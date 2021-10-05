package com.ankamagames.dofus.logic.game.roleplay.types
{
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   
   public class TaxCollectorTooltipInformation
   {
       
      
      public var lastName:String;
      
      public var firstName:String;
      
      public var guildIdentity:GuildWrapper;
      
      public var taxCollectorAttack:int;
      
      public var allianceIdentity:AllianceWrapper;
      
      public var checkSuperposition:Boolean;
      
      public var cellId:int;
      
      public function TaxCollectorTooltipInformation(pFirstName:String, pLastName:String, pGuildIdentity:GuildWrapper, pAllianceIdentity:AllianceWrapper, pTaxCollectorAttack:int, pCheckSuperposition:Boolean = false, pCellId:int = -1)
      {
         super();
         this.lastName = pLastName;
         this.firstName = pFirstName;
         this.guildIdentity = pGuildIdentity;
         this.allianceIdentity = pAllianceIdentity;
         this.taxCollectorAttack = pTaxCollectorAttack;
         this.checkSuperposition = pCheckSuperposition;
         this.cellId = pCellId;
      }
   }
}
