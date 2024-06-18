package com.ankamagames.dofus.network.types.game.presets
{
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ItemsPreset extends Preset implements INetworkType
   {
      
      public static const protocolId:uint = 4783;
       
      
      public var items:Vector.<ItemForPreset>;
      
      public var mountEquipped:Boolean = false;
      
      public var look:EntityLook;
      
      private var _itemstree:FuncTree;
      
      private var _looktree:FuncTree;
      
      public function ItemsPreset()
      {
         this.items = new Vector.<ItemForPreset>();
         this.look = new EntityLook();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 4783;
      }
      
      public function initItemsPreset(id:int = 0, items:Vector.<ItemForPreset> = null, mountEquipped:Boolean = false, look:EntityLook = null) : ItemsPreset
      {
         super.initPreset(id);
         this.items = items;
         this.mountEquipped = mountEquipped;
         this.look = look;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.items = new Vector.<ItemForPreset>();
         this.mountEquipped = false;
         this.look = new EntityLook();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ItemsPreset(output);
      }
      
      public function serializeAs_ItemsPreset(output:ICustomDataOutput) : void
      {
         super.serializeAs_Preset(output);
         output.writeShort(this.items.length);
         for(var _i1:uint = 0; _i1 < this.items.length; _i1++)
         {
            (this.items[_i1] as ItemForPreset).serializeAs_ItemForPreset(output);
         }
         output.writeBoolean(this.mountEquipped);
         this.look.serializeAs_EntityLook(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ItemsPreset(input);
      }
      
      public function deserializeAs_ItemsPreset(input:ICustomDataInput) : void
      {
         var _item1:ItemForPreset = null;
         super.deserialize(input);
         var _itemsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _itemsLen; _i1++)
         {
            _item1 = new ItemForPreset();
            _item1.deserialize(input);
            this.items.push(_item1);
         }
         this._mountEquippedFunc(input);
         this.look = new EntityLook();
         this.look.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ItemsPreset(tree);
      }
      
      public function deserializeAsyncAs_ItemsPreset(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._itemstree = tree.addChild(this._itemstreeFunc);
         tree.addChild(this._mountEquippedFunc);
         this._looktree = tree.addChild(this._looktreeFunc);
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
         var _item:ItemForPreset = new ItemForPreset();
         _item.deserialize(input);
         this.items.push(_item);
      }
      
      private function _mountEquippedFunc(input:ICustomDataInput) : void
      {
         this.mountEquipped = input.readBoolean();
      }
      
      private function _looktreeFunc(input:ICustomDataInput) : void
      {
         this.look = new EntityLook();
         this.look.deserializeAsync(this._looktree);
      }
   }
}
