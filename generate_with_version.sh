#!/bin/bash
MODULENAME=dsp
VERSION="0.1.0"
CWD=`pwd`
PUBLISHDIR=${CWD}/publish
URL="https:\/\/github.com\/corbanbrook\/dsp.js"
REPONAME=$MODULENAME
bower install dsp.js
echo $VERSION
cp bower_components/$MODULENAME.js/$MODULENAME.js $CWD
cat<<EOF >> $MODULENAME.js
exports.DFT = DFT;
exports.FFT = FFT;
exports.Oscillator = Oscillator;
exports.ADSR = ADSR;
exports.IIRFilter = IIRFilter;
exports.IIRFilter2 = IIRFilter2;
exports.MultiDelay = MultiDelay;
exports.Reverb = Reverb;
EOF

for var in README.md kanso.json
do
  sed -e s/@VERSION@/$VERSION/g \
      -e s/@MODULENAME@/$MODULENAME/g \
      -e s/@URL@/$URL/g \
             $var.in > $var 
done

rm -rf ${PUBLISHDIR}
mkdir ${PUBLISHDIR} 
cp README.md kanso.json $MODULENAME.js $PUBLISHDIR/
cd ${PUBLISHDIR}
kanso publish
cd ${CWD} 
rm -rf bower_components
rm -rf ${PUBLISHDIR} 

