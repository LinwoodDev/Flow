#!/bin/bash

# Default values for architecture
DIRECTORY_ARCH="x64"  # Default directory name
BINARY_ARCH="x86_64"  # Default binary name
RPM_ARCH="x86_64"     # Default RPM architecture

# Parse command-line arguments
while getopts "d:b:" opt; do
  case $opt in
    d) DIRECTORY_ARCH="$OPTARG" ;;  # Set the directory architecture
    b) BINARY_ARCH="$OPTARG" ;;    # Set the binary architecture
    *) 
      echo "Usage: $0 [-d directory_arch] [-b binary_arch]"
      exit 1
      ;;
  esac
done
RPM_ARCH=$BINARY_ARCH

# Normalize architecture names for RPM
if [ "$RPM_ARCH" == "arm64" ]; then
  RPM_ARCH="aarch64"
fi
# Read version from pubspec
FLOW_VERSION_REGEX="version:\s(.+)\+(.+)"
[[ $(grep -E "${FLOW_VERSION_REGEX}" pubspec.yaml) =~ ${FLOW_VERSION_REGEX} ]]
FLOW_VERSION="${BASH_REMATCH[1]}"

# Replace - with ~ to match RPM versioning
RPM_VERSION=$(echo $FLOW_VERSION | sed 's/-/~/g')
CURRENT_DIR=$(pwd)
echo "Building Flow $RPM_VERSION for $DIRECTORY_ARCH/$BINARY_ARCH ($RPM_ARCH)"

# Clean and set up build directories
rm -rf build/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
mkdir -p build/{BUILD,RPMS,SOURCES,SPECS,SRPMS}

# Copy files
cp linux/rpm/linwood-flow.spec build/SPECS/linwood-flow.spec
cp -r build/linux/${DIRECTORY_ARCH}/release/bundle build/SOURCES/linwood-flow-$RPM_VERSION
chmod 755 build/SOURCES/linwood-flow-$RPM_VERSION/flow
mv build/SOURCES/linwood-flow-$RPM_VERSION/flow build/SOURCES/linwood-flow-$RPM_VERSION/linwood-flow
cp linux/rpm/linwood-flow.desktop build/SOURCES/linwood-flow-$RPM_VERSION/linwood-flow.desktop

# Update .spec file with the correct version
sed -i "2s/.*/Version: $RPM_VERSION/" build/SPECS/linwood-flow.spec

# Create tarball
cd build/SOURCES/
# Fix .so files using patchelf
cd linwood-flow-$RPM_VERSION/lib
for file in *.so; do
  PATCHELF_OUTPUT=$(patchelf --print-rpath "$file")
  echo "Checking $file: $PATCHELF_OUTPUT"
  # Skip file if PATCHELF_OUTPUT does not contain CURRENT_DIR
  if [[ ! $PATCHELF_OUTPUT =~ $CURRENT_DIR ]]; then
    echo "Skipping $file"
    continue
  fi
  echo "Fixing $file"
  patchelf --set-rpath '$ORIGIN' "$file"
done
cd ../../
tar --create --file linwood-flow-$RPM_VERSION.tar.gz linwood-flow-$RPM_VERSION
cd ../../

# Build RPM
QA_RPATHS=$[ 0x0001|0x0010 ] rpmbuild -bb build/SPECS/linwood-flow.spec --define "_topdir $(pwd)/build"

# Copy the RPM to the build folder
cp build/RPMS/${RPM_ARCH}/linwood-flow-*.rpm build/linwood-flow-linux-${BINARY_ARCH}.rpm
