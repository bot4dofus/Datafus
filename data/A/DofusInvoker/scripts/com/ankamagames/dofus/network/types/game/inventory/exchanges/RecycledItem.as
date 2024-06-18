package com.ankamagames.dofus.network.types.game.inventory.exchanges
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class RecycledItem implements INetworkType
   {
      
      public static const protocolId:uint = 2736;
       
      
      public var id:uint = 0;
      
      public var qty:uint = 0;
      
      public function RecycledItem()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 2736;
      }
      
      public function initRecycledItem(id:uint = 0, qty:uint = 0) : RecycledItem
      {
         this.id = id;
         this.qty = qty;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
         this.qty = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_RecycledItem(output);
      }
      
      public function serializeAs_RecycledItem(output:ICustomDataOutput) : void
      {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeVarInt(this.id);
         if(this.qty < 0 || this.qty > 4294967295)
         {
            throw new Error("Forbidden value (" + this.qty + ") on element qty.");
         }
         output.writeUnsignedInt(this.qty);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_RecycledItem(input);
      }
      
      public function deserializeAs_RecycledItem(input:ICustomDataInput) : void
      {
         this._idFunc(input);
         this._qtyFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_RecycledItem(tree);
      }
      
      public function deserializeAsyncAs_RecycledItem(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         tree.addChild(this._qtyFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readVarUhInt();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of RecycledItem.id.");
         }
      }
      
      private function _qtyFunc(input:ICustomDataInput) : void
      {
         this.qty = input.readUnsignedInt();
         if(this.qty < 0 || this.qty > 4294967295)
         {
            throw new Error("Forbidden value (" + this.qty + ") on element of RecycledItem.qty.");
         }
      }
   }
}
