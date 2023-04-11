package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.types.game.data.items.effects.ObjectEffect;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   import flash.geom.Rectangle;
   
   public class HyperlinkItemManager
   {
      
      private static var _itemId:int = 0;
      
      private static var _itemList:Array = [];
      
      public static var lastItemTooltipId:int = -1;
       
      
      public function HyperlinkItemManager()
      {
         super();
      }
      
      public static function showItem(objectGID:uint, objectUID:uint = 0) : void
      {
         var itemWrapper:ItemWrapper = InventoryManager.getInstance().inventory.getItem(objectUID);
         if(itemWrapper)
         {
            KernelEventsManager.getInstance().processCallback(ChatHookList.ShowObjectLinked,itemWrapper);
         }
         else
         {
            KernelEventsManager.getInstance().processCallback(ChatHookList.ShowObjectLinked,ItemWrapper.create(0,0,objectGID,1,null));
         }
      }
      
      public static function showChatItem(id:int) : void
      {
         if(id == lastItemTooltipId && TooltipManager.isVisible("Hyperlink"))
         {
            TooltipManager.hide("Hyperlink");
            lastItemTooltipId = -1;
            return;
         }
         lastItemTooltipId = id;
         HyperlinkSpellManager.lastSpellTooltipId = -1;
         KernelEventsManager.getInstance().processCallback(ChatHookList.ShowObjectLinked,_itemList[id]);
      }
      
      public static function showBestiaryItem(objectGID:uint) : void
      {
         var item:ItemWrapper = ItemWrapper.create(0,0,objectGID,1,new Vector.<ObjectEffect>(),false);
         var data:Object = {};
         data.monsterId = 0;
         data.monsterSearch = item.name;
         data.monsterIdsList = item.dropMonsterIds;
         data.forceOpen = true;
         KernelEventsManager.getInstance().processCallback(HookList.OpenEncyclopedia,"bestiaryTab",data);
      }
      
      public static function showResourceItem(objectGID:uint) : void
      {
         var item:ItemWrapper = ItemWrapper.create(0,0,objectGID,1,new Vector.<ObjectEffect>(),false);
         var data:Object = {};
         data.resourceSearch = item.name;
         data.resourceId = item.objectGID;
         if(item.category == ItemCategoryEnum.CONSUMABLES_CATEGORY)
         {
            data.forceOpenConsumableTab = true;
            KernelEventsManager.getInstance().processCallback(HookList.OpenEncyclopedia,"consumableTab",data);
         }
         else if(item.category == ItemCategoryEnum.RESOURCES_CATEGORY)
         {
            data.forceOpenResourceTab = true;
            KernelEventsManager.getInstance().processCallback(HookList.OpenEncyclopedia,"resourceTab",data);
         }
         else if(item.type.isInEncyclopedia)
         {
            data.forceOpenEquipmentTab = true;
            KernelEventsManager.getInstance().processCallback(HookList.OpenEncyclopedia,"equipmentTab",data);
         }
         else
         {
            showItem(objectGID,item.objectUID);
         }
      }
      
      public static function showPinnedItemTooltip(objectGID:uint, objectUID:uint = 0, uiName:String = null) : void
      {
         if(!uiName)
         {
            return;
         }
         KernelEventsManager.getInstance().processCallback(HookList.DisplayPinnedItemTooltip,uiName,objectGID,objectUID);
      }
      
      public static function insertItem(objectGID:uint, objectUID:uint = 0, uiName:String = null) : void
      {
         var item:ItemWrapper = ItemWrapper.create(0,objectUID,objectGID,1,new Vector.<ObjectEffect>(),false);
         KernelEventsManager.getInstance().processCallback(BeriliaHookList.MouseShiftClick,{"data":item});
      }
      
      public static function duplicateChatHyperlink(id:int) : void
      {
         KernelEventsManager.getInstance().processCallback(ChatHookList.AddItemHyperlink,_itemList[id]);
      }
      
      public static function getItemName(objectGID:uint, objectUID:uint = 0) : String
      {
         var item:Item = Item.getItemById(objectGID);
         if(item)
         {
            return "[" + item.name + "]";
         }
         return "[null]";
      }
      
      public static function newChatItem(item:ItemWrapper) : String
      {
         _itemList[_itemId] = item;
         var code:* = "{chatitem," + _itemId + "::[" + item.realName + "]}";
         ++_itemId;
         return code;
      }
      
      public static function rollOver(pX:int, pY:int, objectGID:uint, objectUID:uint = 0) : void
      {
         var item:Item = _itemList[objectGID];
         if(!item)
         {
            item = ItemWrapper.create(0,objectUID,objectGID,0,null,false);
         }
         TooltipManager.show(item,new Rectangle(pX,pY,10,10),UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,"standard",LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_TOPRIGHT,3,true,null,null,{
            "header":true,
            "description":false,
            "equipped":false,
            "noFooter":true,
            "showEffects":true
         },null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
