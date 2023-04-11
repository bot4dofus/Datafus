package com.ankamagames.atouin.data.map
{
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.data.map.elements.BasicElement;
   import com.ankamagames.atouin.data.map.elements.GraphicalElement;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
   import flash.utils.IDataInput;
   
   public class TacticalModeCell extends Cell
   {
       
      
      public function TacticalModeCell(layer:Layer = null)
      {
         FpsManager.getInstance().watchObject(this,false,"TacticalModeCell");
         super(layer);
      }
      
      override public function fromRaw(raw:IDataInput, mapVersion:int) : void
      {
         var ge:GraphicalElement = null;
         elementsCount = raw.readShort();
         if(AtouinConstants.DEBUG_FILES_PARSING)
         {
            _log.debug("    (Cell) Elements count : " + elementsCount);
         }
         elements = new Vector.<BasicElement>(elementsCount,true);
         for(var i:int = 0; i < elementsCount; i++)
         {
            ge = new GraphicalElement(this);
            ge.subFromRaw(raw,mapVersion);
            elements[i] = ge;
         }
      }
   }
}
