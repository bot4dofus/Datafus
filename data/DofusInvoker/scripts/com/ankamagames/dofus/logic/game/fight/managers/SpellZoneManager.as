package com.ankamagames.dofus.logic.game.fight.managers
{
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.atouin.renderers.ZoneDARenderer;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.internalDatacenter.spells.EffectZone;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.miscs.DamageUtil;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.zones.Cone;
   import com.ankamagames.jerakine.types.zones.Cross;
   import com.ankamagames.jerakine.types.zones.Custom;
   import com.ankamagames.jerakine.types.zones.HalfLozenge;
   import com.ankamagames.jerakine.types.zones.IZone;
   import com.ankamagames.jerakine.types.zones.Line;
   import com.ankamagames.jerakine.types.zones.Lozenge;
   import com.ankamagames.jerakine.types.zones.Square;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.utils.getQualifiedClassName;
   
   public class SpellZoneManager implements IDestroyable
   {
      
      private static var _log:Logger = Log.getLogger(getQualifiedClassName(SpellZoneManager));
      
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
            this._targetSelection.zone = this.getSpellZone(this._spellWrapper,false,true,targetCellId,(Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame).getEntityInfos(casterId).disposition.cellId);
            this._targetSelection.zone.direction = MapPoint.fromCellId(sourceCellId).advancedOrientationTo(MapPoint.fromCellId(targetCellId),false);
            SelectionManager.getInstance().addSelection(this._targetSelection,SELECTION_ZONE);
            SelectionManager.getInstance().update(SELECTION_ZONE,targetCellId);
         }
         else
         {
            this.removeTarget();
         }
      }
      
      public function removeSpellZone() : void
      {
         this.removeTarget();
      }
      
      private function removeTarget() : void
      {
         var s:Selection = SelectionManager.getInstance().getSelection(SELECTION_ZONE);
         if(s)
         {
            s.remove();
         }
      }
      
      public function getSpellZone(spell:*, ignoreShapeA:Boolean = false, ignoreMaxSize:Boolean = true, spellImpactCell:int = 0, casterCell:int = 0, pForPreview:Boolean = true) : IZone
      {
         var stopAtTarget:uint = 0;
         var finalZone:IZone = null;
         var effectZone:EffectZone = null;
         var fx:EffectInstance = null;
         var entitiesFrame:FightEntitiesFrame = null;
         var entitiesIds:Vector.<Number> = null;
         var zonesCells:Vector.<uint> = null;
         var effect:EffectInstance = null;
         var additionalZone:IZone = null;
         var additionalZoneCells:Vector.<uint> = null;
         var entityId:Number = NaN;
         var entityInfos:GameFightFighterInformations = null;
         var shape:uint = 88;
         var ray:uint = 0;
         var minRay:uint = 0;
         if(pForPreview && spell.default_zone)
         {
            effectZone = new EffectZone(spell.default_zone,null);
            shape = effectZone.zoneShape;
            ray = uint(effectZone.zoneSize);
            minRay = uint(effectZone.zoneMinSize);
            stopAtTarget = uint(effectZone.zoneStopAtTarget);
         }
         else if(!spell.hasOwnProperty("shape"))
         {
            for each(fx in spell.effects)
            {
               if(fx.zoneShape != 0 && (!ignoreMaxSize || fx.zoneSize < 63) && (fx.zoneSize > ray || fx.zoneSize == ray && (shape == SpellShapeEnum.P || fx.zoneMinSize < minRay)))
               {
                  shape = fx.zoneShape;
                  ray = uint(fx.zoneSize);
                  minRay = uint(fx.zoneMinSize);
                  stopAtTarget = uint(fx.zoneStopAtTarget);
               }
            }
         }
         else
         {
            shape = spell.shape;
            ray = spell.ray;
         }
         finalZone = this.getZone(shape,ray,minRay,ignoreShapeA,stopAtTarget,!(spell is SpellWrapper));
         var direction:uint = MapPoint.fromCellId(casterCell).advancedOrientationTo(MapPoint.fromCellId(spellImpactCell));
         finalZone.direction = direction;
         if(pForPreview && spell.hasOwnProperty("additionalEffectsZones") && spell.additionalEffectsZones && spell.additionalEffectsZones.length)
         {
            entitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
            if(!entitiesFrame)
            {
               return finalZone;
            }
            entitiesIds = entitiesFrame.getEntitiesIdsList();
            zonesCells = finalZone.getCells(spellImpactCell);
            effect = new EffectInstance();
            additionalZoneCells = new Vector.<uint>(0);
            for each(effectZone in spell.additionalEffectsZones)
            {
               effect.targetMask = effectZone.targetMask;
               effect.zoneShape = effectZone.zoneShape;
               effect.zoneSize = effectZone.zoneSize;
               effect.zoneMinSize = effectZone.zoneMinSize;
               effect.zoneStopAtTarget = effectZone.zoneStopAtTarget;
               for each(entityId in entitiesIds)
               {
                  entityInfos = entitiesFrame.getEntityInfos(entityId) as GameFightFighterInformations;
                  if(entityInfos.spawnInfo.alive && this.checkZone(entityInfos,shape,zonesCells) && DamageUtil.verifySpellEffectMask(CurrentPlayedFighterManager.getInstance().currentFighterId,entityId,effect,spellImpactCell))
                  {
                     if(effectZone.zoneShape == SpellShapeEnum.X && (isNaN(effectZone.zoneSize as Number) || !effectZone.zoneSize) && (isNaN(effectZone.zoneMinSize as Number) || !effectZone.zoneMinSize))
                     {
                        effectZone.zoneMinSize = 1;
                     }
                     additionalZone = this.getZone(effectZone.zoneShape,uint(effectZone.zoneSize),uint(effectZone.zoneMinSize),ignoreShapeA,uint(effectZone.zoneStopAtTarget));
                     additionalZone.direction = direction;
                     additionalZoneCells = additionalZoneCells.concat(additionalZone.getCells(entityInfos.disposition.cellId));
                  }
               }
            }
            return new Custom(!additionalZoneCells.length ? zonesCells : zonesCells.concat(additionalZoneCells));
         }
         return finalZone;
      }
      
      public function getZone(pShape:uint, pZoneSize:uint, pMinZoneSize:uint, pIgnoreShapeA:Boolean = false, pStopAtTarget:uint = 0, pIsWeapon:Boolean = false) : IZone
      {
         var l:Line = null;
         var casterInfos:GameContextActorInformations = null;
         var shapeT:Cross = null;
         var shapeW:Square = null;
         var shapePlus:Cross = null;
         var shapeSharp:Cross = null;
         var shapeStar:Cross = null;
         var shapeMinus:Cross = null;
         switch(pShape)
         {
            case SpellShapeEnum.X:
               return new Cross(pMinZoneSize,pIsWeapon || pZoneSize ? uint(pZoneSize) : (!!pMinZoneSize ? uint(pMinZoneSize) : uint(pZoneSize)),DataMapProvider.getInstance());
            case SpellShapeEnum.L:
               return new Line(pZoneSize,DataMapProvider.getInstance());
            case SpellShapeEnum.l:
               l = new Line(pZoneSize,DataMapProvider.getInstance());
               casterInfos = FightEntitiesFrame.getCurrentInstance().getEntityInfos(CurrentPlayedFighterManager.getInstance().currentFighterId);
               l.minRadius = pMinZoneSize;
               l.fromCaster = true;
               l.stopAtTarget = pStopAtTarget == 1 ? true : false;
               l.casterCellId = casterInfos.disposition.cellId;
               return l;
            case SpellShapeEnum.T:
               shapeT = new Cross(0,pZoneSize,DataMapProvider.getInstance());
               shapeT.onlyPerpendicular = true;
               return shapeT;
            case SpellShapeEnum.D:
               return new Cross(0,pZoneSize,DataMapProvider.getInstance());
            case SpellShapeEnum.C:
               return new Lozenge(pMinZoneSize,pZoneSize,DataMapProvider.getInstance());
            case SpellShapeEnum.O:
               return new Lozenge(pZoneSize,pZoneSize,DataMapProvider.getInstance());
            case SpellShapeEnum.Q:
               return new Cross(!!pMinZoneSize ? uint(pMinZoneSize) : uint(1),!!pZoneSize ? uint(pZoneSize) : uint(1),DataMapProvider.getInstance());
            case SpellShapeEnum.V:
               return new Cone(0,pZoneSize,DataMapProvider.getInstance());
            case SpellShapeEnum.W:
               shapeW = new Square(0,pZoneSize,DataMapProvider.getInstance());
               shapeW.diagonalFree = true;
               return shapeW;
            case SpellShapeEnum.plus:
               shapePlus = new Cross(0,!!pZoneSize ? uint(pZoneSize) : uint(1),DataMapProvider.getInstance());
               shapePlus.diagonal = true;
               return shapePlus;
            case SpellShapeEnum.sharp:
               shapeSharp = new Cross(pMinZoneSize,pZoneSize,DataMapProvider.getInstance());
               shapeSharp.diagonal = true;
               return shapeSharp;
            case SpellShapeEnum.slash:
               return new Line(pZoneSize,DataMapProvider.getInstance());
            case SpellShapeEnum.star:
               shapeStar = new Cross(0,pZoneSize,DataMapProvider.getInstance());
               shapeStar.allDirections = true;
               return shapeStar;
            case SpellShapeEnum.minus:
               shapeMinus = new Cross(0,pZoneSize,DataMapProvider.getInstance());
               shapeMinus.onlyPerpendicular = true;
               shapeMinus.diagonal = true;
               return shapeMinus;
            case SpellShapeEnum.G:
               return new Square(0,pZoneSize,DataMapProvider.getInstance());
            case SpellShapeEnum.I:
               return new Lozenge(pZoneSize,63,DataMapProvider.getInstance());
            case SpellShapeEnum.U:
               return new HalfLozenge(0,pZoneSize,DataMapProvider.getInstance());
            case SpellShapeEnum.A:
            case SpellShapeEnum.a:
               if(!pIgnoreShapeA)
               {
                  return new Lozenge(0,63,DataMapProvider.getInstance());
               }
            case SpellShapeEnum.P:
         }
         return new Cross(0,0,DataMapProvider.getInstance());
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
