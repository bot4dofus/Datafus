package com.ankamagames.dofus.network.types.game.character.characteristic
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class CharacterCharacteristics implements INetworkType
   {
      
      public static const protocolId:uint = 7623;
       
      
      public var characteristics:Vector.<CharacterCharacteristic>;
      
      private var _characteristicstree:FuncTree;
      
      public function CharacterCharacteristics()
      {
         this.characteristics = new Vector.<CharacterCharacteristic>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 7623;
      }
      
      public function initCharacterCharacteristics(characteristics:Vector.<CharacterCharacteristic> = null) : CharacterCharacteristics
      {
         this.characteristics = characteristics;
         return this;
      }
      
      public function reset() : void
      {
         this.characteristics = new Vector.<CharacterCharacteristic>();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_CharacterCharacteristics(output);
      }
      
      public function serializeAs_CharacterCharacteristics(output:ICustomDataOutput) : void
      {
         output.writeShort(this.characteristics.length);
         for(var _i1:uint = 0; _i1 < this.characteristics.length; _i1++)
         {
            output.writeShort((this.characteristics[_i1] as CharacterCharacteristic).getTypeId());
            (this.characteristics[_i1] as CharacterCharacteristic).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_CharacterCharacteristics(input);
      }
      
      public function deserializeAs_CharacterCharacteristics(input:ICustomDataInput) : void
      {
         var _id1:uint = 0;
         var _item1:CharacterCharacteristic = null;
         var _characteristicsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _characteristicsLen; _i1++)
         {
            _id1 = input.readUnsignedShort();
            _item1 = ProtocolTypeManager.getInstance(CharacterCharacteristic,_id1);
            _item1.deserialize(input);
            this.characteristics.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_CharacterCharacteristics(tree);
      }
      
      public function deserializeAsyncAs_CharacterCharacteristics(tree:FuncTree) : void
      {
         this._characteristicstree = tree.addChild(this._characteristicstreeFunc);
      }
      
      private function _characteristicstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._characteristicstree.addChild(this._characteristicsFunc);
         }
      }
      
      private function _characteristicsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:CharacterCharacteristic = ProtocolTypeManager.getInstance(CharacterCharacteristic,_id);
         _item.deserialize(input);
         this.characteristics.push(_item);
      }
   }
}
