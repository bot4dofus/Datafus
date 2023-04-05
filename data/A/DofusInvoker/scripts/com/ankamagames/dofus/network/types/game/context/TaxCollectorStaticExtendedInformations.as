package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GuildInformations;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class TaxCollectorStaticExtendedInformations extends TaxCollectorStaticInformations implements INetworkType
   {
      
      public static const protocolId:uint = 2929;
       
      
      public var allianceIdentity:AllianceInformations;
      
      private var _allianceIdentitytree:FuncTree;
      
      public function TaxCollectorStaticExtendedInformations()
      {
         this.allianceIdentity = new AllianceInformations();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 2929;
      }
      
      public function initTaxCollectorStaticExtendedInformations(firstNameId:uint = 0, lastNameId:uint = 0, guildIdentity:GuildInformations = null, callerId:Number = 0, allianceIdentity:AllianceInformations = null) : TaxCollectorStaticExtendedInformations
      {
         super.initTaxCollectorStaticInformations(firstNameId,lastNameId,guildIdentity,callerId);
         this.allianceIdentity = allianceIdentity;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.allianceIdentity = new AllianceInformations();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_TaxCollectorStaticExtendedInformations(output);
      }
      
      public function serializeAs_TaxCollectorStaticExtendedInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_TaxCollectorStaticInformations(output);
         this.allianceIdentity.serializeAs_AllianceInformations(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorStaticExtendedInformations(input);
      }
      
      public function deserializeAs_TaxCollectorStaticExtendedInformations(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this.allianceIdentity = new AllianceInformations();
         this.allianceIdentity.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorStaticExtendedInformations(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorStaticExtendedInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         this._allianceIdentitytree = tree.addChild(this._allianceIdentitytreeFunc);
      }
      
      private function _allianceIdentitytreeFunc(input:ICustomDataInput) : void
      {
         this.allianceIdentity = new AllianceInformations();
         this.allianceIdentity.deserializeAsync(this._allianceIdentitytree);
      }
   }
}
