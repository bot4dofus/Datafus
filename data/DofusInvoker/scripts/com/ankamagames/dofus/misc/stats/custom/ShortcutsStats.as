package com.ankamagames.dofus.misc.stats.custom
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.berilia.managers.BindsManager;
   import com.ankamagames.berilia.types.listener.GenericListener;
   import com.ankamagames.berilia.types.messages.AllModulesLoadedMessage;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.actions.ChangeCharacterAction;
   import com.ankamagames.dofus.logic.common.actions.ChangeServerAction;
   import com.ankamagames.dofus.logic.common.actions.ResetGameAction;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.actions.OpenIdolsAction;
   import com.ankamagames.dofus.logic.game.common.actions.humanVendor.ExchangeRequestOnShopStockAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountToggleRidingRequestAction;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightSpellCastAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ShowAllNamesAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleDematerializationAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleEntityIconsAction;
   import com.ankamagames.dofus.logic.game.fight.frames.FightSpellCastFrame;
   import com.ankamagames.dofus.logic.game.roleplay.actions.HighlightInteractiveElementsAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShowEntitiesTooltipsAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShowFightPositionsAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagEnterAction;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.stats.IHookStats;
   import com.ankamagames.dofus.misc.stats.IStatsClass;
   import com.ankamagames.dofus.misc.stats.InternalStatisticTypeEnum;
   import com.ankamagames.dofus.misc.stats.StatsAction;
   import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import flash.events.Event;
   import flash.utils.Dictionary;
   
   public class ShortcutsStats implements IHookStats, IStatsClass
   {
      
      public static const SHORTCUTS:Object = {
         "openCharacterSheet":"characterSheetUi",
         "openBookSpell":"spellBase",
         "openInventory":"storage",
         "openBookQuest":"questBase",
         "openWorldMap":"cartographyUi",
         "openSocialFriends":"socialBase",
         "openSocialGuild":"socialBase",
         "openSocialAlliance":"socialBase",
         "fake_0":"subSocialUi",
         "openSocialSpouse":"spouse",
         "openPvpArena":"pvpArena",
         "openWebBrowser":"webBase",
         "openBookJob":"jobTab",
         "openMount":"mountInfo",
         "toggleRide":null,
         "openSell":null,
         "openAlmanax":"questBase",
         "openAchievement":"questBase",
         "fake_1":"subQuestUi",
         "openTitle":"titleTab",
         "openBestiary":"encyclopediaBase",
         "openIdols":null,
         "openBookAlignment":"alignmentTab",
         "openHavenbag":null,
         "openBuild":"characterBuildsUi",
         "shiftCloseUi":null,
         "showTheoreticalEffects":null,
         "optionMenu1":"optionContainer",
         "showGrid":null,
         "transparancyMode":null,
         "foldAll":null,
         "showCoord":null,
         "toggleDematerialization":null,
         "cellSelectionOnly":null,
         "showAllNames":null,
         "showEntitiesTooltips":null,
         "highlightInteractiveElements":null,
         "showFightPositions":null,
         "toggleShowUI":null,
         "toggleEntityIcons":null,
         "useSpellLine1":null,
         "useSpellLine2":null,
         "openBreach":null,
         "openGuidebook":"guidebook",
         "openCompanions":"companionTab"
      };
       
      
      private var _usedShortcuts:Dictionary;
      
      private var _shortcutsData:Dictionary;
      
      private var _action:StatsAction;
      
      private var _shortcutsList:Object;
      
      private var _keyboardShortcut:String = null;
      
      public function ShortcutsStats(pArgs:Array)
      {
         this._usedShortcuts = new Dictionary();
         this._shortcutsData = new Dictionary();
         this._shortcutsList = {};
         super();
         Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         Dofus.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
      }
      
      private static function getShortcutFromBookTabName(tabName:String) : String
      {
         switch(tabName)
         {
            case "achievementTab":
               return "openAchievement";
            case "questTab":
               return "openBookQuest";
            case "calendarTab":
               return "openAlmanax";
            default:
               return null;
         }
      }
      
      private static function getShortcutFromSocialTabName(tabName:String) : String
      {
         var tab:int = -1;
         switch(tabName)
         {
            case "friends":
               tab = 0;
               break;
            case "guild":
               tab = 1;
               break;
            case "alliance":
               tab = 2;
         }
         return getShortcutFromSocialTab(tab);
      }
      
      private static function getShortcutFromSocialTab(tab:uint) : String
      {
         switch(tab)
         {
            case 0:
               return "openSocialFriends";
            case 1:
               return "openSocialGuild";
            case 2:
               return "openSocialAlliance";
            default:
               return null;
         }
      }
      
      public function onHook(pHook:String, pArgs:Array) : void
      {
         var shortcutName:* = null;
         var shortcut:String = null;
         if(pHook == CustomUiHookList.ShowTheoreticalEffects)
         {
            this._keyboardShortcut = "showTheoreticalEffects";
            this.onNoUiShortcut(this._keyboardShortcut);
         }
         else if(pHook == CustomUiHookList.FoldAll)
         {
            this._keyboardShortcut = "foldAll";
            this.onNoUiShortcut(this._keyboardShortcut);
         }
         else if(pHook == BeriliaHookList.UiLoading)
         {
            for(shortcutName in SHORTCUTS)
            {
               if(pArgs[0] == SHORTCUTS[shortcutName] && !this._usedShortcuts[shortcutName])
               {
                  shortcut = shortcutName;
                  switch(pArgs[0])
                  {
                     case "storage":
                        if(pArgs[2].storageMod != "bag")
                        {
                           shortcut = null;
                        }
                        break;
                     case "socialBase":
                        shortcut = this._keyboardShortcut != null ? this._keyboardShortcut : (!!pArgs[2].hasOwnProperty("tab") ? getShortcutFromSocialTab(pArgs[2].tab) : null);
                        break;
                     case "subSocialUi":
                        shortcut = getShortcutFromSocialTabName(pArgs[1]);
                        break;
                     case "questBase":
                        shortcut = this._keyboardShortcut != null ? this._keyboardShortcut : getShortcutFromBookTabName(pArgs[2].tab);
                        break;
                     case "subQuestUi":
                        shortcut = getShortcutFromBookTabName(pArgs[1]);
                  }
                  if(shortcut != null)
                  {
                     this.onShortcut(shortcut);
                  }
                  break;
               }
            }
         }
         else if(pHook == BeriliaHookList.UiUnloaded)
         {
            if(pArgs[0].indexOf("_pin@") != -1)
            {
               this.onNoUiShortcut("shiftCloseUi");
            }
            else
            {
               for(shortcutName in SHORTCUTS)
               {
                  if(pArgs[0] == SHORTCUTS[shortcutName])
                  {
                     this._usedShortcuts[shortcutName] = false;
                  }
               }
            }
         }
      }
      
      public function process(pMessage:Message, pArgs:Array = null) : void
      {
         var gfsca:GameFightSpellCastAction = null;
         var fscf:FightSpellCastFrame = null;
         if(pMessage is AllModulesLoadedMessage)
         {
            BindsManager.getInstance().registerEvent(new GenericListener("ALL",EnterFrameConst.SHORTCUTS_STATS,this.listener,int.MAX_VALUE));
            EnterFrameDispatcher.addEventListener(this.onEnterFrame,EnterFrameConst.SHORTCUTS_STATS);
         }
         else if(pMessage is MountToggleRidingRequestAction)
         {
            if(MountToggleRidingRequestAction(pMessage).isToggle)
            {
               this.onNoUiShortcut("toggleRide");
            }
         }
         else if(pMessage is ExchangeRequestOnShopStockAction)
         {
            this.onNoUiShortcut("openSell");
         }
         else if(pMessage is OpenIdolsAction)
         {
            this.onNoUiShortcut("openIdols");
         }
         else if(pMessage is HavenbagEnterAction)
         {
            this.onToggleShortcut("openHavenbag");
         }
         else if(pMessage is ToggleDematerializationAction)
         {
            this.onNoUiShortcut("toggleDematerialization");
         }
         else if(pMessage is ShowAllNamesAction)
         {
            this.onNoUiShortcut("showAllNames");
         }
         else if(pMessage is ToggleEntityIconsAction)
         {
            this.onToggleShortcut("toggleEntityIcons");
         }
         else if(pMessage is ShowEntitiesTooltipsAction)
         {
            this.onToggleShortcut("showEntitiesTooltips");
         }
         else if(pMessage is HighlightInteractiveElementsAction)
         {
            this.onToggleShortcut("highlightInteractiveElements");
         }
         else if(pMessage is ShowFightPositionsAction)
         {
            this.onToggleShortcut("showFightPositions");
         }
         else if(pMessage is GameFightSpellCastAction)
         {
            gfsca = GameFightSpellCastAction(pMessage);
            if(gfsca.slot != -1)
            {
               fscf = Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame;
               if(fscf == null || fscf.spellId != gfsca.spellId)
               {
                  this.onNoUiShortcut(this.getShortcutFromSpellSlot(gfsca.slot));
               }
            }
         }
         else if(this._action != null && (pMessage is ChangeCharacterAction || pMessage is ChangeServerAction || pMessage is ResetGameAction))
         {
            this._action.sendOnExit = false;
            this._action.send();
         }
      }
      
      private function getShortcutFromSpellSlot(slot:uint) : String
      {
         return "useSpellLine" + (slot <= 10 ? "1" : "2");
      }
      
      private function onPropertyChanged(e:PropertyChangeEvent) : void
      {
         if(e.propertyName == "alwaysShowGrid")
         {
            this.onNoUiShortcut("showGrid");
         }
         else if(e.propertyName == "transparentOverlayMode")
         {
            this.onNoUiShortcut("transparancyMode");
         }
         else if(e.propertyName == "mapCoordinates")
         {
            this.onNoUiShortcut("showCoord");
         }
         else if(e.propertyName == "cellSelectionOnly")
         {
            this.onNoUiShortcut("cellSelectionOnly");
         }
      }
      
      private function onToggleShortcut(shortcutName:String) : void
      {
         if(this._usedShortcuts[shortcutName])
         {
            this._usedShortcuts[shortcutName] = false;
         }
         else
         {
            this.onShortcut(shortcutName);
         }
      }
      
      private function onNoUiShortcut(shortcutName:String) : void
      {
         this.onShortcut(shortcutName);
         this._usedShortcuts[shortcutName] = false;
      }
      
      private function listener(shortcutName:String) : Boolean
      {
         if(shortcutName.search(/^s\d{1,2}$/g) != -1)
         {
            shortcutName = this.getShortcutFromSpellSlot(parseInt(shortcutName.substr(1)));
         }
         if(!SHORTCUTS.hasOwnProperty(shortcutName))
         {
            return false;
         }
         this._keyboardShortcut = shortcutName;
         return false;
      }
      
      private function onEnterFrame(event:Event) : void
      {
         this._keyboardShortcut = null;
      }
      
      public function remove() : void
      {
         Atouin.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         Dofus.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
      }
      
      private function onShortcut(pShortcutName:String) : void
      {
         if(!this._usedShortcuts[pShortcutName] && SHORTCUTS.hasOwnProperty(pShortcutName))
         {
            if(!this._shortcutsData[pShortcutName])
            {
               this._shortcutsData[pShortcutName] = {
                  "numfromShortcut":0,
                  "numfromUi":0
               };
               this._shortcutsList[pShortcutName] = {};
               this._shortcutsList[pShortcutName]["use"] = 0;
               this._shortcutsList[pShortcutName]["ratio"] = 0;
            }
            if(this._keyboardShortcut == pShortcutName)
            {
               ++this._shortcutsData[pShortcutName].numfromShortcut;
            }
            else
            {
               ++this._shortcutsData[pShortcutName].numfromUi;
            }
            this._keyboardShortcut = null;
            this._shortcutsList[pShortcutName]["use"] = this._shortcutsData[pShortcutName].numfromShortcut + this._shortcutsData[pShortcutName].numfromUi;
            this._shortcutsList[pShortcutName]["ratio"] = this._shortcutsData[pShortcutName].numfromShortcut / this._shortcutsList[pShortcutName]["use"];
            this._usedShortcuts[pShortcutName] = true;
            if(!this._action)
            {
               this._action = new StatsAction(InternalStatisticTypeEnum.USE_SHORTCUT,false,false,false,true);
               this._action.gameSessionId = HaapiKeyManager.getInstance().getGameSessionId();
               this._action.setParam("account_id",PlayerManager.getInstance().accountId);
               this._action.setParam("character_id",PlayedCharacterManager.getInstance().extractedServerCharacterIdFromInterserverCharacterId);
               this._action.setParam("character_level",PlayedCharacterManager.getInstance().infos.level);
               this._action.setParam("keyboard",BindsManager.getInstance().currentLocale);
               this._action.setParam("shortcuts_list",this._shortcutsList);
               this._action.send();
            }
         }
      }
   }
}
