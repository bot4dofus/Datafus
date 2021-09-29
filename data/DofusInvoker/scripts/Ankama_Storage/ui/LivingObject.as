package Ankama_Storage.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.ProgressBar;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.livingObject.LivingObjectDissociateAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.misc.lists.LivingObjectHookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   
   public class LivingObject
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Object;
      
      private var _item:ItemWrapper;
      
      private var ctr_look:LivingObjectLook;
      
      public var btn_close:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var btn_look:ButtonContainer;
      
      public var btn_destroy:ButtonContainer;
      
      public var btn_feed:ButtonContainer;
      
      public var slot_icon:Slot;
      
      public var pb_xp:ProgressBar;
      
      public var lbl_level:Label;
      
      public var lbl_mood:Label;
      
      public var lbl_date:Label;
      
      public function LivingObject()
      {
         super();
      }
      
      public function main(param:Object) : void
      {
         this.uiApi.addComponentHook(this.btn_close,"onRelease");
         this.uiApi.addComponentHook(this.btn_look,"onRelease");
         this.uiApi.addComponentHook(this.btn_destroy,"onRelease");
         this.uiApi.addComponentHook(this.btn_feed,"onRelease");
         this.uiApi.addComponentHook(this.pb_xp,"onRollOver");
         this.uiApi.addComponentHook(this.pb_xp,"onRollOut");
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortCut);
         this.sysApi.addHook(InventoryHookList.EquipmentObjectMove,this.onEquipmentObjectMove);
         this.sysApi.addHook(LivingObjectHookList.LivingObjectUpdate,this.onLivingObjectUpdate);
         this.sysApi.addHook(LivingObjectHookList.LivingObjectFeed,this.onLivingObjectFeed);
         this.sysApi.addHook(LivingObjectHookList.LivingObjectDissociate,this.onLivingObjectDissociate);
         this.sysApi.addHook(LivingObjectHookList.LivingObjectAssociate,this.onLivingObjectAssociate);
         this._item = param.item;
         this.updateLivingObjectInfos();
      }
      
      private function updateLivingObjectInfos() : void
      {
         var xpMax:int = this._item.livingObjectMaxXp;
         if(xpMax == -1)
         {
            this.pb_xp.value = 1;
         }
         else
         {
            this.pb_xp.value = this._item.livingObjectXp / xpMax;
         }
         if(this._item.type.id == DataEnum.ITEM_TYPE_LIVING_OBJECT)
         {
            this.btn_destroy.disabled = true;
            this.btn_feed.disabled = true;
         }
         else
         {
            this.btn_destroy.disabled = false;
            this.btn_feed.disabled = false;
         }
         this.lbl_level.text = this._item.livingObjectLevel.toString();
         this.lbl_date.text = this._item.livingObjectFoodDate;
         this.slot_icon.data = this._item;
         this._item.iconUri;
         var mood:uint = this._item.livingObjectMood;
         if(mood == 0)
         {
            this.lbl_mood.text = this.uiApi.getText("ui.common.lean");
         }
         else if(mood == 1)
         {
            this.lbl_mood.text = this.uiApi.getText("ui.common.satisfied");
         }
         else if(mood == 2)
         {
            this.lbl_mood.text = this.uiApi.getText("ui.common.fat");
         }
         else
         {
            this.lbl_mood.text = "Error";
         }
      }
      
      public function unload() : void
      {
         if(this.uiApi.getUi("livingObjectLook"))
         {
            this.uiApi.unloadUi("livingObjectLook");
         }
      }
      
      private function onEquipmentObjectMove(item:ItemWrapper, oldPosition:uint) : void
      {
         if(item && item.objectUID == this._item.objectUID)
         {
            this._item = item;
            this.updateLivingObjectInfos();
         }
      }
      
      private function onLivingObjectUpdate(item:ItemWrapper) : void
      {
         this._item = item;
         this.updateLivingObjectInfos();
      }
      
      private function onLivingObjectFeed(item:ItemWrapper) : void
      {
         this._item = item;
         this.updateLivingObjectInfos();
      }
      
      private function onLivingObjectDissociate(item:ItemWrapper) : void
      {
         this.uiApi.unloadUi("livingObject");
      }
      
      private function onLivingObjectAssociate(item:ItemWrapper) : void
      {
         this._item = item;
         this.updateLivingObjectInfos();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         if(target == this.btn_close)
         {
            this.uiApi.unloadUi("livingObject");
         }
         else if(target == this.btn_help)
         {
            this.hintsApi.showSubHints();
         }
         else if(target == this.btn_look)
         {
            if(!this.uiApi.getUi("livingObjectLook"))
            {
               this.uiApi.loadUi("livingObjectLook","livingObjectLook",{"item":this._item},StrataEnum.STRATA_HIGH);
            }
         }
         else if(target == this.btn_destroy)
         {
            this.sysApi.sendAction(new LivingObjectDissociateAction([this._item.objectUID,this._item.position]));
         }
         else if(target == this.btn_feed)
         {
            this.sysApi.dispatchHook(HookList.OpenFeed,this._item);
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var textTooltip:String = null;
         var xpMax:int = 0;
         var pos1:int = 7;
         var pos2:int = 1;
         var offset:int = 0;
         if(target == this.pb_xp)
         {
            xpMax = this._item.livingObjectMaxXp;
            if(xpMax == -1)
            {
               textTooltip = String(this._item.livingObjectXp);
            }
            else
            {
               textTooltip = this._item.livingObjectXp + " / " + xpMax;
            }
         }
         this.uiApi.showTooltip(this.uiApi.textTooltipInfo(textTooltip),target,false,"standard",pos1,pos2,offset,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      private function onShortCut(s:String) : Boolean
      {
         if(s == ShortcutHookListEnum.CLOSE_UI)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return true;
         }
         return false;
      }
   }
}
