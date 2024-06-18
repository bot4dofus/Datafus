package com.ankamagames.dofus.network.messages.game.context.fight.breach
{
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightEndMessage;
   import com.ankamagames.dofus.network.types.game.context.fight.FightResultListEntry;
   import com.ankamagames.dofus.network.types.game.context.roleplay.party.NamedPartyTeamWithOutcome;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BreachGameFightEndMessage extends GameFightEndMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9314;
       
      
      private var _isInitialized:Boolean = false;
      
      public var budget:int = 0;
      
      public function BreachGameFightEndMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9314;
      }
      
      public function initBreachGameFightEndMessage(duration:uint = 0, rewardRate:int = 0, lootShareLimitMalus:int = 0, results:Vector.<FightResultListEntry> = null, namedPartyTeamsOutcomes:Vector.<NamedPartyTeamWithOutcome> = null, budget:int = 0) : BreachGameFightEndMessage
      {
         super.initGameFightEndMessage(duration,rewardRate,lootShareLimitMalus,results,namedPartyTeamsOutcomes);
         this.budget = budget;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.budget = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:ICustomDataInput, length:uint) : void
      {
         this.deserialize(input);
      }
      
      override public function unpackAsync(input:ICustomDataInput, length:uint) : FuncTree
      {
         var tree:FuncTree = new FuncTree();
         tree.setRoot(input);
         this.deserializeAsync(tree);
         return tree;
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_BreachGameFightEndMessage(output);
      }
      
      public function serializeAs_BreachGameFightEndMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameFightEndMessage(output);
         output.writeInt(this.budget);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BreachGameFightEndMessage(input);
      }
      
      public function deserializeAs_BreachGameFightEndMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._budgetFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BreachGameFightEndMessage(tree);
      }
      
      public function deserializeAsyncAs_BreachGameFightEndMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._budgetFunc);
      }
      
      private function _budgetFunc(input:ICustomDataInput) : void
      {
         this.budget = input.readInt();
      }
   }
}
