package Ankama_GameUiCore.ui
{
   import Ankama_Common.Common;
   import Ankama_GameUiCore.ui.enums.ContextEnum;
   import Ankama_Grimoire.enum.EnumTab;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.gridRenderer.SlotGridRenderer;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.arena.ArenaRankInfosWrapper;
   import com.ankamagames.dofus.internalDatacenter.userInterface.ButtonWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.CloseInventoryAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenArenaAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenBookAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenForgettableSpellsUiAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenGuidebookAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenIdolsAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenInventoryAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenMapAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenMountAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenSocialAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenStatsAction;
   import com.ankamagames.dofus.logic.game.common.actions.breach.BreachTeleportRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.externalGame.OpenWebServiceAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeRequestOnShopStockAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.ExchangeRequestOnMountStockAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountToggleRidingRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagEnterAction;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.MountHookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.AlignmentSideEnum;
   import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
   import com.ankamagames.dofus.uiApi.BindsApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.HighlightApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.PopupApi;
   import com.ankamagames.dofus.uiApi.RoleplayApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.ui.Keyboard;
   import flash.utils.getTimer;
   
   public class BannerMenu extends ContextAwareUi
   {
      
      private static const STORAGE_NEW_TEMPORIS_REWARD:String = "storageNewTemporisReward";
      
      private static var _shortcutColor:String;
      
      private static const SHORTCUT_DISABLE_DURATION:Number = 500;
       
      
      public const ID_BTN_CARAC:int = 1;
      
      public const ID_BTN_SPELL:int = 2;
      
      public const ID_BTN_BAG:int = 3;
      
      public const ID_BTN_BOOK:int = 4;
      
      public const ID_BTN_MAP:int = 5;
      
      public const ID_BTN_SOCIAL:int = 6;
      
      public const ID_BTN_KOLIZEUM:int = 7;
      
      public const ID_BTN_OGRINE:int = 8;
      
      public const ID_BTN_JOB:int = 9;
      
      public const ID_BTN_MOUNT:int = 10;
      
      public const ID_BTN_SHOP:int = 11;
      
      public const ID_BTN_ACHIEVEMENT:int = 12;
      
      public const ID_BTN_IDOLS:int = 13;
      
      public const ID_BTN_HAVENBAG:int = 14;
      
      public const ID_BTN_ENCYCLOPEDIA:int = 15;
      
      public const ID_BTN_BREACH:int = 16;
      
      public const ID_BTN_BUILDS:int = 17;
      
      public const ID_BTN_GUIDEBOOK:int = 18;
      
      public const ID_BTN_SPOUSE:int = 19;
      
      public const ID_BTN_COMPANION:int = 20;
      
      public const ID_BTN_MORE:int = 2147483647;
      
      private var _maxBtnIds:uint;
      
      private var _serverType:int;
      
      private var _forgettableSpellsActivated:Boolean = false;
      
      private var _companionsActivated:Boolean = false;
      
      private var _temporisAchievementProgressActivated:Boolean = false;
      
      private var _btnSaveKey:String = "uiBtnOrder2";
      
      private var _loading:Boolean = true;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="BindsApi")]
      public var bindsApi:BindsApi;
      
      [Api(name="HighlightApi")]
      public var highlightApi:HighlightApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="RoleplayApi")]
      public var rpApi:RoleplayApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="PopupApi")]
      public var popupApi:PopupApi;
      
      public var mainCtr:GraphicContainer;
      
      public var gd_btnUis:Grid;
      
      public var ctr_moreBtn:GraphicContainer;
      
      public var gd_additionalBtns:Grid;
      
      public var btn_more_slot:Slot;
      
      private var _dataProviderButtons:Array;
      
      private var _btnPositionById:Array;
      
      private var _uiBtnHeight:int;
      
      private var _uiBtnOffset:int;
      
      private var _openAdditionalBtns:Boolean;
      
      private var _secureMode:Boolean = false;
      
      private var _bArenaRegistered:Boolean;
      
      private var _btn_more:ButtonWrapper;
      
      private var _isDragging:Boolean = false;
      
      private var _shortcutTimerDuration:Number = 0;
      
      private var _havenbagPopupId:String;
      
      private var _onBreachMap:Boolean;
      
      private var _big:Boolean = false;
      
      private var _allowDrag:Boolean;
      
      public function BannerMenu()
      {
         super();
      }
      
      override public function main(args:Array) : void
      {
         var breachTitleText:* = null;
         var breachText:String = null;
         var slot:Slot = null;
         var i:int = 0;
         var j:int = 0;
         var unusedIds:Array = null;
         this._forgettableSpellsActivated = this.configApi.isFeatureWithKeywordEnabled("character.spell.forgettable");
         this._companionsActivated = this.configApi.isFeatureWithKeywordEnabled("companion.hudButtonAndShortcut");
         this._temporisAchievementProgressActivated = this.configApi.isFeatureWithKeywordEnabled("temporis.achievementProgress");
         this._maxBtnIds = !!this._companionsActivated ? uint(21) : uint(20);
         this._serverType = sysApi.getCurrentServer().gameTypeId;
         if(this._forgettableSpellsActivated)
         {
            this._btnSaveKey = "uiBtnOrder2_forgettableSpells";
         }
         super.main(args);
         sysApi.addHook(HookList.DisplayUiArrow,this.onDisplayUiArrow);
         sysApi.addHook(RoleplayHookList.ArenaUpdateRank,this.onArenaUpdateRank);
         sysApi.addHook(BeriliaHookList.MouseClick,this.onGenericMouseClick);
         sysApi.addHook(RoleplayHookList.ArenaRegistrationStatusUpdate,this.onArenaRegistrationStatusUpdate);
         sysApi.addHook(HookList.SecureModeChange,this.onSecureModeChange);
         sysApi.addHook(MountHookList.MountSet,this.onMountSet);
         sysApi.addHook(MountHookList.MountUnSet,this.onMountUnSet);
         sysApi.addHook(SocialHookList.SpouseUpdated,this.onSpouseUpdated);
         sysApi.addHook(HookList.ConfigPropertyChange,this.onConfigChange);
         sysApi.addHook(HookList.BreachTeleport,this.onBreachTeleport);
         sysApi.addHook(BeriliaHookList.KeyUp,this.onKeyUp);
         sysApi.addHook(BeriliaHookList.KeyDown,this.onKeyDown);
         sysApi.addHook(BeriliaHookList.LoadingFinished,this.onLoadingFinished);
         this.configApi.addListenerToFeatureWithKeyword("pvp.kis",this.onPVPFeatureActivationUpdate);
         if(this.playerApi.getPlayedCharacterInfo().level < ProtocolConstantsEnum.MAX_LEVEL)
         {
            sysApi.addHook(BeriliaHookList.UiUnloaded,this.onUiUnloaded);
         }
         if(this.playerApi.getPlayedCharacterInfo().level < ProtocolConstantsEnum.CHAR_MIN_LEVEL_RIDE)
         {
            sysApi.addHook(HookList.CharacterLevelUp,this.onCharacterLevelUp);
         }
         this.uiApi.addComponentHook(this.gd_additionalBtns,"onSelectItem");
         this.uiApi.addComponentHook(this.gd_additionalBtns,"onItemRollOver");
         this.uiApi.addComponentHook(this.gd_additionalBtns,"onItemRollOut");
         this.uiApi.addComponentHook(this.gd_btnUis,"onSelectItem");
         this.uiApi.addComponentHook(this.gd_btnUis,"onItemRollOver");
         this.uiApi.addComponentHook(this.gd_btnUis,"onItemRollOut");
         this._big = sysApi.getOption("bigMenuButton","dofus");
         this._uiBtnHeight = this.uiApi.me().getConstant("ui_btn_height");
         if(this._big)
         {
            this.gd_btnUis.slotHeight = this._uiBtnHeight * 1.5;
            this.gd_btnUis.slotWidth = this._uiBtnHeight * 1.5;
            this.updateUiMinimalSize();
         }
         this._uiBtnOffset = this.uiApi.me().getConstant("ui_btn_offset");
         this._dataProviderButtons = [];
         this._btnPositionById = sysApi.getData(this._btnSaveKey);
         if(this._btnPositionById == null)
         {
            this._btnPositionById = [];
         }
         if(this._btnPositionById.length > this._maxBtnIds)
         {
            i = 0;
            j = 0;
            for(unusedIds = []; i < this._btnPositionById.length; )
            {
               if(this._btnPositionById[i] && i >= this._maxBtnIds)
               {
                  unusedIds.push(this._btnPositionById[i]);
               }
               i++;
            }
            this._btnPositionById.length = this._maxBtnIds;
            i = 0;
            for(unusedIds.sort(Array.NUMERIC); i < this._btnPositionById.length; )
            {
               for(j = unusedIds.length - 1; j > 0; )
               {
                  if(this._btnPositionById[i] && this._btnPositionById[i] > unusedIds[j])
                  {
                     this._btnPositionById[i] -= j + 1;
                     break;
                  }
                  j--;
               }
               i++;
            }
         }
         this.gd_btnUis.autoSelectMode = 0;
         this.gd_additionalBtns.autoSelectMode = 0;
         if(this._serverType == GameServerTypeEnum.SERVER_TYPE_HARDCORE)
         {
            breachTitleText = this.uiApi.getText("ui.breach.title") + " (" + this.uiApi.getText("ui.alert.info.aggressionZone") + ")";
         }
         else
         {
            breachTitleText = this.uiApi.getText("ui.breach.title");
         }
         if(this.playerApi.getPlayedCharacterInfo().level >= ProtocolConstantsEnum.MIN_LEVEL_BREACH)
         {
            if(sysApi.getPlayerManager().subscriptionEndDate <= 0)
            {
               breachText = this.uiApi.getText("ui.payzone.limit");
            }
            else
            {
               breachText = this.uiApi.getText("ui.breach.alreadyInBreach");
            }
         }
         else
         {
            breachText = this.uiApi.getText("ui.banner.lockBtn.lvl",ProtocolConstantsEnum.MIN_LEVEL_BREACH);
         }
         if(this._companionsActivated)
         {
            this.addBannerButton(this.ID_BTN_COMPANION,"btn_companions",this.onCompanionAction,this.uiApi.getText("ui.companion.companions"),"openCompanions");
         }
         this.addBannerButton(this.ID_BTN_CARAC,"btn_carac",this.onCharacterAction,this.uiApi.getText("ui.banner.character"),"openCharacterSheet");
         this.addBannerButton(this.ID_BTN_SPELL,"btn_spell",this.onSpellsAction,this.uiApi.getText("ui.grimoire.mySpell"),"openBookSpell");
         this.addBannerButton(this.ID_BTN_BAG,"btn_bag",this.onItemsAction,this.uiApi.getText("ui.banner.inventory"),"openInventory");
         this.addBannerButton(this.ID_BTN_BOOK,"btn_book",this.onQuestsAction,this.uiApi.getText("ui.common.quests"),"openBookQuest");
         this.addBannerButton(this.ID_BTN_MAP,"btn_map",this.onMapAction,this.uiApi.getText("ui.banner.map"),"openWorldMap");
         this.addBannerButton(this.ID_BTN_SOCIAL,"btn_friend",this.onSocialAction,this.uiApi.getText("ui.banner.social"),"openSocial");
         this.addBannerButton(this.ID_BTN_ACHIEVEMENT,"btn_achievement",this.onAchievementAction,this.uiApi.getText("ui.achievement.achievement"),"openAchievement");
         this.addBannerButton(this.ID_BTN_OGRINE,"btn_veteran",this.onWebAction,this.uiApi.getText("ui.banner.shopGifts"),"openWebBrowser",this.uiApi.getText("ui.banner.lockBtn.secureMode"));
         this.addBannerButton(this.ID_BTN_ENCYCLOPEDIA,"btn_encyclopedia",this.onBestiaryAction,this.uiApi.getText("ui.encyclopedia.title"),"openBestiary");
         this.addBannerButton(this.ID_BTN_JOB,"btn_job",this.onJobAction,this.uiApi.getText("ui.common.myJobs"),"openBookJob");
         this.addBannerButton(this.ID_BTN_GUIDEBOOK,"btn_progression",this.onGuidebookAction,!!this._temporisAchievementProgressActivated ? this.uiApi.getText("ui.temporis.titleGuidebook") : this.uiApi.getText("ui.guidebook.title"),"openGuidebook");
         if(this._temporisAchievementProgressActivated)
         {
            sysApi.addHook(HookList.AreTemporisRewardsAvailable,this.onNewTemporisRewardsAvailable);
         }
         this.addBannerButton(this.ID_BTN_SHOP,"btn_shop",this.onShopAction,this.uiApi.getText("ui.common.shop"),"openSell");
         this.addBannerButton(this.ID_BTN_IDOLS,"btn_idols",this.onIdolsAction,this.uiApi.getText("ui.idol.idols"),"openIdols");
         this.addBannerButton(this.ID_BTN_BUILDS,"btn_stuff",this.onBuildsAction,this.uiApi.getText("ui.build.builds"),"openBuild");
         if(this.playerApi.getPlayedCharacterInfo().level >= ProtocolConstantsEnum.MIN_LEVEL_HAVENBAG)
         {
            this.addBannerButton(this.ID_BTN_HAVENBAG,"btn_havenbag",this.onHavenBagAction,this.uiApi.getText("ui.havenbag.havenbag"),"openHavenbag",this.uiApi.getText("ui.banner.lockBtn.lvl",ProtocolConstantsEnum.MIN_LEVEL_HAVENBAG));
         }
         if(this.playerApi.getPlayedCharacterInfo().level >= ProtocolConstantsEnum.CHAR_MIN_LEVEL_ARENA)
         {
            this.addBannerButton(this.ID_BTN_KOLIZEUM,"btn_conquest",this.onKolizeumAction,this.uiApi.getText("ui.common.koliseum"),"openPvpArena",this.uiApi.getText("ui.banner.lockBtn.lvl",ProtocolConstantsEnum.CHAR_MIN_LEVEL_ARENA));
         }
         if(this.playerApi.getPlayedCharacterInfo().level >= ProtocolConstantsEnum.MIN_LEVEL_BREACH)
         {
            this.addBannerButton(this.ID_BTN_BREACH,"btn_breach",this.onBreachAction,breachTitleText,"openBreach",breachText);
         }
         var addMountButton:Boolean = sysApi.getData("addMountButton_" + this.playerApi.getPlayedCharacterInfo().id,DataStoreEnum.BIND_CHARACTER);
         if(this.playerApi.getPlayedCharacterInfo().level >= ProtocolConstantsEnum.CHAR_MIN_LEVEL_RIDE || addMountButton)
         {
            this.addBannerButton(this.ID_BTN_MOUNT,"btn_mount",this.onMountAction,this.uiApi.getText("ui.banner.mount"),"openMount",this.uiApi.getText("ui.banner.lockBtn.mount"));
         }
         if(this.socialApi.hasSpouse())
         {
            this.addBannerButton(this.ID_BTN_SPOUSE,"btn_spouse",this.onSpouseAction,this.uiApi.processText(this.uiApi.getText("ui.common.spouse"),"m",true),"openSocialSpouse",this.uiApi.getText("ui.banner.lockBtn.wed"));
         }
         this._btn_more = this.dataApi.getButtonWrapper(this.ID_BTN_MORE,int.MAX_VALUE,"btn_bannerBtnsPlus",this.toggleAllButtonsVisibility,this.uiApi.getText("ui.common.moreButtons"));
         this.checkAllBtnActivationState(true);
         this.updateButtonGrids();
         var objAccept:Uri = this.uiApi.createUri(this.uiApi.me().getConstant("acceptDrop_uri"));
         var objRefuse:Uri = this.uiApi.createUri(this.uiApi.me().getConstant("refuseDrop_uri"));
         (this.gd_btnUis.renderer as SlotGridRenderer).dropValidatorFunction = this.dropValidatorBtn;
         (this.gd_btnUis.renderer as SlotGridRenderer).processDropFunction = this.processDropBtn;
         (this.gd_btnUis.renderer as SlotGridRenderer).removeDropSourceFunction = this.emptyFct;
         (this.gd_btnUis.renderer as SlotGridRenderer).acceptDragTexture = objAccept;
         (this.gd_btnUis.renderer as SlotGridRenderer).refuseDragTexture = objRefuse;
         (this.gd_additionalBtns.renderer as SlotGridRenderer).dropValidatorFunction = this.dropValidatorBtn;
         (this.gd_additionalBtns.renderer as SlotGridRenderer).processDropFunction = this.processDropBtn;
         (this.gd_additionalBtns.renderer as SlotGridRenderer).removeDropSourceFunction = this.emptyFct;
         (this.gd_additionalBtns.renderer as SlotGridRenderer).acceptDragTexture = objAccept;
         (this.gd_additionalBtns.renderer as SlotGridRenderer).refuseDragTexture = objRefuse;
         for each(slot in this.gd_btnUis.slots)
         {
            slot.allowDrag = false;
         }
      }
      
      private function onLoadingFinished() : void
      {
         var temporisQuestTabSlot:Slot = null;
         var rawAreNewTemporisRewardsAvailable:* = undefined;
         sysApi.log(4,"finished loading, binding shortcuts");
         this.uiApi.addShortcutHook("openCharacterSheet",this.onShortcut);
         this.uiApi.addShortcutHook("openInventory",this.onShortcut);
         this.uiApi.addShortcutHook("openBookSpell",this.onShortcut);
         this.uiApi.addShortcutHook("openBookQuest",this.onShortcut);
         this.uiApi.addShortcutHook("openBookAlignment",this.onShortcut);
         this.uiApi.addShortcutHook("openBookJob",this.onShortcut);
         this.uiApi.addShortcutHook("openWorldMap",this.onShortcut);
         this.uiApi.addShortcutHook("openSocialFriends",this.onShortcut);
         this.uiApi.addShortcutHook("openSocialGuild",this.onShortcut);
         this.uiApi.addShortcutHook("openSocialAlliance",this.onShortcut);
         this.uiApi.addShortcutHook("openSocialSpouse",this.onShortcut);
         this.uiApi.addShortcutHook("openPvpArena",this.onShortcut);
         this.uiApi.addShortcutHook("openSell",this.onShortcut);
         this.uiApi.addShortcutHook("openMount",this.onShortcut);
         this.uiApi.addShortcutHook("openAlmanax",this.onShortcut);
         this.uiApi.addShortcutHook("openAchievement",this.onShortcut);
         this.uiApi.addShortcutHook("openTitle",this.onShortcut);
         this.uiApi.addShortcutHook("openBestiary",this.onShortcut);
         this.uiApi.addShortcutHook("openMountStorage",this.onShortcut);
         this.uiApi.addShortcutHook("openHavenbag",this.onShortcut);
         this.uiApi.addShortcutHook("openWebBrowser",this.onShortcut);
         this.uiApi.addShortcutHook("openBuild",this.onShortcut);
         this.uiApi.addShortcutHook("openBreach",this.onShortcut);
         this.uiApi.addShortcutHook("openGuidebook",this.onShortcut);
         this.uiApi.addShortcutHook("openCompanions",this.onShortcut);
         if(this._temporisAchievementProgressActivated)
         {
            temporisQuestTabSlot = this.getSlotByBtnId(this.ID_BTN_GUIDEBOOK);
            if(temporisQuestTabSlot !== null)
            {
               rawAreNewTemporisRewardsAvailable = sysApi.getData(STORAGE_NEW_TEMPORIS_REWARD);
               if(rawAreNewTemporisRewardsAvailable is Boolean)
               {
                  temporisQuestTabSlot.selected = rawAreNewTemporisRewardsAvailable as Boolean;
               }
               else
               {
                  temporisQuestTabSlot.selected = false;
               }
            }
         }
         this.uiApi.addShortcutHook(ShortcutHookListEnum.OPEN_IDOLS,this.onShortcut);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.TOGGLE_RIDE,this.onShortcut);
         this._loading = false;
      }
      
      public function unload() : void
      {
         this.configApi.removeListenerFromFeatureWithKeyword("pvp.kis",this.onPVPFeatureActivationUpdate);
      }
      
      public function renderUpdate() : void
      {
         this.updateButtonGrids();
         if(currentContext != ContextEnum.ROLEPLAY && this.mainCtr.x != parseInt(this.uiApi.me().getConstant("defaultFightX")))
         {
            this.onContextChanged(currentContext);
         }
      }
      
      private function updateUiMinimalSize() : void
      {
         var minSize:Point = this.calculateUiMinimalSize();
         var maxSize:Point = new Point();
         if(this.mainCtr.maxSize && this.mainCtr.maxSize.xUnit > 0)
         {
            maxSize.x = this.mainCtr.maxSize.xUnit;
            maxSize.y = this.mainCtr.maxSize.yUnit;
         }
         else
         {
            maxSize.x = 1280;
            maxSize.y = 1024;
         }
         this.uiApi.setComponentMinMaxSize(this.mainCtr,minSize,maxSize);
      }
      
      private function calculateUiMinimalSize() : Point
      {
         var minSize:Point = new Point();
         minSize.x = this.gd_btnUis.slotWidth + this.gd_btnUis.x * 2 + 4;
         minSize.y = this.gd_btnUis.slotHeight + this.gd_btnUis.y * 2;
         return minSize;
      }
      
      override protected function onContextChanged(context:String, previousContext:String = "", contextChanged:Boolean = false) : void
      {
         var bannerUi:* = undefined;
         switch(context)
         {
            case ContextEnum.SPECTATOR:
            case ContextEnum.PREFIGHT:
            case ContextEnum.FIGHT:
               if(!this.mainCtr.getSavedPosition() && !this.mainCtr.getSavedDimension())
               {
                  this.mainCtr.xNoCache = parseInt(this.uiApi.me().getConstant("defaultFightX"));
               }
               break;
            case ContextEnum.ROLEPLAY:
               bannerUi = this.uiApi.getUi("banner");
               if(bannerUi && bannerUi.uiClass && !bannerUi.uiClass.mainCtr.getSavedPosition() && !bannerUi.uiClass.mainCtr.getSavedDimension() && !this.mainCtr.getSavedPosition() && !this.mainCtr.getSavedDimension())
               {
                  this.mainCtr.xNoCache = parseInt(this.uiApi.me().getConstant("defaultRpX"));
               }
         }
      }
      
      public function toggleAllButtonsVisibility() : void
      {
         var slot:Slot = null;
         var relativeToComponent:* = undefined;
         var rect:* = undefined;
         var pos:* = undefined;
         if(this.ctr_moreBtn.visible)
         {
            this.ctr_moreBtn.visible = false;
            for each(slot in this.gd_btnUis.slots)
            {
               slot.allowDrag = false;
            }
         }
         else
         {
            this.ctr_moreBtn.visible = true;
            for each(slot in this.gd_btnUis.slots)
            {
               if(slot.data && slot.data.position == this.ID_BTN_MORE)
               {
                  relativeToComponent = slot;
               }
               else
               {
                  slot.allowDrag = true;
               }
            }
            rect = this.uiApi.getVisibleStageBounds();
            pos = this.mainCtr.localToGlobal(new Point(this.mainCtr.x,this.mainCtr.y));
            if(pos.x + this.mainCtr.width + 35 - rect.x > rect.width)
            {
               if(this.ctr_moreBtn.height < this.mainCtr.y)
               {
                  this.ctr_moreBtn.x = this.mainCtr.width - this.ctr_moreBtn.width;
                  this.ctr_moreBtn.y = -this.ctr_moreBtn.height;
               }
               else
               {
                  this.ctr_moreBtn.x = -this.ctr_moreBtn.width;
                  this.ctr_moreBtn.y = Math.max(-this.ctr_moreBtn.height + this.mainCtr.height,-this.mainCtr.y);
               }
            }
            else
            {
               this.ctr_moreBtn.x = this.mainCtr.width - 6;
               this.ctr_moreBtn.y = Math.max(-this.ctr_moreBtn.height + this.mainCtr.height,-this.mainCtr.y);
            }
         }
      }
      
      private function onKeyUp(target:DisplayObject, keyCode:uint) : void
      {
         var slot:* = undefined;
         if(keyCode != Keyboard.CONTROL || this.ctr_moreBtn.visible || !this._allowDrag)
         {
            return;
         }
         this._allowDrag = false;
         for each(slot in this.gd_btnUis.slots)
         {
            slot.allowDrag = false;
         }
      }
      
      private function onKeyDown(target:DisplayObject, keyCode:uint) : void
      {
         var slot:Slot = null;
         if(keyCode != Keyboard.CONTROL)
         {
            return;
         }
         if(this.ctr_moreBtn.visible || this._allowDrag)
         {
            return;
         }
         this._allowDrag = true;
         for each(slot in this.gd_btnUis.slots)
         {
            if(!(slot.data && slot.data.position == this.ID_BTN_MORE))
            {
               slot.allowDrag = true;
            }
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var selectedBtn:ButtonWrapper = null;
         switch(target)
         {
            case this.gd_additionalBtns:
            case this.gd_btnUis:
               if(selectMethod != SelectMethodEnum.AUTO)
               {
                  selectedBtn = (target as Grid).selectedItem as ButtonWrapper;
                  if(selectedBtn && selectedBtn.active)
                  {
                     selectedBtn.callback.call();
                  }
               }
         }
      }
      
      public function onItemRollOver(target:GraphicContainer, item:Object) : void
      {
         var text:String = null;
         var shortcut:String = null;
         if(!item.data)
         {
            return;
         }
         if(!_shortcutColor)
         {
            _shortcutColor = sysApi.getConfigEntry("colors.shortcut");
            _shortcutColor = _shortcutColor.replace("0x","#");
         }
         if(target == this.gd_btnUis || target == this.gd_additionalBtns)
         {
            text = item.data.name;
            shortcut = this.bindsApi.getShortcutBindStr(item.data.shortcutName);
            if(shortcut)
            {
               if(!_shortcutColor)
               {
                  _shortcutColor = sysApi.getConfigEntry("colors.shortcut");
                  _shortcutColor = _shortcutColor.replace("0x","#");
               }
               text += " <font color=\'" + _shortcutColor + "\'>(" + shortcut + ")</font>";
            }
            if(!item.data.active && item.data.description)
            {
               text += "\n<i>" + item.data.description + "</i>";
            }
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),item.container,false,"standard",LocationEnum.POINT_BOTTOMRIGHT,LocationEnum.POINT_TOPRIGHT,0,null,null,null,"TextInfo");
         }
      }
      
      public function onItemRollOut(target:GraphicContainer, item:Object) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onShortcut(s:String) : Boolean
      {
         var storageUi:UiRootContainer = null;
         switch(s)
         {
            case "openCharacterSheet":
               if(this.shortcutTimerReady())
               {
                  sysApi.sendAction(new OpenStatsAction([]));
               }
               return true;
            case "openInventory":
               if(this.shortcutTimerReady())
               {
                  this.openInventory();
               }
               return true;
            case "openBookSpell":
               this.onSpellsAction();
               return true;
            case "openBookAlignment":
               this.onAlignmentAction();
               return true;
            case "openBookJob":
               if(this.shortcutTimerReady())
               {
                  sysApi.sendAction(new OpenBookAction(["jobTab"]));
               }
               return true;
            case "openWorldMap":
               if(this.shortcutTimerReady())
               {
                  sysApi.sendAction(new OpenMapAction([false,true,false]));
               }
               return true;
            case "openTitle":
               this.onTitleAction();
               return true;
            case "openBestiary":
               if(this.shortcutTimerReady())
               {
                  sysApi.sendAction(new OpenBookAction(["bestiaryTab"]));
               }
               return true;
            case "openHavenbag":
               this.onHavenBagAction();
               return true;
            case "openWebBrowser":
               this.onWebAction();
               return true;
            case "openBookQuest":
               if(this.shortcutTimerReady())
               {
                  sysApi.sendAction(new OpenBookAction(["questTab"]));
               }
               return true;
            case "openAchievement":
               if(this.shortcutTimerReady())
               {
                  sysApi.sendAction(new OpenBookAction(["achievementTab"]));
               }
               return true;
            case "openAlmanax":
               this.onAlmanaxAction();
               return true;
            case "openSocialFriends":
               this.onFriendsAction();
               return true;
            case "openSocialGuild":
               this.onGuildAction();
               return true;
            case "openSocialAlliance":
               this.onAllianceAction();
               return true;
            case "openSocialSpouse":
               this.onSpouseAction();
               return true;
            case "openPvpArena":
               this.onKolizeumAction();
               return true;
            case "openSell":
               if(this.shortcutTimerReady())
               {
                  if(!this.uiApi.getUi("stockMyselfVendor"))
                  {
                     sysApi.sendAction(new ExchangeRequestOnShopStockAction([]));
                  }
                  else
                  {
                     this.uiApi.unloadUi("stockMyselfVendor");
                  }
               }
               return true;
            case "openMount":
               this.onMountAction();
               return true;
            case "openMountStorage":
               if(this.shortcutTimerReady() && this.playerApi.getMount())
               {
                  if(this.playerApi.isInFight())
                  {
                     sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.error.cantDoInFight"),666,this.timeApi.getTimestamp());
                  }
                  else
                  {
                     storageUi = this.uiApi.getUi(UIEnum.STORAGE_UI);
                     if(storageUi)
                     {
                        if(storageUi.uiClass.currentStorageBehavior.getName() == "mount")
                        {
                           sysApi.sendAction(new CloseInventoryAction([]));
                        }
                        else
                        {
                           sysApi.sendAction(new ExchangeRequestOnMountStockAction([]));
                        }
                     }
                     else
                     {
                        sysApi.sendAction(new ExchangeRequestOnMountStockAction([]));
                     }
                  }
               }
               return true;
            case "openBuild":
               sysApi.dispatchHook(HookList.OpenCharacterBuilds,-1);
               return true;
            case "openBreach":
               this.onBreachAction();
               return true;
            case ShortcutHookListEnum.TOGGLE_RIDE:
               if(this.shortcutTimerReady() && this.playerApi.getMount())
               {
                  sysApi.sendAction(new MountToggleRidingRequestAction([true]));
               }
               return true;
            case ShortcutHookListEnum.OPEN_IDOLS:
               if(this.shortcutTimerReady())
               {
                  if(!this.uiApi.getUi("idolsTab"))
                  {
                     sysApi.sendAction(new OpenIdolsAction([]));
                  }
                  else
                  {
                     sysApi.sendAction(new OpenBookAction(["idolsTab"]));
                  }
               }
               return true;
            case ShortcutHookListEnum.OPEN_GUIDEBOOK:
               this.onGuidebookAction();
               return true;
            case ShortcutHookListEnum.OPEN_COMPANIONS:
               this.onCompanionAction();
               return true;
            default:
               return false;
         }
      }
      
      private function updateButtonGrids() : void
      {
         var slot:Slot = null;
         var remainingButtons:Array = null;
         var remainingButtonsLength:int = 0;
         var buttonsHeight:int = 0;
         var spaceBetweenButtonsHeight:int = 0;
         if(!this._dataProviderButtons)
         {
            return;
         }
         var totalVisibleBtns:uint = this.totalNumberOfVisibleButtons;
         if(totalVisibleBtns < this._dataProviderButtons.length)
         {
            totalVisibleBtns--;
         }
         this._dataProviderButtons.sortOn("position",Array.NUMERIC);
         var btns:Array = this._dataProviderButtons.slice(0,totalVisibleBtns);
         var hasMoreBtn:Boolean = false;
         if(totalVisibleBtns + 1 < this._dataProviderButtons.length)
         {
            btns.push(this._btn_more);
            hasMoreBtn = true;
         }
         if(totalVisibleBtns > btns.length)
         {
            totalVisibleBtns = btns.length;
         }
         this.gd_btnUis.dataProvider = btns;
         if(hasMoreBtn)
         {
            this.gd_btnUis.slots[totalVisibleBtns].allowDrag = false;
            this.btn_more_slot = this.gd_btnUis.slots[totalVisibleBtns];
            remainingButtons = this._dataProviderButtons.slice(totalVisibleBtns);
            remainingButtonsLength = remainingButtons.length;
            buttonsHeight = remainingButtonsLength * this._uiBtnHeight;
            spaceBetweenButtonsHeight = remainingButtonsLength * this._uiBtnOffset;
            if(spaceBetweenButtonsHeight >= this._uiBtnHeight)
            {
               spaceBetweenButtonsHeight = this._uiBtnHeight - 1;
            }
            this.ctr_moreBtn.height = buttonsHeight + spaceBetweenButtonsHeight + this._uiBtnOffset;
            this.gd_additionalBtns.height = buttonsHeight + spaceBetweenButtonsHeight;
            this.gd_additionalBtns.dataProvider = remainingButtons;
         }
         else
         {
            this.gd_additionalBtns.dataProvider = false;
            this.btn_more_slot = null;
         }
         for each(slot in this.gd_btnUis.slots)
         {
            slot.allowDrag = this.ctr_moreBtn.visible || this._allowDrag;
         }
      }
      
      public function get totalNumberOfVisibleButtons() : uint
      {
         var size:Number = this._uiBtnHeight * (!!this._big ? 1.5 : 1);
         var count:int = Math.floor(this.gd_btnUis.width / size) * Math.floor(this.gd_btnUis.height / size);
         if(count == 0)
         {
            count = 1;
         }
         return count;
      }
      
      private function dropValidatorBtn(target:Object, data:Object, source:Object) : Boolean
      {
         if(!data || target && target.data && target.data.id == int.MAX_VALUE || source && source.data && source.data.id == int.MAX_VALUE)
         {
            return false;
         }
         return data is ButtonWrapper;
      }
      
      private function processDropBtn(target:Object, data:Object, source:Object) : void
      {
         var idData:int = 0;
         var slot:Slot = null;
         var fromSelected:Boolean = false;
         var fromDisabled:Boolean = false;
         var arrowUiProperties:Object = null;
         var indexToRemove:int = 0;
         var i:int = 0;
         var posFrom:int = 0;
         var posTo:int = 0;
         var btn:ButtonWrapper = null;
         var idTarget:int = 0;
         var toSelected:Boolean = false;
         var toDisabled:Boolean = false;
         var components:Array = null;
         if(this.dropValidatorBtn(target,data,source))
         {
            idData = data.id;
            slot = this.getSlotByBtnId(idData);
            fromSelected = slot.selected;
            fromDisabled = slot.disabled;
            if(target && !target.data)
            {
               indexToRemove = -1;
               for(i = 0; i < this._dataProviderButtons.length; i++)
               {
                  if(indexToRemove > -1)
                  {
                     posFrom = (this._dataProviderButtons[i - 1] as ButtonWrapper).position;
                     posTo = (this._dataProviderButtons[i] as ButtonWrapper).position;
                     this._btnPositionById[(this._dataProviderButtons[i - 1] as ButtonWrapper).id] = posTo;
                     this._btnPositionById[(this._dataProviderButtons[i] as ButtonWrapper).id] = posFrom;
                     this.rpApi.switchButtonWrappers(this._dataProviderButtons[i - 1],this._dataProviderButtons[i]);
                     btn = this._dataProviderButtons[i - 1];
                     this._dataProviderButtons[i - 1] = this._dataProviderButtons[i];
                     this._dataProviderButtons[i] = btn;
                  }
                  if(this._dataProviderButtons[i].id == idData && indexToRemove == -1)
                  {
                     indexToRemove = i;
                  }
               }
               if(indexToRemove == -1)
               {
                  return;
               }
            }
            else
            {
               idTarget = target.data.id;
               slot = this.getSlotByBtnId(idTarget);
               toSelected = slot.selected;
               toDisabled = slot.disabled;
               this._btnPositionById[idData] = target.data.position;
               this._btnPositionById[idTarget] = data.position;
               this.rpApi.switchButtonWrappers(data as ButtonWrapper,target.data);
               slot = this.getSlotByBtnId(idTarget);
               slot.selected = toSelected;
               slot.disabled = toDisabled;
               this.refreshButtonAtIndex(this.getBtnById(idTarget).position);
            }
            sysApi.setData(this._btnSaveKey,this._btnPositionById);
            this.updateButtonGrids();
            this.uiApi.hideTooltip();
            slot = this.getSlotByBtnId(idData);
            slot.selected = fromSelected;
            slot.disabled = fromDisabled;
            this.refreshButtonAtIndex(this.getBtnById(idData).position);
            arrowUiProperties = this.highlightApi.getArrowUiProperties();
            if(arrowUiProperties && arrowUiProperties.uiName == UIEnum.BANNER && (arrowUiProperties.componentName.indexOf("gd_btnUis") != -1 || arrowUiProperties.componentName.indexOf("gd_additionalBtns") != -1))
            {
               components = arrowUiProperties.componentName.split("|");
               components[0] = this.getBtnById(idData).position > this.totalNumberOfVisibleButtons ? "gd_additionalBtns" : "gd_btnUis";
               this.highlightApi.highlightUi(UIEnum.BANNER,components.join("|"),arrowUiProperties.pos,arrowUiProperties.reverse,arrowUiProperties.strata,arrowUiProperties.loop);
            }
         }
      }
      
      private function emptyFct(... args) : void
      {
      }
      
      private function addBannerButton(id:int, assetUri:String, callbackFct:Function = null, tooltipText:String = "", shortcutName:String = "", description:String = "") : void
      {
         var maxPos:int = 0;
         var pos:int = 0;
         if(!this._btnPositionById[id])
         {
            maxPos = 0;
            for each(pos in this._btnPositionById)
            {
               if(pos > maxPos)
               {
                  maxPos = pos;
               }
            }
            this._btnPositionById[id] = maxPos + 1;
         }
         this._dataProviderButtons.push(this.dataApi.getButtonWrapper(id,this._btnPositionById[id],assetUri,callbackFct,tooltipText,shortcutName,description));
      }
      
      private function removeBannerButton(id:int) : void
      {
         var btnToRemovePos:int = 0;
         var pos:int = 0;
         var btnId:* = null;
         var btnIndex:int = 0;
         if(this._btnPositionById[id])
         {
            btnToRemovePos = this._btnPositionById[id];
            for(btnId in this._btnPositionById)
            {
               pos = this._btnPositionById[btnId];
               if(pos > btnToRemovePos)
               {
                  this._btnPositionById[btnId] = pos - 1;
               }
            }
            this._btnPositionById[id] = null;
         }
         var btn:ButtonWrapper = this.getBtnById(id);
         if(btn != null)
         {
            btnIndex = this._dataProviderButtons.indexOf(btn);
            if(btnIndex >= 0)
            {
               this._dataProviderButtons.splice(btnIndex,1);
            }
         }
      }
      
      private function onGenericMouseClick(target:DisplayObject) : void
      {
         var slot:Slot = null;
         var arrowUiProperties:Object = null;
         if(target is Slot && (target as Slot).data is ButtonWrapper && (target as Slot).data.position == this.ID_BTN_MORE)
         {
            return;
         }
         if(target != this.ctr_moreBtn && !this._isDragging && this.ctr_moreBtn.visible && !this._openAdditionalBtns)
         {
            this.ctr_moreBtn.visible = false;
            for each(slot in this.gd_btnUis.slots)
            {
               slot.allowDrag = false;
            }
            arrowUiProperties = this.highlightApi.getArrowUiProperties();
            if(arrowUiProperties && arrowUiProperties.uiName == UIEnum.BANNER_MENU && arrowUiProperties.componentName.indexOf("gd_additionalBtns") != -1)
            {
               this.highlightApi.stop();
            }
         }
         this._openAdditionalBtns = false;
      }
      
      private function onArenaUpdateRank(soloInfos:ArenaRankInfosWrapper, groupInfos:ArenaRankInfosWrapper = null, duelInfos:ArenaRankInfosWrapper = null) : void
      {
         var btn:ButtonWrapper = this.getBtnById(this.ID_BTN_KOLIZEUM);
         if(btn != null && !btn.active && this.playerApi.getPlayedCharacterInfo().level >= ProtocolConstantsEnum.CHAR_MIN_LEVEL_ARENA)
         {
            this.checkConquest();
         }
      }
      
      private function onDisplayUiArrow(pUiArrowProperties:Object) : void
      {
         var components:Array = null;
         var btn:ButtonWrapper = null;
         if(pUiArrowProperties.uiName == UIEnum.BANNER || pUiArrowProperties.uiName == UIEnum.BANNER_MENU)
         {
            components = pUiArrowProperties.componentName.split("|");
            if(components[0] == "gd_btnUis")
            {
               for each(btn in this._dataProviderButtons)
               {
                  if(btn.hasOwnProperty(components[1]) && btn[components[1]] == components[2])
                  {
                     if(btn.position > this.totalNumberOfVisibleButtons)
                     {
                        if(!this.ctr_moreBtn.visible)
                        {
                           this.toggleAllButtonsVisibility();
                        }
                        this.highlightApi.highlightUi(UIEnum.BANNER_MENU,pUiArrowProperties.componentName.replace("gd_btnUis","gd_additionalBtns"),pUiArrowProperties.pos,pUiArrowProperties.reverse,pUiArrowProperties.strata,pUiArrowProperties.loop);
                        this._openAdditionalBtns = true;
                     }
                     break;
                  }
               }
            }
         }
      }
      
      private function onCharacterAction() : void
      {
         if(this.shortcutTimerReady() && this.getBtnById(this.ID_BTN_CARAC).active)
         {
            sysApi.sendAction(new OpenStatsAction([]));
         }
      }
      
      private function onSpellsAction() : void
      {
         if(this.shortcutTimerReady() && this.getBtnById(this.ID_BTN_SPELL).active)
         {
            if(this._forgettableSpellsActivated)
            {
               if(!this.uiApi.getUi("forgettableSpellsUi"))
               {
                  sysApi.sendAction(new OpenForgettableSpellsUiAction([]));
               }
               else
               {
                  sysApi.sendAction(new OpenBookAction(["forgettableSpellsUi"]));
               }
            }
            else
            {
               sysApi.sendAction(new OpenBookAction(["spellBase"]));
            }
         }
      }
      
      private function onItemsAction() : void
      {
         if(this.shortcutTimerReady() && this.getBtnById(this.ID_BTN_BAG).active)
         {
            this.openInventory();
         }
      }
      
      private function onQuestsAction() : void
      {
         if(this.shortcutTimerReady() && this.getBtnById(this.ID_BTN_BOOK).active)
         {
            sysApi.sendAction(new OpenBookAction(["questTab"]));
         }
      }
      
      private function onMapAction() : void
      {
         if(this.shortcutTimerReady() && this.getBtnById(this.ID_BTN_MAP).active)
         {
            sysApi.sendAction(new OpenMapAction([]));
         }
      }
      
      private function onSocialAction() : void
      {
         if(this.shortcutTimerReady() && this.getBtnById(this.ID_BTN_SOCIAL).active)
         {
            sysApi.sendAction(new OpenSocialAction([DataEnum.SOCIAL_TAB_LAST_OPENED_ID]));
         }
      }
      
      private function onFriendsAction() : void
      {
         if(this.shortcutTimerReady() && this.getBtnById(this.ID_BTN_SOCIAL).active)
         {
            sysApi.sendAction(new OpenSocialAction([DataEnum.SOCIAL_TAB_FRIENDS_ID]));
         }
      }
      
      private function onGuildAction() : void
      {
         if(this.shortcutTimerReady() && this.getBtnById(this.ID_BTN_SOCIAL).active)
         {
            if(this.socialApi.hasGuild())
            {
               sysApi.sendAction(new OpenSocialAction([DataEnum.SOCIAL_TAB_GUILD_ID]));
            }
            else
            {
               sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.error.onlyForGuild"),666,this.timeApi.getTimestamp());
            }
         }
      }
      
      private function onAllianceAction() : void
      {
         if(this.shortcutTimerReady() && this.getBtnById(this.ID_BTN_SOCIAL).active)
         {
            if(this.socialApi.hasAlliance())
            {
               sysApi.sendAction(new OpenSocialAction([DataEnum.SOCIAL_TAB_ALLIANCE_ID]));
            }
            else
            {
               sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.error.onlyForAlliance"),666,this.timeApi.getTimestamp());
            }
         }
      }
      
      private function onKolizeumAction() : void
      {
         var errorMessage:String = null;
         if(this.shortcutTimerReady())
         {
            if(this.getBtnById(this.ID_BTN_KOLIZEUM) && this.getBtnById(this.ID_BTN_KOLIZEUM).active)
            {
               this.getSlotByBtnId(this.ID_BTN_KOLIZEUM).selected = this._bArenaRegistered;
               sysApi.sendAction(new OpenArenaAction([]));
            }
            else
            {
               if(this.playerApi.getPlayedCharacterInfo().level < ProtocolConstantsEnum.CHAR_MIN_LEVEL_ARENA)
               {
                  errorMessage = this.uiApi.getText("ui.error.arenaLock",ProtocolConstantsEnum.CHAR_MIN_LEVEL_ARENA);
               }
               else
               {
                  errorMessage = this.uiApi.getText("ui.error.arenaAccessError");
               }
               sysApi.dispatchHook(ChatHookList.TextInformation,errorMessage,666,this.timeApi.getTimestamp());
            }
         }
         this.checkConquest();
      }
      
      private function onWebAction() : void
      {
         if(this.shortcutTimerReady())
         {
            if(this.getBtnById(this.ID_BTN_OGRINE).active)
            {
               sysApi.sendAction(new OpenWebServiceAction([null]));
            }
            else if(sysApi.getCurrentServer().gameTypeId != GameServerTypeEnum.SERVER_TYPE_HARDCORE)
            {
               sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.error.onlyIfModeSecured"),666,this.timeApi.getTimestamp());
            }
            else
            {
               sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.banner.lockBtn.shopHeroic"),666,this.timeApi.getTimestamp());
            }
         }
         this.checkWeb();
      }
      
      private function onAlignmentAction() : void
      {
         if(this.shortcutTimerReady())
         {
            if(this.playerApi.getAlignmentSide() != AlignmentSideEnum.ALIGNMENT_NEUTRAL)
            {
               sysApi.sendAction(new OpenBookAction(["alignmentTab"]));
            }
            else
            {
               sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.error.onlyForAligned"),666,this.timeApi.getTimestamp());
            }
         }
      }
      
      private function onJobAction() : void
      {
         if(this.shortcutTimerReady() && this.getBtnById(this.ID_BTN_JOB).active)
         {
            sysApi.sendAction(new OpenBookAction(["jobTab"]));
         }
      }
      
      private function onMountAction() : void
      {
         if(this.shortcutTimerReady())
         {
            if(this.getBtnById(this.ID_BTN_MOUNT) && this.getBtnById(this.ID_BTN_MOUNT).active)
            {
               sysApi.sendAction(new OpenMountAction([]));
            }
            else if(!this.playerApi.getMount())
            {
               sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.error.onlyForMount"),666,this.timeApi.getTimestamp());
            }
         }
         this.checkMount();
      }
      
      private function onSpouseAction() : void
      {
         if(this.shortcutTimerReady() && !this.playerApi.isInTutorialArea())
         {
            if(this.socialApi.hasSpouse())
            {
               sysApi.sendAction(new OpenSocialAction([DataEnum.SOCIAL_TAB_SPOUSE_ID]));
            }
            else
            {
               sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.error.wedLock"),666,this.timeApi.getTimestamp());
            }
         }
      }
      
      private function onAlmanaxAction() : void
      {
         if(this.shortcutTimerReady() && !this.playerApi.isInTutorialArea())
         {
            sysApi.sendAction(new OpenBookAction(["calendarTab"]));
         }
      }
      
      private function onAchievementAction() : void
      {
         if(this.shortcutTimerReady() && this.getBtnById(this.ID_BTN_ACHIEVEMENT).active)
         {
            sysApi.sendAction(new OpenBookAction(["achievementTab"]));
         }
      }
      
      private function onTitleAction() : void
      {
         if(this.shortcutTimerReady())
         {
            if(!this.playerApi.isInTutorialArea() && currentContext == ContextEnum.ROLEPLAY)
            {
               sysApi.sendAction(new OpenBookAction(["titleTab"]));
            }
            else
            {
               sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.error.onlyOutsideCombat"),666,this.timeApi.getTimestamp());
            }
         }
      }
      
      private function onBestiaryAction() : void
      {
         if(this.shortcutTimerReady() && this.getBtnById(this.ID_BTN_ENCYCLOPEDIA).active)
         {
            sysApi.sendAction(new OpenBookAction(["bestiaryTab"]));
         }
      }
      
      private function onBreachAction() : void
      {
         var breachButton:ButtonWrapper = null;
         var errorTextKey:String = null;
         if(this.shortcutTimerReady())
         {
            breachButton = this.getBtnById(this.ID_BTN_BREACH);
            if(breachButton && breachButton.active)
            {
               sysApi.sendAction(new BreachTeleportRequestAction([]));
            }
            else
            {
               errorTextKey = "ui.error.breachLockLevel";
               if(this.playerApi.getPlayedCharacterInfo().level >= ProtocolConstantsEnum.MIN_LEVEL_BREACH)
               {
                  if(sysApi.getPlayerManager().subscriptionEndDate > 0)
                  {
                     errorTextKey = "ui.error.breachLockSubArea";
                  }
                  else
                  {
                     errorTextKey = "ui.payzone.limit";
                  }
               }
               sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText(errorTextKey),666,this.timeApi.getTimestamp());
            }
         }
         this.checkBreach();
      }
      
      private function onBuildsAction() : void
      {
         if(this.shortcutTimerReady() && this.getBtnById(this.ID_BTN_BUILDS).active)
         {
            sysApi.dispatchHook(HookList.OpenCharacterBuilds,-1);
         }
      }
      
      private function onShopAction() : void
      {
         if(this.shortcutTimerReady() && this.getBtnById(this.ID_BTN_SHOP).active)
         {
            if(!this.uiApi.getUi("stockMyselfVendor"))
            {
               sysApi.sendAction(new ExchangeRequestOnShopStockAction([]));
            }
            else
            {
               this.uiApi.unloadUi("stockMyselfVendor");
            }
         }
      }
      
      private function onIdolsAction() : void
      {
         if(this.shortcutTimerReady() && this.getBtnById(this.ID_BTN_IDOLS).active)
         {
            if(!this.uiApi.getUi("idolsTab"))
            {
               sysApi.sendAction(new OpenIdolsAction([]));
            }
            else
            {
               sysApi.sendAction(new OpenBookAction(["idolsTab"]));
            }
         }
      }
      
      private function onHavenBagAction() : void
      {
         if(this.shortcutTimerReady())
         {
            if(this.getBtnById(this.ID_BTN_HAVENBAG) && this.getBtnById(this.ID_BTN_HAVENBAG).active)
            {
               if(this._havenbagPopupId)
               {
                  this.uiApi.unloadUi(this._havenbagPopupId);
                  this._havenbagPopupId = null;
               }
               sysApi.sendAction(new HavenbagEnterAction([this.playerApi.id()]));
            }
            else if(this.playerApi.getPlayedCharacterInfo().level < ProtocolConstantsEnum.MIN_LEVEL_HAVENBAG)
            {
               sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.error.havenbagLock",ProtocolConstantsEnum.MIN_LEVEL_HAVENBAG),666,this.timeApi.getTimestamp());
            }
            else if(sysApi.getPlayerManager().subscriptionEndDate <= 0)
            {
               sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.payzone.limit"),666,this.timeApi.getTimestamp());
            }
         }
         this.checkHavenbag();
      }
      
      private function onGuidebookAction() : void
      {
         if(this.shortcutTimerReady() && this.getBtnById(this.ID_BTN_GUIDEBOOK).active)
         {
            if(!this.uiApi.getUi(UIEnum.GUIDEBOOK))
            {
               sysApi.sendAction(new OpenGuidebookAction([null]));
            }
            else
            {
               this.uiApi.unloadUi(UIEnum.GUIDEBOOK);
            }
         }
      }
      
      private function onCompanionAction() : void
      {
         if(!this.playerApi.isInTutorialArea())
         {
            if(this.shortcutTimerReady())
            {
               if(!this.uiApi.getUi(EnumTab.COMPANION_TAB))
               {
                  sysApi.sendAction(new OpenBookAction(["companionTab"]));
               }
               else
               {
                  this.uiApi.unloadUi(EnumTab.COMPANION_TAB);
               }
            }
         }
      }
      
      public function checkMount(waitForRefresh:Boolean = false) : Boolean
      {
         var btn:ButtonWrapper = this.getBtnById(this.ID_BTN_MOUNT);
         if(btn == null)
         {
            return false;
         }
         var active:* = this.playerApi.getMount() != null;
         this.rpApi.setButtonWrapperActivation(btn,active);
         if(!waitForRefresh)
         {
            this.refreshButtonAtIndex(btn.position);
         }
         return active;
      }
      
      public function checkSpouse(waitForRefresh:Boolean = false) : Boolean
      {
         var active:Boolean = false;
         var btn:ButtonWrapper = this.getBtnById(this.ID_BTN_SPOUSE);
         if(btn == null)
         {
            return false;
         }
         if(this.socialApi.hasSpouse())
         {
            active = true;
         }
         else
         {
            active = false;
         }
         this.rpApi.setButtonWrapperActivation(btn,active);
         if(!waitForRefresh)
         {
            this.refreshButtonAtIndex(btn.position);
         }
         return active;
      }
      
      public function checkConquest(waitForRefresh:Boolean = false) : Boolean
      {
         var active:Boolean = false;
         var btn:ButtonWrapper = this.getBtnById(this.ID_BTN_KOLIZEUM);
         if(btn == null)
         {
            return false;
         }
         if(this.playerApi.getPlayedCharacterInfo().level >= ProtocolConstantsEnum.CHAR_MIN_LEVEL_ARENA && this.configApi.isFeatureWithKeywordEnabled("pvp.kis"))
         {
            active = true;
         }
         else
         {
            active = false;
         }
         this.rpApi.setButtonWrapperActivation(btn,active);
         if(!waitForRefresh)
         {
            this.refreshButtonAtIndex(btn.position);
         }
         return active;
      }
      
      public function checkWeb(waitForRefresh:Boolean = false) : void
      {
         var btn:ButtonWrapper = this.getBtnById(this.ID_BTN_OGRINE);
         var description:String = "";
         if(this._secureMode)
         {
            description = this.uiApi.getText("ui.error.onlyIfModeSecured");
         }
         else if(sysApi.getCurrentServer().gameTypeId == GameServerTypeEnum.SERVER_TYPE_HARDCORE)
         {
            description = this.uiApi.getText("ui.banner.lockBtn.shopHeroic");
         }
         if(description == "")
         {
            this.rpApi.setButtonWrapperActivation(btn,true);
         }
         else
         {
            this.rpApi.setButtonWrapperActivation(btn,false,description);
         }
         if(!waitForRefresh)
         {
            this.refreshButtonAtIndex(btn.position);
         }
      }
      
      public function checkHavenbag(waitForRefresh:Boolean = false) : Boolean
      {
         var active:Boolean = false;
         var btn:ButtonWrapper = this.getBtnById(this.ID_BTN_HAVENBAG);
         if(btn == null)
         {
            return false;
         }
         var description:String = "";
         if(this.playerApi.getPlayedCharacterInfo().level >= ProtocolConstantsEnum.MIN_LEVEL_HAVENBAG && (sysApi.getPlayerManager().subscriptionEndDate > 0 || sysApi.getPlayerManager().hasRights))
         {
            active = true;
         }
         else
         {
            active = false;
            if(this.playerApi.getPlayedCharacterInfo().level < ProtocolConstantsEnum.MIN_LEVEL_HAVENBAG)
            {
               description = this.uiApi.getText("ui.banner.lockBtn.lvl",ProtocolConstantsEnum.MIN_LEVEL_HAVENBAG);
            }
            else if(!(sysApi.getPlayerManager().subscriptionEndDate > 0 || sysApi.getPlayerManager().hasRights))
            {
               description = this.uiApi.getText("ui.payzone.limit");
            }
         }
         this.rpApi.setButtonWrapperActivation(btn,active,description);
         if(!waitForRefresh)
         {
            this.refreshButtonAtIndex(btn.position);
         }
         return active;
      }
      
      public function checkBreach(waitForRefresh:Boolean = false) : Boolean
      {
         var active:Boolean = false;
         var breachTitleText:* = null;
         var btn:ButtonWrapper = this.getBtnById(this.ID_BTN_BREACH);
         if(btn == null)
         {
            return false;
         }
         var description:String = "";
         var currentSubArea:SubArea = this.playerApi.currentSubArea();
         var psiAllowed:Boolean = !currentSubArea ? true : Boolean(currentSubArea.psiAllowed);
         if(this.playerApi.getPlayedCharacterInfo().level >= ProtocolConstantsEnum.MIN_LEVEL_BREACH && (sysApi.getPlayerManager().subscriptionEndDate > 0 || sysApi.getPlayerManager().hasRights))
         {
            if(!this._onBreachMap)
            {
               if(this._serverType == GameServerTypeEnum.SERVER_TYPE_HARDCORE)
               {
                  breachTitleText = this.uiApi.getText("ui.breach.title") + " (" + this.uiApi.getText("ui.alert.info.aggressionZone") + ")";
               }
               else
               {
                  breachTitleText = this.uiApi.getText("ui.breach.title");
               }
               if(!psiAllowed)
               {
                  description = this.uiApi.getText("ui.breach.lockInSubArea");
               }
               active = psiAllowed;
               this.rpApi.setButtonWrapperActivation(btn,psiAllowed,description,breachTitleText);
            }
            else if(this._serverType == GameServerTypeEnum.SERVER_TYPE_HARDCORE)
            {
               description = this.uiApi.getText("ui.breach.alreadyInBreach");
               active = false;
               this.rpApi.setButtonWrapperActivation(btn,active,description);
            }
            else
            {
               active = true;
               this.rpApi.setButtonWrapperActivation(btn,active,description,this.uiApi.getText("ui.breach.leaveBreachCompletely"));
            }
         }
         else
         {
            if(this.playerApi.getPlayedCharacterInfo().level < ProtocolConstantsEnum.MIN_LEVEL_BREACH)
            {
               description = this.uiApi.getText("ui.banner.lockBtn.lvl",ProtocolConstantsEnum.MIN_LEVEL_BREACH);
            }
            else if(sysApi.getPlayerManager().subscriptionEndDate <= 0 && !sysApi.getPlayerManager().hasRights)
            {
               description = this.uiApi.getText("ui.payzone.limit");
            }
            else
            {
               description = this.uiApi.getText("ui.breach.alreadyInBreach");
            }
            active = false;
            this.rpApi.setButtonWrapperActivation(btn,false,description);
         }
         if(!waitForRefresh)
         {
            this.refreshButtonAtIndex(btn.position);
         }
         return active;
      }
      
      private function onSecureModeChange(isActive:Boolean) : void
      {
         this._secureMode = isActive;
         this.checkWeb();
      }
      
      private function onBreachTeleport(teleported:Boolean) : void
      {
         this._onBreachMap = teleported;
         this.checkBreach();
      }
      
      public function checkAllBtnActivationState(waitForRefresh:Boolean = false) : void
      {
         if(!this.socialApi.hasSocialFrame())
         {
            return;
         }
         this.checkMount(waitForRefresh);
         this.checkSpouse(waitForRefresh);
         this.checkConquest(waitForRefresh);
         this.checkWeb(waitForRefresh);
         this.checkHavenbag(waitForRefresh);
         this.checkBreach(waitForRefresh);
      }
      
      public function getBtnById(id:int) : ButtonWrapper
      {
         var btn:ButtonWrapper = null;
         for each(btn in this._dataProviderButtons)
         {
            if(btn.id == id)
            {
               return btn;
            }
         }
         return null;
      }
      
      public function getBtnIndexById(id:int) : int
      {
         var btn:ButtonWrapper = null;
         var index:Number = 0;
         for each(btn in this._dataProviderButtons)
         {
            if(btn.id == id)
            {
               return index;
            }
            index++;
         }
         return index - 1;
      }
      
      public function setDisabledBtn(id:int, disabled:Boolean) : void
      {
         var btn:ButtonWrapper = this.getBtnById(id);
         this.rpApi.setButtonWrapperActivation(btn,!disabled);
         this.refreshButtonAtIndex(btn.position);
      }
      
      public function setDisabledBtns(disabled:Boolean) : void
      {
         var btn:ButtonWrapper = null;
         for each(btn in this._dataProviderButtons)
         {
            this.rpApi.setButtonWrapperActivation(btn,!disabled);
            this.refreshButtonAtIndex(btn.position);
         }
      }
      
      public function getSlotByBtnId(id:int) : Slot
      {
         var pos:int = this.getBtnById(id).position;
         if(pos < this.totalNumberOfVisibleButtons || pos == this.totalNumberOfVisibleButtons && this.gd_additionalBtns.slots.length == 0)
         {
            return this.gd_btnUis.slots[pos - 1];
         }
         return this.gd_additionalBtns.slots[pos - this.totalNumberOfVisibleButtons];
      }
      
      public function refreshButtonAtIndex(index:uint) : void
      {
         var totalBtnsInMainGrid:int = this.gd_btnUis.dataProvider.length;
         if(this.gd_additionalBtns.dataProvider.length)
         {
            totalBtnsInMainGrid--;
         }
         if(index <= totalBtnsInMainGrid)
         {
            this.gd_btnUis.updateItem(index - 1);
         }
         else
         {
            this.gd_additionalBtns.updateItem(index - totalBtnsInMainGrid - 1);
         }
      }
      
      private function highlightButton(btn:ButtonWrapper) : void
      {
         var btnPosition:uint = 0;
         if(btn.highlight)
         {
            btnPosition = btn.position;
            if(btnPosition > this.totalNumberOfVisibleButtons && !this.ctr_moreBtn.visible)
            {
               this.toggleAllButtonsVisibility();
               this.highlightApi.highlightUi(UIEnum.BANNER_MENU,"gd_additionalBtns|id|" + btn.id,3,0,5,true);
            }
            else
            {
               this.highlightApi.highlightUi(UIEnum.BANNER_MENU,"gd_btnUis|id|" + btn.id,0,0,5,true);
            }
         }
         btn.highlight = false;
      }
      
      private function onCharacterLevelUp(pOldLevel:uint, pNewLevel:uint, pCaracPointEarned:uint, pHealPointEarned:uint, newSpellWrappers:Array) : void
      {
         var btn:ButtonWrapper = null;
         var breachTitleText:* = null;
         var breachText:String = null;
         var playerInfo:* = null;
         if(this.playerApi)
         {
            playerInfo = this.playerApi.getPlayedCharacterInfo();
         }
         if(playerInfo)
         {
            if(this.getBtnById(this.ID_BTN_BREACH) == null && playerInfo.level >= ProtocolConstantsEnum.MIN_LEVEL_BREACH)
            {
               if(this._serverType == GameServerTypeEnum.SERVER_TYPE_HARDCORE)
               {
                  breachTitleText = this.uiApi.getText("ui.breach.title") + " (" + this.uiApi.getText("ui.alert.info.aggressionZone") + ")";
               }
               else
               {
                  breachTitleText = this.uiApi.getText("ui.breach.title");
               }
               if(this.playerApi.getPlayedCharacterInfo().level >= ProtocolConstantsEnum.MIN_LEVEL_BREACH)
               {
                  if(sysApi.getPlayerManager().subscriptionEndDate <= 0)
                  {
                     breachText = this.uiApi.getText("ui.payzone.limit");
                  }
                  else
                  {
                     breachText = this.uiApi.getText("ui.breach.alreadyInBreach");
                  }
               }
               else
               {
                  breachText = this.uiApi.getText("ui.banner.lockBtn.lvl",ProtocolConstantsEnum.MIN_LEVEL_BREACH);
               }
               this.addBannerButton(this.ID_BTN_BREACH,"btn_breach",this.onBreachAction,breachTitleText,"openBreach",breachText);
               btn = this.getBtnById(this.ID_BTN_BREACH);
               btn.highlight = true;
               this.checkBreach();
            }
            if(this.getBtnById(this.ID_BTN_HAVENBAG) == null && playerInfo.level >= ProtocolConstantsEnum.MIN_LEVEL_HAVENBAG)
            {
               this.addBannerButton(this.ID_BTN_HAVENBAG,"btn_havenbag",this.onHavenBagAction,this.uiApi.getText("ui.havenbag.havenbag"),"openHavenbag",this.uiApi.getText("ui.banner.lockBtn.lvl",ProtocolConstantsEnum.MIN_LEVEL_HAVENBAG));
               btn = this.getBtnById(this.ID_BTN_HAVENBAG);
               btn.highlight = true;
               this.checkHavenbag();
            }
            if(this.getBtnById(this.ID_BTN_KOLIZEUM) == null && playerInfo.level >= ProtocolConstantsEnum.CHAR_MIN_LEVEL_ARENA)
            {
               this.addBannerButton(this.ID_BTN_KOLIZEUM,"btn_conquest",this.onKolizeumAction,this.uiApi.getText("ui.common.koliseum"),"openPvpArena",this.uiApi.getText("ui.banner.lockBtn.lvl",ProtocolConstantsEnum.CHAR_MIN_LEVEL_ARENA));
               btn = this.getBtnById(this.ID_BTN_KOLIZEUM);
               btn.highlight = true;
               this.checkConquest();
            }
            if(this.getBtnById(this.ID_BTN_MOUNT) == null && playerInfo.level >= ProtocolConstantsEnum.CHAR_MIN_LEVEL_RIDE)
            {
               this.addBannerButton(this.ID_BTN_MOUNT,"btn_mount",this.onMountAction,this.uiApi.getText("ui.banner.mount"),"openMount",this.uiApi.getText("ui.banner.lockBtn.mount"));
               btn = this.getBtnById(this.ID_BTN_MOUNT);
               btn.highlight = true;
               this.checkMount();
               sysApi.removeHook(HookList.CharacterLevelUp);
            }
            this.updateButtonGrids();
         }
      }
      
      private function onUiUnloaded(uiName:String) : void
      {
         var playerInfo:Object = null;
         var btn:ButtonWrapper = null;
         var addMountButton:Boolean = false;
         if(uiName && uiName.indexOf("levelUp") == 0 && this.playerApi && this.playerApi.getPlayedCharacterInfo())
         {
            this.checkBreach();
            playerInfo = this.playerApi.getPlayedCharacterInfo();
            btn = this.getBtnById(this.ID_BTN_HAVENBAG);
            if(playerInfo.level >= ProtocolConstantsEnum.MIN_LEVEL_HAVENBAG && btn && this.checkHavenbag())
            {
               this.highlightButton(btn);
            }
            btn = this.getBtnById(this.ID_BTN_KOLIZEUM);
            if(playerInfo.level >= ProtocolConstantsEnum.CHAR_MIN_LEVEL_ARENA && btn && this.checkConquest())
            {
               this.highlightButton(btn);
            }
            btn = this.getBtnById(this.ID_BTN_BREACH);
            if(playerInfo.level >= ProtocolConstantsEnum.MIN_LEVEL_BREACH && btn && this.checkBreach())
            {
               this.highlightButton(btn);
            }
            btn = this.getBtnById(this.ID_BTN_MOUNT);
            if(playerInfo.level >= ProtocolConstantsEnum.CHAR_MIN_LEVEL_RIDE && btn)
            {
               addMountButton = sysApi.getData("addMountButton_" + this.playerApi.getPlayedCharacterInfo().id,DataStoreEnum.BIND_CHARACTER);
               if(!addMountButton)
               {
                  this.highlightButton(btn);
               }
               sysApi.setData("addMountButton_" + this.playerApi.getPlayedCharacterInfo().id,true,DataStoreEnum.BIND_CHARACTER);
            }
            if(this.playerApi.getPlayedCharacterInfo().level == ProtocolConstantsEnum.MAX_LEVEL)
            {
               sysApi.removeHook(BeriliaHookList.UiUnloaded);
            }
         }
      }
      
      private function onHavenbagPopupClose() : void
      {
         this._havenbagPopupId = null;
         this.highlightApi.stop();
      }
      
      private function onArenaRegistrationStatusUpdate(isRegistered:Boolean, currentStatus:int) : void
      {
         if(isRegistered != this._bArenaRegistered)
         {
            this.getSlotByBtnId(this.ID_BTN_KOLIZEUM).selected = isRegistered;
            this._bArenaRegistered = isRegistered;
         }
      }
      
      private function onMountSet() : void
      {
         var addMountButton:Boolean = false;
         var btn:ButtonWrapper = null;
         if(this.getBtnById(this.ID_BTN_MOUNT) == null)
         {
            this.addBannerButton(this.ID_BTN_MOUNT,"btn_mount",this.onMountAction,this.uiApi.getText("ui.banner.mount"),"openMount",this.uiApi.getText("ui.banner.lockBtn.mount"));
            this.checkMount();
            this.updateButtonGrids();
            addMountButton = sysApi.getData("addMountButton_" + this.playerApi.getPlayedCharacterInfo().id,DataStoreEnum.BIND_CHARACTER);
            if(this.playerApi.getPlayedCharacterInfo().level < ProtocolConstantsEnum.CHAR_MIN_LEVEL_RIDE && !addMountButton)
            {
               btn = this.getBtnById(this.ID_BTN_MOUNT);
               if(btn.position > this.totalNumberOfVisibleButtons && !this.ctr_moreBtn.visible)
               {
                  this.toggleAllButtonsVisibility();
                  this.highlightApi.highlightUi(UIEnum.BANNER_MENU,"gd_additionalBtns|id|" + this.ID_BTN_MOUNT,3,0,5,true);
               }
               else
               {
                  this.highlightApi.highlightUi(UIEnum.BANNER_MENU,"gd_btnUis|id|" + this.ID_BTN_MOUNT,0,0,5,true);
               }
            }
            sysApi.setData("addMountButton_" + this.playerApi.getPlayedCharacterInfo().id,true,DataStoreEnum.BIND_CHARACTER);
         }
         else
         {
            this.checkMount();
         }
      }
      
      private function onMountUnSet() : void
      {
         this.checkMount();
      }
      
      private function onSpouseUpdated() : void
      {
         var btn:ButtonWrapper = this.getBtnById(this.ID_BTN_SPOUSE);
         if(btn == null && this.socialApi.hasSpouse())
         {
            this.addBannerButton(this.ID_BTN_SPOUSE,"btn_spouse",this.onSpouseAction,this.uiApi.processText(this.uiApi.getText("ui.common.spouse"),"m",true),"openSocialSpouse",this.uiApi.getText("ui.banner.lockBtn.wed"));
            this.checkSpouse();
            this.updateButtonGrids();
            btn = this.getBtnById(this.ID_BTN_SPOUSE);
            if(!this._loading)
            {
               if(btn.position > this.totalNumberOfVisibleButtons && !this.ctr_moreBtn.visible)
               {
                  this.toggleAllButtonsVisibility();
                  this.highlightApi.highlightUi(UIEnum.BANNER_MENU,"gd_additionalBtns|id|" + this.ID_BTN_SPOUSE,3,0,5,true);
               }
               else
               {
                  this.highlightApi.highlightUi(UIEnum.BANNER_MENU,"gd_btnUis|id|" + this.ID_BTN_SPOUSE,0,0,5,true);
               }
            }
         }
         else
         {
            this.checkSpouse();
            if(btn && !this.socialApi.hasSpouse())
            {
               this.removeBannerButton(this.ID_BTN_SPOUSE);
               this.updateButtonGrids();
            }
         }
      }
      
      public function onConfigChange(target:String, name:String, value:*, oldValue:*) : void
      {
         if(target != "dofus" || name != "bigMenuButton")
         {
            return;
         }
         this._big = sysApi.getOption("bigMenuButton","dofus");
         this.gd_btnUis.slotHeight = this._uiBtnHeight * (!!this._big ? 1.5 : 1);
         this.gd_btnUis.slotWidth = this._uiBtnHeight * (!!this._big ? 1.5 : 1);
         this.updateUiMinimalSize();
         var minSize:Point = this.calculateUiMinimalSize();
         var mustBeRefresh:Boolean = false;
         if(this.mainCtr.width < minSize.x)
         {
            mustBeRefresh = true;
            this.mainCtr.width = minSize.x;
            this.gd_btnUis.width = minSize.x - this.gd_btnUis.x * 2 - 4;
         }
         if(this.mainCtr.height < minSize.y)
         {
            mustBeRefresh = true;
            this.mainCtr.height = minSize.y;
            this.gd_btnUis.height = minSize.y - this.gd_btnUis.y * 2;
         }
         if(mustBeRefresh)
         {
            this.mainCtr.setSavedDimension(this.mainCtr.width,this.mainCtr.height);
            this.uiApi.me().render();
         }
         this.updateButtonGrids();
      }
      
      private function shortcutTimerReady() : Boolean
      {
         var currentTime:int = getTimer();
         var ret:* = currentTime - this._shortcutTimerDuration > SHORTCUT_DISABLE_DURATION;
         this._shortcutTimerDuration = currentTime;
         if(ret)
         {
         }
         return ret;
      }
      
      private function onDropStart(src:Object) : void
      {
         this._isDragging = true;
      }
      
      private function onDropEnd(src:Object) : void
      {
         this._isDragging = false;
      }
      
      private function openInventory() : void
      {
         var storageUi:UiRootContainer = null;
         if(this.uiApi.getUi(UIEnum.STORAGE_UI) || this.uiApi.getUi(UIEnum.INVENTORY_UI))
         {
            storageUi = this.uiApi.getUi(UIEnum.STORAGE_UI);
            if(!storageUi || storageUi.uiClass && storageUi.uiClass.currentStorageBehavior && storageUi.uiClass.currentStorageBehavior.getName() == "bag")
            {
               sysApi.sendAction(new CloseInventoryAction([]));
            }
         }
         else
         {
            sysApi.sendAction(new OpenInventoryAction([]));
         }
      }
      
      private function onPVPFeatureActivationUpdate(featureKeyword:String, featureId:int, isEnabled:Boolean) : void
      {
         this.checkConquest();
      }
      
      private function onNewTemporisRewardsAvailable(areTemporisRewardsAvailable:Boolean) : void
      {
         sysApi.setData(STORAGE_NEW_TEMPORIS_REWARD,areTemporisRewardsAvailable);
         var temporisQuestTabSlot:Slot = this.getSlotByBtnId(this.ID_BTN_GUIDEBOOK);
         if(temporisQuestTabSlot !== null)
         {
            temporisQuestTabSlot.selected = areTemporisRewardsAvailable;
         }
      }
   }
}
