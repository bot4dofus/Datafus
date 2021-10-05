package Ankama_Job.ui
{
   import Ankama_Common.Common;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.CloseInventoryAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeReadyAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeReadyCrushAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeRefuseAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.DecraftedItemStackInfo;
   import com.ankamagames.dofus.uiApi.AveragePricesApi;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.StorageApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   import flash.utils.Dictionary;
   
   public class RuneMaker
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
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      public var btn_close:ButtonContainer;
      
      public var runeMakerWindow:GraphicContainer;
      
      public var tx_background:Texture;
      
      public var lbl_subTitle:Label;
      
      public var ctr_content:GraphicContainer;
      
      public var gd_items:Grid;
      
      public var ctr_result:GraphicContainer;
      
      public var gd_results:Grid;
      
      public var lbl_itemsPrice:Label;
      
      public var lbl_runesPrice:Label;
      
      public var lbl_quantityObject:Label;
      
      public var btn_info:ButtonContainer;
      
      public var btn_crush:ButtonContainer;
      
      public var btn_lbl_btn_crush:Label;
      
      public var ctr_runes:GraphicContainer;
      
      public var gd_runes:Grid;
      
      public var lbl_runes:Label;
      
      public var btn_closeRunes:ButtonContainer;
      
      public var ctr_focus:GraphicContainer;
      
      public var cb_effectFocus:ComboBox;
      
      private const _actionIdEligibleRune:Array = [111,112,115,117,118,119,123,124,125,126,128,138,158,160,161,174,176,178,182,210,211,212,213,214,220,225,226,240,241,242,243,244,410,412,414,416,418,420,422,424,426,428,430,752,753,2800,2803,2804,2807,2808,2812];
      
      private var _itemsToCrush:Array;
      
      private var _decraftedItems:Array;
      
      private var _currentState:int = 0;
      
      private var _widthBgState0:int;
      
      private var _widthBgState1:int;
      
      private var _item:Object;
      
      private var _compInteractiveList:Dictionary;
      
      private var _runesLists:Dictionary;
      
      private var _UIDItemForRunesWindow:uint;
      
      public function RuneMaker()
      {
         this._itemsToCrush = [];
         this._decraftedItems = [];
         this._compInteractiveList = new Dictionary(true);
         this._runesLists = new Dictionary(true);
         super();
      }
      
      public function main(param:Object) : void
      {
         this.sysApi.disableWorldInteraction(false);
         this.sysApi.addHook(ExchangeHookList.ExchangeObjectModified,this.onExchangeObjectModified);
         this.sysApi.addHook(ExchangeHookList.ExchangeObjectAdded,this.onExchangeObjectAdded);
         this.sysApi.addHook(ExchangeHookList.ExchangeObjectRemoved,this.onExchangeObjectRemoved);
         this.sysApi.addHook(HookList.DoubleClickItemInventory,this.onDoubleClickItemInventory);
         this.sysApi.addHook(ExchangeHookList.ExchangeLeave,this.onExchangeLeave);
         this.sysApi.addHook(ExchangeHookList.ExchangeObjectListAdded,this.onExchangeObjectListAdded);
         this.sysApi.addHook(ExchangeHookList.ExchangeObjectListModified,this.onExchangeObjectListModified);
         this.sysApi.addHook(ExchangeHookList.ExchangeObjectListRemoved,this.onExchangeObjectListRemoved);
         this.sysApi.addHook(CraftHookList.DecraftResult,this.onDecraftResult);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addComponentHook(this.btn_info,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_info,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.gd_runes,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.gd_runes,ComponentHookList.ON_ITEM_RIGHT_CLICK);
         this.uiApi.addComponentHook(this.gd_runes,ComponentHookList.ON_ITEM_ROLL_OVER);
         this.uiApi.addComponentHook(this.gd_runes,ComponentHookList.ON_ITEM_ROLL_OUT);
         this.gd_items.autoSelectMode = 0;
         this.gd_items.dropValidator = this.dropValidatorFunction as Function;
         this.gd_items.processDrop = this.processDropFunction as Function;
         this.gd_items.removeDropSource = this.removeDropSourceFunction as Function;
         this.gd_items.mouseEnabled = true;
         this.gd_items.dataProvider = [];
         this._widthBgState0 = int(this.uiApi.me().getConstant("bg_width_state0"));
         this._widthBgState1 = int(this.uiApi.me().getConstant("bg_width_state1"));
         this.ctr_runes.visible = false;
         this.btn_crush.disabled = true;
         this.cb_effectFocus.disabled = true;
         this.cb_effectFocus.dataProvider = [{
            "label":this.uiApi.getText("ui.crush.noFocus"),
            "actionId":0
         }];
         this.cb_effectFocus.selectedIndex = 0;
         this.updateUI(false);
         this.sysApi.disableWorldInteraction();
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
         var itemObject:Item = null;
         components.slot_item.allowDrag = true;
         components.btn_item.removeDropSource = this.removeDropSourceFunction;
         components.btn_item.processDrop = this.processDropFunction;
         components.btn_item.dropValidator = this.dropValidatorFunction;
         if(!this._compInteractiveList[components.slot_item.name])
         {
            this.uiApi.addComponentHook(components.slot_item,ComponentHookList.ON_RIGHT_CLICK);
            this.uiApi.addComponentHook(components.slot_item,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.slot_item,ComponentHookList.ON_ROLL_OUT);
         }
         this._compInteractiveList[components.slot_item.name] = data;
         if(data)
         {
            components.btn_item.selected = selected;
            itemObject = this.dataApi.getItem(data.objectGID);
            components.lbl_itemName.text = data.shortName;
            components.slot_item.data = data;
            components.tx_backgroundItem.visible = true;
            if(itemObject.etheral)
            {
               components.lbl_itemName.cssClass = "itemetheral";
            }
            else if(itemObject.itemSetId != -1)
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
            components.lbl_itemName.text = "";
            components.slot_item.data = null;
            components.tx_backgroundItem.visible = false;
            components.btn_item.selected = false;
         }
      }
      
      public function updateResultLine(data:*, components:*, selected:Boolean) : void
      {
         var runesList:String = null;
         var obj:* = undefined;
         components.slot_item.allowDrag = false;
         if(!this._compInteractiveList[components.slot_item.name])
         {
            this.uiApi.addComponentHook(components.slot_item,ComponentHookList.ON_RIGHT_CLICK);
            this.uiApi.addComponentHook(components.slot_item,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.slot_item,ComponentHookList.ON_ROLL_OUT);
         }
         this._compInteractiveList[components.slot_item.name] = data;
         if(!this._compInteractiveList[components.btn_seeMore.name])
         {
            this.uiApi.addComponentHook(components.btn_seeMore,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(components.btn_seeMore,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.btn_seeMore,ComponentHookList.ON_ROLL_OUT);
         }
         this._compInteractiveList[components.btn_seeMore.name] = data;
         if(!this._compInteractiveList[components.lbl_percent.name])
         {
            this.uiApi.addComponentHook(components.lbl_percent,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.lbl_percent,ComponentHookList.ON_ROLL_OUT);
         }
         this._compInteractiveList[components.lbl_percent.name] = data;
         if(!this._compInteractiveList[components.gd_runes.name])
         {
            this.uiApi.addComponentHook(components.gd_runes,ComponentHookList.ON_SELECT_ITEM);
            this.uiApi.addComponentHook(components.gd_runes,ComponentHookList.ON_ITEM_ROLL_OVER);
            this.uiApi.addComponentHook(components.gd_runes,ComponentHookList.ON_ITEM_ROLL_OUT);
            this.uiApi.addComponentHook(components.gd_runes,ComponentHookList.ON_ITEM_RIGHT_CLICK);
         }
         this._compInteractiveList[components.gd_runes.name] = data;
         if(data)
         {
            components.lbl_itemName.text = data.item.shortName;
            if(data.item.recipeSlots == 0 && !data.item.secretRecipe)
            {
               components.lbl_percent.cssClass = "p4center";
            }
            else if(data.bonusMin >= 100)
            {
               components.lbl_percent.cssClass = "boldcenter";
            }
            else
            {
               components.lbl_percent.cssClass = "center";
            }
            components.lbl_percent.text = data.bonusMin + " %";
            components.slot_item.data = data.item;
            components.tx_backgroundItem.visible = true;
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
            components.gd_runes.dataProvider = data.runes;
            if(data.runes.length > 6)
            {
               components.btn_seeMore.visible = true;
               runesList = "";
               for each(obj in data.runes)
               {
                  runesList += obj.quantity + " x " + obj.name + " \n";
               }
               this._runesLists[data.id] = runesList;
            }
            else
            {
               components.btn_seeMore.visible = false;
            }
         }
         else
         {
            components.lbl_itemName.text = "";
            components.lbl_percent.text = "";
            components.slot_item.data = null;
            components.gd_runes.dataProvider = [];
            components.tx_backgroundItem.visible = false;
            components.btn_seeMore.visible = false;
         }
      }
      
      public function dropValidatorFunction(target:Object, data:Object, source:Object) : Boolean
      {
         return this._currentState != 1 && data && data is ItemWrapper && (data as ItemWrapper).category == 0;
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
      
      private function updateUI(resultMode:Boolean = false) : void
      {
         if(!resultMode)
         {
            this._currentState = 0;
            this.lbl_subTitle.text = "";
            this.runeMakerWindow.width = this._widthBgState0;
            this.uiApi.me().render();
            this.btn_lbl_btn_crush.text = this.uiApi.getText("ui.crush.crushAll");
            this.ctr_content.visible = true;
            this.ctr_result.visible = false;
            this.ctr_runes.visible = false;
            this.ctr_focus.visible = true;
            this.gd_results.dataProvider = [];
         }
         else
         {
            this._currentState = 1;
            this.gd_results.dataProvider = this._decraftedItems;
            this.gd_items.dataProvider = [];
            this.lbl_subTitle.text = this.uiApi.getText("ui.crush.result");
            this.runeMakerWindow.width = this._widthBgState1;
            this.uiApi.me().render();
            this.btn_lbl_btn_crush.text = this.uiApi.getText("ui.crush.crushOthers");
            this.ctr_content.visible = false;
            this.ctr_result.visible = true;
            this.ctr_focus.visible = false;
         }
      }
      
      private function validateDecraft() : void
      {
         this.sysApi.sendAction(new ExchangeReadyAction([true]));
      }
      
      private function updateGrid() : void
      {
         var itemToCrush:* = undefined;
         var itemToCrushEffects:* = undefined;
         var baseItemEffects:* = undefined;
         var effectsAvailableToFocusOn:Dictionary = null;
         var effectsIndexes:Dictionary = null;
         var i:int = 0;
         var effect:* = undefined;
         var characteristic:* = undefined;
         var effectId:* = undefined;
         var j:int = 0;
         var effectDesc:String = null;
         var desc:String = null;
         this.storageApi.releaseHooks();
         this.gd_items.dataProvider = this._itemsToCrush;
         var effectFocusData:Array = [{
            "label":this.uiApi.getText("ui.crush.noFocus"),
            "actionId":0,
            "index":-1
         }];
         if(this._itemsToCrush.length > 0)
         {
            effectsAvailableToFocusOn = new Dictionary();
            effectsIndexes = new Dictionary();
            for(i = 0; i < this._itemsToCrush.length; i++)
            {
               itemToCrush = this._itemsToCrush[i];
               itemToCrushEffects = itemToCrush.effects;
               baseItemEffects = itemToCrush.possibleEffects;
               if(itemToCrushEffects)
               {
                  for(j = 0; j < itemToCrushEffects.length; j++)
                  {
                     if(this._actionIdEligibleRune.indexOf(itemToCrushEffects[j].effectId) != -1)
                     {
                        if(!effectsAvailableToFocusOn[itemToCrushEffects[j].effectId])
                        {
                           effectsAvailableToFocusOn[itemToCrushEffects[j].effectId] = 1;
                           effectsIndexes[itemToCrushEffects[j].effectId] = j;
                        }
                        else
                        {
                           ++effectsAvailableToFocusOn[itemToCrushEffects[j].effectId];
                        }
                     }
                  }
               }
               if(baseItemEffects)
               {
                  for(j = 0; j < baseItemEffects.length; j++)
                  {
                     if(this._actionIdEligibleRune.indexOf(baseItemEffects[j].effectId) != -1)
                     {
                        if(!effectsAvailableToFocusOn[baseItemEffects[j].effectId])
                        {
                           effectsAvailableToFocusOn[baseItemEffects[j].effectId] = 1;
                        }
                        else
                        {
                           ++effectsAvailableToFocusOn[baseItemEffects[j].effectId];
                        }
                     }
                  }
               }
            }
            for(effectId in effectsAvailableToFocusOn)
            {
               if(effectsAvailableToFocusOn[effectId] == this._itemsToCrush.length * 2)
               {
                  effect = this.dataApi.getEffect(effectId);
                  if(effect)
                  {
                     characteristic = this.dataApi.getCharacteristic(effect.characteristic);
                     if(characteristic)
                     {
                        effectDesc = effect.description;
                        effectDesc = effectDesc.substr(effectDesc.lastIndexOf("#") + 2);
                        effectDesc = effectDesc.replace(/^\s+|\s+$/gs,"");
                        desc = PatternDecoder.combine(effectDesc,"m",false,false);
                        effectFocusData.push({
                           "label":desc,
                           "actionId":effect.id,
                           "index":effectsIndexes[effect.id]
                        });
                     }
                  }
               }
            }
            this.cb_effectFocus.disabled = effectFocusData.length < 3;
            this.btn_crush.disabled = false;
         }
         else
         {
            this.cb_effectFocus.disabled = true;
            this.btn_crush.disabled = true;
         }
         effectFocusData.sortOn("index",Array.NUMERIC);
         this.cb_effectFocus.dataProvider = effectFocusData;
         this.cb_effectFocus.selectedIndex = 0;
         this.lbl_quantityObject.text = this.uiApi.getText("ui.crush.distinctItems",this._itemsToCrush.length,ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_DECRAFT);
      }
      
      private function compareItemsAveragePrices(pItemA:Object, pItemB:Object) : int
      {
         var itemAPrice:Number = this.averagePricesApi.getItemAveragePrice(pItemA.objectGID) * pItemA.quantity;
         var itemBPrice:Number = this.averagePricesApi.getItemAveragePrice(pItemB.objectGID) * pItemB.quantity;
         return itemAPrice < itemBPrice ? 1 : (itemAPrice > itemBPrice ? -1 : 0);
      }
      
      protected function onDecraftResult(decraftedItems:Object) : void
      {
         var runes:Array = null;
         var runeNumber:int = 0;
         var rune:ItemWrapper = null;
         var crushedItem:Object = null;
         var itemToCrush:ItemWrapper = null;
         var item:DecraftedItemStackInfo = null;
         var i:int = 0;
         var bonusMin:Number = NaN;
         var bonusMax:Number = NaN;
         var id:int = 0;
         var estimatedItemsPrice:Number = 0;
         var estimatedRunesPrice:Number = 0;
         for each(itemToCrush in this._itemsToCrush)
         {
            for each(item in decraftedItems)
            {
               if(itemToCrush.objectUID == item.objectUID)
               {
                  runes = [];
                  runeNumber = item.runesId.length;
                  for(i = 0; i < runeNumber; i++)
                  {
                     if(item.runesQty[i] > 0)
                     {
                        rune = this.dataApi.getItemWrapper(item.runesId[i],0,0,item.runesQty[i]);
                        runes.push(rune);
                        estimatedRunesPrice += this.averagePricesApi.getItemAveragePrice(rune.objectGID) * rune.quantity;
                     }
                  }
                  runes.sort(this.compareItemsAveragePrices);
                  bonusMin = item.bonusMin * 100;
                  if(bonusMin > 0 && bonusMin < 1)
                  {
                     bonusMin = Math.round(bonusMin * 100);
                     bonusMin /= 100;
                  }
                  else
                  {
                     bonusMin = Math.round(bonusMin);
                  }
                  bonusMax = item.bonusMax * 100;
                  if(bonusMax > 0 && bonusMax < 1)
                  {
                     bonusMax = Math.round(bonusMax * 100);
                     bonusMax /= 100;
                  }
                  else
                  {
                     bonusMax = Math.round(bonusMax);
                  }
                  crushedItem = {
                     "id":id,
                     "item":itemToCrush,
                     "bonusMin":bonusMin,
                     "bonusMax":bonusMax,
                     "runes":runes
                  };
                  this._decraftedItems.push(crushedItem);
                  estimatedItemsPrice += this.averagePricesApi.getItemAveragePrice(itemToCrush.objectGID) * itemToCrush.quantity;
                  id++;
               }
            }
         }
         this.updateUI(true);
         this.lbl_itemsPrice.text = this.uiApi.getText("ui.crush.itemsEstimatedPrice") + " " + this.utilApi.kamasToString(estimatedItemsPrice);
         this.lbl_runesPrice.text = this.uiApi.getText("ui.crush.runesEstimatedPrice") + " " + this.utilApi.kamasToString(estimatedRunesPrice);
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var selectedItem:Object = null;
         var item:Object = null;
         if(target == this.gd_items)
         {
            selectedItem = this.gd_items.selectedItem;
            if(!selectedItem || this._currentState == 1)
            {
               return;
            }
            switch(selectMethod)
            {
               case SelectMethodEnum.DOUBLE_CLICK:
                  this.sysApi.sendAction(new ExchangeObjectMoveAction([selectedItem.objectUID,-1]));
                  break;
               case SelectMethodEnum.CTRL_DOUBLE_CLICK:
                  this.sysApi.sendAction(new ExchangeObjectMoveAction([selectedItem.objectUID,-selectedItem.quantity]));
                  break;
               case SelectMethodEnum.ALT_DOUBLE_CLICK:
                  this._item = selectedItem;
                  this.modCommon.openQuantityPopup(1,this._item.quantity,this._item.quantity,this.onAltValidQty);
            }
         }
         else if(target.name.indexOf("gd_runes") != -1 || target == this.gd_runes)
         {
            if(!this.sysApi.getOption("displayTooltips","dofus") && (selectMethod == GridItemSelectMethodEnum.CLICK || selectMethod == GridItemSelectMethodEnum.MANUAL))
            {
               item = (target as Grid).selectedItem;
               this.sysApi.dispatchHook(ChatHookList.ShowObjectLinked,item);
            }
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var focusActionId:uint = 0;
         var data:Object = null;
         switch(target)
         {
            case this.btn_close:
               this.sysApi.sendAction(new LeaveDialogRequestAction([]));
               break;
            case this.btn_closeRunes:
               this.ctr_runes.visible = false;
               this._UIDItemForRunesWindow = 0;
               break;
            case this.btn_crush:
               if(this._currentState == 0)
               {
                  if(this._itemsToCrush.length > 0)
                  {
                     focusActionId = 0;
                     if(this.cb_effectFocus.selectedItem)
                     {
                        focusActionId = this.cb_effectFocus.selectedItem.actionId;
                     }
                     this.sysApi.sendAction(new ExchangeReadyCrushAction([true,focusActionId]));
                     this.storageApi.removeAllItemMasks("exchange");
                     this.uiApi.getUi("storage").uiClass.btn_moveAllToLeft.visible = false;
                  }
               }
               else
               {
                  this._itemsToCrush = [];
                  this._decraftedItems = [];
                  this._item = null;
                  this._runesLists = new Dictionary(true);
                  this.updateGrid();
                  this.updateUI(false);
                  this.uiApi.getUi("storage").uiClass.btn_moveAllToLeft.visible = true;
               }
               break;
            default:
               if(target.name.indexOf("btn_seeMore") != -1)
               {
                  data = this._compInteractiveList[target.name];
                  if(this.ctr_runes.visible && this._UIDItemForRunesWindow == data.item.objectUID)
                  {
                     this.ctr_runes.visible = false;
                  }
                  else
                  {
                     this.ctr_runes.visible = true;
                     this.gd_runes.dataProvider = data.runes;
                     this.lbl_runes.text = data.item.name;
                     this._UIDItemForRunesWindow = data.item.objectUID;
                  }
               }
         }
      }
      
      public function onDoubleClickItemInventory(item:Object, quantity:int = 1) : void
      {
         if(!item || this._currentState == 1 || (item as ItemWrapper).category != 0)
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
         var contextMenu:ContextMenuData = this.menuApi.create(item.data);
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
         if(!(target is Slot) || (target as Slot).data == null)
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
            case this.btn_info:
               info = this.uiApi.getText("ui.crush.help");
               break;
            default:
               if(target.name.indexOf("btn_seeMore") != -1)
               {
                  info = this._runesLists[this._compInteractiveList[target.name].id];
               }
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
         var itemTooltipSettings:ItemTooltipSettings = null;
         var tooltipData:* = undefined;
         if(item.data)
         {
            itemTooltipSettings = this.sysApi.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
            if(!itemTooltipSettings)
            {
               itemTooltipSettings = this.tooltipApi.createItemSettings();
               this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
            }
            tooltipData = item.data;
            if(!itemTooltipSettings.header && !itemTooltipSettings.conditions && !itemTooltipSettings.effects && !itemTooltipSettings.description && !itemTooltipSettings.averagePrice)
            {
               tooltipData = item.data.name;
            }
            this.uiApi.showTooltip(item.data,item.container,false,"standard",7,7,0,"itemName",null,{
               "header":itemTooltipSettings.header,
               "conditions":itemTooltipSettings.conditions,
               "description":itemTooltipSettings.description,
               "averagePrice":itemTooltipSettings.averagePrice,
               "showEffects":itemTooltipSettings.effects
            },"ItemInfo");
         }
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
         this._itemsToCrush.push(itemWrapper);
         this.storageApi.addItemMask(itemWrapper.objectUID,"exchange",itemWrapper.quantity);
         this.updateGrid();
      }
      
      private function onExchangeObjectListAdded(objectList:Object, remote:Object) : void
      {
         var wrapper:ItemWrapper = null;
         this.soundApi.playSound(SoundTypeEnum.SWITCH_RIGHT_TO_LEFT);
         for each(wrapper in objectList)
         {
            this._itemsToCrush.push(wrapper);
            this.storageApi.addItemMask(wrapper.objectUID,"exchange",wrapper.quantity);
         }
         this.updateGrid();
      }
      
      private function onExchangeObjectModified(itemWrapper:Object, remote:Boolean) : void
      {
         var index:String = null;
         var i:* = null;
         this.soundApi.playSound(SoundTypeEnum.SWITCH_RIGHT_TO_LEFT);
         for(i in this._itemsToCrush)
         {
            if(this._itemsToCrush[i].objectUID == itemWrapper.objectUID)
            {
               index = i;
               break;
            }
         }
         if(index)
         {
            this._itemsToCrush.splice(index,1,itemWrapper);
            this.storageApi.addItemMask(itemWrapper.objectUID,"exchange",itemWrapper.quantity);
            this.updateGrid();
         }
      }
      
      private function onExchangeObjectListModified(objectList:Object, remote:Boolean) : void
      {
         var index:String = null;
         var itemWrapper:ItemWrapper = null;
         var i:* = null;
         this.soundApi.playSound(SoundTypeEnum.SWITCH_RIGHT_TO_LEFT);
         for each(itemWrapper in objectList)
         {
            for(i in this._itemsToCrush)
            {
               if(this._itemsToCrush[i].objectUID == itemWrapper.objectUID)
               {
                  index = i;
                  break;
               }
            }
            if(index)
            {
               this._itemsToCrush.splice(index,1,itemWrapper);
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
         for(i in this._itemsToCrush)
         {
            if(this._itemsToCrush[i].objectUID == itemUID)
            {
               index = i;
               break;
            }
         }
         if(index)
         {
            this._itemsToCrush.splice(index,1);
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
            for(i in this._itemsToCrush)
            {
               if(this._itemsToCrush[i].objectUID == itemUID)
               {
                  index = i;
                  break;
               }
            }
            if(index)
            {
               this._itemsToCrush.splice(index,1);
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
