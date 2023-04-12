package com.ankamagames.berilia.components
{
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.messages.Message;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class LinkedLabel extends Label
   {
       
      
      private var _sUrl:String;
      
      private var _sTarget:String = "_blank";
      
      public function LinkedLabel()
      {
         super();
         buttonMode = true;
         mouseChildren = false;
      }
      
      public function get url() : String
      {
         return this._sUrl;
      }
      
      public function set url(value:String) : void
      {
         this._sUrl = value;
      }
      
      public function get target() : String
      {
         return this._sTarget;
      }
      
      public function set target(value:String) : void
      {
         this._sTarget = value;
      }
      
      override public function process(msg:Message) : Boolean
      {
         switch(true)
         {
            case msg is MouseClickMessage:
               if((msg as MouseClickMessage).target == this && getUi())
               {
                  navigateToURL(new URLRequest(this.url),this.target);
                  return true;
               }
               break;
         }
         return false;
      }
   }
}
