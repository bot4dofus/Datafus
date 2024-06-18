package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceChangeMemberRankMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1892;
       
      
      private var _isInitialized:Boolean = false;
      
      public var memberId:Number = 0;
      
      public var rankId:uint = 0;
      
      public function AllianceChangeMemberRankMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1892;
      }
      
      public function initAllianceChangeMemberRankMessage(memberId:Number = 0, rankId:uint = 0) : AllianceChangeMemberRankMessage
      {
         this.memberId = memberId;
         this.rankId = rankId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.memberId = 0;
         this.rankId = 0;
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
         this.serializeAs_AllianceChangeMemberRankMessage(output);
      }
      
      public function serializeAs_AllianceChangeMemberRankMessage(output:ICustomDataOutput) : void
      {
         if(this.memberId < 0 || this.memberId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element memberId.");
         }
         output.writeVarLong(this.memberId);
         if(this.rankId < 0)
         {
            throw new Error("Forbidden value (" + this.rankId + ") on element rankId.");
         }
         output.writeVarInt(this.rankId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceChangeMemberRankMessage(input);
      }
      
      public function deserializeAs_AllianceChangeMemberRankMessage(input:ICustomDataInput) : void
      {
         this._memberIdFunc(input);
         this._rankIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceChangeMemberRankMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceChangeMemberRankMessage(tree:FuncTree) : void
      {
         tree.addChild(this._memberIdFunc);
         tree.addChild(this._rankIdFunc);
      }
      
      private function _memberIdFunc(input:ICustomDataInput) : void
      {
         this.memberId = input.readVarUhLong();
         if(this.memberId < 0 || this.memberId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element of AllianceChangeMemberRankMessage.memberId.");
         }
      }
      
      private function _rankIdFunc(input:ICustomDataInput) : void
      {
         this.rankId = input.readVarUhInt();
         if(this.rankId < 0)
         {
            throw new Error("Forbidden value (" + this.rankId + ") on element of AllianceChangeMemberRankMessage.rankId.");
         }
      }
   }
}
