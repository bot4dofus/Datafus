package com.ankamagames.dofus.network.types.game.data.items.effects
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ObjectEffectDice extends ObjectEffect implements INetworkType
   {
      
      public static const protocolId:uint = 670;
       
      
      public var diceNum:uint = 0;
      
      public var diceSide:uint = 0;
      
      public var diceConst:uint = 0;
      
      public function ObjectEffectDice()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 670;
      }
      
      public function initObjectEffectDice(actionId:uint = 0, diceNum:uint = 0, diceSide:uint = 0, diceConst:uint = 0) : ObjectEffectDice
      {
         super.initObjectEffect(actionId);
         this.diceNum = diceNum;
         this.diceSide = diceSide;
         this.diceConst = diceConst;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.diceNum = 0;
         this.diceSide = 0;
         this.diceConst = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ObjectEffectDice(output);
      }
      
      public function serializeAs_ObjectEffectDice(output:ICustomDataOutput) : void
      {
         super.serializeAs_ObjectEffect(output);
         if(this.diceNum < 0)
         {
            throw new Error("Forbidden value (" + this.diceNum + ") on element diceNum.");
         }
         output.writeVarInt(this.diceNum);
         if(this.diceSide < 0)
         {
            throw new Error("Forbidden value (" + this.diceSide + ") on element diceSide.");
         }
         output.writeVarInt(this.diceSide);
         if(this.diceConst < 0)
         {
            throw new Error("Forbidden value (" + this.diceConst + ") on element diceConst.");
         }
         output.writeVarInt(this.diceConst);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ObjectEffectDice(input);
      }
      
      public function deserializeAs_ObjectEffectDice(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._diceNumFunc(input);
         this._diceSideFunc(input);
         this._diceConstFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ObjectEffectDice(tree);
      }
      
      public function deserializeAsyncAs_ObjectEffectDice(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._diceNumFunc);
         tree.addChild(this._diceSideFunc);
         tree.addChild(this._diceConstFunc);
      }
      
      private function _diceNumFunc(input:ICustomDataInput) : void
      {
         this.diceNum = input.readVarUhInt();
         if(this.diceNum < 0)
         {
            throw new Error("Forbidden value (" + this.diceNum + ") on element of ObjectEffectDice.diceNum.");
         }
      }
      
      private function _diceSideFunc(input:ICustomDataInput) : void
      {
         this.diceSide = input.readVarUhInt();
         if(this.diceSide < 0)
         {
            throw new Error("Forbidden value (" + this.diceSide + ") on element of ObjectEffectDice.diceSide.");
         }
      }
      
      private function _diceConstFunc(input:ICustomDataInput) : void
      {
         this.diceConst = input.readVarUhInt();
         if(this.diceConst < 0)
         {
            throw new Error("Forbidden value (" + this.diceConst + ") on element of ObjectEffectDice.diceConst.");
         }
      }
   }
}
