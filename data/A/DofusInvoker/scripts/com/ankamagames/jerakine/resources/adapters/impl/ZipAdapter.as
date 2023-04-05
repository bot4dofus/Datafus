package com.ankamagames.jerakine.resources.adapters.impl
{
   import com.ankamagames.jerakine.resources.ResourceType;
   import com.ankamagames.jerakine.resources.adapters.AbstractUrlLoaderAdapter;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import flash.net.URLLoaderDataFormat;
   import flash.utils.ByteArray;
   import nochump.util.zip.ZipFile;
   
   public class ZipAdapter extends AbstractUrlLoaderAdapter implements IAdapter
   {
       
      
      public function ZipAdapter()
      {
         super();
      }
      
      override protected function getResource(dataFormat:String, data:*) : *
      {
         return new ZipFile(data as ByteArray);
      }
      
      override public function getResourceType() : uint
      {
         return ResourceType.RESOURCE_ZIP;
      }
      
      override protected function getDataFormat() : String
      {
         return URLLoaderDataFormat.BINARY;
      }
   }
}
