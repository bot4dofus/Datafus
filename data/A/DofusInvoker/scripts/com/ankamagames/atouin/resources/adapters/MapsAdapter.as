package com.ankamagames.atouin.resources.adapters
{
   import com.ankamagames.atouin.resources.AtouinResourceType;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   import com.ankamagames.jerakine.resources.adapters.AbstractUrlLoaderAdapter;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import flash.errors.IOError;
   import flash.net.URLLoaderDataFormat;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class MapsAdapter extends AbstractUrlLoaderAdapter implements IAdapter
   {
       
      
      public function MapsAdapter()
      {
         super();
      }
      
      override protected function getResource(dataFormat:String, data:*) : *
      {
         var ba:ByteArray = data as ByteArray;
         ba.endian = Endian.BIG_ENDIAN;
         var header:int = ba.readByte();
         if(header != 77)
         {
            ba.position = 0;
            try
            {
               ba.uncompress();
            }
            catch(ioe:IOError)
            {
               dispatchFailure("Wrong header and non-compressed file.",ResourceErrorCode.MALFORMED_MAP_FILE);
               return null;
            }
            header = ba.readByte();
            if(header != 77)
            {
               dispatchFailure("Wrong header file.",ResourceErrorCode.MALFORMED_MAP_FILE);
               return null;
            }
         }
         ba.position = 0;
         return ba;
      }
      
      override public function getResourceType() : uint
      {
         return AtouinResourceType.RESOURCE_MAP;
      }
      
      override protected function getDataFormat() : String
      {
         return URLLoaderDataFormat.BINARY;
      }
   }
}
