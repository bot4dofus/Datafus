package com.ankamagames.dofus.network.types.game.mount
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ItemDurability implements INetworkType
   {
      
      public static const protocolId:uint = 1278;
       
      
      public var durability:int = 0;
      
      public var durabilityMax:int = 0;
      
      public function ItemDurability()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 1278;
      }
      
      public function initItemDurability(durability:int = 0, durabilityMax:int = 0) : ItemDurability
      {
         this.durability = durability;
         this.durabilityMax = durabilityMax;
         return this;
      }
      
      public function reset() : void
      {
         this.durability = 0;
         this.durabilityMax = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ItemDurability(output);
      }
      
      public function serializeAs_ItemDurability(output:ICustomDataOutput) : void
      {
         output.writeShort(this.durability);
         output.writeShort(this.durabilityMax);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ItemDurability(input);
      }
      
      public function deserializeAs_ItemDurability(input:ICustomDataInput) : void
      {
         this._durabilityFunc(input);
         this._durabilityMaxFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ItemDurability(tree);
      }
      
      public function deserializeAsyncAs_ItemDurability(tree:FuncTree) : void
      {
         tree.addChild(this._durabilityFunc);
         tree.addChild(this._durabilityMaxFunc);
      }
      
      private function _durabilityFunc(input:ICustomDataInput) : void
      {
         this.durability = input.readShort();
      }
      
      private function _durabilityMaxFunc(input:ICustomDataInput) : void
      {
         this.durabilityMax = input.readShort();
      }
   }
}
