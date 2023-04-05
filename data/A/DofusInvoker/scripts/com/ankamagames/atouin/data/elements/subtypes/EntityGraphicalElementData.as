package com.ankamagames.atouin.data.elements.subtypes
{
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.data.elements.GraphicalElementData;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.IDataInput;
   import flash.utils.getQualifiedClassName;
   
   public class EntityGraphicalElementData extends GraphicalElementData
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(EntityGraphicalElementData));
       
      
      public var entityLook:String;
      
      public var horizontalSymmetry:Boolean;
      
      public var playAnimation:Boolean;
      
      public var playAnimStatic:Boolean;
      
      public var minDelay:uint;
      
      public var maxDelay:uint;
      
      public function EntityGraphicalElementData(elementId:int, elementType:int)
      {
         super(elementId,elementType);
      }
      
      override public function fromRaw(raw:IDataInput, version:int) : void
      {
         var entityLookLength:uint = raw.readInt();
         this.entityLook = raw.readUTFBytes(entityLookLength);
         if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
         {
            _log.debug("  (EntityGraphicalElementData) Entity look : " + this.entityLook);
         }
         this.horizontalSymmetry = raw.readBoolean();
         if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
         {
            _log.debug("  (EntityGraphicalElementData) Element horizontals symmetry : " + this.horizontalSymmetry);
         }
         if(version >= 7)
         {
            this.playAnimation = raw.readBoolean();
            if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
               _log.debug("  (EntityGraphicalElementData) playAnimation : " + this.playAnimation);
            }
         }
         if(version >= 6)
         {
            this.playAnimStatic = raw.readBoolean();
            if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
               _log.debug("  (EntityGraphicalElementData) playAnimStatic : " + this.playAnimStatic);
            }
         }
         if(version >= 5)
         {
            this.minDelay = raw.readInt();
            if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
               _log.debug("  (EntityGraphicalElementData) minDelay : " + this.minDelay);
            }
            this.maxDelay = raw.readInt();
            if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
            {
               _log.debug("  (EntityGraphicalElementData) maxDelay : " + this.maxDelay);
            }
         }
      }
   }
}
