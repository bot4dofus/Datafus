package com.ankamagames.dofus.internalDatacenter.conquest
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.guild.AllianceWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.AllianceFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.misc.lists.PrismHookList;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.dofus.network.types.game.prism.AllianceInsiderPrismInformation;
   import com.ankamagames.dofus.network.types.game.prism.AlliancePrismInformation;
   import com.ankamagames.dofus.network.types.game.prism.PrismGeolocalizedInformation;
   import com.ankamagames.dofus.network.types.game.prism.PrismSubareaEmptyInfo;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.utils.Dictionary;
   
   public class PrismSubAreaWrapper implements IDataCenter
   {
      
      private static var _ref:Dictionary = new Dictionary();
      
      private static var _cache:Array = new Array();
       
      
      private var _subAreaId:uint;
      
      private var _mapId:Number = -1;
      
      private var _worldX:int = 0;
      
      private var _worldY:int = 0;
      
      private var _prismType:uint = 0;
      
      private var _state:uint = 0;
      
      private var _nextVulnerabilityDate:uint = 0;
      
      private var _placementDate:uint = 0;
      
      private var _alliance:AllianceWrapper = null;
      
      private var _timeSlotHour:uint = 0;
      
      private var _timeSlotQuarter:uint = 0;
      
      private var _lastTimeSlotModificationDate:uint = 0;
      
      private var _lastTimeSlotModificationAuthorGuildId:uint = 0;
      
      private var _lastTimeSlotModificationAuthorId:Number = 0;
      
      private var _lastTimeSlotModificationAuthorName:String = "";
      
      private var _isVillage:int = -1;
      
      private var _subAreaName:String = "";
      
      private var _rewardTokenCount:uint;
      
      private var _modulesObjects:Vector.<ObjectItem>;
      
      public function PrismSubAreaWrapper()
      {
         this._modulesObjects = new Vector.<ObjectItem>();
         super();
      }
      
      public static function reset() : void
      {
         _ref = new Dictionary();
      }
      
      public static function get prismList() : Dictionary
      {
         return _ref;
      }
      
      public static function getFromNetwork(msg:PrismSubareaEmptyInfo, currentPlayerAlliance:AllianceWrapper = null) : PrismSubAreaWrapper
      {
         var ind:int = 0;
         var pgi:PrismGeolocalizedInformation = null;
         var date:Date = null;
         var aipi:AllianceInsiderPrismInformation = null;
         if(!_ref[msg.subAreaId] || Object(msg).constructor == PrismSubareaEmptyInfo)
         {
            _ref[msg.subAreaId] = new PrismSubAreaWrapper();
         }
         var prism:PrismSubAreaWrapper = _ref[msg.subAreaId];
         prism._subAreaId = msg.subAreaId;
         if(prism._alliance)
         {
            ind = prism._alliance.prismIds.indexOf(msg.subAreaId);
            if(ind != -1)
            {
               prism._alliance.prismIds.splice(ind,1);
            }
         }
         if(msg is PrismGeolocalizedInformation)
         {
            pgi = msg as PrismGeolocalizedInformation;
            prism._mapId = pgi.mapId;
            prism._worldX = pgi.worldX;
            prism._worldY = pgi.worldY;
            prism._state = pgi.prism.state;
            prism._prismType = pgi.prism.typeId;
            prism._placementDate = pgi.prism.placementDate;
            prism._nextVulnerabilityDate = pgi.prism.nextVulnerabilityDate;
            prism._rewardTokenCount = pgi.prism.rewardTokenCount;
            date = new Date();
            date.time = prism.nextVulnerabilityDate * 1000 + TimeManager.getInstance().timezoneOffset;
            prism._timeSlotHour = date.hoursUTC;
            prism._timeSlotQuarter = Math.round(date.minutesUTC / 15);
            if(pgi.prism is AllianceInsiderPrismInformation)
            {
               aipi = pgi.prism as AllianceInsiderPrismInformation;
               currentPlayerAlliance.prismIds.push(msg.subAreaId);
               prism._alliance = currentPlayerAlliance;
               prism._lastTimeSlotModificationDate = aipi.lastTimeSlotModificationDate;
               prism._lastTimeSlotModificationAuthorId = aipi.lastTimeSlotModificationAuthorId;
               prism._lastTimeSlotModificationAuthorName = aipi.lastTimeSlotModificationAuthorName;
               prism._lastTimeSlotModificationAuthorGuildId = aipi.lastTimeSlotModificationAuthorGuildId;
               prism._modulesObjects = aipi.modulesObjects;
            }
            else
            {
               prism._lastTimeSlotModificationDate = 0;
               prism._lastTimeSlotModificationAuthorId = 0;
               prism._lastTimeSlotModificationAuthorName = null;
               prism._lastTimeSlotModificationAuthorGuildId = 0;
               prism._modulesObjects = new Vector.<ObjectItem>();
               if(pgi.prism is AlliancePrismInformation)
               {
                  prism._alliance = AllianceWrapper.getFromNetwork(AlliancePrismInformation(pgi.prism).alliance);
                  prism._alliance.prismIds.push(msg.subAreaId);
               }
               else
               {
                  prism._alliance = null;
               }
            }
         }
         else if(msg.allianceId != 0)
         {
            prism._alliance = (Kernel.getWorker().getFrame(AllianceFrame) as AllianceFrame).getAllianceById(msg.allianceId);
         }
         if(PlayedCharacterManager.getInstance().currentSubArea && prism.subAreaId == PlayedCharacterManager.getInstance().currentSubArea.id)
         {
            KernelEventsManager.getInstance().processCallback(PrismHookList.KohState,prism);
         }
         return prism;
      }
      
      public function get subAreaId() : uint
      {
         return this._subAreaId;
      }
      
      public function get mapId() : Number
      {
         return this._mapId;
      }
      
      public function get worldX() : int
      {
         return this._worldX;
      }
      
      public function get worldY() : int
      {
         return this._worldY;
      }
      
      public function get prismType() : uint
      {
         return this._prismType;
      }
      
      public function get state() : uint
      {
         return this._state;
      }
      
      public function get rewardTokenCount() : uint
      {
         return this._rewardTokenCount;
      }
      
      public function get modulesObjects() : Vector.<ObjectItem>
      {
         return this._modulesObjects;
      }
      
      public function get nextVulnerabilityDate() : uint
      {
         return this._nextVulnerabilityDate;
      }
      
      public function get timeSlotHour() : uint
      {
         return this._timeSlotHour;
      }
      
      public function get timeSlotQuarter() : uint
      {
         return this._timeSlotQuarter;
      }
      
      public function get placementDate() : uint
      {
         return this._placementDate;
      }
      
      public function get alliance() : AllianceWrapper
      {
         return this._alliance;
      }
      
      public function get lastTimeSlotModificationDate() : uint
      {
         return this._lastTimeSlotModificationDate;
      }
      
      public function get lastTimeSlotModificationAuthorGuildId() : uint
      {
         return this._lastTimeSlotModificationAuthorGuildId;
      }
      
      public function get lastTimeSlotModificationAuthorId() : Number
      {
         return this._lastTimeSlotModificationAuthorId;
      }
      
      public function get lastTimeSlotModificationAuthorName() : String
      {
         return this._lastTimeSlotModificationAuthorName;
      }
      
      public function get isVillage() : Boolean
      {
         if(this._isVillage == -1)
         {
            if(!SubArea.getSubAreaById(this.subAreaId))
            {
               return false;
            }
            this._isVillage = int(SubArea.getSubAreaById(this.subAreaId).isConquestVillage);
         }
         return this._isVillage == 1;
      }
      
      public function get subAreaName() : String
      {
         if(this._subAreaName == "")
         {
            this._subAreaName = SubArea.getSubAreaById(this.subAreaId).name + " (" + SubArea.getSubAreaById(this.subAreaId).area.name + ")";
         }
         return this._subAreaName;
      }
      
      public function get vulnerabilityHourString() : String
      {
         var sHours:String = null;
         var sMinutes:String = null;
         var hour:String = "";
         if(this._nextVulnerabilityDate != 0)
         {
            sHours = this._timeSlotHour.toString();
            if(sHours.length == 1)
            {
               sHours = "0" + sHours;
            }
            sMinutes = (this._timeSlotQuarter * 15).toString();
            if(sMinutes.length == 1)
            {
               sMinutes = "0" + sMinutes;
            }
            hour = sHours + ":" + sMinutes;
         }
         return hour;
      }
   }
}
