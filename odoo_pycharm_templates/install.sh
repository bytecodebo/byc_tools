#!/bin/bash

# Create folder
TEMPLATE_FOLDER="${PYCHARM_TEMPLATES_FOLDER}"
echo """$TEMPLATE_FOLDER"""
# shellcheck disable=SC2054
# eval """open $TEMPLATE_FOLDER"""
if [ ! -d "${TEMPLATE_FOLDER}" ]; then
  echo " *** Invalid path ***"
  echo "${TEMPLATE_FOLDER}"
  exit 1
fi
EXPORT_FILES=('OdooBaseXml.xml' 'OdooXml.xml' 'OdooPython.xml' 'other.xml')
for f_names in "${EXPORT_FILES[@]}" ; do
    echo "select file.... $f_names"
    # shellcheck disable=SC2027
    FULL_PATH="${TEMPLATE_FOLDER}""/$f_names"
    # eval """cp -p $f_names ""${TEMPLATE_FOLDER}""/$f_names"""
    cp -p "$f_names" "$FULL_PATH"
done

echo ""
echo ""
echo """Success... files had been created/updated"""
echo "Now you have to restart pycharm"
echo ""