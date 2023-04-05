package com.ankamagames.dofus.network.messages.game.prism
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PrismFightDefenderAddMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2845;
       
      
      private var _isInitialized:Boolean = false;
      
      public var subAreaId:uint = 0;
      
      public var fightId:uint = 0;
      
      public var defender:CharacterMinimalPlusLookInformations;
      
      private var _defendertree:FuncTree;
      
      public function PrismFightDefenderAddMessage()
      {
         this.defender = new CharacterMinimalPlusLookInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2845;
      }
      
      public function initPrismFightDefenderAddMessage(subAreaId:uint = 0, fightId:uint = 0, defender:CharacterMinimalPlusLookInformations = null) : PrismFightDefenderAddMessage
      {
         this.subAreaId = subAreaId;
         this.fightId = fightId;
         this.defender = defender;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.subAreaId = 0;
         this.fightId = 0;
         this.defender = new CharacterMinimalPlusLookInformations();
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
         this.serializeAs_PrismFightDefenderAddMessage(output);
      }
      
      public function serializeAs_PrismFightDefenderAddMessage(output:ICustomDataOutput) : void
      {
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         output.writeVarShort(this.subAreaId);
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element fightId.");
         }
         output.writeVarShort(this.fightId);
         output.writeShort(this.defender.getTypeId());
         this.defender.serialize(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PrismFightDefenderAddMessage(input);
      }
      
      public function deserializeAs_PrismFightDefenderAddMessage(input:ICustomDataInput) : void
      {
         this._subAreaIdFunc(input);
         this._fightIdFunc(input);
         var _id3:uint = input.readUnsignedShort();
         this.defender = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations,_id3);
         this.defender.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PrismFightDefenderAddMessage(tree);
      }
      
      public function deserializeAsyncAs_PrismFightDefenderAddMessage(tree:FuncTree) : void
      {
         tree.addChild(this._subAreaIdFunc);
         tree.addChild(this._fightIdFunc);
         this._defendertree = tree.addChild(this._defendertreeFunc);
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of PrismFightDefenderAddMessage.subAreaId.");
         }
      }
      
      private function _fightIdFunc(input:ICustomDataInput) : void
      {
         this.fightId = input.readVarUhShort();
         if(this.fightId < 0)
         {
            throw new Error("Forbidden value (" + this.fightId + ") on element of PrismFightDefenderAddMessage.fightId.");
         }
      }
      
      private function _defendertreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.defender = ProtocolTypeManager.getInstance(CharacterMinimalPlusLookInformations,_id);
         this.defender.deserializeAsync(this._defendertree);
      }
   }
}
