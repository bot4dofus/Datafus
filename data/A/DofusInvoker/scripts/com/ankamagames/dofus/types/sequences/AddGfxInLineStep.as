package com.ankamagames.dofus.types.sequences
{
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.types.SpellCastSequenceContext;
   import com.ankamagames.dofus.scripts.api.SpellScriptRunnerUtils;
   import com.ankamagames.dofus.types.entities.Projectile;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.enum.AddGfxModeEnum;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.zones.Cross;
   import com.ankamagames.jerakine.types.zones.DisplayZone;
   import com.ankamagames.jerakine.types.zones.Line;
   import com.ankamagames.jerakine.types.zones.Lozenge;
   import com.ankamagames.jerakine.utils.display.Dofus2Line;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.geom.Point;
   
   public class AddGfxInLineStep extends AbstractSequencable
   {
       
      
      private var _gfxId:uint;
      
      private var _startCell:MapPoint;
      
      private var _startEntity:IEntity;
      
      private var _endCell:MapPoint;
      
      private var _addOnStartCell:Boolean;
      
      private var _addOnEndCell:Boolean;
      
      private var _yOffset:int;
      
      private var _mode:uint;
      
      private var _shot:Boolean = false;
      
      private var _scale:Number;
      
      private var _castingSpell:SpellCastSequenceContext;
      
      private var _showUnder:Boolean;
      
      private var _useOnlyAddedCells:Boolean;
      
      private var _addedCells:Vector.<uint>;
      
      private var _cells:Array;
      
      private var _zone:DisplayZone;
      
      public function AddGfxInLineStep(gfxId:uint, castingSpell:SpellCastSequenceContext, startCell:MapPoint, endCell:MapPoint, yOffset:int, mode:uint = 0, minScale:Number = 0, maxScale:Number = 0, addOnStartCell:Boolean = false, addOnEndCell:Boolean = false, useSpellZone:Boolean = false, useOnlyAddedCells:Boolean = false, showUnder:Boolean = false, startEntity:IEntity = null)
      {
         var shape:uint = 0;
         var ray:uint = 0;
         var i:EffectInstance = null;
         var shapeT:Cross = null;
         super();
         this._gfxId = gfxId;
         this._startCell = startCell;
         this._endCell = endCell;
         this._addOnStartCell = addOnStartCell;
         this._addOnEndCell = addOnEndCell;
         this._yOffset = yOffset;
         this._mode = mode;
         this._useOnlyAddedCells = useOnlyAddedCells;
         this._showUnder = showUnder;
         this._castingSpell = castingSpell;
         this._startEntity = startEntity;
         var level:uint = this._castingSpell.spellData.spellLevels.indexOf(this._castingSpell.spellLevelData.id);
         this._scale = 1 + (minScale + (maxScale - minScale) * level / this._castingSpell.spellData.spellLevels.length) / 10;
         this._addedCells = new Vector.<uint>();
         if(useSpellZone)
         {
            shape = 88;
            ray = 0;
            for each(i in this._castingSpell.spellLevelData.effects)
            {
               if(i.zoneShape != 0 && i.zoneSize < 63 && (i.zoneSize > ray || i.zoneSize == ray && shape == SpellShapeEnum.P))
               {
                  ray = uint(i.zoneSize);
                  shape = i.zoneShape;
               }
            }
            switch(shape)
            {
               case SpellShapeEnum.X:
                  this._zone = new Cross(shape,0,ray,DataMapProvider.getInstance());
                  break;
               case SpellShapeEnum.L:
                  this._zone = new Line(shape,0,ray,DataMapProvider.getInstance());
                  break;
               case SpellShapeEnum.T:
                  shapeT = new Cross(shape,0,ray,DataMapProvider.getInstance());
                  this._zone = shapeT;
                  break;
               case SpellShapeEnum.D:
                  this._zone = new Cross(shape,0,ray,DataMapProvider.getInstance());
                  break;
               case SpellShapeEnum.C:
                  this._zone = new Lozenge(shape,0,ray,DataMapProvider.getInstance());
                  break;
               case SpellShapeEnum.O:
                  this._zone = new Cross(shape,ray - 1,ray,DataMapProvider.getInstance());
                  break;
               case SpellShapeEnum.P:
               default:
                  this._zone = new Cross(shape,0,0,DataMapProvider.getInstance());
            }
         }
      }
      
      override public function start() : void
      {
         var cells:Array = null;
         var cell:Point = null;
         var i:uint = 0;
         var add:Boolean = false;
         var targetedPoint:MapPoint = null;
         var j:uint = 0;
         if(this._startEntity)
         {
            this._startCell = SpellScriptRunnerUtils.GetEntityCell(this._startEntity);
         }
         if(this._zone)
         {
            targetedPoint = MapPoint.fromCellId(this._castingSpell.targetedCellId);
            this._zone.direction = this._startCell.advancedOrientationTo(targetedPoint);
            this._addedCells = this._zone.getCells(this._castingSpell.targetedCellId);
         }
         if(!this._useOnlyAddedCells)
         {
            cells = Dofus2Line.getLine(this._startCell.cellId,this._endCell.cellId);
         }
         else
         {
            cells = [];
         }
         this._cells = new Array();
         if(this._addOnStartCell)
         {
            this._cells.push(this._startCell);
         }
         for(i = 0; i < cells.length; i++)
         {
            cell = cells[i];
            if(this._addOnEndCell && i == cells.length - 1 || i >= 0 && i < cells.length - 1)
            {
               this._cells.push(MapPoint.fromCoords(cell.x,cell.y));
            }
         }
         if(this._addedCells)
         {
            for(i = 0; i < this._addedCells.length; i++)
            {
               add = true;
               for(j = 0; j < this._cells.length; j++)
               {
                  if(this._addedCells[i] == MapPoint(this._cells[j]).cellId)
                  {
                     add = false;
                     break;
                  }
               }
               if(add)
               {
                  this._cells.push(MapPoint.fromCellId(this._addedCells[i]));
               }
            }
         }
         this.addNextGfx();
      }
      
      private function addNextGfx() : void
      {
         if(!this._cells.length)
         {
            executeCallbacks();
            return;
         }
         var id:int = -10000;
         while(DofusEntities.getEntity(id))
         {
            id = -10000 + Math.random() * 10000;
         }
         var entity:Projectile = new Projectile(id,TiphonEntityLook.fromString("{" + this._gfxId + "}"));
         entity.addEventListener(TiphonEvent.ANIMATION_SHOT,this.shot);
         entity.addEventListener(TiphonEvent.ANIMATION_END,this.remove);
         entity.addEventListener(TiphonEvent.RENDER_FAILED,this.remove);
         entity.position = this._cells.shift();
         if(!entity.libraryIsAvailable)
         {
            entity.addEventListener(TiphonEvent.SPRITE_INIT,this.startDisplay);
            entity.addEventListener(TiphonEvent.SPRITE_INIT_FAILED,this.remove);
            entity.initDirection();
         }
         else
         {
            entity.initDirection();
            this.startDisplay(new TiphonEvent(TiphonEvent.SPRITE_INIT,entity));
         }
      }
      
      private function startDisplay(e:TiphonEvent) : void
      {
         var p:Projectile = null;
         var dir:Array = null;
         var ad:Array = null;
         var i:uint = 0;
         p = Projectile(e.sprite);
         switch(this._mode)
         {
            case AddGfxModeEnum.NORMAL:
               break;
            case AddGfxModeEnum.RANDOM:
               dir = p.getAvaibleDirection("FX");
               ad = new Array();
               for(i = 0; i < 8; i++)
               {
                  if(dir[i])
                  {
                     ad.push(i);
                  }
               }
               p.setDirection(ad[Math.floor(Math.random() * ad.length)]);
               break;
            case AddGfxModeEnum.ORIENTED:
               p.setDirection(this._startCell.advancedOrientationTo(this._endCell,true));
         }
         p.display(!!this._showUnder ? uint(PlacementStrataEnums.STRATA_SPELL_BACKGROUND) : uint(PlacementStrataEnums.STRATA_SPELL_FOREGROUND));
         p.y += this._yOffset;
         p.scaleX = p.scaleY = this._scale;
      }
      
      private function remove(e:TiphonEvent) : void
      {
         e.sprite.removeEventListener(TiphonEvent.ANIMATION_END,this.remove);
         e.sprite.removeEventListener(TiphonEvent.ANIMATION_SHOT,this.shot);
         e.sprite.removeEventListener(TiphonEvent.RENDER_FAILED,this.remove);
         e.sprite.removeEventListener(TiphonEvent.SPRITE_INIT,this.startDisplay);
         e.sprite.removeEventListener(TiphonEvent.SPRITE_INIT_FAILED,this.remove);
         Projectile(e.sprite).remove();
         if(!this._shot)
         {
            this.shot(null);
         }
      }
      
      private function shot(e:TiphonEvent) : void
      {
         if(e)
         {
            e.sprite.removeEventListener(TiphonEvent.ANIMATION_SHOT,this.shot);
         }
         this._shot = true;
         this.addNextGfx();
      }
   }
}
