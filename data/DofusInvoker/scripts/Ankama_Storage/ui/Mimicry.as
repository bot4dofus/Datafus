package Ankama_Storage.ui
{
   import Ankama_Common.Common;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.CloseInventoryAction;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.MimicryObjectFeedAndAssociateRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.misc.lists.LivingObjectHookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.StorageApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.events.TimerEvent;
   
   public class Mimicry
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="StorageApi")]
      public var storageApi:StorageApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="InventoryApi")]
      public var inventoryApi:InventoryApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      private var _itemMimicry:ItemWrapper;
      
      private var _itemHost:ItemWrapper;
      
      private var _itemFood:ItemWrapper;
      
      private var _itemResult:ItemWrapper;
      
      private var _waitingSlot:Slot;
      
      private var _slotsIngredients:Array;
      
      private var _okButtonDisabled:Boolean;
      
      private var _updateTimer:BenchmarkTimer;
      
      private var _popupName:String;
      
      public var tx_ingredients_selected:Texture;
      
      public var tx_ingredients_content:Texture;
      
      public var lbl_previewItem:Label;
      
      public var slot_ingredient_1:Slot;
      
      public var slot_ingredient_2:Slot;
      
      public var slot_ingredient_3:Slot;
      
      public var slot_item_preview:Slot;
      
      public var ctr_slot1:GraphicContainer;
      
      public var ctr_slot2:GraphicContainer;
      
      public var ctr_slot3:GraphicContainer;
      
      public var ctr_slot4:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_ok:ButtonContainer;
      
      public function Mimicry()
      {
         super();
      }
      
      public function main(param:Object) : void
      {
         var slot:* = undefined;
         var mimicryItem:ItemWrapper = null;
         var myItem:ItemWrapper = null;
         this.sysApi.disableWorldInteraction();
         this.sysApi.addHook(LivingObjectHookList.MimicryObjectPreview,this.onMimicryObjectPreview);
         this.sysApi.addHook(LivingObjectHookList.MimicryObjectAssociated,this.onMimicryObjectAssociated);
         this.sysApi.addHook(HookList.DoubleClickItemInventory,this.onDoubleClickItemInventory);
         this.sysApi.addHook(InventoryHookList.ObjectSelected,this.onObjectSelected);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortCut);
         this.uiApi.addComponentHook(this.btn_ok,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_close,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.slot_item_preview,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.slot_item_preview,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.slot_item_preview,ComponentHookList.ON_ITEM_RIGHT_CLICK);
         this.uiApi.addComponentHook(this.slot_item_preview,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ctr_slot1,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_slot1,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.ctr_slot2,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_slot2,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.ctr_slot3,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_slot3,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.ctr_slot4,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_slot4,ComponentHookList.ON_ROLL_OUT);
         this._updateTimer = new BenchmarkTimer(300,1,"Mimicry._updateTimer");
         this._slotsIngredients = [this.slot_ingredient_1,this.slot_ingredient_2,this.slot_ingredient_3];
         for each(slot in this._slotsIngredients)
         {
            this.registerSlot(slot);
         }
         this.btn_ok.disabled = true;
         if(param)
         {
            mimicryItem = this.inventoryApi.getItem(int(param));
            if(mimicryItem)
            {
               this._itemMimicry = mimicryItem;
               myItem = this.dataApi.getItemWrapper(mimicryItem.objectGID,mimicryItem.position,mimicryItem.objectUID,1,mimicryItem.effectsList);
               this.fillSlot(this.slot_ingredient_1,myItem);
            }
         }
      }
      
      public function unload() : void
      {
         if(this._popupName != null && this.uiApi.getUi(this._popupName))
         {
            this.uiApi.unloadUi(this._popupName);
         }
         this.uiApi.unloadUi("itemBoxMimicry");
         this._updateTimer.stop();
         this._updateTimer.removeEventListener(TimerEvent.TIMER,this.onTimerEvent);
         this._updateTimer = null;
         this.storageApi.releaseHooks();
         this.sysApi.sendAction(new LeaveDialogRequestAction([]));
         this.sysApi.sendAction(new CloseInventoryAction([]));
         this.sysApi.enableWorldInteraction();
      }
      
      public function processDropToInventory(target:Object, d:Object, source:Object) : void
      {
         this.unfillSlot(this._waitingSlot);
      }
      
      public function fillAutoSlot(item:Object, force:Boolean = false) : void
      {
         var slot:Object = null;
         for each(slot in this._slotsIngredients)
         {
            if(slot.data && slot.data.objectGID == item.objectGID)
            {
               this.fillSlot(slot,item);
               return;
            }
            if(slot.data == null)
            {
               this.fillSlot(slot,item);
               return;
            }
         }
         if(force)
         {
            this.fillSlot(null,item);
         }
      }
      
      protected function registerSlot(slot:Slot) : void
      {
         slot.dropValidator = this.dropValidatorFunction as Function;
         slot.processDrop = this.processDropFunction as Function;
         this.uiApi.addComponentHook(slot,"onRollOver");
         this.uiApi.addComponentHook(slot,"onRollOut");
         this.uiApi.addComponentHook(slot,"onDoubleClick");
         this.uiApi.addComponentHook(slot,"onRightClick");
         this.uiApi.addComponentHook(slot,"onRelease");
      }
      
      protected function switchOkButtonState() : void
      {
         var slot:Object = null;
         this._okButtonDisabled = false;
         for each(slot in this._slotsIngredients)
         {
            if(slot.data == null)
            {
               this._okButtonDisabled = true;
            }
         }
         this.btn_ok.disabled = this._okButtonDisabled;
      }
      
      private function fillSlot(slot:Object, item:Object) : void
      {
         this.restartUpdateTimer();
         if(slot != null && slot.data != null && item && slot.data.objectUID == item.objectUID)
         {
            this.unfillSlot(slot);
         }
         else
         {
            slot.data = item;
            if(slot == this.slot_ingredient_1)
            {
               this._itemMimicry = item as ItemWrapper;
            }
            else if(slot == this.slot_ingredient_2)
            {
               this._itemHost = item as ItemWrapper;
            }
            else if(slot == this.slot_ingredient_3)
            {
               this._itemFood = item as ItemWrapper;
            }
         }
      }
      
      private function unfillSlot(slot:Object) : void
      {
         this.restartUpdateTimer();
         if(slot == null || slot.data == null)
         {
            return;
         }
         slot.data = null;
         if(slot == this.slot_ingredient_1)
         {
            this._itemMimicry = null;
         }
         else if(slot == this.slot_ingredient_2)
         {
            this._itemHost = null;
         }
         else if(slot == this.slot_ingredient_3)
         {
            this._itemFood = null;
         }
      }
      
      private function restartUpdateTimer() : void
      {
         this._updateTimer.reset();
         this._updateTimer.addEventListener(TimerEvent.TIMER,this.onTimerEvent);
         this._updateTimer.start();
      }
      
      private function dropValidatorFunction(target:Object, data:Object, source:Object) : Boolean
      {
         if(!data)
         {
            return false;
         }
         switch(target)
         {
            case this.slot_ingredient_1:
               if(data.typeId == DataEnum.ITEM_TYPE_MIMISYMBIC)
               {
                  return true;
               }
               break;
            case this.slot_ingredient_2:
            case this.slot_ingredient_3:
               if(data.category == 0 && data.typeId != DataEnum.ITEM_TYPE_MIMISYMBIC)
               {
                  return true;
               }
               break;
         }
         return false;
      }
      
      private function processDropFunction(target:Object, d:Object, source:Object) : void
      {
         var myItem:ItemWrapper = null;
         var targetItem:ItemWrapper = null;
         if(this.dropValidatorFunction(target,d,source))
         {
            myItem = this.dataApi.getItemWrapper(d.objectGID,d.position,d.objectUID,1,d.effectsList);
            targetItem = target.data;
            this.fillSlot(target,myItem);
            if(source == this.slot_ingredient_1 || source == this.slot_ingredient_2 || source == this.slot_ingredient_3)
            {
               this.fillSlot(source,targetItem);
            }
         }
      }
      
      private function validAssociation() : void
      {
         if(this._itemMimicry && this._itemHost && this._itemFood && this._itemResult && this.btn_ok.disabled == false && this._popupName == null)
         {
            this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.mimicry.confirmPopup",this._itemHost.name,this._itemMimicry.name,this._itemFood.name),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.no")],[this.onConfirmAssociate,this.onCancelAssociate],this.onConfirmAssociate,this.onCancelAssociate);
         }
      }
      
      private function onMimicryObjectPreview(item:ItemWrapper, errorText:String) : void
      {
         this._itemResult = item;
         if(this._itemResult)
         {
            this.lbl_previewItem.visible = false;
            this.btn_ok.disabled = false;
         }
         else
         {
            this.lbl_previewItem.visible = true;
            if(errorText != "")
            {
               this.lbl_previewItem.text = errorText;
            }
            this.btn_ok.disabled = true;
         }
         this.slot_item_preview.data = this._itemResult;
      }
      
      private function onMimicryObjectAssociated(item:ItemWrapper) : void
      {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      protected function onConfirmAssociate() : void
      {
         this._popupName = null;
         this.sysApi.sendAction(new MimicryObjectFeedAndAssociateRequestAction([this._itemMimicry.objectUID,this._itemMimicry.position,this._itemFood.objectUID,this._itemFood.position,this._itemHost.objectUID,this._itemHost.position,false]));
      }
      
      protected function onCancelAssociate() : void
      {
         this._popupName = null;
      }
      
      public function onDoubleClickItemInventory(pItem:Object, pQuantity:int = 1) : void
      {
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_ok:
               this.validAssociation();
               break;
            default:
               if(target.name.indexOf("slot") != -1 && (target as Slot).data)
               {
                  this.onObjectSelected(target);
               }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         if(target is Slot && (target as Slot).data)
         {
            this.uiApi.showTooltip((target as Slot).data,target,false,"standard",8,0,0,"itemName",null,{
               "showEffects":true,
               "header":true
            },"ItemInfo");
         }
         else
         {
            switch(target)
            {
               case this.ctr_slot1:
                  text = this.uiApi.getText("ui.mimicry.mimicry") + " " + this.uiApi.getText("ui.mimicry.toBeDestroyed");
                  break;
               case this.ctr_slot2:
                  text = this.uiApi.getText("ui.mimicry.host");
                  break;
               case this.ctr_slot3:
                  text = this.uiApi.getText("ui.mimicry.food") + " " + this.uiApi.getText("ui.mimicry.toBeDestroyed");
                  break;
               case this.ctr_slot4:
                  text = this.uiApi.getText("ui.craft.itemCreated");
            }
            if(text)
            {
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
            }
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onDoubleClick(target:GraphicContainer) : void
      {
         if((target as Slot).data && (target as Slot).data != this.slot_ingredient_1.data)
         {
            this.unfillSlot(target);
         }
      }
      
      private function onShortCut(s:String) : Boolean
      {
         if(s == ShortcutHookListEnum.CLOSE_UI)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return true;
         }
         if(s == ShortcutHookListEnum.VALID_UI)
         {
            this.validAssociation();
            return true;
         }
         return false;
      }
      
      public function onObjectSelected(item:Object) : void
      {
         if(!this.sysApi.getOption("displayTooltips","dofus"))
         {
            this.lbl_previewItem.visible = false;
         }
      }
      
      public function onRightClick(target:GraphicContainer) : void
      {
         var data:Object = null;
         var contextMenu:Object = null;
         if(target is Slot)
         {
            data = (target as Slot).data;
            contextMenu = this.menuApi.create(data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
      
      private function onDropStart(src:Object) : void
      {
         var slot:Object = null;
         this._waitingSlot = src as Slot;
         for each(slot in this._slotsIngredients)
         {
            if(this.dropValidatorFunction(slot,src.data,null))
            {
               slot.selected = true;
            }
         }
      }
      
      private function onDropEnd(src:Object) : void
      {
         var slot:Object = null;
         for each(slot in this._slotsIngredients)
         {
            slot.selected = false;
         }
      }
      
      protected function onTimerEvent(e:TimerEvent) : void
      {
         if(this.slot_ingredient_1.data != null && this.slot_ingredient_2.data != null && this.slot_ingredient_3.data != null)
         {
            this.sysApi.sendAction(new MimicryObjectFeedAndAssociateRequestAction([this._itemMimicry.objectUID,this._itemMimicry.position,this._itemFood.objectUID,this._itemFood.position,this._itemHost.objectUID,this._itemHost.position,true]));
         }
      }
      
      public function set slotsIngredients(value:Array) : void
      {
         this._slotsIngredients = value;
      }
   }
}
