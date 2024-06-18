package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceMemberOnlineStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5529;
       
      
      private var _isInitialized:Boolean = false;
      
      public var memberId:Number = 0;
      
      public var online:Boolean = false;
      
      public function AllianceMemberOnlineStatusMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5529;
      }
      
      public function initAllianceMemberOnlineStatusMessage(memberId:Number = 0, online:Boolean = false) : AllianceMemberOnlineStatusMessage
      {
         this.memberId = memberId;
         this.online = online;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.memberId = 0;
         this.online = false;
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
         this.serializeAs_AllianceMemberOnlineStatusMessage(output);
      }
      
      public function serializeAs_AllianceMemberOnlineStatusMessage(output:ICustomDataOutput) : void
      {
         if(this.memberId < 0 || this.memberId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element memberId.");
         }
         output.writeVarLong(this.memberId);
         output.writeBoolean(this.online);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceMemberOnlineStatusMessage(input);
      }
      
      public function deserializeAs_AllianceMemberOnlineStatusMessage(input:ICustomDataInput) : void
      {
         this._memberIdFunc(input);
         this._onlineFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceMemberOnlineStatusMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceMemberOnlineStatusMessage(tree:FuncTree) : void
      {
         tree.addChild(this._memberIdFunc);
         tree.addChild(this._onlineFunc);
      }
      
      private function _memberIdFunc(input:ICustomDataInput) : void
      {
         this.memberId = input.readVarUhLong();
         if(this.memberId < 0 || this.memberId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element of AllianceMemberOnlineStatusMessage.memberId.");
         }
      }
      
      private function _onlineFunc(input:ICustomDataInput) : void
      {
         this.online = input.readBoolean();
      }
   }
}
