package Ankama_Web.ui
{
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextArea;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.GridItem;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.AccessoryPreviewRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopBuyRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ShopOverlayBuyRequestAction;
   import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.types.enums.DofusShopEnum;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import mx.utils.StringUtil;
   
   public class ShopPopupItemSet
   {
       
      
      public const ANIMATION_STATIQUE:String = "AnimStatique";
      
      public const ANIMATION_WEAPON:String = "AnimArme8";
      
      public const SKIN_ACTION_ID:int = 1179;
      
      public const WEAPON_TYPE_ID:int = 2;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      public var btn_close:ButtonContainer;
      
      public var ed_popupChar:EntityDisplayer;
      
      public var lbl_description:TextArea;
      
      public var btn_leftArrow:ButtonContainer;
      
      public var btn_rightArrow:ButtonContainer;
      
      public var gd_setItems:Grid;
      
      public var btn_playWeaponAnim:ButtonContainer;
      
      public var btn_lbl_btn_buy:Label;
      
      public var btn_buy:ButtonContainer;
      
      public var lbl_title:Label;
      
      public var btn_buyOverlay:ButtonContainer;
      
      public var btn_getForFree:ButtonContainer;
      
      public var tx_ogrineButton:Texture;
      
      public var btn_lbl_btn_buyOverlay:Label;
      
      public var btn_seeMore:ButtonContainer;
      
      public var ctr_pack:GraphicContainer;
      
      public var gd_pack:Grid;
      
      public var btn_closePack:ButtonContainer;
      
      public var lbl_pack:Label;
      
      private var _containsWeapon:Boolean;
      
      private var _direction:int = 3;
      
      private var _params:Object;
      
      private var _itemsByTypes:Dictionary;
      
      private var _previewItemsPositions:Dictionary;
      
      public function ShopPopupItemSet()
      {
         this._itemsByTypes = new Dictionary();
         this._previewItemsPositions = new Dictionary();
         super();
      }
      
      public function main(params:Object = null) : void
      {
         var itemTmp:Object = null;
         var item:ItemWrapper = null;
         var superTypeId:uint = 0;
         var effect:EffectInstance = null;
         var i:int = 0;
         var hasOgrinePrice:Boolean = false;
         var hasRealPrice:Boolean = false;
         this._params = params;
         this.lbl_title.text = params.article.article.name;
         this.sysApi.addHook(InventoryHookList.AccessoryPreview,this.onAccessoryPreview);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addComponentHook(this.gd_setItems,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.btn_seeMore,ComponentHookList.ON_RELEASE);
         this._containsWeapon = false;
         for each(itemTmp in params.article.items)
         {
            if(!(!(itemTmp is ItemWrapper) || !(itemTmp as ItemWrapper).isCosmetic))
            {
               item = itemTmp as ItemWrapper;
               if(!this.isCosmeticItemId(item.type.id))
               {
                  superTypeId = item.type.superTypeId;
               }
               else
               {
                  for each(effect in item.possibleEffects)
                  {
                     if(effect.effectId == this.SKIN_ACTION_ID)
                     {
                        superTypeId = this.dataApi.getItemType(effect.parameter2 as int).superTypeId;
                     }
                  }
               }
               if(!this._itemsByTypes[superTypeId])
               {
                  this._itemsByTypes[superTypeId] = [];
                  this._previewItemsPositions[superTypeId] = 0;
               }
               if(this._itemsByTypes[superTypeId].indexOf(item) == -1)
               {
                  this._itemsByTypes[superTypeId].push(item);
               }
            }
         }
         if(this._itemsByTypes[this.WEAPON_TYPE_ID])
         {
            this._containsWeapon = true;
         }
         params.article.items = params.article.items.reverse();
         var nbSlots:int = Math.floor(this.gd_setItems.width / this.gd_setItems.slotWidth);
         if(params.article.items.length > nbSlots)
         {
            this.gd_pack.dataProvider = params.article.items;
            this.btn_seeMore.visible = true;
            this.gd_setItems.width -= this.gd_setItems.slotWidth;
            this.gd_setItems.dataProvider = params.article.items.slice(0,nbSlots - 1);
         }
         else
         {
            this.gd_setItems.dataProvider = params.article.items;
         }
         this.preview();
         this.lbl_description.text = params.article.article.description;
         this.lbl_description.text = StringUtil.trim(this.lbl_description.text);
         this.ed_popupChar.look = this.utilApi.getRealTiphonEntityLook(this.playerApi.getPlayedCharacterInfo().id,true);
         if(this.ed_popupChar.look.getBone() == 2)
         {
            this.ed_popupChar.look.setBone(1);
         }
         this.ed_popupChar.setAnimationAndDirection(this.ANIMATION_STATIQUE,this._direction);
         this.uiApi.addComponentHook(this.ed_popupChar,"onEntityReady");
         if(this._params.article.article.isFree)
         {
            this.btn_getForFree.visible = this._params.article.article.availability != DofusShopEnum.SOON_AVAILABLE;
            this.tx_ogrineButton.visible = false;
            this.btn_buyOverlay.visible = false;
            this.btn_buy.visible = false;
         }
         else if(params.article.article.prices)
         {
            hasOgrinePrice = false;
            hasRealPrice = false;
            for(i = 0; i < params.article.article.prices.length; i++)
            {
               if(params.article.article.prices[i].currency == DofusShopEnum.CURRENCY_OGRINES)
               {
                  hasOgrinePrice = true;
                  this.btn_lbl_btn_buy.text = params.article.article.prices[i].price;
               }
               else if(params.article.article.prices[i].paymentmode == DofusShopEnum.PAYMENT_MODE_ONECLICK)
               {
                  hasRealPrice = true;
                  if(this.btn_lbl_btn_buyOverlay.text == "" || params.article.article.prices[i].country != "WD")
                  {
                     this.btn_lbl_btn_buyOverlay.text = params.article.article.prices[i].price + " " + params.article.article.prices[i].currency;
                  }
               }
            }
            if(hasOgrinePrice)
            {
               if(!hasRealPrice)
               {
                  this.btn_buyOverlay.visible = false;
                  this.btn_buy.x = 95;
               }
            }
            else
            {
               this.btn_buy.visible = false;
               this.tx_ogrineButton.visible = false;
               if(hasRealPrice)
               {
                  this.btn_buyOverlay.x = 95;
               }
               else
               {
                  this.btn_buyOverlay.visible = false;
               }
            }
         }
      }
      
      public function unload() : void
      {
         this.ed_popupChar.removeEndAnimationListener(this.onAnimationEnd);
         this.sysApi.dispatchHook(HookList.ClosePopup);
      }
      
      public function onEntityReady(entity:*) : void
      {
         this.uiApi.removeComponentHook(this.ed_popupChar,"onEntityReady");
         this.ed_popupChar.visible = true;
         if(this._containsWeapon)
         {
            this.btn_playWeaponAnim.visible = true;
         }
      }
      
      private function preview() : void
      {
         var id:* = null;
         var previewItems:Vector.<uint> = new Vector.<uint>();
         for(id in this._itemsByTypes)
         {
            previewItems.push(this._itemsByTypes[id][this._previewItemsPositions[id]].objectGID);
         }
         this.sysApi.sendAction(new AccessoryPreviewRequestAction([previewItems]));
      }
      
      private function turnChara(sens:int) : void
      {
         this._direction = (this._direction + sens + 8) % 8;
         if(this.ed_popupChar.animation == this.ANIMATION_WEAPON && this._direction % 2 == 0)
         {
            this.turnChara(sens);
         }
         else
         {
            this.ed_popupChar.direction = this._direction;
         }
      }
      
      private function isCosmeticItemId(id:int) : Boolean
      {
         switch(id)
         {
            case DataEnum.ITEM_TYPE_HARNESS_MOUNT:
            case DataEnum.ITEM_TYPE_COSMETIC_HAT:
            case DataEnum.ITEM_TYPE_COSMETIC_CLOAK:
            case DataEnum.ITEM_TYPE_COSMETIC_SHIELD:
            case DataEnum.ITEM_TYPE_COSMETIC_PET:
            case DataEnum.ITEM_TYPE_COSMETIC_PETMOUNT:
            case DataEnum.ITEM_TYPE_COSMETIC_WEAPON:
            case DataEnum.ITEM_TYPE_COSMETIC_MISC:
            case DataEnum.ITEM_TYPE_HARNESS_MULDO:
            case DataEnum.ITEM_TYPE_HARNESS_FLYHORN:
            case DataEnum.ITEM_TYPE_LIVING_OBJECT:
               return true;
            default:
               return false;
         }
      }
      
      private function onAccessoryPreview(look:Object) : void
      {
         if(look)
         {
            this.ed_popupChar.look = look;
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var id:* = null;
         if(target == this.gd_setItems)
         {
            for(id in this._itemsByTypes)
            {
               if(this._itemsByTypes[id].indexOf(this.gd_setItems.selectedItem) != -1)
               {
                  this._previewItemsPositions[id] = this._itemsByTypes[id].indexOf(this.gd_setItems.selectedItem);
               }
            }
            this.preview();
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_leftArrow:
               this.turnChara(-1);
               break;
            case this.btn_rightArrow:
               this.turnChara(1);
               break;
            case this.btn_playWeaponAnim:
               if(this.ed_popupChar.direction % 2 == 0)
               {
                  this.turnChara(1);
               }
               this.ed_popupChar.animation = this.ANIMATION_WEAPON;
               this.ed_popupChar.addEndAnimationListener(this.onAnimationEnd);
               break;
            case this.btn_buy:
               this.sysApi.dispatchHook(ExternalGameHookList.DofusShopIndirectBuyClick,this._params.article.article,true);
               this.uiApi.loadUi("shopPopupConfirmBuy","shopPopupConfirmBuy",this._params,StrataEnum.STRATA_TOP,null,true);
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_buyOverlay:
               this.sysApi.dispatchHook(ExternalGameHookList.DofusShopIndirectBuyClick,this._params.article.article,false);
               this.sysApi.sendAction(new ShopOverlayBuyRequestAction([this._params.article.article.id]));
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_getForFree:
               this.sysApi.dispatchHook(ExternalGameHookList.DofusShopCurrentArticle,this._params.article);
               this.sysApi.sendAction(new ShopBuyRequestAction([this._params.article.article.id,1,DofusShopEnum.CURRENCY_OGRINES,0]));
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_seeMore:
               this.ctr_pack.visible = true;
               break;
            case this.btn_closePack:
               this.ctr_pack.visible = false;
         }
      }
      
      private function onAnimationEnd(e:Event) : void
      {
         this.ed_popupChar.removeEndAnimationListener(this.onAnimationEnd);
         this.ed_popupChar.animation = this.ANIMATION_STATIQUE;
      }
      
      public function onItemRollOver(target:Grid, item:GridItem) : void
      {
         if(item && item.data is ItemWrapper)
         {
            this.uiApi.showTooltip(item.data,item.container,false,"standard",LocationEnum.POINT_BOTTOMLEFT,LocationEnum.POINT_BOTTOMRIGHT,3,null,null,{
               "showEffects":true,
               "header":true
            });
         }
      }
      
      public function onItemRollOut(target:Grid, item:GridItem) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onItemRightClick(target:Grid, item:GridItem) : void
      {
         if(item.data)
         {
            this.modContextMenu.createContextMenu(this.menuApi.create(item.data,"item"));
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         if(s == "closeUi")
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return true;
         }
         return false;
      }
   }
}
