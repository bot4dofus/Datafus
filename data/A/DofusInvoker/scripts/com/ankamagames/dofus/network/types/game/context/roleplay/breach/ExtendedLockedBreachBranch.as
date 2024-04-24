package com.ankamagames.dofus.network.types.game.context.roleplay.breach
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupLightInformations;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class ExtendedLockedBreachBranch extends ExtendedBreachBranch implements INetworkType
   {
      
      public static const protocolId:uint = 5890;
       
      
      public var unlockPrice:uint = 0;
      
      public function ExtendedLockedBreachBranch()
      {
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 5890;
      }
      
      public function initExtendedLockedBreachBranch(room:uint = 0, element:uint = 0, bosses:Vector.<MonsterInGroupLightInformations> = null, map:Number = 0, score:int = 0, relativeScore:int = 0, monsters:Vector.<MonsterInGroupLightInformations> = null, rewards:Vector.<BreachReward> = null, modifier:int = 0, prize:uint = 0, unlockPrice:uint = 0) : ExtendedLockedBreachBranch
      {
         super.initExtendedBreachBranch(room,element,bosses,map,score,relativeScore,monsters,rewards,modifier,prize);
         this.unlockPrice = unlockPrice;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.unlockPrice = 0;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_ExtendedLockedBreachBranch(output);
      }
      
      public function serializeAs_ExtendedLockedBreachBranch(output:ICustomDataOutput) : void
      {
         super.serializeAs_ExtendedBreachBranch(output);
         if(this.unlockPrice < 0)
         {
            throw new Error("Forbidden value (" + this.unlockPrice + ") on element unlockPrice.");
         }
         output.writeVarInt(this.unlockPrice);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ExtendedLockedBreachBranch(input);
      }
      
      public function deserializeAs_ExtendedLockedBreachBranch(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._unlockPriceFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ExtendedLockedBreachBranch(tree);
      }
      
      public function deserializeAsyncAs_ExtendedLockedBreachBranch(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._unlockPriceFunc);
      }
      
      private function _unlockPriceFunc(input:ICustomDataInput) : void
      {
         this.unlockPrice = input.readVarUhInt();
         if(this.unlockPrice < 0)
         {
            throw new Error("Forbidden value (" + this.unlockPrice + ") on element of ExtendedLockedBreachBranch.unlockPrice.");
         }
      }
   }
}
