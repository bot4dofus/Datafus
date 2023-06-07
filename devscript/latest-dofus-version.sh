xml_title=$(curl -s https://www.dofus.com/fr/rss/changelog.xml | grep "title" | grep -v "Changelog" -m 1)
title=$(echo ${xml_title#*'<title><![CDATA['} | cut -d']' -f 1)
echo $title
