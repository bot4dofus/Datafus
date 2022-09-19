package Ankama_Party.ui
{
   import Ankama_Grimoire.enum.EnumTab;
   import Ankama_Grimoire.enum.GameGuideArticlesEnum;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.ProgressBar;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.arena.ArenaRankInfosWrapper;
   import com.ankamagames.dofus.internalDatacenter.people.PartyMemberWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.kernel.sound.enum.UISoundEnum;
   import com.ankamagames.dofus.logic.game.common.actions.OpenGuidebookAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenSocialAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.ArenaRegisterAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.ArenaUnregisterAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.network.enums.PvpArenaStepEnum;
   import com.ankamagames.dofus.network.enums.PvpArenaTypeEnum;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.PartyApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.PopupApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.utils.Dictionary;
   
   public class PvpArena
   {
      
      private static const FULL_ARENA_TEAM:int = 3;
      
      private static const MAX_LEAGUE_POINTS:int = 100;
      
      private static const POPUP_KOLIZEUM_RULES:int = 33;
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="PartyApi")]
      public var partyApi:PartyApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="PopupApi")]
      public var popupApi:PopupApi;
      
      private var _currentFightMode:uint = 3;
      
      private var _isRegistered:Boolean;
      
      private var _currentStatus:int;
      
      private var _nbFightersReady:int = 0;
      
      private var _currentPartySize:int;
      
      private var _partyIsValid:Boolean;
      
      private var _dailyVictoryResetTime:Date;
      
      public var btn_help:ButtonContainer;
      
      public var lbl_whatToDo:Label;
      
      public var lbl_3v3SoloTitle:Label;
      
      public var lbl_3v3TeamTitle:Label;
      
      public var lbl_1v1Title:Label;
      
      public var btn_3v3SoloQueue:ButtonContainer;
      
      public var btn_lbl_btn_3v3SoloQueue:Label;
      
      public var pb_3v3SoloLeaguePoint:ProgressBar;
      
      public var tx_3v3SoloLeagueIcon:Texture;
      
      public var lbl_3v3SoloLeagueName:Label;
      
      public var lbl_3v3SoloPointsToNextLeague:Label;
      
      public var lbl_3v3SoloPointsValue:Label;
      
      public var lbl_3v3SoloRankValue:Label;
      
      public var lbl_3v3SoloRank:Label;
      
      public var lbl_3v3SoloVictoryRatioValue:Label;
      
      public var lbl_3v3SoloVictoryRatio:Label;
      
      public var btn_3v3TeamQueue:ButtonContainer;
      
      public var btn_lbl_btn_3v3TeamQueue:Label;
      
      public var pb_3v3TeamleaguePoint:ProgressBar;
      
      public var tx_3v3TeamLeagueIcon:Texture;
      
      public var lbl_3v3TeamLeagueName:Label;
      
      public var lbl_3v3TeamPointsToNextLeague:Label;
      
      public var lbl_3v3TeamPointsValue:Label;
      
      public var lbl_3v3TeamRankValue:Label;
      
      public var lbl_3v3TeamRank:Label;
      
      public var lbl_3v3TeamVictoryRatioValue:Label;
      
      public var lbl_3v3TeamVictoryRatio:Label;
      
      public var btn_1v1Queue:ButtonContainer;
      
      public var btn_lbl_btn_1v1Queue:Label;
      
      public var lbl_1v1MatchToBeRanked:Label;
      
      public var lbl_1v1PointsValue:Label;
      
      public var lbl_1v1RankValue:Label;
      
      public var lbl_1v1Rank:Label;
      
      public var lbl_1v1VictoryRatioValue:Label;
      
      public var lbl_1v1VictoryRatio:Label;
      
      public var txt_1v1Help:Texture;
      
      public var ctr_statusIndicator:GraphicContainer;
      
      public var btn_findPartyMembers:ButtonContainer;
      
      public var lbl_ladderAccess:Label;
      
      public var lbl_rules:Label;
      
      public var btn_close:ButtonContainer;
      
      public function PvpArena()
      {
         super();
      }
      
      public function main(list:Array) : void
      {
         var readyMember:Number = NaN;
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         this.btn_1v1Queue.soundId = UISoundEnum.OK_BUTTON;
         this.btn_3v3SoloQueue.soundId = UISoundEnum.OK_BUTTON;
         this.btn_3v3TeamQueue.soundId = UISoundEnum.OK_BUTTON;
         this.btn_close.soundId = UISoundEnum.CANCEL_BUTTON;
         this.popupApi.showPopup(POPUP_KOLIZEUM_RULES);
         this.sysApi.addHook(RoleplayHookList.ArenaRegistrationStatusUpdate,this.onArenaRegistrationStatusUpdate);
         this.sysApi.addHook(RoleplayHookList.ArenaFighterStatusUpdate,this.onArenaFighterStatusUpdate);
         this.sysApi.addHook(RoleplayHookList.ArenaFightProposition,this.onArenaFightProposition);
         this.sysApi.addHook(RoleplayHookList.ArenaUpdateRank,this.onArenaUpdateRank);
         this.sysApi.addHook(HookList.PartyJoin,this.onPartyJoin);
         this.sysApi.addHook(HookList.PartyUpdate,this.onPartyUpdate);
         this.sysApi.addHook(HookList.PartyLeave,this.onPartyLeave);
         this.sysApi.addHook(HookList.PartyLeaderUpdate,this.onPartyLeaderUpdate);
         this.sysApi.addHook(HookList.PartyMemberUpdate,this.onPartyMemberUpdate);
         this.sysApi.addHook(HookList.PartyMemberRemove,this.onPartyMemberRemove);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addComponentHook(this.btn_help,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.lbl_ladderAccess,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.lbl_rules,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_3v3TeamQueue,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_3v3TeamQueue,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.ctr_statusIndicator,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ctr_statusIndicator,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_3v3SoloVictoryRatio,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_3v3SoloVictoryRatio,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_3v3TeamVictoryRatio,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_3v3TeamVictoryRatio,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_1v1VictoryRatio,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_1v1VictoryRatio,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.txt_1v1Help,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.txt_1v1Help,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_1v1Rank,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_1v1Rank,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_3v3TeamRank,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_3v3TeamRank,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_3v3SoloRank,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_3v3SoloRank,ComponentHookList.ON_ROLL_OUT);
         this._isRegistered = this.partyApi.isArenaRegistered();
         this._currentStatus = this.partyApi.getArenaCurrentStatus();
         this.lbl_3v3SoloTitle.text = this.uiApi.getText("ui.common.versus",3,3) + " - " + this.uiApi.getText("ui.chat.status.solo");
         this.lbl_3v3TeamTitle.text = this.uiApi.getText("ui.common.versus",3,3) + " - " + this.uiApi.getText("ui.common.party");
         this.lbl_1v1Title.text = this.uiApi.getText("ui.common.versus",1,1) + " - " + this.uiApi.getText("ui.common.pvpDuel");
         this._currentFightMode = this.sysApi.getData("arenaLastFightMode");
         var serverDailyVictoryReset:String = String(this.configApi.getServerConstant(8));
         var sDVRMinutes:String = serverDailyVictoryReset.substr(serverDailyVictoryReset.length - 2);
         var sDVRHours:String = serverDailyVictoryReset.substr(0,serverDailyVictoryReset.length - 2);
         var date:Date = new Date();
         date.setHours(Number(sDVRHours));
         date.setMinutes(Number(sDVRMinutes));
         this._dailyVictoryResetTime = new Date(this.timeApi.serverTimeToLocalTime(date));
         this.onArenaRegistrationStatusUpdate(this._isRegistered,this._currentStatus);
         this.updateFighters();
         var rankInfos:ArenaRankInfosWrapper = this.partyApi.getArenaRankSoloInfos();
         var rankGroupInfos:ArenaRankInfosWrapper = this.partyApi.getArenaRankGroupInfos();
         var rankDuelInfos:ArenaRankInfosWrapper = this.partyApi.getArenaRankDuelInfos();
         this.onArenaUpdateRank(rankInfos,rankGroupInfos,rankDuelInfos);
         for each(readyMember in this.partyApi.getArenaReadyPartyMemberIds())
         {
            this.onArenaFighterStatusUpdate(readyMember,true);
         }
      }
      
      public function unload() : void
      {
         this.uiApi.hideTooltip();
         this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
      }
      
      protected function getColorButtonByStatus(status:int) : String
      {
         switch(status)
         {
            case 3:
               return "green";
            case 0:
         }
         return "grey";
      }
      
      private function updateFighters() : void
      {
         var partyMembersBreedId:Dictionary = null;
         var fighter:PartyMemberWrapper = null;
         var partyMembers:Vector.<PartyMemberWrapper> = this.partyApi.getPartyMembers(1);
         this._partyIsValid = true;
         if(partyMembers.length <= 0)
         {
            this._currentPartySize = 1;
         }
         else
         {
            this._currentPartySize = 0;
            partyMembersBreedId = new Dictionary();
            for each(fighter in partyMembers)
            {
               if(partyMembersBreedId[fighter.breedId])
               {
                  this._partyIsValid = false;
               }
               partyMembersBreedId[fighter.breedId] = true;
               if(fighter.isMember)
               {
                  ++this._currentPartySize;
               }
            }
         }
         if(partyMembers.length > 0)
         {
            if(partyMembers.length == FULL_ARENA_TEAM && this._partyIsValid)
            {
               if(this.playerApi.id() != this.partyApi.getArenaLeader().id)
               {
                  this.btn_3v3TeamQueue.softDisabled = true;
               }
               else
               {
                  this.btn_3v3TeamQueue.softDisabled = false;
               }
            }
            else
            {
               this.btn_3v3TeamQueue.softDisabled = true;
            }
            this.btn_3v3SoloQueue.softDisabled = true;
            this.btn_1v1Queue.softDisabled = true;
         }
         else
         {
            this.btn_1v1Queue.softDisabled = false;
            this.btn_3v3SoloQueue.softDisabled = false;
            this.btn_3v3TeamQueue.softDisabled = true;
         }
      }
      
      private function getTextSuffix() : int
      {
         if(this._currentFightMode == PvpArenaTypeEnum.ARENA_TYPE_1VS1)
         {
            return PvpArenaTypeEnum.ARENA_TYPE_1VS1;
         }
         return PvpArenaTypeEnum.ARENA_TYPE_3VS3_TEAM;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_3v3TeamQueue:
               if(!this._isRegistered)
               {
                  this.sysApi.sendAction(new ArenaRegisterAction([PvpArenaTypeEnum.ARENA_TYPE_3VS3_TEAM,false]));
                  this._currentFightMode = PvpArenaTypeEnum.ARENA_TYPE_3VS3_TEAM;
                  this.sysApi.setData("arenaLastFightMode",this._currentFightMode);
               }
               else
               {
                  this.sysApi.sendAction(new ArenaUnregisterAction([]));
               }
               break;
            case this.btn_3v3SoloQueue:
               if(!this._isRegistered)
               {
                  this.sysApi.sendAction(new ArenaRegisterAction([PvpArenaTypeEnum.ARENA_TYPE_3VS3_SOLO,false]));
                  this._currentFightMode = PvpArenaTypeEnum.ARENA_TYPE_3VS3_SOLO;
                  this.sysApi.setData("arenaLastFightMode",this._currentFightMode);
               }
               else
               {
                  this.sysApi.sendAction(new ArenaUnregisterAction([]));
               }
               break;
            case this.btn_1v1Queue:
               if(!this._isRegistered)
               {
                  this.sysApi.sendAction(new ArenaRegisterAction([PvpArenaTypeEnum.ARENA_TYPE_1VS1,false]));
                  this._currentFightMode = PvpArenaTypeEnum.ARENA_TYPE_1VS1;
                  this.sysApi.setData("arenaLastFightMode",this._currentFightMode);
               }
               else
               {
                  this.sysApi.sendAction(new ArenaUnregisterAction([]));
               }
               break;
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_help:
               this.hintsApi.showSubHints();
               break;
            case this.btn_findPartyMembers:
               this.sysApi.sendAction(new OpenSocialAction([0]));
               break;
            case this.lbl_ladderAccess:
               this.sysApi.goToUrl(this.uiApi.getText("ui.link.arenaLadder"));
               break;
            case this.lbl_rules:
               this.sysApi.sendAction(new OpenGuidebookAction([EnumTab.GUIDEBOOK_GAME_GUIDE,GameGuideArticlesEnum.KOLOSSIUM_CHART]));
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var data:TextTooltipInfo = null;
         var resetHours:String = null;
         var resetMinutes:String = null;
         var teamCount:int = 0;
         switch(target)
         {
            case this.ctr_statusIndicator:
               data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.arena.playerState"));
               break;
            case this.lbl_3v3SoloVictoryRatio:
            case this.lbl_3v3TeamVictoryRatio:
            case this.lbl_1v1VictoryRatio:
               resetHours = this._dailyVictoryResetTime.hours.toString();
               resetMinutes = this._dailyVictoryResetTime.minutes.toString();
               if(resetHours.length < 2)
               {
                  resetHours = "0" + resetHours;
               }
               if(resetMinutes.length < 2)
               {
                  resetMinutes = "0" + resetMinutes;
               }
               data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.arena.dailyVictory",resetHours,resetMinutes));
               break;
            case this.lbl_3v3SoloRank:
            case this.lbl_3v3TeamRank:
            case this.lbl_1v1Rank:
               data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.arena.ladderPosition"));
               break;
            case this.btn_3v3TeamQueue:
               if(this.btn_3v3TeamQueue.softDisabled)
               {
                  if(this._currentPartySize < FULL_ARENA_TEAM)
                  {
                     teamCount = FULL_ARENA_TEAM - this._currentPartySize;
                     data = this.uiApi.textTooltipInfo(this.uiApi.processText(this.uiApi.getText("ui.party.arena.teamMissingPlayer",teamCount),"n",teamCount < 2,teamCount == 0));
                  }
                  else if(!this._partyIsValid)
                  {
                     data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.arena.twoPlayerSameBreed"));
                  }
                  else
                  {
                     data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.arena.notTeamLeader"));
                  }
               }
               break;
            case this.btn_3v3SoloQueue:
               if(this.btn_3v3SoloQueue.softDisabled)
               {
                  data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.arena.inArenaTeam"));
               }
               break;
            case this.btn_1v1Queue:
               if(this.btn_1v1Queue.softDisabled)
               {
                  data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.arena.inArenaTeam"));
               }
               break;
            case this.txt_1v1Help:
               data = this.uiApi.textTooltipInfo(this.uiApi.getText("ui.party.arena.1v1Help"));
         }
         if(data)
         {
            this.uiApi.showTooltip(data,target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "validUi":
               if(!this._isRegistered)
               {
                  this.sysApi.sendAction(new ArenaRegisterAction([this._currentFightMode,true]));
               }
               return true;
            case "closeUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
      
      public function onArenaRegistrationStatusUpdate(isRegistered:Boolean, currentStatus:int) : void
      {
         var whatToDoText:String = null;
         this._isRegistered = isRegistered;
         this._currentStatus = currentStatus;
         switch(this._currentStatus)
         {
            case PvpArenaStepEnum.ARENA_STEP_UNREGISTER:
               this._nbFightersReady = 0;
               this.btn_3v3SoloQueue.softDisabled = false;
               this.btn_3v3TeamQueue.softDisabled = false;
               this.btn_1v1Queue.softDisabled = false;
               this.btn_lbl_btn_1v1Queue.text = this.btn_lbl_btn_3v3SoloQueue.text = this.btn_lbl_btn_3v3TeamQueue.text = this.uiApi.getText("ui.party.arena.findGame");
               this.updateFighters();
               break;
            case PvpArenaStepEnum.ARENA_STEP_REGISTRED:
               whatToDoText = this.uiApi.getText("ui.party.arenaInfoSearch" + this.getTextSuffix());
               if(this._currentFightMode == PvpArenaTypeEnum.ARENA_TYPE_1VS1)
               {
                  this.btn_3v3SoloQueue.softDisabled = true;
                  this.btn_3v3TeamQueue.softDisabled = true;
                  this.btn_1v1Queue.softDisabled = false;
                  this.btn_lbl_btn_1v1Queue.text = this.uiApi.getText("ui.party.arena.leftQueue");
               }
               else if(this._currentFightMode == PvpArenaTypeEnum.ARENA_TYPE_3VS3_SOLO)
               {
                  this.btn_1v1Queue.softDisabled = true;
                  this.btn_3v3SoloQueue.softDisabled = false;
                  this.btn_3v3TeamQueue.softDisabled = true;
                  this.btn_lbl_btn_3v3SoloQueue.text = this.uiApi.getText("ui.party.arena.leftQueue");
               }
               else if(this._currentFightMode == PvpArenaTypeEnum.ARENA_TYPE_3VS3_TEAM)
               {
                  this.btn_1v1Queue.softDisabled = true;
                  this.btn_3v3SoloQueue.softDisabled = true;
                  this.btn_3v3TeamQueue.softDisabled = false;
                  this.btn_lbl_btn_3v3TeamQueue.text = this.uiApi.getText("ui.party.arena.leftQueue");
               }
               break;
            case PvpArenaStepEnum.ARENA_STEP_WAITING_FIGHT:
               if(this._currentFightMode == PvpArenaTypeEnum.ARENA_TYPE_3VS3_TEAM)
               {
                  whatToDoText = this.uiApi.getText("ui.party.arenaInfoWaiting" + this.getTextSuffix(),0);
               }
               else
               {
                  whatToDoText = this.uiApi.getText("ui.party.arenaInfoWaiting" + this.getTextSuffix());
               }
               this.btn_3v3SoloQueue.softDisabled = true;
               this.btn_3v3TeamQueue.softDisabled = true;
               this.btn_1v1Queue.softDisabled = true;
               this.btn_lbl_btn_1v1Queue.text = this.btn_lbl_btn_3v3SoloQueue.text = this.btn_lbl_btn_3v3TeamQueue.text = this.uiApi.getText("ui.party.arena.findGame");
               break;
            case PvpArenaStepEnum.ARENA_STEP_STARTING_FIGHT:
               this._nbFightersReady = 0;
               whatToDoText = this.uiApi.getText("ui.party.arenaInfoFighting");
               this.btn_3v3SoloQueue.softDisabled = true;
               this.btn_3v3TeamQueue.softDisabled = true;
               this.btn_1v1Queue.softDisabled = true;
               break;
            default:
               this.sysApi.log(1,"Probleme de status d\'arene");
         }
         this.ctr_statusIndicator.visible = this._isRegistered;
         this.lbl_whatToDo.text = whatToDoText;
      }
      
      public function onArenaFighterStatusUpdate(playerId:Number, answer:Boolean) : void
      {
         if(answer)
         {
            ++this._nbFightersReady;
            if(this._currentStatus == PvpArenaStepEnum.ARENA_STEP_WAITING_FIGHT && this._currentFightMode == PvpArenaTypeEnum.ARENA_TYPE_3VS3_TEAM)
            {
               this.lbl_whatToDo.text = this.uiApi.getText("ui.party.arenaInfoWaiting" + this.getTextSuffix(),this._nbFightersReady);
            }
         }
         else
         {
            this._nbFightersReady = 0;
         }
      }
      
      public function onArenaFightProposition(alliesIds:Object) : void
      {
         this._nbFightersReady = 0;
         if(this._currentStatus == PvpArenaStepEnum.ARENA_STEP_WAITING_FIGHT && this._currentFightMode == PvpArenaTypeEnum.ARENA_TYPE_3VS3_TEAM)
         {
            this.lbl_whatToDo.text = this.uiApi.getText("ui.party.arenaInfoWaiting" + this.getTextSuffix(),this._nbFightersReady);
         }
      }
      
      public function onPartyJoin(id:int, pMembers:Object, restrict:Boolean, isArenaParty:Boolean, name:String = "") : void
      {
         if(id == this.partyApi.getArenaPartyId())
         {
            this.updateFighters();
         }
      }
      
      public function onPartyUpdate(id:int, pMembers:Object) : void
      {
         if(id == this.partyApi.getArenaPartyId())
         {
            this.updateFighters();
         }
      }
      
      public function onPartyLeave(id:int, isArena:Boolean) : void
      {
         if(isArena)
         {
            this.updateFighters();
         }
      }
      
      public function onPartyMemberUpdate(id:int, playerId:Number, guest:Boolean) : void
      {
         if(id == this.partyApi.getArenaPartyId())
         {
            this.updateFighters();
         }
      }
      
      public function onPartyLeaderUpdate(id:int, leaderId:Number) : void
      {
         if(id == this.partyApi.getArenaPartyId())
         {
            this.updateFighters();
         }
      }
      
      public function onPartyMemberRemove(id:int, playerId:Number) : void
      {
         if(id == this.partyApi.getArenaPartyId())
         {
            this.updateFighters();
         }
      }
      
      public function onArenaUpdateRank(soloInfos:ArenaRankInfosWrapper, groupInfos:ArenaRankInfosWrapper = null, duelInfos:ArenaRankInfosWrapper = null) : void
      {
         if(soloInfos)
         {
            this.tx_3v3SoloLeagueIcon.visible = true;
            this.tx_3v3SoloLeagueIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("arenaIcon") + soloInfos.leagueIconId);
         }
         else
         {
            this.tx_3v3SoloLeagueIcon.visible = false;
            this.tx_3v3SoloLeagueIcon.uri = null;
         }
         if(groupInfos)
         {
            this.tx_3v3TeamLeagueIcon.visible = true;
            this.tx_3v3TeamLeagueIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("arenaIcon") + groupInfos.leagueIconId);
         }
         else
         {
            this.tx_3v3TeamLeagueIcon.visible = false;
            this.tx_3v3TeamLeagueIcon.uri = null;
         }
         if(!soloInfos || soloInfos.leagueId <= 0)
         {
            this.lbl_3v3SoloLeagueName.text = this.uiApi.getText("ui.party.arena.noLeague");
            this.pb_3v3SoloLeaguePoint.visible = false;
            this.lbl_3v3SoloPointsToNextLeague.text = this.uiApi.getText("ui.party.noArenaRankInfos");
            this.lbl_3v3SoloPointsValue.text = "-";
         }
         else
         {
            this.lbl_3v3SoloLeagueName.text = soloInfos.leagueName;
            if(!soloInfos.inLastLeague)
            {
               this.pb_3v3SoloLeaguePoint.visible = true;
               this.pb_3v3SoloLeaguePoint.value = soloInfos.leagueProgression / 100;
               this.lbl_3v3SoloPointsToNextLeague.visible = true;
               this.lbl_3v3SoloPointsToNextLeague.text = this.uiApi.getText("ui.party.arena.pointLeftToNextLeague",soloInfos.leagueProgression,MAX_LEAGUE_POINTS);
            }
            else
            {
               this.pb_3v3SoloLeaguePoint.visible = false;
               this.lbl_3v3SoloPointsToNextLeague.visible = false;
            }
            this.lbl_3v3SoloPointsValue.text = this.utilApi.kamasToString(soloInfos.rank,"");
         }
         if(!soloInfos || soloInfos.ladderPosition <= 0)
         {
            this.lbl_3v3SoloRankValue.text = "-";
         }
         else
         {
            this.lbl_3v3SoloRankValue.text = this.utilApi.kamasToString(soloInfos.ladderPosition,"");
         }
         if(!soloInfos || soloInfos.todayFightCount <= 0)
         {
            this.lbl_3v3SoloVictoryRatioValue.text = "-";
         }
         else
         {
            this.lbl_3v3SoloVictoryRatioValue.text = soloInfos.todayVictoryCount + "/" + soloInfos.todayFightCount;
         }
         if(!groupInfos || groupInfos.leagueId <= 0)
         {
            this.lbl_3v3TeamLeagueName.text = this.uiApi.getText("ui.party.arena.noLeague");
            this.pb_3v3TeamleaguePoint.visible = false;
            this.lbl_3v3TeamPointsToNextLeague.text = this.uiApi.getText("ui.party.noArenaRankInfos");
            this.lbl_3v3TeamPointsValue.text = "-";
         }
         else
         {
            this.lbl_3v3TeamLeagueName.text = groupInfos.leagueName;
            if(!groupInfos.inLastLeague)
            {
               this.lbl_3v3TeamPointsToNextLeague.visible = true;
               this.lbl_3v3TeamPointsToNextLeague.text = this.uiApi.getText("ui.party.arena.pointLeftToNextLeague",groupInfos.leagueProgression,MAX_LEAGUE_POINTS);
               this.pb_3v3TeamleaguePoint.visible = true;
               this.pb_3v3TeamleaguePoint.value = groupInfos.leagueProgression / 100;
            }
            else
            {
               this.lbl_3v3TeamPointsToNextLeague.visible = false;
               this.pb_3v3TeamleaguePoint.visible = false;
            }
            this.lbl_3v3TeamPointsValue.text = this.utilApi.kamasToString(groupInfos.rank,"");
         }
         if(!groupInfos || groupInfos.ladderPosition <= 0)
         {
            this.lbl_3v3TeamRankValue.text = "-";
         }
         else
         {
            this.lbl_3v3TeamRankValue.text = this.utilApi.kamasToString(groupInfos.ladderPosition,"");
         }
         if(!groupInfos || groupInfos.todayFightCount <= 0)
         {
            this.lbl_3v3TeamVictoryRatioValue.text = "-";
         }
         else
         {
            this.lbl_3v3TeamVictoryRatioValue.text = groupInfos.todayVictoryCount + "/" + groupInfos.todayFightCount;
         }
         if(!duelInfos || duelInfos.rank <= 0)
         {
            this.lbl_1v1MatchToBeRanked.visible = true;
            if(duelInfos)
            {
               this.lbl_1v1MatchToBeRanked.text = this.uiApi.getText("ui.party.arena.fightLeftToBeRanked",duelInfos.numFightNeededForLadder);
            }
            else
            {
               this.lbl_1v1MatchToBeRanked.text = this.uiApi.getText("ui.party.noArenaRankInfos");
            }
            this.lbl_1v1PointsValue.text = "-";
         }
         else
         {
            this.lbl_1v1MatchToBeRanked.visible = false;
            this.lbl_1v1PointsValue.text = this.utilApi.kamasToString(duelInfos.rank,"");
         }
         if(!duelInfos || duelInfos.ladderPosition <= 0)
         {
            this.lbl_1v1RankValue.text = "-";
         }
         else
         {
            this.lbl_1v1RankValue.text = this.utilApi.kamasToString(duelInfos.ladderPosition,"");
         }
         if(!duelInfos || duelInfos.todayFightCount <= 0)
         {
            this.lbl_1v1VictoryRatioValue.text = "-";
         }
         else
         {
            this.lbl_1v1VictoryRatioValue.text = duelInfos.todayVictoryCount + "/" + duelInfos.todayFightCount;
         }
      }
   }
}
