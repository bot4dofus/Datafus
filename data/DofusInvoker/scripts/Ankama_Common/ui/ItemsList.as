package Ankama_Common.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.types.data.GridItem;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.StorageApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   
   public class ItemsList
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="StorageApi")]
      public var storageApi:StorageApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Object;
      
      private var _selectedItemUID:int = -1;
      
      private var _itemsToDisplay:Vector.<ItemWrapper>;
      
      private var _callbackSelect:Function;
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_window:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var btn_unequip:ButtonContainer;
      
      public var gd_items:Grid;
      
      public var lbl_title:Label;
      
      public function ItemsList()
      {
         super();
      }
      
      public function main(param:Object) : void
      {
         this.btn_close.soundId = SoundEnum.WINDOW_CLOSE;
         this.uiApi.addComponentHook(this.gd_items,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.VALID_UI,this.onValidUi);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortcut);
         this.display(param.selectedItemUID,param.items,param.title,param.callback);
      }
      
      public function display(selectedItemUID:int, items:Vector.<ItemWrapper>, title:String, callback:Function) : void
      {
         var itemw:ItemWrapper = null;
         var index:int = 0;
         var found:Boolean = false;
         this.lbl_title.text = title;
         this._selectedItemUID = selectedItemUID;
         this._callbackSelect = callback;
         this._itemsToDisplay = items;
         this.gd_items.dataProvider = this._itemsToDisplay;
         this.ctr_window.x = 0;
         this.ctr_window.y = 0;
         this.mainCtr.x = this.uiApi.getMouseX() + 20;
         this.mainCtr.y = this.uiApi.getMouseY() + 20;
         if(this._selectedItemUID != -1)
         {
            index = 0;
            for each(itemw in this._itemsToDisplay)
            {
               if(itemw.objectUID == this._selectedItemUID)
               {
                  found = true;
                  break;
               }
               index++;
            }
            if(found)
            {
               this.gd_items.selectedIndex = index;
            }
            this.btn_unequip.disabled = false;
         }
         else
         {
            this.btn_unequip.disabled = true;
         }
      }
      
      public function unload() : void
      {
         this.uiApi.hideTooltip();
         this.uiApi.resetUiSavedUserModification(this.uiApi.me().name);
      }
      
      public function onValidUi(pShortcut:String) : Boolean
      {
         return false;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_unequip:
               this._callbackSelect(-1);
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_help:
               this.hintsApi.showSubHints();
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
      
      public function onSelectItem(target:Grid, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(target == this.gd_items && selectMethod != SelectMethodEnum.AUTO)
         {
            if(this.gd_items.selectedItem.objectUID != this._selectedItemUID)
            {
               this._callbackSelect(this.gd_items.selectedItem.objectUID);
               this.uiApi.unloadUi(this.uiApi.me().name);
            }
         }
      }
      
      public function onItemRollOver(target:Grid, item:GridItem) : void
      {
         var itemTooltipSettings:ItemTooltipSettings = null;
         var tooltipData:Object = null;
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
               tooltipData = item.data;
            }
            this.uiApi.showTooltip(tooltipData,item.container,false,"standard",8,0,0,"itemName",null,{
               "showEffects":true,
               "header":true,
               "description":itemTooltipSettings.description
            },"ItemInfo");
         }
      }
      
      public function onItemRollOut(target:Grid, item:GridItem) : void
      {
         this.uiApi.hideTooltip();
      }
   }
}
