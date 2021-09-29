package by.blooddy.crypto.image
{
   import flash.utils.ByteArray;
   import flash.utils.getQualifiedClassName;
   
   [ExcludeClass]
   public final class JPEGTable
   {
      
      private static const _quantTables:Array = new Array();
      
      private static var _jpegTable:ByteArray;
       
      
      public function JPEGTable()
      {
         super();
         Error.throwError(ArgumentError,2012,getQualifiedClassName(this));
      }
      
      public static function getTable(quality:uint = 60) : ByteArray
      {
         if(quality > 100)
         {
            Error.throwError(RangeError,2006,"quality");
         }
         if(quality < 1)
         {
            quality = 1;
         }
         var quantTable:ByteArray = _quantTables[quality];
         if(!quantTable)
         {
            quantTable = JPEGTableHelper.createQuantTable(quality);
            if(!_jpegTable)
            {
               _jpegTable = new ByteArray();
               _jpegTable.writeBytes(JPEGTableHelper.createZigZagTable());
               _jpegTable.writeBytes(JPEGTableHelper.createHuffmanTable());
               _jpegTable.writeBytes(JPEGTableHelper.createCategoryTable());
            }
         }
         var result:ByteArray = new ByteArray();
         result.writeBytes(quantTable);
         result.writeBytes(_jpegTable);
         result.position = 0;
         return result;
      }
   }
}
