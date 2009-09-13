#!/bin/sh

if [ "${NAME}" = "" ]; then
	echo "error: Invalid \${NAME}"
	exit 1
fi

# Should define FLAVOR=3_0 or a compatible OS version

OUTPUT_DIR=${BUILD_DIR}/Combined${BUILD_STYLE}${FLAVOR}
OUTPUT_FILE=lib${NAME}${FLAVOR}.a
ZIP_DIR=${BUILD_DIR}/Zip

if [ ! -d ${OUTPUT_DIR} ]; then
	mkdir ${OUTPUT_DIR}
fi

# Combine lib files
lipo -create "${BUILD_DIR}/${BUILD_STYLE}-iphoneos/lib${NAME}Device${FLAVOR}.a" "${BUILD_DIR}/${BUILD_STYLE}-iphonesimulator/lib${NAME}Simulator${FLAVOR}.a" -output ${OUTPUT_DIR}/${OUTPUT_FILE}

# Copy to direcory for zipping 
mkdir ${ZIP_DIR}
cp ${OUTPUT_DIR}/${OUTPUT_FILE} ${ZIP_DIR}
cp ${BUILD_DIR}/${BUILD_STYLE}-iphonesimulator/*.h ${ZIP_DIR}

cd ${ZIP_DIR}
zip -m lib${NAME}${FLAVOR}-${GHUNIT_VERSION}.zip *
mv lib${NAME}${FLAVOR}-${GHUNIT_VERSION}.zip ..
rm -rf ${ZIP_DIR}
