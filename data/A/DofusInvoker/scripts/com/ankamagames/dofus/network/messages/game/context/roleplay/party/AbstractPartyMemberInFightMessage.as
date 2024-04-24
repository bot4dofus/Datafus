package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AbstractPartyMemberInFightMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 392;
       
      
      private var _isInitialized:Boolean = false;
      
      public var reason:uint = 0;
      
      public var memberId:Number = 0;
      
      public var memberAccountId:uint = 0;
      
      public var memberName:String = "";
      
      public var fightId:uint = 0;
      
      public var timeBeforeFightStart:int = 0;
      
      public function AbstractPartyMemberInFightMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 392;
      }
      
      public function initAbstractPartyMemberInFightMessage(partyId:uint = 0, reason:uint = 0, memberId:Number = 0, memberAccountId:uint = 0, memberName:String = "", fightId:uint = 0, timeBeforeFightStart:int = 0) : AbstractPartyMemberInFightMessage
      {
         super.initAbstractPartyMessage(partyId);
         this.reason = reason;
         this.memberId = memberId;
         this.memberAccountId = memberAccountId;
         this.memberName = memberName;
         this.fightId = fightId;
         this.timeBeforeFightStart = timeBeforeFightStart;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.reason = 0;
         this.memberId = 0;
         this.memberAccountId = 0;
         this.memberName = "";
         this.fightId = 0;
         this.timeBeforeFightStart = 0;
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AbstractPartyMemberInFightMessage(output);
      }
      
      public function serializeAs_AbstractPartyMemberInFightMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyMessage(output);
         output.writeByte(this.reason);
         if(this.memberId < 0 || this.memberId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element memberId.");
         }
         output.writeVarLong(this.memberId);
         if(this.memberAccountId < 0)
         {
            throw new Error("Forbidden value (" + this.memberAccountId + ") on element memberAccountId.");
         }
         output.writeInt(this.memberAccountId);
         output.writeUTF(this.memberName);
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         output.writeVarShort(this.fightId);
         output.writeVarShort(this.timeBeforeFightStart);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AbstractPartyMemberInFightMessage(input);
      }
      
      public function deserializeAs_AbstractPartyMemberInFightMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._reasonFunc(input);
         this._memberIdFunc(input);
         this._memberAccountIdFunc(input);
         this._memberNameFunc(input);
         this._fightIdFunc(input);
         this._timeBeforeFightStartFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AbstractPartyMemberInFightMessage(tree);
      }
      
      public function deserializeAsyncAs_AbstractPartyMemberInFightMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._reasonFunc);
         tree.addChild(this._memberIdFunc);
         tree.addChild(this._memberAccountIdFunc);
         tree.addChild(this._memberNameFunc);
         tree.addChild(this._fightIdFunc);
         tree.addChild(this._timeBeforeFightStartFunc);
      }
      
      private function _reasonFunc(input:ICustomDataInput) : void
      {
         this.reason = input.readByte();
         if(this.reason < 0)
         {
            throw new Error("Forbidden value (" + this.reason + ") on element of AbstractPartyMemberInFightMessage.reason.");
         }
      }
      
      private function _memberIdFunc(input:ICustomDataInput) : void
      {
         this.memberId = input.readVarUhLong();
         if(this.memberId < 0 || this.memberId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.memberId + ") on element of AbstractPartyMemberInFightMessage.memberId.");
         }
      }
      
      private function _memberAccountIdFunc(input:ICustomDataInput) : void
      {
         this.memberAccountId = input.readInt();
         if(this.memberAccountId < 0)
         {
            throw new Error("Forbidden value (" + this.memberAccountId + ") on element of AbstractPartyMemberInFightMessage.memberAccountId.");
         }
      }
      
      private function _memberNameFunc(input:ICustomDataInput) : void
      {
         this.memberName = input.readUTF();
      }
      
      private function _fightIdFunc(input:ICustomDataInput) : void
      {
         this.fightId = input.readVarUhShort();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of AbstractPartyMemberInFightMessage.fightId.");
         }
      }
      
      private function _timeBeforeFightStartFunc(input:ICustomDataInput) : void
      {
         this.timeBeforeFightStart = input.readVarShort();
      }
   }
}
