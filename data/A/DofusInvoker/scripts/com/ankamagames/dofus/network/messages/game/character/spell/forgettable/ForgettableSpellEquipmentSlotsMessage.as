package com.ankamagames.dofus.network.messages.game.character.spell.forgettable
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ForgettableSpellEquipmentSlotsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 891;
       
      
      private var _isInitialized:Boolean = false;
      
      public var quantity:int = 0;
      
      public function ForgettableSpellEquipmentSlotsMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 891;
      }
      
      public function initForgettableSpellEquipmentSlotsMessage(quantity:int = 0) : ForgettableSpellEquipmentSlotsMessage
      {
         this.quantity = quantity;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.quantity = 0;
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
         this.serializeAs_ForgettableSpellEquipmentSlotsMessage(output);
      }
      
      public function serializeAs_ForgettableSpellEquipmentSlotsMessage(output:ICustomDataOutput) : void
      {
         output.writeVarShort(this.quantity);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ForgettableSpellEquipmentSlotsMessage(input);
      }
      
      public function deserializeAs_ForgettableSpellEquipmentSlotsMessage(input:ICustomDataInput) : void
      {
         this._quantityFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ForgettableSpellEquipmentSlotsMessage(tree);
      }
      
      public function deserializeAsyncAs_ForgettableSpellEquipmentSlotsMessage(tree:FuncTree) : void
      {
         tree.addChild(this._quantityFunc);
      }
      
      private function _quantityFunc(input:ICustomDataInput) : void
      {
         this.quantity = input.readVarShort();
      }
   }
}
