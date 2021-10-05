rm -rf $2
wget https://github.com/jindrapetrik/jpexs-decompiler/releases/download/version14.4.0/ffdec_14.4.0.zip
unzip ffdec_14.4.0.zip -d ffdec/
rm ffdec_14.4.0.zip
java -Xmx7168m -Djna.nosys=true -Dsun.java2d.uiScale=1.0 -jar "ffdec/ffdec.jar" -timeout 1200 -exportTimeout 21600 -exportFileTimeout 1200 -export all $2 $1
rm -rf ffdec/