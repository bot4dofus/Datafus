package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   
   public class Fanion extends GraphicContainer implements FinalizableUIComponent
   {
       
      
      private var _background:Texture;
      
      private var _label:Label;
      
      private var _picto:Texture;
      
      private var _margin:int = 16;
      
      private var _maxWidth:int = 2147483647;
      
      private var _maxLabelWidth:int = 2147483647;
      
      public function Fanion()
      {
         super();
         this.createBackground();
         this.createPicto();
         this.createLabel();
      }
      
      public function get background() : Texture
      {
         return this._background;
      }
      
      public function get label() : Label
      {
         return this._label;
      }
      
      public function get picto() : Texture
      {
         return this._picto;
      }
      
      public function get maxWidth() : int
      {
         return this._maxWidth;
      }
      
      public function get maxLabelWidth() : int
      {
         return this._maxLabelWidth;
      }
      
      public function set maxWidth(width:int) : void
      {
         this._maxWidth = width;
         this._maxLabelWidth = width - (this._picto.width + this._margin + 5);
      }
      
      public function set text(text:String) : void
      {
         this._label.text = text;
         this._label.fullWidthAndHeight();
         this.recalculateBackgroundSize();
      }
      
      public function set margin(margin:int) : void
      {
         this._margin = margin;
         this.recalculateBackgroundSize();
      }
      
      private function createBackground() : void
      {
         this._background = new Texture();
         this._background.finalized = true;
         this._background.x = 0;
         this._background.y = 0;
         addChild(this._background);
      }
      
      private function createLabel() : void
      {
         this._label = new Label();
         addChild(this._label);
      }
      
      private function createPicto() : void
      {
         this._picto = new Texture();
         this._picto.finalized = true;
         this._picto.x = 0;
         this._picto.y = 0;
         addChild(this._picto);
      }
      
      public function recalculateBackgroundSize() : void
      {
         this._background.width = Math.min(this._label.width + this._picto.width + this._margin + 5,this._maxWidth);
         this._label.x = 2 * this._margin / 3;
         this._label.y = (this._background.height - this._label.height) / 2 + 2;
         this._picto.x = this._label.x + this._label.width + 5;
         this._picto.y = (this._background.height - this._picto.height) / 2;
      }
      
      public function setPictoSize(width:int, height:int) : void
      {
         this._picto.width = width;
         this._picto.height = height;
         this.recalculateBackgroundSize();
         if(this._picto.width == 0 || this._picto.width == 0)
         {
            this._picto.visible = false;
         }
      }
   }
}
