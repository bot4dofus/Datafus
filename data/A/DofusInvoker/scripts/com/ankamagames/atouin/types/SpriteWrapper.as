package com.ankamagames.atouin.types
{
   import com.ankamagames.jerakine.interfaces.ICustomUnicNameGetter;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   
   public class SpriteWrapper extends Sprite implements ICustomUnicNameGetter
   {
       
      
      private var _name:String;
      
      public function SpriteWrapper(content:DisplayObject, identifier:uint)
      {
         super();
         addChild(content);
         this._name = "mapGfx::" + identifier;
      }
      
      public function get customUnicName() : String
      {
         return this._name;
      }
   }
}
