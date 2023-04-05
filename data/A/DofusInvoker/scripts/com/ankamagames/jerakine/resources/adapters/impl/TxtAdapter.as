package com.ankamagames.jerakine.resources.adapters.impl
{
   import com.ankamagames.jerakine.resources.ResourceType;
   import com.ankamagames.jerakine.resources.adapters.AbstractUrlLoaderAdapter;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import flash.utils.IDataInput;
   
   public class TxtAdapter extends AbstractUrlLoaderAdapter implements IAdapter
   {
       
      
      public function TxtAdapter()
      {
         super();
      }
      
      override protected function getResource(dataFormat:String, data:*) : *
      {
         if(dataFormat == ResourceType.getName(ResourceType.RESOURCE_BINARY) && data is IDataInput)
         {
            return IDataInput(data).readUTFBytes(IDataInput(data).bytesAvailable);
         }
         return data as String;
      }
      
      override public function getResourceType() : uint
      {
         return ResourceType.RESOURCE_TXT;
      }
   }
}
