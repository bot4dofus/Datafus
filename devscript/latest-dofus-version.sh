xml_title=$(curl -s https://www.dofus.com/fr/rss/changelog.xml | grep "title" | grep -v "Changelog" -m 1)
title=$(echo ${xml_title#*'<title><![CDATA['} | cut -d']' -f 1)

if [[ $fullstring == *"$substr"* ]]; then
	IFS=' ' read -a version_array <<< $title
	version=$(echo "${version_array[-1]}")
else
	version=title
fi

echo $version
