package com.ankamagames.jerakine.resources.adapters.impl
{
   import by.blooddy.crypto.serialization.JSON;
   import com.ankamagames.jerakine.resources.ResourceType;
   import com.ankamagames.jerakine.resources.adapters.AbstractUrlLoaderAdapter;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import flash.net.URLLoaderDataFormat;
   
   public class JSONAdapter extends AbstractUrlLoaderAdapter implements IAdapter
   {
       
      
      public function JSONAdapter()
      {
         super();
      }
      
      override protected function getResource(dataFormat:String, data:*) : *
      {
         var jsonData:* = undefined;
         try
         {
            jsonData = by.blooddy.crypto.serialization.JSON.decode(data);
         }
         catch(error:Error)
         {
            _log.error(error.message);
         }
         if(!jsonData)
         {
            jsonData = {};
         }
         return jsonData;
      }
      
      override public function getResourceType() : uint
      {
         return ResourceType.RESOURCE_JSON;
      }
      
      override protected function getDataFormat() : String
      {
         return URLLoaderDataFormat.TEXT;
      }
   }
}
