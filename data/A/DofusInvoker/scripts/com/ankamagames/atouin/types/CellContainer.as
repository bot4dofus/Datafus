package com.ankamagames.atouin.types
{
   import com.ankamagames.jerakine.data.XmlConfig;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   
   public class CellContainer extends Sprite implements ICellContainer
   {
      
      private static var _ratio:Number;
      
      private static var cltr:ColorTransform;
       
      
      private var _cellId:int = 0;
      
      private var _layerId:int = 0;
      
      private var _startX:int = 0;
      
      private var _startY:int = 0;
      
      private var _depth:int = 0;
      
      public function CellContainer(id:uint)
      {
         super();
         this.cellId = id;
         name = "Cell_" + this.cellId;
      }
      
      public function get cellId() : uint
      {
         return this._cellId;
      }
      
      public function set cellId(val:uint) : void
      {
         this._cellId = val;
      }
      
      public function get layerId() : int
      {
         return this._layerId;
      }
      
      public function set layerId(val:int) : void
      {
         this._layerId = val;
      }
      
      public function get startX() : int
      {
         return this._startX;
      }
      
      public function set startX(val:int) : void
      {
         this._startX = val;
      }
      
      public function get startY() : int
      {
         return this._startY;
      }
      
      public function set startY(val:int) : void
      {
         this._startY = val;
      }
      
      public function get depth() : int
      {
         return this._depth;
      }
      
      public function set depth(val:int) : void
      {
         this._depth = val;
      }
      
      public function addFakeChild(pChild:Object, pData:Object, colors:Object) : void
      {
         var val:* = undefined;
         if(isNaN(_ratio))
         {
            val = XmlConfig.getInstance().getEntry("config.gfx.world.scaleRatio");
            _ratio = val == null ? Number(1) : Number(parseFloat(val));
         }
         var child:DisplayObject = pChild as DisplayObject;
         if(pData != null)
         {
            if(pChild is Bitmap)
            {
               child.x = pData.x * _ratio;
               child.y = pData.y * _ratio;
            }
            else
            {
               child.x = pData.x;
               child.y = pData.y;
            }
            child.alpha = pData.alpha;
            child.scaleX = pData.scaleX;
            child.scaleY = pData.scaleY;
         }
         if(colors != null)
         {
            if(cltr == null)
            {
               cltr = new ColorTransform();
            }
            cltr.redMultiplier = colors.red;
            cltr.greenMultiplier = colors.green;
            cltr.blueMultiplier = colors.blue;
            cltr.alphaMultiplier = colors.alpha;
            child.transform.colorTransform = cltr;
         }
         addChild(child);
      }
   }
}
