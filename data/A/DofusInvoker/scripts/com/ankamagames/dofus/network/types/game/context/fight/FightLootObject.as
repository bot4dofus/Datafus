package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightLootObject implements INetworkType
   {
      
      public static const protocolId:uint = 1967;
       
      
      public var objectId:int = 0;
      
      public var quantity:int = 0;
      
      public var priorityHint:int = 0;
      
      public function FightLootObject()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 1967;
      }
      
      public function initFightLootObject(objectId:int = 0, quantity:int = 0, priorityHint:int = 0) : FightLootObject
      {
         this.objectId = objectId;
         this.quantity = quantity;
         this.priorityHint = priorityHint;
         return this;
      }
      
      public function reset() : void
      {
         this.objectId = 0;
         this.quantity = 0;
         this.priorityHint = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightLootObject(output);
      }
      
      public function serializeAs_FightLootObject(output:ICustomDataOutput) : void
      {
         output.writeInt(this.objectId);
         output.writeInt(this.quantity);
         output.writeInt(this.priorityHint);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightLootObject(input);
      }
      
      public function deserializeAs_FightLootObject(input:ICustomDataInput) : void
      {
         this._objectIdFunc(input);
         this._quantityFunc(input);
         this._priorityHintFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightLootObject(tree);
      }
      
      public function deserializeAsyncAs_FightLootObject(tree:FuncTree) : void
      {
         tree.addChild(this._objectIdFunc);
         tree.addChild(this._quantityFunc);
         tree.addChild(this._priorityHintFunc);
      }
      
      private function _objectIdFunc(input:ICustomDataInput) : void
      {
         this.objectId = input.readInt();
      }
      
      private function _quantityFunc(input:ICustomDataInput) : void
      {
         this.quantity = input.readInt();
      }
      
      private function _priorityHintFunc(input:ICustomDataInput) : void
      {
         this.priorityHint = input.readInt();
      }
   }
}
