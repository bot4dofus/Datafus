package com.ankamagames.dofus.types.sequences
{
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.scripts.api.SpellScriptRunnerUtils;
   import com.ankamagames.dofus.types.entities.Projectile;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.enum.AddGfxModeEnum;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.getQualifiedClassName;
   
   public class AddGfxEntityStep extends AbstractSequencable
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AddGfxEntityStep));
       
      
      private var _gfxId:uint;
      
      private var _cellId:uint;
      
      private var _entity:Projectile;
      
      private var _shot:Boolean = false;
      
      private var _angle:Number;
      
      private var _yOffset:int;
      
      private var _mode:uint;
      
      private var _startCell:MapPoint;
      
      private var _endCell:MapPoint;
      
      private var _startEntity:IEntity;
      
      private var _popUnderPlayer:Boolean;
      
      private var _strataEnum;
      
      public function AddGfxEntityStep(gfxId:uint, cellId:uint, angle:Number = 0, yOffset:int = 0, mode:uint = 0, startCell:MapPoint = null, endCell:MapPoint = null, popUnderPlayer:Boolean = false, strataEnum:* = null, startEntity:IEntity = null)
      {
         super();
         this._mode = mode;
         this._gfxId = gfxId;
         this._cellId = cellId;
         this._angle = angle;
         this._yOffset = yOffset;
         this._startCell = startCell;
         this._endCell = endCell;
         this._startEntity = startEntity;
         this._popUnderPlayer = popUnderPlayer;
         this._strataEnum = strataEnum;
      }
      
      override public function start() : void
      {
         var dir:Array = null;
         var ad:Array = null;
         var orientedDir:uint = 0;
         var i:uint = 0;
         if(this._startEntity)
         {
            this._startCell = SpellScriptRunnerUtils.GetEntityCell(this._startEntity);
            this._cellId = this._startCell.cellId;
         }
         var id:Number = EntitiesManager.getInstance().getFreeEntityId();
         this._entity = new Projectile(id,TiphonEntityLook.fromString("{" + this._gfxId + "}"),true);
         this._entity.addEventListener(TiphonEvent.ANIMATION_SHOT,this.shot);
         this._entity.addEventListener(TiphonEvent.ANIMATION_END,this.remove);
         this._entity.addEventListener(TiphonEvent.RENDER_FAILED,this.remove);
         this._entity.addEventListener(TiphonEvent.SPRITE_INIT_FAILED,this.remove);
         this._entity.rotation = this._angle;
         this._entity.mouseEnabled = false;
         this._entity.mouseChildren = false;
         switch(this._mode)
         {
            case AddGfxModeEnum.NORMAL:
               this._entity.initDirection();
               break;
            case AddGfxModeEnum.RANDOM:
               dir = this._entity.getAvaibleDirection();
               ad = new Array();
               for(i = 0; i < 8; i++)
               {
                  if(dir[i])
                  {
                     ad.push(i);
                  }
               }
               this._entity.initDirection(ad[Math.floor(Math.random() * ad.length)]);
               break;
            case AddGfxModeEnum.ORIENTED:
               orientedDir = this._startCell.advancedOrientationTo(this._endCell,true);
               this._entity.initDirection(orientedDir);
         }
         this._entity.position = MapPoint.fromCellId(this._cellId);
         if(this._strataEnum != null)
         {
            this._entity.display(this._strataEnum);
         }
         else if(this._popUnderPlayer)
         {
            this._entity.display(PlacementStrataEnums.STRATA_SPELL_BACKGROUND);
         }
         else
         {
            this._entity.display(PlacementStrataEnums.STRATA_SPELL_FOREGROUND);
         }
         this._entity.y += this._yOffset;
      }
      
      private function remove(e:Event) : void
      {
         this._entity.removeEventListener(TiphonEvent.ANIMATION_END,this.remove);
         this._entity.removeEventListener(TiphonEvent.ANIMATION_SHOT,this.shot);
         this._entity.removeEventListener(TiphonEvent.RENDER_FAILED,this.remove);
         this._entity.removeEventListener(TiphonEvent.SPRITE_INIT_FAILED,this.remove);
         this._entity.destroy();
         if(!this._shot)
         {
            this.shot(null);
         }
      }
      
      private function shot(e:Event) : void
      {
         this._shot = true;
         this._entity.removeEventListener(TiphonEvent.ANIMATION_SHOT,this.shot);
         executeCallbacks();
      }
      
      override protected function onTimeOut(e:TimerEvent) : void
      {
         _log.error("Timeout en attendant le SHOT du bone du projectile " + this._gfxId);
         if(this._entity)
         {
            this._entity.destroy();
         }
         super.onTimeOut(e);
      }
   }
}
