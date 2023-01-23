DOFUS=$USERPROFILE/AppData/Local/Ankama/Dofus
DOFUS=$((echo $DOFUS) | sed -r 's/[\]+/\//g')
VERSION=$(bash latest-dofus-version.sh)

git pull

echo "Removing .d2o files..."
rm ../data/d2o/*

echo "Removing .d2i files..."
rm ../data/d2i/*

echo "Removing DofusInvoker.swf file..."
rm ../data/DofusInvoker.swf

echo "Copying .d2o files..."
cp $DOFUS/data/common/*.d2o ../data/d2o/

echo "Copying .d2i files..."
cp $DOFUS/data/i18n/*.d2i ../data/d2i/

echo "Copying DofusInvoker.swf file..."
cp $DOFUS/DofusInvoker.swf ../data/DofusInvoker.swf

git add ../data/
git status
read -p "The following files will be commited. Press enter to continue. Press Ctrl+C to abort."

git commit -m "Update Dofus files for version \"$VERSION\""
git push
read -p "Press enter to continue."
