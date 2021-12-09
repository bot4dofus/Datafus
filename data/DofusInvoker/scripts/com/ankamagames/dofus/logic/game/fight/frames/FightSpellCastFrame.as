package com.ankamagames.dofus.logic.game.fight.frames
{
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.data.map.CellData;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.managers.*;
   import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.atouin.messages.CellOutMessage;
   import com.ankamagames.atouin.messages.CellOverMessage;
   import com.ankamagames.atouin.renderers.*;
   import com.ankamagames.atouin.types.*;
   import com.ankamagames.atouin.utils.CellUtil;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.atouin.utils.IFightZoneRenderer;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.types.data.LinkedCursorData;
   import com.ankamagames.berilia.types.tooltip.TooltipPlacer;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.actions.BannerEmptySlotClickAction;
   import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityClickAction;
   import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOutAction;
   import com.ankamagames.dofus.logic.game.fight.actions.TimelineEntityOverAction;
   import com.ankamagames.dofus.logic.game.fight.frames.Preview.DamagePreview;
   import com.ankamagames.dofus.logic.game.fight.managers.CurrentPlayedFighterManager;
   import com.ankamagames.dofus.logic.game.fight.managers.LinkedCellsManager;
   import com.ankamagames.dofus.logic.game.fight.managers.MarkedCellsManager;
   import com.ankamagames.dofus.logic.game.fight.managers.SpellZoneManager;
   import com.ankamagames.dofus.logic.game.fight.types.FightSummonPreview;
   import com.ankamagames.dofus.logic.game.fight.types.FightTeleportationPreview;
   import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
   import com.ankamagames.dofus.logic.game.fight.types.SpellDamage;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.GameActionFightInvisibilityStateEnum;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCastOnTargetRequestMessage;
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightCastRequestMessage;
   import com.ankamagames.dofus.network.messages.game.chat.ChatClientMultiMessage;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightCharacterInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.types.entities.Glyph;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.messages.EntityClickMessage;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOutMessage;
   import com.ankamagames.jerakine.entities.messages.EntityMouseOverMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.map.*;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.zones.Cross;
   import com.ankamagames.jerakine.types.zones.Custom;
   import com.ankamagames.jerakine.types.zones.IZone;
   import com.ankamagames.jerakine.types.zones.Lozenge;
   import com.ankamagames.jerakine.utils.display.Dofus2Line;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.KeyPoll;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import damageCalculation.damageManagement.EffectOutput;
   import damageCalculation.fighterManagement.HaxeFighter;
   import damageCalculation.tools.StatIds;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import haxe.ds._List.ListNode;
   import tools.BreedEnum;
   import tools.enumeration.GameActionMarkTypeEnum;
   
   public class FightSpellCastFrame implements Frame
   {
      
      private static var SWF_LIB:String = XmlConfig.getInstance().getEntry("config.ui.skin").concat("assets_tacticmod.swf");
      
      private static const FORBIDDEN_CURSOR:Class = FightSpellCastFrame_FORBIDDEN_CURSOR;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(FightSpellCastFrame));
      
      private static const RANGE_COLOR:Color = new Color(5533093);
      
      private static const LOS_COLOR:Color = new Color(2241433);
      
      private static const POSSIBLE_TARGET_CELL_COLOR:Color = new Color(3359897);
      
      private static const PORTAL_COLOR:Color = new Color(251623);
      
      private static const TARGET_CENTER_COLOR:Color = new Color(14487842);
      
      private static const TARGET_COLOR:Color = new Color(14487842);
      
      private static const SELECTION_RANGE:String = "SpellCastRange";
      
      private static const SELECTION_PORTALS:String = "SpellCastPortals";
      
      private static const SELECTION_LOS:String = "SpellCastLos";
      
      private static const SELECTION_TARGET:String = "SpellCastTarget";
      
      private static const SELECTION_CENTER_TARGET:String = "SELECTION_CENTER_TARGET";
      
      private static const FORBIDDEN_CURSOR_NAME:String = "SpellCastForbiddenCusror";
      
      private static const MAX_TOOLTIP:uint = 10;
      
      private static var _currentTargetIsTargetable:Boolean;
       
      
      private var _spellLevel:Object;
      
      private var _spellId:uint;
      
      private var _portalsSelection:Selection;
      
      private var _targetSelection:Selection;
      
      private var _targetCenterSelection:Selection;
      
      private var _currentCell:int = -1;
      
      private var _cancelTimer:BenchmarkTimer;
      
      private var _cursorData:LinkedCursorData;
      
      private var _lastTargetStatus:Boolean = true;
      
      private var _isInfiniteTarget:Boolean;
      
      private var _usedWrapper;
      
      private var _targetingThroughPortal:Boolean;
      
      private var _clearTargetTimer:BenchmarkTimer;
      
      private var _spellmaximumRange:uint;
      
      private var _fightTeleportationPreview:FightTeleportationPreview;
      
      private var _summoningPreview:FightSummonPreview;
      
      private var _currentCellEntity:AnimatedCharacter;
      
      private var _fightContextFrame:FightContextFrame;
      
      public function FightSpellCastFrame(spellId:uint)
      {
         var i:SpellWrapper = null;
         var weapon:WeaponWrapper = null;
         super();
         this._spellId = spellId;
         this._cursorData = new LinkedCursorData();
         this._cursorData.sprite = new FORBIDDEN_CURSOR();
         this._cursorData.sprite.cacheAsBitmap = true;
         this._cursorData.offset = new Point(14,14);
         this._cancelTimer = new BenchmarkTimer(50,0,"FightSpellCastFrame._cancelTimer");
         this._cancelTimer.addEventListener(TimerEvent.TIMER,this.cancelCast);
         if(spellId || !PlayedCharacterManager.getInstance().currentWeapon)
         {
            for each(i in PlayedCharacterManager.getInstance().spellsInventory)
            {
               if(i.spellId == this._spellId)
               {
                  this._spellLevel = i;
               }
            }
         }
         else
         {
            weapon = PlayedCharacterManager.getInstance().currentWeapon;
            this._spellLevel = {
               "effects":weapon.effects,
               "castTestLos":weapon.castTestLos,
               "castInLine":weapon.castInLine,
               "castInDiagonal":weapon.castInDiagonal,
               "minRange":weapon.minRange,
               "range":weapon.range,
               "apCost":weapon.apCost,
               "needFreeCell":false,
               "needTakenCell":false,
               "needFreeTrapCell":false,
               "name":weapon.name,
               "playerId":PlayedCharacterManager.getInstance().id
            };
         }
         this._clearTargetTimer = new BenchmarkTimer(50,1,"FightSpellCastFrame._clearTargetTimer");
         this._clearTargetTimer.addEventListener(TimerEvent.TIMER,this.onClearTarget);
      }
      
      public static function isCurrentTargetTargetable() : Boolean
      {
         return _currentTargetIsTargetable;
      }
      
      public static function updateRangeAndTarget() : void
      {
         var castFrame:FightSpellCastFrame = Kernel.getWorker().getFrame(FightSpellCastFrame) as FightSpellCastFrame;
         if(castFrame)
         {
            castFrame.removeRange();
            castFrame.drawRange();
            castFrame.refreshTarget(true);
         }
      }
      
      public function get priority() : int
      {
         return Priority.HIGHEST;
      }
      
      public function get hasSummoningPreview() : Boolean
      {
         return this._summoningPreview && this._summoningPreview.previews.length > 0;
      }
      
      public function get invocationPreview() : Vector.<AnimatedCharacter>
      {
         if(this._summoningPreview)
         {
            return this._summoningPreview.previews;
         }
         return null;
      }
      
      public function get spellId() : uint
      {
         return this._spellId;
      }
      
      public function pushed() : Boolean
      {
         var actorInfos:GameContextActorInformations = null;
         var fighterInfos:GameFightFighterInformations = null;
         var character:AnimatedCharacter = null;
         Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         this._fightContextFrame = Kernel.getWorker().getFrame(FightContextFrame) as FightContextFrame;
         var fef:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var fighters:Dictionary = fef.entities;
         for each(actorInfos in fighters)
         {
            fighterInfos = actorInfos as GameFightFighterInformations;
            character = DofusEntities.getEntity(fighterInfos.contextualId) as AnimatedCharacter;
            if(character && fighterInfos.contextualId != CurrentPlayedFighterManager.getInstance().currentFighterId && fighterInfos.stats.invisibilityState == GameActionFightInvisibilityStateEnum.DETECTED)
            {
               character.setCanSeeThrough(true);
               character.setCanWalkThrough(false);
               character.setCanWalkTo(false);
            }
         }
         this._cancelTimer.reset();
         this._lastTargetStatus = true;
         if(this._spellId == 0)
         {
            if(PlayedCharacterManager.getInstance().currentWeapon)
            {
               this._usedWrapper = PlayedCharacterManager.getInstance().currentWeapon;
            }
            else
            {
               this._usedWrapper = SpellWrapper.create(0,1,false,PlayedCharacterManager.getInstance().id);
            }
         }
         else
         {
            this._usedWrapper = SpellWrapper.getSpellWrapperById(this._spellId,CurrentPlayedFighterManager.getInstance().currentFighterId);
         }
         KernelEventsManager.getInstance().processCallback(HookList.CastSpellMode,this._usedWrapper);
         this.drawRange();
         this.refreshTarget();
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var conmsg:CellOverMessage = null;
         var comsg:CellOutMessage = null;
         var cellEntity:IEntity = null;
         var emomsg:EntityMouseOverMessage = null;
         var teoa:TimelineEntityOverAction = null;
         var timelineEntity:IEntity = null;
         var teouta:TimelineEntityOutAction = null;
         var outEntity:IEntity = null;
         var ccmsg:CellClickMessage = null;
         var ecmsg:EntityClickMessage = null;
         var teica:TimelineEntityClickAction = null;
         switch(true)
         {
            case msg is CellOverMessage:
               conmsg = msg as CellOverMessage;
               FightContextFrame.currentCell = conmsg.cellId;
               this.refreshTarget();
               return false;
            case msg is EntityMouseOutMessage:
               this.clearTarget();
               return false;
            case msg is CellOutMessage:
               comsg = msg as CellOutMessage;
               cellEntity = EntitiesManager.getInstance().getEntityOnCell(comsg.cellId,AnimatedCharacter);
               this.removeTeleportationPreview();
               this.removeSummoningPreview();
               this.clearTarget();
               return false;
            case msg is EntityMouseOverMessage:
               emomsg = msg as EntityMouseOverMessage;
               FightContextFrame.currentCell = emomsg.entity.position.cellId;
               this.refreshTarget();
               return false;
            case msg is TimelineEntityOverAction:
               teoa = msg as TimelineEntityOverAction;
               timelineEntity = DofusEntities.getEntity(teoa.targetId);
               if(timelineEntity && timelineEntity.position && timelineEntity.position.cellId > -1)
               {
                  FightContextFrame.currentCell = timelineEntity.position.cellId;
                  this.refreshTarget();
               }
               return false;
            case msg is TimelineEntityOutAction:
               teouta = msg as TimelineEntityOutAction;
               outEntity = DofusEntities.getEntity(teouta.targetId);
               this.removeTeleportationPreview();
               this.removeSummoningPreview();
               return false;
            case msg is CellClickMessage:
               ccmsg = msg as CellClickMessage;
               this.castSpell(ccmsg.cellId);
               return true;
            case msg is EntityClickMessage:
               ecmsg = msg as EntityClickMessage;
               if(this._summoningPreview && this._summoningPreview.isPreview(ecmsg.entity.id) || this._fightTeleportationPreview && this._fightTeleportationPreview.isPreview(ecmsg.entity.id))
               {
                  this.castSpell(ecmsg.entity.position.cellId);
               }
               else
               {
                  this.castSpell(ecmsg.entity.position.cellId,ecmsg.entity.id);
               }
               return true;
            case msg is TimelineEntityClickAction:
               teica = msg as TimelineEntityClickAction;
               this.castSpell(0,teica.fighterId,true);
               return true;
            case msg is AdjacentMapClickMessage:
            case msg is MouseRightClickMessage:
               this.cancelCast();
               return true;
            case msg is BannerEmptySlotClickAction:
               this.cancelCast();
               return true;
            case msg is MouseClickMessage:
               if(!KeyPoll.getInstance().isDown(Keyboard.ALTERNATE) && !((msg as MouseClickMessage).target is GraphicCell && this.isValidCell(GraphicCell((msg as MouseClickMessage).target).cellId)))
               {
                  this._cancelTimer.start();
               }
               return false;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         var fef:FightEntitiesFrame = null;
         var fighters:Dictionary = null;
         var actorInfos:GameContextActorInformations = null;
         var fighterInfos:GameFightFighterInformations = null;
         var character:AnimatedCharacter = null;
         Atouin.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
         var fbf:FightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
         if(fbf)
         {
            fef = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            fighters = fef.entities;
            for each(actorInfos in fighters)
            {
               fighterInfos = actorInfos as GameFightFighterInformations;
               character = DofusEntities.getEntity(actorInfos.contextualId) as AnimatedCharacter;
               if(character && actorInfos.contextualId != CurrentPlayedFighterManager.getInstance().currentFighterId && fighterInfos.stats.invisibilityState == GameActionFightInvisibilityStateEnum.VISIBLE)
               {
                  character.setCanSeeThrough(false);
                  character.setCanWalkThrough(false);
                  character.setCanWalkTo(false);
               }
            }
         }
         this._clearTargetTimer.stop();
         this._clearTargetTimer.removeEventListener(TimerEvent.TIMER,this.onClearTarget);
         this._cancelTimer.stop();
         this._cancelTimer.removeEventListener(TimerEvent.TIMER,this.cancelCast);
         this.hideTargetsTooltips();
         this.removeRange();
         this.removeTarget();
         this.removeSummoningPreview();
         LinkedCursorSpriteManager.getInstance().removeItem(FORBIDDEN_CURSOR_NAME);
         this.removeTeleportationPreview(true);
         try
         {
            KernelEventsManager.getInstance().processCallback(HookList.CancelCastSpell,SpellWrapper.getSpellWrapperById(this._spellId,CurrentPlayedFighterManager.getInstance().currentFighterId));
         }
         catch(e:Error)
         {
         }
         return true;
      }
      
      public function entityMovement(pEntityId:Number) : void
      {
         if(this._currentCellEntity && this._currentCellEntity.id == pEntityId)
         {
            this.removeSummoningPreview();
            if(this._fightTeleportationPreview)
            {
               this.removeTeleportationPreview();
            }
         }
         else if(this._fightTeleportationPreview && this._fightTeleportationPreview.getEntitiesIds().indexOf(pEntityId) != -1)
         {
            this.removeTeleportationPreview();
         }
      }
      
      public function refreshTarget(force:Boolean = false) : void
      {
         var currentFighterId:Number = NaN;
         var entityInfos:GameFightFighterInformations = null;
         var renderer:IFightZoneRenderer = null;
         var ignoreMaxSize:Boolean = false;
         var spellShape:uint = 0;
         var entityInfo:GameContextActorInformations = null;
         var cellId:int = 0;
         var spellZone:IZone = null;
         var updateStrata:Boolean = false;
         if(this._clearTargetTimer.running)
         {
            this._clearTargetTimer.reset();
         }
         var target:int = FightContextFrame.currentCell;
         if(target == -1)
         {
            return;
         }
         this._targetingThroughPortal = false;
         var newTarget:int = -1;
         if(SelectionManager.getInstance().isInside(target,SELECTION_PORTALS) && SelectionManager.getInstance().isInside(target,SELECTION_LOS) && this._spellId != 0)
         {
            newTarget = this.getTargetThroughPortal(target,true);
            if(newTarget != target)
            {
               this._targetingThroughPortal = true;
               target = newTarget;
            }
         }
         this.removeSummoningPreview();
         this.removeTeleportationPreview();
         if(!force && (this._currentCell == target && this._currentCell != newTarget))
         {
            if(this._targetSelection && this.isValidCell(target))
            {
               this.showTargetsTooltips();
            }
            return;
         }
         this._currentCell = target;
         var entitiesOnCell:Array = EntitiesManager.getInstance().getEntitiesOnCell(this._currentCell,AnimatedCharacter);
         this._currentCellEntity = entitiesOnCell.length > 0 ? this.getParentEntity(entitiesOnCell[0]) as AnimatedCharacter : null;
         var fightTurnFrame:FightTurnFrame = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
         if(!fightTurnFrame)
         {
            return;
         }
         var myTurn:Boolean = fightTurnFrame.myTurn;
         _currentTargetIsTargetable = this.isValidCell(target);
         if(_currentTargetIsTargetable)
         {
            if(!this._targetSelection)
            {
               this._targetSelection = new Selection();
               this._targetSelection.renderer = this.createZoneRenderer(TARGET_COLOR);
               this._targetSelection.color = TARGET_COLOR;
               this._targetCenterSelection = new Selection();
               this._targetCenterSelection.renderer = this.createZoneRenderer(TARGET_CENTER_COLOR,!!Atouin.getInstance().options.getOption("transparentOverlayMode") ? uint(PlacementStrataEnums.STRATA_NO_Z_ORDER) : uint(PlacementStrataEnums.STRATA_AREA));
               this._targetCenterSelection.color = TARGET_CENTER_COLOR;
               ignoreMaxSize = true;
               spellShape = this.getSpellShape();
               if(spellShape == SpellShapeEnum.l)
               {
                  ignoreMaxSize = false;
               }
               this._targetCenterSelection.zone = new Cross(0,0,DataMapProvider.getInstance());
               SelectionManager.getInstance().addSelection(this._targetCenterSelection,SELECTION_CENTER_TARGET);
               SelectionManager.getInstance().addSelection(this._targetSelection,SELECTION_TARGET);
            }
            if(!this._targetSelection.zone || this._targetSelection.zone is Custom)
            {
               entityInfo = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._spellLevel.playerId);
               if(entityInfo)
               {
                  cellId = entityInfo.disposition.cellId;
                  spellZone = SpellZoneManager.getInstance().getSpellZone(this._spellLevel,true,ignoreMaxSize,target,cellId);
                  this._spellmaximumRange = spellZone.radius;
                  this._targetSelection.zone = spellZone;
               }
            }
            currentFighterId = CurrentPlayedFighterManager.getInstance().currentFighterId;
            entityInfos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(currentFighterId) as GameFightFighterInformations;
            if(entityInfos)
            {
               if(this._targetingThroughPortal)
               {
                  this._targetSelection.zone.direction = MapPoint(MapPoint.fromCellId(entityInfos.disposition.cellId)).advancedOrientationTo(MapPoint.fromCellId(FightContextFrame.currentCell),false);
               }
               else
               {
                  this._targetSelection.zone.direction = MapPoint(MapPoint.fromCellId(entityInfos.disposition.cellId)).advancedOrientationTo(MapPoint.fromCellId(target),false);
               }
            }
            renderer = this._targetSelection.renderer as IFightZoneRenderer;
            if(Atouin.getInstance().options.getOption("transparentOverlayMode") && this._spellmaximumRange != 63)
            {
               renderer.currentStrata = PlacementStrataEnums.STRATA_NO_Z_ORDER;
               SelectionManager.getInstance().update(SELECTION_TARGET,target,true);
               SelectionManager.getInstance().update(SELECTION_CENTER_TARGET,target,true);
            }
            else
            {
               if(renderer.currentStrata == PlacementStrataEnums.STRATA_NO_Z_ORDER)
               {
                  renderer.currentStrata = PlacementStrataEnums.STRATA_AREA;
                  updateStrata = true;
               }
               SelectionManager.getInstance().update(SELECTION_TARGET,target,updateStrata);
               SelectionManager.getInstance().update(SELECTION_CENTER_TARGET,target,updateStrata);
            }
            if(myTurn)
            {
               LinkedCursorSpriteManager.getInstance().removeItem(FORBIDDEN_CURSOR_NAME);
               this._lastTargetStatus = true;
            }
            else
            {
               if(this._lastTargetStatus)
               {
                  LinkedCursorSpriteManager.getInstance().addItem(FORBIDDEN_CURSOR_NAME,this._cursorData,true);
               }
               this._lastTargetStatus = false;
            }
            this.showTargetsTooltips();
         }
         else
         {
            if(this._lastTargetStatus)
            {
               LinkedCursorSpriteManager.getInstance().addItem(FORBIDDEN_CURSOR_NAME,this._cursorData,true);
            }
            this.removeTarget();
            this._lastTargetStatus = false;
            this.hideTargetsTooltips();
         }
      }
      
      public function isTeleportationPreviewEntity(pEntityId:Number) : Boolean
      {
         return this._fightTeleportationPreview && this._fightTeleportationPreview.isPreview(pEntityId);
      }
      
      public function isSummoningPreviewEntity(pEntityId:Number) : Boolean
      {
         return this._summoningPreview && this._summoningPreview.isPreview(pEntityId);
      }
      
      public function getSummonPreview(pEntityId:Number) : AnimatedCharacter
      {
         if(this._summoningPreview)
         {
            return this._summoningPreview.getSummonPreview(pEntityId);
         }
         return null;
      }
      
      public function drawRange() : void
      {
         var shapePlus:Cross = null;
         var selectionCellId:uint = 0;
         var noLosRangeCell:Vector.<uint> = null;
         var losRangeCell:Vector.<uint> = null;
         var num:int = 0;
         var i:int = 0;
         var cellId:uint = 0;
         var cAfterPortal:int = 0;
         var exitPortal:int = 0;
         var c:uint = 0;
         var entryMarkPortal:MarkInstance = null;
         var teamPortals:Vector.<MapPoint> = null;
         var portalsCellIds:Vector.<uint> = null;
         var lastPortalMp:MapPoint = null;
         var newTargetMp:MapPoint = null;
         var cellsFromLine:Array = null;
         var mp:MapPoint = null;
         var cellFromLine:Point = null;
         var cellsWithLosOk:Vector.<uint> = null;
         if(this._spellLevel == null)
         {
            return;
         }
         var currentFighterId:Number = CurrentPlayedFighterManager.getInstance().currentFighterId;
         var entityInfos:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(currentFighterId) as GameFightFighterInformations;
         var origin:uint = entityInfos.disposition.cellId;
         var playerStats:EntityStats = CurrentPlayedFighterManager.getInstance().getStats();
         var range:int = this._spellLevel.range;
         var minRange:int = this._spellLevel.minRange;
         var spellShape:uint = this.getSpellShape();
         var castInLine:Boolean = this._spellLevel.castInLine || spellShape == SpellShapeEnum.l;
         var mpWithPortals:Vector.<MapPoint> = MarkedCellsManager.getInstance().getMarksMapPoint(GameActionMarkTypeEnum.PORTAL);
         if(!castInLine && !this._spellLevel.castInDiagonal && !this._spellLevel.castTestLos && range == 63)
         {
            this._isInfiniteTarget = true;
            if(mpWithPortals == null || mpWithPortals.length < 2)
            {
               return;
            }
         }
         else
         {
            this._isInfiniteTarget = false;
         }
         if(this._spellLevel["rangeCanBeBoosted"])
         {
            range += playerStats.getStatTotalValue(StatIds.RANGE) - playerStats.getStatAdditionalValue(StatIds.RANGE);
         }
         if(range < minRange)
         {
            range = minRange;
         }
         range = Math.min(range,AtouinConstants.MAP_WIDTH * AtouinConstants.MAP_HEIGHT);
         if(range < 0)
         {
            range = 0;
         }
         var rangeSelection:Selection = new Selection();
         rangeSelection.renderer = this.createZoneRenderer(RANGE_COLOR,PlacementStrataEnums.STRATA_AREA);
         rangeSelection.color = RANGE_COLOR;
         rangeSelection.alpha = true;
         if(castInLine && this._spellLevel.castInDiagonal)
         {
            shapePlus = new Cross(minRange,range,DataMapProvider.getInstance());
            shapePlus.allDirections = true;
            rangeSelection.zone = shapePlus;
         }
         else if(castInLine)
         {
            rangeSelection.zone = new Cross(minRange,range,DataMapProvider.getInstance());
         }
         else if(this._spellLevel.castInDiagonal)
         {
            shapePlus = new Cross(minRange,range,DataMapProvider.getInstance());
            shapePlus.diagonal = true;
            rangeSelection.zone = shapePlus;
         }
         else
         {
            rangeSelection.zone = new Lozenge(minRange,range,DataMapProvider.getInstance());
         }
         var untargetableCells:Vector.<uint> = new Vector.<uint>();
         var losSelection:Selection = new Selection();
         if(!this._isInfiniteTarget)
         {
            losSelection.renderer = this.createZoneRenderer(LOS_COLOR,PlacementStrataEnums.STRATA_AREA);
            losSelection.color = LOS_COLOR;
         }
         var allCells:Vector.<uint> = rangeSelection.zone.getCells(origin);
         if(!this._spellLevel.castTestLos)
         {
            losSelection.zone = new Custom(allCells);
         }
         else
         {
            losSelection.zone = new Custom(LosDetector.getCell(DataMapProvider.getInstance(),allCells,MapPoint.fromCellId(origin)));
            rangeSelection.renderer = this.createZoneRenderer(POSSIBLE_TARGET_CELL_COLOR,PlacementStrataEnums.STRATA_AREA);
            noLosRangeCell = rangeSelection.zone.getCells(origin);
            losRangeCell = losSelection.zone.getCells(origin);
            num = noLosRangeCell.length;
            for(i = 0; i < num; i++)
            {
               cellId = noLosRangeCell[i];
               if(losRangeCell.indexOf(cellId) == -1)
               {
                  untargetableCells.push(cellId);
               }
            }
         }
         var portalUsableCells:Vector.<uint> = new Vector.<uint>();
         var cells:Vector.<uint> = new Vector.<uint>();
         if(mpWithPortals && mpWithPortals.length >= 2)
         {
            for each(c in losSelection.zone.getCells(origin))
            {
               cAfterPortal = this.getTargetThroughPortal(c);
               if(cAfterPortal != c)
               {
                  this._targetingThroughPortal = true;
                  if(this.isValidCell(cAfterPortal,true))
                  {
                     if(this._spellLevel.castTestLos)
                     {
                        entryMarkPortal = MarkedCellsManager.getInstance().getMarkAtCellId(c,GameActionMarkTypeEnum.PORTAL);
                        teamPortals = MarkedCellsManager.getInstance().getMarksMapPoint(GameActionMarkTypeEnum.PORTAL,entryMarkPortal.teamId);
                        portalsCellIds = LinkedCellsManager.getInstance().getLinks(MapPoint.fromCellId(c),teamPortals);
                        exitPortal = portalsCellIds.pop();
                        lastPortalMp = MapPoint.fromCellId(exitPortal);
                        newTargetMp = MapPoint.fromCellId(cAfterPortal);
                        cellsFromLine = Dofus2Line.getLine(lastPortalMp.cellId,newTargetMp.cellId);
                        for each(cellFromLine in cellsFromLine)
                        {
                           mp = MapPoint.fromCoords(cellFromLine.x,cellFromLine.y);
                           cells.push(mp.cellId);
                        }
                        cellsWithLosOk = LosDetector.getCell(DataMapProvider.getInstance(),cells,lastPortalMp);
                        if(cellsWithLosOk.indexOf(cAfterPortal) > -1)
                        {
                           portalUsableCells.push(c);
                        }
                        else
                        {
                           untargetableCells.push(c);
                        }
                     }
                     else
                     {
                        portalUsableCells.push(c);
                     }
                  }
                  else
                  {
                     untargetableCells.push(c);
                  }
                  this._targetingThroughPortal = false;
               }
            }
         }
         var losCells:Vector.<uint> = new Vector.<uint>();
         var losSelectionCells:Vector.<uint> = losSelection.zone.getCells(origin);
         for each(selectionCellId in losSelectionCells)
         {
            if(portalUsableCells.indexOf(selectionCellId) != -1)
            {
               losCells.push(selectionCellId);
            }
            else if(this._usedWrapper is SpellWrapper && this._usedWrapper.spellLevelInfos && (this._usedWrapper.spellLevelInfos.needFreeCell && this.cellHasEntity(selectionCellId) || this._usedWrapper.spellLevelInfos.needFreeTrapCell && MarkedCellsManager.getInstance().cellHasTrap(selectionCellId)))
            {
               untargetableCells.push(selectionCellId);
            }
            else if(untargetableCells.indexOf(selectionCellId) == -1)
            {
               losCells.push(selectionCellId);
            }
         }
         losSelection.zone = new Custom(losCells);
         SelectionManager.getInstance().addSelection(losSelection,SELECTION_LOS,origin);
         if(untargetableCells.length > 0)
         {
            rangeSelection.zone = new Custom(untargetableCells);
            SelectionManager.getInstance().addSelection(rangeSelection,SELECTION_RANGE,origin);
         }
         else
         {
            rangeSelection.zone = new Custom(new Vector.<uint>());
            SelectionManager.getInstance().addSelection(rangeSelection,SELECTION_RANGE,origin);
         }
         if(portalUsableCells.length > 0)
         {
            this._portalsSelection = new Selection();
            this._portalsSelection.renderer = this.createZoneRenderer(PORTAL_COLOR,PlacementStrataEnums.STRATA_AREA);
            this._portalsSelection.color = PORTAL_COLOR;
            this._portalsSelection.alpha = true;
            this._portalsSelection.zone = new Custom(portalUsableCells);
            SelectionManager.getInstance().addSelection(this._portalsSelection,SELECTION_PORTALS,origin);
         }
      }
      
      private function removeTeleportationPreview(destroy:Boolean = false) : void
      {
         if(this._fightTeleportationPreview)
         {
            this._fightTeleportationPreview.remove(destroy);
            if(destroy)
            {
               this._fightTeleportationPreview = null;
            }
         }
      }
      
      private function removeSummoningPreview() : void
      {
         if(this._summoningPreview)
         {
            this._summoningPreview.remove();
         }
      }
      
      private function getParentEntity(pEntity:TiphonSprite) : TiphonSprite
      {
         var parentEntity:TiphonSprite = null;
         var parent:TiphonSprite = pEntity.parentSprite;
         while(parent)
         {
            parentEntity = parent;
            parent = parent.parentSprite;
         }
         return !parentEntity ? pEntity : parentEntity;
      }
      
      private function showTargetsTooltips() : void
      {
         var paramsToShow:Vector.<Object> = null;
         var movedFighters:Vector.<HaxeFighter> = null;
         var summonedFighters:Vector.<HaxeFighter> = null;
         var limitedParams:Vector.<Object> = null;
         var result:Object = null;
         var entityId:Number = NaN;
         var hide:Boolean = false;
         var params:Object = null;
         var movementPreview:AnimatedCharacter = null;
         var entId:Number = NaN;
         var entity:AnimatedCharacter = null;
         var entitiesIds:Vector.<Number> = this._fightContextFrame.entitiesFrame.getEntitiesIdsList();
         var showDamages:Boolean = this._spellLevel && OptionManager.getOptionManager("dofus").getOption("showDamagesPreview") == true && FightSpellCastFrame.isCurrentTargetTargetable();
         var showMove:Boolean = this._spellLevel && OptionManager.getOptionManager("dofus").getOption("showMovePreview") == true && FightSpellCastFrame.isCurrentTargetTargetable();
         if(showDamages || showMove)
         {
            result = this.damagePreview();
            paramsToShow = result.damages;
            movedFighters = result.movements;
            summonedFighters = result.summoned;
         }
         this._fightContextFrame.removeSpellTargetsTooltips();
         if(showMove && movedFighters)
         {
            this.removeSummoningPreview();
            if(summonedFighters.length > 0)
            {
               this._summoningPreview = new FightSummonPreview(summonedFighters);
               this._summoningPreview.show();
            }
            this.removeTeleportationPreview();
            if(movedFighters.length > 0)
            {
               if(!this._fightTeleportationPreview)
               {
                  this._fightTeleportationPreview = new FightTeleportationPreview(movedFighters);
               }
               else
               {
                  this._fightTeleportationPreview.init(movedFighters);
               }
               this._fightTeleportationPreview.show(this);
            }
         }
         if(paramsToShow)
         {
            limitedParams = paramsToShow.slice(0,MAX_TOOLTIP);
            for each(entityId in entitiesIds)
            {
               hide = true;
               if(limitedParams)
               {
                  for each(params in limitedParams)
                  {
                     if(params.fighterId == entityId)
                     {
                        if(this._fightTeleportationPreview != null)
                        {
                           movementPreview = this._fightTeleportationPreview.getPreview(entityId);
                           if(movementPreview != null)
                           {
                              params.previewEntity = movementPreview;
                           }
                        }
                        TooltipPlacer.waitBeforeOrder("tooltip_tooltipOverEntity_" + entityId);
                        hide = false;
                        break;
                     }
                  }
               }
               if(hide)
               {
                  TooltipManager.hide("tooltip_tooltipOverEntity_" + entityId);
               }
            }
         }
         else
         {
            for each(entId in entitiesIds)
            {
               TooltipManager.hide("tooltip_tooltipOverEntity_" + entId);
            }
         }
         if(showDamages && limitedParams && limitedParams.length > 0)
         {
            EnterFrameDispatcher.worker.addForeachTreatment(this,this.displayEntityTooltipTreatment,[this._spellLevel,this._currentCell],limitedParams);
         }
         else
         {
            entity = EntitiesManager.getInstance().getEntityOnCell(this._currentCell,AnimatedCharacter) as AnimatedCharacter;
            if(entity != null)
            {
               this._fightContextFrame.displayEntityTooltip(entity.id,null,false,this._currentCell);
            }
         }
      }
      
      private function displayEntityTooltipTreatment(params:Object, spellLevel:int, currentCell:int) : void
      {
         this._fightContextFrame.displayEntityTooltip(params.fighterId,spellLevel,true,currentCell,params);
      }
      
      public function damagePreview() : Object
      {
         var currentFighter:HaxeFighter = null;
         var infos:GameFightCharacterInformations = null;
         var spellDamage:SpellDamage = null;
         var cursor:ListNode = null;
         var params:Object = null;
         var currentEffect:EffectOutput = null;
         var affectedFighters:Array = DamagePreview.computePreview(this._fightContextFrame,this._spellLevel,CurrentPlayedFighterManager.getInstance().currentFighterId,this._currentCell);
         var movedFighters:Vector.<HaxeFighter> = new Vector.<HaxeFighter>();
         var summonedFighters:Vector.<HaxeFighter> = new Vector.<HaxeFighter>();
         var paramsToShow:Vector.<Object> = new Vector.<Object>();
         var currentCharacterIsXelor:Boolean = false;
         var entityInfos:GameContextActorInformations = this._fightContextFrame.entitiesFrame.getEntityInfos(CurrentPlayedFighterManager.getInstance().currentFighterId);
         if(entityInfos is GameFightCharacterInformations)
         {
            infos = GameFightCharacterInformations(entityInfos);
            if(infos != null && infos.breed == BreedEnum.Xelor)
            {
               currentCharacterIsXelor = true;
            }
         }
         for each(currentFighter in affectedFighters)
         {
            spellDamage = new SpellDamage();
            cursor = currentFighter.totalEffects.h;
            params = {};
            while(cursor != null)
            {
               currentEffect = cursor.item as EffectOutput;
               if(currentEffect.damageRange != null)
               {
                  if(currentEffect.shield != null && !currentEffect.shield.isZero())
                  {
                     spellDamage.addDamageRange(currentEffect.computeShieldDamage());
                  }
                  spellDamage.addDamageRange(currentEffect.computeLifeDamage());
                  if(currentEffect.unknown)
                  {
                     spellDamage.unknownDamage = true;
                  }
               }
               else if(currentEffect.movement != null || currentEffect.isPulled || currentEffect.isPushed)
               {
                  if(movedFighters.indexOf(currentFighter) == -1)
                  {
                     movedFighters.push(currentFighter);
                  }
                  if(currentEffect.movement != null && currentEffect.movement.swappedWith != null && currentCharacterIsXelor)
                  {
                     spellDamage.telefrag = true;
                  }
               }
               else if(currentEffect.summon != null)
               {
                  summonedFighters.push(currentFighter);
               }
               cursor = cursor.next;
            }
            if(spellDamage.hasDamage())
            {
               spellDamage.updateDamage();
               params.spellDamage = spellDamage;
            }
            params.fighterId = currentFighter.id;
            paramsToShow.push(params);
         }
         return {
            "damages":paramsToShow,
            "movements":movedFighters,
            "summoned":summonedFighters
         };
      }
      
      private function hideTargetsTooltips() : void
      {
         var entityId:Number = NaN;
         var ac:AnimatedCharacter = null;
         if(!this._fightContextFrame || !this._fightContextFrame.entitiesFrame)
         {
            return;
         }
         var entitiesId:Vector.<Number> = this._fightContextFrame.entitiesFrame.getEntitiesIdsList();
         var overEntity:IEntity = EntitiesManager.getInstance().getEntityOnCell(FightContextFrame.currentCell,AnimatedCharacter);
         if(overEntity)
         {
            ac = overEntity as AnimatedCharacter;
            if(ac && ac.parentSprite && ac.parentSprite.carriedEntity == ac)
            {
               overEntity = ac.parentSprite as AnimatedCharacter;
            }
         }
         for each(entityId in entitiesId)
         {
            if(!this._fightContextFrame.showPermanentTooltips || this._fightContextFrame.showPermanentTooltips && this._fightContextFrame.battleFrame.targetedEntities.indexOf(entityId) == -1)
            {
               TooltipManager.hide("tooltipOverEntity_" + entityId);
            }
         }
         if(this._fightContextFrame.showPermanentTooltips && this._fightContextFrame.battleFrame && this._fightContextFrame.battleFrame.targetedEntities && this._fightContextFrame.battleFrame.targetedEntities.length > 0)
         {
            for each(entityId in this._fightContextFrame.battleFrame.targetedEntities)
            {
               if(!overEntity || entityId != overEntity.id)
               {
                  this._fightContextFrame.displayEntityTooltip(entityId);
               }
            }
         }
         if(overEntity)
         {
            this._fightContextFrame.displayEntityTooltip(overEntity.id);
         }
      }
      
      private function clearTarget() : void
      {
         if(!this._clearTargetTimer.running)
         {
            this._clearTargetTimer.start();
         }
      }
      
      private function onClearTarget(event:TimerEvent) : void
      {
         this.refreshTarget();
      }
      
      private function getTargetThroughPortal(target:int, drawLinks:Boolean = false) : int
      {
         var targetPortal:MapPoint = null;
         var portalMark:MarkInstance = null;
         var portalp:MapPoint = null;
         var effect:EffectInstance = null;
         var newTargetPoint:MapPoint = null;
         var entryVector:Vector.<uint> = null;
         var exitVector:Vector.<uint> = null;
         if(this._spellLevel && this._spellLevel.effects)
         {
            for each(effect in this._spellLevel.effects)
            {
               if(effect.effectId == ActionIds.ACTION_FIGHT_DISABLE_PORTAL)
               {
                  return target;
               }
            }
         }
         var currentFighterId:Number = CurrentPlayedFighterManager.getInstance().currentFighterId;
         var entityInfos:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(currentFighterId) as GameFightFighterInformations;
         if(!entityInfos)
         {
            return target;
         }
         var markedCellsManager:MarkedCellsManager = MarkedCellsManager.getInstance();
         var mpWithPortals:Vector.<MapPoint> = markedCellsManager.getMarksMapPoint(GameActionMarkTypeEnum.PORTAL);
         if(!mpWithPortals || mpWithPortals.length < 2)
         {
            return target;
         }
         for each(portalp in mpWithPortals)
         {
            portalMark = markedCellsManager.getMarkAtCellId(portalp.cellId,GameActionMarkTypeEnum.PORTAL);
            if(portalMark && portalMark.active)
            {
               if(portalp.cellId == target)
               {
                  targetPortal = portalp;
                  break;
               }
            }
         }
         if(!targetPortal)
         {
            return target;
         }
         mpWithPortals = markedCellsManager.getMarksMapPoint(GameActionMarkTypeEnum.PORTAL,portalMark.teamId);
         var portalsCellIds:Vector.<uint> = LinkedCellsManager.getInstance().getLinks(targetPortal,mpWithPortals);
         var exitPoint:MapPoint = MapPoint.fromCellId(portalsCellIds.pop());
         var fighterPoint:MapPoint = MapPoint.fromCellId(entityInfos.disposition.cellId);
         if(!fighterPoint)
         {
            return target;
         }
         var symmetricalTargetX:int = targetPortal.x - fighterPoint.x + exitPoint.x;
         var symmetricalTargetY:int = targetPortal.y - fighterPoint.y + exitPoint.y;
         if(!MapPoint.isInMap(symmetricalTargetX,symmetricalTargetY))
         {
            return AtouinConstants.MAP_CELLS_COUNT + 1;
         }
         newTargetPoint = MapPoint.fromCoords(symmetricalTargetX,symmetricalTargetY);
         if(drawLinks)
         {
            entryVector = new Vector.<uint>();
            entryVector.push(fighterPoint.cellId);
            entryVector.push(targetPortal.cellId);
            LinkedCellsManager.getInstance().drawLinks("spellEntryLink",entryVector,10,TARGET_COLOR.color,1);
            if(newTargetPoint.cellId < AtouinConstants.MAP_CELLS_COUNT)
            {
               exitVector = new Vector.<uint>();
               exitVector.push(exitPoint.cellId);
               exitVector.push(newTargetPoint.cellId);
               LinkedCellsManager.getInstance().drawLinks("spellExitLink",exitVector,6,TARGET_COLOR.color,1);
            }
         }
         return newTargetPoint.cellId;
      }
      
      private function checkSpellCostAndPlayerAp() : int
      {
         var spell:SpellWrapper = null;
         for each(spell in PlayedCharacterManager.getInstance().spellsInventory)
         {
            if(spell.spellId == this._spellLevel.spellId && spell.apCost != this._spellLevel.apCost)
            {
               this._spellLevel.apCost = spell.apCost;
            }
         }
         return CurrentPlayedFighterManager.getInstance().getStats().getStatTotalValue(StatIds.ACTION_POINTS);
      }
      
      private function castSpell(cell:uint, targetId:Number = 0, forceCheckForRange:Boolean = false) : void
      {
         var entity:IEntity = null;
         var text:String = null;
         var targetName:* = null;
         var fighter:GameFightFighterInformations = null;
         var spellName:* = null;
         var ccmmsg:ChatClientMultiMessage = null;
         var cellEntity:IEntity = null;
         var gafcotrmsg:GameActionFightCastOnTargetRequestMessage = null;
         var gafcrmsg:GameActionFightCastRequestMessage = null;
         var fightTurnFrame:FightTurnFrame = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
         if(!fightTurnFrame)
         {
            return;
         }
         var apCurrent:int = this.checkSpellCostAndPlayerAp();
         if(apCurrent < this._spellLevel.apCost)
         {
            return;
         }
         if(KeyPoll.getInstance().isDown(Keyboard.ALTERNATE))
         {
            if(cell == 0 && targetId != 0)
            {
               entity = DofusEntities.getEntity(targetId);
               if(entity && entity.position)
               {
                  cell = entity.position.cellId;
               }
            }
            if(targetId == 0 && cell > 0)
            {
               cellEntity = EntitiesManager.getInstance().getEntityOnCell(cell,AnimatedCharacter);
               if(cellEntity)
               {
                  targetId = cellEntity.id;
               }
            }
            if(targetId != 0 && !entity)
            {
               fighter = FightEntitiesFrame.getCurrentInstance().getEntityInfos(targetId) as GameFightFighterInformations;
            }
            if(fighter && fighter.disposition.cellId)
            {
               targetName = "{entity," + targetId + "," + 1 + "}";
            }
            else
            {
               targetName = I18n.getUiText("ui.fightAutomsg.cellTarget",["{cell," + cell + "::" + cell + "}"]);
            }
            if(this._spellId == 0)
            {
               spellName = this._spellLevel.name;
            }
            else
            {
               spellName = "{spell," + this._spellId + "," + this._spellLevel.spellLevel + "}";
            }
            if(SelectionManager.getInstance().isInside(cell,SELECTION_RANGE))
            {
               text = I18n.getUiText("ui.fightAutomsg.targetcast.noLineOfSight",[spellName,targetName]);
            }
            else if(!SelectionManager.getInstance().isInside(cell,SELECTION_LOS))
            {
               text = I18n.getUiText("ui.fightAutomsg.targetcast.outsideRange",[spellName,targetName]);
            }
            else
            {
               text = I18n.getUiText("ui.fightAutomsg.targetcast.available",[spellName,targetName]);
            }
            ccmmsg = new ChatClientMultiMessage();
            ccmmsg.initChatClientMultiMessage(text,ChatActivableChannelsEnum.CHANNEL_TEAM);
            ConnectionsHandler.getConnection().send(ccmmsg);
            return;
         }
         if(forceCheckForRange && this._spellLevel.maximalRange < 63)
         {
            if(cell == 0 && targetId != 0)
            {
               entity = DofusEntities.getEntity(targetId);
               if(entity && entity.position)
               {
                  cell = entity.position.cellId;
               }
            }
            if(SelectionManager.getInstance().isInside(cell,SELECTION_RANGE) || !SelectionManager.getInstance().isInside(cell,SELECTION_LOS))
            {
               return;
            }
         }
         if(!fightTurnFrame.myTurn)
         {
            return;
         }
         var fightBattleFrame:FightBattleFrame = Kernel.getWorker().getFrame(FightBattleFrame) as FightBattleFrame;
         if(fightBattleFrame && fightBattleFrame.fightIsPaused)
         {
            this.cancelCast();
            return;
         }
         if(targetId != 0 && !FightEntitiesFrame.getCurrentInstance().entityIsIllusion(targetId) && !(this._fightTeleportationPreview && this._fightTeleportationPreview.isPreview(targetId)) && CurrentPlayedFighterManager.getInstance().canCastThisSpell(this._spellId,this._spellLevel.spellLevel,targetId))
         {
            gafcotrmsg = new GameActionFightCastOnTargetRequestMessage();
            gafcotrmsg.initGameActionFightCastOnTargetRequestMessage(this._spellId,targetId);
            ConnectionsHandler.getConnection().send(gafcotrmsg);
         }
         else if(this.isValidCell(cell))
         {
            this.removeSummoningPreview();
            this.removeTeleportationPreview(true);
            gafcrmsg = new GameActionFightCastRequestMessage();
            gafcrmsg.initGameActionFightCastRequestMessage(this._spellId,cell);
            ConnectionsHandler.getConnection().send(gafcrmsg);
         }
         this.cancelCast();
      }
      
      private function cancelCast(... args) : void
      {
         this.removeSummoningPreview();
         this.removeTeleportationPreview(true);
         this._cancelTimer.reset();
         Kernel.getWorker().removeFrame(this);
      }
      
      private function removeRange() : void
      {
         var s:Selection = SelectionManager.getInstance().getSelection(SELECTION_RANGE);
         if(s)
         {
            s.remove();
         }
         var los:Selection = SelectionManager.getInstance().getSelection(SELECTION_LOS);
         if(los)
         {
            los.remove();
         }
         var ps:Selection = SelectionManager.getInstance().getSelection(SELECTION_PORTALS);
         if(ps)
         {
            ps.remove();
            this._portalsSelection = null;
         }
         this._isInfiniteTarget = false;
      }
      
      private function removeTarget() : void
      {
         var s:Selection = SelectionManager.getInstance().getSelection(SELECTION_TARGET);
         if(s)
         {
            s.remove();
         }
         s = SelectionManager.getInstance().getSelection(SELECTION_CENTER_TARGET);
         if(s)
         {
            s.remove();
         }
      }
      
      private function cellHasEntity(cellId:uint) : Boolean
      {
         var isPreviewedEntity:Boolean = false;
         var entity:IEntity = null;
         var entities:Array = EntitiesManager.getInstance().getEntitiesOnCell(cellId,AnimatedCharacter);
         if(entities === null || entities.length <= 0)
         {
            return false;
         }
         var isSummoningPreview:Boolean = this.hasSummoningPreview;
         var isTeleportationPreview:* = this._fightTeleportationPreview !== null;
         var entityId:Number = Number.NaN;
         for each(entity in entities)
         {
            entityId = entity.id;
            isPreviewedEntity = false;
            if(isSummoningPreview)
            {
               if(this._summoningPreview.isPreview(entityId))
               {
                  isPreviewedEntity = true;
               }
            }
            if(!isPreviewedEntity && isTeleportationPreview)
            {
               if(this._fightTeleportationPreview.isPreview(entityId))
               {
                  isPreviewedEntity = true;
               }
            }
            if(!isPreviewedEntity)
            {
               return true;
            }
         }
         return false;
      }
      
      private function isValidCell(cell:uint, ignorePortal:Boolean = false) : Boolean
      {
         var spellLevel:SpellLevel = null;
         var entities:Array = null;
         var entity:IEntity = null;
         var isGlyph:* = false;
         var valid:Boolean = false;
         if(!CellUtil.isValidCellIndex(cell))
         {
            return false;
         }
         var cellData:CellData = MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[cell];
         if(!cellData || cellData.farmCell)
         {
            return false;
         }
         if(this._isInfiniteTarget)
         {
            return true;
         }
         if(this._spellId && this._spellLevel)
         {
            spellLevel = this._spellLevel.spellLevelInfos;
            entities = EntitiesManager.getInstance().getEntitiesOnCell(cell);
            for each(entity in entities)
            {
               if(!(this.isTeleportationPreviewEntity(entity.id) || this.isSummoningPreviewEntity(entity.id)))
               {
                  if(!CurrentPlayedFighterManager.getInstance().canCastThisSpell(this._spellLevel.spellId,this._spellLevel.spellLevel,entity.id))
                  {
                     return false;
                  }
                  isGlyph = entity is Glyph;
                  if(spellLevel.needFreeTrapCell && isGlyph && (entity as Glyph).glyphType == GameActionMarkTypeEnum.TRAP)
                  {
                     return false;
                  }
                  if(this._spellLevel.needFreeCell && !isGlyph)
                  {
                     return false;
                  }
               }
            }
         }
         if(this._targetingThroughPortal && !ignorePortal)
         {
            valid = this.isValidCell(this.getTargetThroughPortal(cell),true);
            if(!valid)
            {
               return false;
            }
         }
         if(this._targetingThroughPortal)
         {
            if(cellData.nonWalkableDuringFight)
            {
               return false;
            }
            return cellData.mov;
         }
         return SelectionManager.getInstance().isInside(cell,SELECTION_LOS);
      }
      
      private function getSpellShape() : uint
      {
         var spellShape:uint = 0;
         var spellEffect:EffectInstance = null;
         var size:uint = 0;
         var minSize:uint = 0;
         for each(spellEffect in this._spellLevel.effects)
         {
            if(spellEffect.zoneShape != 0 && (spellEffect.zoneSize > size || spellEffect.zoneSize == size && (spellEffect.zoneShape == SpellShapeEnum.P || spellEffect.zoneMinSize < minSize)))
            {
               spellShape = spellEffect.zoneShape;
            }
         }
         return spellShape;
      }
      
      private function createZoneRenderer(color:Color, strata:uint = 90) : IFightZoneRenderer
      {
         var renderer:IFightZoneRenderer = null;
         switch(color)
         {
            case TARGET_CENTER_COLOR:
               renderer = new ZoneClipRenderer(strata,SWF_LIB,["cellActive"],-1,false,false);
               break;
            default:
               renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA,1,true);
         }
         renderer.showFarmCell = false;
         return renderer;
      }
      
      private function onPropertyChanged(e:PropertyChangeEvent) : void
      {
         if(this._targetCenterSelection && this._targetCenterSelection.visible)
         {
            ZoneDARenderer(this._targetSelection.renderer).fixedStrata = false;
            ZoneDARenderer(this._targetSelection.renderer).currentStrata = e.propertyValue == true ? uint(PlacementStrataEnums.STRATA_NO_Z_ORDER) : uint(PlacementStrataEnums.STRATA_AREA);
            ZoneClipRenderer(this._targetCenterSelection.renderer).currentStrata = e.propertyValue == true ? uint(PlacementStrataEnums.STRATA_NO_Z_ORDER) : uint(PlacementStrataEnums.STRATA_AREA);
         }
      }
   }
}
