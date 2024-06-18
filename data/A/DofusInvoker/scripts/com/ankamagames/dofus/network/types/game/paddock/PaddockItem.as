package com.ankamagames.dofus.network.types.game.paddock
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.ObjectItemInRolePlay;
   import com.ankamagames.dofus.network.types.game.mount.ItemDurability;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class PaddockItem extends ObjectItemInRolePlay implements INetworkType
   {
      
      public static const protocolId:uint = 2373;
       
      
      public var durability:ItemDurability;
      
      private var _durabilitytree:FuncTree;
      
      public function PaddockItem()
      {
         this.durability = new ItemDurability();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 2373;
      }
      
      public function initPaddockItem(cellId:uint = 0, objectGID:uint = 0, durability:ItemDurability = null) : PaddockItem
      {
         super.initObjectItemInRolePlay(cellId,objectGID);
         this.durability = durability;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.durability = new ItemDurability();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_PaddockItem(output);
      }
      
      public function serializeAs_PaddockItem(output:ICustomDataOutput) : void
      {
         super.serializeAs_ObjectItemInRolePlay(output);
         this.durability.serializeAs_ItemDurability(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PaddockItem(input);
      }
      
      public function deserializeAs_PaddockItem(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.durability = new ItemDurability();
         this.durability.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PaddockItem(tree);
      }
      
      public function deserializeAsyncAs_PaddockItem(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._durabilitytree = tree.addChild(this._durabilitytreeFunc);
      }
      
      private function _durabilitytreeFunc(input:ICustomDataInput) : void
      {
         this.durability = new ItemDurability();
         this.durability.deserializeAsync(this._durabilitytree);
      }
   }
}
