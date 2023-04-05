package com.ankamagames.dofus.network.types.game.startup
{
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemInformationWithQuantity;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class StartupActionAddObject implements INetworkType
   {
      
      public static const protocolId:uint = 9542;
       
      
      public var uid:uint = 0;
      
      public var title:String = "";
      
      public var text:String = "";
      
      public var descUrl:String = "";
      
      public var pictureUrl:String = "";
      
      public var items:Vector.<ObjectItemInformationWithQuantity>;
      
      public var type:uint = 1;
      
      private var _itemstree:FuncTree;
      
      public function StartupActionAddObject()
      {
         this.items = new Vector.<ObjectItemInformationWithQuantity>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 9542;
      }
      
      public function initStartupActionAddObject(uid:uint = 0, title:String = "", text:String = "", descUrl:String = "", pictureUrl:String = "", items:Vector.<ObjectItemInformationWithQuantity> = null, type:uint = 1) : StartupActionAddObject
      {
         this.uid = uid;
         this.title = title;
         this.text = text;
         this.descUrl = descUrl;
         this.pictureUrl = pictureUrl;
         this.items = items;
         this.type = type;
         return this;
      }
      
      public function reset() : void
      {
         this.uid = 0;
         this.title = "";
         this.text = "";
         this.descUrl = "";
         this.pictureUrl = "";
         this.items = new Vector.<ObjectItemInformationWithQuantity>();
         this.type = 1;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_StartupActionAddObject(output);
      }
      
      public function serializeAs_StartupActionAddObject(output:ICustomDataOutput) : void
      {
         if(this.uid < 0)
         {
            throw new Error("Forbidden value (" + this.uid + ") on element uid.");
         }
         output.writeInt(this.uid);
         output.writeUTF(this.title);
         output.writeUTF(this.text);
         output.writeUTF(this.descUrl);
         output.writeUTF(this.pictureUrl);
         output.writeShort(this.items.length);
         for(var _i6:uint = 0; _i6 < this.items.length; _i6++)
         {
            (this.items[_i6] as ObjectItemInformationWithQuantity).serializeAs_ObjectItemInformationWithQuantity(output);
         }
         output.writeVarInt(this.type);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_StartupActionAddObject(input);
      }
      
      public function deserializeAs_StartupActionAddObject(input:ICustomDataInput) : void
      {
         var _item6:ObjectItemInformationWithQuantity = null;
         this._uidFunc(input);
         this._titleFunc(input);
         this._textFunc(input);
         this._descUrlFunc(input);
         this._pictureUrlFunc(input);
         var _itemsLen:uint = input.readUnsignedShort();
         for(var _i6:uint = 0; _i6 < _itemsLen; _i6++)
         {
            _item6 = new ObjectItemInformationWithQuantity();
            _item6.deserialize(input);
            this.items.push(_item6);
         }
         this._typeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_StartupActionAddObject(tree);
      }
      
      public function deserializeAsyncAs_StartupActionAddObject(tree:FuncTree) : void
      {
         tree.addChild(this._uidFunc);
         tree.addChild(this._titleFunc);
         tree.addChild(this._textFunc);
         tree.addChild(this._descUrlFunc);
         tree.addChild(this._pictureUrlFunc);
         this._itemstree = tree.addChild(this._itemstreeFunc);
         tree.addChild(this._typeFunc);
      }
      
      private function _uidFunc(input:ICustomDataInput) : void
      {
         this.uid = input.readInt();
         if(this.uid < 0)
         {
            throw new Error("Forbidden value (" + this.uid + ") on element of StartupActionAddObject.uid.");
         }
      }
      
      private function _titleFunc(input:ICustomDataInput) : void
      {
         this.title = input.readUTF();
      }
      
      private function _textFunc(input:ICustomDataInput) : void
      {
         this.text = input.readUTF();
      }
      
      private function _descUrlFunc(input:ICustomDataInput) : void
      {
         this.descUrl = input.readUTF();
      }
      
      private function _pictureUrlFunc(input:ICustomDataInput) : void
      {
         this.pictureUrl = input.readUTF();
      }
      
      private function _itemstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._itemstree.addChild(this._itemsFunc);
         }
      }
      
      private function _itemsFunc(input:ICustomDataInput) : void
      {
         var _item:ObjectItemInformationWithQuantity = new ObjectItemInformationWithQuantity();
         _item.deserialize(input);
         this.items.push(_item);
      }
      
      private function _typeFunc(input:ICustomDataInput) : void
      {
         this.type = input.readVarUhInt();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of StartupActionAddObject.type.");
         }
      }
   }
}
