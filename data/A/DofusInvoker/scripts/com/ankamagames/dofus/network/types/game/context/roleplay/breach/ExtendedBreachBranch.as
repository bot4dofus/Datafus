package com.ankamagames.dofus.network.types.game.context.roleplay.breach
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupLightInformations;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ExtendedBreachBranch extends BreachBranch implements INetworkType
   {
      
      public static const protocolId:uint = 8307;
       
      
      public var rewards:Vector.<BreachReward>;
      
      public var modifier:int = 0;
      
      public var prize:uint = 0;
      
      private var _rewardstree:FuncTree;
      
      public function ExtendedBreachBranch()
      {
         this.rewards = new Vector.<BreachReward>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 8307;
      }
      
      public function initExtendedBreachBranch(room:uint = 0, element:uint = 0, bosses:Vector.<MonsterInGroupLightInformations> = null, map:Number = 0, score:int = 0, relativeScore:int = 0, monsters:Vector.<MonsterInGroupLightInformations> = null, rewards:Vector.<BreachReward> = null, modifier:int = 0, prize:uint = 0) : ExtendedBreachBranch
      {
         super.initBreachBranch(room,element,bosses,map,score,relativeScore,monsters);
         this.rewards = rewards;
         this.modifier = modifier;
         this.prize = prize;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.rewards = new Vector.<BreachReward>();
         this.modifier = 0;
         this.prize = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ExtendedBreachBranch(output);
      }
      
      public function serializeAs_ExtendedBreachBranch(output:ICustomDataOutput) : void
      {
         super.serializeAs_BreachBranch(output);
         output.writeShort(this.rewards.length);
         for(var _i1:uint = 0; _i1 < this.rewards.length; _i1++)
         {
            (this.rewards[_i1] as BreachReward).serializeAs_BreachReward(output);
         }
         output.writeVarInt(this.modifier);
         if(this.prize < 0)
         {
            throw new Error("Forbidden value (" + this.prize + ") on element prize.");
         }
         output.writeVarInt(this.prize);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExtendedBreachBranch(input);
      }
      
      public function deserializeAs_ExtendedBreachBranch(input:ICustomDataInput) : void
      {
         var _item1:BreachReward = null;
         super.deserialize(input);
         var _rewardsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _rewardsLen; _i1++)
         {
            _item1 = new BreachReward();
            _item1.deserialize(input);
            this.rewards.push(_item1);
         }
         this._modifierFunc(input);
         this._prizeFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExtendedBreachBranch(tree);
      }
      
      public function deserializeAsyncAs_ExtendedBreachBranch(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._rewardstree = tree.addChild(this._rewardstreeFunc);
         tree.addChild(this._modifierFunc);
         tree.addChild(this._prizeFunc);
      }
      
      private function _rewardstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._rewardstree.addChild(this._rewardsFunc);
         }
      }
      
      private function _rewardsFunc(input:ICustomDataInput) : void
      {
         var _item:BreachReward = new BreachReward();
         _item.deserialize(input);
         this.rewards.push(_item);
      }
      
      private function _modifierFunc(input:ICustomDataInput) : void
      {
         this.modifier = input.readVarInt();
      }
      
      private function _prizeFunc(input:ICustomDataInput) : void
      {
         this.prize = input.readVarUhInt();
         if(this.prize < 0)
         {
            throw new Error("Forbidden value (" + this.prize + ") on element of ExtendedBreachBranch.prize.");
         }
      }
   }
}
