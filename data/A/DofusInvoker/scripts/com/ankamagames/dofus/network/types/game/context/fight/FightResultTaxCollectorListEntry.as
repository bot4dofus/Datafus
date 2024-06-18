package com.ankamagames.dofus.network.types.game.context.fight
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicAllianceInformations;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class FightResultTaxCollectorListEntry extends FightResultFighterListEntry implements INetworkType
   {
      
      public static const protocolId:uint = 6507;
       
      
      public var allianceInfo:BasicAllianceInformations;
      
      private var _allianceInfotree:FuncTree;
      
      public function FightResultTaxCollectorListEntry()
      {
         this.allianceInfo = new BasicAllianceInformations();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 6507;
      }
      
      public function initFightResultTaxCollectorListEntry(outcome:uint = 0, wave:uint = 0, rewards:FightLoot = null, id:Number = 0, alive:Boolean = false, allianceInfo:BasicAllianceInformations = null) : FightResultTaxCollectorListEntry
      {
         super.initFightResultFighterListEntry(outcome,wave,rewards,id,alive);
         this.allianceInfo = allianceInfo;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.allianceInfo = new BasicAllianceInformations();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_FightResultTaxCollectorListEntry(output);
      }
      
      public function serializeAs_FightResultTaxCollectorListEntry(output:ICustomDataOutput) : void
      {
         super.serializeAs_FightResultFighterListEntry(output);
         this.allianceInfo.serializeAs_BasicAllianceInformations(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_FightResultTaxCollectorListEntry(input);
      }
      
      public function deserializeAs_FightResultTaxCollectorListEntry(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.allianceInfo = new BasicAllianceInformations();
         this.allianceInfo.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_FightResultTaxCollectorListEntry(tree);
      }
      
      public function deserializeAsyncAs_FightResultTaxCollectorListEntry(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._allianceInfotree = tree.addChild(this._allianceInfotreeFunc);
      }
      
      private function _allianceInfotreeFunc(input:ICustomDataInput) : void
      {
         this.allianceInfo = new BasicAllianceInformations();
         this.allianceInfo.deserializeAsync(this._allianceInfotree);
      }
   }
}
