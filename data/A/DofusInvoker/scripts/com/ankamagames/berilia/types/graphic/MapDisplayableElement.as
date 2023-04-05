package com.ankamagames.berilia.types.graphic
{
   import com.ankamagames.berilia.components.TextureBase;
   import com.ankamagames.berilia.types.data.MapElement;
   import com.ankamagames.jerakine.pools.PoolablePoint;
   import com.ankamagames.jerakine.pools.PoolsManager;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   
   public class MapDisplayableElement extends MapElement
   {
      
      public static const VISIBLE_BG_SCALE_CEIL:Number = 1.1;
      
      public static const INITIAL_SCALE:Number = 1;
      
      public static const SCALE_FACTOR:Number = 0.7;
       
      
      protected var _texture:TextureBase;
      
      protected var _texturePosition:PoolablePoint;
      
      protected var _scale:Number = 1;
      
      public function MapDisplayableElement(id:String, x:int, y:int, layer:String, owner:*, texture:TextureBase)
      {
         super(id,x,y,layer,owner);
         this._texture = texture;
      }
      
      override public function get classType() : String
      {
         return "MapDisplayableElement";
      }
      
      override public function remove() : void
      {
         if(this._texture)
         {
            this._texture.remove();
            if(this._texture.parent)
            {
               this._texture.parent.removeChild(this._texture);
            }
            this._texture = null;
         }
         if(this._texturePosition)
         {
            PoolsManager.getInstance().getPointPool().checkIn(this._texturePosition);
            this._texturePosition = null;
         }
         super.remove();
      }
      
      public function get textureX() : Number
      {
         if(this._texture)
         {
            return this._texture.x;
         }
         return 0;
      }
      
      public function set textureX(v:Number) : void
      {
         if(this._texture)
         {
            this._texture.x = v;
         }
      }
      
      public function get textureY() : Number
      {
         if(this._texture)
         {
            return this._texture.y;
         }
         return 0;
      }
      
      public function set textureY(v:Number) : void
      {
         if(this._texture)
         {
            this._texture.y = v;
         }
      }
      
      public function get uri() : String
      {
         if(this._texture && this._texture.uri)
         {
            return this._texture.uri.uri;
         }
         return null;
      }
      
      public function get texture() : TextureBase
      {
         return this._texture;
      }
      
      public function get textureName() : String
      {
         if(this._texture && this._texture.uri)
         {
            if(this._texture.uri.subPath)
            {
               return this._texture.uri.subPath;
            }
            return this._texture.uri.fileName;
         }
         return "";
      }
      
      public function getTexturePosition() : Point
      {
         if(!this._texturePosition)
         {
            this._texturePosition = PoolsManager.getInstance().getPointPool().checkOut() as PoolablePoint;
         }
         if(this._texture)
         {
            this._texturePosition.x = this._texture.x;
            this._texturePosition.y = this._texture.y;
         }
         return this._texturePosition;
      }
      
      public function setTexturePosition(x:Number, y:Number) : void
      {
         if(this._texture)
         {
            this._texture.x = x;
            this._texture.y = y;
         }
      }
      
      public function set textureScale(v:Number) : void
      {
         this._scale = v;
         if(this._texture)
         {
            if(this._scale > VISIBLE_BG_SCALE_CEIL)
            {
               this._texture.scaleX = this._scale * SCALE_FACTOR;
               this._texture.scaleY = this._scale * SCALE_FACTOR;
            }
            else
            {
               this._texture.scaleX = SCALE_FACTOR;
               this._texture.scaleY = SCALE_FACTOR;
            }
         }
      }
      
      public function setTextureParent(parent:DisplayObjectContainer) : void
      {
         if(this._texture)
         {
            parent.addChild(this._texture);
         }
      }
      
      public function hasTexture() : Boolean
      {
         return this._texture != null;
      }
   }
}
