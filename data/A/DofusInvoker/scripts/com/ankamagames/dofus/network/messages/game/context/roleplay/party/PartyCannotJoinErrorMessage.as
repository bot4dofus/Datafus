package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PartyCannotJoinErrorMessage extends AbstractPartyMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1360;
       
      
      private var _isInitialized:Boolean = false;
      
      public var reason:uint = 0;
      
      public function PartyCannotJoinErrorMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1360;
      }
      
      public function initPartyCannotJoinErrorMessage(partyId:uint = 0, reason:uint = 0) : PartyCannotJoinErrorMessage
      {
         super.initAbstractPartyMessage(partyId);
         this.reason = reason;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.reason = 0;
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
         this.serializeAs_PartyCannotJoinErrorMessage(output);
      }
      
      public function serializeAs_PartyCannotJoinErrorMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AbstractPartyMessage(output);
         output.writeByte(this.reason);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyCannotJoinErrorMessage(input);
      }
      
      public function deserializeAs_PartyCannotJoinErrorMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._reasonFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyCannotJoinErrorMessage(tree);
      }
      
      public function deserializeAsyncAs_PartyCannotJoinErrorMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._reasonFunc);
      }
      
      private function _reasonFunc(input:ICustomDataInput) : void
      {
         this.reason = input.readByte();
         if(this.reason < 0)
         {
            throw new Error("Forbidden value (" + this.reason + ") on element of PartyCannotJoinErrorMessage.reason.");
         }
      }
   }
}
