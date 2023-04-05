package com.ankamagames.atouin.messages
{
   import com.ankamagames.atouin.data.map.CellData;
   import com.ankamagames.jerakine.messages.Message;
   import flash.display.DisplayObject;
   
   public class AdjacentMapOverMessage implements Message
   {
       
      
      private var _nDirection:uint;
      
      private var _spZone:DisplayObject;
      
      private var _cellId:int;
      
      private var _cellData:CellData;
      
      private var _neighborMapId:Number;
      
      public function AdjacentMapOverMessage(nDirection:uint, zone:DisplayObject, cellId:int, cellData:CellData)
      {
         super();
         this._nDirection = nDirection;
         this._spZone = zone;
         this._cellId = cellId;
         this._cellData = cellData;
      }
      
      public function get direction() : uint
      {
         return this._nDirection;
      }
      
      public function get zone() : DisplayObject
      {
         return this._spZone;
      }
      
      public function get cellId() : int
      {
         return this._cellId;
      }
      
      public function get cellData() : CellData
      {
         return this._cellData;
      }
   }
}
