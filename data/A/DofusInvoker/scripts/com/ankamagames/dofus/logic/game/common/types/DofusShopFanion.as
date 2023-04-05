package com.ankamagames.dofus.logic.game.common.types
{
   public class DofusShopFanion
   {
       
      
      private var _textColor:String = "white";
      
      private var _text:String = "";
      
      private var _pictoName:String = "";
      
      private var _bgColor:int = 0;
      
      public function DofusShopFanion()
      {
         super();
      }
      
      public static function createFromData(data:Object) : DofusShopFanion
      {
         if(!data.key)
         {
            return null;
         }
         var fanion:DofusShopFanion = new DofusShopFanion();
         fanion.text = data.value;
         fanion.pictoName = DofusShopFanionEnum["PICTO_" + data.key];
         fanion.bgColor = DofusShopFanionEnum["COLOR_" + data.key];
         fanion.textColor = DofusShopFanionEnum["TEXTCOLOR_" + data.key];
         return fanion;
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function set text(text:String) : void
      {
         this._text = text;
      }
      
      public function get pictoName() : String
      {
         return this._pictoName;
      }
      
      public function set pictoName(pictoName:String) : void
      {
         this._pictoName = pictoName;
      }
      
      public function get bgColor() : int
      {
         return this._bgColor;
      }
      
      public function set bgColor(bgColor:int) : void
      {
         this._bgColor = bgColor;
      }
      
      public function get textColor() : String
      {
         return this._textColor;
      }
      
      public function set textColor(textColor:String) : void
      {
         this._textColor = textColor;
      }
   }
}
