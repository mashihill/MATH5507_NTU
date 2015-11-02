#! /bin/sh
echo Deploying ....
HOST='ceiba.ntu.edu.tw'
USER=$1
PASSWD=$2
TARGET=$3
FILE='hw.html'
sed -i '' "s/\(Last updated\).*</Last updated: $(date '+%Y-%m-%d %H:%M')</g" $FILE
# Start of ftp command
ftp -n $HOST > /tmp/ftp.worked 2> /tmp/ftp.failed <<END_SCRIPT
user $USER $PASSWD
cd hw_html
put $FILE $TARGET
get $FILE retrieval.$$
bye
END_SCRIPT
# End of ftp command

if [ -f retrieval.$$ ]
then
    echo "FTP of $FILE to $HOST worked"
    rm -f retrieval.$$
    read -p "Open browser? (y/n): " yn
    if [[ "${yn}" == "y" ]]; then
        if [ "${TARGET}" == "hw.html" ]; then
            open https://ceiba.ntu.edu.tw/course/eaa7a7/hw_html/hw.html
        else
            open https://ceiba.ntu.edu.tw/course/eaa7a7/hw_html/dev.html
        fi
    fi
else
    echo "FTP of $FILE did not work"
fi
