package com.ankamagames.dofus.network.messages.game.inventory.exchanges
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.mount.UpdateMountCharacteristic;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class UpdateMountCharacteristicsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1346;
       
      
      private var _isInitialized:Boolean = false;
      
      public var rideId:int = 0;
      
      public var boostToUpdateList:Vector.<UpdateMountCharacteristic>;
      
      private var _boostToUpdateListtree:FuncTree;
      
      public function UpdateMountCharacteristicsMessage()
      {
         this.boostToUpdateList = new Vector.<UpdateMountCharacteristic>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1346;
      }
      
      public function initUpdateMountCharacteristicsMessage(rideId:int = 0, boostToUpdateList:Vector.<UpdateMountCharacteristic> = null) : UpdateMountCharacteristicsMessage
      {
         this.rideId = rideId;
         this.boostToUpdateList = boostToUpdateList;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.rideId = 0;
         this.boostToUpdateList = new Vector.<UpdateMountCharacteristic>();
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
         this.serializeAs_UpdateMountCharacteristicsMessage(output);
      }
      
      public function serializeAs_UpdateMountCharacteristicsMessage(output:ICustomDataOutput) : void
      {
         output.writeVarInt(this.rideId);
         output.writeShort(this.boostToUpdateList.length);
         for(var _i2:uint = 0; _i2 < this.boostToUpdateList.length; _i2++)
         {
            output.writeShort((this.boostToUpdateList[_i2] as UpdateMountCharacteristic).getTypeId());
            (this.boostToUpdateList[_i2] as UpdateMountCharacteristic).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_UpdateMountCharacteristicsMessage(input);
      }
      
      public function deserializeAs_UpdateMountCharacteristicsMessage(input:ICustomDataInput) : void
      {
         var _id2:uint = 0;
         var _item2:UpdateMountCharacteristic = null;
         this._rideIdFunc(input);
         var _boostToUpdateListLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _boostToUpdateListLen; _i2++)
         {
            _id2 = input.readUnsignedShort();
            _item2 = ProtocolTypeManager.getInstance(UpdateMountCharacteristic,_id2);
            _item2.deserialize(input);
            this.boostToUpdateList.push(_item2);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_UpdateMountCharacteristicsMessage(tree);
      }
      
      public function deserializeAsyncAs_UpdateMountCharacteristicsMessage(tree:FuncTree) : void
      {
         tree.addChild(this._rideIdFunc);
         this._boostToUpdateListtree = tree.addChild(this._boostToUpdateListtreeFunc);
      }
      
      private function _rideIdFunc(input:ICustomDataInput) : void
      {
         this.rideId = input.readVarInt();
      }
      
      private function _boostToUpdateListtreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._boostToUpdateListtree.addChild(this._boostToUpdateListFunc);
         }
      }
      
      private function _boostToUpdateListFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:UpdateMountCharacteristic = ProtocolTypeManager.getInstance(UpdateMountCharacteristic,_id);
         _item.deserialize(input);
         this.boostToUpdateList.push(_item);
      }
   }
}
