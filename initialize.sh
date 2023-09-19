#!/bin/bash
LLVM_RELEASE="$(cat llvm-release.txt)"
LLVM_RELEASE_RC="$(cat llvm-rc.txt)"

if [ -z "$LLVM_RELEASE_RC" ]; then
  LLVM_RELEASE_RC=""
else
  LLVM_RELEASE_RC="-rc$LLVM_RELEASE_RC"
fi

LLVM_TARBALL_FILENAME=llvm-project-"$LLVM_RELEASE""${LLVM_RELEASE_RC//-}".src
[ ! -f llvm-project-"$LLVM_TARBALL_FILENAME".tar.xz ] && curl -O -L https://github.com/llvm/llvm-project/releases/download/llvmorg-"$LLVM_RELEASE""$LLVM_RELEASE_RC"/"$LLVM_TARBALL_FILENAME".tar.xz
[ "$(shasum -a 512 "$LLVM_TARBALL_FILENAME".tar.xz)" != "$(cat checksum.txt)" ] && exit 1
mkdir final
tar -xf "$LLVM_TARBALL_FILENAME".tar.xz
mv "$LLVM_TARBALL_FILENAME" final/llvm-project
