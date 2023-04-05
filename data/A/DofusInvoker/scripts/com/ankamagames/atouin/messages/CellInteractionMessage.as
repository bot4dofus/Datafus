package com.ankamagames.atouin.messages
{
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.display.Sprite;
   
   public class CellInteractionMessage extends MapMessage
   {
       
      
      private var _cellId:uint;
      
      private var _cellDepth:uint;
      
      private var _cellContainer:Sprite;
      
      private var _cellCoords:MapPoint;
      
      public function CellInteractionMessage()
      {
         super();
      }
      
      public function get cellId() : uint
      {
         return this._cellId;
      }
      
      public function set cellId(nValue:uint) : void
      {
         this._cellId = nValue;
      }
      
      public function get cellContainer() : Sprite
      {
         return this._cellContainer;
      }
      
      public function set cellContainer(sSprite:Sprite) : void
      {
         this._cellContainer = sSprite;
      }
      
      public function get cellDepth() : uint
      {
         return this._cellDepth;
      }
      
      public function set cellDepth(nValue:uint) : void
      {
         this._cellDepth = nValue;
      }
      
      public function get cell() : MapPoint
      {
         return this._cellCoords;
      }
      
      public function set cell(pValue:MapPoint) : void
      {
         this._cellCoords = pValue;
      }
   }
}
