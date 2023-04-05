package com.ankamagames.dofus.internalDatacenter.social
{
   import com.ankamagames.dofus.network.types.game.collector.tax.TaxCollectorPreset;
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformation;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicAllianceInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicNamedAllianceInformations;
   import com.ankamagames.dofus.network.types.game.social.AllianceFactSheetInformation;
   import com.ankamagames.dofus.network.types.game.social.SocialEmblem;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.utils.Dictionary;
   
   public class AllianceWrapper extends SocialGroupWrapper implements IDataCenter
   {
      
      private static var _ref:Dictionary = new Dictionary();
       
      
      private var _allianceTag:String;
      
      public var nbSubareas:uint = 0;
      
      public var prismIds:Vector.<uint>;
      
      public var taxCollectorPresets:Vector.<TaxCollectorPreset>;
      
      public var allianceRecruitmentInfo:AllianceRecruitmentDataWrapper;
      
      public function AllianceWrapper()
      {
         this.prismIds = new Vector.<uint>();
         this.taxCollectorPresets = new Vector.<TaxCollectorPreset>();
         super();
      }
      
      public static function getAllianceById(id:int) : AllianceWrapper
      {
         return _ref[id];
      }
      
      public static function create(pAllianceId:uint, pAllianceTag:String, pAllianceName:String, pAllianceEmblem:SocialEmblem, creationDate:Number = 0, nbMembers:uint = 0, prismIds:Vector.<uint> = null, taxCollectorPresets:Vector.<TaxCollectorPreset> = null, pAllianceLeaderId:Number = 0) : AllianceWrapper
      {
         var item:AllianceWrapper = null;
         item = new AllianceWrapper();
         item.groupId = pAllianceId;
         item._allianceTag = pAllianceTag;
         item.groupName = pAllianceName;
         item.leaderId = pAllianceLeaderId;
         if(pAllianceEmblem != null)
         {
            item.upEmblem = EmblemWrapper.create(pAllianceEmblem.symbolShape,EmblemWrapper.UP,pAllianceEmblem.symbolColor,true);
            item.backEmblem = EmblemWrapper.create(pAllianceEmblem.backgroundShape,EmblemWrapper.BACK,pAllianceEmblem.backgroundColor,true);
         }
         item.creationDate = creationDate;
         item.nbMembers = nbMembers;
         if(prismIds)
         {
            item.prismIds = prismIds;
         }
         if(taxCollectorPresets)
         {
            item.taxCollectorPresets = taxCollectorPresets;
         }
         return item;
      }
      
      public static function clearCache() : void
      {
         _ref = new Dictionary();
      }
      
      public static function getFromNetwork(o:*) : AllianceWrapper
      {
         if(o is BasicAllianceInformations)
         {
            return getFromBasicAllianceInformation(BasicAllianceInformations(o));
         }
         return null;
      }
      
      private static function getFromBasicAllianceInformation(o:BasicAllianceInformations) : AllianceWrapper
      {
         var aw:AllianceWrapper = null;
         var emblem:SocialEmblem = null;
         if(_ref[o.allianceId])
         {
            aw = _ref[o.allianceId];
         }
         else
         {
            aw = new AllianceWrapper();
            _ref[o.allianceId] = aw;
         }
         aw.groupId = o.allianceId;
         aw._allianceTag = o.allianceTag;
         if(o is BasicNamedAllianceInformations)
         {
            aw.groupName = BasicNamedAllianceInformations(o).allianceName;
         }
         if(o is AllianceInformation)
         {
            emblem = AllianceInformation(o).allianceEmblem;
            aw.upEmblem = EmblemWrapper.fromNetwork(emblem,false,true);
            aw.backEmblem = EmblemWrapper.fromNetwork(emblem,true,true);
         }
         if(o is AllianceFactSheetInformation)
         {
            aw.nbMembers = AllianceFactSheetInformation(o).nbMembers;
            aw.creationDate = AllianceFactSheetInformation(o).creationDate;
            aw.nbSubareas = AllianceFactSheetInformation(o).nbSubarea;
            aw.allianceRecruitmentInfo = AllianceRecruitmentDataWrapper.wrap((o as AllianceFactSheetInformation).recruitment);
         }
         return aw;
      }
      
      public static function getFromAllianceFactSheetWrapper(allianceFactSheetWrapper:AllianceFactSheetWrapper) : AllianceWrapper
      {
         var o:AllianceWrapper = null;
         if(_ref[allianceFactSheetWrapper.groupId])
         {
            o = _ref[allianceFactSheetWrapper.groupId];
         }
         else
         {
            o = new AllianceWrapper();
            _ref[allianceFactSheetWrapper.groupId] = o;
         }
         o.groupId = allianceFactSheetWrapper.groupId;
         o.groupName = allianceFactSheetWrapper.groupName;
         o.upEmblem = allianceFactSheetWrapper.upEmblem;
         o.backEmblem = allianceFactSheetWrapper.backEmblem;
         o.nbMembers = allianceFactSheetWrapper.nbMembers;
         o.allianceRecruitmentInfo = allianceFactSheetWrapper.allianceRecruitmentInfo;
         o.leaderId = allianceFactSheetWrapper.leaderId;
         o.creationDate = allianceFactSheetWrapper.creationDate;
         return o;
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
      
      public function get realAllianceTag() : String
      {
         return this._allianceTag;
      }
      
      public function get allianceId() : uint
      {
         return groupId;
      }
      
      override public function get recruitmentInfo() : SocialRecruitmentDataWrapper
      {
         return this.allianceRecruitmentInfo;
      }
      
      public function update(pAllianceId:uint, pAllianceTag:String, pAllianceName:String, pAllianceEmblem:SocialEmblem, creationDate:Number = 0, nbMembers:uint = 0, prismIds:Vector.<uint> = null, taxCollectorPresets:Vector.<TaxCollectorPreset> = null, pAllianceLeaderId:Number = 0) : void
      {
         this.groupId = pAllianceId;
         this._allianceTag = pAllianceTag;
         this.groupName = pAllianceName;
         this.leaderId = pAllianceLeaderId;
         this.upEmblem.update(pAllianceEmblem.symbolShape,EmblemWrapper.UP,pAllianceEmblem.symbolColor);
         this.backEmblem.update(pAllianceEmblem.backgroundShape,EmblemWrapper.BACK,pAllianceEmblem.backgroundColor);
         this.creationDate = creationDate;
         this.nbMembers = nbMembers;
         if(prismIds)
         {
            this.prismIds = prismIds;
         }
         if(taxCollectorPresets)
         {
            this.taxCollectorPresets = taxCollectorPresets;
         }
      }
      
      public function clone() : AllianceWrapper
      {
         var wrapper:AllianceWrapper = create(groupId,this.allianceTag,groupName,null,creationDate,nbMembers,this.prismIds,this.taxCollectorPresets);
         wrapper.upEmblem = upEmblem;
         wrapper.backEmblem = backEmblem;
         return wrapper;
      }
   }
}
