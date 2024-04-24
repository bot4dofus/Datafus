package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.house.HouseInstanceInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HousePropertiesMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8534;
       
      
      private var _isInitialized:Boolean = false;
      
      public var houseId:uint = 0;
      
      public var doorsOnMap:Vector.<uint>;
      
      public var properties:HouseInstanceInformations;
      
      private var _doorsOnMaptree:FuncTree;
      
      private var _propertiestree:FuncTree;
      
      public function HousePropertiesMessage()
      {
         this.doorsOnMap = new Vector.<uint>();
         this.properties = new HouseInstanceInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8534;
      }
      
      public function initHousePropertiesMessage(houseId:uint = 0, doorsOnMap:Vector.<uint> = null, properties:HouseInstanceInformations = null) : HousePropertiesMessage
      {
         this.houseId = houseId;
         this.doorsOnMap = doorsOnMap;
         this.properties = properties;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.houseId = 0;
         this.doorsOnMap = new Vector.<uint>();
         this.properties = new HouseInstanceInformations();
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
         this.serializeAs_HousePropertiesMessage(output);
      }
      
      public function serializeAs_HousePropertiesMessage(output:ICustomDataOutput) : void
      {
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element houseId.");
         }
         output.writeVarInt(this.houseId);
         output.writeShort(this.doorsOnMap.length);
         for(var _i2:uint = 0; _i2 < this.doorsOnMap.length; _i2++)
         {
            if(this.doorsOnMap[_i2] < 0)
            {
               throw new Error("Forbidden value (" + this.doorsOnMap[_i2] + ") on element 2 (starting at 1) of doorsOnMap.");
            }
            output.writeInt(this.doorsOnMap[_i2]);
         }
         output.writeShort(this.properties.getTypeId());
         this.properties.serialize(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HousePropertiesMessage(input);
      }
      
      public function deserializeAs_HousePropertiesMessage(input:ICustomDataInput) : void
      {
         var _val2:uint = 0;
         this._houseIdFunc(input);
         var _doorsOnMapLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _doorsOnMapLen; _i2++)
         {
            _val2 = input.readInt();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of doorsOnMap.");
            }
            this.doorsOnMap.push(_val2);
         }
         var _id3:uint = input.readUnsignedShort();
         this.properties = ProtocolTypeManager.getInstance(HouseInstanceInformations,_id3);
         this.properties.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HousePropertiesMessage(tree);
      }
      
      public function deserializeAsyncAs_HousePropertiesMessage(tree:FuncTree) : void
      {
         tree.addChild(this._houseIdFunc);
         this._doorsOnMaptree = tree.addChild(this._doorsOnMaptreeFunc);
         this._propertiestree = tree.addChild(this._propertiestreeFunc);
      }
      
      private function _houseIdFunc(input:ICustomDataInput) : void
      {
         this.houseId = input.readVarUhInt();
         if(this.houseId < 0)
         {
            throw new Error("Forbidden value (" + this.houseId + ") on element of HousePropertiesMessage.houseId.");
         }
      }
      
      private function _doorsOnMaptreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._doorsOnMaptree.addChild(this._doorsOnMapFunc);
         }
      }
      
      private function _doorsOnMapFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readInt();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of doorsOnMap.");
         }
         this.doorsOnMap.push(_val);
      }
      
      private function _propertiestreeFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         this.properties = ProtocolTypeManager.getInstance(HouseInstanceInformations,_id);
         this.properties.deserializeAsync(this._propertiestree);
      }
   }
}
