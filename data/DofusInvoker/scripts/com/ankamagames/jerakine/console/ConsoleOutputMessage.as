package com.ankamagames.jerakine.console
{
   import com.ankamagames.jerakine.messages.Message;
   
   public class ConsoleOutputMessage implements Message
   {
       
      
      private var _consoleId:String;
      
      private var _text:String;
      
      private var _type:uint;
      
      public function ConsoleOutputMessage(consoleId:String, text:String, type:uint)
      {
         super();
         this._consoleId = consoleId;
         this._text = text;
         this._type = type;
      }
      
      public function get consoleId() : String
      {
         return this._consoleId;
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function get type() : uint
      {
         return this._type;
      }
   }
}
