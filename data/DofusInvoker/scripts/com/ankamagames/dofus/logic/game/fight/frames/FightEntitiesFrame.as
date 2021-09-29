package com.ankamagames.dofus.logic.game.fight.frames
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.house.HouseWrapper;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.sound.SoundManager;
   import com.ankamagames.dofus.kernel.sound.enum.UISoundEnum;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowCellManager;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
   import com.ankamagames.dofus.logic.game.common.frames.BreachFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.actions.RemoveEntityAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ShowMountsInFightAction;
   import com.ankamagames.dofus.logic.game.fight.actions.ToggleDematerializationAction;
   import com.ankamagames.dofus.logic.game.fight.fightEvents.FightEventsHelper;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.miscs.CarrierAnimationModifier;
   import com.ankamagames.dofus.logic.game.fight.miscs.FightEntitiesHolder;
   import com.ankamagames.dofus.logic.game.fight.steps.FightCarryCharacterStep;
   import com.ankamagames.dofus.logic.game.fight.steps.FightChangeVisibilityStep;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.misc.lists.BreachHookList;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.utils.EmbedAssets;
   import com.ankamagames.dofus.misc.utils.LookCleaner;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.GameActionFightInvisibilityStateEnum;
   import com.ankamagames.dofus.network.enums.MapObstacleStateEnum;
   import com.ankamagames.dofus.network.enums.TeamEnum;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCarryCharacterMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDropCharacterMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightThrowCharacterMessage;
   import com.ankamagames.dofus.network.messages.game.character.status.PlayerStatusUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameContextRefreshEntityLookMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameEntitiesDispositionMessage;
   import com.ankamagames.dofus.network.messages.game.context.GameEntityDispositionMessage;
   import com.ankamagames.dofus.network.messages.game.context.ShowCellMessage;
   import com.ankamagames.dofus.network.messages.game.context.ShowCellSpectatorMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightHumanReadyStateMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.GameFightPlacementSwapPositionsMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightRefreshFighterMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightShowFighterMessage;
   import com.ankamagames.dofus.network.messages.game.context.fight.character.GameFightShowFighterRandomStaticPoseMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataInHouseMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsDataMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapComplementaryInformationsWithCoordsMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapRewardRateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.anomaly.AnomalyStateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.breach.MapComplementaryInformationsBreachMessage;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.context.FightEntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorPositionInformations;
   import com.ankamagames.dofus.network.types.game.context.IdentifiedEntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightEntityInformation;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterNamedInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightMonsterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.breach.BreachBranch;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
   import com.ankamagames.dofus.network.types.game.interactive.StatedElement;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.types.entities.CustomBreedAnimationModifier;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.utils.display.Rectangle2;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.tiphon.types.IAnimationModifier;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import damageCalculation.tools.StatIds;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class FightEntitiesFrame extends AbstractEntitiesFrame implements Frame
   {
      
      private static const TEAM_CIRCLE_COLOR_1:uint = 255;
      
      private static const TEAM_CIRCLE_COLOR_2:uint = 16711680;
       
      
      private var _ie:Dictionary;
      
      private var _tempFighterList:Array;
      
      private var _illusionEntities:Dictionary;
      
      private var _entitiesNumber:Dictionary;
      
      private var _lastKnownPosition:Dictionary;
      
      private var _lastKnownMovementPoint:Dictionary;
      
      private var _lastKnownPlayerStatus:Dictionary;
      
      private var _realFightersLooks:Dictionary;
      
      private var _mountsVisible:Boolean;
      
      private var _numCreatureSwitchingEntities:int;
      
      private var _entitiesIconsToUpdate:Vector.<Number>;
      
      public var lastKilledChallengers:Vector.<GameFightFighterInformations>;
      
      public var lastKilledDefenders:Vector.<GameFightFighterInformations>;
      
      public function FightEntitiesFrame()
      {
         this._ie = new Dictionary(true);
         this._tempFighterList = [];
         this._entitiesIconsToUpdate = new Vector.<Number>(0);
         this.lastKilledChallengers = new Vector.<GameFightFighterInformations>(0);
         this.lastKilledDefenders = new Vector.<GameFightFighterInformations>(0);
         super();
      }
      
      public static function getCurrentInstance() : FightEntitiesFrame
      {
         return Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
      }
      
      public static function getTeamCircleColor(teamId:uint) : uint
      {
         return teamId == TeamEnum.TEAM_DEFENDER ? uint(TEAM_CIRCLE_COLOR_1) : uint(TEAM_CIRCLE_COLOR_2);
      }
      
      override public function pushed() : Boolean
      {
         Atouin.getInstance().cellOverEnabled = true;
         Dofus.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         this._entitiesNumber = new Dictionary();
         this._illusionEntities = new Dictionary();
         this._lastKnownPosition = new Dictionary();
         this._lastKnownMovementPoint = new Dictionary();
         this._lastKnownPlayerStatus = new Dictionary();
         this._realFightersLooks = new Dictionary();
         _creaturesFightMode = OptionManager.getOptionManager("dofus").getOption("creaturesFightMode");
         this._mountsVisible = OptionManager.getOptionManager("dofus").getOption("showMountsInFight");
         return super.pushed();
      }
      
      public function addLastKilledAlly(entity:GameFightFighterInformations) : void
      {
         var listKilled:Vector.<GameFightFighterInformations> = entity.spawnInfo.teamId == TeamEnum.TEAM_CHALLENGER ? this.lastKilledChallengers : this.lastKilledDefenders;
         var index:int = 0;
         if(!(entity is GameFightFighterNamedInformations))
         {
            while(index < listKilled.length && listKilled[index] is GameFightFighterNamedInformations)
            {
               index++;
            }
            if(!(entity is GameFightEntityInformation))
            {
               while(index < listKilled.length && listKilled[index] is GameFightEntityInformation)
               {
                  index++;
               }
            }
         }
         if(entity.spawnInfo.teamId == TeamEnum.TEAM_CHALLENGER)
         {
            this.lastKilledChallengers.insertAt(index,entity);
         }
         else
         {
            this.lastKilledDefenders.insertAt(index,entity);
         }
      }
      
      public function removeSpecificKilledAlly(infos:GameFightFighterInformations) : void
      {
         if(infos.spawnInfo.teamId == TeamEnum.TEAM_CHALLENGER && this.lastKilledChallengers.length > 0)
         {
            this.lastKilledChallengers.removeAt(this.lastKilledChallengers.indexOf(infos));
         }
         else if(infos.spawnInfo.teamId == TeamEnum.TEAM_DEFENDER && this.lastKilledDefenders.length > 0)
         {
            this.lastKilledDefenders.removeAt(this.lastKilledDefenders.indexOf(infos));
         }
      }
      
      public function removeLastKilledAlly(teamId:int) : void
      {
         if(teamId == TeamEnum.TEAM_CHALLENGER && this.lastKilledChallengers.length > 0)
         {
            this.lastKilledChallengers.removeAt(0);
         }
         else if(teamId == TeamEnum.TEAM_DEFENDER && this.lastKilledDefenders.length > 0)
         {
            this.lastKilledDefenders.removeAt(0);
         }
      }
      
      override public function addOrUpdateActor(infos:GameContextActorInformations, animationModifier:IAnimationModifier = null) : AnimatedCharacter
      {
         var res:AnimatedCharacter = super.addOrUpdateActor(infos,animationModifier);
         if(infos.disposition.cellId != -1)
         {
            this.setLastKnownEntityPosition(infos.contextualId,infos.disposition.cellId);
         }
         if(infos.contextualId > 0)
         {
            res.disableMouseEventWhenAnimated = true;
         }
         if(CurrentPlayedFighterManager.getInstance().currentFighterId == infos.contextualId)
         {
            res.setCanSeeThrough(true);
         }
         if(infos is GameFightCharacterInformations)
         {
            this._lastKnownPlayerStatus[infos.contextualId] = GameFightCharacterInformations(infos).status.statusId;
         }
         return res;
      }
      
      override public function process(msg:Message) : Boolean
      {
         var gfrfmsg:GameFightRefreshFighterMessage = null;
         var actorId:Number = NaN;
         var fullInfos:GameContextActorInformations = null;
         var gfsfmsg:GameFightShowFighterMessage = null;
         var fightContextFrame:FightContextFrame = null;
         var gfhrsmsg:GameFightHumanReadyStateMessage = null;
         var fighterInfoToBeReady:GameFightFighterInformations = null;
         var ac2:AnimatedCharacter = null;
         var fightPreparationFrame:FightPreparationFrame = null;
         var gedmsg:GameEntityDispositionMessage = null;
         var gfpspmsg:GameFightPlacementSwapPositionsMessage = null;
         var iedi:IdentifiedEntityDispositionInformations = null;
         var gedsmsg:GameEntitiesDispositionMessage = null;
         var fighterInfos:GameFightFighterInformations = null;
         var gcrelmsg:GameContextRefreshEntityLookMessage = null;
         var tiphonSprite:TiphonSprite = null;
         var fighterRemovedId:Number = NaN;
         var scsmsg:ShowCellSpectatorMessage = null;
         var stext:String = null;
         var scmsg:ShowCellMessage = null;
         var mcidmsg:MapComplementaryInformationsDataMessage = null;
         var taimsg:AnomalyStateMessage = null;
         var mrrmsg:MapRewardRateMessage = null;
         var gafccmsg:GameActionFightCarryCharacterMessage = null;
         var gaftcmsg:GameActionFightThrowCharacterMessage = null;
         var gafdcmsg:GameActionFightDropCharacterMessage = null;
         var psum:PlayerStatusUpdateMessage = null;
         var smifa:ShowMountsInFightAction = null;
         var staticRandomAnimModifier:IAnimationModifier = null;
         var swords:Sprite = null;
         var disposition:IdentifiedEntityDispositionInformations = null;
         var mciwcmsg:MapComplementaryInformationsWithCoordsMessage = null;
         var mcidihmsg:MapComplementaryInformationsDataInHouseMessage = null;
         var isPlayerHouse:* = false;
         var breachFrame:BreachFrame = null;
         var mcibm:MapComplementaryInformationsBreachMessage = null;
         var b:BreachBranch = null;
         var mo:MapObstacle = null;
         var ie:InteractiveElement = null;
         var se:StatedElement = null;
         var ent:GameFightFighterInformations = null;
         switch(true)
         {
            case msg is GameFightRefreshFighterMessage:
               gfrfmsg = msg as GameFightRefreshFighterMessage;
               actorId = gfrfmsg.informations.contextualId;
               fullInfos = _entities[actorId];
               if(fullInfos != null)
               {
                  fullInfos.disposition = gfrfmsg.informations.disposition;
                  fullInfos.look = gfrfmsg.informations.look;
                  this._realFightersLooks[gfrfmsg.informations.contextualId] = gfrfmsg.informations.look;
                  if(Kernel.getWorker().contains(FightPreparationFrame) && gfrfmsg.informations.disposition.cellId == -1)
                  {
                     registerActor(gfrfmsg.informations);
                  }
                  else
                  {
                     this.updateActor(fullInfos,true);
                  }
               }
               if(Kernel.getWorker().getFrame(FightPreparationFrame))
               {
                  KernelEventsManager.getInstance().processCallback(FightHookList.UpdatePreFightersList,actorId);
                  if(Dofus.getInstance().options.getOption("orderFighters"))
                  {
                     this.updateAllEntitiesNumber(this.getOrdonnedPreFighters());
                  }
               }
               return true;
            case msg is GameFightShowFighterMessage:
               gfsfmsg = msg as GameFightShowFighterMessage;
               this._realFightersLooks[gfsfmsg.informations.contextualId] = gfsfmsg.informations.look;
               if(msg is GameFightShowFighterRandomStaticPoseMessage)
               {
                  staticRandomAnimModifier = new CustomBreedAnimationModifier();
                  (staticRandomAnimModifier as CustomBreedAnimationModifier).randomStatique = true;
                  this.updateFighter(gfsfmsg.informations,staticRandomAnimModifier);
                  this._illusionEntities[gfsfmsg.informations.contextualId] = true;
               }
               else
               {
                  if(Kernel.getWorker().contains(FightPreparationFrame) && gfsfmsg.informations.disposition.cellId == -1)
                  {
                     registerActor(gfsfmsg.informations);
                  }
                  else
                  {
                     this.updateFighter(gfsfmsg.informations);
                  }
                  this._illusionEntities[gfsfmsg.informations.contextualId] = false;
                  if(Kernel.getWorker().getFrame(FightPreparationFrame))
                  {
                     KernelEventsManager.getInstance().processCallback(FightHookList.UpdatePreFightersList,gfsfmsg.informations.contextualId);
                     if(Dofus.getInstance().options.getOption("orderFighters"))
                     {
                        this.updateAllEntitiesNumber(this.getOrdonnedPreFighters());
                     }
                  }
               }
               fightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
               if(fightContextFrame.fightersPositionsHistory[gfsfmsg.informations.contextualId])
               {
               }
               return true;
            case msg is GameFightHumanReadyStateMessage:
               gfhrsmsg = msg as GameFightHumanReadyStateMessage;
               fighterInfoToBeReady = getEntityInfos(gfhrsmsg.characterId) as GameFightFighterInformations;
               if(!fighterInfoToBeReady || fighterInfoToBeReady.disposition.cellId == -1)
               {
                  return true;
               }
               ac2 = this.addOrUpdateActor(fighterInfoToBeReady);
               if(gfhrsmsg.isReady)
               {
                  swords = EmbedAssets.getSprite("SWORDS_CLIP");
                  ac2.addBackground("readySwords",swords);
               }
               else
               {
                  ac2.removeBackground("readySwords");
                  if(gfhrsmsg.characterId == PlayedCharacterManager.getInstance().id)
                  {
                     KernelEventsManager.getInstance().processCallback(FightHookList.NotReadyToFight);
                  }
               }
               fightPreparationFrame = Kernel.getWorker().getFrame(FightPreparationFrame) as FightPreparationFrame;
               if(fightPreparationFrame)
               {
                  fightPreparationFrame.updateSwapPositionRequestsIcons();
               }
               return true;
               break;
            case msg is GameEntityDispositionMessage:
               gedmsg = msg as GameEntityDispositionMessage;
               if(gedmsg.disposition.id == CurrentPlayedFighterManager.getInstance().currentFighterId)
               {
                  SoundManager.getInstance().manager.playUISound(UISoundEnum.FIGHT_POSITION);
               }
               this.updateActorDisposition(gedmsg.disposition.id,gedmsg.disposition);
               KernelEventsManager.getInstance().processCallback(FightHookList.GameEntityDisposition,gedmsg.disposition.id,gedmsg.disposition.cellId,gedmsg.disposition.direction);
               return true;
            case msg is GameFightPlacementSwapPositionsMessage:
               gfpspmsg = msg as GameFightPlacementSwapPositionsMessage;
               for each(iedi in gfpspmsg.dispositions)
               {
                  this.updateActorDisposition(iedi.id,iedi);
                  KernelEventsManager.getInstance().processCallback(FightHookList.GameEntityDisposition,iedi.id,iedi.cellId,iedi.direction);
               }
               return true;
            case msg is GameEntitiesDispositionMessage:
               gedsmsg = msg as GameEntitiesDispositionMessage;
               for each(disposition in gedsmsg.dispositions)
               {
                  fighterInfos = getEntityInfos(disposition.id) as GameFightFighterInformations;
                  if(fighterInfos && fighterInfos.stats.invisibilityState != GameActionFightInvisibilityStateEnum.INVISIBLE)
                  {
                     this.updateActorDisposition(disposition.id,disposition);
                  }
                  KernelEventsManager.getInstance().processCallback(FightHookList.GameEntityDisposition,disposition.id,disposition.cellId,disposition.direction);
               }
               return true;
            case msg is GameContextRefreshEntityLookMessage:
               if(Kernel.getWorker().avoidFlood(getQualifiedClassName(msg)))
               {
                  return true;
               }
               gcrelmsg = msg as GameContextRefreshEntityLookMessage;
               tiphonSprite = DofusEntities.getEntity(gcrelmsg.id) as TiphonSprite;
               if(tiphonSprite)
               {
                  tiphonSprite.setAnimation(AnimationEnum.ANIM_STATIQUE);
               }
               this.updateActorLook(gcrelmsg.id,gcrelmsg.look);
               return true;
               break;
            case msg is ToggleDematerializationAction:
               this.showCreaturesInFight(!_creaturesFightMode);
               KernelEventsManager.getInstance().processCallback(FightHookList.DematerializationChanged,_creaturesFightMode);
               return true;
            case msg is RemoveEntityAction:
               fighterRemovedId = RemoveEntityAction(msg).actorId;
               this._entitiesNumber[fighterRemovedId] = null;
               removeActor(fighterRemovedId);
               KernelEventsManager.getInstance().processCallback(FightHookList.UpdatePreFightersList,fighterRemovedId);
               delete this._realFightersLooks[fighterRemovedId];
               return true;
            case msg is ShowCellSpectatorMessage:
               scsmsg = msg as ShowCellSpectatorMessage;
               HyperlinkShowCellManager.showCell(scsmsg.cellId);
               stext = I18n.getUiText("ui.fight.showCell",[scsmsg.playerName,"{cell," + scsmsg.cellId + "::" + scsmsg.cellId + "}"]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,stext,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is ShowCellMessage:
               scmsg = msg as ShowCellMessage;
               HyperlinkShowCellManager.showCell(scmsg.cellId);
               return true;
            case msg is MapComplementaryInformationsDataMessage:
               mcidmsg = msg as MapComplementaryInformationsDataMessage;
               _interactiveElements = mcidmsg.interactiveElements;
               if(msg is MapComplementaryInformationsWithCoordsMessage)
               {
                  mciwcmsg = msg as MapComplementaryInformationsWithCoordsMessage;
                  if(PlayedCharacterManager.getInstance().isInHouse)
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.HouseExit);
                  }
                  PlayedCharacterManager.getInstance().isInHouse = false;
                  PlayedCharacterManager.getInstance().isInHisHouse = false;
                  PlayedCharacterManager.getInstance().currentMap.setOutdoorCoords(mciwcmsg.worldX,mciwcmsg.worldY);
                  _worldPoint = new WorldPointWrapper(mciwcmsg.mapId,true,mciwcmsg.worldX,mciwcmsg.worldY);
               }
               else if(msg is MapComplementaryInformationsDataInHouseMessage)
               {
                  mcidihmsg = msg as MapComplementaryInformationsDataInHouseMessage;
                  isPlayerHouse = PlayerManager.getInstance().nickname == mcidihmsg.currentHouse.houseInfos.ownerTag.nickname;
                  PlayedCharacterManager.getInstance().isInHouse = true;
                  if(isPlayerHouse)
                  {
                     PlayedCharacterManager.getInstance().isInHisHouse = true;
                  }
                  PlayedCharacterManager.getInstance().currentMap.setOutdoorCoords(mcidihmsg.currentHouse.worldX,mcidihmsg.currentHouse.worldY);
                  KernelEventsManager.getInstance().processCallback(HookList.HouseEntered,isPlayerHouse,mcidihmsg.currentHouse.worldX,mcidihmsg.currentHouse.worldY,HouseWrapper.createInside(mcidihmsg.currentHouse));
                  _worldPoint = new WorldPointWrapper(mcidihmsg.mapId,true,mcidihmsg.currentHouse.worldX,mcidihmsg.currentHouse.worldY);
               }
               else if(msg is MapComplementaryInformationsBreachMessage)
               {
                  _worldPoint = new WorldPointWrapper(mcidmsg.mapId);
                  breachFrame = Kernel.getWorker().getFrame(BreachFrame) as BreachFrame;
                  if(breachFrame)
                  {
                     mcibm = msg as MapComplementaryInformationsBreachMessage;
                     breachFrame.floor = mcibm.floor;
                     breachFrame.room = mcibm.room;
                     breachFrame.infinityLevel = mcibm.infinityMode;
                     breachFrame.branches = new Dictionary();
                     for each(b in mcibm.branches)
                     {
                        breachFrame.branches[b.element] = {
                           "room":b.room,
                           "bosses":b.bosses
                        };
                     }
                     KernelEventsManager.getInstance().processCallback(BreachHookList.BreachMapInfos,mcibm.branches.length == 1 ? mcibm.branches[0].bosses : null);
                  }
               }
               else
               {
                  _worldPoint = new WorldPointWrapper(mcidmsg.mapId);
                  if(PlayedCharacterManager.getInstance().isInHouse)
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.HouseExit);
                  }
                  PlayedCharacterManager.getInstance().isInHouse = false;
                  PlayedCharacterManager.getInstance().isInHisHouse = false;
               }
               _currentSubAreaId = mcidmsg.subAreaId;
               PlayedCharacterManager.getInstance().currentMap = _worldPoint;
               PlayedCharacterManager.getInstance().currentSubArea = SubArea.getSubAreaById(_currentSubAreaId);
               TooltipManager.hide();
               for each(mo in mcidmsg.obstacles)
               {
                  InteractiveCellManager.getInstance().updateCell(mo.obstacleCellId,mo.state == MapObstacleStateEnum.OBSTACLE_OPENED);
               }
               for each(ie in mcidmsg.interactiveElements)
               {
                  if(ie.enabledSkills.length)
                  {
                     this.registerInteractive(ie,ie.enabledSkills[0].skillId);
                  }
                  else if(ie.disabledSkills.length)
                  {
                     this.registerInteractive(ie,ie.disabledSkills[0].skillId);
                  }
               }
               for each(se in mcidmsg.statedElements)
               {
                  this.updateStatedElement(se);
               }
               KernelEventsManager.getInstance().processCallback(HookList.MapComplementaryInformationsData,PlayedCharacterManager.getInstance().currentMap,_currentSubAreaId,Dofus.getInstance().options.getOption("mapCoordinates"));
               KernelEventsManager.getInstance().processCallback(HookList.MapFightCount,0);
               return true;
            case msg is AnomalyStateMessage:
               taimsg = msg as AnomalyStateMessage;
               KernelEventsManager.getInstance().processCallback(HookList.AnomalyState,taimsg.open,taimsg.closingTime,taimsg.subAreaId);
               return true;
            case msg is MapRewardRateMessage:
               mrrmsg = msg as MapRewardRateMessage;
               KernelEventsManager.getInstance().processCallback(HookList.MapRewardRate,mrrmsg.totalRate,mrrmsg.mapRate,mrrmsg.subAreaRate);
               return true;
            case msg is GameActionFightCarryCharacterMessage:
               gafccmsg = msg as GameActionFightCarryCharacterMessage;
               if(gafccmsg.cellId != -1)
               {
                  for each(ent in _entities)
                  {
                     if(ent.contextualId == gafccmsg.targetId)
                     {
                        (ent.disposition as FightEntityDispositionInformations).carryingCharacterId = gafccmsg.sourceId;
                        this._tempFighterList.push(new TmpFighterInfos(ent.contextualId,gafccmsg.sourceId));
                        break;
                     }
                  }
               }
               return true;
            case msg is GameActionFightThrowCharacterMessage:
               gaftcmsg = msg as GameActionFightThrowCharacterMessage;
               this.dropEntity(gaftcmsg.targetId);
               return true;
            case msg is GameActionFightDropCharacterMessage:
               gafdcmsg = msg as GameActionFightDropCharacterMessage;
               this.dropEntity(gafdcmsg.targetId);
               return true;
            case msg is PlayerStatusUpdateMessage:
               psum = msg as PlayerStatusUpdateMessage;
               this._lastKnownPlayerStatus[psum.playerId] = psum.status.statusId;
               return false;
            case msg is ShowMountsInFightAction:
               smifa = msg as ShowMountsInFightAction;
               OptionManager.getOptionManager("dofus").setOption("showMountsInFight",smifa.visibility);
               return true;
            default:
               return false;
         }
      }
      
      private function dropEntity(targetId:Number) : void
      {
         var index:int = 0;
         var ent:GameFightFighterInformations = null;
         for each(ent in _entities)
         {
            if(ent.contextualId == targetId)
            {
               (ent.disposition as FightEntityDispositionInformations).carryingCharacterId = NaN;
               index = this.getTmpFighterInfoIndex(ent.contextualId);
               if(this._tempFighterList != null && this._tempFighterList.length != 0 && index != -1)
               {
                  this._tempFighterList.splice(index,1);
               }
               return;
            }
         }
      }
      
      public function showCreaturesInFight(activated:Boolean = false) : void
      {
         var ent:GameFightFighterInformations = null;
         var ac:AnimatedCharacter = null;
         _creaturesFightMode = activated;
         _justSwitchingCreaturesFightMode = true;
         this._numCreatureSwitchingEntities = 0;
         for each(ent in _entities)
         {
            this.updateFighter(ent);
            ac = DofusEntities.getEntity(ent.contextualId) as AnimatedCharacter;
            if(ac && !ac.rendered)
            {
               ++this._numCreatureSwitchingEntities;
               ac.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onCreatureSwitchEnd);
            }
            if(ent.contextualId in _entitiesIcons)
            {
               _entitiesIcons[ent.contextualId].needUpdate = true;
            }
         }
         _justSwitchingCreaturesFightMode = false;
         if(this._numCreatureSwitchingEntities == 0)
         {
            this.onCreatureSwitchEnd(null);
         }
         FightEntitiesFrame.getCurrentInstance().updateAllIcons();
      }
      
      public function switchMountsVisibility(pMountsVisibility:Boolean) : void
      {
         var entityInfos:GameFightFighterInformations = null;
         var fscf:FightSpellCastFrame = null;
         var ts:TiphonSprite = null;
         this._mountsVisible = pMountsVisibility;
         for each(entityInfos in _entities)
         {
            this.updateFighter(entityInfos);
         }
         fscf = Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame;
         if(fscf && fscf.spellId == DataEnum.SPELL_SRAM_DOUBLE && fscf.hasSummoningPreview)
         {
            ts = fscf.invocationPreview[0];
            ts.look.updateFrom(!!this._mountsVisible ? EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook) : TiphonUtility.getLookWithoutMount(EntityLookAdapter.fromNetwork(PlayedCharacterManager.getInstance().infos.entityLook)));
         }
      }
      
      public function entityIsIllusion(id:Number) : Boolean
      {
         return this._illusionEntities[id];
      }
      
      public function getLastKnownEntityPosition(id:Number) : int
      {
         return this._lastKnownPosition[id] != null ? int(this._lastKnownPosition[id]) : -1;
      }
      
      public function setLastKnownEntityPosition(id:Number, value:int) : void
      {
         this._lastKnownPosition[id] = value;
      }
      
      public function getLastKnownEntityMovementPoint(id:Number) : int
      {
         return this._lastKnownMovementPoint[id] != null ? int(this._lastKnownMovementPoint[id]) : 0;
      }
      
      public function setLastKnownEntityMovementPoint(id:Number, value:int, add:Boolean = false) : void
      {
         if(this._lastKnownMovementPoint[id] == null)
         {
            this._lastKnownMovementPoint[id] = 0;
         }
         if(!add)
         {
            this._lastKnownMovementPoint[id] = value;
         }
         else
         {
            this._lastKnownMovementPoint[id] += value;
         }
      }
      
      override public function pulled() : Boolean
      {
         var obj:Object = null;
         var fighterId:* = undefined;
         Dofus.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         this._tempFighterList = null;
         for each(obj in this._ie)
         {
            this.removeInteractive(obj.element as InteractiveElement);
         }
         for(fighterId in this._realFightersLooks)
         {
            delete this._realFightersLooks[fighterId];
         }
         return super.pulled();
      }
      
      private function registerInteractive(ie:InteractiveElement, firstSkill:int) : void
      {
         var s:* = null;
         var cie:InteractiveElement = null;
         var worldObject:InteractiveObject = Atouin.getInstance().getIdentifiedElement(ie.elementId);
         if(!worldObject)
         {
            _log.error("Unknown identified element " + ie.elementId + ", unable to register it as interactive.");
            return;
         }
         var found:Boolean = false;
         for(s in interactiveElements)
         {
            cie = interactiveElements[int(s)];
            if(cie.elementId == ie.elementId)
            {
               found = true;
               interactiveElements[int(s)] = ie;
               break;
            }
         }
         if(!found)
         {
            interactiveElements.push(ie);
         }
         var worldPos:MapPoint = Atouin.getInstance().getIdentifiedElementPosition(ie.elementId);
         this._ie[worldObject] = {
            "element":ie,
            "position":worldPos,
            "firstSkill":firstSkill
         };
      }
      
      private function updateStatedElement(se:StatedElement) : void
      {
         var worldObject:InteractiveObject = Atouin.getInstance().getIdentifiedElement(se.elementId);
         if(!worldObject)
         {
            _log.error("Unknown identified element " + se.elementId + "; unable to change its state to " + se.elementState + " !");
            return;
         }
         var ts:TiphonSprite = worldObject is DisplayObjectContainer ? this.findTiphonSprite(worldObject as DisplayObjectContainer) : null;
         if(!ts)
         {
            _log.warn("Unable to find an animated element for the stated element " + se.elementId + " on cell " + se.elementCellId + ", this element is probably invisible or is not configured as an animated element.");
            return;
         }
         ts.setAnimationAndDirection("AnimState1",0);
      }
      
      private function findTiphonSprite(doc:DisplayObjectContainer) : TiphonSprite
      {
         var child:DisplayObject = null;
         if(doc is TiphonSprite)
         {
            return doc as TiphonSprite;
         }
         if(!doc.numChildren)
         {
            return null;
         }
         for(var i:uint = 0; i < doc.numChildren; i++)
         {
            child = doc.getChildAt(i);
            if(child is TiphonSprite)
            {
               return child as TiphonSprite;
            }
            if(child is DisplayObjectContainer)
            {
               return this.findTiphonSprite(child as DisplayObjectContainer);
            }
         }
         return null;
      }
      
      private function removeInteractive(ie:InteractiveElement) : void
      {
         var interactiveElement:InteractiveObject = Atouin.getInstance().getIdentifiedElement(ie.elementId);
         delete this._ie[interactiveElement];
      }
      
      private function onCreatureSwitchEnd(pEvent:TiphonEvent) : void
      {
         var fightPreparationFrame:FightPreparationFrame = null;
         if(pEvent)
         {
            pEvent.currentTarget.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onCreatureSwitchEnd);
            --this._numCreatureSwitchingEntities;
         }
         if(this._numCreatureSwitchingEntities == 0)
         {
            fightPreparationFrame = Kernel.getWorker().getFrame(FightPreparationFrame) as FightPreparationFrame;
            if(fightPreparationFrame)
            {
               fightPreparationFrame.updateSwapPositionRequestsIcons();
            }
         }
      }
      
      override protected function showIcons(pEvent:Event = null) : void
      {
         var entityId:* = undefined;
         var tooltip:UiRootContainer = null;
         var iconUpdated:Boolean = false;
         if(!_showIcons && !_isShowIconsChanged)
         {
            return;
         }
         var updateAllIcons:Boolean = _updateAllIcons;
         this._entitiesIconsToUpdate.length = 0;
         for(entityId in _entitiesIconsNames)
         {
            if(_entitiesIcons[entityId] && _entitiesIcons[entityId].needUpdate)
            {
               this._entitiesIconsToUpdate.push(entityId);
            }
         }
         super.showIcons(pEvent);
         for(entityId in _entitiesIconsNames)
         {
            tooltip = Berilia.getInstance().getUi("tooltip_tooltipOverEntity_" + entityId);
            iconUpdated = this._entitiesIconsToUpdate.indexOf(entityId) != -1 && !_entitiesIcons[entityId].needUpdate;
            if((_entitiesIcons[entityId] && _entitiesIcons[entityId].needUpdate || iconUpdated || updateAllIcons) && tooltip)
            {
               this.updateEntityIconPosition(entityId);
            }
         }
      }
      
      public function getOrdonnedPreFighters() : Vector.<Number>
      {
         var id:Number = NaN;
         var badStart:Boolean = false;
         var entityInfo:GameFightFighterInformations = null;
         var stats:EntityStats = null;
         var monsterGenericId:int = 0;
         var initiative:Number = NaN;
         var lifePoints:Number = NaN;
         var maxLifePoints:Number = NaN;
         var entitiesIds:Vector.<Number> = getEntitiesIdsList();
         var fighters:Vector.<Number> = new Vector.<Number>();
         if(!entitiesIds || entitiesIds.length <= 1)
         {
            return fighters;
         }
         var goodGuys:Array = [];
         var badGuys:Array = [];
         var hiddenGuys:Array = [];
         var badInit:int = 0;
         var goodInit:int = 0;
         for each(id in entitiesIds)
         {
            entityInfo = getEntityInfos(id) as GameFightFighterInformations;
            if(entityInfo)
            {
               if(entityInfo is GameFightFighterNamedInformations && (entityInfo as GameFightFighterNamedInformations).hiddenInPrefight)
               {
                  hiddenGuys.push(id);
               }
               else
               {
                  stats = StatsManager.getInstance().getStats(entityInfo.contextualId);
                  monsterGenericId = 0;
                  if(entityInfo is GameFightMonsterInformations)
                  {
                     monsterGenericId = (entityInfo as GameFightMonsterInformations).creatureGenericId;
                  }
                  if(stats)
                  {
                     initiative = stats.getStatTotalValue(StatIds.INITIATIVE);
                     lifePoints = stats.getHealthPoints();
                     maxLifePoints = stats.getMaxHealthPoints();
                     if(entityInfo.spawnInfo.teamId == 0)
                     {
                        badGuys.push({
                           "fighterId":id,
                           "init":initiative * lifePoints / maxLifePoints,
                           "monsterId":monsterGenericId
                        });
                        badInit += initiative * lifePoints / maxLifePoints;
                     }
                     else
                     {
                        goodGuys.push({
                           "fighterId":id,
                           "init":initiative * lifePoints / maxLifePoints,
                           "monsterId":monsterGenericId
                        });
                        goodInit += initiative * lifePoints / maxLifePoints;
                     }
                  }
               }
            }
         }
         badGuys.sortOn(["init","monsterId","fighterId"],Array.DESCENDING | Array.NUMERIC);
         goodGuys.sortOn(["init","monsterId","fighterId"],Array.DESCENDING | Array.NUMERIC);
         badStart = true;
         if(badGuys.length == 0 || goodGuys.length == 0 || badInit / badGuys.length < goodInit / goodGuys.length)
         {
            badStart = false;
         }
         var length:int = Math.max(badGuys.length,goodGuys.length);
         for(var i:int = 0; i < length; i++)
         {
            if(badStart)
            {
               if(badGuys[i])
               {
                  fighters.push(badGuys[i].fighterId);
               }
               if(goodGuys[i])
               {
                  fighters.push(goodGuys[i].fighterId);
               }
            }
            else
            {
               if(goodGuys[i])
               {
                  fighters.push(goodGuys[i].fighterId);
               }
               if(badGuys[i])
               {
                  fighters.push(badGuys[i].fighterId);
               }
            }
         }
         length = hiddenGuys.length;
         for(i = length - 1; i >= 0; i--)
         {
            fighters.unshift(hiddenGuys[i]);
         }
         return fighters;
      }
      
      public function removeSwords() : void
      {
         var entInfo:* = undefined;
         var ac:AnimatedCharacter = null;
         for each(entInfo in _entities)
         {
            if(!(entInfo is GameFightCharacterInformations && !GameFightCharacterInformations(entInfo).spawnInfo.alive))
            {
               ac = this.addOrUpdateActor(entInfo);
               ac.removeBackground("readySwords");
            }
         }
      }
      
      public function updateFighter(fighterInfos:GameFightFighterInformations, animationModifier:IAnimationModifier = null) : void
      {
         var lastInvisibilityStat:int = 0;
         var lastFighterInfo:GameFightFighterInformations = null;
         var ac:AnimatedCharacter = null;
         var inviStep:FightChangeVisibilityStep = null;
         var fighterId:Number = fighterInfos.contextualId;
         if(fighterInfos.spawnInfo.alive)
         {
            lastInvisibilityStat = -1;
            lastFighterInfo = _entities[fighterId] as GameFightFighterInformations;
            if(lastFighterInfo)
            {
               lastInvisibilityStat = lastFighterInfo.stats.invisibilityState;
            }
            ac = this.addOrUpdateActor(fighterInfos,animationModifier);
            if(lastInvisibilityStat == GameActionFightInvisibilityStateEnum.INVISIBLE && fighterInfos.stats.invisibilityState == lastInvisibilityStat)
            {
               registerActor(fighterInfos);
               return;
            }
            if(lastFighterInfo != fighterInfos)
            {
               if(fighterId == CurrentPlayedFighterManager.getInstance().currentFighterId)
               {
                  KernelEventsManager.getInstance().processCallback(HookList.CharacterStatsList);
               }
            }
            if(fighterInfos.stats.invisibilityState != GameActionFightInvisibilityStateEnum.VISIBLE && fighterInfos.stats.invisibilityState != lastInvisibilityStat)
            {
               inviStep = new FightChangeVisibilityStep(fighterId,fighterInfos.stats.invisibilityState);
               inviStep.start();
            }
            this.addCircleToFighter(ac,getTeamCircleColor(fighterInfos.spawnInfo.teamId));
         }
         else
         {
            this.updateActor(fighterInfos,false);
         }
         this.updateCarriedEntities(fighterInfos);
      }
      
      public function isEntityAlive(entityId:Number) : Boolean
      {
         if(!hasEntity(entityId))
         {
            return false;
         }
         var entityInfo:GameContextActorInformations = getEntityInfos(entityId);
         return entityInfo is GameFightFighterInformations && (entityInfo as GameFightFighterInformations).spawnInfo.alive;
      }
      
      public function updateActor(actorInfos:GameContextActorInformations, alive:Boolean = true, animationModifier:IAnimationModifier = null) : void
      {
         if(alive)
         {
            this.addOrUpdateActor(actorInfos,animationModifier);
         }
         else
         {
            if(_entities[actorInfos.contextualId])
            {
               hideActor(actorInfos.contextualId);
            }
            registerActor(actorInfos);
         }
      }
      
      override protected function updateActorLook(actorId:Number, newLook:EntityLook, smoke:Boolean = false) : AnimatedCharacter
      {
         var ac:AnimatedCharacter = super.updateActorLook(actorId,newLook,smoke);
         if(ac && actorId != PlayedCharacterManager.getInstance().id)
         {
            KernelEventsManager.getInstance().processCallback(HookList.FighterLookChange,actorId,LookCleaner.clean(ac.look));
         }
         return ac;
      }
      
      public function addCircleToFighter(pAc:TiphonSprite, pColor:uint) : void
      {
         var circle:Sprite = new Sprite();
         var teamCircle:Sprite = EmbedAssets.getSprite("TEAM_CIRCLE_CLIP");
         circle.addChild(teamCircle);
         var colorTransform:ColorTransform = new ColorTransform();
         colorTransform.color = pColor;
         circle.filters = [new GlowFilter(16777215,0.5,2,2,3,3)];
         teamCircle.transform.colorTransform = colorTransform;
         pAc.addBackground("teamCircle",circle);
      }
      
      private function updateCarriedEntities(fighterInfos:GameContextActorInformations) : void
      {
         var infos:TmpFighterInfos = null;
         var carryingCharacterId:Number = NaN;
         var fedi:FightEntityDispositionInformations = null;
         var carryingEntity:IEntity = null;
         var carriedEntity:IEntity = null;
         var hasCarryingModifier:Boolean = false;
         var carryingTs:TiphonSprite = null;
         var modifier:IAnimationModifier = null;
         var fighterId:Number = fighterInfos.contextualId;
         var num:int = this._tempFighterList.length;
         var i:int = 0;
         while(i < num)
         {
            infos = this._tempFighterList[i];
            carryingCharacterId = infos.carryingCharacterId;
            if(fighterId == carryingCharacterId)
            {
               this._tempFighterList.splice(i,1);
               this.startCarryStep(carryingCharacterId,infos.contextualId);
               break;
            }
            i++;
         }
         if(fighterInfos.disposition is FightEntityDispositionInformations)
         {
            fedi = fighterInfos.disposition as FightEntityDispositionInformations;
            if(fedi.carryingCharacterId)
            {
               carryingEntity = DofusEntities.getEntity(fedi.carryingCharacterId);
               if(!carryingEntity)
               {
                  this._tempFighterList.push(new TmpFighterInfos(fighterInfos.contextualId,fedi.carryingCharacterId));
               }
               else
               {
                  carriedEntity = DofusEntities.getEntity(fighterInfos.contextualId);
                  if(carriedEntity)
                  {
                     hasCarryingModifier = false;
                     if((carryingEntity as AnimatedCharacter).isMounted())
                     {
                        carryingTs = (carryingEntity as TiphonSprite).getSubEntitySlot(2,0) as TiphonSprite;
                     }
                     else
                     {
                        carryingTs = carryingEntity as TiphonSprite;
                     }
                     if(carryingTs)
                     {
                        carryingTs.removeAnimationModifierByClass(CustomBreedAnimationModifier);
                        for each(modifier in carryingTs.animationModifiers)
                        {
                           if(modifier is CarrierAnimationModifier)
                           {
                              hasCarryingModifier = true;
                              break;
                           }
                        }
                        if(!hasCarryingModifier)
                        {
                           carryingTs.addAnimationModifier(CarrierAnimationModifier.getInstance());
                        }
                     }
                     if(!hasCarryingModifier || !(carryingEntity is TiphonSprite && carriedEntity is TiphonSprite && TiphonSprite(carriedEntity).parentSprite == carryingEntity))
                     {
                        this.startCarryStep(fedi.carryingCharacterId,fighterInfos.contextualId);
                     }
                  }
               }
            }
         }
      }
      
      private function startCarryStep(fighterId:Number, carriedId:Number) : void
      {
         var step:FightCarryCharacterStep = new FightCarryCharacterStep(fighterId,carriedId,-1,true);
         step.start();
         FightEventsHelper.sendAllFightEvent();
      }
      
      public function updateAllEntitiesNumber(ids:Vector.<Number>) : void
      {
         var id:Number = NaN;
         var num:uint = 1;
         for each(id in ids)
         {
            if(_entities[id] && _entities[id].spawnInfo.alive)
            {
               this.updateEntityNumber(id,num);
               num++;
            }
         }
      }
      
      public function updateEntityNumber(id:Number, num:uint) : void
      {
         var number:Sprite = null;
         var lbl_number:Label = null;
         var ac:AnimatedCharacter = null;
         if(_entities[id] && (!(_entities[id] is GameFightCharacterInformations) || GameFightCharacterInformations(_entities[id]).spawnInfo.alive))
         {
            if(!this._entitiesNumber[id] || this._entitiesNumber[id] == null)
            {
               number = new Sprite();
               lbl_number = new Label();
               lbl_number.width = 30;
               lbl_number.height = 20;
               lbl_number.x = -45;
               lbl_number.y = -15;
               lbl_number.css = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin") + "css/normal.css");
               lbl_number.text = num.toString();
               number.addChild(lbl_number);
               number.filters = [new GlowFilter(XmlConfig.getInstance().getEntry("colors.text.glow"),1,4,4,6,3)];
               this._entitiesNumber[id] = lbl_number;
               ac = DofusEntities.getEntity(id) as AnimatedCharacter;
               if(ac)
               {
                  ac.addBackground("fighterNumber",number);
               }
            }
            else
            {
               this._entitiesNumber[id].text = num.toString();
            }
         }
      }
      
      public function updateRemovedEntity(idEntity:Number) : void
      {
         var num:uint = 0;
         var fightBFrame:FightBattleFrame = null;
         var entId:Number = NaN;
         this._entitiesNumber[idEntity] = null;
         if(Dofus.getInstance().options.getOption("orderFighters"))
         {
            num = 1;
            fightBFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
            for each(entId in fightBFrame.fightersList)
            {
               if(entId != idEntity && (getEntityInfos(entId) as GameFightFighterInformations).spawnInfo.alive)
               {
                  this.updateEntityNumber(entId,num);
                  num++;
               }
            }
         }
      }
      
      public function updateEntityIconPosition(pEntityId:Number) : void
      {
         var tooltip:UiRootContainer = null;
         var bounds:IRectangle = null;
         var entity:AnimatedCharacter = DofusEntities.getEntity(pEntityId) as AnimatedCharacter;
         if(entity && entity.parent && entity.displayed && hasIcon(pEntityId))
         {
            tooltip = Berilia.getInstance().getUi("tooltip_tooltipOverEntity_" + pEntityId);
            bounds = !tooltip ? getIconEntityBounds(DofusEntities.getEntity(pEntityId) as AnimatedCharacter) : new Rectangle2(tooltip.x,tooltip.y,tooltip.width,tooltip.height);
            getIcon(pEntityId).place(bounds);
         }
      }
      
      override protected function onPropertyChanged(e:PropertyChangeEvent) : void
      {
         var id:* = null;
         var ac:AnimatedCharacter = null;
         var num:uint = 0;
         var fightBFrame:FightBattleFrame = null;
         var entId:Number = NaN;
         if(!_worldPoint)
         {
            _worldPoint = PlayedCharacterManager.getInstance().currentMap;
         }
         if(!_currentSubAreaId)
         {
            _currentSubAreaId = PlayedCharacterManager.getInstance().currentSubArea.id;
         }
         super.onPropertyChanged(e);
         if(e.propertyName == "cellSelectionOnly")
         {
            untargetableEntities = e.propertyValue || Kernel.getWorker().getFrame(FightPreparationFrame);
         }
         else if(e.propertyName == "orderFighters")
         {
            if(!e.propertyValue)
            {
               for(id in this._entitiesNumber)
               {
                  if(this._entitiesNumber[Number(id)])
                  {
                     this._entitiesNumber[Number(id)] = null;
                     ac = DofusEntities.getEntity(Number(id)) as AnimatedCharacter;
                     if(ac)
                     {
                        ac.removeBackground("fighterNumber");
                     }
                  }
               }
            }
            else
            {
               num = 1;
               fightBFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
               if(fightBFrame)
               {
                  for each(entId in fightBFrame.fightersList)
                  {
                     if((getEntityInfos(entId) as GameFightFighterInformations).spawnInfo.alive)
                     {
                        this.updateEntityNumber(entId,num);
                        num++;
                     }
                  }
               }
            }
         }
         else if(e.propertyName == "showMountsInFight")
         {
            this.switchMountsVisibility(e.propertyValue);
         }
      }
      
      public function set cellSelectionOnly(enabled:Boolean) : void
      {
         var infos:GameContextActorInformations = null;
         var entity:AnimatedCharacter = null;
         for each(infos in _entities)
         {
            entity = DofusEntities.getEntity(infos.contextualId) as AnimatedCharacter;
            if(entity)
            {
               entity.mouseEnabled = !enabled;
            }
         }
      }
      
      public function get dematerialization() : Boolean
      {
         return _creaturesFightMode;
      }
      
      public function get lastKnownPlayerStatus() : Dictionary
      {
         return this._lastKnownPlayerStatus;
      }
      
      public function getRealFighterLook(pFighterId:Number) : EntityLook
      {
         return this._realFightersLooks[pFighterId];
      }
      
      public function setRealFighterLook(pFighterId:Number, pEntityLook:EntityLook) : void
      {
         this._realFightersLooks[pFighterId] = pEntityLook;
      }
      
      public function get charactersMountsVisible() : Boolean
      {
         return this._mountsVisible;
      }
      
      public function getEntityTeamId(entityId:Number) : Number
      {
         if(!(entityId in _entities) || !(_entities[entityId] is GameFightFighterInformations))
         {
            return -1;
         }
         var entitiesInfo:GameContextActorPositionInformations = _entities[entityId];
         if(!(entitiesInfo is GameFightFighterInformations))
         {
            return -1;
         }
         return (entitiesInfo as GameFightFighterInformations).spawnInfo.teamId;
      }
      
      public function getEntityIdsWithTeamId(teamId:Number) : Vector.<Number>
      {
         var entityInfo:GameFightFighterInformations = null;
         var entityIds:Vector.<Number> = new Vector.<Number>(0);
         if(teamId < 0)
         {
            return entityIds;
         }
         for each(entityInfo in _entities)
         {
            if(entityInfo !== null && entityInfo.spawnInfo.teamId === teamId)
            {
               entityIds.push(entityInfo.contextualId);
            }
         }
         return entityIds;
      }
      
      override protected function updateActorDisposition(actorId:Number, newDisposition:EntityDispositionInformations) : void
      {
         var actor:IEntity = null;
         super.updateActorDisposition(actorId,newDisposition);
         if(newDisposition.cellId == -1)
         {
            actor = DofusEntities.getEntity(actorId);
            if(actor)
            {
               FightEntitiesHolder.getInstance().holdEntity(actor);
            }
         }
         else
         {
            FightEntitiesHolder.getInstance().unholdEntity(actorId);
         }
      }
      
      private function getTmpFighterInfoIndex(pId:Number) : Number
      {
         var infos:TmpFighterInfos = null;
         for each(infos in this._tempFighterList)
         {
            if(infos.contextualId == pId)
            {
               return this._tempFighterList.indexOf(infos);
            }
         }
         return -1;
      }
   }
}

class TmpFighterInfos
{
    
   
   public var contextualId:Number;
   
   public var carryingCharacterId:Number;
   
   function TmpFighterInfos(pId:Number, pCarryindId:Number)
   {
      super();
      this.contextualId = pId;
      this.carryingCharacterId = pCarryindId;
   }
}
