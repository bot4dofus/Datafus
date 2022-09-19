package Ankama_Storage.ui
{
   import Ankama_ContextMenu.contextMenu.ContextMenuItem;
   import Ankama_Storage.ui.behavior.GuildChestUiBehavior;
   import Ankama_Storage.ui.enum.StorageState;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.guild.GuildChestTab;
   import com.ankamagames.dofus.internalDatacenter.FeatureEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.CloseInventoryAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenInventoryAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveToTabAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.GuildSelectChestTabRequestAction;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.network.enums.GuildRightsEnum;
   import com.ankamagames.dofus.network.types.game.inventory.StorageTabInformation;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.jerakine.logger.LogLevel;
   import flash.utils.Dictionary;
   
   public class GuildChestUi extends AbstractStorageUi
   {
       
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      public var ctr_slotsUsed:GraphicContainer;
      
      public var lbl_slotsUsed:Label;
      
      public var tx_viewers:Texture;
      
      public var lbl_viewers:Label;
      
      public var btn_updateChest:ButtonContainer;
      
      public var gd_tabs:Grid;
      
      private var _componentsList:Dictionary;
      
      private var _chestTabActivated:Boolean;
      
      private const MAX_GUILD_CHEST:uint = 4;
      
      private var _guildChestTab:Vector.<StorageTabInformation>;
      
      private var _params:Object;
      
      private var _listeners:Vector.<String>;
      
      private var _currentTab:uint = 1;
      
      private var _objectUIDToExchange:uint;
      
      private var _destinationTab:uint;
      
      public var behavior:GuildChestUiBehavior;
      
      public function GuildChestUi()
      {
         this._componentsList = new Dictionary(true);
         this._listeners = new Vector.<String>();
         super();
      }
      
      override public function main(param:Object) : void
      {
         this._chestTabActivated = this.configApi.isFeatureWithKeywordEnabled(FeatureEnum.GUILD_CHEST_TAB);
         param.storageMod = StorageState.GUILD_CHEST_UI_MOD;
         this._params = param;
         super.main(param);
         sysApi.addHook(InventoryHookList.BankViewContent,onInventoryUpdate);
         sysApi.addHook(InventoryHookList.BankObjectNumberUpdate,this.updateSlotsUsedCount);
         sysApi.addHook(ExchangeHookList.ExchangeLeave,this.onExchangeLeave);
         sysApi.addHook(InventoryHookList.ListenersOfSynchronizedStorage,this.onListenersOfChest);
         sysApi.addHook(InventoryHookList.AddListenerOfSynchronizedStorage,this.onAddListenersOfChest);
         sysApi.addHook(InventoryHookList.RemoveListenerOfSynchronizedStorage,this.onRemoveListenersOfChest);
         sysApi.addHook(ExchangeHookList.GuildChestLastContribution,this.onGuildChestLastContribution);
         uiApi.addComponentHook(this.btn_updateChest,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_updateChest,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btn_updateChest,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.tx_viewers,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.tx_viewers,ComponentHookList.ON_ROLL_OUT);
         this.categoryFilter = ItemCategoryEnum.ALL_CATEGORY;
         this.btn_updateChest.visible = this._chestTabActivated && this.socialApi.playerGuildRank.rights.indexOf(GuildRightsEnum.RIGHT_MANAGE_CHEST_RIGHTS) != -1;
         this.gd_tabs.visible = this._chestTabActivated;
         _hasSlot = true;
         slotsMax = !param.maxSlots ? uint(0) : uint(param.maxSlots);
         ctrTotalWeight.visible = false;
         ctr_kamas.visible = false;
         btn_moveAllToLeft.visible = false;
         btn_moveAllToRight.visible = false;
         this.subFilter = -1;
         storageApi.releaseBankHooks();
         mainCtr.x = 16;
         mainCtr.y = 1024 - (mainCtr.height + 155);
         this._currentTab = this._params.tabNumber;
         this.initTabs(this._params.tabs);
         sysApi.sendAction(new OpenInventoryAction([StorageState.GUILD_CHEST_STORAGE_MOD]));
      }
      
      public function openNewChestTab(param:Object) : void
      {
         sysApi.addHook(ExchangeHookList.ExchangeLeave,this.onExchangeLeave);
         _lastSearchCriteria = null;
         param.storageMod = StorageState.GUILD_CHEST_UI_MOD;
         this._params = param;
         slotsMax = !param.maxSlots ? uint(0) : uint(param.maxSlots);
         this._currentTab = this._params.tabNumber;
         lbl_title.text = !!this._chestTabActivated ? this.getRealTabName(this._guildChestTab[this._currentTab - 1]) : uiApi.getText("ui.guild.chestTitleOneTab");
         this.behavior.objectTypesRestriction = this._guildChestTab[this._currentTab - 1].dropTypeLimitation.concat();
         this.behavior.dropRight = this._guildChestTab[this._currentTab - 1].dropRight;
         this.behavior.takeRight = this._guildChestTab[this._currentTab - 1].takeRight;
         this.gd_tabs.updateItems();
      }
      
      public function initTabs(tabs:Vector.<StorageTabInformation>) : void
      {
         var tab:StorageTabInformation = null;
         this._guildChestTab = tabs;
         var guildChestTab:Array = [];
         for each(tab in this._guildChestTab)
         {
            if(tab.tabNumber == this._currentTab)
            {
               lbl_title.text = !!this._chestTabActivated ? this.getRealTabName(tab) : uiApi.getText("ui.guild.chestTitleOneTab");
               this.behavior.objectTypesRestriction = tab.dropTypeLimitation.concat();
               this.behavior.dropRight = tab.dropRight;
               this.behavior.takeRight = tab.takeRight;
            }
            guildChestTab.push(tab);
         }
         if(guildChestTab.length < this.MAX_GUILD_CHEST)
         {
            guildChestTab.push(-1);
         }
         this.gd_tabs.dataProvider = guildChestTab;
      }
      
      override public function unload() : void
      {
         sysApi.removeHook(InventoryHookList.BankViewContent);
         sysApi.removeHook(ExchangeHookList.ExchangeLeave);
         sysApi.sendAction(new LeaveDialogRequestAction([]));
         sysApi.sendAction(new CloseInventoryAction([]));
      }
      
      override protected function getStorageTypes(categoryFilter:int) : Array
      {
         return storageApi.getBankStorageTypes(categoryFilter);
      }
      
      override public function set categoryFilter(category:int) : void
      {
         super.categoryFilter = category;
         storageApi.setDisplayedBankCategory(categoryFilter);
      }
      
      override public function set subFilter(filter:int) : void
      {
         var cb_category:Object = null;
         updateSubFilter(this.getStorageTypes(categoryFilter));
         var hasFilter:Boolean = false;
         for each(cb_category in super.cb_category.dataProvider)
         {
            if(cb_category.filterType == filter)
            {
               hasFilter = true;
               break;
            }
         }
         if(!hasFilter)
         {
            filter = -1;
         }
         if(!itemWithAssociatedRunesDisplayed)
         {
            storageApi.setBankStorageFilter(filter);
         }
         super.subFilter = filter;
      }
      
      public function updateChestTab(data:*, components:*, selected:Boolean) : void
      {
         var tabInfo:StorageTabInformation = null;
         var canOpen:* = false;
         var canDrop:* = false;
         var canTake:* = false;
         if(data !== null)
         {
            if(!this._componentsList[components.btn_tab.name])
            {
               uiApi.addComponentHook(components.btn_tab,ComponentHookList.ON_ROLL_OVER);
               uiApi.addComponentHook(components.btn_tab,ComponentHookList.ON_ROLL_OUT);
               uiApi.addComponentHook(components.btn_tab,ComponentHookList.ON_RIGHT_CLICK);
               uiApi.addComponentHook(components.btn_tab,ComponentHookList.ON_RELEASE);
            }
            this._componentsList[components.btn_tab.name] = data;
            if(!this._componentsList[components.btn_plus.name])
            {
               uiApi.addComponentHook(components.btn_plus,ComponentHookList.ON_ROLL_OVER);
               uiApi.addComponentHook(components.btn_plus,ComponentHookList.ON_ROLL_OUT);
               uiApi.addComponentHook(components.btn_plus,ComponentHookList.ON_RIGHT_CLICK);
               uiApi.addComponentHook(components.btn_plus,ComponentHookList.ON_RELEASE);
            }
            this._componentsList[components.btn_plus.name] = data;
            components.btn_tab.visible = data != -1;
            components.btn_plus.visible = data == -1;
            if(data is StorageTabInformation)
            {
               tabInfo = data as StorageTabInformation;
               canOpen = this.socialApi.playerGuildRank.rights.indexOf(tabInfo.openRight) != -1;
               canDrop = this.socialApi.playerGuildRank.rights.indexOf(tabInfo.dropRight) != -1;
               canTake = this.socialApi.playerGuildRank.rights.indexOf(tabInfo.takeRight) != -1;
               components.btn_tab.disabled = !canOpen;
               components.btn_tab.selected = tabInfo.tabNumber == this._currentTab;
               components.tx_right.visible = canOpen && !canTake;
               if(!canOpen)
               {
                  components.txIcon_btn_tab.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "icon_lock.png");
               }
               else
               {
                  components.txIcon_btn_tab.uri = uiApi.createUri(uiApi.me().getConstant("ranks_uri") + tabInfo.picto + ".png");
                  if(canOpen && !canDrop && !canTake)
                  {
                     components.tx_right.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "slot_eye.png");
                  }
                  else if(canDrop && !canTake)
                  {
                     components.tx_right.uri = uiApi.createUri(uiApi.me().getConstant("texture") + "slot_drop.png");
                  }
                  else
                  {
                     components.tx_right.uri = null;
                  }
               }
            }
         }
         else
         {
            components.txIcon_btn_tab.uri = null;
            components.btn_tab.visible = false;
            components.btn_plus.visible = false;
            components.tx_right.visible = false;
         }
      }
      
      private function updateSlotsUsedCount() : void
      {
         this.lbl_slotsUsed.text = uiApi.getText("ui.guild.chestSlotsUsed",InventoryManager.getInstance().bankInventory.objectNumber,this._params.maxSlots);
      }
      
      private function formatListenersText() : String
      {
         var text:* = uiApi.getText("ui.guild.chestListeners") + "\n\n";
         for(var i:uint = 0; i < this._listeners.length; i++)
         {
            if(i >= 20)
            {
               text += "...";
               break;
            }
            text += "- " + this._listeners[i] + "\n";
         }
         return text;
      }
      
      private function formatTabRollOver(tabName:String) : String
      {
         var text:String = uiApi.getText("ui.guild.chestTitle",tabName);
         if(this.socialApi.playerGuildRank.rights.indexOf(GuildRightsEnum.RIGHT_MANAGE_CHEST_RIGHTS) != -1)
         {
            text += "\n<font color=\'#6d6d6d\'>" + uiApi.getText("ui.guild.updateTabOptionText") + "</font>";
         }
         return text;
      }
      
      override protected function releaseHooks() : void
      {
         storageApi.releaseBankHooks();
      }
      
      override protected function sortOn(property:int, numeric:Boolean = false) : void
      {
         storageApi.resetBankSort();
         this.addSort(property);
      }
      
      override protected function addSort(property:int) : void
      {
         storageApi.sortBank(property,false);
         this.releaseHooks();
      }
      
      override protected function getSortFields() : Array
      {
         return storageApi.getSortBankFields();
      }
      
      private function createChestTransfertMenu(itemWrapper:ItemWrapper) : Array
      {
         var tab:StorageTabInformation = null;
         var menuArray:Array = [];
         for each(tab in this._guildChestTab)
         {
            if(tab.tabNumber != this._currentTab)
            {
               menuArray.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.guild.chestTitle",this.getRealTabName(this._guildChestTab[tab.tabNumber - 1])),this.onSelectChestTransfer,[itemWrapper.objectUID,itemWrapper.quantity,tab.tabNumber],this.transferTabDisabled(itemWrapper,tab)));
            }
         }
         menuArray.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.common.inventory"),this.onSelectInventoryTransfer,[itemWrapper.objectUID,-itemWrapper.quantity],false));
         return menuArray;
      }
      
      private function transferTabDisabled(itemWrapper:ItemWrapper, tab:StorageTabInformation) : Boolean
      {
         return tab.dropTypeLimitation.indexOf(itemWrapper.typeId) == -1 || this.socialApi.playerGuildRank.rights.indexOf(this._guildChestTab[this._currentTab - 1].takeRight) == -1 || this.socialApi.playerGuildRank.rights.indexOf(tab.dropRight) == -1;
      }
      
      private function getRealTabName(tabInfo:StorageTabInformation) : String
      {
         var tab:GuildChestTab = null;
         var tabName:String = tabInfo.name;
         if(tabName.indexOf("guild.chest.tab") != -1)
         {
            tab = GuildChestTab.getGuildChestTabByIndex(tabInfo.tabNumber);
            if(tab)
            {
               return tab.name;
            }
            return "";
         }
         return tabName;
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         var tabInfo:StorageTabInformation = null;
         switch(target)
         {
            case this.btn_updateChest:
               if(!uiApi.getUi(UIEnum.UPDATE_STORAGE_TAB_UI))
               {
                  uiApi.loadUi(UIEnum.UPDATE_STORAGE_TAB_UI,UIEnum.UPDATE_STORAGE_TAB_UI,this._guildChestTab[this._currentTab - 1]);
               }
               break;
            default:
               if(target.name.indexOf("btn_plus") != -1)
               {
                  if(!uiApi.getUi(UIEnum.UNLOCK_GUILD_CHEST))
                  {
                     uiApi.loadUi(UIEnum.UNLOCK_GUILD_CHEST,UIEnum.UNLOCK_GUILD_CHEST,{
                        "tabNumber":this._currentTab,
                        "requiredAmount":0,
                        "currentAmount":0
                     });
                  }
               }
               else if(target.name.indexOf("btn_tab") != -1)
               {
                  tabInfo = this._componentsList[target.name] as StorageTabInformation;
                  sysApi.removeHook(ExchangeHookList.ExchangeLeave);
                  sysApi.sendAction(GuildSelectChestTabRequestAction.create(tabInfo.tabNumber));
               }
         }
         super.onRelease(target);
      }
      
      override public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var tabInfo:StorageTabInformation = null;
         var location:Object = {
            "point":LocationEnum.POINT_BOTTOMLEFT,
            "relativePoint":LocationEnum.POINT_TOPRIGHT
         };
         switch(target)
         {
            case this.tx_viewers:
               tooltipText = this.formatListenersText();
               break;
            case this.btn_updateChest:
               tooltipText = uiApi.getText("ui.guild.updateGuildChestTitle",this.getRealTabName(this._guildChestTab[this._currentTab - 1]));
               location.point = LocationEnum.POINT_BOTTOM;
               location.relativePoint = LocationEnum.POINT_TOP;
               break;
            default:
               if(target.name.indexOf("btn_plus") != -1)
               {
                  tooltipText = uiApi.getText("ui.guild.contributeChest");
               }
               else if(target.name.indexOf("btn_tab") != -1)
               {
                  tabInfo = this._componentsList[target.name] as StorageTabInformation;
                  tooltipText = this.formatTabRollOver(this.getRealTabName(tabInfo));
               }
         }
         if(tooltipText)
         {
            uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText),target,false,"standard",location.point,location.relativePoint,3,null,null,null,"TextInfo");
         }
         super.onRollOver(target);
      }
      
      public function onRightClick(target:GraphicContainer) : void
      {
         if(target.name.indexOf("btn_tab") != -1 && this.socialApi.playerGuildRank.rights.indexOf(GuildRightsEnum.RIGHT_MANAGE_CHEST_RIGHTS) != -1)
         {
            if(!uiApi.getUi(UIEnum.UPDATE_STORAGE_TAB_UI))
            {
               uiApi.loadUi(UIEnum.UPDATE_STORAGE_TAB_UI,UIEnum.UPDATE_STORAGE_TAB_UI,this._componentsList[target.name]);
            }
         }
      }
      
      override public function onItemRightClick(target:GraphicContainer, item:Object) : void
      {
         var contextMenu:Object = null;
         var transferMenu:ContextMenuItem = null;
         var data:Object = item.data;
         if(data == null)
         {
            return;
         }
         contextMenu = menuApi.create(data,"item",[{"ownedItem":true}]);
         if(this._chestTabActivated && this._guildChestTab.length > 1)
         {
            contextMenu.content.push(modContextMenu.createContextMenuSeparatorObject());
            transferMenu = modContextMenu.createContextMenuItemObject(uiApi.getText("ui.guild.moveTo"),null,null,false,null,false);
            transferMenu.child = this.createChestTransfertMenu(data as ItemWrapper);
            contextMenu.content.push(transferMenu);
         }
         var disabled:Boolean = contextMenu.content[0].disabled;
         fillContextMenu(contextMenu.content,data,disabled,item.container);
         if(contextMenu.content.length > 0)
         {
            modContextMenu.createContextMenu(contextMenu);
         }
      }
      
      public function onExchangeLeave(success:Boolean) : void
      {
         uiApi.unloadUi(uiApi.me().name);
      }
      
      private function onListenersOfChest(players:Vector.<String>) : void
      {
         this._listeners = players;
         this.lbl_viewers.text = this._listeners.length.toString();
      }
      
      private function onAddListenersOfChest(player:String) : void
      {
         if(this._listeners.indexOf(player) == -1)
         {
            this._listeners.push(player);
         }
         else
         {
            sysApi.log(LogLevel.WARN,"Ajout impossible : le joueur déjà présent dans la liste des listeners");
         }
         this.lbl_viewers.text = this._listeners.length.toString();
      }
      
      private function onRemoveListenersOfChest(player:String) : void
      {
         if(this._listeners.indexOf(player) != -1)
         {
            this._listeners.splice(this._listeners.indexOf(player),1);
         }
         else
         {
            sysApi.log(LogLevel.WARN,"Suppression impossible : le joueur n\'est pas présent dans la liste des listeners");
         }
         this.lbl_viewers.text = this._listeners.length.toString();
      }
      
      override protected function onDropEnd(src:Object, target:Object) : void
      {
         if(target is Slot && target.getUi() == uiApi.me() && dropErrorText)
         {
            chatApi.sendErrorOnChat(dropErrorText);
            dropErrorText = "";
         }
         super.onDropEnd(src,target);
      }
      
      private function onGuildChestLastContribution(lastContributionDate:Number) : void
      {
         var tabs:Array = this.gd_tabs.dataProvider.concat();
         if(tabs.indexOf(-1) == -1)
         {
            tabs.push(-1);
         }
         this.gd_tabs.dataProvider = tabs;
      }
      
      private function onSelectInventoryTransfer(objectUID:uint, quantity:int) : void
      {
         sysApi.sendAction(ExchangeObjectMoveAction.create(objectUID,quantity));
      }
      
      private function onSelectChestTransfer(objectUID:uint, quantity:int, tabNumber:uint) : void
      {
         var quantityMax:uint = 0;
         if(quantity > 1)
         {
            this._objectUIDToExchange = objectUID;
            this._destinationTab = tabNumber;
            quantityMax = quantity;
            modCommon.openQuantityPopup(1,quantityMax,quantityMax,this.onValidQty);
         }
         else
         {
            sysApi.sendAction(ExchangeObjectMoveToTabAction.create(objectUID,1,tabNumber));
         }
      }
      
      private function onValidQty(qty:Number) : void
      {
         sysApi.sendAction(ExchangeObjectMoveToTabAction.create(this._objectUIDToExchange,qty,this._destinationTab));
      }
   }
}
