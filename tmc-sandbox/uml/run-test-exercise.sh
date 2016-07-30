#!/bin/sh

rm -Rf tmp
mkdir -p tmp
tar -C test/data/test-exercise -cf tmp/test-exercise.tar . || exit 1

MAX_OUTPUT_SIZE=20M
dd if=/dev/zero of=tmp/output.tar bs=$MAX_OUTPUT_SIZE count=1

output/linux.uml \
  initrd=output/initrd.img \
  ubdarc=output/rootfs.squashfs \
  ubdbr=tmp/test-exercise.tar \
  ubdc=tmp/output.tar \
  mem=96M

tar -C tmp -xf tmp/output.tar
cat tmp/{exit_code.txt,stderr.txt,stdout.txt,test_output.txt,valgrind.log,validations.json}
exit $(cat tmp/exit_code.txt)

