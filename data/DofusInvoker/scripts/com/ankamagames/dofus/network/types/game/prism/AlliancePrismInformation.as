package com.ankamagames.dofus.network.types.game.prism
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformations;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class AlliancePrismInformation extends PrismInformation implements INetworkType
   {
      
      public static const protocolId:uint = 1085;
       
      
      public var alliance:AllianceInformations;
      
      private var _alliancetree:FuncTree;
      
      public function AlliancePrismInformation()
      {
         this.alliance = new AllianceInformations();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 1085;
      }
      
      public function initAlliancePrismInformation(typeId:uint = 0, state:uint = 1, nextVulnerabilityDate:uint = 0, placementDate:uint = 0, rewardTokenCount:uint = 0, alliance:AllianceInformations = null) : AlliancePrismInformation
      {
         super.initPrismInformation(typeId,state,nextVulnerabilityDate,placementDate,rewardTokenCount);
         this.alliance = alliance;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.alliance = new AllianceInformations();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AlliancePrismInformation(output);
      }
      
      public function serializeAs_AlliancePrismInformation(output:ICustomDataOutput) : void
      {
         super.serializeAs_PrismInformation(output);
         this.alliance.serializeAs_AllianceInformations(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AlliancePrismInformation(input);
      }
      
      public function deserializeAs_AlliancePrismInformation(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.alliance = new AllianceInformations();
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
         this.alliance = new AllianceInformations();
         this.alliance.deserializeAsync(this._alliancetree);
      }
   }
}
