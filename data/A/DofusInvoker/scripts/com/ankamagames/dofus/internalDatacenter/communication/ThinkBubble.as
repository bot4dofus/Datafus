package com.ankamagames.dofus.internalDatacenter.communication
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ThinkBubble implements IDataCenter
   {
       
      
      private var _text:String;
      
      public function ThinkBubble(text:String)
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
