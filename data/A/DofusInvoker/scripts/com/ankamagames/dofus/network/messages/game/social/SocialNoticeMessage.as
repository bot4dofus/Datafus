package com.ankamagames.dofus.network.messages.game.social
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SocialNoticeMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3051;
       
      
      private var _isInitialized:Boolean = false;
      
      [Transient]
      public var content:String = "";
      
      public var timestamp:uint = 0;
      
      public var memberId:Number = 0;
      
      public var memberName:String = "";
      
      public function SocialNoticeMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3051;
      }
      
      public function initSocialNoticeMessage(content:String = "", timestamp:uint = 0, memberId:Number = 0, memberName:String = "") : SocialNoticeMessage
      {
         this.content = content;
         this.timestamp = timestamp;
         this.memberId = memberId;
         this.memberName = memberName;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.content = "";
         this.timestamp = 0;
         this.memberId = 0;
         this.memberName = "";
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:ICustomDataInput, length:uint) : void
      {
         this.deserialize(input);
      }
      
      override public function unpackAsync(input:ICustomDataInput, length:uint) : FuncTree
      {
         var tree:FuncTree = new FuncTree();
         tree.setRoot(input);
         this.deserializeAsync(tree);
         return tree;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_SocialNoticeMessage(output);
      }
      
      public function serializeAs_SocialNoticeMessage(output:ICustomDataOutput) : void
      {
         output.writeUTF(this.content);
         if(this.timestamp < 0)
         {
            throw new Error("Forbidden value (" + this.timestamp + ") on element timestamp.");
         }
         output.writeInt(this.timestamp);
         if(this.memberId < 0 || this.memberId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element memberId.");
         }
         output.writeVarLong(this.memberId);
         output.writeUTF(this.memberName);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SocialNoticeMessage(input);
      }
      
      public function deserializeAs_SocialNoticeMessage(input:ICustomDataInput) : void
      {
         this._contentFunc(input);
         this._timestampFunc(input);
         this._memberIdFunc(input);
         this._memberNameFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SocialNoticeMessage(tree);
      }
      
      public function deserializeAsyncAs_SocialNoticeMessage(tree:FuncTree) : void
      {
         tree.addChild(this._contentFunc);
         tree.addChild(this._timestampFunc);
         tree.addChild(this._memberIdFunc);
         tree.addChild(this._memberNameFunc);
      }
      
      private function _contentFunc(input:ICustomDataInput) : void
      {
         this.content = input.readUTF();
      }
      
      private function _timestampFunc(input:ICustomDataInput) : void
      {
         this.timestamp = input.readInt();
         if(this.timestamp < 0)
         {
            throw new Error("Forbidden value (" + this.timestamp + ") on element of SocialNoticeMessage.timestamp.");
         }
      }
      
      private function _memberIdFunc(input:ICustomDataInput) : void
      {
         this.memberId = input.readVarUhLong();
         if(this.memberId < 0 || this.memberId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element of SocialNoticeMessage.memberId.");
         }
      }
      
      private function _memberNameFunc(input:ICustomDataInput) : void
      {
         this.memberName = input.readUTF();
      }
   }
}
