const fs = require('fs');

let rawdata = fs.readFileSync('lights.json');
let lightSeq = JSON.parse(rawdata);
//console.log(lightSeq);

let cld = [];

for (let i = 0; i < lightSeq.length; i++) {
    const ls = lightSeq[i];
    const frame = {};

    for (const lsKey of Object.keys(ls)) {
        //find previous value
        cld.reverse();
        const lastValue = cld.find(o =>{
            o[lsKey]!=null
        });
        cld.reverse();

        if(ls[lsKey] == 1 && !lastValue)
        {
            frame[lsKey] = 1
        }
        else if(lastValue && ls[lsKey] != lastValue){
            frame[lsKey] = ls[lsKey]
        }
    }

    if(Object.keys(frame).length > 0)
        cld.push(frame);
}

console.log(JSON.stringify(cld));