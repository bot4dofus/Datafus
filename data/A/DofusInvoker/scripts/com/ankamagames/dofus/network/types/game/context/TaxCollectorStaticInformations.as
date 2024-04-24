package com.ankamagames.dofus.network.types.game.context
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformation;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class TaxCollectorStaticInformations implements INetworkType
   {
      
      public static const protocolId:uint = 2371;
       
      
      public var firstNameId:uint = 0;
      
      public var lastNameId:uint = 0;
      
      public var allianceIdentity:AllianceInformation;
      
      public var callerId:Number = 0;
      
      private var _allianceIdentitytree:FuncTree;
      
      public function TaxCollectorStaticInformations()
      {
         this.allianceIdentity = new AllianceInformation();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 2371;
      }
      
      public function initTaxCollectorStaticInformations(firstNameId:uint = 0, lastNameId:uint = 0, allianceIdentity:AllianceInformation = null, callerId:Number = 0) : TaxCollectorStaticInformations
      {
         this.firstNameId = firstNameId;
         this.lastNameId = lastNameId;
         this.allianceIdentity = allianceIdentity;
         this.callerId = callerId;
         return this;
      }
      
      public function reset() : void
      {
         this.firstNameId = 0;
         this.lastNameId = 0;
         this.allianceIdentity = new AllianceInformation();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_TaxCollectorStaticInformations(output);
      }
      
      public function serializeAs_TaxCollectorStaticInformations(output:ICustomDataOutput) : void
      {
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element firstNameId.");
         }
         output.writeVarShort(this.firstNameId);
         if(this.lastNameId < 0)
         {
            throw new Error("Forbidden value (" + this.lastNameId + ") on element lastNameId.");
         }
         output.writeVarShort(this.lastNameId);
         this.allianceIdentity.serializeAs_AllianceInformation(output);
         if(this.callerId < 0 || this.callerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.callerId + ") on element callerId.");
         }
         output.writeVarLong(this.callerId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_TaxCollectorStaticInformations(input);
      }
      
      public function deserializeAs_TaxCollectorStaticInformations(input:ICustomDataInput) : void
      {
         this._firstNameIdFunc(input);
         this._lastNameIdFunc(input);
         this.allianceIdentity = new AllianceInformation();
         this.allianceIdentity.deserialize(input);
         this._callerIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_TaxCollectorStaticInformations(tree);
      }
      
      public function deserializeAsyncAs_TaxCollectorStaticInformations(tree:FuncTree) : void
      {
         tree.addChild(this._firstNameIdFunc);
         tree.addChild(this._lastNameIdFunc);
         this._allianceIdentitytree = tree.addChild(this._allianceIdentitytreeFunc);
         tree.addChild(this._callerIdFunc);
      }
      
      private function _firstNameIdFunc(input:ICustomDataInput) : void
      {
         this.firstNameId = input.readVarUhShort();
         if(this.firstNameId < 0)
         {
            throw new Error("Forbidden value (" + this.firstNameId + ") on element of TaxCollectorStaticInformations.firstNameId.");
         }
      }
      
      private function _lastNameIdFunc(input:ICustomDataInput) : void
      {
         this.lastNameId = input.readVarUhShort();
         if(this.lastNameId < 0)
         {
            throw new Error("Forbidden value (" + this.lastNameId + ") on element of TaxCollectorStaticInformations.lastNameId.");
         }
      }
      
      private function _allianceIdentitytreeFunc(input:ICustomDataInput) : void
      {
         this.allianceIdentity = new AllianceInformation();
         this.allianceIdentity.deserializeAsync(this._allianceIdentitytree);
      }
      
      private function _callerIdFunc(input:ICustomDataInput) : void
      {
         this.callerId = input.readVarUhLong();
         if(this.callerId < 0 || this.callerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.callerId + ") on element of TaxCollectorStaticInformations.callerId.");
         }
      }
   }
}
