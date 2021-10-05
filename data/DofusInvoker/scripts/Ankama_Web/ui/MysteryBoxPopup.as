package Ankama_Web.ui
{
   import Ankama_Web.enum.MysteryBoxRarityEnum;
   import com.ankama.haapi.client.model.KardKardProba;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.ConsumeMultipleKardAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.OpenWebServiceAction;
   import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
   import com.ankamagames.dofus.types.enums.DofusShopEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import flash.events.Event;
   
   public class MysteryBoxPopup
   {
      
      private static const STATE_MAIN:int = 0;
      
      private static const STATE_WAITOPEN:int = 1;
      
      private static const STATE_ANIMATION:int = 2;
      
      private static const STATE_RESULT:int = 3;
      
      private static const STATE_NOMORE:int = 4;
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      private var _mbToOpen:Object;
      
      private var openingMBId:uint;
      
      private var _mbStockIds:Array;
      
      private var _isJackpot:Boolean = false;
      
      private var _hasRarity:Boolean = false;
      
      private var _currentState:int;
      
      private var _dateAnimStartStats:int;
      
      private var _dateAnimEndStats:int;
      
      private var _isAnimSkipped:Boolean = false;
      
      public var lbl_title:Label;
      
      public var lbl_rarity:Label;
      
      public var lbl_skipAnim:Label;
      
      public var lbl_noMoreLeft:Label;
      
      public var lbl_rewardsInfos:Label;
      
      public var lbl_receivedItem:Label;
      
      public var lbl_receiveReward:Label;
      
      public var lbl_congratulation:Label;
      
      public var lbl_noMoreLeftName:Label;
      
      public var lbl_remainingMysteryBox:Label;
      
      public var tx_jackpot:Texture;
      
      public var tx_receivedItem:Texture;
      
      public var btn_close:ButtonContainer;
      
      public var btn_goToShop:ButtonContainer;
      
      public var btn_openMysteryBox:ButtonContainer;
      
      public var ed_mbAnim:EntityDisplayer;
      
      public function MysteryBoxPopup()
      {
         super();
      }
      
      public function main(params:Object = null) : void
      {
         this._currentState = STATE_MAIN;
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addComponentHook(this.btn_close,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.lbl_skipAnim,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ed_mbAnim,ComponentHookList.ON_RELEASE);
         this.sysApi.addHook(ExternalGameHookList.CodesAndGiftConsumeMultipleKardSuccess,this.onConsumeMB);
         this._mbToOpen = params.data.item;
         this._mbStockIds = params.data.ids;
         this.lbl_title.text = this._mbToOpen.name;
         this.lbl_rewardsInfos.text = this.uiApi.getText("ui.codesAndGift.mb.rewardDesc",this.uiApi.getText("ui.codesAndGift.tabTitle"));
         this.lbl_skipAnim.fullWidthAndHeight(0,15);
         this.ed_mbAnim.visible = true;
         this.ed_mbAnim.animation = MysteryBoxAnimEnum.ANIM_START;
         this.displayMainContent();
      }
      
      public function unload() : void
      {
         this.ed_mbAnim.removeShotAnimationListener(this.onAnimationShot);
         this.ed_mbAnim.removeEndAnimationListener(this.onAnimationEnd);
      }
      
      private function openMysteryBox() : void
      {
         this._currentState = STATE_WAITOPEN;
         this.uiApi.removeComponentHook(this.ed_mbAnim,ComponentHookList.ON_RELEASE);
         this.openingMBId = this._mbStockIds.shift();
         this.sysApi.sendAction(new ConsumeMultipleKardAction([this.openingMBId]));
         this.displayMainContent(false);
         this.displayResultContent(false);
      }
      
      private function displayMainContent(display:Boolean = true) : void
      {
         if(this._mbStockIds.length > 0)
         {
            this.lbl_remainingMysteryBox.text = this.uiApi.getText("ui.codesAndGift.mb.remaining",this._mbStockIds.length,this._mbToOpen.name);
         }
         this.lbl_remainingMysteryBox.visible = this._mbStockIds.length > 0 && display;
         this.btn_openMysteryBox.visible = this._mbStockIds.length > 0 && display;
         this.lbl_noMoreLeft.visible = this._mbStockIds.length <= 0 && display;
         this.lbl_noMoreLeftName.visible = this._mbStockIds.length <= 0 && display;
         if(this._mbToOpen)
         {
            this.lbl_noMoreLeftName.text = this._mbToOpen.name;
         }
         this.btn_goToShop.visible = this._mbStockIds.length <= 0 && display;
         if(this._mbStockIds.length <= 0)
         {
            this._currentState = STATE_NOMORE;
         }
      }
      
      private function displayResultContent(display:Boolean = true) : void
      {
         if(display)
         {
            this._currentState = STATE_RESULT;
            this.displayMainContent();
         }
         this.lbl_congratulation.visible = display;
         this.lbl_receiveReward.visible = display;
         this.lbl_receivedItem.visible = display;
         this.tx_receivedItem.visible = display && !this._isJackpot;
         this.tx_jackpot.visible = display && this._isJackpot;
         this.lbl_rarity.visible = display && this._hasRarity;
         this.lbl_rewardsInfos.visible = display;
         this.lbl_rewardsInfos.fullWidthAndHeight(375);
         this.lbl_skipAnim.visible = false;
      }
      
      private function playAnimation(anim:String) : void
      {
         this._currentState = STATE_ANIMATION;
         this._dateAnimStartStats = this.timeApi.getTimestamp();
         this.ed_mbAnim.animation = anim;
         this.ed_mbAnim.visible = true;
         this.ed_mbAnim.addEndAnimationListener(this.onAnimationEnd);
         this.ed_mbAnim.addShotAnimationListener(this.onAnimationShot);
         this.lbl_skipAnim.visible = true;
      }
      
      private function getRarity(mysteryBoxKards:Vector.<KardKardProba>, resultId:uint) : Object
      {
         var kard:KardKardProba = null;
         for each(kard in mysteryBoxKards)
         {
            if(kard.kard.id == resultId)
            {
               return this.rarityFromString(kard.rarity);
            }
         }
         return {};
      }
      
      private function rarityFromString(rarityStr:String) : Object
      {
         this._hasRarity = rarityStr != MysteryBoxRarityEnum.NO_RARITY;
         switch(rarityStr)
         {
            case MysteryBoxRarityEnum.COMMON:
               return {
                  "text":this.uiApi.getText("ui.codesAndGift.mb.rarityCommon"),
                  "color":MysteryBoxRarityEnum.COMMON_COLOR,
                  "anim":MysteryBoxAnimEnum.ANIM_COMMON
               };
            case MysteryBoxRarityEnum.UNCOMMON:
               return {
                  "text":this.uiApi.getText("ui.codesAndGift.mb.rarityUncommon"),
                  "color":MysteryBoxRarityEnum.UNCOMMON_COLOR,
                  "anim":MysteryBoxAnimEnum.ANIM_UNCOMMON
               };
            case MysteryBoxRarityEnum.RARE:
               return {
                  "text":this.uiApi.getText("ui.codesAndGift.mb.rarityRare"),
                  "color":MysteryBoxRarityEnum.RARE_COLOR,
                  "anim":MysteryBoxAnimEnum.ANIM_RARE
               };
            case MysteryBoxRarityEnum.EPIC:
               return {
                  "text":this.uiApi.getText("ui.codesAndGift.mb.rarityEpic"),
                  "color":MysteryBoxRarityEnum.EPIC_COLOR,
                  "anim":MysteryBoxAnimEnum.ANIM_EPIC
               };
            case MysteryBoxRarityEnum.LEGENDARY:
               return {
                  "text":this.uiApi.getText("ui.codesAndGift.mb.rarityLegendary"),
                  "color":MysteryBoxRarityEnum.LEGENDARY_COLOR,
                  "anim":MysteryBoxAnimEnum.ANIM_LEGENDARY
               };
            default:
               return {
                  "text":this.uiApi.getText("ui.codesAndGift.mb.rarityCommon"),
                  "color":MysteryBoxRarityEnum.COMMON_COLOR,
                  "anim":MysteryBoxAnimEnum.ANIM_COMMON
               };
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_openMysteryBox:
            case this.ed_mbAnim:
               this.openMysteryBox();
               break;
            case this.lbl_skipAnim:
               this._isAnimSkipped = true;
               this.onAnimComplete();
               break;
            case this.btn_goToShop:
               this.sysApi.sendAction(new OpenWebServiceAction(["webShop",[DofusShopEnum.MYSTERY_CATEGORY_ID]]));
               this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      public function onShortcut(shortcut:String) : Boolean
      {
         if(shortcut == "closeUi")
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return true;
         }
         if(shortcut == "validUi")
         {
            switch(this._currentState)
            {
               case STATE_WAITOPEN:
                  return true;
               case STATE_MAIN:
                  this.onRelease(this.btn_openMysteryBox);
                  return true;
               case STATE_ANIMATION:
                  this.onRelease(this.lbl_skipAnim);
                  return true;
               case STATE_RESULT:
                  if(!this.btn_openMysteryBox.softDisabled)
                  {
                     this.onRelease(this.btn_openMysteryBox);
                  }
                  return true;
               case STATE_NOMORE:
                  this.onRelease(this.btn_goToShop);
                  return true;
            }
         }
         return false;
      }
      
      public function onAnimComplete(displayContent:Boolean = true) : void
      {
         this._dateAnimEndStats = this.timeApi.getTimestamp();
         this.ed_mbAnim.removeEndAnimationListener(this.onAnimationEnd);
         this.ed_mbAnim.removeShotAnimationListener(this.onAnimationShot);
         this.ed_mbAnim.animation = MysteryBoxAnimEnum.ANIM_START;
         this.ed_mbAnim.stopAllMovieClips();
         if(displayContent)
         {
            this.displayResultContent();
         }
         this.ed_mbAnim.visible = false;
         this.sysApi.dispatchHook(ExternalGameHookList.CodesAndGiftOpenBoxStats,this._mbToOpen.id,this._mbStockIds.length,this._dateAnimEndStats - this._dateAnimStartStats,this._isAnimSkipped);
      }
      
      private function onConsumeMB(result:Array) : void
      {
         if(this._mbStockIds.length == 0)
         {
            this.sysApi.dispatchHook(ExternalGameHookList.CodesAndGiftNoMoreMysteryBox,this._mbToOpen.id);
         }
         var resObject:Object = this.getResult(result);
         this.tx_receivedItem.uri = this.uiApi.createUri(resObject.image);
         this.lbl_receivedItem.text = resObject.name;
         var rarity:Object = this.getRarity(this._mbToOpen.kards,resObject.id);
         this.lbl_rarity.text = rarity.text;
         this.lbl_rarity.fullWidthAndHeight();
         this.lbl_rarity.x = this.tx_receivedItem.x + (this.tx_receivedItem.width - this.lbl_rarity.width) / 2;
         this.lbl_rarity.graphics.clear();
         this.lbl_rarity.graphics.beginFill(rarity.color);
         this.lbl_rarity.graphics.drawRect(-10,-5,this.lbl_rarity.width + 20,this.lbl_rarity.height + 10);
         this.lbl_rarity.graphics.endFill();
         this.playAnimation(rarity.anim);
      }
      
      private function getResult(result:Array) : Object
      {
         var resultElement:Object = null;
         for each(resultElement in result)
         {
            if(resultElement.type == "SIMPLE")
            {
               return resultElement;
            }
         }
         return null;
      }
      
      public function onAnimationEnd(e:Event) : void
      {
         this._isAnimSkipped = false;
         this.ed_mbAnim.removeEndAnimationListener(this.onAnimationEnd);
         this.onAnimComplete(false);
         this.btn_openMysteryBox.softDisabled = false;
         this.btn_openMysteryBox.handCursor = !this.btn_openMysteryBox.softDisabled;
      }
      
      public function onAnimationShot(e:Event) : void
      {
         this.ed_mbAnim.removeShotAnimationListener(this.onAnimationShot);
         this.displayResultContent();
         this.btn_openMysteryBox.softDisabled = true;
         this.btn_openMysteryBox.handCursor = !this.btn_openMysteryBox.softDisabled;
      }
   }
}

class MysteryBoxAnimEnum
{
   
   public static const ANIM_START:String = "AnimStatique";
   
   public static const ANIM_COMMON:String = "AnimAttaque0";
   
   public static const ANIM_UNCOMMON:String = "AnimAttaque1";
   
   public static const ANIM_RARE:String = "AnimAttaque2";
   
   public static const ANIM_EPIC:String = "AnimAttaque3";
   
   public static const ANIM_LEGENDARY:String = "AnimAttaque4";
    
   
   function MysteryBoxAnimEnum()
   {
      super();
   }
}
