package Ankama_Common.ui.items
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.jobs.KnownJobWrapper;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.JobsApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.Version;
   import flash.utils.Dictionary;
   
   public class RecipeItem
   {
      
      private static var uriMissingIngredients:Uri;
      
      private static var uriNoIngredients:Uri;
      
      private static var uriMissingIngredientsSlot:Uri;
      
      private static var uriNoIngredientsSlot:Uri;
       
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:Object;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="JobsApi")]
      public var jobApi:JobsApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="InventoryApi")]
      public var inventoryApi:InventoryApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      private var _data;
      
      private var _item;
      
      private var _selected:Boolean;
      
      private var _componentsList:Dictionary;
      
      private var _changeVersion:String = null;
      
      public var tx_historyIcon:Texture;
      
      public var tx_slot_background:Texture;
      
      public var slotCraftedItem:Slot;
      
      public var gd_recipe:Grid;
      
      public var lbl_level:Label;
      
      public var lbl_job:Label;
      
      public var lbl_name:Label;
      
      public var lbl_noRecipe:Label;
      
      public function RecipeItem()
      {
         this._componentsList = new Dictionary(true);
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         var uriBase:String = null;
         if(!uriMissingIngredients)
         {
            uriBase = this.uiApi.me().getConstant("assets");
            uriMissingIngredients = this.uiApi.createUri(uriBase + "tx_coloredWarning");
            uriNoIngredients = this.uiApi.createUri(uriBase + "tx_coloredCross");
            uriBase = this.uiApi.me().getConstant("slotTexture");
            uriMissingIngredientsSlot = this.uiApi.createUri(uriBase + "warningSlot.png");
            uriNoIngredientsSlot = this.uiApi.createUri(uriBase + "refuseDrop.png");
         }
         this._data = oParam.data;
         if(oParam.hasOwnProperty("item"))
         {
            this._item = oParam.item;
         }
         this.uiApi.addComponentHook(this.slotCraftedItem,"onRollOver");
         this.uiApi.addComponentHook(this.slotCraftedItem,"onRollOut");
         this.uiApi.addComponentHook(this.slotCraftedItem,"onRightClick");
         this.slotCraftedItem.allowDrag = false;
         this.update(this._data,this._selected);
      }
      
      public function get data() : *
      {
         return this._data;
      }
      
      public function get selected() : Boolean
      {
         return this._selected;
      }
      
      public function update(data:*, selected:Boolean) : void
      {
         var currentVersion:Version = null;
         var majorMinorVersion:String = null;
         this._data = data;
         if(!this._data)
         {
            if(this._item)
            {
               this.tx_slot_background.visible = true;
               this.slotCraftedItem.data = this._item;
               this.lbl_name.text = this._item.name;
               if(this.sysApi.getPlayerManager().hasRights)
               {
                  this.lbl_name.text += " (" + this._item.id + ")";
               }
               this.lbl_level.text = this.uiApi.getText("ui.common.short.level") + " " + this._item.level;
               this.lbl_job.text = "";
               this.lbl_level.x = this.uiApi.me().getConstant("lbl_levelXNoJob");
               this.gd_recipe.visible = false;
               this.lbl_noRecipe.visible = true;
            }
            else
            {
               this.tx_slot_background.visible = false;
               this.slotCraftedItem.data = null;
               this.lbl_name.text = "";
               this.lbl_level.text = "";
               this.lbl_job.text = "";
               this.gd_recipe.visible = false;
               this.lbl_noRecipe.visible = false;
            }
            this.tx_historyIcon.visible = false;
            return;
         }
         this.lbl_name.text = this._data.result.name;
         this.lbl_level.text = this.uiApi.getText("ui.common.short.level") + " " + this._data.result.level.toString();
         var job:KnownJobWrapper = this.jobApi.getKnownJob(this._data.jobId);
         if(job && this._data.jobId > DataEnum.JOB_ID_BASE)
         {
            this.lbl_job.text = "(" + job.name + ")";
            this.lbl_level.x = this.uiApi.me().getConstant("lbl_levelXWithJob");
         }
         else
         {
            this.lbl_job.text = "";
            this.lbl_level.x = this.uiApi.me().getConstant("lbl_levelXNoJob");
         }
         this.slotCraftedItem.data = this._data.result;
         this.slotCraftedItem.visible = this.tx_slot_background.visible = true;
         if(this._data.ingredients.length == 0)
         {
            this.gd_recipe.visible = false;
            this.lbl_noRecipe.visible = true;
         }
         else
         {
            this.lbl_noRecipe.visible = false;
            this.gd_recipe.width = this.gd_recipe.slotWidth * this._data.ingredients.length;
            this.gd_recipe.dataProvider = this._data.ingredients;
            this.gd_recipe.visible = true;
         }
         this.tx_historyIcon.visible = true;
         if(!data.changeVersion || isNaN(data.tooltipExpirationDate) || data.tooltipExpirationDate <= 0 || data.tooltipExpirationDate <= this.timeApi.getTimestamp())
         {
            this.tx_historyIcon.visible = false;
            this.uiApi.removeComponentHook(this.tx_historyIcon,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(this.tx_historyIcon,ComponentHookList.ON_ROLL_OUT);
            this._changeVersion = null;
         }
         else
         {
            this.tx_historyIcon.visible = true;
            this.uiApi.addComponentHook(this.tx_historyIcon,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_historyIcon,ComponentHookList.ON_ROLL_OUT);
            this._changeVersion = data.changeVersion;
            currentVersion = this.sysApi.getCurrentVersion();
            majorMinorVersion = null;
            if(currentVersion !== null)
            {
               majorMinorVersion = currentVersion.major.toString() + "." + currentVersion.minor.toString();
            }
            if(majorMinorVersion !== null && majorMinorVersion.indexOf(data.changeVersion) === 0)
            {
               this.tx_historyIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "clock_arrow_yellow.png");
            }
            else
            {
               this.tx_historyIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "clock_arrow.png");
            }
         }
      }
      
      public function updateItems(data:*, componentsRef:*, selected:Boolean) : void
      {
         var ownedQty:uint = 0;
         var requiredQty:uint = 0;
         var uriSlot:Uri = null;
         var uriIcon:Uri = null;
         if(!this._componentsList[componentsRef.slot_item.name])
         {
            this.uiApi.addComponentHook(componentsRef.slot_item,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.slot_item,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(componentsRef.slot_item,ComponentHookList.ON_RIGHT_CLICK);
            this.uiApi.addComponentHook(componentsRef.slot_item,ComponentHookList.ON_RELEASE);
         }
         this._componentsList[componentsRef.slot_item.name] = data;
         if(!this._componentsList[componentsRef.tx_ingredientStateIcon.name])
         {
            this.uiApi.addComponentHook(componentsRef.tx_ingredientStateIcon,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.tx_ingredientStateIcon,ComponentHookList.ON_ROLL_OUT);
         }
         this._componentsList[componentsRef.tx_ingredientStateIcon.name] = data;
         if(data)
         {
            componentsRef.slot_item.data = data;
            ownedQty = this.inventoryApi.getItemQty(data.id);
            requiredQty = data.quantity;
            uriSlot = null;
            uriIcon = null;
            if(ownedQty == 0)
            {
               uriSlot = uriNoIngredientsSlot;
               uriIcon = uriNoIngredients;
            }
            else if(ownedQty < requiredQty)
            {
               uriSlot = uriMissingIngredientsSlot;
               uriIcon = uriMissingIngredients;
            }
            componentsRef.tx_ingredientStateIcon.uri = uriIcon;
            componentsRef.slot_item.customTexture = uriSlot;
            componentsRef.slot_item.selectedTexture = uriSlot;
            componentsRef.slot_item.highlightTexture = uriSlot;
            componentsRef.slot_item.visible = true;
         }
         else
         {
            componentsRef.tx_ingredientStateIcon.uri = null;
            componentsRef.slot_item.customTexture = null;
            componentsRef.slot_item.selectedTexture = null;
            componentsRef.slot_item.highlightTexture = null;
            componentsRef.slot_item.visible = false;
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var ownedQty:uint = 0;
         var requiredQty:uint = 0;
         var txt:String = null;
         switch(target)
         {
            case this.slotCraftedItem:
               if((target as Slot).data)
               {
                  this.uiApi.showTooltip((target as Slot).data,target,false,"standard",8,0,0,"itemName",null,{
                     "showEffects":true,
                     "header":true
                  },"ItemInfo");
               }
               break;
            case this.tx_historyIcon:
               if(this._changeVersion)
               {
                  this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.jobs.versionNotice",this._changeVersion)),target,false,"standard",7,1,3,null,null,null,"TextInfo");
               }
               break;
            default:
               if(target.name.indexOf("slot_item") != -1)
               {
                  this.uiApi.showTooltip(this._componentsList[target.name],target,false,"standard",6,2,3,"itemName",null,{
                     "showEffects":true,
                     "header":true
                  },"ItemInfo");
               }
               else if(target.name.indexOf("tx_ingredientStateIcon") != -1)
               {
                  ownedQty = this.inventoryApi.getItemQty(this._componentsList[target.name].id);
                  requiredQty = this._componentsList[target.name].quantity;
                  if(requiredQty > ownedQty)
                  {
                     txt = this.uiApi.getText("ui.craft.ingredientNotEnough");
                     if(ownedQty == 0)
                     {
                        txt = this.uiApi.getText("ui.craft.noIngredient");
                     }
                     this.uiApi.showTooltip(this.uiApi.textTooltipInfo(txt),target,false,"standard",LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_BOTTOMRIGHT,6);
                  }
               }
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         this.sysApi.dispatchHook(ExchangeHookList.BidHouseSelectItemFromRecipe,(target as Slot).data);
      }
      
      public function onRightClick(target:Slot) : void
      {
         var contextMenu:Object = null;
         if(target.data)
         {
            contextMenu = this.menuApi.create(target.data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
   }
}
