package com.ankamagames.jerakine.resources.adapters.impl
{
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   import com.ankamagames.jerakine.resources.ResourceType;
   import com.ankamagames.jerakine.resources.adapters.AbstractUrlLoaderAdapter;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   
   public class XmlAdapter extends AbstractUrlLoaderAdapter implements IAdapter
   {
       
      
      public function XmlAdapter()
      {
         super();
      }
      
      override protected function getResource(dataFormat:String, data:*) : *
      {
         var str:String = null;
         var xml:XML = null;
         try
         {
            str = data.toString();
            xml = new XML(data);
         }
         catch(te:TypeError)
         {
            this.dispatchFailure(te.message,ResourceErrorCode.XML_MALFORMED_FILE);
         }
         return xml;
      }
      
      override public function getResourceType() : uint
      {
         return ResourceType.RESOURCE_XML;
      }
   }
}
