package com.ankamagames.berilia.types.graphic
{
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBase;
   import flash.geom.Rectangle;
   
   public class MapIconElement extends MapDisplayableElement
   {
       
      
      public var legend:String;
      
      public var follow:Boolean;
      
      public var canBeGrouped:Boolean = true;
      
      public var canBeAutoSize:Boolean = true;
      
      public var canBeManuallyRemoved:Boolean = true;
      
      public var allowDuplicate:Boolean;
      
      public var priority:uint;
      
      public var color:int;
      
      public var visible:Boolean;
      
      private var _highlight:Boolean = false;
      
      private var _boundsRef:TextureBase;
      
      public function MapIconElement(id:String, x:int, y:int, layer:String, texture:TextureBase, color:int, legend:String, owner:*, canBeManuallyRemoved:Boolean = true, mouseEnabled:Boolean = false, allowDuplicate:Boolean = false, priority:uint = 0)
      {
         super(id,x,y,layer,owner,texture);
         this.legend = legend;
         this.canBeManuallyRemoved = canBeManuallyRemoved;
         this.allowDuplicate = allowDuplicate;
         this.priority = priority;
         this.color = color;
         this.visible = true;
         _texture.mouseEnabled = mouseEnabled;
      }
      
      override public function get classType() : String
      {
         return "MapIconElement";
      }
      
      public function get bounds() : Rectangle
      {
         return !!this._boundsRef ? this._boundsRef.getStageRect() : this.getRealBounds;
      }
      
      public function get getRealBounds() : Rectangle
      {
         return !!_texture ? _texture.getStageRect() : null;
      }
      
      public function set boundsRef(v:Texture) : void
      {
         this._boundsRef = v;
      }
      
      public function highlight(highlight:Boolean = true) : void
      {
         if(this._highlight == highlight)
         {
            return;
         }
         var lastScale:Number = _scale;
         this._highlight = highlight;
         if(this._highlight)
         {
            textureScale = _scale * 1.5;
            _scale = lastScale;
         }
         else
         {
            textureScale = _scale;
         }
      }
      
      public function setScale(scale:Number) : void
      {
         var lastScale:Number = _scale;
         textureScale = _scale * scale;
         _scale = lastScale;
      }
      
      override public function remove() : void
      {
         this._boundsRef = null;
         super.remove();
      }
      
      public function get key() : String
      {
         return x + "_" + y;
      }
   }
}
