package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ObjectItemToSellInHumanVendorShop extends Item implements INetworkType
   {
      
      public static const protocolId:uint = 8803;
       
      
      public var objectGID:uint = 0;
      
      public var effects:Vector.<ObjectEffect>;
      
      public var objectUID:uint = 0;
      
      public var quantity:uint = 0;
      
      public var objectPrice:Number = 0;
      
      public var publicPrice:Number = 0;
      
      private var _effectstree:FuncTree;
      
      public function ObjectItemToSellInHumanVendorShop()
      {
         this.effects = new Vector.<ObjectEffect>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8803;
      }
      
      public function initObjectItemToSellInHumanVendorShop(objectGID:uint = 0, effects:Vector.<ObjectEffect> = null, objectUID:uint = 0, quantity:uint = 0, objectPrice:Number = 0, publicPrice:Number = 0) : ObjectItemToSellInHumanVendorShop
      {
         this.objectGID = objectGID;
         this.effects = effects;
         this.objectUID = objectUID;
         this.quantity = quantity;
         this.objectPrice = objectPrice;
         this.publicPrice = publicPrice;
         return this;
      }
      
      override public function reset() : void
      {
         this.objectGID = 0;
         this.effects = new Vector.<ObjectEffect>();
         this.objectUID = 0;
         this.quantity = 0;
         this.objectPrice = 0;
         this.publicPrice = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectItemToSellInHumanVendorShop(output);
      }
      
      public function serializeAs_ObjectItemToSellInHumanVendorShop(output:ICustomDataOutput) : void
      {
         super.serializeAs_Item(output);
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element objectGID.");
         }
         output.writeVarInt(this.objectGID);
         output.writeShort(this.effects.length);
         for(var _i2:uint = 0; _i2 < this.effects.length; _i2++)
         {
            output.writeShort((this.effects[_i2] as ObjectEffect).getTypeId());
            (this.effects[_i2] as ObjectEffect).serialize(output);
         }
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element objectUID.");
         }
         output.writeVarInt(this.objectUID);
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element quantity.");
         }
         output.writeVarInt(this.quantity);
         if(this.objectPrice < 0 || this.objectPrice > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.objectPrice + ") on element objectPrice.");
         }
         output.writeVarLong(this.objectPrice);
         if(this.publicPrice < 0 || this.publicPrice > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.publicPrice + ") on element publicPrice.");
         }
         output.writeVarLong(this.publicPrice);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectItemToSellInHumanVendorShop(input);
      }
      
      public function deserializeAs_ObjectItemToSellInHumanVendorShop(input:ICustomDataInput) : void
      {
         var _id2:uint = 0;
         var _item2:ObjectEffect = null;
         super.deserialize(input);
         this._objectGIDFunc(input);
         var _effectsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _effectsLen; _i2++)
         {
            _id2 = input.readUnsignedShort();
            _item2 = ProtocolTypeManager.getInstance(ObjectEffect,_id2);
            _item2.deserialize(input);
            this.effects.push(_item2);
         }
         this._objectUIDFunc(input);
         this._quantityFunc(input);
         this._objectPriceFunc(input);
         this._publicPriceFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectItemToSellInHumanVendorShop(tree);
      }
      
      public function deserializeAsyncAs_ObjectItemToSellInHumanVendorShop(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._objectGIDFunc);
         this._effectstree = tree.addChild(this._effectstreeFunc);
         tree.addChild(this._objectUIDFunc);
         tree.addChild(this._quantityFunc);
         tree.addChild(this._objectPriceFunc);
         tree.addChild(this._publicPriceFunc);
      }
      
      private function _objectGIDFunc(input:ICustomDataInput) : void
      {
         this.objectGID = input.readVarUhInt();
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element of ObjectItemToSellInHumanVendorShop.objectGID.");
         }
      }
      
      private function _effectstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._effectstree.addChild(this._effectsFunc);
         }
      }
      
      private function _effectsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:ObjectEffect = ProtocolTypeManager.getInstance(ObjectEffect,_id);
         _item.deserialize(input);
         this.effects.push(_item);
      }
      
      private function _objectUIDFunc(input:ICustomDataInput) : void
      {
         this.objectUID = input.readVarUhInt();
         if(this.objectUID < 0)
         {
            throw new Error("Forbidden value (" + this.objectUID + ") on element of ObjectItemToSellInHumanVendorShop.objectUID.");
         }
      }
      
      private function _quantityFunc(input:ICustomDataInput) : void
      {
         this.quantity = input.readVarUhInt();
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element of ObjectItemToSellInHumanVendorShop.quantity.");
         }
      }
      
      private function _objectPriceFunc(input:ICustomDataInput) : void
      {
         this.objectPrice = input.readVarUhLong();
         if(this.objectPrice < 0 || this.objectPrice > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.objectPrice + ") on element of ObjectItemToSellInHumanVendorShop.objectPrice.");
         }
      }
      
      private function _publicPriceFunc(input:ICustomDataInput) : void
      {
         this.publicPrice = input.readVarUhLong();
         if(this.publicPrice < 0 || this.publicPrice > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.publicPrice + ") on element of ObjectItemToSellInHumanVendorShop.publicPrice.");
         }
      }
   }
}
