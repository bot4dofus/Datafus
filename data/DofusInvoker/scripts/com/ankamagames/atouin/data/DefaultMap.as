package com.ankamagames.atouin.data
{
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.data.map.Cell;
   import com.ankamagames.atouin.data.map.CellData;
   import com.ankamagames.atouin.data.map.Fixture;
   import com.ankamagames.atouin.data.map.Layer;
   import com.ankamagames.atouin.data.map.Map;
   import flash.utils.ByteArray;
   import flash.utils.IDataInput;
   
   public class DefaultMap extends Map
   {
       
      
      public function DefaultMap(id:uint = 0)
      {
         var i:int = 0;
         var cd:CellData = null;
         super();
         this.id = id;
         mapVersion = 7;
         var emptyFixtureList:Vector.<Fixture> = new Vector.<Fixture>(0,true);
         backgroundFixtures = emptyFixtureList;
         foregroundFixtures = emptyFixtureList;
         layers = new Vector.<Layer>(2,true);
         layers[0] = this.createLayer(Layer.LAYER_GROUND);
         layers[1] = this.createLayer(Layer.LAYER_DECOR);
         cellsCount = AtouinConstants.MAP_CELLS_COUNT;
         cells = new Vector.<CellData>(cellsCount,true);
         for(i = 0; i < cellsCount; i++)
         {
            cd = new CellData(this,i);
            cells[i] = cd;
         }
      }
      
      override public function fromRaw(raw:IDataInput, decryptionKey:ByteArray = null) : void
      {
      }
      
      private function createLayer(id:uint) : Layer
      {
         var bgLayer:Layer = new Layer(this);
         bgLayer.layerId = id;
         bgLayer.cellsCount = 1;
         bgLayer.cells = new Vector.<Cell>();
         var firstCell:Cell = Cell.createEmptyCell(bgLayer,0);
         bgLayer.cells.push(firstCell);
         bgLayer.cells.fixed = true;
         return bgLayer;
      }
   }
}
