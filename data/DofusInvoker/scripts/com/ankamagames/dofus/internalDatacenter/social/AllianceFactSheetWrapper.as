package com.ankamagames.dofus.internalDatacenter.social
{
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalSocialPublicInformations;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class AllianceFactSheetWrapper extends SocialGroupFactSheetWrapper implements IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AllianceFactSheetWrapper));
       
      
      private var _allianceTag:String;
      
      public var nbTaxCollectors:uint = 0;
      
      public var prismIds:Vector.<uint>;
      
      public var allianceRecruitmentInfo:AllianceRecruitmentDataWrapper;
      
      public function AllianceFactSheetWrapper(allianceId:uint, allianceName:String, allianceUpEmblem:EmblemWrapper, allianceBackEmblem:EmblemWrapper, leaderId:Number, nbMembers:uint, creationDate:Number, members:Vector.<CharacterMinimalSocialPublicInformations>, allianceTag:String = "", prismIds:Vector.<uint> = null, nbTaxCollectors:uint = 0, allianceRecruitmentInfo:AllianceRecruitmentDataWrapper = null)
      {
         this.prismIds = new Vector.<uint>();
         this.allianceRecruitmentInfo = new AllianceRecruitmentDataWrapper();
         super(allianceId,allianceName,allianceUpEmblem,allianceBackEmblem,leaderId,nbMembers,creationDate,members);
         this.allianceTag = allianceTag;
         this.nbTaxCollectors = nbTaxCollectors;
         this.prismIds = prismIds;
         this.allianceRecruitmentInfo = allianceRecruitmentInfo;
      }
      
      public function updateWrapper(allianceId:uint, allianceName:String, allianceUpEmblem:EmblemWrapper, allianceBackEmblem:EmblemWrapper, leaderId:Number, nbMembers:uint, creationDate:Number, members:Vector.<CharacterMinimalSocialPublicInformations>, allianceTag:String = "", prismIds:Vector.<uint> = null, nbTaxCollectors:uint = 0, allianceRecruitmentInfo:AllianceRecruitmentDataWrapper = null) : void
      {
         super.update(allianceId,allianceName,allianceUpEmblem,allianceBackEmblem,leaderId,nbMembers,creationDate,members);
         this.allianceTag = allianceTag;
         this.nbTaxCollectors = nbTaxCollectors;
         this.prismIds = prismIds;
         this.allianceRecruitmentInfo = allianceRecruitmentInfo;
      }
      
      public function get allianceTag() : String
      {
         if(this._allianceTag == "#TAG#")
         {
            return I18n.getUiText("ui.alliance.noTag");
         }
         return this._allianceTag;
      }
      
      public function set allianceTag(tag:String) : void
      {
         this._allianceTag = tag;
      }
   }
}
