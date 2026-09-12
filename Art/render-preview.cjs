// Run with Node.js, playwright and sharp available (NODE_PATH may point to the bundled runtime).
const fs=require('fs'),path=require('path'),http=require('http');
const {chromium}=require('playwright'),sharp=require('sharp');
const root=path.resolve(__dirname,'..');
const palette=JSON.parse(fs.readFileSync(path.join(__dirname,'preview-palette.json')));
function luminance(rgb){const c=rgb.map(x=>{x/=255;return x<=.04045?x/12.92:((x+.055)/1.055)**2.4});return .2126*c[0]+.7152*c[1]+.0722*c[2]}
function contrast(a,b){const x=luminance(a),y=luminance(b);return (Math.max(x,y)+.05)/(Math.min(x,y)+.05)}
const rgb=hex=>hex.match(/\w\w/g).map(x=>parseInt(x,16));
(async()=>{
 const server=http.createServer((req,res)=>{const file=path.resolve(root,'.'+decodeURIComponent(req.url.split('?')[0]));if(!file.startsWith(root+path.sep)){res.writeHead(403).end();return}fs.readFile(file,(err,data)=>{if(err){res.writeHead(404).end();return}res.setHeader('Content-Type',file.endsWith('.html')?'text/html':file.endsWith('.json')?'application/json':file.endsWith('.xml')?'application/xml':'image/png');res.end(data)})});
 await new Promise(r=>server.listen(0,'127.0.0.1',r));
 let browser;
 try {
 browser=await chromium.launch({executablePath:'C:/Program Files/Google/Chrome/Application/chrome.exe',headless:true});
 const page=await browser.newPage({viewport:{width:896,height:504},deviceScaleFactor:1});
 await page.goto(`http://127.0.0.1:${server.address().port}/Art/preview.html`);await page.evaluate(()=>window.previewReady);
 const cdp=await page.context().newCDPSession(page);await cdp.send('DOM.enable');await cdp.send('CSS.enable');
 const doc=await cdp.send('DOM.getDocument');const fonts={};
 for(const selector of ['h1','p','.version']){const {nodeId}=await cdp.send('DOM.querySelector',{nodeId:doc.root.nodeId,selector});fonts[selector]=(await cdp.send('CSS.getPlatformFontsForNode',{nodeId})).fonts}
 const boxes={};for(const s of ['h1','p','.version'])boxes[s]=await page.locator(s).boundingBox();
 for(const b of Object.values(boxes))if(b.x<0||b.y<0||b.x+b.width>896||b.y+b.height>504)throw Error('Text out of bounds');
 const output=path.join(root,'Mod/About/Preview.png');await page.screenshot({path:output});
 await sharp(output).resize(268).png().toFile(path.join(__dirname,'preview-268.png'));
 await page.addStyleTag({content:'.copy,.version { visibility:hidden }'});
 const background=await page.screenshot({path:path.join(__dirname,'preview-background.png')});
 const {data,info}=await sharp(background).removeAlpha().raw().toBuffer({resolveWithObject:true});
 const ratios={};
 for(const selector of ['h1','p']){let min=Infinity;const b=boxes[selector];for(let y=Math.floor(b.y);y<Math.ceil(b.y+b.height);y++)for(let x=Math.floor(b.x);x<Math.ceil(b.x+b.width);x++){const i=(y*info.width+x)*info.channels;min=Math.min(min,contrast(rgb(palette.inkPrimary),[data[i],data[i+1],data[i+2]]))}ratios[selector]=min}
 ratios.badge=contrast(rgb(palette.badgeInk),rgb(palette.accent));
 const report={dimensions:[896,504],bytes:fs.statSync(output).size,fonts,boxes,minimumContrastOverFullTextRectangles:ratios,tag:'Not applicable: public original mod; no prefix/suffix/linking words',version:await page.locator('.version').textContent()};
 fs.writeFileSync(path.join(__dirname,'preview-qa.json'),JSON.stringify(report,null,2)+'\n');
 console.log(JSON.stringify(report,null,2));
 if(Object.values(ratios).some(x=>x<4.5))throw Error('Contrast below 4.5');
 if(report.bytes>=900000)throw Error('Preview too large');
 if(Object.values(fonts).some(list=>list.some(f=>!['Segoe UI','Segoe UI Semibold'].includes(f.familyName))))throw Error('Unexpected font fallback');
 }finally{if(browser)await browser.close();server.close()}
})().catch(e=>{console.error(e);process.exitCode=1});
