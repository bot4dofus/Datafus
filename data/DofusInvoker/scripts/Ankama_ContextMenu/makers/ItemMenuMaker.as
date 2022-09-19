package Ankama_ContextMenu.makers
{
   import Ankama_ContextMenu.Api;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.interfaces.IMenuMaker;
   import com.ankamagames.dofus.datacenter.items.EvolutiveItemType;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.FeatureEnum;
   import com.ankamagames.dofus.internalDatacenter.items.BuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.OpenBookAction;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.MimicryObjectEraseRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.WrapperObjectDissociateRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountInfoRequestAction;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.misc.lists.MountHookList;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.geom.Rectangle;
   
   public class ItemMenuMaker implements IMenuMaker
   {
      
      public static var disabled:Boolean = false;
       
      
      private var _itemToFree:ItemWrapper;
      
      private var _shortcutColor:String;
      
      public function ItemMenuMaker()
      {
         super();
         this._shortcutColor = (Api.system.getConfigEntry("colors.contextmenu.shortcut") as String).replace("0x","#");
      }
      
      private function askRecipesItem(item:ItemWrapper) : void
      {
         Api.system.dispatchHook(HookList.OpenRecipe,item);
      }
      
      private function askAssociatedRunes(item:ItemWrapper) : void
      {
         Api.system.dispatchHook(ExchangeHookList.DisplayAssociatedRunes,item,false);
      }
      
      private function askBestiary(item:Object) : void
      {
         var monsterIdsList:Vector.<uint> = null;
         var currentMonsterId:uint = 0;
         var index:uint = 0;
         var data:Object = {};
         data.monsterId = 0;
         data.monsterSearch = item.name;
         if(Api.config.isFeatureWithKeywordEnabled(FeatureEnum.TEMPORIS_DROPS))
         {
            monsterIdsList = null;
            if(item.hasOwnProperty("dropMonsterIds") && item.dropMonsterIds && item.dropMonsterIds.length > 0)
            {
               monsterIdsList = item.dropMonsterIds;
            }
            if(item.hasOwnProperty("dropTemporisMonsterIds") && item.dropTemporisMonsterIds && item.dropTemporisMonsterIds.length > 0)
            {
               if(!monsterIdsList)
               {
                  monsterIdsList = item.dropTemporisMonsterIds;
               }
               else
               {
                  monsterIdsList.fixed = false;
                  for(index = 0; index < item.dropTemporisMonsterIds.length; index++)
                  {
                     currentMonsterId = item.dropTemporisMonsterIds[index];
                     if(monsterIdsList.indexOf(currentMonsterId) === -1)
                     {
                        monsterIdsList.push(currentMonsterId);
                     }
                  }
               }
            }
            if(monsterIdsList === null)
            {
               return;
            }
            monsterIdsList.fixed = true;
            data.monsterIdsList = monsterIdsList;
         }
         else
         {
            data.monsterIdsList = item.dropMonsterIds;
         }
         data.forceOpen = true;
         Api.system.dispatchHook(HookList.OpenEncyclopedia,"bestiaryTab",data);
      }
      
      private function askSetItem(item:Object) : void
      {
         Api.system.dispatchHook(HookList.OpenSet,item);
      }
      
      private function askLivingObjectItem(item:Object) : void
      {
         Api.system.dispatchHook(InventoryHookList.OpenLivingObject,item);
      }
      
      private function dissociateWrapperObjectItem(item:Object) : void
      {
         this._itemToFree = item as ItemWrapper;
         Api.system.sendAction(new WrapperObjectDissociateRequestAction([this._itemToFree.objectUID,this._itemToFree.position]));
      }
      
      private function dissociateMimicryObjectItem(item:Object) : void
      {
         var popupText:String = null;
         this._itemToFree = item as ItemWrapper;
         if(this._itemToFree.isMimiCryWithWrapperObject || this._itemToFree.isWrapperObject)
         {
            popupText = Api.ui.getText("ui.mimicry.confirmFreePopupNoDeletion",item.name);
         }
         else
         {
            popupText = Api.ui.getText("ui.mimicry.confirmFreePopup",item.name);
         }
         Api.modCommon.openPopup(Api.ui.getText("ui.popup.warning"),popupText,[Api.ui.getText("ui.common.yes"),Api.ui.getText("ui.common.no")],[this.onConfirmFree,this.onCancel],this.onConfirmFree,this.onCancel);
      }
      
      private function displayChatItem(item:Object) : void
      {
         Api.system.dispatchHook(CustomUiHookList.InsertHyperlink,item);
      }
      
      private function displayChatRecipe(item:Object) : void
      {
         Api.system.dispatchHook(ChatHookList.InsertRecipeHyperlink,item.objectGID);
      }
      
      private function viewMountDetails(item:Object) : void
      {
         Api.system.sendAction(new MountInfoRequestAction([item]));
      }
      
      private function viewMountAncestors(item:Object) : void
      {
         Api.system.dispatchHook(MountHookList.ViewMountAncestors,item);
      }
      
      private function viewCompanionDetails() : void
      {
         Api.system.sendAction(new OpenBookAction(["companionTab"]));
      }
      
      public function feedItem(item:Object) : void
      {
         Api.system.dispatchHook(HookList.OpenEvolutiveFeed,item);
      }
      
      public function createMenu(data:*, param:Object) : Array
      {
         var evolutiveType:EvolutiveItemType = null;
         var ctrId:int = 0;
         var ctr:Item = null;
         var elem:ItemWrapper = null;
         var counter:uint = 0;
         Api.ui.hideTooltip();
         var notOwnedItem:Boolean = true;
         if(param && param[0])
         {
            if(param[0].hasOwnProperty("ownedItem"))
            {
               if(param[0].ownedItem)
               {
                  notOwnedItem = false;
               }
            }
         }
         var menu:Array = [];
         var uiName:String = !!param ? (param.length > 1 && param[1] is String ? param[1] : null) : null;
         var hasRecipes:Boolean = false;
         if(data.hasOwnProperty("objectGID"))
         {
            hasRecipes = Api.jobs.checkCraftVisible(data.objectGID) && (Api.jobs.getRecipe(data.objectGID) || Api.jobs.getRecipesList(data.objectGID).length);
         }
         if(data.hasOwnProperty("isCertificate") && data.isCertificate)
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.mount.viewMountDetails"),this.viewMountDetails,[data],disabled));
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.mount.ancestorTooltip"),this.viewMountAncestors,[data],disabled));
         }
         if(data.hasOwnProperty("typeId") && data.typeId == DataEnum.ITEM_TYPE_COMPANION)
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.infos"),this.viewCompanionDetails,null,disabled));
         }
         if(data.hasOwnProperty("isEquipment") && data.isEquipment && data.hasOwnProperty("type") && data.type.superTypeId == DataEnum.ITEM_SUPERTYPE_PET)
         {
            evolutiveType = data.type.evolutiveType;
            if((!evolutiveType || evolutiveType.maxLevel != data.evolutiveLevel) && data.isEvolutive())
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.feed"),this.feedItem,[data],disabled || notOwnedItem));
            }
            else
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.evolutive.pet.evolvePet"),this.feedItem,[data],disabled || notOwnedItem));
            }
         }
         if(!(data is BuildWrapper) && data is ItemWrapper && hasRecipes)
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.recipes"),this.askRecipesItem,[data],disabled));
         }
         if(Api.ui.getUiByName(UIEnum.BANK_UI) != null && !(data is BuildWrapper) && data is ItemWrapper && data.isEquipment && data.enhanceable)
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.item.displayAssociatedRunes"),this.askAssociatedRunes,[data],disabled));
         }
         var areDrops:Boolean = data.hasOwnProperty("dropMonsterIds") && data.dropMonsterIds && data.dropMonsterIds.length > 0;
         if(Api.config.isFeatureWithKeywordEnabled(FeatureEnum.TEMPORIS_DROPS))
         {
            areDrops = areDrops || data.hasOwnProperty("dropTemporisMonsterIds") && data.dropTemporisMonsterIds && data.dropTemporisMonsterIds.length > 0;
         }
         if(areDrops)
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.bestiary"),this.askBestiary,[data],disabled));
         }
         else if(data.hasOwnProperty("containerIds") && data.containerIds && data.containerIds.length > 0)
         {
            for each(ctrId in data.containerIds)
            {
               ctr = Api.data.getItem(ctrId);
               if(ctr && ctr.hasOwnProperty("dropMonsterIds") && ctr.dropMonsterIds && ctr.dropMonsterIds.length > 0)
               {
                  menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.bestiary"),this.askBestiary,[ctr],disabled));
                  break;
               }
            }
         }
         if(data.hasOwnProperty("belongsToSet") && data.belongsToSet)
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.set"),this.askSetItem,[data],disabled));
         }
         if(data.hasOwnProperty("isLivingObject") && data.isLivingObject)
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.item.manageItem"),this.askLivingObjectItem,[data],disabled));
         }
         if(data.hasOwnProperty("isObjectWrapped") && data.isObjectWrapped)
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.item.dissociate"),this.dissociateWrapperObjectItem,[data],disabled || notOwnedItem));
         }
         if(data.hasOwnProperty("isMimicryObject") && data.isMimicryObject)
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.mimicry.free"),this.dissociateMimicryObjectItem,[data],disabled || notOwnedItem));
         }
         if(menu.length)
         {
            menu.push(ContextMenu.static_createContextMenuSeparatorObject());
         }
         var uiChat:* = Api.ui.getUi("chat");
         if(uiChat && !(data is BuildWrapper) && data is ItemWrapper)
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.craft.displayChatItem") + " <font color=\'" + this._shortcutColor + "\'>(" + Api.ui.getText("ui.keyboard.shift") + " + " + Api.ui.getText("ui.mouse.click") + ")</font>",this.displayChatItem,[data],disabled));
         }
         if(uiChat && !(data is BuildWrapper) && data is ItemWrapper && hasRecipes)
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.craft.displayChatRecipe"),this.displayChatRecipe,[data],disabled));
         }
         if((!uiName || uiName.indexOf("_pin@") == -1) && !(data is BuildWrapper) && (data is Item || data is ItemWrapper))
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.tooltip.pin") + " <font color=\'" + this._shortcutColor + "\'>(Alt)</font>",this.pinTooltip,[data]));
         }
         var equipment:Vector.<ItemWrapper> = Api.inventoryApi.getEquipement();
         if(equipment && data is ItemWrapper && data.isEquipment && equipment.indexOf(data) < 0)
         {
            counter = 0;
            for each(elem in equipment)
            {
               if(elem)
               {
                  if(elem.type && data.type && elem.type.superTypeId == data.type.superTypeId)
                  {
                     counter++;
                  }
               }
            }
            if(counter > 0)
            {
               menu.push(ContextMenu.static_createContextMenuItemObject("<i>" + Api.ui.getText("ui.tooltip.item.compare") + " : <font color=\'" + this._shortcutColor + "\'>" + Api.ui.getText("ui.keyboard.shift") + "</font></i>",null,null,disabled));
            }
            if(counter > 1)
            {
               menu.push(ContextMenu.static_createContextMenuItemObject("<i>" + Api.ui.getText("ui.tooltip.item.compare2") + " : <font color=\'" + this._shortcutColor + "\'>" + Api.ui.getText("ui.keyboard.shift") + " + &lt;</font></i>",null,null,disabled));
            }
         }
         return menu;
      }
      
      private function pinTooltip(data:*) : void
      {
         var setting:String = null;
         var settings:Object = {};
         var itemTooltipSettings:ItemTooltipSettings = Api.system.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
         if(itemTooltipSettings == null)
         {
            itemTooltipSettings = Api.tooltip.createItemSettings();
            Api.system.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
         }
         var objVariables:Vector.<String> = Api.system.getObjectVariables(itemTooltipSettings);
         for each(setting in objVariables)
         {
            settings[setting] = itemTooltipSettings[setting];
         }
         settings.pinnable = true;
         settings.showEffects = true;
         Api.ui.showTooltip(data,new Rectangle(20,20,0,0),false,"standard",0,0,0,null,null,settings,null,true,4,1,"storage");
      }
      
      protected function onConfirmFree() : void
      {
         Api.system.sendAction(new MimicryObjectEraseRequestAction([this._itemToFree.objectUID,this._itemToFree.position]));
      }
      
      protected function onCancel() : void
      {
      }
   }
}
