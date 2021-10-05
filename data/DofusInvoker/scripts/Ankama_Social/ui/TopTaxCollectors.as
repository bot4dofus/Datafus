package Ankama_Social.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.guild.TaxCollectorWrapper;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.utils.Dictionary;
   
   public class TopTaxCollectors
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      public var lbl_title:Label;
      
      public var btn_close:ButtonContainer;
      
      public var btn_dungeonTaxCollectors:ButtonContainer;
      
      public var btn_taxCollectors:ButtonContainer;
      
      public var gd_taxCollectors:Grid;
      
      public var lbl_sortGuild:Label;
      
      public var btn_sortGuild:ButtonContainer;
      
      public var lbl_sortEstimatedValue:Label;
      
      public var btn_sortEstimatedValue:ButtonContainer;
      
      public var lbl_sortSubArea:Label;
      
      public var btn_sortSubArea:ButtonContainer;
      
      public var lbl_sortCoordinates:Label;
      
      public var btn_sortCoordinates:ButtonContainer;
      
      private var _dungeonTopTaxCollectors:Array;
      
      private var _topTaxCollectors:Array;
      
      private var _currentDataProvider:Array;
      
      private var _sortFieldAssoc:Dictionary;
      
      private var _ascendingSort:Boolean;
      
      private var _lastSortType:String;
      
      public function TopTaxCollectors()
      {
         super();
      }
      
      public function main(pParams:Object) : void
      {
         this._dungeonTopTaxCollectors = this.createDataProvider(pParams.dungeonTopTaxCollectors);
         this._topTaxCollectors = this.createDataProvider(pParams.topTaxCollectors);
         this._sortFieldAssoc = new Dictionary();
         this._sortFieldAssoc[this.btn_sortGuild] = "guildName";
         this._sortFieldAssoc[this.btn_sortEstimatedValue] = "estimatedValue";
         this._sortFieldAssoc[this.btn_sortSubArea] = "location";
         this.lbl_title.text = this.uiApi.getText("ui.social.topTaxCollectors");
         this.btn_dungeonTaxCollectors.selected = true;
         this.gd_taxCollectors.dataProvider = this._currentDataProvider = this._dungeonTopTaxCollectors;
         this.sortDataByEstimatedValueDESC();
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onCloseUi);
      }
      
      public function updateItemLine(taxCollectorData:Object, components:*, selected:Boolean) : void
      {
         if(taxCollectorData)
         {
            components.lbl_taxCollectorGuild.text = taxCollectorData.guildLink;
            components.lbl_taxCollectorEstimatedValue.text = this.utilApi.kamasToString(taxCollectorData.estimatedValue,"");
            components.lbl_taxCollectorSubArea.text = taxCollectorData.location;
            components.lbl_taxCollectorCoordinates.text = taxCollectorData.coordsLink;
            components.tx_estimatedValue.visible = true;
         }
         else
         {
            components.lbl_taxCollectorGuild.text = "";
            components.lbl_taxCollectorEstimatedValue.text = "";
            components.lbl_taxCollectorSubArea.text = "";
            components.lbl_taxCollectorCoordinates.text = "";
            components.tx_estimatedValue.visible = false;
         }
      }
      
      public function onRelease(pTarget:GraphicContainer) : void
      {
         var sortType:String = null;
         switch(pTarget)
         {
            case this.btn_close:
               this.onCloseUi(null);
               break;
            case this.btn_dungeonTaxCollectors:
               this.gd_taxCollectors.dataProvider = this._currentDataProvider = this._dungeonTopTaxCollectors;
               this.sortDataByEstimatedValueDESC();
               this._lastSortType = "estimatedValue";
               break;
            case this.btn_taxCollectors:
               this.gd_taxCollectors.dataProvider = this._currentDataProvider = this._topTaxCollectors;
               this.sortDataByEstimatedValueDESC();
               this._lastSortType = "estimatedValue";
               break;
            case this.btn_sortGuild:
            case this.btn_sortEstimatedValue:
            case this.btn_sortSubArea:
               sortType = this._sortFieldAssoc[pTarget];
               this._ascendingSort = sortType != this._lastSortType ? true : !this._ascendingSort;
               this.gd_taxCollectors.dataProvider = this.utilApi.sort(this.gd_taxCollectors.dataProvider,sortType,this._ascendingSort,sortType == "estimatedValue");
               this._lastSortType = sortType;
               break;
            case this.btn_sortCoordinates:
               sortType = "coords";
               this._ascendingSort = sortType != this._lastSortType ? true : !this._ascendingSort;
               this.gd_taxCollectors.dataProvider = !!this._ascendingSort ? this._currentDataProvider.sort(this.sortDataByCoordinates) : this._currentDataProvider.sort(this.sortDataByCoordinates,Array.DESCENDING);
               this._lastSortType = "coords";
         }
      }
      
      public function onCloseUi(pShortCut:String) : Boolean
      {
         this.uiApi.unloadUi(this.uiApi.me().name);
         return true;
      }
      
      private function createDataProvider(pTaxCollectors:Object) : Array
      {
         var taxCollector:TaxCollectorWrapper = null;
         var taxCollectorData:Object = null;
         var subArea:SubArea = null;
         var dataProvider:Array = [];
         for each(taxCollector in pTaxCollectors)
         {
            subArea = this.dataApi.getSubArea(taxCollector.subareaId);
            taxCollectorData = {
               "guildName":taxCollector.guild.guildName,
               "guildLink":this.chatApi.getGuildLink(taxCollector.guild,taxCollector.guild.guildName),
               "estimatedValue":taxCollector.itemsValue + taxCollector.kamas,
               "location":subArea.area.name + " - " + subArea.name,
               "coordX":taxCollector.mapWorldX,
               "coordY":taxCollector.mapWorldY,
               "coordsLink":"({taxcollectorPosition," + taxCollector.mapWorldX + "," + taxCollector.mapWorldY + "," + subArea.worldmap.id + "," + taxCollector.uniqueId + "::" + taxCollector.mapWorldX + "," + taxCollector.mapWorldY + "})"
            };
            dataProvider.push(taxCollectorData);
         }
         return dataProvider;
      }
      
      private function sortDataByEstimatedValueDESC() : void
      {
         this.gd_taxCollectors.dataProvider = this.utilApi.sort(this.gd_taxCollectors.dataProvider,"estimatedValue",false,true);
         this._ascendingSort = false;
      }
      
      private function sortDataByCoordinates(pDataA:Object, pDataB:Object) : int
      {
         var result:int = 0;
         if(pDataA.coordX < pDataB.coordX)
         {
            result = -1;
         }
         else if(pDataA.coordX > pDataB.coordX)
         {
            result = 1;
         }
         else if(pDataA.coordY < pDataB.coordY)
         {
            result = -1;
         }
         else if(pDataA.coordY > pDataB.coordY)
         {
            result = 1;
         }
         else
         {
            result = 0;
         }
         return result;
      }
   }
}
