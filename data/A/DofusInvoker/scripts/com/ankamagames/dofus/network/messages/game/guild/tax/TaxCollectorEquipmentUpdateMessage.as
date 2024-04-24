package com.ankamagames.dofus.network.messages.game.guild.tax
{
   import com.ankamagames.dofus.network.types.game.character.characteristic.CharacterCharacteristics;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class TaxCollectorEquipmentUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6675;
       
      
      private var _isInitialized:Boolean = false;
      
      public var uniqueId:Number = 0;
      
      public var object:ObjectItem;
      
      public var added:Boolean = false;
      
      public var characteristics:CharacterCharacteristics;
      
      private var _objecttree:FuncTree;
      
      private var _characteristicstree:FuncTree;
      
      public function TaxCollectorEquipmentUpdateMessage()
      {
         this.object = new ObjectItem();
         this.characteristics = new CharacterCharacteristics();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6675;
      }
      
      public function initTaxCollectorEquipmentUpdateMessage(uniqueId:Number = 0, object:ObjectItem = null, added:Boolean = false, characteristics:CharacterCharacteristics = null) : TaxCollectorEquipmentUpdateMessage
      {
         this.uniqueId = uniqueId;
         this.object = object;
         this.added = added;
         this.characteristics = characteristics;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.uniqueId = 0;
         this.object = new ObjectItem();
         this.characteristics = new CharacterCharacteristics();
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
         this.serializeAs_TaxCollectorEquipmentUpdateMessage(output);
      }
      
      public function serializeAs_TaxCollectorEquipmentUpdateMessage(output:ICustomDataOutput) : void
      {
         if(this.uniqueId < 0 || this.uniqueId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.uniqueId + ") on element uniqueId.");
         }
         output.writeDouble(this.uniqueId);
         this.object.serializeAs_ObjectItem(output);
         output.writeBoolean(this.added);
         this.characteristics.serializeAs_CharacterCharacteristics(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorEquipmentUpdateMessage(input);
      }
      
      public function deserializeAs_TaxCollectorEquipmentUpdateMessage(input:ICustomDataInput) : void
      {
         this._uniqueIdFunc(input);
         this.object = new ObjectItem();
         this.object.deserialize(input);
         this._addedFunc(input);
         this.characteristics = new CharacterCharacteristics();
         this.characteristics.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorEquipmentUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorEquipmentUpdateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._uniqueIdFunc);
         this._objecttree = tree.addChild(this._objecttreeFunc);
         tree.addChild(this._addedFunc);
         this._characteristicstree = tree.addChild(this._characteristicstreeFunc);
      }
      
      private function _uniqueIdFunc(input:ICustomDataInput) : void
      {
         this.uniqueId = input.readDouble();
         if(this.uniqueId < 0 || this.uniqueId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.uniqueId + ") on element of TaxCollectorEquipmentUpdateMessage.uniqueId.");
         }
      }
      
      private function _objecttreeFunc(input:ICustomDataInput) : void
      {
         this.object = new ObjectItem();
         this.object.deserializeAsync(this._objecttree);
      }
      
      private function _addedFunc(input:ICustomDataInput) : void
      {
         this.added = input.readBoolean();
      }
      
      private function _characteristicstreeFunc(input:ICustomDataInput) : void
      {
         this.characteristics = new CharacterCharacteristics();
         this.characteristics.deserializeAsync(this._characteristicstree);
      }
   }
}
