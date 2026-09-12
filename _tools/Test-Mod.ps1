$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
function Assert($condition, $message) {
    if (-not $condition) { throw $message }
}

# Exercise the shipped XPath and payloads on synthetic upstream defs. This small
# interpreter covers only the four operations used here; it is not RimWorld.
function Invoke-Patch([xml]$document, [System.Xml.XmlElement]$operation) {
    $nodes = @()
    if ($operation.SelectSingleNode('xpath')) { $nodes = @($document.SelectNodes([string]$operation.xpath)) }
    switch ($operation.GetAttribute('Class')) {
        'PatchOperationConditional' {
            $branch = if ($nodes.Count) { $operation.SelectSingleNode('match') } else { $operation.SelectSingleNode('nomatch') }
            if ($branch) { Invoke-Patch $document $branch }
        }
        'PatchOperationSequence' {
            foreach ($child in $operation.SelectNodes('operations/li')) { Invoke-Patch $document $child }
        }
        'PatchOperationAdd' {
            Assert ($nodes.Count -gt 0) 'Add XPath matched nothing'
            foreach ($node in $nodes) {
                foreach ($child in $operation.SelectNodes('value/*')) {
                    [void]$node.AppendChild($document.ImportNode($child, $true))
                }
            }
        }
        'PatchOperationReplace' {
            Assert ($nodes.Count -gt 0) 'Replace XPath matched nothing'
            foreach ($node in $nodes) {
                [void]$node.ParentNode.ReplaceChild($document.ImportNode($operation.SelectSingleNode('value/*'), $true), $node)
            }
        }
        default { throw "Unsupported patch operation: $($operation.GetAttribute('Class'))" }
    }
}

foreach ($file in Get-ChildItem "$root/Mod" -Recurse -Filter *.xml) {
    [xml]$parsed = Get-Content $file.FullName -Raw
}
[xml]$about = Get-Content "$root/Mod/About/About.xml" -Raw
Assert ($about.ModMetaData.packageId -ceq 'nelim.drumbathhygiene') 'Package ID changed'
Assert ($about.ModMetaData.name -ceq 'Drum Bath Hygiene') 'Unexpected mod title'
Assert ($about.ModMetaData.description.Contains([string]$about.ModMetaData.url)) 'Description must link to source repository'
foreach ($dependency in $about.ModMetaData.modDependencies.li) {
    Assert (@($about.ModMetaData.loadAfter.li) -contains $dependency.packageId) 'Dependency missing from loadAfter'
}
Assert ((Get-Content "$root/LICENSE" -Raw) -ceq (Get-Content "$root/Mod/LICENSE" -Raw)) 'Distributed license differs'
Assert (@(Get-ChildItem "$root/Mod" -Recurse -Filter Assembly-CSharp.dll).Count -eq 0) 'Game assembly must not ship'

[xml]$patch = Get-Content "$root/Mod/Patches/AddComp.xml" -Raw
$cases = 0
foreach ($class in @('', '<hediffClass>Hediff</hediffClass>', '<hediffClass>HediffWithComps</hediffClass>')) {
    foreach ($comps in @('', '<comps/>', '<comps><li Class="ExistingComp"><keep>42</keep></li></comps>')) {
        [xml]$defs = "<Defs><HediffDef><defName>Hed_BathingAtDrumBathPassive</defName>$class$comps<label>Keep me</label></HediffDef><HediffDef><defName>Unrelated</defName></HediffDef></Defs>"
        $other = $defs.Defs.LastChild.OuterXml
        Invoke-Patch $defs $patch.Patch.Operation
        $target = $defs.Defs.FirstChild
        Assert ($target.SelectNodes('hediffClass').Count -eq 1) 'Duplicate class'
        Assert ($target.hediffClass -ceq 'HediffWithComps') 'Wrong hediff class'
        Assert ($target.SelectNodes('comps').Count -eq 1) 'Duplicate comps container'
        $added = $target.SelectNodes('comps/li[@Class="DrumBathHygiene.HediffCompProperties_DrumBathHygiene"]')
        Assert ($added.Count -eq 1) 'Component missing or duplicated'
        Assert ($added[0].cleanPerTick -eq '0.0005') 'Wrong hygiene rate'
        Assert ($added[0].privacyCheckInterval -eq '300') 'Wrong privacy interval'
        Assert ($target.label -ceq 'Keep me') 'Unrelated field changed'
        Assert ($defs.Defs.LastChild.OuterXml -ceq $other) 'Unrelated def changed'
        if ($comps.Contains('ExistingComp')) {
            Assert ($target.SelectSingleNode('comps/li[@Class="ExistingComp"]/keep').InnerText -eq '42') 'Existing component lost'
        }
        $cases++
    }
}
[xml]$absent = '<Defs><HediffDef><defName>Unrelated</defName></HediffDef></Defs>'
$before = $absent.OuterXml
Invoke-Patch $absent $patch.Patch.Operation
Assert ($absent.OuterXml -ceq $before) 'Missing upstream mod must leave defs unchanged'
Write-Host "PASS: metadata, licensing, packaging and $($cases + 1) XML patch cases."

# Read actual assembly metadata without loading RimWorld or executing game code.
$stream = [IO.File]::OpenRead("$root/Mod/Assemblies/DrumBathHygiene.dll")
$pe = [System.Reflection.PortableExecutable.PEReader]::new($stream)
try {
    $metadata = [System.Reflection.Metadata.PEReaderExtensions]::GetMetadataReader($pe)
    $waiver = $false
    foreach ($handle in $metadata.GetAssemblyDefinition().GetCustomAttributes()) {
        $attribute = $metadata.GetCustomAttribute($handle)
        if ($attribute.Constructor.Kind -eq 'MethodDefinition') {
            $method = $metadata.GetMethodDefinition([System.Reflection.Metadata.MethodDefinitionHandle]$attribute.Constructor)
            $type = $metadata.GetTypeDefinition($method.GetDeclaringType())
            if ($metadata.GetString($type.Name) -eq 'IgnoresAccessChecksToAttribute') {
                $blob = $metadata.GetBlobReader($attribute.Value)
                Assert ($blob.ReadUInt16() -eq 1) 'Invalid attribute encoding'
                if ($blob.ReadSerializedString() -eq 'Assembly-CSharp') { $waiver = $true }
            }
        }
    }
    Assert $waiver 'Compiled assembly lacks Assembly-CSharp access waiver'
    $types = @($metadata.TypeDefinitions | ForEach-Object { $metadata.GetString($metadata.GetTypeDefinition($_).Name) })
    Assert ($types -contains 'HediffCompProperties_DrumBathHygiene') 'XML component type missing from assembly'
    Assert ($types -contains 'HediffComp_DrumBathHygiene') 'Runtime component missing from assembly'
    Write-Host 'PASS: compiled component types and Assembly-CSharp access waiver.'
} finally {
    $pe.Dispose()
    $stream.Dispose()
}
