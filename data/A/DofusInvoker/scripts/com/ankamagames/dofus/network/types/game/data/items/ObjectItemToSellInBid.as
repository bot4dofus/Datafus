package com.ankamagames.dofus.network.types.game.data.items
{
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ObjectItemToSellInBid extends ObjectItemToSell implements INetworkType
   {
      
      public static const protocolId:uint = 166;
       
      
      public var unsoldDelay:uint = 0;
      
      public function ObjectItemToSellInBid()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 166;
      }
      
      public function initObjectItemToSellInBid(objectGID:uint = 0, effects:Vector.<ObjectEffect> = null, objectUID:uint = 0, quantity:uint = 0, objectPrice:Number = 0, unsoldDelay:uint = 0) : ObjectItemToSellInBid
      {
         super.initObjectItemToSell(objectGID,effects,objectUID,quantity,objectPrice);
         this.unsoldDelay = unsoldDelay;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.unsoldDelay = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectItemToSellInBid(output);
      }
      
      public function serializeAs_ObjectItemToSellInBid(output:ICustomDataOutput) : void
      {
         super.serializeAs_ObjectItemToSell(output);
         if(this.unsoldDelay < 0)
         {
            throw new Error("Forbidden value (" + this.unsoldDelay + ") on element unsoldDelay.");
         }
         output.writeInt(this.unsoldDelay);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectItemToSellInBid(input);
      }
      
      public function deserializeAs_ObjectItemToSellInBid(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._unsoldDelayFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectItemToSellInBid(tree);
      }
      
      public function deserializeAsyncAs_ObjectItemToSellInBid(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._unsoldDelayFunc);
      }
      
      private function _unsoldDelayFunc(input:ICustomDataInput) : void
      {
         this.unsoldDelay = input.readInt();
         if(this.unsoldDelay < 0)
         {
            throw new Error("Forbidden value (" + this.unsoldDelay + ") on element of ObjectItemToSellInBid.unsoldDelay.");
         }
      }
   }
}
