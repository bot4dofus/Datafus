package com.ankamagames.atouin.data.map.elements
{
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.data.map.Cell;
   import com.ankamagames.atouin.enums.ElementTypesEnum;
   import com.ankamagames.jerakine.types.ColorMultiplicator;
   import flash.geom.Point;
   import flash.utils.IDataInput;
   
   public class GraphicalElement extends BasicElement
   {
       
      
      public var elementId:int;
      
      public var finalTeint:ColorMultiplicator;
      
      public var pixelOffset:Point;
      
      public var altitude:int;
      
      public var identifier:uint;
      
      public function GraphicalElement(cell:Cell)
      {
         super(cell);
      }
      
      override public function get elementType() : int
      {
         return ElementTypesEnum.GRAPHICAL;
      }
      
      public function get colorMultiplicator() : ColorMultiplicator
      {
         return this.finalTeint;
      }
      
      public function calculateFinalTeint(rHue:Number, gHue:Number, bHue:Number, rShadow:Number, gShadow:Number, bShadow:Number) : void
      {
         var r:Number = ColorMultiplicator.clamp((rHue + rShadow + 128) * 2,0,512);
         var g:Number = ColorMultiplicator.clamp((gHue + gShadow + 128) * 2,0,512);
         var b:Number = ColorMultiplicator.clamp((bHue + bShadow + 128) * 2,0,512);
         this.finalTeint = new ColorMultiplicator(r,g,b,true);
      }
      
      override public function fromRaw(raw:IDataInput, mapVersion:int) : void
      {
         this.subFromRaw(raw,mapVersion);
         this.identifier = raw.readUnsignedInt();
         if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
         {
            _log.debug("      (GraphicalElement) Identifier : " + this.identifier);
         }
      }
      
      public function subFromRaw(raw:IDataInput, mapVersion:int) : void
      {
         this.elementId = raw.readUnsignedInt();
         if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
         {
            _log.debug("      (GraphicalElement) Element id : " + this.elementId);
         }
         this.calculateFinalTeint(raw.readByte(),raw.readByte(),raw.readByte(),raw.readByte(),raw.readByte(),raw.readByte());
         if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
         {
            _log.debug("      (GraphicalElement) Teint : " + this.finalTeint);
         }
         this.pixelOffset = new Point();
         if(mapVersion <= 4)
         {
            this.pixelOffset.x = raw.readByte() * AtouinConstants.CELL_HALF_WIDTH;
            this.pixelOffset.y = raw.readByte() * AtouinConstants.CELL_HALF_HEIGHT;
         }
         else
         {
            this.pixelOffset.x = raw.readShort();
            this.pixelOffset.y = raw.readShort();
         }
         if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
         {
            _log.debug("      (GraphicalElement) Pixel Offset : (" + this.pixelOffset.x + ";" + this.pixelOffset.y + ")");
         }
         this.altitude = raw.readByte();
         if(AtouinConstants.DEBUG_FILES_PARSING_ELEMENTS)
         {
            _log.debug("      (GraphicalElement) Altitude : " + this.altitude);
         }
      }
   }
}
