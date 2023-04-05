package com.ankamagames.dofus.internalDatacenter.communication
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ChatBubble implements IDataCenter
   {
       
      
      private var _text:String;
      
      public function ChatBubble(text:String)
      {
         super();
         this._text = text;
      }
      
      public function get text() : String
      {
         return this._text;
      }
   }
}
