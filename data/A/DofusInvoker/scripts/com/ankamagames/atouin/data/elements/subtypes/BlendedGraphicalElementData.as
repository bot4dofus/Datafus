package com.ankamagames.atouin.data.elements.subtypes
{
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.IDataInput;
   import flash.utils.getQualifiedClassName;
   
   public class BlendedGraphicalElementData extends NormalGraphicalElementData
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(NormalGraphicalElementData));
       
      
      public var blendMode:String;
      
      public function BlendedGraphicalElementData(elementId:int, elementType:int)
      {
         super(elementId,elementType);
      }
      
      override public function fromRaw(raw:IDataInput, version:int) : void
      {
         super.fromRaw(raw,version);
         var blendModeLength:uint = raw.readInt();
         this.blendMode = raw.readUTFBytes(blendModeLength);
         if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
         {
            _log.debug("  (BlendedGraphicalElementData) BlendMode : " + this.blendMode);
         }
      }
   }
}
