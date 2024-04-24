package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildChangeMemberParametersMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1637;
       
      
      private var _isInitialized:Boolean = false;
      
      public var memberId:Number = 0;
      
      public var rankId:uint = 0;
      
      public var experienceGivenPercent:uint = 0;
      
      public function GuildChangeMemberParametersMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1637;
      }
      
      public function initGuildChangeMemberParametersMessage(memberId:Number = 0, rankId:uint = 0, experienceGivenPercent:uint = 0) : GuildChangeMemberParametersMessage
      {
         this.memberId = memberId;
         this.rankId = rankId;
         this.experienceGivenPercent = experienceGivenPercent;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.memberId = 0;
         this.rankId = 0;
         this.experienceGivenPercent = 0;
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
         this.serializeAs_GuildChangeMemberParametersMessage(output);
      }
      
      public function serializeAs_GuildChangeMemberParametersMessage(output:ICustomDataOutput) : void
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
         if(this.experienceGivenPercent < 0 || this.experienceGivenPercent > 100)
         {
            throw new Error("Forbidden value (" + this.experienceGivenPercent + ") on element experienceGivenPercent.");
         }
         output.writeByte(this.experienceGivenPercent);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildChangeMemberParametersMessage(input);
      }
      
      public function deserializeAs_GuildChangeMemberParametersMessage(input:ICustomDataInput) : void
      {
         this._memberIdFunc(input);
         this._rankIdFunc(input);
         this._experienceGivenPercentFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildChangeMemberParametersMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildChangeMemberParametersMessage(tree:FuncTree) : void
      {
         tree.addChild(this._memberIdFunc);
         tree.addChild(this._rankIdFunc);
         tree.addChild(this._experienceGivenPercentFunc);
      }
      
      private function _memberIdFunc(input:ICustomDataInput) : void
      {
         this.memberId = input.readVarUhLong();
         if(this.memberId < 0 || this.memberId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element of GuildChangeMemberParametersMessage.memberId.");
         }
      }
      
      private function _rankIdFunc(input:ICustomDataInput) : void
      {
         this.rankId = input.readVarUhInt();
         if(this.rankId < 0)
         {
            throw new Error("Forbidden value (" + this.rankId + ") on element of GuildChangeMemberParametersMessage.rankId.");
         }
      }
      
      private function _experienceGivenPercentFunc(input:ICustomDataInput) : void
      {
         this.experienceGivenPercent = input.readByte();
         if(this.experienceGivenPercent < 0 || this.experienceGivenPercent > 100)
         {
            throw new Error("Forbidden value (" + this.experienceGivenPercent + ") on element of GuildChangeMemberParametersMessage.experienceGivenPercent.");
         }
      }
   }
}
