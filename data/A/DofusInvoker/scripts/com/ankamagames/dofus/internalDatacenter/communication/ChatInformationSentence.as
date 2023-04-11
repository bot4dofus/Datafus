package com.ankamagames.dofus.internalDatacenter.communication
{
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ChatInformationSentence extends BasicChatSentence implements IDataCenter
   {
       
      
      private var _textKey:uint;
      
      private var _params:Array;
      
      public function ChatInformationSentence(id:uint, baseMsg:String, msg:String, channel:uint = 0, time:Number = 0, finger:String = "", textKey:uint = 0, params:Array = null)
      {
         super(id,baseMsg,msg,channel,time,finger);
         this._textKey = textKey;
         this._params = params;
      }
      
      public function get textKey() : uint
      {
         return this._textKey;
      }
      
      public function get params() : Array
      {
         return this._params;
      }
      
      override public function get msg() : String
      {
         return I18n.getText(this._textKey,this._params);
      }
   }
}
