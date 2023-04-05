package com.ankamagames.jerakine.json
{
   public class JSONParseError extends Error
   {
       
      
      private var _location:int;
      
      private var _text:String;
      
      public function JSONParseError(message:String = "", location:int = 0, text:String = "")
      {
         super(message);
         name = "JSONParseError";
         this._location = location;
         this._text = text;
      }
      
      public function get location() : int
      {
         return this._location;
      }
      
      public function get text() : String
      {
         return this._text;
      }
   }
}
