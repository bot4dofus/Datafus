package com.ankamagames.dofus.internalDatacenter.conquest
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.social.AllianceWrapper;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.misc.lists.PrismHookList;
   import com.ankamagames.dofus.network.enums.AlliancePrismCristalTypeEnum;
   import com.ankamagames.dofus.network.enums.AlliancePrismModuleTypeEnum;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.dofus.network.types.game.prism.AllianceInsiderPrismInformation;
   import com.ankamagames.dofus.network.types.game.prism.AlliancePrismInformation;
   import com.ankamagames.dofus.network.types.game.prism.PrismGeolocalizedInformation;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class PrismSubAreaWrapper implements IDataCenter
   {
       
      
      private var _subAreaId:uint;
      
      private var _mapId:Number = -1;
      
      private var _worldX:int = 0;
      
      private var _worldY:int = 0;
      
      private var _prismType:uint = 0;
      
      private var _state:uint = 0;
      
      private var _placementDate:uint = 0;
      
      private var _durability:uint;
      
      private var _alliance:AllianceWrapper = null;
      
      private var _isVillage:int = -1;
      
      private var _subAreaName:String = "";
      
      private var _nuggetsCount:uint;
      
      private var _moduleObject:ObjectItem;
      
      private var _moduleType:int = -1;
      
      private var _cristalObject:ObjectItem;
      
      private var _nextEvolutionDate:Number;
      
      private var _cristalType:int = -1;
      
      private var _cristalNumberLeft:uint;
      
      public function PrismSubAreaWrapper()
      {
         super();
      }
      
      public static function create(prismInfo:PrismGeolocalizedInformation) : PrismSubAreaWrapper
      {
         var aipi:AllianceInsiderPrismInformation = null;
         var prism:PrismSubAreaWrapper = new PrismSubAreaWrapper();
         prism._subAreaId = prismInfo.subAreaId;
         prism._mapId = prismInfo.mapId;
         prism._worldX = prismInfo.worldX;
         prism._worldY = prismInfo.worldY;
         prism._state = prismInfo.prism.state;
         prism._durability = prismInfo.prism.durability;
         prism._placementDate = prismInfo.prism.placementDate;
         prism._nuggetsCount = prismInfo.prism.nuggetsCount;
         if(prismInfo.prism is AllianceInsiderPrismInformation)
         {
            aipi = prismInfo.prism as AllianceInsiderPrismInformation;
            prism._alliance = SocialFrame.getInstance().alliance;
            prism._moduleObject = aipi.moduleObject;
            prism._moduleType = aipi.moduleType;
            prism._cristalObject = aipi.cristalObject;
            prism._cristalType = aipi.cristalType;
            prism._nextEvolutionDate = aipi.nextEvolutionDate;
            prism._cristalNumberLeft = aipi.cristalNumberLeft;
         }
         else
         {
            prism._moduleObject = null;
            prism._moduleType = AlliancePrismModuleTypeEnum.NO_MODULE;
            prism._cristalObject = null;
            prism._cristalType = AlliancePrismCristalTypeEnum.NO_CRISTAL;
            prism._nextEvolutionDate = 0;
            prism._cristalNumberLeft = 0;
            if(prismInfo.prism is AlliancePrismInformation)
            {
               prism._alliance = AllianceWrapper.getFromNetwork(AlliancePrismInformation(prismInfo.prism).alliance);
            }
            else
            {
               prism._alliance = null;
            }
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
      
      public function get nuggetsCount() : uint
      {
         return this._nuggetsCount;
      }
      
      public function get moduleObject() : ObjectItem
      {
         return this._moduleObject;
      }
      
      public function get cristalObject() : ObjectItem
      {
         return this._cristalObject;
      }
      
      public function get moduleType() : int
      {
         return this._moduleType;
      }
      
      public function get cristalType() : int
      {
         return this._cristalType;
      }
      
      public function get durability() : uint
      {
         return this._durability;
      }
      
      public function get nextEvolutionDate() : Number
      {
         return this._nextEvolutionDate;
      }
      
      public function get cristalNumberLeft() : uint
      {
         return this._cristalNumberLeft;
      }
      
      public function get placementDate() : uint
      {
         return this._placementDate;
      }
      
      public function get alliance() : AllianceWrapper
      {
         return this._alliance;
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
   }
}
