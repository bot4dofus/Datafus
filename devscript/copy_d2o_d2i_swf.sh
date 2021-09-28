DOFUS=$USERPROFILE/AppData/Local/Ankama/Dofus
DOFUS=$((echo $DOFUS) | sed -r 's/[\]+/\//g')

rm ../data/d2o/*
rm ../data/d2i/*
rm ../data/DofusInvoker.swf
cp $DOFUS/data/common/*.d2o ../data/d2o/
cp $DOFUS/data/i18n/*.d2i ../data/d2i/
cp $DOFUS/DofusInvoker.swf ../data/DofusInvoker.swf

git add ../data/
git commit -m "Update files"
git push
