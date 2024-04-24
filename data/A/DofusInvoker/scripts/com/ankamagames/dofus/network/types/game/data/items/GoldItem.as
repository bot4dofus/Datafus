package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GoldItem extends Item implements INetworkType
   {
      
      public static const protocolId:uint = 1772;
       
      
      public var sum:Number = 0;
      
      public function GoldItem()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 1772;
      }
      
      public function initGoldItem(sum:Number = 0) : GoldItem
      {
         this.sum = sum;
         return this;
      }
      
      override public function reset() : void
      {
         this.sum = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GoldItem(output);
      }
      
      public function serializeAs_GoldItem(output:ICustomDataOutput) : void
      {
         super.serializeAs_Item(output);
         if(this.sum < 0 || this.sum > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.sum + ") on element sum.");
         }
         output.writeVarLong(this.sum);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GoldItem(input);
      }
      
      public function deserializeAs_GoldItem(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._sumFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GoldItem(tree);
      }
      
      public function deserializeAsyncAs_GoldItem(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._sumFunc);
      }
      
      private function _sumFunc(input:ICustomDataInput) : void
      {
         this.sum = input.readVarUhLong();
         if(this.sum < 0 || this.sum > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.sum + ") on element of GoldItem.sum.");
         }
      }
   }
}
