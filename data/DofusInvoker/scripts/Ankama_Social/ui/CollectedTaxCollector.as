package Ankama_Social.ui
{
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildWrapper;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   import com.ankamagames.dofus.uiApi.AveragePricesApi;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.utils.Dictionary;
   
   public class CollectedTaxCollector
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="AveragePricesApi")]
      public var averagePricesApi:AveragePricesApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      public var lbl_title:Label;
      
      public var btn_close:ButtonContainer;
      
      public var ed_pony:EntityDisplayer;
      
      public var lbl_taxCollector_name:Label;
      
      public var lbl_taxCollector_localisation:Label;
      
      public var lbl_taxCollector_xp_text:Label;
      
      public var lbl_taxCollector_xp_value:Label;
      
      public var lbl_totalEstimatedKamas_text:Label;
      
      public var lbl_totalEstimatedKamas_value:Label;
      
      public var lbl_totalPods_value:Label;
      
      public var lbl_taxCollectorOwner_value:Label;
      
      public var btn_sortItemName:ButtonContainer;
      
      public var btn_sortItemQuantity:ButtonContainer;
      
      public var btn_sortEstimatedKamas:ButtonContainer;
      
      public var gd_items:Grid;
      
      private var _collectedTaxCollector:Object;
      
      private var _ascendingSort:Boolean;
      
      private var _sortFieldAssoc:Dictionary;
      
      private var _lastSortType:String;
      
      protected var _componentsList:Dictionary;
      
      public function CollectedTaxCollector()
      {
         this._sortFieldAssoc = new Dictionary();
         this._componentsList = new Dictionary(true);
         super();
      }
      
      public function main(pParams:Object) : void
      {
         var objItemQty:Object = null;
         var itemObj:Object = null;
         var ponyLook:String = null;
         this._collectedTaxCollector = pParams;
         var myGuild:GuildWrapper = this.socialApi.getGuild();
         if(myGuild)
         {
            ponyLook = "{714|";
            ponyLook += this.dataApi.getEmblemSymbol(myGuild.upEmblem.idEmblem).skinId + "|";
            ponyLook += "7=" + myGuild.backEmblem.color + ",8=" + myGuild.upEmblem.color + "|110}";
            this.ed_pony.look = this.sysApi.getEntityLookFromString(ponyLook);
         }
         this.lbl_taxCollector_name.text = this._collectedTaxCollector.firstName + " " + this._collectedTaxCollector.lastName;
         var subArea:SubArea = this.dataApi.getSubArea(this._collectedTaxCollector.subareaId);
         this.lbl_taxCollector_localisation.text = subArea.name + " ({taxcollectorPosition," + this._collectedTaxCollector.mapWorldX + "," + this._collectedTaxCollector.mapWorldY + "," + subArea.worldmap.id + "," + this._collectedTaxCollector.uniqueId + "::" + this._collectedTaxCollector.mapWorldX + "," + this._collectedTaxCollector.mapWorldY + "})";
         this.lbl_taxCollector_xp_text.text = this.uiApi.getText("ui.common.experiencePoint") + " " + this.uiApi.getText("ui.common.colon");
         this.lbl_taxCollector_xp_value.text = this.utilApi.kamasToString(this._collectedTaxCollector.experience,"");
         var items:Array = [];
         var totalEstimatedKamas:Number = 0;
         for each(objItemQty in this._collectedTaxCollector.collectedItems)
         {
            itemObj = {};
            itemObj.item = this.dataApi.getItemWrapper(objItemQty.objectGID,0,0,objItemQty.quantity);
            itemObj.itemName = itemObj.item.name;
            itemObj.itemQuantity = itemObj.item.quantity;
            itemObj.averagePrice = this.averagePricesApi.getItemAveragePrice(objItemQty.objectGID) * objItemQty.quantity;
            items.push(itemObj);
            totalEstimatedKamas += itemObj.averagePrice;
         }
         this.gd_items.dataProvider = items;
         this.lbl_totalEstimatedKamas_text.text = this.uiApi.getText("ui.exchange.estimatedValue") + " " + this.uiApi.getText("ui.common.colon");
         this.lbl_totalEstimatedKamas_value.text = this.utilApi.kamasToString(totalEstimatedKamas,"K");
         this.lbl_totalPods_value.text = this.utilApi.kamasToString(this._collectedTaxCollector.pods,"");
         this.lbl_taxCollectorOwner_value.text = "{player," + this._collectedTaxCollector.callerName + "," + this._collectedTaxCollector.callerId + "}";
         this._sortFieldAssoc[this.btn_sortItemName] = "itemName";
         this._sortFieldAssoc[this.btn_sortItemQuantity] = "itemQuantity";
         this._sortFieldAssoc[this.btn_sortEstimatedKamas] = "averagePrice";
         this._ascendingSort = true;
         this._lastSortType = "averagePrice";
         this.onRelease(this.btn_sortEstimatedKamas);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onCloseUi);
      }
      
      public function updateItemLine(itemObj:Object, components:*, selected:Boolean) : void
      {
         if(!this._componentsList[components.slot_item.name])
         {
            this.uiApi.addComponentHook(components.slot_item,ComponentHookList.ON_RIGHT_CLICK);
            this.uiApi.addComponentHook(components.slot_item,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.slot_item,ComponentHookList.ON_ROLL_OUT);
         }
         this._componentsList[components.slot_item.name] = itemObj;
         if(itemObj)
         {
            components.slot_item.data = itemObj.item;
            components.lbl_item_name.text = "{item," + itemObj.item.objectGID + "::" + itemObj.itemName + "}";
            components.lbl_item_quantity.text = itemObj.itemQuantity;
            components.lbl_estimated_kamas.text = this.utilApi.kamasToString(itemObj.averagePrice,"");
         }
         else
         {
            components.slot_item.data = null;
            components.lbl_item_name.text = "";
            components.lbl_item_quantity.text = "";
            components.lbl_estimated_kamas.text = "";
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
            case this.btn_sortItemName:
            case this.btn_sortItemQuantity:
            case this.btn_sortEstimatedKamas:
               sortType = this._sortFieldAssoc[pTarget];
               this._ascendingSort = sortType != this._lastSortType ? true : !this._ascendingSort;
               this.gd_items.dataProvider = this.utilApi.sort(this.gd_items.dataProvider,sortType,this._ascendingSort,sortType != "itemName");
               this._lastSortType = sortType;
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var itemTooltipSettings:ItemTooltipSettings = null;
         if(target.name.indexOf("slot_") != -1)
         {
            itemTooltipSettings = this.sysApi.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
            if(itemTooltipSettings == null)
            {
               itemTooltipSettings = this.tooltipApi.createItemSettings();
               this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
            }
            this.uiApi.showTooltip((target as Slot).data,target,false,"standard",3,3,0,null,null,itemTooltipSettings);
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onRightClick(target:GraphicContainer) : void
      {
         var data:Object = null;
         var contextMenu:ContextMenuData = null;
         if(target.name.indexOf("slot_") != -1)
         {
            data = (target as Slot).data;
            contextMenu = this.menuApi.create(data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
      
      public function onCloseUi(pShortCut:String) : Boolean
      {
         this.uiApi.unloadUi(this.uiApi.me().name);
         return true;
      }
   }
}
