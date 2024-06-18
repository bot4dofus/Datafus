package com.ankamagames.dofus.network.types.game.prism
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AlliancePrismInformation extends PrismInformation implements INetworkType
   {
      
      public static const protocolId:uint = 4594;
       
      
      public var alliance:AllianceInformation;
      
      private var _alliancetree:FuncTree;
      
      public function AlliancePrismInformation()
      {
         this.alliance = new AllianceInformation();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 4594;
      }
      
      public function initAlliancePrismInformation(state:uint = 1, placementDate:uint = 0, nuggetsCount:uint = 0, durability:uint = 0, nextEvolutionDate:Number = 0, alliance:AllianceInformation = null) : AlliancePrismInformation
      {
         super.initPrismInformation(state,placementDate,nuggetsCount,durability,nextEvolutionDate);
         this.alliance = alliance;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.alliance = new AllianceInformation();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AlliancePrismInformation(output);
      }
      
      public function serializeAs_AlliancePrismInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_PrismInformation(output);
         this.alliance.serializeAs_AllianceInformation(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AlliancePrismInformation(input);
      }
      
      public function deserializeAs_AlliancePrismInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.alliance = new AllianceInformation();
         this.alliance.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AlliancePrismInformation(tree);
      }
      
      public function deserializeAsyncAs_AlliancePrismInformation(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._alliancetree = tree.addChild(this._alliancetreeFunc);
      }
      
      private function _alliancetreeFunc(input:ICustomDataInput) : void
      {
         this.alliance = new AllianceInformation();
         this.alliance.deserializeAsync(this._alliancetree);
      }
   }
}
