package com.ankamagames.atouin.data.elements.subtypes
{
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.data.elements.GraphicalElementData;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.IDataInput;
   import flash.utils.getQualifiedClassName;
   
   public class ParticlesGraphicalElementData extends GraphicalElementData
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ParticlesGraphicalElementData));
       
      
      public var scriptId:int;
      
      public function ParticlesGraphicalElementData(elementId:int, elementType:int)
      {
         super(elementId,elementType);
      }
      
      override public function fromRaw(raw:IDataInput, version:int) : void
      {
         this.scriptId = raw.readShort();
         if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
         {
            _log.debug("  (ParticlesGraphicalElementData) Script id : " + this.scriptId);
         }
      }
   }
}
