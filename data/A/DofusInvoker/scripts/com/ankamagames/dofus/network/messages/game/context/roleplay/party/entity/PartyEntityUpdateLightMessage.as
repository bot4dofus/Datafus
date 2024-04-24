package com.ankamagames.dofus.network.messages.game.context.roleplay.party.entity
{
   import com.ankamagames.dofus.network.messages.game.context.roleplay.party.PartyUpdateLightMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PartyEntityUpdateLightMessage extends PartyUpdateLightMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4271;
       
      
      private var _isInitialized:Boolean = false;
      
      public var indexId:uint = 0;
      
      public function PartyEntityUpdateLightMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4271;
      }
      
      public function initPartyEntityUpdateLightMessage(partyId:uint = 0, id:Number = 0, lifePoints:uint = 0, maxLifePoints:uint = 0, prospecting:uint = 0, regenRate:uint = 0, indexId:uint = 0) : PartyEntityUpdateLightMessage
      {
         super.initPartyUpdateLightMessage(partyId,id,lifePoints,maxLifePoints,prospecting,regenRate);
         this.indexId = indexId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.indexId = 0;
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
         this.serializeAs_PartyEntityUpdateLightMessage(output);
      }
      
      public function serializeAs_PartyEntityUpdateLightMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_PartyUpdateLightMessage(output);
         if(this.indexId < 0)
         {
            throw new Error("Forbidden value (" + this.indexId + ") on element indexId.");
         }
         output.writeByte(this.indexId);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PartyEntityUpdateLightMessage(input);
      }
      
      public function deserializeAs_PartyEntityUpdateLightMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._indexIdFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PartyEntityUpdateLightMessage(tree);
      }
      
      public function deserializeAsyncAs_PartyEntityUpdateLightMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._indexIdFunc);
      }
      
      private function _indexIdFunc(input:ICustomDataInput) : void
      {
         this.indexId = input.readByte();
         if(this.indexId < 0)
         {
            throw new Error("Forbidden value (" + this.indexId + ") on element of PartyEntityUpdateLightMessage.indexId.");
         }
      }
   }
}
