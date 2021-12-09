package Ankama_Social.ui.data
{
   import Ankama_Social.Api;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.SocialEntityInFightWrapper;
   import com.ankamagames.dofus.internalDatacenter.guild.TaxCollectorWrapper;
   import com.ankamagames.dofus.network.enums.TaxCollectorStateEnum;
   import com.ankamagames.jerakine.types.Uri;
   
   public class SocialEntityDisplayInfo
   {
      
      private static const TYPE_TAX_COLLECTOR:int = 0;
      
      private static const TYPE_PRISM:int = 1;
       
      
      private var _entityTypeId:int;
      
      public var name:String;
      
      public var location:String = "";
      
      public var position:String = "";
      
      public var guildName:String = "";
      
      public var birthDate:String = "";
      
      public var description:String = "";
      
      public var podsAndXp:String = "";
      
      public var belongsToMe:Boolean;
      
      public var elapsedTimePercent:Number = 0;
      
      public var symbolName:String = "tx_conquestTaxCollector.png";
      
      public var state:int = -1;
      
      public var pods:int = -1;
      
      public var xp:int = -1;
      
      private var _symbolUri:Uri;
      
      private var _descriptionOfOwner:String;
      
      private var _descriptionOfStartDate:String;
      
      public function SocialEntityDisplayInfo(data:Object)
      {
         var detailedData:TaxCollectorWrapper = null;
         var detailedPData:PrismSubAreaWrapper = null;
         super();
         if(data is SocialEntityInFightWrapper)
         {
            this._entityTypeId = data.typeId;
            if(data.typeId == TYPE_TAX_COLLECTOR)
            {
               detailedData = Api.social.getTaxCollector(data.uniqueId);
               if(!detailedData)
               {
                  return;
               }
               this.createInfoFromTaxCollector(detailedData);
            }
            else if(data.typeId == TYPE_PRISM)
            {
               detailedPData = Api.social.getPrismSubAreaById(data.uniqueId);
               if(!detailedPData)
               {
                  return;
               }
               this.createInfoFromPrism(detailedPData);
            }
         }
         if(data is TaxCollectorWrapper)
         {
            this.createInfoFromTaxCollector(data as TaxCollectorWrapper);
         }
      }
      
      private function createInfoFromTaxCollector(data:TaxCollectorWrapper) : void
      {
         this.name = data.firstName + " " + data.lastName;
         var subarea:SubArea = Api.data.getSubArea(data.subareaId);
         var worldMapId:uint = subarea.worldmap.id;
         this.location = subarea.name + " - " + subarea.area.name;
         this.position = "({taxcollectorPosition," + data.mapWorldX + "," + data.mapWorldY + "," + worldMapId + "," + data.uniqueId + "::" + data.mapWorldX + "," + data.mapWorldY + "})";
         this.guildName = Api.ui.getText("ui.common.guild") + Api.ui.getText("ui.common.colon") + (!!data.guild ? data.guild.guildName : Api.social.getGuild().guildName);
         this.podsAndXpUpdate(data);
         this.belongsToMe = data.additionalInformation.collectorCallerName == Api.player.getPlayedCharacterInfo().name;
         this._descriptionOfOwner = Api.ui.getText("ui.common.ownerWord") + Api.ui.getText("ui.common.colon") + data.additionalInformation.collectorCallerName + "\n";
         this._descriptionOfStartDate = Api.ui.getText("ui.social.guild.taxStartDate") + Api.ui.getText("ui.common.colon") + Api.time.getDofusDate(data.additionalInformation.date * 1000) + " " + Api.time.getClock(data.additionalInformation.date * 1000);
         this.stateUpdate(data.state);
      }
      
      private function createInfoFromPrism(data:PrismSubAreaWrapper) : void
      {
         this.name = Api.ui.getText("ui.zaap.prism") + " " + data.alliance.allianceName;
         var subarea:SubArea = Api.data.getSubArea(data.subAreaId);
         this.location = subarea.name + " - " + subarea.area.name + " (" + data.worldX + "," + data.worldY + ")";
         this.birthDate = Api.ui.getText("ui.prism.placed",Api.time.getDate(data.placementDate * 1000));
         if(data.isVillage)
         {
            this.symbolName = "tx_conquestVillage.png";
         }
         else
         {
            this.symbolName = "tx_conquestPrism.png";
         }
         this.stateUpdate(data.state);
      }
      
      private function descriptionUpdate() : void
      {
         if(this.state == TaxCollectorStateEnum.STATE_COLLECTING)
         {
            this.description = Api.ui.getText("ui.social.guild.taxInCollect") + "\n";
            this.elapsedTimePercent = 1;
         }
         else if(this.state == TaxCollectorStateEnum.STATE_FIGHTING)
         {
            this.description = Api.ui.getText("ui.social.guild.taxInFight") + "\n";
            this.elapsedTimePercent = 1;
         }
         else if(this.state == TaxCollectorStateEnum.STATE_WAITING_FOR_HELP)
         {
            this.description = Api.ui.getText("ui.social.guild.taxInEnterFight") + "\n";
         }
         this.description += this._descriptionOfOwner;
         this.description += this._descriptionOfStartDate;
      }
      
      public function get symbolUri() : Uri
      {
         return this._symbolUri;
      }
      
      public function set symbolUri(uri:Uri) : void
      {
         this._symbolUri = uri;
      }
      
      public function podsAndXpUpdate(data:TaxCollectorWrapper) : void
      {
         if(data.pods == this.pods && data.experience == this.xp)
         {
            return;
         }
         this.podsAndXp = "";
         if(Api.config.isFeatureWithKeywordEnabled("server.heroic"))
         {
            if(data.pods != 0)
            {
               this.podsAndXp = Api.ui.processText(Api.ui.getText("ui.common.short.weight",data.pods),"m",data.pods <= 1);
            }
         }
         else
         {
            this.podsAndXp = Api.ui.getText("ui.social.thingsTaxCollectorGet",Api.ui.processText(Api.ui.getText("ui.common.short.weight",data.pods),"m",data.pods <= 1),Api.util.kamasToString(data.experience,""));
         }
         this.pods = data.pods;
         this.xp = data.experience;
      }
      
      public function stateUpdate(newState:int) : void
      {
         if(newState == this.state)
         {
            return;
         }
         this.state = newState;
         if(this._entityTypeId == TYPE_TAX_COLLECTOR)
         {
            this.descriptionUpdate();
         }
      }
      
      public function startFight() : void
      {
         this.stateUpdate(TaxCollectorStateEnum.STATE_FIGHTING);
      }
   }
}
