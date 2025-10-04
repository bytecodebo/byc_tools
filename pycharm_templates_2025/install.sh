#!/bin/bash

# You can use an environment variable or change for path folder
TEMPLATE_FOLDER="${PYCHARM_TEMPLATES_FOLDER}"
echo """$TEMPLATE_FOLDER"""
if [ ! -d "${TEMPLATE_FOLDER}" ]; then
  echo " *** Invalid path ***"
  echo "${TEMPLATE_FOLDER}"
  exit 1
fi
# shellcheck disable=SC2054
# eval """open $TEMPLATE_FOLDER"""
EXPORT_FILES=('BaseAngularScripts.xml' 'BaseBashScripts.xml' 'BaseJavaScripts.xml' 'BaseOtherScripts.xml' 'BasePythonScripts.xml' 'BaseShellScripts.xml' 'BaseSQLScripts.xml')
for f_names in "${EXPORT_FILES[@]}" ; do
    echo "select file.... $f_names"
    FULL_PATH="${TEMPLATE_FOLDER}""/$f_names"
    # eval """cp -p $f_names ${TEMPLATE_FOLDER}/$f_names"""
    cp -p "$f_names" "$FULL_PATH"
done

echo ""
echo ""
echo """Success... files had been created/updated"""
echo "Now you have to restart pycharm"
echo ""