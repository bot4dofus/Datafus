package com.ankamagames.dofus.internalDatacenter.communication
{
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class ChatSentenceWithRecipient extends ChatSentenceWithSource implements IDataCenter
   {
       
      
      private var _receiverName:String;
      
      private var _receiverId:Number;
      
      public function ChatSentenceWithRecipient(id:uint, baseMsg:String, msg:String, channel:uint = 0, time:Number = 0, finger:String = "", senderId:Number = 0, prefix:String = "", senderName:String = "", receiverName:String = "", receiverId:Number = 0, objects:Vector.<ItemWrapper> = null)
      {
         super(id,baseMsg,msg,channel,time,finger,senderId,prefix,senderName,objects);
         this._receiverName = receiverName;
         this._receiverId = receiverId;
      }
      
      public function get receiverName() : String
      {
         return this._receiverName;
      }
      
      public function get receiverId() : Number
      {
         return this._receiverId;
      }
   }
}
