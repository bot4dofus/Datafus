package Ankama_Job.ui
{
   import Ankama_Common.Common;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.CloseInventoryAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeReadyAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeRefuseAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.dofus.uiApi.AveragePricesApi;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.StorageApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.utils.Dictionary;
   
   public class Recycle
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="StorageApi")]
      public var storageApi:StorageApi;
      
      [Api(name="AveragePricesApi")]
      public var averagePricesApi:AveragePricesApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      public var btn_close:ButtonContainer;
      
      public var gd_items:Grid;
      
      public var lbl_explanation:Label;
      
      public var lbl_distribution:Label;
      
      public var lbl_myTotal:Label;
      
      public var lbl_allianceTotal:Label;
      
      public var lbl_quantityObject:Label;
      
      public var lbl_objectsPrice:Label;
      
      public var lbl_minePrice:Label;
      
      public var lbl_alliancePrice:Label;
      
      public var btn_recycle:ButtonContainer;
      
      public var btn_tabItem:ButtonContainer;
      
      public var btn_tabBonus:ButtonContainer;
      
      public var btn_tabMyNuggets:ButtonContainer;
      
      public var btn_tabAllianceNuggets:ButtonContainer;
      
      public var tx_kama1:Texture;
      
      public var tx_kama2:Texture;
      
      public var tx_kama3:Texture;
      
      public var tx_nugget:Texture;
      
      private var _itemsToRecycle:Array;
      
      private var _recyclingSubareaIds:Array;
      
      private var _item:Object;
      
      private var _compInteractiveList:Dictionary;
      
      private var _estimatedItemsPrice:Number = 0;
      
      private var _nuggetAveragePrice:Number = -1;
      
      private var _charNuggetsQuantity:Number = 0;
      
      private var _allianceNuggetsQuantity:Number = 0;
      
      private var _distributionCharPercent:int;
      
      private var _distributionAlliancePercent:int;
      
      private var _modeResult:Boolean = false;
      
      private var ZONE_BONUS:int = 2;
      
      public function Recycle()
      {
         this._itemsToRecycle = [];
         this._recyclingSubareaIds = [];
         this._compInteractiveList = new Dictionary(true);
         super();
      }
      
      public function main(param:Object) : void
      {
         var prismInfo:PrismSubAreaWrapper = null;
         var prismId:int = 0;
         var mo:ObjectItem = null;
         var effect:ObjectEffect = null;
         this.sysApi.disableWorldInteraction(false);
         this.sysApi.addHook(ExchangeHookList.ExchangeObjectModified,this.onExchangeObjectModified);
         this.sysApi.addHook(ExchangeHookList.ExchangeObjectAdded,this.onExchangeObjectAdded);
         this.sysApi.addHook(ExchangeHookList.ExchangeObjectRemoved,this.onExchangeObjectRemoved);
         this.sysApi.addHook(HookList.DoubleClickItemInventory,this.onDoubleClickItemInventory);
         this.sysApi.addHook(ExchangeHookList.ExchangeLeave,this.onExchangeLeave);
         this.sysApi.addHook(ExchangeHookList.ExchangeObjectListAdded,this.onExchangeObjectListAdded);
         this.sysApi.addHook(ExchangeHookList.ExchangeObjectListModified,this.onExchangeObjectListModified);
         this.sysApi.addHook(ExchangeHookList.ExchangeObjectListRemoved,this.onExchangeObjectListRemoved);
         this.sysApi.addHook(CraftHookList.RecycleResult,this.onRecycleResult);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addComponentHook(this.btn_tabBonus,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_tabBonus,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_distribution,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_distribution,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_myTotal,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_myTotal,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_allianceTotal,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_allianceTotal,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_tabMyNuggets,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_tabMyNuggets,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_tabAllianceNuggets,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_tabAllianceNuggets,ComponentHookList.ON_ROLL_OUT);
         this.gd_items.autoSelectMode = 0;
         this.gd_items.dropValidator = this.dropValidatorFunction as Function;
         this.gd_items.processDrop = this.processDropFunction as Function;
         this.gd_items.removeDropSource = this.removeDropSourceFunction as Function;
         this.gd_items.mouseEnabled = true;
         this.gd_items.dataProvider = [];
         this.btn_recycle.disabled = true;
         this.sysApi.disableWorldInteraction();
         var nugget:Item = this.dataApi.getItem(DataEnum.ITEM_GID_NUGGET);
         if(nugget)
         {
            this.tx_nugget.uri = this.uiApi.createUri(this.uiApi.me().getConstant("item_path") + nugget.iconId + ".swf");
         }
         var prismIds:Vector.<uint> = this.socialApi.getAlliance().prismIds;
         for each(prismId in prismIds)
         {
            prismInfo = this.socialApi.getPrismSubAreaById(prismId);
            for each(mo in prismInfo.modulesObjects)
            {
               for each(effect in mo.effects)
               {
                  if(effect.actionId == ActionIds.ACTION_NUGGETS_REPARTITION)
                  {
                     this._recyclingSubareaIds.push(prismId);
                  }
               }
            }
         }
         this._nuggetAveragePrice = this.averagePricesApi.getItemAveragePrice(DataEnum.ITEM_GID_NUGGET);
         this._distributionCharPercent = param[0];
         this._distributionAlliancePercent = param[1];
         this.lbl_distribution.text = this.uiApi.getText("ui.recycle.distributionDetailed",this._distributionCharPercent,this._distributionAlliancePercent);
         this.updateGrid();
      }
      
      public function unload() : void
      {
         this.storageApi.removeAllItemMasks("exchange");
         this.storageApi.releaseHooks();
         this.sysApi.sendAction(new ExchangeRefuseAction([]));
         this.sysApi.sendAction(new CloseInventoryAction([]));
         this.sysApi.enableWorldInteraction();
      }
      
      public function updateItemLine(data:*, components:*, selected:Boolean) : void
      {
         components.slot_item.allowDrag = true;
         if(!this._compInteractiveList[components.slot_item.name])
         {
            this.uiApi.addComponentHook(components.slot_item,ComponentHookList.ON_RIGHT_CLICK);
            this.uiApi.addComponentHook(components.slot_item,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.slot_item,ComponentHookList.ON_ROLL_OUT);
         }
         this._compInteractiveList[components.slot_item.name] = data;
         if(!this._compInteractiveList[components.lbl_areaBonus.name])
         {
            this.uiApi.addComponentHook(components.lbl_areaBonus,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.lbl_areaBonus,ComponentHookList.ON_ROLL_OUT);
         }
         this._compInteractiveList[components.lbl_areaBonus.name] = data;
         if(data)
         {
            components.slot_item.visible = true;
            components.lbl_itemName.text = data.item.shortName;
            if(data.bonus != 0)
            {
               components.lbl_areaBonus.text = data.bonus + "%";
            }
            else
            {
               components.lbl_areaBonus.text = "-";
            }
            components.lbl_myNuggets.text = Math.round(data.charNuggetsQty * 100) / 100;
            components.lbl_allianceNuggets.text = Math.round(data.allianceNuggetsQty * 100) / 100;
            components.slot_item.data = data.item;
            components.tx_backgroundItem.visible = true;
            components.tx_arrow.visible = true;
            if(data.item.etheral)
            {
               components.lbl_itemName.cssClass = "itemetheral";
            }
            else if(data.item.itemSetId != -1)
            {
               components.lbl_itemName.cssClass = "itemset";
            }
            else
            {
               components.lbl_itemName.cssClass = "p";
            }
         }
         else
         {
            components.slot_item.visible = false;
            components.lbl_itemName.text = "";
            components.lbl_areaBonus.text = "";
            components.lbl_myNuggets.text = "";
            components.lbl_allianceNuggets.text = "";
            components.slot_item.data = null;
            components.tx_backgroundItem.visible = false;
            components.tx_arrow.visible = false;
         }
      }
      
      public function dropValidatorFunction(target:Object, data:Object, source:Object) : Boolean
      {
         return data && data is ItemWrapper;
      }
      
      public function removeDropSourceFunction(target:Object) : void
      {
      }
      
      public function processDropFunction(target:Object, data:Object, source:Object) : void
      {
         if(this.dropValidatorFunction(target,data,source))
         {
            this._item = data;
            if(data.quantity > 1)
            {
               this.modCommon.openQuantityPopup(1,data.quantity,data.quantity,this.onValidQty);
            }
            else
            {
               this.onValidQty(1);
            }
         }
      }
      
      private function validateDecraft() : void
      {
         this.sysApi.sendAction(new ExchangeReadyAction([true]));
      }
      
      private function updateGrid() : void
      {
         this.storageApi.releaseHooks();
         this.gd_items.dataProvider = this._itemsToRecycle;
         if(this._itemsToRecycle.length > 0)
         {
            this._modeResult = false;
            this.lbl_explanation.visible = false;
            this.tx_kama1.visible = true;
            this.tx_kama2.visible = true;
            this.tx_kama3.visible = true;
            this.lbl_quantityObject.text = "" + this._itemsToRecycle.length + "/" + ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT;
            this.btn_recycle.disabled = false;
            this.lbl_myTotal.text = (Math.round(this._charNuggetsQuantity * 100) / 100).toString();
            this.lbl_allianceTotal.text = (Math.round(this._allianceNuggetsQuantity * 100) / 100).toString();
            this.lbl_objectsPrice.text = this._estimatedItemsPrice.toString();
            this.lbl_minePrice.text = Math.floor(this._charNuggetsQuantity * this._nuggetAveragePrice).toString();
            this.lbl_alliancePrice.text = Math.floor(this._allianceNuggetsQuantity * this._nuggetAveragePrice).toString();
         }
         else
         {
            this.lbl_quantityObject.text = "";
            this.btn_recycle.disabled = true;
            this.lbl_myTotal.text = "";
            this.lbl_allianceTotal.text = "";
            this.lbl_objectsPrice.text = "";
            this.lbl_minePrice.text = "";
            this.lbl_alliancePrice.text = "";
            this.lbl_explanation.visible = true;
            this.tx_kama1.visible = false;
            this.tx_kama2.visible = false;
            this.tx_kama3.visible = false;
            this._estimatedItemsPrice = 0;
            this._charNuggetsQuantity = 0;
            this._allianceNuggetsQuantity = 0;
         }
      }
      
      private function compareItemsAveragePrices(pItemA:Object, pItemB:Object) : int
      {
         var itemAPrice:Number = this.averagePricesApi.getItemAveragePrice(pItemA.objectGID) * pItemA.quantity;
         var itemBPrice:Number = this.averagePricesApi.getItemAveragePrice(pItemB.objectGID) * pItemB.quantity;
         return itemAPrice < itemBPrice ? 1 : (itemAPrice > itemBPrice ? -1 : 0);
      }
      
      private function prepareItem(itemWrapper:Object) : Object
      {
         var nuggetsBySubarea:Object = null;
         var bonus:int = 0;
         var itemWithNuggets:Object = {
            "item":itemWrapper,
            "bonus":0,
            "charNuggetsQty":0,
            "allianceNuggetsQty":0
         };
         var nuggets:Number = 0;
         for each(nuggetsBySubarea in itemWrapper.nuggetsBySubarea)
         {
            if(this._recyclingSubareaIds.indexOf(nuggetsBySubarea[0]) != -1)
            {
               nuggets += this.ZONE_BONUS * nuggetsBySubarea[1];
            }
            else
            {
               nuggets += nuggetsBySubarea[1];
            }
         }
         bonus = 0;
         if(itemWrapper.nuggetsQuantity > 0)
         {
            bonus = Math.round(nuggets / itemWrapper.nuggetsQuantity * 100) - 100;
         }
         var charNuggets:Number = nuggets * itemWrapper.quantity * this._distributionCharPercent / 100;
         var allianceNuggets:Number = nuggets * itemWrapper.quantity * this._distributionAlliancePercent / 100;
         itemWithNuggets.bonus = bonus;
         itemWithNuggets.charNuggetsQty = charNuggets;
         itemWithNuggets.allianceNuggetsQty = allianceNuggets;
         return itemWithNuggets;
      }
      
      protected function onRecycleResult(nuggetsForPlayer:uint, nuggetsForPrism:uint) : void
      {
         this._modeResult = true;
         this._itemsToRecycle = [];
         this.storageApi.removeAllItemMasks("exchange");
         this.lbl_myTotal.text = this.utilApi.kamasToString(nuggetsForPlayer,"");
         this.lbl_allianceTotal.text = this.utilApi.kamasToString(nuggetsForPrism,"");
         this.updateGrid();
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var selectedItem:Object = null;
         if(target == this.gd_items)
         {
            selectedItem = this.gd_items.selectedItem;
            if(!selectedItem)
            {
               return;
            }
            switch(selectMethod)
            {
               case SelectMethodEnum.DOUBLE_CLICK:
                  this.sysApi.sendAction(new ExchangeObjectMoveAction([selectedItem.item.objectUID,-1]));
                  break;
               case SelectMethodEnum.CTRL_DOUBLE_CLICK:
                  this.sysApi.sendAction(new ExchangeObjectMoveAction([selectedItem.item.objectUID,-selectedItem.item.quantity]));
                  break;
               case SelectMethodEnum.ALT_DOUBLE_CLICK:
                  this._item = selectedItem.item;
                  this.modCommon.openQuantityPopup(1,this._item.quantity,this._item.quantity,this.onAltValidQty);
            }
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.sysApi.sendAction(new LeaveDialogRequestAction([]));
               break;
            case this.btn_recycle:
               if(this._itemsToRecycle.length > 0)
               {
                  this.sysApi.sendAction(new ExchangeReadyAction([true]));
                  this.storageApi.removeAllItemMasks("exchange");
               }
         }
      }
      
      public function onDoubleClickItemInventory(item:Object, quantity:int = 1) : void
      {
         if(!item)
         {
            return;
         }
         this._item = item;
         this.onValidQty(quantity);
      }
      
      public function onItemRightClick(target:GraphicContainer, item:Object) : void
      {
         if(item.data == null)
         {
            return;
         }
         var contextMenu:Object = this.menuApi.create(item.data);
         var itemTooltipSettings:ItemTooltipSettings = this.sysApi.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
         if(!itemTooltipSettings)
         {
            itemTooltipSettings = this.tooltipApi.createItemSettings();
            this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
         }
         var disabled:Boolean = contextMenu.content[0].disabled;
         this.modContextMenu.createContextMenu(contextMenu);
      }
      
      public function onRightClick(target:GraphicContainer) : void
      {
         if((target as Slot).data == null)
         {
            return;
         }
         var data:Object = (target as Slot).data;
         if(data.hasOwnProperty("item") && data.item)
         {
            data = data.item;
         }
         var contextMenu:ContextMenuData = this.menuApi.create(data);
         var itemTooltipSettings:ItemTooltipSettings = this.sysApi.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
         if(!itemTooltipSettings)
         {
            itemTooltipSettings = this.tooltipApi.createItemSettings();
            this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
         }
         if(contextMenu.content.length > 0)
         {
            this.modContextMenu.createContextMenu(contextMenu);
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var info:* = null;
         var data:Object = null;
         var itemTooltipSettings:ItemTooltipSettings = null;
         var tooltipData:Object = null;
         var pos:Object = {
            "point":LocationEnum.POINT_BOTTOM,
            "relativePoint":LocationEnum.POINT_TOP
         };
         switch(target)
         {
            case this.btn_tabBonus:
               info = this.uiApi.getText("ui.recycle.bonusHelp");
               break;
            case this.lbl_distribution:
               info = this.uiApi.getText("ui.recycle.distributionHelp");
               break;
            case this.lbl_myTotal:
               if(!this._modeResult && this.lbl_myTotal.text != "")
               {
                  info = this.uiApi.getText("ui.recycle.myNuggetsHelp");
               }
               break;
            case this.lbl_allianceTotal:
               if(!this._modeResult && this.lbl_allianceTotal.text != "")
               {
                  info = this.uiApi.getText("ui.recycle.allianceNuggetsHelp");
               }
               break;
            case this.btn_tabMyNuggets:
               info = this.uiApi.getText("ui.recycle.myNuggetsHelp");
               break;
            case this.btn_tabAllianceNuggets:
               info = this.uiApi.getText("ui.recycle.allianceNuggetsHelp");
               break;
            default:
               if(target.name.indexOf("lbl_percent") != -1 && this._compInteractiveList[target.name])
               {
                  data = this._compInteractiveList[target.name];
                  if(data.item.recipeSlots == 0 && !data.item.secretRecipe)
                  {
                     info = this.uiApi.getText("ui.crush.lockedCoefficientHelp");
                  }
                  else if(data.bonusMax != data.bonusMin)
                  {
                     info = data.bonusMax + " " + this.uiApi.getText("ui.chat.to") + " " + data.bonusMin + "%";
                  }
               }
               else if(target.name.indexOf("lbl_areaBonus") != -1)
               {
                  data = this._compInteractiveList[target.name];
                  if(data && data.bonus != 0)
                  {
                     info = this.uiApi.getText("ui.recycle.bonusHelp");
                  }
               }
               else if(target.name.indexOf("slot_item") != -1)
               {
                  itemTooltipSettings = this.sysApi.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
                  if(!itemTooltipSettings)
                  {
                     itemTooltipSettings = this.tooltipApi.createItemSettings();
                     this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
                  }
                  if(this._compInteractiveList[target.name].hasOwnProperty("item") && this._compInteractiveList[target.name].item)
                  {
                     tooltipData = this._compInteractiveList[target.name].item;
                  }
                  else
                  {
                     tooltipData = this._compInteractiveList[target.name];
                  }
                  if(!itemTooltipSettings.header && !itemTooltipSettings.conditions && !itemTooltipSettings.effects && !itemTooltipSettings.description && !itemTooltipSettings.averagePrice)
                  {
                     tooltipData = tooltipData.name;
                  }
                  this.uiApi.showTooltip(tooltipData,target,false,"standard",7,7,0,"itemName",null,{
                     "header":itemTooltipSettings.header,
                     "conditions":itemTooltipSettings.conditions,
                     "description":itemTooltipSettings.description,
                     "averagePrice":itemTooltipSettings.averagePrice,
                     "showEffects":itemTooltipSettings.effects
                  },"ItemInfo");
               }
         }
         if(info)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(info),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onItemRollOver(target:GraphicContainer, item:Object) : void
      {
      }
      
      public function onItemRollOut(target:GraphicContainer, item:Object) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "closeUi":
               this.sysApi.sendAction(new LeaveDialogRequestAction([]));
               return true;
            default:
               return false;
         }
      }
      
      private function onValidQty(qty:Number) : void
      {
         this.sysApi.sendAction(new ExchangeObjectMoveAction([this._item.objectUID,qty]));
      }
      
      private function onAltValidQty(qty:Number) : void
      {
         this.sysApi.sendAction(new ExchangeObjectMoveAction([this._item.objectUID,-qty]));
      }
      
      private function onExchangeObjectAdded(itemWrapper:Object, remote:Object) : void
      {
         this.soundApi.playSound(SoundTypeEnum.SWITCH_RIGHT_TO_LEFT);
         this.storageApi.addItemMask(itemWrapper.objectUID,"exchange",itemWrapper.quantity);
         var dataObject:Object = this.prepareItem(itemWrapper);
         this._itemsToRecycle.push(dataObject);
         this._estimatedItemsPrice += this.averagePricesApi.getItemAveragePrice(itemWrapper.objectGID) * itemWrapper.quantity;
         this._charNuggetsQuantity += dataObject.charNuggetsQty;
         this._allianceNuggetsQuantity += dataObject.allianceNuggetsQty;
         this.sysApi.log(2,"Adding 0 ? " + dataObject.item.name + "_estimatedItemsPrice=" + this._estimatedItemsPrice + "_charNuggetsQuantity=" + this._charNuggetsQuantity + "_allianceNuggetsQuantity=" + this._allianceNuggetsQuantity);
         this.updateGrid();
      }
      
      private function onExchangeObjectListAdded(objectList:Object, remote:Object) : void
      {
         var wrapper:ItemWrapper = null;
         var dataObject:Object = null;
         this.soundApi.playSound(SoundTypeEnum.SWITCH_RIGHT_TO_LEFT);
         for each(wrapper in objectList)
         {
            this.storageApi.addItemMask(wrapper.objectUID,"exchange",wrapper.quantity);
            dataObject = this.prepareItem(wrapper);
            this._itemsToRecycle.push(dataObject);
            this._estimatedItemsPrice += this.averagePricesApi.getItemAveragePrice(wrapper.objectGID) * wrapper.quantity;
            this._charNuggetsQuantity += dataObject.charNuggetsQty;
            this._allianceNuggetsQuantity += dataObject.allianceNuggetsQty;
            this.sysApi.log(2,"Adding 1 ? " + dataObject.item.name + "_estimatedItemsPrice=" + this._estimatedItemsPrice + "_charNuggetsQuantity=" + this._charNuggetsQuantity + "_allianceNuggetsQuantity=" + this._allianceNuggetsQuantity);
         }
         this.updateGrid();
      }
      
      private function onExchangeObjectModified(itemWrapper:Object, remote:Boolean) : void
      {
         var index:String = null;
         var i:* = null;
         var itemPrice:Number = NaN;
         var dataObject:Object = null;
         this.soundApi.playSound(SoundTypeEnum.SWITCH_RIGHT_TO_LEFT);
         for(i in this._itemsToRecycle)
         {
            if(this._itemsToRecycle[i].item.objectUID == itemWrapper.objectUID)
            {
               index = i;
               itemPrice = this.averagePricesApi.getItemAveragePrice(itemWrapper.objectGID);
               this._estimatedItemsPrice -= itemPrice * this._itemsToRecycle[i].item.quantity;
               this._estimatedItemsPrice += itemPrice * itemWrapper.quantity;
               this._charNuggetsQuantity -= this._itemsToRecycle[i].charNuggetsQty;
               this._allianceNuggetsQuantity -= this._itemsToRecycle[i].allianceNuggetsQty;
               this.sysApi.log(2,"Modif 1 ? " + this._itemsToRecycle[i].item.name + "_estimatedItemsPrice=" + this._estimatedItemsPrice + "_charNuggetsQuantity=" + this._charNuggetsQuantity + "_allianceNuggetsQuantity=" + this._allianceNuggetsQuantity);
               break;
            }
         }
         if(index)
         {
            dataObject = this.prepareItem(itemWrapper);
            this._itemsToRecycle.splice(index,1,dataObject);
            this._charNuggetsQuantity += dataObject.charNuggetsQty;
            this._allianceNuggetsQuantity += dataObject.allianceNuggetsQty;
            this.sysApi.log(2,"Modif 1 ? " + dataObject.item.name + "_estimatedItemsPrice=" + this._estimatedItemsPrice + "_charNuggetsQuantity=" + this._charNuggetsQuantity + "_allianceNuggetsQuantity=" + this._allianceNuggetsQuantity);
            this.storageApi.addItemMask(itemWrapper.objectUID,"exchange",itemWrapper.quantity);
            this.updateGrid();
         }
      }
      
      private function onExchangeObjectListModified(objectList:Object, remote:Boolean) : void
      {
         var index:String = null;
         var itemWrapper:ItemWrapper = null;
         var i:* = null;
         var itemPrice:Number = NaN;
         var dataObject:Object = null;
         this.soundApi.playSound(SoundTypeEnum.SWITCH_RIGHT_TO_LEFT);
         for each(itemWrapper in objectList)
         {
            for(i in this._itemsToRecycle)
            {
               if(this._itemsToRecycle[i].item.objectUID == itemWrapper.objectUID)
               {
                  index = i;
                  itemPrice = this.averagePricesApi.getItemAveragePrice(itemWrapper.objectGID);
                  this._estimatedItemsPrice -= itemPrice * this._itemsToRecycle[i].item.quantity;
                  this._estimatedItemsPrice += itemPrice * itemWrapper.quantity;
                  this._charNuggetsQuantity -= this._itemsToRecycle[i].charNuggetsQty;
                  this._allianceNuggetsQuantity -= this._itemsToRecycle[i].allianceNuggetsQty;
                  this.sysApi.log(2,"Modif ? " + this._itemsToRecycle[i].item.name + "_estimatedItemsPrice=" + this._estimatedItemsPrice + "_charNuggetsQuantity=" + this._charNuggetsQuantity + "_allianceNuggetsQuantity=" + this._allianceNuggetsQuantity);
                  break;
               }
            }
            if(index)
            {
               dataObject = this.prepareItem(itemWrapper);
               this._itemsToRecycle.splice(index,1,dataObject);
               this._charNuggetsQuantity += dataObject.charNuggetsQty;
               this._allianceNuggetsQuantity += dataObject.allianceNuggetsQty;
               this.sysApi.log(2,"Modif ? " + dataObject.item.name + "_estimatedItemsPrice=" + this._estimatedItemsPrice + "_charNuggetsQuantity=" + this._charNuggetsQuantity + "_allianceNuggetsQuantity=" + this._allianceNuggetsQuantity);
               this.storageApi.addItemMask(itemWrapper.objectUID,"exchange",itemWrapper.quantity);
            }
         }
         this.updateGrid();
      }
      
      private function onExchangeObjectRemoved(itemUID:int, remote:Boolean) : void
      {
         var index:String = null;
         var i:* = null;
         this.soundApi.playSound(SoundTypeEnum.SWITCH_LEFT_TO_RIGHT);
         for(i in this._itemsToRecycle)
         {
            if(this._itemsToRecycle[i].item.objectUID == itemUID)
            {
               index = i;
               this._estimatedItemsPrice -= this.averagePricesApi.getItemAveragePrice(this._itemsToRecycle[i].item.objectGID) * this._itemsToRecycle[i].item.quantity;
               this._charNuggetsQuantity -= this._itemsToRecycle[i].charNuggetsQty;
               this._allianceNuggetsQuantity -= this._itemsToRecycle[i].allianceNuggetsQty;
               this.sysApi.log(2,"Removing 1 " + this._itemsToRecycle[i].item.name + "_estimatedItemsPrice=" + this._estimatedItemsPrice + "_charNuggetsQuantity=" + this._charNuggetsQuantity + "_allianceNuggetsQuantity=" + this._allianceNuggetsQuantity);
               break;
            }
         }
         if(index)
         {
            this._itemsToRecycle.splice(index,1);
            this.storageApi.removeItemMask(itemUID,"exchange");
            this.updateGrid();
         }
      }
      
      private function onExchangeObjectListRemoved(itemUIDList:Object, remote:Boolean) : void
      {
         var itemUID:int = 0;
         var index:String = null;
         var i:* = null;
         this.soundApi.playSound(SoundTypeEnum.SWITCH_LEFT_TO_RIGHT);
         for each(itemUID in itemUIDList)
         {
            for(i in this._itemsToRecycle)
            {
               if(this._itemsToRecycle[i].item.objectUID == itemUID)
               {
                  index = i;
                  this._estimatedItemsPrice -= this.averagePricesApi.getItemAveragePrice(this._itemsToRecycle[i].item.objectGID) * this._itemsToRecycle[i].item.quantity;
                  this._charNuggetsQuantity -= this._itemsToRecycle[i].charNuggetsQty;
                  this._allianceNuggetsQuantity -= this._itemsToRecycle[i].allianceNuggetsQty;
                  this.sysApi.log(2,"Removing " + this._itemsToRecycle[i].item.name + "_estimatedItemsPrice=" + this._estimatedItemsPrice + "_charNuggetsQuantity=" + this._charNuggetsQuantity + "_allianceNuggetsQuantity=" + this._allianceNuggetsQuantity);
                  break;
               }
            }
            if(index)
            {
               this._itemsToRecycle.splice(index,1);
               this.storageApi.removeItemMask(itemUID,"exchange");
            }
         }
         this.updateGrid();
      }
      
      private function onExchangeLeave(success:Boolean) : void
      {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
   }
}
