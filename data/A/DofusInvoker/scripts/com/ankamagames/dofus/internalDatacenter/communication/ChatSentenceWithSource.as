package com.ankamagames.dofus.internalDatacenter.communication
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ChatSentenceWithSource extends BasicChatSentence implements IDataCenter
   {
       
      
      private var _senderId:Number;
      
      private var _prefix:String;
      
      private var _senderName:String;
      
      private var _objects:Vector.<ItemWrapper>;
      
      private var _admin:Boolean;
      
      public function ChatSentenceWithSource(id:uint, baseMsg:String, msg:String, channel:uint = 0, time:Number = 0, finger:String = "", senderId:Number = 0, prefix:String = "", senderName:String = "", objects:Vector.<ItemWrapper> = null, admin:Boolean = false)
      {
         super(id,baseMsg,msg,channel,time,finger);
         this._senderId = senderId;
         this._prefix = prefix;
         this._senderName = senderName;
         this._objects = objects;
         this._admin = admin;
      }
      
      public function get senderId() : Number
      {
         return this._senderId;
      }
      
      public function get prefix() : String
      {
         return this._prefix;
      }
      
      public function get senderName() : String
      {
         return this._senderName;
      }
      
      public function get objects() : Vector.<ItemWrapper>
      {
         return this._objects;
      }
      
      public function get admin() : Boolean
      {
         return this._admin;
      }
   }
}
