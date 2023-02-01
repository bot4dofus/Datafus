DOFUS=$USERPROFILE/AppData/Local/Ankama/Dofus
DOFUS=$((echo $DOFUS) | sed -r 's/[\]+/\//g')
VERSION=$(python latest-dofus-version.py)
COMMIT_MESSAGE="Update Dofus files for version \"$VERSION\""

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
read -p "Those files will be commited with the following message: $COMMIT_MESSAGE. Press enter to continue. Press Ctrl+C to abort."

git commit -m "$COMMIT_MESSAGE"
git push
read -p "Press enter to continue."
