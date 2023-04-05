package com.ankamagames.atouin.resources.adapters
{
   import com.ankamagames.atouin.data.map.TacticalModeTemplate;
   import com.ankamagames.atouin.resources.AtouinResourceType;
   import com.ankamagames.jerakine.resources.ResourceErrorCode;
   import com.ankamagames.jerakine.resources.adapters.AbstractUrlLoaderAdapter;
   import com.ankamagames.jerakine.resources.adapters.IAdapter;
   import flash.errors.IOError;
   import flash.net.URLLoaderDataFormat;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   
   public class TacticalTemplatesAdapter extends AbstractUrlLoaderAdapter implements IAdapter
   {
       
      
      public function TacticalTemplatesAdapter()
      {
         super();
      }
      
      override protected function getResource(dataFormat:String, data:*) : *
      {
         var template:TacticalModeTemplate = null;
         var templates:Dictionary = new Dictionary();
         var ba:ByteArray = data as ByteArray;
         var header:int = ba.readByte();
         if(header != 84)
         {
            ba.position = 0;
            try
            {
               ba.uncompress();
            }
            catch(ioe:IOError)
            {
               dispatchFailure(ioe.message,ResourceErrorCode.MALFORMED_MAP_FILE);
               return null;
            }
            header = ba.readByte();
            if(header != 84)
            {
               dispatchFailure("Wrong header file.",ResourceErrorCode.MALFORMED_MAP_FILE);
               return null;
            }
         }
         var version:int = ba.readByte();
         var numTemplates:uint = ba.readInt();
         for(var i:int = 0; i < numTemplates; i++)
         {
            template = new TacticalModeTemplate();
            template.fromRaw(ba);
            templates[template.id] = template;
         }
         return templates;
      }
      
      override public function getResourceType() : uint
      {
         return AtouinResourceType.TACTICAL_TEMPLATES;
      }
      
      override protected function getDataFormat() : String
      {
         return URLLoaderDataFormat.BINARY;
      }
   }
}
