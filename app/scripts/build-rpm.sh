# Read version from pubspec
FLOW_VERSION_REGEX="version:\s(.+)\+(.+)"
[[ $(grep -E "${FLOW_VERSION_REGEX}" pubspec.yaml) =~ ${FLOW_VERSION_REGEX} ]]
FLOW_VERSION="${BASH_REMATCH[1]}"
# Replace - with ~ to match RPM versioning
RPM_VERSION=$(echo $FLOW_VERSION | sed 's/-/~/g')
CURRENT_DIR=$(pwd)
echo "Building Flow $RPM_VERSION"
rm -rf build/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
mkdir -p build/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
# Copy files
cp linux/rpm/linwood-flow.spec build/SPECS/linwood-flow.spec
cp -r build/linux/x64/release/bundle build/SOURCES/linwood-flow-$RPM_VERSION
chmod 755 build/SOURCES/linwood-flow-$RPM_VERSION/flow
mv build/SOURCES/linwood-flow-$RPM_VERSION/flow build/SOURCES/linwood-flow-$RPM_VERSION/linwood-flow
cp linux/rpm/linwood-flow.desktop build/SOURCES/linwood-flow-$RPM_VERSION/linwood-flow.desktop
# Change second line of spec file Version: to match version
sed -i "2s/.*/Version: $RPM_VERSION/" build/SPECS/linwood-flow.spec
# Create tar
cd build/SOURCES/
# Fix .so files using patchelf
cd linwood-flow-$RPM_VERSION/lib
for file in *.so; do
  PATCHELF_OUTPUT=$(patchelf --print-rpath $file)
  echo "Checking $file: $PATCHELF_OUTPUT"
  # Skip file if PATCHELF_OUTPUT does not contain CURRENT_DIR
  if [[ ! $PATCHELF_OUTPUT =~ $CURRENT_DIR ]]; then
    echo "Skipping $file"
    continue
  fi
  echo "Fixing $file"
  patchelf --set-rpath '$ORIGIN' $file
done
cd ../../
tar --create --file linwood-flow-$RPM_VERSION.tar.gz linwood-flow-$RPM_VERSION
cd ../../
# Build RPM
QA_RPATHS=$[ 0x0001|0x0010 ] rpmbuild -bb build/SPECS/linwood-flow.spec --define "_topdir $(pwd)/build"
# Copy RPM to build folder
cp build/RPMS/x86_64/linwood-flow-*.rpm build/linwood-flow-linux.rpm