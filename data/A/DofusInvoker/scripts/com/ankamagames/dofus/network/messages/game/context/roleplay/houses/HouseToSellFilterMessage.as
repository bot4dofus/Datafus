package com.ankamagames.dofus.network.messages.game.context.roleplay.houses
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HouseToSellFilterMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9188;
       
      
      private var _isInitialized:Boolean = false;
      
      public var areaId:int = 0;
      
      public var atLeastNbRoom:uint = 0;
      
      public var atLeastNbChest:uint = 0;
      
      public var skillRequested:uint = 0;
      
      public var maxPrice:Number = 0;
      
      public var orderBy:uint = 0;
      
      public function HouseToSellFilterMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9188;
      }
      
      public function initHouseToSellFilterMessage(areaId:int = 0, atLeastNbRoom:uint = 0, atLeastNbChest:uint = 0, skillRequested:uint = 0, maxPrice:Number = 0, orderBy:uint = 0) : HouseToSellFilterMessage
      {
         this.areaId = areaId;
         this.atLeastNbRoom = atLeastNbRoom;
         this.atLeastNbChest = atLeastNbChest;
         this.skillRequested = skillRequested;
         this.maxPrice = maxPrice;
         this.orderBy = orderBy;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.areaId = 0;
         this.atLeastNbRoom = 0;
         this.atLeastNbChest = 0;
         this.skillRequested = 0;
         this.maxPrice = 0;
         this.orderBy = 0;
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
         this.serializeAs_HouseToSellFilterMessage(output);
      }
      
      public function serializeAs_HouseToSellFilterMessage(output:ICustomDataOutput) : void
      {
         output.writeInt(this.areaId);
         if(this.atLeastNbRoom < 0)
         {
            throw new Error("Forbidden value (" + this.atLeastNbRoom + ") on element atLeastNbRoom.");
         }
         output.writeByte(this.atLeastNbRoom);
         if(this.atLeastNbChest < 0)
         {
            throw new Error("Forbidden value (" + this.atLeastNbChest + ") on element atLeastNbChest.");
         }
         output.writeByte(this.atLeastNbChest);
         if(this.skillRequested < 0)
         {
            throw new Error("Forbidden value (" + this.skillRequested + ") on element skillRequested.");
         }
         output.writeVarShort(this.skillRequested);
         if(this.maxPrice < 0 || this.maxPrice > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.maxPrice + ") on element maxPrice.");
         }
         output.writeVarLong(this.maxPrice);
         output.writeByte(this.orderBy);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HouseToSellFilterMessage(input);
      }
      
      public function deserializeAs_HouseToSellFilterMessage(input:ICustomDataInput) : void
      {
         this._areaIdFunc(input);
         this._atLeastNbRoomFunc(input);
         this._atLeastNbChestFunc(input);
         this._skillRequestedFunc(input);
         this._maxPriceFunc(input);
         this._orderByFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HouseToSellFilterMessage(tree);
      }
      
      public function deserializeAsyncAs_HouseToSellFilterMessage(tree:FuncTree) : void
      {
         tree.addChild(this._areaIdFunc);
         tree.addChild(this._atLeastNbRoomFunc);
         tree.addChild(this._atLeastNbChestFunc);
         tree.addChild(this._skillRequestedFunc);
         tree.addChild(this._maxPriceFunc);
         tree.addChild(this._orderByFunc);
      }
      
      private function _areaIdFunc(input:ICustomDataInput) : void
      {
         this.areaId = input.readInt();
      }
      
      private function _atLeastNbRoomFunc(input:ICustomDataInput) : void
      {
         this.atLeastNbRoom = input.readByte();
         if(this.atLeastNbRoom < 0)
         {
            throw new Error("Forbidden value (" + this.atLeastNbRoom + ") on element of HouseToSellFilterMessage.atLeastNbRoom.");
         }
      }
      
      private function _atLeastNbChestFunc(input:ICustomDataInput) : void
      {
         this.atLeastNbChest = input.readByte();
         if(this.atLeastNbChest < 0)
         {
            throw new Error("Forbidden value (" + this.atLeastNbChest + ") on element of HouseToSellFilterMessage.atLeastNbChest.");
         }
      }
      
      private function _skillRequestedFunc(input:ICustomDataInput) : void
      {
         this.skillRequested = input.readVarUhShort();
         if(this.skillRequested < 0)
         {
            throw new Error("Forbidden value (" + this.skillRequested + ") on element of HouseToSellFilterMessage.skillRequested.");
         }
      }
      
      private function _maxPriceFunc(input:ICustomDataInput) : void
      {
         this.maxPrice = input.readVarUhLong();
         if(this.maxPrice < 0 || this.maxPrice > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.maxPrice + ") on element of HouseToSellFilterMessage.maxPrice.");
         }
      }
      
      private function _orderByFunc(input:ICustomDataInput) : void
      {
         this.orderBy = input.readByte();
         if(this.orderBy < 0)
         {
            throw new Error("Forbidden value (" + this.orderBy + ") on element of HouseToSellFilterMessage.orderBy.");
         }
      }
   }
}
