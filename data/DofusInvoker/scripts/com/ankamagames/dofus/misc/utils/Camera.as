package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.steps.CameraFollowStep;
   import com.ankamagames.dofus.logic.game.common.steps.CameraMoveStep;
   import com.ankamagames.dofus.logic.game.common.steps.CameraZoomStep;
   import com.ankamagames.dofus.scripts.ScriptEntity;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.sequencer.CallbackStep;
   import com.ankamagames.jerakine.sequencer.ISequencable;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class Camera
   {
      
      private static const CENTER_X:Number = StageShareManager.startWidth / 2;
      
      private static const CENTER_Y:Number = (StageShareManager.startHeight - 163) / 2;
      
      private static const LASTCELL_X:Number = AtouinConstants.MAP_WIDTH * AtouinConstants.CELL_WIDTH;
      
      private static const LASTCELL_Y:Number = AtouinConstants.MAP_HEIGHT * AtouinConstants.CELL_HEIGHT;
      
      private static const MIN_SCALE:Number = 1;
       
      
      private var _zoom:Number;
      
      private var _entityToFollow:AnimatedCharacter;
      
      private var _container:DisplayObjectContainer;
      
      private var _x:Number;
      
      private var _y:Number;
      
      public function Camera(pZoom:Number = 1)
      {
         super();
         this._zoom = pZoom;
         this._container = Atouin.getInstance().rootContainer;
      }
      
      public function get currentZoom() : Number
      {
         return this._zoom;
      }
      
      public function set currentZoom(pZoom:Number) : void
      {
         this._zoom = pZoom;
      }
      
      public function get x() : Number
      {
         return this._x;
      }
      
      public function get y() : Number
      {
         return this._y;
      }
      
      public function setZoom(pZoom:Number) : ISequencable
      {
         return new CallbackStep(new Callback(function(pCamera:Camera, pNewZoom:Number):void
         {
            pCamera.currentZoom = pNewZoom;
         },this,pZoom));
      }
      
      public function zoom(pArgs:Array) : ISequencable
      {
         var args:Array = pArgs;
         var instant:Boolean = true;
         if(args[args.length - 1] is Boolean)
         {
            instant = args.pop();
         }
         return new CameraZoomStep(this,args,instant);
      }
      
      public function moveTo(pArgs:Array) : ISequencable
      {
         var args:Array = pArgs;
         var instant:Boolean = true;
         if(args[args.length - 1] is Boolean)
         {
            instant = args.pop();
         }
         return new CameraMoveStep(this,args,instant);
      }
      
      public function follow(pEntity:ScriptEntity) : ISequencable
      {
         return new CameraFollowStep(this,DofusEntities.getEntity(pEntity.id) as AnimatedCharacter);
      }
      
      public function stop() : ISequencable
      {
         return new CallbackStep(new Callback(EnterFrameDispatcher.removeEventListener,this.onEnterFrame));
      }
      
      public function reset() : ISequencable
      {
         return new CallbackStep(new Callback(this.zoomOnPos,MIN_SCALE,0,0));
      }
      
      public function followEntity(pEntity:AnimatedCharacter) : void
      {
         this.stop().start();
         this._entityToFollow = pEntity;
         EnterFrameDispatcher.addEventListener(this.onEnterFrame,EnterFrameConst.CAMERA);
      }
      
      public function zoomOnPos(pTargetZoom:Number, pTargetX:Number, pTargetY:Number) : void
      {
         var finalX:Number = NaN;
         var finalY:Number = NaN;
         if(pTargetZoom <= MIN_SCALE)
         {
            this._container.scaleX = MIN_SCALE;
            this._container.scaleY = MIN_SCALE;
            this._container.x = 0;
            this._container.y = 0;
            Atouin.getInstance().currentZoom = MIN_SCALE;
            MapDisplayManager.getInstance().cacheAsBitmapEnabled(true);
         }
         else
         {
            MapDisplayManager.getInstance().cacheAsBitmapEnabled(false);
            this._container.scaleX = pTargetZoom;
            this._container.scaleY = pTargetZoom;
            finalX = -pTargetX * pTargetZoom + CENTER_X;
            finalY = -pTargetY * pTargetZoom + CENTER_Y;
            if((LASTCELL_X - pTargetX) * pTargetZoom < LASTCELL_X / 2)
            {
               finalX += CENTER_X - (1280 - pTargetX) * pTargetZoom;
               if(finalX < -pTargetX * pTargetZoom)
               {
                  finalX = -pTargetX * pTargetZoom + CENTER_X;
               }
            }
            else if(pTargetX < CENTER_X / pTargetZoom)
            {
               finalX = 0;
            }
            if((LASTCELL_Y - pTargetY) * pTargetZoom < LASTCELL_Y / 2)
            {
               finalY += CENTER_Y - (874 - pTargetY) * pTargetZoom;
               if(finalY < -pTargetY * pTargetZoom)
               {
                  finalY = -pTargetY * pTargetZoom + CENTER_Y;
               }
            }
            else if(pTargetY < CENTER_Y / pTargetZoom)
            {
               finalY = 0;
            }
            this._container.x = finalX;
            this._container.y = finalY;
            Atouin.getInstance().currentZoom = pTargetZoom;
         }
         this._x = pTargetX;
         this._y = pTargetY;
      }
      
      private function onEnterFrame(pEvent:Event) : void
      {
         var entityPos:Point = this._entityToFollow.parent.localToGlobal(new Point(this._entityToFollow.x,this._entityToFollow.y));
         var pos:Point = this._container.globalToLocal(entityPos);
         if(this._zoom > MIN_SCALE)
         {
            this.zoomOnPos(this._zoom,pos.x,pos.y);
         }
      }
   }
}
