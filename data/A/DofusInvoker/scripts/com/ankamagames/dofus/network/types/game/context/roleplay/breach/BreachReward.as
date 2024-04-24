package com.ankamagames.dofus.network.types.game.context.roleplay.breach
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class BreachReward implements INetworkType
   {
      
      public static const protocolId:uint = 32;
       
      
      public var id:uint = 0;
      
      public var buyLocks:Vector.<uint>;
      
      public var buyCriterion:String = "";
      
      public var remainingQty:int = 0;
      
      public var price:uint = 0;
      
      private var _buyLockstree:FuncTree;
      
      public function BreachReward()
      {
         this.buyLocks = new Vector.<uint>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 32;
      }
      
      public function initBreachReward(id:uint = 0, buyLocks:Vector.<uint> = null, buyCriterion:String = "", remainingQty:int = 0, price:uint = 0) : BreachReward
      {
         this.id = id;
         this.buyLocks = buyLocks;
         this.buyCriterion = buyCriterion;
         this.remainingQty = remainingQty;
         this.price = price;
         return this;
      }
      
      public function reset() : void
      {
         this.id = 0;
         this.buyLocks = new Vector.<uint>();
         this.buyCriterion = "";
         this.remainingQty = 0;
         this.price = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_BreachReward(output);
      }
      
      public function serializeAs_BreachReward(output:ICustomDataOutput) : void
      {
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element id.");
         }
         output.writeVarInt(this.id);
         output.writeShort(this.buyLocks.length);
         for(var _i2:uint = 0; _i2 < this.buyLocks.length; _i2++)
         {
            output.writeByte(this.buyLocks[_i2]);
         }
         output.writeUTF(this.buyCriterion);
         output.writeVarInt(this.remainingQty);
         if(this.price < 0)
         {
            throw new Error("Forbidden value (" + this.price + ") on element price.");
         }
         output.writeVarInt(this.price);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BreachReward(input);
      }
      
      public function deserializeAs_BreachReward(input:ICustomDataInput) : void
      {
         var _val2:uint = 0;
         this._idFunc(input);
         var _buyLocksLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _buyLocksLen; _i2++)
         {
            _val2 = input.readByte();
            if(_val2 < 0)
            {
               throw new Error("Forbidden value (" + _val2 + ") on elements of buyLocks.");
            }
            this.buyLocks.push(_val2);
         }
         this._buyCriterionFunc(input);
         this._remainingQtyFunc(input);
         this._priceFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BreachReward(tree);
      }
      
      public function deserializeAsyncAs_BreachReward(tree:FuncTree) : void
      {
         tree.addChild(this._idFunc);
         this._buyLockstree = tree.addChild(this._buyLockstreeFunc);
         tree.addChild(this._buyCriterionFunc);
         tree.addChild(this._remainingQtyFunc);
         tree.addChild(this._priceFunc);
      }
      
      private function _idFunc(input:ICustomDataInput) : void
      {
         this.id = input.readVarUhInt();
         if(this.id < 0)
         {
            throw new Error("Forbidden value (" + this.id + ") on element of BreachReward.id.");
         }
      }
      
      private function _buyLockstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._buyLockstree.addChild(this._buyLocksFunc);
         }
      }
      
      private function _buyLocksFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readByte();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of buyLocks.");
         }
         this.buyLocks.push(_val);
      }
      
      private function _buyCriterionFunc(input:ICustomDataInput) : void
      {
         this.buyCriterion = input.readUTF();
      }
      
      private function _remainingQtyFunc(input:ICustomDataInput) : void
      {
         this.remainingQty = input.readVarInt();
      }
      
      private function _priceFunc(input:ICustomDataInput) : void
      {
         this.price = input.readVarUhInt();
         if(this.price < 0)
         {
            throw new Error("Forbidden value (" + this.price + ") on element of BreachReward.price.");
         }
      }
   }
}
