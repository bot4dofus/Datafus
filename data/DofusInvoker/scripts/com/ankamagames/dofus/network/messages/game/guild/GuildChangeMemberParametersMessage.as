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
      
      public static const protocolId:uint = 1869;
       
      
      private var _isInitialized:Boolean = false;
      
      public var memberId:Number = 0;
      
      public var rank:uint = 0;
      
      public var experienceGivenPercent:uint = 0;
      
      public var rights:uint = 0;
      
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
         return 1869;
      }
      
      public function initGuildChangeMemberParametersMessage(memberId:Number = 0, rank:uint = 0, experienceGivenPercent:uint = 0, rights:uint = 0) : GuildChangeMemberParametersMessage
      {
         this.memberId = memberId;
         this.rank = rank;
         this.experienceGivenPercent = experienceGivenPercent;
         this.rights = rights;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.memberId = 0;
         this.rank = 0;
         this.experienceGivenPercent = 0;
         this.rights = 0;
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
         if(this.rank < 0)
         {
            throw new Error("Forbidden value (" + this.rank + ") on element rank.");
         }
         output.writeVarShort(this.rank);
         if(this.experienceGivenPercent < 0 || this.experienceGivenPercent > 100)
         {
            throw new Error("Forbidden value (" + this.experienceGivenPercent + ") on element experienceGivenPercent.");
         }
         output.writeByte(this.experienceGivenPercent);
         if(this.rights < 0)
         {
            throw new Error("Forbidden value (" + this.rights + ") on element rights.");
         }
         output.writeVarInt(this.rights);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildChangeMemberParametersMessage(input);
      }
      
      public function deserializeAs_GuildChangeMemberParametersMessage(input:ICustomDataInput) : void
      {
         this._memberIdFunc(input);
         this._rankFunc(input);
         this._experienceGivenPercentFunc(input);
         this._rightsFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildChangeMemberParametersMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildChangeMemberParametersMessage(tree:FuncTree) : void
      {
         tree.addChild(this._memberIdFunc);
         tree.addChild(this._rankFunc);
         tree.addChild(this._experienceGivenPercentFunc);
         tree.addChild(this._rightsFunc);
      }
      
      private function _memberIdFunc(input:ICustomDataInput) : void
      {
         this.memberId = input.readVarUhLong();
         if(this.memberId < 0 || this.memberId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element of GuildChangeMemberParametersMessage.memberId.");
         }
      }
      
      private function _rankFunc(input:ICustomDataInput) : void
      {
         this.rank = input.readVarUhShort();
         if(this.rank < 0)
         {
            throw new Error("Forbidden value (" + this.rank + ") on element of GuildChangeMemberParametersMessage.rank.");
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
      
      private function _rightsFunc(input:ICustomDataInput) : void
      {
         this.rights = input.readVarUhInt();
         if(this.rights < 0)
         {
            throw new Error("Forbidden value (" + this.rights + ") on element of GuildChangeMemberParametersMessage.rights.");
         }
      }
   }
}
