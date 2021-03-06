#!/bin/sh
# tests for JPEG/PNG/PPM -> JPEG -> JPEG chain

SJPEG=../examples/sjpeg
TMP_JPEG1=/tmp/test1.jpg
TMP_JPEG2=/tmp/test2.jpg

LIST="source1.png \
      source1.itl.png \
      source2.jpg \
      source3.jpg \
      source4.ppm \
      test_icc.jpg \
      test_exif_xmp.png"

set -e
for f in ${LIST}; do
  ${SJPEG} testdata/${f} -o ${TMP_JPEG2} -info
done

for f in ${LIST}; do
  ${SJPEG} testdata/${f} -o ${TMP_JPEG1} -quiet
  ${SJPEG} ${TMP_JPEG1} -o ${TMP_JPEG2} -r 90 -short -info
done

for f in ${LIST}; do
  ${SJPEG} testdata/${f} -o ${TMP_JPEG1} -quiet -no_metadata -q 30
  ${SJPEG} ${TMP_JPEG1} -r 90 -o ${TMP_JPEG2} -short -info
done

echo "OK!"
exit 0
