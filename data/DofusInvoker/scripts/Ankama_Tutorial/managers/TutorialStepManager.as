package Ankama_Tutorial.managers
{
   import Ankama_Tutorial.Api;
   import Ankama_Tutorial.TutorialConstants;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.types.shortcut.Bind;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.datacenter.items.ItemType;
   import com.ankamagames.dofus.datacenter.quest.Quest;
   import com.ankamagames.dofus.internalDatacenter.fight.FighterInformations;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ShortcutWrapper;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.quest.QuestObjectiveValidationAction;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.misc.lists.TriggerHookList;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   
   public class TutorialStepManager
   {
      
      private static var _self:TutorialStepManager;
      
      private static var _watchedComponents:Object = null;
      
      private static var _fightWatchedComponents:Object = null;
      
      private static var _disabledShortcuts:Object = {
         "cac":false,
         "s1":false,
         "s2":false,
         "s3":false,
         "s4":false,
         "s5":false,
         "s6":false,
         "s7":false,
         "s8":false,
         "s9":false,
         "s10":false,
         "s11":false,
         "s12":false,
         "s13":false,
         "s14":false,
         "s15":false,
         "s16":false,
         "s17":false,
         "s18":false,
         "s19":false,
         "s20":false,
         "skipTurn":false,
         "bannerSpellsTab":false,
         "bannerItemsTab":false,
         "bannerEmotesTab":false,
         "bannerPreviousTab":false,
         "bannerNextTab":false,
         "flagCurrentMap":false,
         "openInventory":false,
         "openBookSpell":false,
         "openBookQuest":false,
         "openBookAlignment":false,
         "openBookJob":false,
         "openWorldMap":false,
         "openSocialFriends":false,
         "openSocialGuild":false,
         "openSocialAlliance":false,
         "openSocialSpouse":false,
         "openCharacterSheet":false,
         "openMount":false,
         "openWebBrowser":false,
         "openTeamSearch":false,
         "openPvpArena":false,
         "openSell":false,
         "openAlmanax":false,
         "openAchievement":false,
         "openTitle":false,
         "openBestiary":false,
         "openHavenbag":false,
         "showAllNames":false,
         "showEntitiesTooltips":false,
         "toggleRide":false,
         "pageItem1":false,
         "pageItem2":false,
         "pageItem3":false,
         "pageItem4":false,
         "pageItem5":false,
         "pageItemDown":false,
         "pageItemUp":false,
         "openIdols":false,
         "openBuild":false,
         "openGuidebook":false,
         "openCompanion":false
      };
      
      private static var _dropItem:Object;
      
      private static const DELAY_BEFORE_HIGHLIGHT_SHORT:uint = 5000;
      
      private static const DELAY_BEFORE_HIGHLIGHT_LONG:uint = 10000;
       
      
      private const INTRO_DIALOGUE_DURATION:int = 3000;
      
      private var _bannerMenuUiClass:Object;
      
      private var _actionBarUiClass:Object;
      
      private var _currentStepNumber:int = -1;
      
      private var _introStepTimer:BenchmarkTimer;
      
      private var _quest:Quest;
      
      private var _disabled:Boolean = false;
      
      public var doneIntroStep:Boolean = false;
      
      public function TutorialStepManager()
      {
         super();
         Api.system.addHook(InventoryHookList.EquipmentObjectMove,this.onEquipmentObjectMove);
         Api.system.addHook(HookList.GameFightStarting,this.onGameFightStarting);
         Api.system.addHook(HookList.GameFightStart,this.onGameFightStart);
         Api.system.addHook(FightHookList.GameEntityDisposition,this.onGameEntityDisposition);
         Api.system.addHook(TriggerHookList.PlayerFightMove,this.onPlayerFightMove);
         Api.system.addHook(TriggerHookList.FightSpellCast,this.onFightSpellCast);
         Api.system.addHook(HookList.GameFightTurnEnd,this.onGameFightTurnEnd);
         Api.system.addHook(TriggerHookList.PlayerMove,this.onPlayerMove);
         Api.system.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         Api.system.addHook(BeriliaHookList.UiUnloaded,this.onUiUnloaded);
         Api.system.addHook(CustomUiHookList.StorageFilterUpdated,this.onStorageFilterUpdated);
         Api.system.addHook(HookList.MapComplementaryInformationsData,this.onMapComplementaryInformationsData);
         Api.system.addHook(BeriliaHookList.DropStart,this.onDropStart);
         Api.system.addHook(BeriliaHookList.DropEnd,this.onDropEnd);
         Api.system.addHook(HookList.CastSpellMode,this.onCastSpellMode);
         Api.system.addHook(HookList.CancelCastSpell,this.onCancelCastSpell);
         Api.system.addHook(HookList.GameFightEnd,this.onGameFightEnd);
         Api.system.addHook(HookList.StopableSoundEnded,this.onSoundEnded);
         Api.system.addHook(HookList.NpcDialogRepliesVisible,this.onNpcDialogRepliesVisible);
         Api.system.addHook(FightHookList.FightResultClosed,this.onFightResultClosed);
         this._quest = Api.data.getQuest(TutorialConstants.QUEST_TUTORIAL_ID);
         var doneIntroData:* = Api.system.getData(Api.player.getPlayedCharacterInfo().id + "doneIntroStep");
         if(doneIntroData)
         {
            this.doneIntroStep = doneIntroData;
         }
         this._disabled = true;
      }
      
      public static function initStepManager() : void
      {
         _self = new TutorialStepManager();
      }
      
      public static function getInstance() : TutorialStepManager
      {
         if(_self == null)
         {
            initStepManager();
         }
         return _self;
      }
      
      public function get preloaded() : Boolean
      {
         return _watchedComponents != null && _fightWatchedComponents != null;
      }
      
      public function set disabled(b:Boolean) : void
      {
         this._disabled = b;
         if(b)
         {
            this.unsetAllDisabled();
         }
         else
         {
            this.redoSteps();
         }
      }
      
      public function unload() : void
      {
         _watchedComponents = null;
         _fightWatchedComponents = null;
      }
      
      public function get disabled() : Boolean
      {
         return this._disabled;
      }
      
      public function get bannerMenuUiClass() : Object
      {
         return this._bannerMenuUiClass;
      }
      
      public function set bannerMenuUiClass(uiClass:Object) : void
      {
         this._bannerMenuUiClass = uiClass;
      }
      
      public function removeHooks() : void
      {
         Api.system.removeHook(InventoryHookList.EquipmentObjectMove);
         Api.system.removeHook(HookList.GameFightStarting);
         Api.system.removeHook(HookList.GameFightStart);
         Api.system.removeHook(FightHookList.GameEntityDisposition);
         Api.system.removeHook(TriggerHookList.PlayerFightMove);
         Api.system.removeHook(TriggerHookList.FightSpellCast);
         Api.system.removeHook(HookList.GameFightTurnEnd);
         Api.system.removeHook(TriggerHookList.PlayerMove);
         Api.system.removeHook(BeriliaHookList.UiLoaded);
         Api.system.removeHook(BeriliaHookList.UiUnloaded);
         Api.system.removeHook(CustomUiHookList.StorageFilterUpdated);
         Api.system.removeHook(HookList.MapComplementaryInformationsData);
         Api.system.removeHook(BeriliaHookList.DropStart);
         Api.system.removeHook(BeriliaHookList.DropEnd);
         Api.system.removeHook(HookList.CastSpellMode);
         Api.system.removeHook(HookList.CancelCastSpell);
         Api.system.removeHook(HookList.GameFightEnd);
         Api.system.removeHook(HookList.StopableSoundEnded);
         Api.system.removeHook(HookList.NpcDialogRepliesVisible);
         Api.system.removeHook(FightHookList.FightResultClosed);
      }
      
      private function onPlayerMove() : void
      {
         if(!this.disabled)
         {
            if(this._currentStepNumber == TutorialConstants.TUTORIAL_STEP_ROLEPLAY_MOVE)
            {
               this.validateCurrentStep();
            }
         }
      }
      
      private function onGameFightEnd(resultsKey:String) : void
      {
         if(!this.disabled)
         {
            Api.highlight.stop();
         }
      }
      
      private function onEquipmentObjectMove(item:Object, oldPosition:uint) : void
      {
         var nbItems:int = 0;
         var hasRing:Boolean = false;
         var i:ItemWrapper = null;
         if(!this.disabled)
         {
            switch(this._currentStepNumber)
            {
               case TutorialConstants.TUTORIAL_STEP_EQUIP_ITEM:
                  if(item)
                  {
                     this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__CLOSE_INTERFACE);
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_EQUIP_ALL_ITEMS:
                  nbItems = 0;
                  hasRing = false;
                  for each(i in Api.storage.getViewContent("equipment"))
                  {
                     if(i)
                     {
                        if(TutorialConstants.TUTORIAL_RINGS_POSITIONS.indexOf(i.position) != -1)
                        {
                           hasRing = true;
                        }
                        else if(TutorialConstants.TUTORIAL_ITEMS_POSITIONS.indexOf(i.position) != -1)
                        {
                           nbItems++;
                        }
                     }
                  }
                  if(nbItems == TutorialConstants.TUTORIAL_ITEMS_POSITIONS.length && hasRing)
                  {
                     this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__CLOSE_CHARACTER_SHEET);
                  }
            }
         }
      }
      
      private function onGameFightStarting(fightType:uint) : void
      {
         if(!this.disabled)
         {
            switch(this._currentStepNumber)
            {
               case TutorialConstants.TUTORIAL_STEP_STARTING_A_FIGHT:
                  this.validateCurrentStep();
                  break;
               case TutorialConstants.TUTORIAL_STEP_FIND_BOSS:
                  this.validateCurrentStep();
            }
         }
      }
      
      private function onGameEntityDisposition(dispositionInformation:Object, cellId:uint, direction:uint) : void
      {
         if(!this.disabled)
         {
            if(this._currentStepNumber == TutorialConstants.TUTORIAL_STEP_FIGHT_LOCATION)
            {
               this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_FIGHT_LOCATION__START_FIGHT);
            }
         }
      }
      
      private function onGameFightStart() : void
      {
         if(!this.disabled)
         {
            if(this._currentStepNumber < TutorialConstants.TUTORIAL_STEP_FIGHT_CAST_SPELL)
            {
               _watchedComponents["SpellsBanner"].disabled = true;
            }
            if(this._currentStepNumber == TutorialConstants.TUTORIAL_STEP_FIGHT_LOCATION)
            {
               this.validateCurrentStep();
            }
         }
      }
      
      private function onPlayerFightMove() : void
      {
         if(!this.disabled)
         {
            if(this._currentStepNumber == TutorialConstants.TUTORIAL_STEP_FIGHT_MOVE)
            {
               this.validateCurrentStep();
            }
         }
      }
      
      private function onFightSpellCast() : void
      {
         if(!this.disabled)
         {
            if(this._currentStepNumber == TutorialConstants.TUTORIAL_STEP_FIGHT_CAST_SPELL)
            {
               this.validateCurrentStep();
            }
         }
      }
      
      private function onGameFightTurnEnd(entityId:Number) : void
      {
         if(!this.disabled)
         {
            if(this._currentStepNumber == TutorialConstants.TUTORIAL_STEP_FIGHT_SKIP_TURN)
            {
               if(entityId == Api.player.id())
               {
                  this.validateCurrentStep();
               }
            }
         }
      }
      
      private function onUiLoaded(name:String) : void
      {
         var ui:UiRootContainer = null;
         if(!this.disabled)
         {
            switch(this._currentStepNumber)
            {
               case TutorialConstants.TUTORIAL_STEP_TALK:
                  if(name == "npcDialog")
                  {
                     this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_TALK__SHOW_RESPONSE);
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_SUCCESS_QUEST:
                  if(name == "npcDialog")
                  {
                     this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_SUCCESS_QUEST__SHOW_RESPONSE);
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_START_QUEST:
                  if(name == "npcDialog")
                  {
                     this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__SHOW_RESPONSE);
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_EQUIP_ITEM:
                  if(name == UIEnum.STORAGE_UI)
                  {
                     ui = Api.ui.getUi(name);
                     if(ui && ui.uiClass.categoryFilter != 0)
                     {
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_TAB);
                     }
                     else
                     {
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_EQUIPEMENT);
                     }
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_CHANGE_MAP:
                  if(name == UIEnum.STORAGE_UI)
                  {
                     this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_CHANGE_MAP__SHOW_MAP_TRANSITION);
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_FIND_BOSS:
                  if(name == UIEnum.STORAGE_UI)
                  {
                     this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__SHOW_TRANSITION);
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_EQUIP_ALL_ITEMS:
                  if(name == UIEnum.STORAGE_UI)
                  {
                     ui = Api.ui.getUi(name);
                     if(ui)
                     {
                        ui.uiClass.categoryFilter = 0;
                     }
                     this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_EQUIPEMENT);
                  }
            }
         }
      }
      
      private function onUiUnloaded(name:String) : void
      {
         var nbItems:int = 0;
         var hasRing:Boolean = false;
         var i:ItemWrapper = null;
         if(!this.disabled)
         {
            switch(this._currentStepNumber)
            {
               case TutorialConstants.TUTORIAL_STEP_TALK:
                  if(name == "npcDialog")
                  {
                     this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_TALK__SHOW_NPC);
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_SUCCESS_QUEST:
                  if(name == "npcDialog")
                  {
                     this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_SUCCESS_QUEST__SHOW_NPC);
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_START_QUEST:
                  if(name == "npcDialog")
                  {
                     this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__SHOW_NPC);
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_EQUIP_ITEM:
                  if(name == UIEnum.STORAGE_UI)
                  {
                     if(Api.player.getEquipment().length > 0)
                     {
                        this.validateCurrentStep();
                     }
                     else
                     {
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__OPEN_CHARACTER_SHEET);
                     }
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_EQUIP_ALL_ITEMS:
                  if(name == UIEnum.STORAGE_UI)
                  {
                     nbItems = 0;
                     hasRing = false;
                     for each(i in Api.storage.getViewContent("equipment"))
                     {
                        if(i)
                        {
                           if(TutorialConstants.TUTORIAL_RINGS_POSITIONS.indexOf(i.position) != -1)
                           {
                              hasRing = true;
                           }
                           else if(TutorialConstants.TUTORIAL_ITEMS_POSITIONS.indexOf(i.position) != -1)
                           {
                              nbItems++;
                           }
                        }
                     }
                     if(nbItems == TutorialConstants.TUTORIAL_ITEMS_POSITIONS.length && hasRing)
                     {
                        this.validateCurrentStep();
                     }
                     else
                     {
                        this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_CHARACTER_SHEET);
                     }
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_CHANGE_MAP:
                  if(name == UIEnum.STORAGE_UI)
                  {
                     this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_CHANGE_MAP__SHOW_MAP_TRANSITION);
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_FIND_BOSS:
                  if(name == UIEnum.STORAGE_UI)
                  {
                     this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__SHOW_TRANSITION);
                  }
                  break;
               case TutorialConstants.TUTORIAL_INTRO_DIALOGUE:
                  if(name == UIEnum.CINEMATIC)
                  {
                     this.refreshStep(TutorialConstants.TUTORIAL_INTRO_DIALOGUE);
                  }
            }
         }
      }
      
      public function onFightResultClosed() : void
      {
         if(!this.disabled)
         {
            switch(this._currentStepNumber)
            {
               case TutorialConstants.TUTORIAL_STEP_START_QUEST:
                  this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__SHOW_NPC);
                  break;
               case TutorialConstants.TUTORIAL_STEP_SUCCESS_QUEST:
                  this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_SUCCESS_QUEST__SHOW_NPC);
            }
         }
      }
      
      public function onMapComplementaryInformationsData(map:Object, subAreaId:uint, show:Boolean) : void
      {
         if(!this.disabled)
         {
            switch(this._currentStepNumber)
            {
               case TutorialConstants.TUTORIAL_STEP_TALK:
                  this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_TALK__SHOW_NPC);
                  break;
               case TutorialConstants.TUTORIAL_STEP_STARTING_A_FIGHT:
                  this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_STARTING_A_FIGHT__SHOW_MONSTER);
                  break;
               case TutorialConstants.TUTORIAL_STEP_START_QUEST:
                  this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__CLOSE_FIGHT_RESULT);
                  break;
               case TutorialConstants.TUTORIAL_STEP_FIND_BOSS:
                  if(map.mapId == TutorialConstants.TUTORIAL_MAP_ID_THIRD_BEFORE_FIGHT)
                  {
                     this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__SHOW_BOSS);
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_SUCCESS_QUEST:
                  this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_SUCCESS_QUEST__CLOSE_FIGHT_RESULT);
            }
         }
      }
      
      public function onDropStart(src:Object) : void
      {
         if(!this.disabled && src.data)
         {
            switch(this._currentStepNumber)
            {
               case TutorialConstants.TUTORIAL_STEP_EQUIP_ITEM:
                  if(src.data is ItemWrapper)
                  {
                     _dropItem = src.data;
                     this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_TARGET);
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_EQUIP_ALL_ITEMS:
                  if(src.data is ItemWrapper)
                  {
                     _dropItem = src.data;
                     this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_EQUIPEMENT_TARGET);
                  }
            }
         }
      }
      
      public function onDropEnd(src:Object, target:Object) : void
      {
         if(!this.disabled)
         {
            switch(this._currentStepNumber)
            {
               case TutorialConstants.TUTORIAL_STEP_EQUIP_ITEM:
                  this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_EQUIPEMENT);
                  break;
               case TutorialConstants.TUTORIAL_STEP_EQUIP_ALL_ITEMS:
                  this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_EQUIPEMENT);
            }
         }
      }
      
      public function onCastSpellMode(spell:Object) : void
      {
         if(!this.disabled)
         {
            switch(this._currentStepNumber)
            {
               case TutorialConstants.TUTORIAL_STEP_FIGHT_CAST_SPELL:
                  this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_FIGHT_CAST_SPELL__SHOW_TARGET);
            }
         }
      }
      
      public function onCancelCastSpell(spell:Object) : void
      {
         if(!this.disabled)
         {
            switch(this._currentStepNumber)
            {
               case TutorialConstants.TUTORIAL_STEP_FIGHT_CAST_SPELL:
                  this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_FIGHT_CAST_SPELL__SHOW_SPELL);
            }
         }
      }
      
      public function onStorageFilterUpdated(items:Object, category:int) : void
      {
         switch(this._currentStepNumber)
         {
            case TutorialConstants.TUTORIAL_STEP_EQUIP_ITEM:
               if(category == ItemCategoryEnum.EQUIPMENT_CATEGORY)
               {
                  this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_EQUIPEMENT);
               }
               else
               {
                  this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_TAB);
               }
               break;
            case TutorialConstants.TUTORIAL_STEP_EQUIP_ALL_ITEMS:
               if(category == ItemCategoryEnum.EQUIPMENT_CATEGORY)
               {
                  this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_EQUIPEMENT);
               }
               else
               {
                  this.refreshStep(TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_TAB);
               }
         }
      }
      
      private function onSoundEnded(fileName:String) : void
      {
         if(fileName == TutorialConstants.TUTORIAL_AUDIO_DIALOG_INTRO)
         {
            this.jumpToStep(TutorialConstants.TUTORIAL_STEP_ROLEPLAY_MOVE);
            if(this._introStepTimer)
            {
               this._introStepTimer.stop();
               this._introStepTimer.removeEventListener(TimerEvent.TIMER,this.onFakeStepTimerEnd);
            }
         }
      }
      
      private function onNpcDialogRepliesVisible(pVisible:Boolean) : void
      {
         if(!this.disabled)
         {
            Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_LONG);
            Api.highlight.highlightUi("npcDialog","btn_rep0",7,1,5,true);
         }
      }
      
      public function preload() : void
      {
         this.loadWatchedComponents();
         this.loadFightWatchedComponents();
      }
      
      public function loadWatchedComponents() : void
      {
         var bannerMenuUi:* = Api.ui.getUi("bannerMenu");
         var actionBarUi:* = Api.ui.getUi("bannerActionBar");
         if(!bannerMenuUi || !actionBarUi)
         {
            return;
         }
         this._bannerMenuUiClass = bannerMenuUi.uiClass;
         this._actionBarUiClass = actionBarUi.uiClass;
         _watchedComponents = new Dictionary();
         _watchedComponents["SpellsBanner"] = this._actionBarUiClass.gd_spellitemotes;
         _watchedComponents["InventoryButton"] = this._bannerMenuUiClass.ID_BTN_BAG;
         _watchedComponents["GrimoireButton"] = this._bannerMenuUiClass.ID_BTN_SPELL;
         _watchedComponents["QuestButton"] = this._bannerMenuUiClass.ID_BTN_BOOK;
         _watchedComponents["SpellTab"] = this._actionBarUiClass.btn_tabSpells;
         _watchedComponents["InventoryTab"] = this._actionBarUiClass.btn_tabItems;
         this.checkComponents(_watchedComponents);
      }
      
      public function loadFightWatchedComponents() : void
      {
         var bannerUi:* = Api.ui.getUi(UIEnum.BANNER);
         if(!bannerUi)
         {
            return;
         }
         var bannerUiClass:Object = bannerUi.uiClass;
         _fightWatchedComponents = new Dictionary();
         _fightWatchedComponents["SkipTurnButton"] = bannerUiClass.btn_readyOrSkip;
         _fightWatchedComponents["ReadyButton"] = bannerUiClass.btn_readyOrSkip;
         _fightWatchedComponents["LeaveButton"] = bannerUiClass.btn_leave;
         _fightWatchedComponents["HelpButton"] = bannerUiClass.btn_requestHelp;
         _fightWatchedComponents["AllowJoinFightButton"] = bannerUiClass.btn_lockFight;
         _fightWatchedComponents["AllowJoinFightPartyButton"] = bannerUiClass.btn_lockParty;
         _fightWatchedComponents["InvisibleModeButton"] = bannerUiClass.btn_tacticMode;
         _fightWatchedComponents["AllowSpectatorButton"] = bannerUiClass.btn_noSpectator;
         _fightWatchedComponents["ShowCellButton"] = bannerUiClass.btn_pointCell;
         this.checkComponents(_fightWatchedComponents);
      }
      
      public function unsetAllDisabled() : void
      {
         this.setWatchedElementsDisabled(false);
         this.setFightWatchedElementsDisabled(false);
         this._bannerMenuUiClass.checkAllBtnActivationState(false);
         Api.modMenu.setBehavior(null);
      }
      
      public function onFakeStepTimerEnd(e:TimerEvent) : void
      {
         (e.target as Timer).removeEventListener(TimerEvent.TIMER,this.onFakeStepTimerEnd);
         this.jumpToStep(TutorialConstants.TUTORIAL_STEP_ROLEPLAY_MOVE);
      }
      
      public function prepareStep(stepNumber:uint, subStep:uint = 0, displayArrow:Boolean = false) : void
      {
         var btnPosition:uint = 0;
         var cinematicUi:UiRootContainer = null;
         var wp:WorldPointWrapper = null;
         var cellId:int = 0;
         var fighter:FighterInformations = null;
         var superTypeId:uint = 0;
         var positions:Array = null;
         this._currentStepNumber = stepNumber;
         var tutorialUi:UiRootContainer = Api.ui.getUi(UIEnum.TUTORIAL_UI);
         this.moveTutorialUiDefault();
         Api.highlight.stop();
         if(!this.disabled)
         {
            switch(stepNumber)
            {
               case TutorialConstants.TUTORIAL_INTRO_DIALOGUE:
                  this.setWatchedElementsDisabled(true);
                  cinematicUi = Api.ui.getUi(UIEnum.CINEMATIC);
                  if(displayArrow && !cinematicUi)
                  {
                     this.doneIntroStep = true;
                     Api.system.setData(Api.player.getPlayedCharacterInfo().id + "doneIntroStep",true);
                     tutorialUi.visible = false;
                     Api.roleplay.showNpcBubble(TutorialConstants.TUTORIAL_PNJ_ID,Api.ui.getText("ui.tutorial.dialog.jorisBubble"));
                     this._introStepTimer = new BenchmarkTimer(this.INTRO_DIALOGUE_DURATION,0,"TutorialStepManager._introStepTimer");
                     this._introStepTimer.addEventListener(TimerEvent.TIMER,this.onFakeStepTimerEnd);
                     this._introStepTimer.start();
                     Api.roleplay.playEntityAnimation(TutorialConstants.TUTORIAL_PNJ_ID,"AnimAttaque2");
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_ROLEPLAY_MOVE:
                  tutorialUi.visible = true;
                  this.setWatchedElementsDisabled(true);
                  if(displayArrow)
                  {
                     Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_SHORT);
                     Api.highlight.highlightAbsolute(new Rectangle(TutorialConstants.ROLEPLAY_MOVE_DESTINATION_X,TutorialConstants.ROLEPLAY_MOVE_DESTINATION_Y),0,0,0,true);
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_TALK:
                  switch(subStep)
                  {
                     case TutorialConstants.TUTORIAL_SUB_STEP_TALK__LOADING_MAP:
                        Api.modMenu.getMenuMaker("npc").maker.disabled = false;
                        break;
                     case TutorialConstants.TUTORIAL_SUB_STEP_TALK__SHOW_NPC:
                        if(displayArrow)
                        {
                           Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_SHORT);
                           Api.roleplay.playEntityAnimation(TutorialConstants.TUTORIAL_PNJ_ID,"AnimAttaque1");
                           Api.highlight.highlightNpc(TutorialConstants.TUTORIAL_PNJ_ID,true);
                        }
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_EQUIP_ITEM:
                  switch(subStep)
                  {
                     case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__OPEN_CHARACTER_SHEET:
                        btnPosition = this._bannerMenuUiClass.getBtnById(this._bannerMenuUiClass.ID_BTN_BAG).position;
                        if(displayArrow)
                        {
                           Api.roleplay.playEntityAnimation(TutorialConstants.TUTORIAL_PNJ_ID,"AnimAttaque6");
                           if(btnPosition > this._bannerMenuUiClass.totalNumberOfVisibleButtons && !this._bannerMenuUiClass.ctr_moreBtn.visible)
                           {
                              this._bannerMenuUiClass.toggleAllButtonsVisibility();
                              Api.highlight.highlightUi(UIEnum.BANNER_MENU,"gd_additionalBtns|id|" + this._bannerMenuUiClass.ID_BTN_BAG,3,0,5,true);
                           }
                           else
                           {
                              Api.highlight.highlightUi(UIEnum.BANNER_MENU,"gd_btnUis|id|" + this._bannerMenuUiClass.ID_BTN_BAG,0,0,5,true);
                           }
                        }
                        this._bannerMenuUiClass.setDisabledBtn(this._bannerMenuUiClass.ID_BTN_BAG,false);
                        this.setShortcutDisabled("openInventory",false);
                        break;
                     case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_TAB:
                        this.moveTutorialUiLeft();
                        if(displayArrow)
                        {
                           Api.highlight.highlightUi(UIEnum.STORAGE_UI,"btnEquipable",0,0,5,true);
                        }
                        break;
                     case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_EQUIPEMENT:
                        this.moveTutorialUiLeft();
                        if(displayArrow)
                        {
                           Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_SHORT);
                           Api.highlight.highlightUi(UIEnum.STORAGE_UI,"grid|objectGID|10785|",0,0,5,true);
                        }
                        break;
                     case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__SHOW_TARGET:
                        this.moveTutorialUiLeft();
                        if(displayArrow)
                        {
                           Api.highlight.highlightUi(UIEnum.STORAGE_UI,"slot_2",5,0,5,true);
                        }
                        break;
                     case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ITEM__CLOSE_INTERFACE:
                        this.moveTutorialUiLeft();
                        if(displayArrow)
                        {
                           Api.highlight.highlightUi(UIEnum.STORAGE_UI,"btn_close",7,0,5,true);
                        }
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_CHANGE_MAP:
                  if(!Api.ui.getUi(UIEnum.STORAGE_UI))
                  {
                     subStep = TutorialConstants.TUTORIAL_SUB_STEP_CHANGE_MAP__SHOW_MAP_TRANSITION;
                  }
                  switch(subStep)
                  {
                     case TutorialConstants.TUTORIAL_SUB_STEP_CHANGE_MAP__SHOW_MAP_TRANSITION:
                        if(displayArrow)
                        {
                           Api.roleplay.playEntityAnimation(TutorialConstants.TUTORIAL_PNJ_ID,"AnimAttaque8");
                           Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_LONG);
                           Api.highlight.highlightMapTransition(TutorialConstants.TUTORIAL_MAP_ID_FIRST,TutorialConstants.CHANGE_MAP_TRANSITION_ORIENTATION,TutorialConstants.CHANGE_MAP_TRANSITION_POSITION,false,0,true);
                        }
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_STARTING_A_FIGHT:
                  this.setFightWatchedElementsDisabled(true);
                  switch(subStep)
                  {
                     case TutorialConstants.TUTORIAL_SUB_STEP_STARTING_A_FIGHT__LOADING_MAP:
                        break;
                     case TutorialConstants.TUTORIAL_SUB_STEP_STARTING_A_FIGHT__SHOW_MONSTER:
                        if(displayArrow)
                        {
                           Api.roleplay.playEntityAnimation(TutorialConstants.TUTORIAL_PNJ_ID,"AnimAttaque4");
                           Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_SHORT);
                           Api.highlight.highlightMonster(TutorialConstants.TUTORIAL_MONSTER_ID_POUTCH,true);
                        }
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_FIGHT_LOCATION:
                  switch(subStep)
                  {
                     case TutorialConstants.TUTORIAL_SUB_STEP_FIGHT_LOCATION__SHOW_CELL:
                        if(displayArrow)
                        {
                           Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_LONG);
                           Api.highlight.highlightCell(TutorialConstants.FIGHT_LOCATION_TARGET_CELLS,true);
                        }
                        break;
                     case TutorialConstants.TUTORIAL_SUB_STEP_FIGHT_LOCATION__START_FIGHT:
                        this.setShortcutDisabled("skipTurn",false);
                        _fightWatchedComponents["ReadyButton"].disabled = false;
                        Api.modMenu.getMenuMaker("player").maker.disabled = false;
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_FIGHT_MOVE:
                  _fightWatchedComponents["ReadyButton"].disabled = false;
                  if(Api.player.isInFight() && displayArrow)
                  {
                     cellId = -1;
                     fighter = Api.fight.getFighterInformations(Api.player.id());
                     if(fighter)
                     {
                        cellId = TutorialConstants.FIGHT_MOVE_TARGET_CELLS[fighter.currentCell];
                        Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_SHORT);
                        Api.highlight.highlightCell([cellId],true);
                     }
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_FIGHT_CAST_SPELL:
                  switch(subStep)
                  {
                     case TutorialConstants.TUTORIAL_SUB_STEP_FIGHT_CAST_SPELL__SHOW_SPELL:
                        if(Api.player.isInFight() && displayArrow)
                        {
                           Api.highlight.highlightUi("bannerActionBar","gd_spellitemotes|slot|1");
                        }
                        _fightWatchedComponents["SkipTurnButton"].disabled = false;
                        this.setShortcutDisabled("skipTurn",false);
                        _watchedComponents["SpellsBanner"].disabled = false;
                        this.setShortcutDisabled("cac",false);
                        this.setShortcutDisabled("s1",false);
                        this.setShortcutDisabled("s2",false);
                        this.setShortcutDisabled("s3",false);
                        this.setShortcutDisabled("s4",false);
                        this.setShortcutDisabled("s5",false);
                        this.setShortcutDisabled("s6",false);
                        this.setShortcutDisabled("s7",false);
                        this.setShortcutDisabled("s8",false);
                        this.setShortcutDisabled("s9",false);
                        this.setShortcutDisabled("s10",false);
                        this.setShortcutDisabled("s11",false);
                        this.setShortcutDisabled("s12",false);
                        this.setShortcutDisabled("s13",false);
                        this.setShortcutDisabled("s14",false);
                        this.setShortcutDisabled("s15",false);
                        this.setShortcutDisabled("s16",false);
                        this.setShortcutDisabled("s17",false);
                        this.setShortcutDisabled("s18",false);
                        this.setShortcutDisabled("s19",false);
                        this.setShortcutDisabled("s20",false);
                        this.setShortcutDisabled("pageItem1",false);
                        this.setShortcutDisabled("pageItem2",false);
                        this.setShortcutDisabled("pageItem3",false);
                        this.setShortcutDisabled("pageItem4",false);
                        this.setShortcutDisabled("pageItem5",false);
                        this.setShortcutDisabled("pageItemDown",false);
                        this.setShortcutDisabled("pageItemUp",false);
                        break;
                     case TutorialConstants.TUTORIAL_SUB_STEP_FIGHT_CAST_SPELL__SHOW_TARGET:
                        if(displayArrow)
                        {
                           Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_SHORT);
                           Api.highlight.highlightMonster(TutorialConstants.TUTORIAL_MONSTER_ID_POUTCH,true);
                        }
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_FIGHT_SKIP_TURN:
                  if(Api.player.isInFight() && displayArrow)
                  {
                     Api.highlight.highlightUi(UIEnum.BANNER,"btn_readyOrSkip",0,0,5,true);
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_START_QUEST:
                  if(subStep == TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__CLOSE_FIGHT_RESULT && !Api.ui.getUi(UIEnum.FIGHT_RESULT_SIMPLE))
                  {
                     subStep = TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__SHOW_NPC;
                  }
                  switch(subStep)
                  {
                     case TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__LOADING_MAP:
                        break;
                     case TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__CLOSE_FIGHT_RESULT:
                        if(displayArrow)
                        {
                           Api.highlight.highlightUi(UIEnum.FIGHT_RESULT_SIMPLE,"btn_close",7,0,5,true);
                        }
                        break;
                     case TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__SHOW_NPC:
                        this.moveTutorialUiLeft();
                        if(displayArrow)
                        {
                           Api.roleplay.playEntityAnimation(TutorialConstants.TUTORIAL_PNJ_ID,"AnimAttaque5");
                           Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_SHORT);
                           Api.highlight.highlightNpc(TutorialConstants.TUTORIAL_PNJ_ID,true);
                        }
                        break;
                     case TutorialConstants.TUTORIAL_SUB_STEP_START_QUEST__SHOW_RESPONSE:
                        this.moveTutorialUiLeft();
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_EQUIP_ALL_ITEMS:
                  switch(subStep)
                  {
                     case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_CHARACTER_SHEET:
                        this._bannerMenuUiClass.setDisabledBtn(_watchedComponents["GrimoireButton"],false);
                        this._bannerMenuUiClass.setDisabledBtn(_watchedComponents["QuestButton"],false);
                        this.setShortcutDisabled("openBook",false);
                        this.setShortcutDisabled("openBookSpell",false);
                        this.setShortcutDisabled("openBookQuest",false);
                        btnPosition = this._bannerMenuUiClass.getBtnById(this._bannerMenuUiClass.ID_BTN_BAG).position;
                        if(displayArrow)
                        {
                           Api.roleplay.playEntityAnimation(TutorialConstants.TUTORIAL_PNJ_ID,"AnimStatique");
                           Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_SHORT);
                           if(btnPosition > this._bannerMenuUiClass.totalNumberOfVisibleButtons && !this._bannerMenuUiClass.ctr_moreBtn.visible)
                           {
                              this._bannerMenuUiClass.toggleAllButtonsVisibility();
                              Api.highlight.highlightUi(UIEnum.BANNER_MENU,"gd_additionalBtns|id|" + this._bannerMenuUiClass.ID_BTN_BAG,3,0,5,true);
                           }
                           else
                           {
                              Api.highlight.highlightUi(UIEnum.BANNER_MENU,"gd_btnUis|id|" + this._bannerMenuUiClass.ID_BTN_BAG,0,0,5,true);
                           }
                        }
                        break;
                     case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_TAB:
                        this.moveTutorialUiLeft();
                        if(displayArrow)
                        {
                           Api.highlight.highlightUi(UIEnum.STORAGE_UI,"btnEquipable",0,0,5,true);
                        }
                        break;
                     case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_EQUIPEMENT:
                        this.moveTutorialUiLeft();
                        if(displayArrow)
                        {
                           Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_SHORT);
                           Api.highlight.highlightUi(UIEnum.STORAGE_UI,"grid",0,0,5,true);
                        }
                        break;
                     case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__SHOW_EQUIPEMENT_TARGET:
                        this.moveTutorialUiLeft();
                        if(displayArrow && _dropItem)
                        {
                           superTypeId = this.getItemSuperType(_dropItem);
                           positions = Api.storage.itemSuperTypeToServerPosition(superTypeId);
                           if(positions[0] != null)
                           {
                              Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_SHORT);
                              Api.highlight.highlightUi(UIEnum.STORAGE_UI,"slot_" + positions[0],5,0,5,true);
                           }
                        }
                        break;
                     case TutorialConstants.TUTORIAL_SUB_STEP_EQUIP_ALL_ITEMS__CLOSE_CHARACTER_SHEET:
                        this.moveTutorialUiLeft();
                        if(displayArrow)
                        {
                           Api.highlight.highlightUi(UIEnum.STORAGE_UI,"btn_close",7,0,5,true);
                        }
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_FIND_BOSS:
                  wp = Api.player.currentMap();
                  if(subStep == TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__SHOW_TRANSITION && wp.mapId == TutorialConstants.TUTORIAL_MAP_ID_THIRD_BEFORE_FIGHT)
                  {
                     subStep = TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__SHOW_BOSS;
                  }
                  switch(subStep)
                  {
                     case TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__SHOW_TRANSITION:
                        if(wp.mapId == TutorialConstants.TUTORIAL_MAP_ID_SECOND_AFTER_FIGHT)
                        {
                           if(displayArrow)
                           {
                              Api.roleplay.playEntityAnimation(TutorialConstants.TUTORIAL_PNJ_ID,"AnimAttaque8");
                              Api.highlight.setDisplayDelay(DELAY_BEFORE_HIGHLIGHT_LONG);
                              Api.highlight.highlightMapTransition(TutorialConstants.TUTORIAL_MAP_ID_SECOND_AFTER_FIGHT,TutorialConstants.FIND_BOSS_TRANSITION_ORIENTATION,TutorialConstants.FIND_BOSS_TRANSITION_POSITION,false,0,true);
                           }
                        }
                        break;
                     case TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__LOADING_MAP:
                        break;
                     case TutorialConstants.TUTORIAL_SUB_STEP_FIND_BOSS__SHOW_BOSS:
                        if(wp.mapId == TutorialConstants.TUTORIAL_MAP_ID_THIRD_BEFORE_FIGHT)
                        {
                           if(displayArrow)
                           {
                              Api.roleplay.playEntityAnimation(TutorialConstants.TUTORIAL_PNJ_ID,"AnimAttaque7");
                              Api.highlight.highlightMonster(TutorialConstants.TUTORIAL_MONSTER_ID_BOSS,true);
                           }
                        }
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_KILL_BOSS:
                  if(displayArrow)
                  {
                     Api.highlight.forceArrowPosition("banner","tx_timeFrame",new Point(640,880));
                  }
                  break;
               case TutorialConstants.TUTORIAL_STEP_SUCCESS_QUEST:
                  switch(subStep)
                  {
                     case TutorialConstants.TUTORIAL_SUB_STEP_SUCCESS_QUEST__LOADING_MAP:
                        break;
                     case TutorialConstants.TUTORIAL_SUB_STEP_SUCCESS_QUEST__CLOSE_FIGHT_RESULT:
                        if(displayArrow)
                        {
                           Api.highlight.highlightUi(UIEnum.FIGHT_RESULT_SIMPLE,"btn_close",7,0,5,true);
                        }
                        break;
                     case TutorialConstants.TUTORIAL_SUB_STEP_SUCCESS_QUEST__SHOW_NPC:
                        if(displayArrow)
                        {
                           Api.roleplay.playEntityAnimation(TutorialConstants.TUTORIAL_PNJ_ID,"AnimAttaque5");
                           Api.highlight.highlightNpc(TutorialConstants.TUTORIAL_PNJ_ID,true);
                        }
                        break;
                     case TutorialConstants.TUTORIAL_SUB_STEP_SUCCESS_QUEST__SHOW_RESPONSE:
                        if(displayArrow)
                        {
                           Api.roleplay.playEntityAnimation(TutorialConstants.TUTORIAL_PNJ_ID,"AnimAttaque7");
                        }
                  }
            }
         }
         Api.system.dispatchHook(HookList.TutorialStep,this._currentStepNumber);
      }
      
      public function redoSteps() : void
      {
         var max:uint = 0;
         Api.modMenu.setBehavior("tutorial");
         if(this._currentStepNumber != -1)
         {
            max = this._currentStepNumber;
            this._currentStepNumber = 0;
            this.jumpToStep(max);
         }
      }
      
      public function jumpToStep(stepNumber:uint) : void
      {
         if(this._currentStepNumber == -1)
         {
            this._currentStepNumber = 0;
         }
         for(var i:uint = this._currentStepNumber; i <= stepNumber; i++)
         {
            this.prepareStep(i,0,i == stepNumber);
         }
      }
      
      private function moveTutorialUiDefault() : void
      {
         var tutorialUi:UiRootContainer = Api.ui.getUi(UIEnum.TUTORIAL_UI);
         if(tutorialUi)
         {
            tutorialUi.uiClass.moveDefault();
         }
      }
      
      private function moveTutorialUiLeft() : void
      {
         var tutorialUi:UiRootContainer = Api.ui.getUi(UIEnum.TUTORIAL_UI);
         if(tutorialUi)
         {
            tutorialUi.uiClass.moveLeft();
         }
      }
      
      private function validateCurrentStep() : void
      {
         var obj:uint = 0;
         if(this._currentStepNumber != -1)
         {
            for each(obj in this._quest.steps[this._currentStepNumber - 1].objectiveIds)
            {
               Api.system.sendAction(new QuestObjectiveValidationAction([this._quest.id,obj]));
            }
         }
      }
      
      private function refreshStep(subStep:uint) : void
      {
         if(this._currentStepNumber != -1)
         {
            this.prepareStep(this._currentStepNumber,subStep,true);
         }
      }
      
      private function setComponentsDisabled(components:Object, disabled:Boolean) : void
      {
         var component:Object = null;
         for each(component in components)
         {
            if(component && component.hasOwnProperty("disabled"))
            {
               component.disabled = disabled;
            }
         }
         if(components === _watchedComponents)
         {
            this._bannerMenuUiClass.setDisabledBtns(disabled);
         }
      }
      
      private function checkComponents(components:Object) : void
      {
         var component:* = null;
         for(component in components)
         {
            if(components[component] == null)
            {
               throw new Error("Unable to find component : " + component);
            }
         }
      }
      
      private function setWatchedElementsDisabled(disabled:Boolean) : void
      {
         Api.modMenu.getMenuMaker("world").maker.disabled = disabled;
         Api.modMenu.getMenuMaker("player").maker.disabled = disabled;
         Api.modMenu.getMenuMaker("npc").maker.disabled = disabled;
         this.setComponentsDisabled(_watchedComponents,disabled);
         this.setShortcutsDisabled(disabled);
      }
      
      private function setFightWatchedElementsDisabled(disabled:Boolean) : void
      {
         this.setComponentsDisabled(_fightWatchedComponents,disabled);
      }
      
      private function setShortcutsDisabled(disabled:Boolean) : void
      {
         var s:* = null;
         for(s in _disabledShortcuts)
         {
            this.setShortcutDisabled(s,disabled);
         }
      }
      
      private function setShortcutDisabled(s:String, disabled:Boolean) : void
      {
         var bind:Bind = Api.binds.getShortcutBind(s,true);
         if(bind)
         {
            Api.binds.setBindDisabled(bind,disabled);
            _disabledShortcuts[s] = disabled;
         }
      }
      
      private function getItemSuperType(item:Object) : uint
      {
         var cat:int = 0;
         var type:ItemType = null;
         if(item.isLivingObject || item.isWrapperObject)
         {
            cat = 0;
            if(item.isLivingObject)
            {
               cat = item.livingObjectCategory;
            }
            else
            {
               cat = item.wrapperObjectCategory;
            }
            type = Api.data.getItemType(cat);
            if(type)
            {
               return type.superTypeId;
            }
            return 0;
         }
         if(item is ItemWrapper)
         {
            return (item as ItemWrapper).type.superTypeId;
         }
         if(item is ShortcutWrapper)
         {
            if((item as ShortcutWrapper).type == 0)
            {
               return ((item as ShortcutWrapper).realItem as ItemWrapper).type.superTypeId;
            }
         }
         return 0;
      }
   }
}
