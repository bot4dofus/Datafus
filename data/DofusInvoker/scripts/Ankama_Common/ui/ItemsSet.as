package Ankama_Common.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.items.ItemSet;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.types.data.PlayerSetInfo;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   
   public class ItemsSet
   {
       
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:Object;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Object;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="InventoryApi")]
      public var inventoryApi:InventoryApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      private var _set:ItemSet;
      
      private var _serverSet:PlayerSetInfo;
      
      private var _items:Array;
      
      private var _selectedItems:Array;
      
      private var _filterType:int = -1;
      
      private var _nbItemsToDisplay:int;
      
      public var gd_bonus:Grid;
      
      public var cb_filter:ComboBox;
      
      public var btn_close:ButtonContainer;
      
      public var btn_bonusObjects:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var lbl_title:Label;
      
      public var slot_0:Slot;
      
      public var slot_1:Slot;
      
      public var slot_2:Slot;
      
      public var slot_3:Slot;
      
      public var slot_4:Slot;
      
      public var slot_5:Slot;
      
      public var slot_6:Slot;
      
      public var slot_7:Slot;
      
      public var tx_itemEquipped_0:Texture;
      
      public var tx_itemEquipped_1:Texture;
      
      public var tx_itemEquipped_2:Texture;
      
      public var tx_itemEquipped_3:Texture;
      
      public var tx_itemEquipped_4:Texture;
      
      public var tx_itemEquipped_5:Texture;
      
      public var tx_itemEquipped_6:Texture;
      
      public var tx_itemEquipped_7:Texture;
      
      public function ItemsSet()
      {
         super();
      }
      
      public function main(param:Object) : void
      {
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.sysApi.addHook(InventoryHookList.SetUpdate,this.onSetUpdate);
         this.uiApi.addComponentHook(this.btn_close,"onRelease");
         this.uiApi.addComponentHook(this.btn_bonusObjects,"onRelease");
         this.uiApi.addComponentHook(this.btn_bonusObjects,"onRollOver");
         this.uiApi.addComponentHook(this.btn_bonusObjects,"onRollOut");
         this.uiApi.addComponentHook(this.cb_filter,"onSelectItem");
         this.uiApi.addComponentHook(this.tx_itemEquipped_0,"onRollOver");
         this.uiApi.addComponentHook(this.tx_itemEquipped_0,"onRollOut");
         this.uiApi.addComponentHook(this.tx_itemEquipped_1,"onRollOver");
         this.uiApi.addComponentHook(this.tx_itemEquipped_1,"onRollOut");
         this.uiApi.addComponentHook(this.tx_itemEquipped_2,"onRollOver");
         this.uiApi.addComponentHook(this.tx_itemEquipped_2,"onRollOut");
         this.uiApi.addComponentHook(this.tx_itemEquipped_3,"onRollOver");
         this.uiApi.addComponentHook(this.tx_itemEquipped_3,"onRollOut");
         this.uiApi.addComponentHook(this.tx_itemEquipped_4,"onRollOver");
         this.uiApi.addComponentHook(this.tx_itemEquipped_4,"onRollOut");
         this.uiApi.addComponentHook(this.tx_itemEquipped_5,"onRollOver");
         this.uiApi.addComponentHook(this.tx_itemEquipped_5,"onRollOut");
         this.uiApi.addComponentHook(this.tx_itemEquipped_6,"onRollOver");
         this.uiApi.addComponentHook(this.tx_itemEquipped_6,"onRollOut");
         this.uiApi.addComponentHook(this.tx_itemEquipped_7,"onRollOver");
         this.uiApi.addComponentHook(this.tx_itemEquipped_7,"onRollOut");
         this.uiApi.addComponentHook(this.slot_0,"onRelease");
         this.uiApi.addComponentHook(this.slot_1,"onRelease");
         this.uiApi.addComponentHook(this.slot_2,"onRelease");
         this.uiApi.addComponentHook(this.slot_3,"onRelease");
         this.uiApi.addComponentHook(this.slot_4,"onRelease");
         this.uiApi.addComponentHook(this.slot_5,"onRelease");
         this.uiApi.addComponentHook(this.slot_6,"onRelease");
         this.uiApi.addComponentHook(this.slot_7,"onRelease");
         this.uiApi.addComponentHook(this.btn_help,ComponentHookList.ON_RELEASE);
         this.displaySet(this.dataApi.getItem(param.item.objectGID).itemSetId);
      }
      
      public function updateEffectLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         var cssClass:String = null;
         if(data)
         {
            cssClass = "p";
            if(data.indexOf("-") == 0)
            {
               cssClass = "malus";
            }
            componentsRef.lbl_effect.cssClass = cssClass;
            componentsRef.lbl_effect.text = data;
         }
         else
         {
            componentsRef.lbl_effect.text = "";
         }
      }
      
      private function displaySet(setId:int) : void
      {
         var eqItem:ItemWrapper = null;
         var name:String = null;
         var num:int = 0;
         var i:int = 0;
         var setItem:uint = 0;
         var item1:uint = 0;
         var item2:uint = 0;
         var equip:ItemWrapper = null;
         this._items = [];
         this._selectedItems = [-1,-1,-1,-1,-1,-1,-1,-1];
         this._set = this.dataApi.getItemSet(setId);
         var equipment:Array = [];
         for each(eqItem in this.playerApi.getEquipment())
         {
            for each(setItem in this._set.items)
            {
               if(setItem == eqItem.objectGID)
               {
                  equipment.push(eqItem);
               }
            }
         }
         if(equipment.length > 0)
         {
            this._serverSet = this.playerApi.getPlayerSet(equipment[0].objectGID);
         }
         if(this._serverSet != null)
         {
            name = this._serverSet.setName;
            for each(item1 in this._serverSet.allItems)
            {
               this._items.push(item1);
            }
         }
         else
         {
            name = this._set.name;
            for each(item2 in this._set.items)
            {
               this._items.push(item2);
            }
         }
         this.lbl_title.text = name;
         num = this._items.length;
         for(i = 0; i < num; i++)
         {
            this.uiApi.addComponentHook(this["slot_" + i],"onRollOver");
            this.uiApi.addComponentHook(this["slot_" + i],"onRollOut");
            this.uiApi.addComponentHook(this["slot_" + i],"onRightClick");
            this["slot_" + i].data = this.dataApi.getItemWrapper(this._items[i]);
            this["slot_" + i].visible = true;
            this["tx_itemEquipped_" + i].visible = false;
            for each(equip in equipment)
            {
               if(equip.objectGID == this._items[i])
               {
                  this["tx_itemEquipped_" + i].visible = true;
                  this._selectedItems[i] = equip.objectGID;
                  this["slot_" + i].data = this.inventoryApi.getItem(equip.objectUID);
               }
            }
         }
         for(i = i; i < 8; i++)
         {
            this["slot_" + i].data = null;
         }
         var cbProvider:Array = new Array();
         for(var k:int = 1; k <= num; k++)
         {
            cbProvider.push({
               "label":k + " " + this.uiApi.getText("ui.common.objects"),
               "filterType":k
            });
         }
         this.cb_filter.dataProvider = cbProvider;
         if(equipment.length > 0)
         {
            this.cb_filter.selectedIndex = equipment.length - 1;
         }
         else
         {
            this.cb_filter.selectedIndex = num - 1;
         }
      }
      
      private function filteredBonus(addObjects:Boolean = false) : Array
      {
         var effect:EffectInstance = null;
         var bonusLineS:EffectInstance = null;
         var i:int = 0;
         var bonusPack:Vector.<EffectInstance> = null;
         var bonusLine:EffectInstance = null;
         var objectsGID:Array = null;
         var selObject:* = undefined;
         var bonus:Array = [];
         if(this._serverSet)
         {
            if(this._serverSet.setObjects.length == this._filterType)
            {
               for each(bonusLineS in this._serverSet.setEffects)
               {
                  bonus.push(bonusLineS);
               }
            }
         }
         if(bonus.length == 0)
         {
            if(this._set.bonusIsSecret)
            {
               this.sysApi.log(16,"The set bonuses are secrets when this feature is supposed not to be used anymore.");
            }
            else
            {
               i = 1;
               for each(bonusPack in this._set.effects)
               {
                  if(i == this._filterType)
                  {
                     if(bonusPack != null)
                     {
                        for each(bonusLine in bonusPack)
                        {
                           if(bonusLine != null)
                           {
                              bonus.push(bonusLine);
                           }
                        }
                     }
                  }
                  i++;
               }
            }
         }
         var effectsText:Array = [];
         var totalEffects:Array = [];
         if(addObjects)
         {
            objectsGID = [];
            for each(selObject in this._selectedItems)
            {
               if(selObject != -1)
               {
                  objectsGID.push(selObject);
               }
            }
            for each(effect in this.dataApi.getSetEffects(objectsGID,bonus))
            {
               totalEffects.push(effect);
            }
            totalEffects.sortOn("order",Array.NUMERIC);
            for each(effect in totalEffects)
            {
               if(effect.description && effect.description != "")
               {
                  effectsText.push(effect.description);
               }
            }
         }
         else
         {
            bonus.sortOn("order",Array.NUMERIC);
            for each(effect in bonus)
            {
               if(effect && effect.description && effect.description != "")
               {
                  effectsText.push(effect.description);
               }
            }
         }
         return effectsText;
      }
      
      private function switchObjectsMode(showObjects:Boolean) : void
      {
         var i:uint = 0;
         var j:uint = 0;
         var nbItem:uint = 0;
         if(showObjects)
         {
            this.cb_filter.disabled = true;
            for(i = 0; i < 8; i++)
            {
               if(i < this._set.items.length)
               {
                  this["slot_" + i].handCursor = true;
               }
               if(this["tx_itemEquipped_" + i].visible || this._selectedItems[i] && this._selectedItems[i] != -1)
               {
                  this["slot_" + i].selected = true;
                  this._selectedItems[i] = this._items[i];
                  nbItem++;
               }
               else
               {
                  this._selectedItems[i] = -1;
                  this["slot_" + i].selected = false;
               }
            }
            this._filterType = nbItem;
            this.cb_filter.selectedIndex = nbItem - 1;
            this.gd_bonus.dataProvider = this.filteredBonus(true);
         }
         else
         {
            this.cb_filter.disabled = false;
            for(j = 0; j < 8; j++)
            {
               this["slot_" + j].selected = false;
               this["slot_" + j].handCursor = false;
               if(this._selectedItems[i] != -1)
               {
                  nbItem++;
               }
            }
            this.gd_bonus.dataProvider = this.filteredBonus();
         }
      }
      
      private function onSetUpdate(setId:int) : void
      {
         if(this._set.id == setId)
         {
            this.displaySet(setId);
            if(this.btn_bonusObjects.selected)
            {
               this.switchObjectsMode(true);
            }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         if(target == this.btn_bonusObjects)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.set.addObjectBonusText")),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
         else if(target.name.substr(0,16) == "tx_itemEquipped_")
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.set.objectEquipped")),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
         else if(target.hasOwnProperty("data"))
         {
            this.uiApi.showTooltip((target as Slot).data,target,false,"standard",8,0,3,"itemName",null,{
               "showEffects":true,
               "header":true
            },"ItemInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var index:int = 0;
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_bonusObjects:
               this.switchObjectsMode(this.btn_bonusObjects.selected);
               break;
            case this.btn_help:
               this.hintsApi.showSubHints();
               break;
            default:
               if(target.name.substr(0,4) == "slot" && (target as Slot).data)
               {
                  if(this.btn_bonusObjects.selected)
                  {
                     index = int(target.name.substr(5,1));
                     if(this._selectedItems[index] == -1)
                     {
                        this.sysApi.log(2,"selection de " + (target as Slot).data.objectGID);
                        this._selectedItems[index] = (target as Slot).data.objectGID;
                        (target as Slot).selected = true;
                        ++this._filterType;
                     }
                     else
                     {
                        this._selectedItems[index] = -1;
                        (target as Slot).selected = false;
                        --this._filterType;
                     }
                     this.cb_filter.selectedIndex = this._filterType >= 1 ? uint(this._filterType - 1) : uint(-1);
                     this.gd_bonus.dataProvider = this.filteredBonus(true);
                  }
               }
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(target == this.cb_filter && !this.cb_filter.disabled)
         {
            this._filterType = this.cb_filter.value.filterType;
            this.gd_bonus.dataProvider = this.filteredBonus();
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "closeUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
      
      public function onRightClick(target:Object) : void
      {
         var data:Object = null;
         var contextMenu:Object = null;
         if(target.data)
         {
            data = target.data;
            contextMenu = this.menuApi.create(data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
   }
}
