package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PartyMemberEjectedMessage extends PartyMemberRemoveMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9438;
       
      
      private var _isInitialized:Boolean = false;
      
      public var kickerId:Number = 0;
      
      public function PartyMemberEjectedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9438;
      }
      
      public function initPartyMemberEjectedMessage(partyId:uint = 0, leavingPlayerId:Number = 0, kickerId:Number = 0) : PartyMemberEjectedMessage
      {
         super.initPartyMemberRemoveMessage(partyId,leavingPlayerId);
         this.kickerId = kickerId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.kickerId = 0;
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
         this.serializeAs_PartyMemberEjectedMessage(output);
      }
      
      public function serializeAs_PartyMemberEjectedMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_PartyMemberRemoveMessage(output);
         if(this.kickerId < 0 || this.kickerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.kickerId + ") on element kickerId.");
         }
         output.writeVarLong(this.kickerId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyMemberEjectedMessage(input);
      }
      
      public function deserializeAs_PartyMemberEjectedMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._kickerIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyMemberEjectedMessage(tree);
      }
      
      public function deserializeAsyncAs_PartyMemberEjectedMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._kickerIdFunc);
      }
      
      private function _kickerIdFunc(input:ICustomDataInput) : void
      {
         this.kickerId = input.readVarUhLong();
         if(this.kickerId < 0 || this.kickerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.kickerId + ") on element of PartyMemberEjectedMessage.kickerId.");
         }
      }
   }
}
