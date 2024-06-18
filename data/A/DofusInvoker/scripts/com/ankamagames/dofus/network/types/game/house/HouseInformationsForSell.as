package com.ankamagames.dofus.network.types.game.house
{
   import com.ankamagames.dofus.network.types.common.AccountTagInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class HouseInformationsForSell implements INetworkType
   {
      
      public static const protocolId:uint = 6977;
       
      
      public var instanceId:uint = 0;
      
      public var secondHand:Boolean = false;
      
      public var modelId:uint = 0;
      
      public var ownerTag:AccountTagInformation;
      
      public var hasOwner:Boolean = false;
      
      public var ownerCharacterName:String = "";
      
      public var worldX:int = 0;
      
      public var worldY:int = 0;
      
      public var subAreaId:uint = 0;
      
      public var nbRoom:int = 0;
      
      public var nbChest:int = 0;
      
      public var skillListIds:Vector.<int>;
      
      public var isLocked:Boolean = false;
      
      public var price:Number = 0;
      
      private var _ownerTagtree:FuncTree;
      
      private var _skillListIdstree:FuncTree;
      
      public function HouseInformationsForSell()
      {
         this.ownerTag = new AccountTagInformation();
         this.skillListIds = new Vector.<int>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 6977;
      }
      
      public function initHouseInformationsForSell(instanceId:uint = 0, secondHand:Boolean = false, modelId:uint = 0, ownerTag:AccountTagInformation = null, hasOwner:Boolean = false, ownerCharacterName:String = "", worldX:int = 0, worldY:int = 0, subAreaId:uint = 0, nbRoom:int = 0, nbChest:int = 0, skillListIds:Vector.<int> = null, isLocked:Boolean = false, price:Number = 0) : HouseInformationsForSell
      {
         this.instanceId = instanceId;
         this.secondHand = secondHand;
         this.modelId = modelId;
         this.ownerTag = ownerTag;
         this.hasOwner = hasOwner;
         this.ownerCharacterName = ownerCharacterName;
         this.worldX = worldX;
         this.worldY = worldY;
         this.subAreaId = subAreaId;
         this.nbRoom = nbRoom;
         this.nbChest = nbChest;
         this.skillListIds = skillListIds;
         this.isLocked = isLocked;
         this.price = price;
         return this;
      }
      
      public function reset() : void
      {
         this.instanceId = 0;
         this.secondHand = false;
         this.modelId = 0;
         this.ownerTag = new AccountTagInformation();
         this.ownerCharacterName = "";
         this.worldX = 0;
         this.worldY = 0;
         this.subAreaId = 0;
         this.nbRoom = 0;
         this.nbChest = 0;
         this.skillListIds = new Vector.<int>();
         this.isLocked = false;
         this.price = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_HouseInformationsForSell(output);
      }
      
      public function serializeAs_HouseInformationsForSell(output:ICustomDataOutput) : void
      {
         if(this.instanceId < 0)
         {
            throw new Error("Forbidden value (" + this.instanceId + ") on element instanceId.");
         }
         output.writeInt(this.instanceId);
         output.writeBoolean(this.secondHand);
         if(this.modelId < 0)
         {
            throw new Error("Forbidden value (" + this.modelId + ") on element modelId.");
         }
         output.writeVarInt(this.modelId);
         this.ownerTag.serializeAs_AccountTagInformation(output);
         output.writeBoolean(this.hasOwner);
         output.writeUTF(this.ownerCharacterName);
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element worldX.");
         }
         output.writeShort(this.worldX);
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element worldY.");
         }
         output.writeShort(this.worldY);
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element subAreaId.");
         }
         output.writeVarShort(this.subAreaId);
         output.writeByte(this.nbRoom);
         output.writeByte(this.nbChest);
         output.writeShort(this.skillListIds.length);
         for(var _i12:uint = 0; _i12 < this.skillListIds.length; _i12++)
         {
            output.writeInt(this.skillListIds[_i12]);
         }
         output.writeBoolean(this.isLocked);
         if(this.price < 0 || this.price > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.price + ") on element price.");
         }
         output.writeVarLong(this.price);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HouseInformationsForSell(input);
      }
      
      public function deserializeAs_HouseInformationsForSell(input:ICustomDataInput) : void
      {
         var _val12:int = 0;
         this._instanceIdFunc(input);
         this._secondHandFunc(input);
         this._modelIdFunc(input);
         this.ownerTag = new AccountTagInformation();
         this.ownerTag.deserialize(input);
         this._hasOwnerFunc(input);
         this._ownerCharacterNameFunc(input);
         this._worldXFunc(input);
         this._worldYFunc(input);
         this._subAreaIdFunc(input);
         this._nbRoomFunc(input);
         this._nbChestFunc(input);
         var _skillListIdsLen:uint = input.readUnsignedShort();
         for(var _i12:uint = 0; _i12 < _skillListIdsLen; _i12++)
         {
            _val12 = input.readInt();
            this.skillListIds.push(_val12);
         }
         this._isLockedFunc(input);
         this._priceFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HouseInformationsForSell(tree);
      }
      
      public function deserializeAsyncAs_HouseInformationsForSell(tree:FuncTree) : void
      {
         tree.addChild(this._instanceIdFunc);
         tree.addChild(this._secondHandFunc);
         tree.addChild(this._modelIdFunc);
         this._ownerTagtree = tree.addChild(this._ownerTagtreeFunc);
         tree.addChild(this._hasOwnerFunc);
         tree.addChild(this._ownerCharacterNameFunc);
         tree.addChild(this._worldXFunc);
         tree.addChild(this._worldYFunc);
         tree.addChild(this._subAreaIdFunc);
         tree.addChild(this._nbRoomFunc);
         tree.addChild(this._nbChestFunc);
         this._skillListIdstree = tree.addChild(this._skillListIdstreeFunc);
         tree.addChild(this._isLockedFunc);
         tree.addChild(this._priceFunc);
      }
      
      private function _instanceIdFunc(input:ICustomDataInput) : void
      {
         this.instanceId = input.readInt();
         if(this.instanceId < 0)
         {
            throw new Error("Forbidden value (" + this.instanceId + ") on element of HouseInformationsForSell.instanceId.");
         }
      }
      
      private function _secondHandFunc(input:ICustomDataInput) : void
      {
         this.secondHand = input.readBoolean();
      }
      
      private function _modelIdFunc(input:ICustomDataInput) : void
      {
         this.modelId = input.readVarUhInt();
         if(this.modelId < 0)
         {
            throw new Error("Forbidden value (" + this.modelId + ") on element of HouseInformationsForSell.modelId.");
         }
      }
      
      private function _ownerTagtreeFunc(input:ICustomDataInput) : void
      {
         this.ownerTag = new AccountTagInformation();
         this.ownerTag.deserializeAsync(this._ownerTagtree);
      }
      
      private function _hasOwnerFunc(input:ICustomDataInput) : void
      {
         this.hasOwner = input.readBoolean();
      }
      
      private function _ownerCharacterNameFunc(input:ICustomDataInput) : void
      {
         this.ownerCharacterName = input.readUTF();
      }
      
      private function _worldXFunc(input:ICustomDataInput) : void
      {
         this.worldX = input.readShort();
         if(this.worldX < -255 || this.worldX > 255)
         {
            throw new Error("Forbidden value (" + this.worldX + ") on element of HouseInformationsForSell.worldX.");
         }
      }
      
      private function _worldYFunc(input:ICustomDataInput) : void
      {
         this.worldY = input.readShort();
         if(this.worldY < -255 || this.worldY > 255)
         {
            throw new Error("Forbidden value (" + this.worldY + ") on element of HouseInformationsForSell.worldY.");
         }
      }
      
      private function _subAreaIdFunc(input:ICustomDataInput) : void
      {
         this.subAreaId = input.readVarUhShort();
         if(this.subAreaId < 0)
         {
            throw new Error("Forbidden value (" + this.subAreaId + ") on element of HouseInformationsForSell.subAreaId.");
         }
      }
      
      private function _nbRoomFunc(input:ICustomDataInput) : void
      {
         this.nbRoom = input.readByte();
      }
      
      private function _nbChestFunc(input:ICustomDataInput) : void
      {
         this.nbChest = input.readByte();
      }
      
      private function _skillListIdstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._skillListIdstree.addChild(this._skillListIdsFunc);
         }
      }
      
      private function _skillListIdsFunc(input:ICustomDataInput) : void
      {
         var _val:int = input.readInt();
         this.skillListIds.push(_val);
      }
      
      private function _isLockedFunc(input:ICustomDataInput) : void
      {
         this.isLocked = input.readBoolean();
      }
      
      private function _priceFunc(input:ICustomDataInput) : void
      {
         this.price = input.readVarUhLong();
         if(this.price < 0 || this.price > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.price + ") on element of HouseInformationsForSell.price.");
         }
      }
   }
}
