package com.ankamagames.dofus.network.types.game.shortcut
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ShortcutObjectItem extends ShortcutObject implements INetworkType
   {
      
      public static const protocolId:uint = 2079;
       
      
      public var itemUID:int = 0;
      
      public var itemGID:int = 0;
      
      public function ShortcutObjectItem()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 2079;
      }
      
      public function initShortcutObjectItem(slot:uint = 0, itemUID:int = 0, itemGID:int = 0) : ShortcutObjectItem
      {
         super.initShortcutObject(slot);
         this.itemUID = itemUID;
         this.itemGID = itemGID;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.itemUID = 0;
         this.itemGID = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ShortcutObjectItem(output);
      }
      
      public function serializeAs_ShortcutObjectItem(output:ICustomDataOutput) : void
      {
         super.serializeAs_ShortcutObject(output);
         output.writeInt(this.itemUID);
         output.writeInt(this.itemGID);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ShortcutObjectItem(input);
      }
      
      public function deserializeAs_ShortcutObjectItem(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._itemUIDFunc(input);
         this._itemGIDFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ShortcutObjectItem(tree);
      }
      
      public function deserializeAsyncAs_ShortcutObjectItem(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._itemUIDFunc);
         tree.addChild(this._itemGIDFunc);
      }
      
      private function _itemUIDFunc(input:ICustomDataInput) : void
      {
         this.itemUID = input.readInt();
      }
      
      private function _itemGIDFunc(input:ICustomDataInput) : void
      {
         this.itemGID = input.readInt();
      }
   }
}
