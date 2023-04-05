package com.ankamagames.berilia.types.messages
{
   import com.ankamagames.jerakine.messages.Message;
   
   public class ThemeLoadedMessage implements Message
   {
       
      
      private var _themeName:String;
      
      public function ThemeLoadedMessage(themeName:String)
      {
         super();
         this._themeName = themeName;
      }
      
      public function get themeName() : String
      {
         return this._themeName;
      }
   }
}
