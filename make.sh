#!/usr/bin/env sh

dir_name=${PWD##*/}
file_name=`basename "$0"`

if [ -e "./plugin.xml" ]
then
    echo "Cleaning up old Zip files";
    rm ./*.zip 2>&1

    echo "Zipping up the files into an installable plugin";
    zip -r $dir_name ./* -x $file_name -x .git* -x README.md -q

    echo "Done!";
    echo "Upload and install the plugin named $dir_name.zip";
else
    echo "plugin.xml does not exist. Creating a plugin skeleton";
    mkdir {web_root,permissions_root,queries_root,user_schema_root}
    echo "*.zip" >> .gitignore;
    echo "<?xml version=\"1.0\" encoding=\"UTF-8\"?>
<plugin xmlns=\"http://plugin.powerschool.pearson.com\"
        xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\"
        xsi:schemaLocation=\"http://plugin.powerschool.pearson.com plugin.xsd\"
        name=\"Title\"
        version=\"1.0\"
        description=\"\">
  <autoinstall required=\"true\">
    <autoenable required=\"true\" />
    <autoredeploy />
  </autoinstall>
  <publisher name=\"\">
    <contact email=\"\" />
  </publisher>
</plugin>" >> plugin.xml;
fi
