#!/bin/bash

# You can use an environment variable or change for path folder
TEMPLATE_FOLDER="${PYCHARM_TEMPLATES_FOLDER}"
echo """$TEMPLATE_FOLDER"""
# shellcheck disable=SC2054
# eval """open $TEMPLATE_FOLDER"""
EXPORT_FILES=('OdooBaseXml.xml' 'OdooXml.xml' 'OdooPython.xml')
for f_names in "${EXPORT_FILES[@]}" ; do
    echo "select file.... $f_names"
    eval """cp -p $f_names ${TEMPLATE_FOLDER}/$f_names"""
done

echo ""
echo ""
echo """Success... files had been created/updated"""
echo "Now you have to restart pycharm"
echo ""