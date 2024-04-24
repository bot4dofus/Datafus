package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ObjectItem extends Item implements INetworkType
   {
      
      public static const protocolId:uint = 8371;
       
      
      public var position:uint = 63;
      
      public var objectGID:uint = 0;
      
      public var effects:Vector.<ObjectEffect>;
      
      public var objectUID:uint = 0;
      
      public var quantity:uint = 0;
      
      public var favorite:Boolean = false;
      
      private var _effectstree:FuncTree;
      
      public function ObjectItem()
      {
         this.effects = new Vector.<ObjectEffect>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8371;
      }
      
      public function initObjectItem(position:uint = 63, objectGID:uint = 0, effects:Vector.<ObjectEffect> = null, objectUID:uint = 0, quantity:uint = 0, favorite:Boolean = false) : ObjectItem
      {
         this.position = position;
         this.objectGID = objectGID;
         this.effects = effects;
         this.objectUID = objectUID;
         this.quantity = quantity;
         this.favorite = favorite;
         return this;
      }
      
      override public function reset() : void
      {
         this.position = 63;
         this.objectGID = 0;
         this.effects = new Vector.<ObjectEffect>();
         this.objectUID = 0;
         this.quantity = 0;
         this.favorite = false;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectItem(output);
      }
      
      public function serializeAs_ObjectItem(output:ICustomDataOutput) : void
      {
         super.serializeAs_Item(output);
         output.writeShort(this.position);
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element objectGID.");
         }
         output.writeVarInt(this.objectGID);
         output.writeShort(this.effects.length);
         for(var _i3:uint = 0; _i3 < this.effects.length; _i3++)
         {
            output.writeShort((this.effects[_i3] as ObjectEffect).getTypeId());
            (this.effects[_i3] as ObjectEffect).serialize(output);
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
         output.writeBoolean(this.favorite);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectItem(input);
      }
      
      public function deserializeAs_ObjectItem(input:ICustomDataInput) : void
      {
         var _id3:uint = 0;
         var _item3:ObjectEffect = null;
         super.deserialize(input);
         this._positionFunc(input);
         this._objectGIDFunc(input);
         var _effectsLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _effectsLen; _i3++)
         {
            _id3 = input.readUnsignedShort();
            _item3 = ProtocolTypeManager.getInstance(ObjectEffect,_id3);
            _item3.deserialize(input);
            this.effects.push(_item3);
         }
         this._objectUIDFunc(input);
         this._quantityFunc(input);
         this._favoriteFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectItem(tree);
      }
      
      public function deserializeAsyncAs_ObjectItem(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._positionFunc);
         tree.addChild(this._objectGIDFunc);
         this._effectstree = tree.addChild(this._effectstreeFunc);
         tree.addChild(this._objectUIDFunc);
         tree.addChild(this._quantityFunc);
         tree.addChild(this._favoriteFunc);
      }
      
      private function _positionFunc(input:ICustomDataInput) : void
      {
         this.position = input.readShort();
         if(this.position < 0)
         {
            throw new Error("Forbidden value (" + this.position + ") on element of ObjectItem.position.");
         }
      }
      
      private function _objectGIDFunc(input:ICustomDataInput) : void
      {
         this.objectGID = input.readVarUhInt();
         if(this.objectGID < 0)
         {
            throw new Error("Forbidden value (" + this.objectGID + ") on element of ObjectItem.objectGID.");
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
            throw new Error("Forbidden value (" + this.objectUID + ") on element of ObjectItem.objectUID.");
         }
      }
      
      private function _quantityFunc(input:ICustomDataInput) : void
      {
         this.quantity = input.readVarUhInt();
         if(this.quantity < 0)
         {
            throw new Error("Forbidden value (" + this.quantity + ") on element of ObjectItem.quantity.");
         }
      }
      
      private function _favoriteFunc(input:ICustomDataInput) : void
      {
         this.favorite = input.readBoolean();
      }
   }
}
