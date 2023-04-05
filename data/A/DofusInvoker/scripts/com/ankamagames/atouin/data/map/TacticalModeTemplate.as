package com.ankamagames.atouin.data.map
{
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.IDataInput;
   import flash.utils.getQualifiedClassName;
   
   public class TacticalModeTemplate
   {
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(TacticalModeTemplate));
       
      
      public var id:int;
      
      public var backgroundColor:int;
      
      public var groundCells:Vector.<TacticalModeCell>;
      
      public var lineOfSightCells:Vector.<TacticalModeCell>;
      
      public function TacticalModeTemplate()
      {
         super();
      }
      
      public function fromRaw(raw:IDataInput) : void
      {
         var i:int = 0;
         var cell:TacticalModeCell = null;
         var numGroundCells:uint = 0;
         var numLineOfSightCells:uint = 0;
         try
         {
            this.id = raw.readShort();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("  (TacticalModeTemplate) id : " + this.id);
            }
            this.backgroundColor = raw.readInt();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("  (TacticalModeTemplate) backgroundColor : " + this.backgroundColor);
            }
            numGroundCells = raw.readByte();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("  (TacticalModeTemplate) numGroundCells : " + numGroundCells);
            }
            this.groundCells = new Vector.<TacticalModeCell>(0);
            for(i = 0; i < numGroundCells; i++)
            {
               cell = new TacticalModeCell();
               cell.fromRaw(raw,11);
               this.groundCells.push(cell);
            }
            numLineOfSightCells = raw.readByte();
            if(AtouinConstants.DEBUG_FILES_PARSING)
            {
               _log.debug("  (TacticalModeTemplate) numLineOfSightCells : " + numLineOfSightCells);
            }
            this.lineOfSightCells = new Vector.<TacticalModeCell>(0);
            for(i = 0; i < numLineOfSightCells; i++)
            {
               cell = new TacticalModeCell();
               cell.fromRaw(raw,11);
               this.lineOfSightCells.push(cell);
            }
         }
         catch(e:*)
         {
            throw e;
         }
      }
   }
}
