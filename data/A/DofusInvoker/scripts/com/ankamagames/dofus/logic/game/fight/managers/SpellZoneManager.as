package com.ankamagames.dofus.logic.game.fight.managers
{
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.atouin.renderers.ZoneDARenderer;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.spells.EffectZone;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.miscs.DamageUtil;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.zones.Cone;
   import com.ankamagames.jerakine.types.zones.Cross;
   import com.ankamagames.jerakine.types.zones.Custom;
   import com.ankamagames.jerakine.types.zones.DisplayZone;
   import com.ankamagames.jerakine.types.zones.Fork;
   import com.ankamagames.jerakine.types.zones.HalfLozenge;
   import com.ankamagames.jerakine.types.zones.Line;
   import com.ankamagames.jerakine.types.zones.Lozenge;
   import com.ankamagames.jerakine.types.zones.Rectangle;
   import com.ankamagames.jerakine.types.zones.Square;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import mapTools.MapDirection;
   import mapTools.MapTools;
   
   public class SpellZoneManager implements IDestroyable
   {
      
      private static var _self:SpellZoneManager;
      
      private static const ZONE_COLOR:Color = new Color(10929860);
      
      private static const SELECTION_ZONE:String = "SpellCastZone";
       
      
      private var _targetSelection:Selection;
      
      private var _spellWrapper:SpellWrapper;
      
      public function SpellZoneManager()
      {
         super();
         if(_self != null)
         {
            throw new SingletonError("SpellZoneManager is a singleton and should not be instanciated directly.");
         }
      }
      
      public static function getInstance() : SpellZoneManager
      {
         if(_self == null)
         {
            _self = new SpellZoneManager();
         }
         return _self;
      }
      
      public function destroy() : void
      {
         _self = null;
      }
      
      public function displaySpellZone(casterId:Number, targetCellId:int, sourceCellId:int, spellId:uint, spellLevelId:uint) : void
      {
         this._spellWrapper = SpellWrapper.create(spellId,spellLevelId,false,casterId);
         if(this._spellWrapper && targetCellId != -1 && sourceCellId != -1)
         {
            this._targetSelection = new Selection();
            this._targetSelection.renderer = new ZoneDARenderer(PlacementStrataEnums.STRATA_AREA);
            this._targetSelection.color = ZONE_COLOR;
            this._targetSelection.zone = this.getSpellZone(this._spellWrapper,false,true,targetCellId,sourceCellId);
            this._targetSelection.zone.direction = MapPoint.fromCellId(sourceCellId).advancedOrientationTo(MapPoint.fromCellId(targetCellId),false);
            SelectionManager.getInstance().addSelection(this._targetSelection,SELECTION_ZONE);
            SelectionManager.getInstance().update(SELECTION_ZONE,targetCellId);
         }
         else
         {
            this.removeSpellZone();
         }
      }
      
      public function getPreferredPreviewZone(spell:SpellWrapper, isWholeMapShapeIgnored:Boolean = false, isInfiniteSizeIgnored:Boolean = true, isTooltipFilter:Boolean = false, outputPortalCell:int = -1) : DisplayZone
      {
         var effect:EffectInstance = null;
         var currentZone:DisplayZone = null;
         var currentSurface:uint = 0;
         var biggestZone:DisplayZone = null;
         var lastSurface:uint = 0;
         for each(effect in spell.effects)
         {
            if(!(effect.zoneShape === SpellShapeEnum.UNKNOWN || isTooltipFilter && !effect.visibleInTooltip))
            {
               currentZone = this.getZone(effect.zoneShape,uint(effect.zoneSize),uint(effect.zoneMinSize),isWholeMapShapeIgnored,uint(effect.zoneStopAtTarget),!(spell is SpellWrapper),spell.getEntityId(),outputPortalCell);
               currentSurface = currentZone.surface;
               if((!isInfiniteSizeIgnored || !currentZone.isInfinite) && currentSurface > lastSurface)
               {
                  biggestZone = currentZone;
                  lastSurface = currentSurface;
               }
            }
         }
         return biggestZone;
      }
      
      public function removeSpellZone() : void
      {
         var s:Selection = SelectionManager.getInstance().getSelection(SELECTION_ZONE);
         if(s)
         {
            s.remove();
         }
      }
      
      public function getSpellZone(spell:*, isWholeMapShapeIgnored:Boolean = false, isInfiniteSizeIgnored:Boolean = true, spellImpactCell:int = 0, casterCell:int = 0, isPreview:Boolean = true, casterId:Number = NaN, portalCell:Number = -1) : DisplayZone
      {
         var finalZone:DisplayZone = null;
         var oppositeDirection:uint = 0;
         var distance:int = 0;
         var entitiesFrame:FightEntitiesFrame = null;
         var entitiesIds:Vector.<Number> = null;
         var zonesCells:Vector.<uint> = null;
         var additionalZoneCells:Vector.<uint> = null;
         var isDefaultZoneDisplayed:Boolean = false;
         var effectZone:EffectZone = null;
         var finalZoneCells:Vector.<uint> = null;
         var relatedEffect:EffectInstance = null;
         var displayedZone:DisplayZone = null;
         var isActivationMaskEmpty:* = false;
         var activationZone:DisplayZone = null;
         var entityId:Number = NaN;
         var casterEffect:EffectInstance = null;
         var casterPos:int = 0;
         var entityInfo:GameFightFighterInformations = null;
         var direction:uint = portalCell === MapTools.INVALID_CELL_ID ? uint(MapPoint.fromCellId(casterCell).advancedOrientationTo(MapPoint.fromCellId(spellImpactCell))) : uint(MapPoint.fromCellId(casterCell).advancedOrientationTo(MapPoint.fromCellId(portalCell)));
         var outputPortalCell:int = MapTools.INVALID_CELL_ID;
         if(portalCell !== MapTools.INVALID_CELL_ID)
         {
            oppositeDirection = MapDirection.getOppositeDirection(direction);
            distance = MapTools.getDistance(portalCell,casterCell);
            outputPortalCell = spellImpactCell;
            while(distance > 0)
            {
               outputPortalCell = MapTools.getNextCellByDirection(outputPortalCell,oppositeDirection);
               distance--;
            }
         }
         if(isPreview && spell.defaultPreviewZone)
         {
            finalZone = this.getZone(spell.effectZone.activationZoneShape,spell.effectZone.activationZoneSize,spell.effectZone.activationZoneMinSize,isWholeMapShapeIgnored,spell.effectZone.activationZoneStopAtTarget,!(spell is SpellWrapper),casterId,outputPortalCell);
         }
         else
         {
            finalZone = this.getPreferredPreviewZone(spell,isWholeMapShapeIgnored,isInfiniteSizeIgnored,false,outputPortalCell);
         }
         if(finalZone === null)
         {
            finalZone = this.getZone(SpellShapeEnum.X,0,0,isWholeMapShapeIgnored,0,!(spell is SpellWrapper),casterId,outputPortalCell);
         }
         finalZone.direction = direction;
         if(isPreview && spell.previewZones !== null && spell.previewZones.length > 0)
         {
            entitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            if(entitiesFrame === null)
            {
               return finalZone;
            }
            entitiesIds = entitiesFrame.getEntitiesIdsList();
            zonesCells = finalZone.getCells(spellImpactCell);
            additionalZoneCells = new Vector.<uint>(0);
            isDefaultZoneDisplayed = true;
            for each(effectZone in spell.previewZones)
            {
               if(effectZone.isDisplayZone)
               {
                  relatedEffect = new EffectInstance();
                  relatedEffect.targetMask = effectZone.activationMask;
                  relatedEffect.zoneShape = effectZone.activationZoneShape;
                  relatedEffect.zoneSize = effectZone.activationZoneSize;
                  relatedEffect.zoneMinSize = effectZone.activationZoneMinSize;
                  relatedEffect.zoneStopAtTarget = effectZone.activationZoneStopAtTarget;
                  if(effectZone.casterMask)
                  {
                     casterEffect = relatedEffect.clone();
                     casterEffect.targetMask = effectZone.casterMask;
                     casterPos = (Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).getLastKnownEntityPosition(casterId);
                     if(!DamageUtil.verifySpellEffectMask(casterId,casterId,casterEffect,casterPos))
                     {
                        continue;
                     }
                  }
                  displayedZone = this.getZone(effectZone.displayZoneShape,effectZone.displayZoneSize,effectZone.displayZoneMinSize,isWholeMapShapeIgnored,effectZone.displayZoneStopAtTarget,false,casterId,outputPortalCell == MapTools.INVALID_CELL_ID ? int(casterCell) : int(outputPortalCell));
                  displayedZone.direction = direction;
                  isActivationMaskEmpty = !relatedEffect.targetMask;
                  if(isActivationMaskEmpty)
                  {
                     additionalZoneCells = additionalZoneCells.concat(displayedZone.getCells(spellImpactCell));
                     if(isDefaultZoneDisplayed && effectZone.isDefaultPreviewZoneHidden)
                     {
                        isDefaultZoneDisplayed = false;
                     }
                  }
                  (activationZone = this.getZone(effectZone.activationZoneShape,effectZone.activationZoneSize,effectZone.activationZoneMinSize,isWholeMapShapeIgnored,effectZone.activationZoneStopAtTarget)).direction = direction;
                  for each(entityId in entitiesIds)
                  {
                     entityInfo = entitiesFrame.getEntityInfos(entityId) as GameFightFighterInformations;
                     if(entityInfo.spawnInfo.alive && this.checkZone(entityInfo,relatedEffect.zoneShape,activationZone.getCells(spellImpactCell)) && (isActivationMaskEmpty || DamageUtil.verifySpellEffectMask(casterId,entityId,relatedEffect,spellImpactCell)))
                     {
                        additionalZoneCells = additionalZoneCells.concat(displayedZone.getCells(entityInfo.disposition.cellId));
                        if(isDefaultZoneDisplayed && effectZone.isDefaultPreviewZoneHidden)
                        {
                           isDefaultZoneDisplayed = false;
                        }
                     }
                  }
               }
            }
            finalZoneCells = !!isDefaultZoneDisplayed ? zonesCells : new Vector.<uint>(0);
            if(additionalZoneCells.length > 0)
            {
               finalZoneCells = finalZoneCells.concat(additionalZoneCells);
            }
            return new Custom(finalZoneCells);
         }
         return finalZone;
      }
      
      public function getEffectZone(rawZone:String) : EffectZone
      {
         var effectZone:EffectZone = new EffectZone();
         effectZone.rawActivationZone = rawZone;
         return effectZone;
      }
      
      public function parseZone(rawZone:String, casterId:Number, targetedCellId:int, isWeapon:Boolean) : DisplayZone
      {
         var effectZone:EffectZone = this.getEffectZone(rawZone);
         return SpellZoneManager.getInstance().getZone(effectZone.activationZoneShape,effectZone.activationZoneSize,effectZone.activationZoneMinSize,false,effectZone.activationZoneStopAtTarget,isWeapon,casterId,targetedCellId);
      }
      
      public function getZone(shape:uint, size:uint, alternativeSize:uint, isWholeMapShapeIgnored:Boolean = false, isZoneStopAtTarget:uint = 0, isWeapon:Boolean = false, entityId:Number = NaN, entityCellId:int = -1) : DisplayZone
      {
         var casterId:Number = NaN;
         var casterInfoCellId:int = 0;
         var shapeT:Cross = null;
         switch(shape)
         {
            case SpellShapeEnum.X:
               return new Cross(shape,alternativeSize,isWeapon || size ? uint(size) : (!!alternativeSize ? uint(alternativeSize) : uint(size)),DataMapProvider.getInstance());
            case SpellShapeEnum.L:
               return new Line(shape,0,size,DataMapProvider.getInstance());
            case SpellShapeEnum.l:
               casterId = !!isNaN(entityId) ? Number(CurrentPlayedFighterManager.getInstance().currentFighterId) : Number(entityId);
               casterInfoCellId = 0;
               if(PlayedCharacterApi.getInstance().isInFight())
               {
                  casterInfoCellId = FightEntitiesFrame.getCurrentInstance().getEntityInfos(casterId).disposition.cellId;
               }
               return new Line(shape,alternativeSize,size,DataMapProvider.getInstance(),true,isZoneStopAtTarget === 1,entityCellId !== -1 ? uint(entityCellId) : uint(casterInfoCellId));
            case SpellShapeEnum.T:
               return new Cross(shape,0,size,DataMapProvider.getInstance());
            case SpellShapeEnum.D:
               return new Cross(shape,0,size,DataMapProvider.getInstance());
            case SpellShapeEnum.C:
               return new Lozenge(shape,alternativeSize,size,DataMapProvider.getInstance());
            case SpellShapeEnum.O:
               return new Lozenge(shape,size,size,DataMapProvider.getInstance());
            case SpellShapeEnum.Q:
               return new Cross(shape,!!alternativeSize ? uint(alternativeSize) : uint(1),!!size ? uint(size) : uint(1),DataMapProvider.getInstance());
            case SpellShapeEnum.V:
               return new Cone(0,size,DataMapProvider.getInstance());
            case SpellShapeEnum.W:
               return new Square(0,size,true,DataMapProvider.getInstance());
            case SpellShapeEnum.plus:
               return new Cross(shape,0,!!size ? uint(size) : uint(1),DataMapProvider.getInstance(),true);
            case SpellShapeEnum.sharp:
               return new Cross(shape,alternativeSize,size,DataMapProvider.getInstance(),true);
            case SpellShapeEnum.slash:
               return new Line(shape,0,size,DataMapProvider.getInstance());
            case SpellShapeEnum.star:
               return new Cross(shape,0,size,DataMapProvider.getInstance(),false,true);
            case SpellShapeEnum.minus:
               return new Cross(shape,0,size,DataMapProvider.getInstance(),true);
            case SpellShapeEnum.G:
               return new Square(0,size,false,DataMapProvider.getInstance());
            case SpellShapeEnum.I:
               return new Lozenge(shape,size,63,DataMapProvider.getInstance());
            case SpellShapeEnum.U:
               return new HalfLozenge(0,size,DataMapProvider.getInstance());
            case SpellShapeEnum.A:
            case SpellShapeEnum.a:
               if(!isWholeMapShapeIgnored)
               {
                  return new Lozenge(shape,0,63,DataMapProvider.getInstance());
               }
               return new Cross(shape,0,0,DataMapProvider.getInstance());
               break;
            case SpellShapeEnum.R:
               return new Rectangle(alternativeSize,size,DataMapProvider.getInstance());
            case SpellShapeEnum.F:
               return new Fork(size,DataMapProvider.getInstance());
            case SpellShapeEnum.P:
         }
         return new Cross(shape,0,0,DataMapProvider.getInstance());
      }
      
      private function checkZone(pEntityInfos:GameFightFighterInformations, pShape:int, pCells:Vector.<uint>) : Boolean
      {
         switch(pShape)
         {
            case SpellShapeEnum.a:
               return pEntityInfos.spawnInfo.alive;
            case SpellShapeEnum.A:
               return true;
            default:
               return pCells.indexOf(pEntityInfos.disposition.cellId) != -1;
         }
      }
   }
}
