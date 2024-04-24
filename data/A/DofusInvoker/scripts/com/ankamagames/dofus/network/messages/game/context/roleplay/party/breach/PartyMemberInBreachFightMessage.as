package com.ankamagames.dofus.network.messages.game.context.roleplay.party.breach
{
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.AbstractPartyMemberInFightMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PartyMemberInBreachFightMessage extends AbstractPartyMemberInFightMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8104;
       
      
      private var _isInitialized:Boolean = false;
      
      public var floor:uint = 0;
      
      public var room:uint = 0;
      
      public function PartyMemberInBreachFightMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8104;
      }
      
      public function initPartyMemberInBreachFightMessage(partyId:uint = 0, reason:uint = 0, memberId:Number = 0, memberAccountId:uint = 0, memberName:String = "", fightId:uint = 0, timeBeforeFightStart:int = 0, floor:uint = 0, room:uint = 0) : PartyMemberInBreachFightMessage
      {
         super.initAbstractPartyMemberInFightMessage(partyId,reason,memberId,memberAccountId,memberName,fightId,timeBeforeFightStart);
         this.floor = floor;
         this.room = room;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.floor = 0;
         this.room = 0;
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
         this.serializeAs_PartyMemberInBreachFightMessage(output);
      }
      
      public function serializeAs_PartyMemberInBreachFightMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyMemberInFightMessage(output);
         if(this.floor < 0)
         {
            throw new Error("Forbidden value (" + this.floor + ") on element floor.");
         }
         output.writeVarInt(this.floor);
         if(this.room < 0)
         {
            throw new Error("Forbidden value (" + this.room + ") on element room.");
         }
         output.writeByte(this.room);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyMemberInBreachFightMessage(input);
      }
      
      public function deserializeAs_PartyMemberInBreachFightMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._floorFunc(input);
         this._roomFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyMemberInBreachFightMessage(tree);
      }
      
      public function deserializeAsyncAs_PartyMemberInBreachFightMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._floorFunc);
         tree.addChild(this._roomFunc);
      }
      
      private function _floorFunc(input:ICustomDataInput) : void
      {
         this.floor = input.readVarUhInt();
         if(this.floor < 0)
         {
            throw new Error("Forbidden value (" + this.floor + ") on element of PartyMemberInBreachFightMessage.floor.");
         }
      }
      
      private function _roomFunc(input:ICustomDataInput) : void
      {
         this.room = input.readByte();
         if(this.room < 0)
         {
            throw new Error("Forbidden value (" + this.room + ") on element of PartyMemberInBreachFightMessage.room.");
         }
      }
   }
}
