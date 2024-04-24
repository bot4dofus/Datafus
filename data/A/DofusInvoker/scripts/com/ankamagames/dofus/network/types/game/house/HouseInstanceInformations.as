package com.ankamagames.dofus.network.types.game.house
{
   import com.ankamagames.dofus.network.types.common.AccountTagInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class HouseInstanceInformations implements INetworkType
   {
      
      public static const protocolId:uint = 3942;
       
      
      public var instanceId:uint = 0;
      
      public var secondHand:Boolean = false;
      
      public var isLocked:Boolean = false;
      
      public var ownerTag:AccountTagInformation;
      
      public var hasOwner:Boolean = false;
      
      public var price:Number = 0;
      
      public var isSaleLocked:Boolean = false;
      
      public var isAdminLocked:Boolean = false;
      
      private var _ownerTagtree:FuncTree;
      
      public function HouseInstanceInformations()
      {
         this.ownerTag = new AccountTagInformation();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 3942;
      }
      
      public function initHouseInstanceInformations(instanceId:uint = 0, secondHand:Boolean = false, isLocked:Boolean = false, ownerTag:AccountTagInformation = null, hasOwner:Boolean = false, price:Number = 0, isSaleLocked:Boolean = false, isAdminLocked:Boolean = false) : HouseInstanceInformations
      {
         this.instanceId = instanceId;
         this.secondHand = secondHand;
         this.isLocked = isLocked;
         this.ownerTag = ownerTag;
         this.hasOwner = hasOwner;
         this.price = price;
         this.isSaleLocked = isSaleLocked;
         this.isAdminLocked = isAdminLocked;
         return this;
      }
      
      public function reset() : void
      {
         this.instanceId = 0;
         this.secondHand = false;
         this.isLocked = false;
         this.ownerTag = new AccountTagInformation();
         this.price = 0;
         this.isSaleLocked = false;
         this.isAdminLocked = false;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_HouseInstanceInformations(output);
      }
      
      public function serializeAs_HouseInstanceInformations(output:ICustomDataOutput) : void
      {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.secondHand);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.isLocked);
         _box0 = BooleanByteWrapper.setFlag(_box0,2,this.hasOwner);
         _box0 = BooleanByteWrapper.setFlag(_box0,3,this.isSaleLocked);
         _box0 = BooleanByteWrapper.setFlag(_box0,4,this.isAdminLocked);
         output.writeByte(_box0);
         if(this.instanceId < 0)
         {
            throw new Error("Forbidden value (" + this.instanceId + ") on element instanceId.");
         }
         output.writeInt(this.instanceId);
         this.ownerTag.serializeAs_AccountTagInformation(output);
         if(this.price < -9007199254740992 || this.price > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.price + ") on element price.");
         }
         output.writeVarLong(this.price);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HouseInstanceInformations(input);
      }
      
      public function deserializeAs_HouseInstanceInformations(input:ICustomDataInput) : void
      {
         this.deserializeByteBoxes(input);
         this._instanceIdFunc(input);
         this.ownerTag = new AccountTagInformation();
         this.ownerTag.deserialize(input);
         this._priceFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HouseInstanceInformations(tree);
      }
      
      public function deserializeAsyncAs_HouseInstanceInformations(tree:FuncTree) : void
      {
         tree.addChild(this.deserializeByteBoxes);
         tree.addChild(this._instanceIdFunc);
         this._ownerTagtree = tree.addChild(this._ownerTagtreeFunc);
         tree.addChild(this._priceFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.secondHand = BooleanByteWrapper.getFlag(_box0,0);
         this.isLocked = BooleanByteWrapper.getFlag(_box0,1);
         this.hasOwner = BooleanByteWrapper.getFlag(_box0,2);
         this.isSaleLocked = BooleanByteWrapper.getFlag(_box0,3);
         this.isAdminLocked = BooleanByteWrapper.getFlag(_box0,4);
      }
      
      private function _instanceIdFunc(input:ICustomDataInput) : void
      {
         this.instanceId = input.readInt();
         if(this.instanceId < 0)
         {
            throw new Error("Forbidden value (" + this.instanceId + ") on element of HouseInstanceInformations.instanceId.");
         }
      }
      
      private function _ownerTagtreeFunc(input:ICustomDataInput) : void
      {
         this.ownerTag = new AccountTagInformation();
         this.ownerTag.deserializeAsync(this._ownerTagtree);
      }
      
      private function _priceFunc(input:ICustomDataInput) : void
      {
         this.price = input.readVarLong();
         if(this.price < -9007199254740992 || this.price > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.price + ") on element of HouseInstanceInformations.price.");
         }
      }
   }
}
