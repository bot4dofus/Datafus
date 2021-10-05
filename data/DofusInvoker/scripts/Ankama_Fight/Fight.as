package Ankama_Fight
{
   import Ankama_Common.Common;
   import Ankama_ContextMenu.ContextMenu;
   import Ankama_Fight.ui.Buffs;
   import Ankama_Fight.ui.ChallengeDisplay;
   import Ankama_Fight.ui.FightIdols;
   import Ankama_Fight.ui.FightResult;
   import Ankama_Fight.ui.FightResultSimple;
   import Ankama_Fight.ui.FighterInfo;
   import Ankama_Fight.ui.SpectatorPanel;
   import Ankama_Fight.ui.SwapPositionIcon;
   import Ankama_Fight.ui.Timeline;
   import Ankama_Fight.ui.TurnStart;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightPlacementSwapPositionsAcceptAction;
   import com.ankamagames.dofus.logic.game.fight.actions.GameFightPlacementSwapPositionsCancelAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleEntityIconsAction;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.types.game.idol.Idol;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.FightApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   
   public class Fight extends Sprite
   {
      
      private static var _newLevel:int;
       
      
      protected var timeline:Timeline;
      
      protected var buffs:Buffs;
      
      protected var fightResult:FightResult;
      
      protected var fightResultSimple:FightResultSimple;
      
      protected var turnStart:TurnStart;
      
      protected var fighterInfo:FighterInfo;
      
      protected var challengeDisplay:ChallengeDisplay;
      
      protected var spectatorPanel:SpectatorPanel;
      
      protected var swapPositionIconUi:SwapPositionIcon;
      
      protected var fightIdols:FightIdols;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="FightApi")]
      public var fightApi:FightApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      private var _currentBuffsOwnerId:Number;
      
      private var _currentFightStartDate:Number = 0;
      
      private var _currentFightAttackersName:String = "";
      
      private var _currentFightDefendersName:String = "";
      
      private var _afkPopup:String;
      
      private var _preparationPhase:Boolean;
      
      private var _killCount:uint = 0;
      
      public function Fight()
      {
         super();
      }
      
      public static function get newLevel() : int
      {
         return _newLevel;
      }
      
      public function main() : void
      {
         Api.sysApi = this.sysApi;
         Api.uiApi = this.uiApi;
         Api.fightApi = this.fightApi;
         Api.dataApi = this.dataApi;
         Api.configApi = this.configApi;
         Api.chatApi = this.chatApi;
         Api.playerApi = this.playerApi;
         _newLevel = -1;
         this.sysApi.addHook(HookList.GameFightEnd,this.onGameFightEnd);
         this.sysApi.addHook(FightHookList.OpenFightResults,this.onOpenFightResults);
         this.sysApi.addHook(HookList.GameFightStarting,this.onGameFightStarting);
         this.sysApi.addHook(HookList.GameFightStart,this.onGameFightStart);
         this.sysApi.addHook(FightHookList.SpectateUpdate,this.onSpectateUpdate);
         this.sysApi.addHook(HookList.FightersListUpdated,this.onFightersListUpdated);
         this.sysApi.addHook(HookList.FightText,this.onFightText);
         this.sysApi.addHook(FightHookList.FighterSelected,this.onOpenBuffs);
         this.sysApi.addHook(HookList.GameFightTurnStart,this.onTurnStart);
         this.sysApi.addHook(HookList.CharacterLevelUp,this.onCharacterLevelUp);
         this.sysApi.addHook(FightHookList.SpectatorWantLeave,this.onSpectatorWantLeave);
         this.sysApi.addHook(FightHookList.AfkModeChanged,this.onAfkModeChanged);
         this.sysApi.addHook(FightHookList.ChallengeInfoUpdate,this.onChallengeInfoUpdate);
         this.sysApi.addHook(FightHookList.ShowSwapPositionRequestMenu,this.onShowSwapPositionRequestMenu);
         this.sysApi.addHook(FightHookList.IdolFightPreparationUpdate,this.onIdolFightPreparationUpdate);
         this.sysApi.addHook(FightHookList.FightIdolList,this.onFightIdolList);
         this.uiApi.addShortcutHook("toggleEntityIcons",this.onShortcut);
      }
      
      public function onShortcut(shortcut:String) : Boolean
      {
         if(shortcut === "toggleEntityIcons")
         {
            this.sysApi.sendAction(new ToggleEntityIconsAction([!this.sysApi.getOption("toggleEntityIcons","dofus")]));
            return true;
         }
         return false;
      }
      
      public function unload() : void
      {
      }
      
      private function onTurnStart(fighterId:Number, waitingTime:uint, remainingTime:uint, picture:Boolean) : void
      {
         var turnStartUi:Object = null;
         this._killCount = 0;
         if(picture)
         {
            turnStartUi = this.uiApi.getUi("turnStart");
            if(turnStartUi)
            {
               turnStartUi.uiClass.restart(fighterId,waitingTime);
            }
            else
            {
               this.uiApi.loadUi("turnStart","turnStart",{
                  "fighterId":fighterId,
                  "waitingTime":waitingTime
               });
            }
         }
         else if(this.uiApi.getUi("turnStart"))
         {
            this.uiApi.unloadUi("turnStart");
         }
      }
      
      private function onFightersListUpdated() : void
      {
         var currentOrientation:uint = 0;
         var uiName:String = null;
         if(!this.uiApi.getUi("timeline"))
         {
            currentOrientation = this.sysApi.getData("timelineOrientation",DataStoreEnum.BIND_ACCOUNT);
            uiName = currentOrientation == 0 ? "timeline" : "timelineVertical";
            this.uiApi.loadUi(uiName,"timeline");
         }
      }
      
      private function onGameFightEnd(resultsKey:String) : void
      {
         this.uiApi.unloadUi("timeline");
         this.uiApi.unloadUi("fighterInfo");
         if(this.uiApi.getUi("buffs"))
         {
            this.uiApi.unloadUi("buffs");
         }
         this.onOpenFightResults(resultsKey);
         if(this.uiApi.getUi("turnStart"))
         {
            this.uiApi.unloadUi("turnStart");
         }
         if(this.uiApi.getUi("challengeDisplay"))
         {
            this.uiApi.unloadUi("challengeDisplay");
         }
         if(this.uiApi.getUi("fightIdols"))
         {
            this.uiApi.unloadUi("fightIdols");
         }
         if(this._afkPopup)
         {
            this.uiApi.unloadUi(this._afkPopup);
            this._afkPopup = null;
         }
         this._preparationPhase = false;
         this._currentFightStartDate = 0;
         this._currentFightAttackersName = "";
         this._currentFightDefendersName = "";
      }
      
      private function onOpenFightResults(resultsKey:String) : void
      {
         var useFightResultSimple:Boolean = false;
         var pResultsRecap:Object = FightContextFrame.getResults(resultsKey);
         if(pResultsRecap !== null && pResultsRecap.results.length > 0)
         {
            useFightResultSimple = this.sysApi.getSetData("useFightResultSimple",true,DataStoreEnum.BIND_ACCOUNT);
            if(useFightResultSimple && !pResultsRecap.isSpectator)
            {
               if(this.uiApi.getUi("fightResultSimple"))
               {
                  this.uiApi.unloadUi("fightResultSimple");
               }
               else
               {
                  this.uiApi.loadUi("fightResultSimple","fightResultSimple",pResultsRecap);
               }
            }
            else if(this.uiApi.getUi("fightResult"))
            {
               this.uiApi.unloadUi("fightResult");
            }
            else
            {
               this.uiApi.loadUi("fightResult","fightResult",pResultsRecap);
            }
         }
      }
      
      private function onFightText(pEvtName:String, pParams:Object, pTargets:Object, pTargetsTeam:String = "", forcedDetailedLog:Boolean = false) : void
      {
         try
         {
            FightTexts.event(pEvtName,pParams,this.sysApi.getBuildType(),pTargets,pTargetsTeam,forcedDetailedLog);
         }
         catch(e:Error)
         {
         }
      }
      
      private function onOpenBuffs(targetId:Number) : void
      {
         var currentOrientation:uint = 0;
         var uiName:String = null;
         var timelineUi:UiRootContainer = this.uiApi.getUi("timeline");
         if(!this.uiApi.getUi("buffs"))
         {
            currentOrientation = this.sysApi.getData("timelineOrientation",DataStoreEnum.BIND_ACCOUNT);
            uiName = currentOrientation == 0 ? "buffs" : "buffsVertical";
            this._currentBuffsOwnerId = targetId;
            this.uiApi.loadUiInside(uiName,timelineUi.uiClass.ctr_buffs,"buffs",targetId);
         }
         else if(this._currentBuffsOwnerId == targetId)
         {
            this.uiApi.unloadUi("buffs");
         }
         else
         {
            currentOrientation = this.sysApi.getData("timelineOrientation",DataStoreEnum.BIND_ACCOUNT);
            uiName = currentOrientation == 0 ? "buffs" : "buffsVertical";
            this._currentBuffsOwnerId = targetId;
            this.uiApi.unloadUi("buffs");
            this.uiApi.loadUiInside(uiName,timelineUi.uiClass.ctr_buffs,"buffs",targetId);
         }
      }
      
      private function onCharacterLevelUp(pOldLevel:uint, pNewLevel:uint, pCaracPointEarned:uint, pHealPointEarned:uint, newSpellWrappers:Array) : void
      {
         _newLevel = pNewLevel;
      }
      
      private function onSpectatorWantLeave() : void
      {
         this.uiApi.unloadUi("timeline");
         this.uiApi.unloadUi("fighterInfo");
         if(this.uiApi.getUi("buffs"))
         {
            this.uiApi.unloadUi("buffs");
         }
         if(this.uiApi.getUi("turnStart"))
         {
            this.uiApi.unloadUi("turnStart");
         }
         if(this.uiApi.getUi("challengeDisplay"))
         {
            this.uiApi.unloadUi("challengeDisplay");
         }
         if(this.uiApi.getUi("spectatorPanel"))
         {
            this.uiApi.unloadUi("spectatorPanel");
         }
         if(this.uiApi.getUi("fightIdols"))
         {
            this.uiApi.unloadUi("fightIdols");
         }
         this._currentFightStartDate = 0;
         this._currentFightAttackersName = "";
         this._currentFightDefendersName = "";
      }
      
      private function onSpectateUpdate(fightStartTime:Number, attackersName:String = "", defendersName:String = "") : void
      {
         if(fightStartTime > 0)
         {
            this._currentFightStartDate = fightStartTime;
         }
         if(attackersName != "")
         {
            this._currentFightAttackersName = attackersName;
         }
         if(defendersName != "")
         {
            this._currentFightDefendersName = defendersName;
         }
         var uiCtr:* = this.uiApi.getUi("banner");
         if(uiCtr && !this.uiApi.getUi("spectatorPanel"))
         {
            this.uiApi.loadUiInside("spectatorPanel",uiCtr.uiClass.spectatorUiCtr,"spectatorPanel",[this._currentFightStartDate,this._currentFightAttackersName,this._currentFightDefendersName]);
         }
      }
      
      private function onGameFightStarting(... params) : void
      {
         var currentOrientation:uint = 0;
         var uiName:String = null;
         FightTexts.cacheFighterName = new Dictionary();
         this._preparationPhase = true;
         this.uiApi.unloadUi("fightResult");
         this.uiApi.unloadUi("fightResultSimple");
         if(!this.uiApi.getUi("timeline"))
         {
            currentOrientation = this.sysApi.getData("timelineOrientation",DataStoreEnum.BIND_ACCOUNT);
            uiName = currentOrientation == 0 ? "timeline" : "timelineVertical";
            this.uiApi.loadUi(uiName,"timeline");
         }
         var uiCtr:* = this.uiApi.getUi("banner");
         if(uiCtr && !this.uiApi.getUi("fighterInfo"))
         {
            this.uiApi.loadUiInside("fighterInfo",uiCtr.uiClass.subUiCtr);
         }
      }
      
      private function onGameFightStart(... params) : void
      {
         this._preparationPhase = false;
      }
      
      private function onAfkModeChanged(enabled:Boolean) : void
      {
         var context:FightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         if(context && context.isKolossium)
         {
            return;
         }
         if(enabled && !this._afkPopup)
         {
            this._afkPopup = this.modCommon.openPopup(this.uiApi.getText("ui.fight.inactivityTitle"),this.uiApi.getText("ui.fight.inactivityMessage"),[this.uiApi.getText("ui.common.ok")],[this.onQuitAfk],this.onQuitAfk,this.onQuitAfk);
         }
      }
      
      private function onQuitAfk() : void
      {
         this._afkPopup = null;
      }
      
      public function onChallengeInfoUpdate(challenges:Object) : void
      {
         if(!this.uiApi.getUi("challengeDisplay"))
         {
            this.uiApi.loadUi("challengeDisplay","challengeDisplay",{"challenges":challenges});
         }
      }
      
      private function onShowSwapPositionRequestMenu(pRequestId:uint, pIsRequester:Boolean) : void
      {
         var contextMenu:Array = [];
         contextMenu.push(this.modContextMenu.createContextMenuTitleObject(this.uiApi.getText("ui.companion.switchPlaces")));
         if(pIsRequester)
         {
            contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.common.accept"),this.onAccept,[pRequestId]));
         }
         contextMenu.push(this.modContextMenu.createContextMenuItemObject(!!pIsRequester ? this.uiApi.getText("ui.common.refuse") : this.uiApi.getText("ui.common.cancel"),this.onRefuse,[pRequestId]));
         this.modContextMenu.createContextMenu(contextMenu,null,null,"swapPositionMenu");
      }
      
      private function onAccept(pRequestId:uint) : void
      {
         this.sysApi.sendAction(new GameFightPlacementSwapPositionsAcceptAction([pRequestId]));
      }
      
      private function onRefuse(pRequestId:uint) : void
      {
         this.sysApi.sendAction(new GameFightPlacementSwapPositionsCancelAction([pRequestId]));
      }
      
      private function onIdolFightPreparationUpdate(leader:Number, idols:Object) : void
      {
         if(!this.uiApi.getUi("fightIdols"))
         {
            this.uiApi.loadUi("fightIdols","fightIdols",[leader,idols,false]);
         }
      }
      
      private function onFightIdolList(idols:Vector.<Idol>) : void
      {
         if(!this.uiApi.getUi("fightIdols"))
         {
            this.uiApi.loadUi("fightIdols","fightIdols",[-1,idols,true]);
         }
      }
   }
}
