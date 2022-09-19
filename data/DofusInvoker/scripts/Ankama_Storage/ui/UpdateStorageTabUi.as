package Ankama_Storage.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.GridItemSelectMethodEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.guild.GuildChestTab;
   import com.ankamagames.dofus.datacenter.items.ItemType;
   import com.ankamagames.dofus.logic.game.common.actions.GuildUpdateChestTabRequestAction;
   import com.ankamagames.dofus.network.types.game.inventory.StorageTabInformation;
   import com.ankamagames.dofus.network.types.game.inventory.UpdatedStorageTabInformation;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import flash.utils.Dictionary;
   
   public class UpdateStorageTabUi
   {
      
      private static const GUILD_CHEST_NAME_RESTRICTED_CHARACTERS:RegExp = /[<>{}]/g;
      
      private static const TYPES_CACHE_PREFIX:String = "guildChest_openededTypes_";
       
      
      public var lbl_title_popup:Label;
      
      public var btn_close_popup:ButtonContainer;
      
      public var btn_save:ButtonContainer;
      
      public var lbl_cancel:Label;
      
      public var gd_objectTypes:Grid;
      
      public var inp_guildChestName:Input;
      
      public var tx_chestIcon:Texture;
      
      public var ctr_editChestIcon:GraphicContainer;
      
      public var gd_chestIcons:Grid;
      
      public var ctr_icons:GraphicContainer;
      
      public var hint_rank:Texture;
      
      private const CTR_TYPE_CAT:String = "ctr_category";
      
      private const CTR_TYPE:String = "ctr_type";
      
      private var _oldStorageTabInfo:StorageTabInformation;
      
      private var _objectCategories:Array;
      
      private var _objectCategoriesSelected:Array;
      
      private var _objectTypes:Array;
      
      private var _lastSelectedTypes:Vector.<uint>;
      
      private var _selectedTypes:Vector.<uint>;
      
      private var _currentPicto:uint;
      
      private var _iconIds:Vector.<uint>;
      
      private var _openedCategoryIds:Array;
      
      private var _componentList:Dictionary;
      
      private var _currentCacheName:String;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      public function UpdateStorageTabUi()
      {
         this._objectCategories = [];
         this._objectCategoriesSelected = [];
         this._objectTypes = [];
         this._iconIds = new Vector.<uint>();
         this._openedCategoryIds = [];
         this._componentList = new Dictionary(true);
         super();
      }
      
      public function main(params:StorageTabInformation) : void
      {
         var tabInfo:GuildChestTab = null;
         this.uiApi.addComponentHook(this.btn_close_popup,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_save,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.lbl_cancel,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.tx_chestIcon,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ctr_editChestIcon,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.gd_chestIcons,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.inp_guildChestName,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.hint_rank,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.hint_rank,ComponentHookList.ON_ROLL_OUT);
         this._iconIds = this.socialApi.getGuildRankIconIds();
         this.gd_chestIcons.dataProvider = this._iconIds;
         var size:int = Math.ceil(Math.sqrt(this._iconIds.length)) * 32;
         this.ctr_icons.width = size;
         this.ctr_icons.height = size;
         this.gd_chestIcons.width = size - 10;
         this.gd_chestIcons.height = size - 10;
         this._oldStorageTabInfo = params;
         this._currentPicto = this._oldStorageTabInfo.picto;
         this._lastSelectedTypes = this._oldStorageTabInfo.dropTypeLimitation.concat();
         this._selectedTypes = this._lastSelectedTypes.concat();
         this._currentCacheName = TYPES_CACHE_PREFIX + this._oldStorageTabInfo.tabNumber + "_" + this.playerApi.id();
         this._openedCategoryIds = this.sysApi.getSetData(this._currentCacheName,[]);
         var tabName:String = this._oldStorageTabInfo.name;
         if(tabName.indexOf("guild.chest.tab") != -1)
         {
            tabInfo = GuildChestTab.getGuildChestTabByIndex(this._oldStorageTabInfo.tabNumber);
            if(tabInfo)
            {
               this.lbl_title_popup.text = this.uiApi.getText("ui.guild.chestTitle",tabInfo.name);
               this.inp_guildChestName.text = tabInfo.name;
            }
         }
         else
         {
            this.lbl_title_popup.text = this.uiApi.getText("ui.guild.chestTitle",tabName);
            this.inp_guildChestName.text = tabName;
         }
         this.tx_chestIcon.uri = this.socialApi.getGuildRankIconUriById(this._currentPicto);
         this.tx_chestIcon.handCursor = true;
         this.ctr_editChestIcon.handCursor = true;
         this.initChestIcons();
         this.initObjectCategories();
         this.displayCategories();
      }
      
      public function updateTypes(data:*, componentsRef:*, selected:Boolean, line:uint) : void
      {
         switch(this.getTypesLineType(data,line))
         {
            case this.CTR_TYPE_CAT:
               if(!this._componentList[componentsRef.ctr_category.name])
               {
                  this.uiApi.addComponentHook(componentsRef.ctr_category,ComponentHookList.ON_RELEASE);
               }
               this._componentList[componentsRef.ctr_category.name] = data;
               if(!this._componentList[componentsRef.chk_selectAll.name])
               {
                  this.uiApi.addComponentHook(componentsRef.chk_selectAll,ComponentHookList.ON_RELEASE);
               }
               this._componentList[componentsRef.chk_selectAll.name] = data;
               if(this._openedCategoryIds.indexOf(data.id) != -1)
               {
                  componentsRef.tx_catplusminus.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_minus_grey.png");
               }
               else
               {
                  componentsRef.tx_catplusminus.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "icon_plus_grey.png");
               }
               componentsRef.lbl_categoryName.text = (data as CatTypeGridItem).name;
               componentsRef.chk_selectAll.selected = this.catIsSelected(data as CatTypeGridItem);
               break;
            case this.CTR_TYPE:
               if(!this._componentList[componentsRef.lblcb_type.name])
               {
                  this.uiApi.addComponentHook(componentsRef.lblcb_type,ComponentHookList.ON_RELEASE);
               }
               this._componentList[componentsRef.lblcb_type.name] = data;
               componentsRef.lblcb_type.visible = true;
               componentsRef.lblcb_type.selected = this._selectedTypes.indexOf((data as ItemType).id) != -1;
               componentsRef.btn_label_lblcb_type.text = (data as ItemType).name;
               break;
            default:
               componentsRef.lbl_categoryName.text = "";
               componentsRef.btn_label_lblcb_type.text = "";
               componentsRef.lblcb_type.visible = false;
         }
      }
      
      public function getTypesLineType(data:*, line:uint) : String
      {
         if(!data)
         {
            return "";
         }
         if(data is CatTypeGridItem)
         {
            return this.CTR_TYPE_CAT;
         }
         return this.CTR_TYPE;
      }
      
      public function updateIcon(data:uint, components:*, selected:Boolean) : void
      {
         components.btn_icon.selected = false;
         if(data)
         {
            components.tx_icon.uri = this.socialApi.getGuildRankIconUriById(data);
            components.btn_icon.selected = selected;
         }
         else
         {
            components.tx_icon.uri = null;
         }
      }
      
      private function initObjectCategories() : void
      {
         var equipmentCatType:CatTypeGridItem = new CatTypeGridItem(ItemCategoryEnum.EQUIPMENT_CATEGORY,this.uiApi.getText("ui.common.equipments"));
         this.initObjectTypes(equipmentCatType);
         var consumableCatType:CatTypeGridItem = new CatTypeGridItem(ItemCategoryEnum.CONSUMABLES_CATEGORY,this.uiApi.getText("ui.common.consumables"));
         this.initObjectTypes(consumableCatType);
         var resourceCatType:CatTypeGridItem = new CatTypeGridItem(ItemCategoryEnum.RESOURCES_CATEGORY,this.uiApi.getText("ui.common.ressources"));
         this.initObjectTypes(resourceCatType);
         var cosmeticCatType:CatTypeGridItem = new CatTypeGridItem(ItemCategoryEnum.COSMETICS_CATEGORY,this.uiApi.getText("ui.common.cosmetic"));
         this.initObjectTypes(cosmeticCatType);
      }
      
      private function initObjectTypes(catType:CatTypeGridItem) : void
      {
         var itemType:ItemType = null;
         var typeId:uint = 0;
         var tmpTypeIds:Vector.<uint> = this.dataApi.queryEquals(ItemType,"categoryId",catType.id);
         this._objectTypes.push(catType);
         this._objectCategories.push(catType);
         var sortedTypes:Array = [];
         for each(typeId in tmpTypeIds)
         {
            itemType = this.dataApi.getItemType(typeId);
            if(itemType)
            {
               sortedTypes.push(itemType);
               catType.addType(typeId);
            }
         }
         sortedTypes = sortedTypes.sort(this.sortItemTypesByName);
         this._objectTypes = this._objectTypes.concat(sortedTypes);
         if(this.allTypeSelected(catType) && this._objectCategoriesSelected.indexOf(catType.id) == -1)
         {
            this._objectCategoriesSelected.push(catType.id);
         }
      }
      
      private function sortItemTypesByName(itemTypeA:ItemType, itemTypeB:ItemType) : Number
      {
         var itemTypeNameA:String = this.utilApi.noAccent(itemTypeA.name).toLowerCase();
         var itemTypeNameB:String = this.utilApi.noAccent(itemTypeB.name).toLowerCase();
         if(itemTypeNameA > itemTypeNameB)
         {
            return 1;
         }
         if(itemTypeNameA < itemTypeNameB)
         {
            return -1;
         }
         return 0;
      }
      
      private function displayCategories(selectedCategory:CatTypeGridItem = null) : void
      {
         var myIndex:int = 0;
         var entry:* = undefined;
         var scrollValue:int = 0;
         var selecCatId:int = 0;
         if(selectedCategory)
         {
            selecCatId = selectedCategory.id;
            if(this._openedCategoryIds.indexOf(selecCatId) != -1)
            {
               this._openedCategoryIds.splice(this._openedCategoryIds.indexOf(selecCatId),1);
            }
            else
            {
               this._openedCategoryIds.push(selecCatId);
            }
         }
         var index:int = -1;
         var tempCats:Array = [];
         for each(entry in this._objectTypes)
         {
            if(entry is CatTypeGridItem)
            {
               tempCats.push(entry);
               index++;
               if(entry.id == selecCatId)
               {
                  myIndex = index;
               }
            }
            if(entry is ItemType && this._openedCategoryIds.indexOf((entry as ItemType).categoryId) != -1)
            {
               tempCats.push(entry);
               index++;
            }
         }
         scrollValue = this.gd_objectTypes.verticalScrollValue;
         this.gd_objectTypes.dataProvider = tempCats;
         if(this.gd_objectTypes.selectedIndex != myIndex)
         {
            this.gd_objectTypes.silent = true;
            this.gd_objectTypes.selectedIndex = myIndex;
            this.gd_objectTypes.silent = false;
         }
         this.gd_objectTypes.verticalScrollValue = scrollValue;
         this.sysApi.setData(this._currentCacheName,this._openedCategoryIds);
      }
      
      private function selectType(itemType:ItemType) : void
      {
         var index:int = this._selectedTypes.indexOf(itemType.id);
         if(index != -1)
         {
            this._selectedTypes.splice(index,1);
         }
         else
         {
            this._selectedTypes.push(itemType.id);
         }
         var cat:CatTypeGridItem = this.getCategoryById(itemType.categoryId);
         if(cat)
         {
            if(this.allTypeSelected(cat) && this._objectCategoriesSelected.indexOf(cat.id) == -1)
            {
               this._objectCategoriesSelected.push(cat.id);
            }
            else if(this._objectCategoriesSelected.indexOf(cat.id) != -1)
            {
               this._objectCategoriesSelected.splice(this._objectCategoriesSelected.indexOf(cat.id),1);
            }
         }
         this.updateObjectTypesGrid();
         this.updateSaveButton();
      }
      
      private function getCategoryById(catId:uint) : CatTypeGridItem
      {
         var cat:CatTypeGridItem = null;
         for each(cat in this._objectCategories)
         {
            if(cat.id == catId)
            {
               return cat;
            }
         }
         return null;
      }
      
      private function selectAllType(cat:CatTypeGridItem) : void
      {
         var typeId:uint = 0;
         for each(typeId in cat.objectTypes)
         {
            if(this._selectedTypes.indexOf(typeId) == -1)
            {
               this._selectedTypes.push(typeId);
            }
         }
         this._objectCategoriesSelected.push(cat.id);
         this.updateObjectTypesGrid();
         this.updateSaveButton();
      }
      
      private function unselectAllType(cat:CatTypeGridItem) : void
      {
         var typeId:uint = 0;
         var index:int = -1;
         for each(typeId in cat.objectTypes)
         {
            index = this._selectedTypes.indexOf(typeId);
            if(index != -1)
            {
               this._selectedTypes.splice(index,1);
            }
         }
         this._objectCategoriesSelected.splice(this._objectCategoriesSelected.indexOf(cat.id),1);
         this.updateObjectTypesGrid();
         this.updateSaveButton();
      }
      
      private function catIsSelected(cat:CatTypeGridItem) : Boolean
      {
         return this._objectCategoriesSelected.indexOf(cat.id) != -1 || this.allTypeSelected(cat);
      }
      
      private function allTypeSelected(cat:CatTypeGridItem) : Boolean
      {
         var typeId:uint = 0;
         for each(typeId in cat.objectTypes)
         {
            if(this._selectedTypes.indexOf(typeId) == -1)
            {
               return false;
            }
         }
         return true;
      }
      
      private function save() : void
      {
         var updatedStorageTabInfo:UpdatedStorageTabInformation = new UpdatedStorageTabInformation();
         updatedStorageTabInfo.tabNumber = this._oldStorageTabInfo.tabNumber;
         updatedStorageTabInfo.name = this.sysApi.trimString(this.inp_guildChestName.text);
         updatedStorageTabInfo.picto = this._currentPicto;
         updatedStorageTabInfo.dropTypeLimitation = this._selectedTypes;
         this.sysApi.sendAction(GuildUpdateChestTabRequestAction.create(updatedStorageTabInfo));
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      private function cancel() : void
      {
         this.inp_guildChestName.text = this._oldStorageTabInfo.name;
         this._currentPicto = this._oldStorageTabInfo.picto;
         this.tx_chestIcon.uri = this.socialApi.getGuildRankIconUriById(this._currentPicto);
         this._selectedTypes = this._lastSelectedTypes.concat();
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      private function initChestIcons() : void
      {
         this.gd_chestIcons.dataProvider = this._iconIds;
         this.gd_chestIcons.selectedItem = this._currentPicto;
         this.gd_chestIcons.updateItem(this.gd_chestIcons.selectedIndex);
      }
      
      private function chooseAChestIcon(iconId:uint) : void
      {
         this._currentPicto = iconId;
         this.tx_chestIcon.uri = this.socialApi.getGuildRankIconUriById(iconId);
      }
      
      private function updateObjectTypesGrid() : void
      {
         var scrollValue:int = this.gd_objectTypes.verticalScrollValue;
         this.gd_objectTypes.updateItems();
         this.gd_objectTypes.verticalScrollValue = scrollValue;
      }
      
      private function checkIfRightsMatch() : Boolean
      {
         var i:int = 0;
         if(this._lastSelectedTypes.length == this._selectedTypes.length)
         {
            for(i = 0; i < this._lastSelectedTypes.length; i++)
            {
               if(this._selectedTypes.indexOf(this._lastSelectedTypes[i]) == -1)
               {
                  return false;
               }
            }
            return true;
         }
         return false;
      }
      
      private function updateSaveButton() : void
      {
         var trimmedText:String = this.sysApi.trimString(this.inp_guildChestName.text);
         var isText:Boolean = Boolean(trimmedText);
         this.btn_save.softDisabled = !isText || this.inp_guildChestName.text.length < 1 || this.inp_guildChestName.text.length > this.uiApi.me().getConstant("chestNameMaxChar") || this.utilApi.noAccent(this._oldStorageTabInfo.name).toLowerCase() == this.utilApi.noAccent(trimmedText).toLowerCase() && this._currentPicto == this._oldStorageTabInfo.picto && this.checkIfRightsMatch();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var itemType:ItemType = null;
         var cat:CatTypeGridItem = null;
         var buildIconVisible:Boolean = this.ctr_icons.visible;
         this.ctr_icons.visible = false;
         switch(target)
         {
            case this.btn_close_popup:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_save:
               this.save();
               break;
            case this.lbl_cancel:
               this.cancel();
               break;
            case this.ctr_editChestIcon:
            case this.tx_chestIcon:
               this.gd_chestIcons.selectedItem = this._currentPicto;
               this.ctr_icons.visible = !buildIconVisible;
               break;
            default:
               if(target.name.indexOf("ctr_category") != -1)
               {
                  this.displayCategories(this._componentList[target.name]);
               }
               else if(target.name.indexOf("lblcb_type") != -1)
               {
                  itemType = this._componentList[target.name] as ItemType;
                  this.selectType(itemType);
               }
               else if(target.name.indexOf("chk_selectAll") != -1)
               {
                  cat = this._componentList[target.name] as CatTypeGridItem;
                  if(this._objectCategoriesSelected.indexOf(cat.id) == -1)
                  {
                     this.selectAllType(cat);
                  }
                  else
                  {
                     this.unselectAllType(cat);
                  }
               }
         }
      }
      
      public function onSelectItem(target:Object, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(selectMethod == GridItemSelectMethodEnum.CLICK)
         {
            if(target == this.gd_chestIcons)
            {
               if(selectMethod != GridItemSelectMethodEnum.AUTO)
               {
                  this.chooseAChestIcon(target.selectedItem);
                  this.ctr_icons.visible = false;
                  this.updateSaveButton();
               }
            }
         }
      }
      
      public function onChange(target:Object) : void
      {
         if(target != this.inp_guildChestName)
         {
            return;
         }
         if(this.inp_guildChestName.text !== null)
         {
            this.inp_guildChestName.text = this.inp_guildChestName.text.replace(GUILD_CHEST_NAME_RESTRICTED_CHARACTERS,"");
         }
         this.updateSaveButton();
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         switch(target)
         {
            case this.hint_rank:
               tooltipText = StringUtils.escapeHTMLText(this.uiApi.getText("ui.guild.nameRulesChest",this.uiApi.me().getConstant("chestNameMaxChar")));
         }
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_TOPRIGHT,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
   }
}

class CatTypeGridItem
{
    
   
   public var id:uint;
   
   public var name:String;
   
   public var objectTypes:Vector.<uint>;
   
   function CatTypeGridItem(pId:uint, pName:String)
   {
      this.objectTypes = new Vector.<uint>();
      super();
      this.id = pId;
      this.name = pName;
   }
   
   public function addType(typeId:uint) : void
   {
      if(this.objectTypes.indexOf(typeId) == -1)
      {
         this.objectTypes.push(typeId);
      }
   }
}
