#!/bin/bash

# Create folder
TEMPLATE_FOLDER="${PYCHARM_TEMPLATES_FOLDER}"
# shellcheck disable=SC2054
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