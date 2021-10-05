package Ankama_Roleplay.ui
{
   import Ankama_Common.Common;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.jobs.Recipe;
   import com.ankamagames.dofus.datacenter.quest.treasureHunt.LegendaryTreasureHunt;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.QuantifiedItemWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.quest.treasureHunt.TreasureHuntLegendaryRequestAction;
   import com.ankamagames.dofus.misc.lists.QuestHookList;
   import com.ankamagames.dofus.network.enums.TreasureHuntTypeEnum;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.JobsApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   
   public class LegendaryHunts
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="JobsApi")]
      public var jobsApi:JobsApi;
      
      [Api(name="InventoryApi")]
      public var inventoryApi:InventoryApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      private var _hunts:Array;
      
      private var _availableHunts:Array;
      
      private var _showAll:Boolean = true;
      
      private var _selectedHunt:LegendaryTreasureHunt;
      
      private var _mapItem:QuantifiedItemWrapper;
      
      public var btn_close:ButtonContainer;
      
      public var gd_hunts:Grid;
      
      public var btn_showAll:ButtonContainer;
      
      public var lbl_name:Label;
      
      public var lbl_level:Label;
      
      public var ed_monster:EntityDisplayer;
      
      public var lbl_monsterName:Label;
      
      public var lbl_rewardXp:Label;
      
      public var tx_rewardChest:Texture;
      
      public var lbl_mapRecap:Label;
      
      public var gd_mapPieces:Grid;
      
      public var slot_map:Slot;
      
      public var ctr_map:GraphicContainer;
      
      public var tx_craftMap:Texture;
      
      public var btn_start:ButtonContainer;
      
      public function LegendaryHunts()
      {
         this._hunts = [];
         this._availableHunts = [];
         super();
      }
      
      public function main(param:Object) : void
      {
         var h:LegendaryTreasureHunt = null;
         var id:int = 0;
         this.sysApi.addHook(QuestHookList.TreasureHuntUpdate,this.onTreasureHunt);
         this.uiApi.addComponentHook(this.gd_hunts,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.btn_showAll,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.gd_mapPieces,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.gd_mapPieces,ComponentHookList.ON_ITEM_ROLL_OVER);
         this.uiApi.addComponentHook(this.gd_mapPieces,ComponentHookList.ON_ITEM_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_craftMap,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_craftMap,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.slot_map,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.slot_map,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.slot_map,ComponentHookList.ON_RELEASE);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.btn_showAll.selected = this._showAll;
         this.ed_monster.setAnimationAndDirection("AnimArtwork",1);
         this.ed_monster.view = "turnstart";
         if(param)
         {
            for each(id in param)
            {
               this._availableHunts.push(id);
            }
         }
         var dataHunts:Array = this.dataApi.getLegendaryTreasureHunts();
         for each(h in dataHunts)
         {
            this._hunts.push(h);
         }
         this.refreshList();
      }
      
      public function unload() : void
      {
      }
      
      public function updateLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(data)
         {
            componentsRef.lbl_name.text = data.name;
            if(this._showAll && data.id != 0 && this._availableHunts.indexOf(data.id) == -1)
            {
               componentsRef.lbl_name.cssClass = "disabled";
            }
            else
            {
               componentsRef.lbl_name.cssClass = "p";
            }
            componentsRef.btn_hunt.selected = selected;
            componentsRef.btn_hunt.visible = true;
         }
         else
         {
            componentsRef.lbl_name.text = "";
            componentsRef.btn_hunt.selected = false;
            componentsRef.btn_hunt.visible = false;
         }
      }
      
      private function displayHunt() : void
      {
         var totalPieces:int = 0;
         var ingredients:Vector.<ItemWrapper> = null;
         var iw:QuantifiedItemWrapper = null;
         var i:int = 0;
         this.sysApi.log(2,"go " + this._selectedHunt.id);
         this.lbl_name.text = this._selectedHunt.name;
         this.lbl_level.text = this.uiApi.getText("ui.common.short.level") + " " + this._selectedHunt.level;
         if(this._selectedHunt.monster)
         {
            this.lbl_monsterName.text = "{chatmonster," + this._selectedHunt.monster.id + "::[" + this._selectedHunt.monster.name + "]}";
            this.ed_monster.look = this._selectedHunt.monster.look;
         }
         this.lbl_rewardXp.text = this.utilApi.kamasToString(this._selectedHunt.experienceReward,"");
         var chest:Item = this.dataApi.getItem(this._selectedHunt.chestId);
         if(chest)
         {
            this.tx_rewardChest.uri = this.uiApi.createUri(this.uiApi.me().getConstant("item_path") + chest.iconId + ".swf");
         }
         this._mapItem = this.inventoryApi.getQuantifiedItemByGIDInInventoryOrMakeUpOne(this._selectedHunt.mapItemId);
         this.slot_map.data = this._mapItem;
         var recipe:Recipe = this.jobsApi.getRecipe(this._selectedHunt.mapItemId);
         var myPieces:int = 0;
         var items:Array = [];
         if(recipe)
         {
            ingredients = recipe.ingredients;
            totalPieces = ingredients.length;
            for(i = 0; i < totalPieces; i++)
            {
               iw = this.inventoryApi.getQuantifiedItemByGIDInInventoryOrMakeUpOne(ingredients[i].id);
               items.push(iw);
               if(iw.quantity > 0)
               {
                  myPieces++;
               }
            }
            this.gd_mapPieces.width = totalPieces * 46 + 2;
            this.gd_mapPieces.dataProvider = items;
         }
         this.lbl_mapRecap.text = this.uiApi.processText(this.uiApi.getText("ui.treasureHunt.pieces",myPieces,totalPieces),"",myPieces <= 1,myPieces == 0);
         this.ctr_map.x = this.gd_mapPieces.x + this.gd_mapPieces.width + 4;
         this.btn_start.disabled = this._availableHunts.indexOf(this._selectedHunt.id) == -1;
      }
      
      private function refreshList() : void
      {
         var tempStartableHunts:Array = null;
         var h:LegendaryTreasureHunt = null;
         if(this._showAll)
         {
            this.gd_hunts.dataProvider = this._hunts;
         }
         else
         {
            tempStartableHunts = [];
            for each(h in this._hunts)
            {
               if(h && this._availableHunts.indexOf(h.id) > -1)
               {
                  tempStartableHunts.push(h);
               }
            }
            this.gd_hunts.dataProvider = tempStartableHunts;
         }
      }
      
      public function onItemRightClick(target:GraphicContainer, item:Object) : void
      {
         if(item.data)
         {
            this.modContextMenu.createContextMenu(this.menuApi.create(item.data,"item"));
         }
      }
      
      public function onRightClick(target:GraphicContainer) : void
      {
         if(target is Slot)
         {
            this.modContextMenu.createContextMenu(this.menuApi.create((target as Slot).data,"item"));
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_showAll:
               this._showAll = this.btn_showAll.selected;
               this.refreshList();
               break;
            case this.btn_start:
               this.onPopupValid();
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.slot_map:
               if((target as Slot).data)
               {
                  this.uiApi.showTooltip((target as Slot).data,target,false,"standard",LocationEnum.POINT_BOTTOMRIGHT,LocationEnum.POINT_TOPRIGHT,0,"itemName",null,{
                     "showEffects":true,
                     "header":true
                  },"ItemInfo");
               }
               break;
            case this.tx_craftMap:
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.treasureHunt.craftMap")),target,false,"standard",6,2,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onItemRollOver(target:GraphicContainer, item:Object) : void
      {
         if(!item.data)
         {
            return;
         }
         this.uiApi.showTooltip(item.data,target,false,"standard",LocationEnum.POINT_BOTTOMRIGHT,LocationEnum.POINT_TOPRIGHT,0,"itemName",null,{
            "showEffects":true,
            "header":true
         },"ItemInfo");
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
               this.uiApi.unloadUi(this.uiApi.me().name);
         }
         return true;
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(target == this.gd_hunts)
         {
            this._selectedHunt = (target as Grid).selectedItem;
            this.displayHunt();
         }
      }
      
      public function onPopupClose() : void
      {
      }
      
      public function onPopupValid() : void
      {
         if(!this._selectedHunt)
         {
            return;
         }
         this.sysApi.sendAction(new TreasureHuntLegendaryRequestAction([this._selectedHunt.id]));
      }
      
      private function onTreasureHunt(treasureHuntType:uint) : void
      {
         if(treasureHuntType == TreasureHuntTypeEnum.TREASURE_HUNT_LEGENDARY)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
   }
}
