package com.ankamagames.atouin.types
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.pools.PoolableRectangle;
   import com.ankamagames.jerakine.pools.PoolsManager;
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   
   public class CellReference
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CellReference));
       
      
      private var _visible:Boolean;
      
      private var _lock:Boolean = false;
      
      public var id:uint;
      
      public var listSprites:Array;
      
      public var elevation:int = 0;
      
      public var x:Number = 0;
      
      public var y:Number = 0;
      
      public var width:Number = 0;
      
      public var height:Number = 0;
      
      public var mov:Boolean;
      
      public var isDisabled:Boolean = false;
      
      public var rendered:Boolean = false;
      
      public var gfxId:Array;
      
      public function CellReference(nId:uint)
      {
         super();
         this.id = nId;
         this.listSprites = new Array();
         this.gfxId = new Array();
      }
      
      public function addSprite(d:DisplayObject) : void
      {
         this.listSprites.push(d);
      }
      
      public function addGfx(nGfxId:int) : void
      {
         this.gfxId.push(nGfxId);
      }
      
      public function lock() : void
      {
         this._lock = true;
      }
      
      public function get locked() : Boolean
      {
         return this._lock;
      }
      
      public function get visible() : Boolean
      {
         return this._visible;
      }
      
      public function set visible(bValue:Boolean) : void
      {
         var i:uint = 0;
         if(this._visible != bValue)
         {
            this._visible = bValue;
            for(i = 0; i < this.listSprites.length; i++)
            {
               if(this.listSprites[i] != null)
               {
                  this.listSprites[i].visible = bValue;
               }
            }
         }
      }
      
      public function get bounds() : Rectangle
      {
         var sprite:DisplayObject = null;
         var rectangle:PoolableRectangle = (PoolsManager.getInstance().getRectanglePool().checkOut() as PoolableRectangle).renew();
         var boundRect:PoolableRectangle = PoolsManager.getInstance().getRectanglePool().checkOut() as PoolableRectangle;
         for each(sprite in this.listSprites)
         {
            rectangle.extend(boundRect.renew(sprite.x,sprite.y,sprite.width,sprite.height));
         }
         PoolsManager.getInstance().getRectanglePool().checkIn(boundRect);
         PoolsManager.getInstance().getRectanglePool().checkIn(rectangle);
         return rectangle as Rectangle;
      }
      
      public function getAvgColor() : uint
      {
         var t:ColorTransform = null;
         var i:int = 0;
         var red:Number = 0;
         var green:Number = 0;
         var blue:Number = 0;
         var len:int = this.listSprites.length;
         for(i = 0; i < len; i += 1)
         {
            t = (this.listSprites[i] as DisplayObject).transform.colorTransform;
            red += t.redOffset * t.redMultiplier;
            green += t.greenOffset * t.greenMultiplier;
            blue += t.blueOffset * t.blueMultiplier;
         }
         red /= len;
         green /= len;
         blue /= len;
         return red << 16 | green << 8 | blue;
      }
   }
}
