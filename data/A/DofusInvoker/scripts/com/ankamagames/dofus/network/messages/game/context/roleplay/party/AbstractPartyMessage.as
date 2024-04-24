package com.ankamagames.dofus.network.messages.game.context.roleplay.party
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AbstractPartyMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1319;
       
      
      private var _isInitialized:Boolean = false;
      
      public var partyId:uint = 0;
      
      public function AbstractPartyMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1319;
      }
      
      public function initAbstractPartyMessage(partyId:uint = 0) : AbstractPartyMessage
      {
         this.partyId = partyId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.partyId = 0;
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
         this.serializeAs_AbstractPartyMessage(output);
      }
      
      public function serializeAs_AbstractPartyMessage(output:ICustomDataOutput) : void
      {
         if(this.partyId < 0)
         {
            throw new Error("Forbidden value (" + this.partyId + ") on element partyId.");
         }
         output.writeVarInt(this.partyId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AbstractPartyMessage(input);
      }
      
      public function deserializeAs_AbstractPartyMessage(input:ICustomDataInput) : void
      {
         this._partyIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AbstractPartyMessage(tree);
      }
      
      public function deserializeAsyncAs_AbstractPartyMessage(tree:FuncTree) : void
      {
         tree.addChild(this._partyIdFunc);
      }
      
      private function _partyIdFunc(input:ICustomDataInput) : void
      {
         this.partyId = input.readVarUhInt();
         if(this.partyId < 0)
         {
            throw new Error("Forbidden value (" + this.partyId + ") on element of AbstractPartyMessage.partyId.");
         }
      }
   }
}
