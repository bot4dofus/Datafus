package com.ankamagames.atouin.types.sequences
{
   import com.ankamagames.atouin.utils.CellUtil;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import gs.TweenMax;
   import gs.easing.Linear;
   
   public class ParableGfxMovementStep extends AbstractSequencable
   {
       
      
      private var _gfxEntity:IMovable;
      
      private var _targetPoint:MapPoint;
      
      private var _curvePrc:Number;
      
      private var _yOffset:int;
      
      private var _yOffsetOnHit:int;
      
      private var _waitEnd:Boolean;
      
      private var _speed:uint;
      
      public function ParableGfxMovementStep(gfxEntity:IMovable, targetPoint:MapPoint, speed:uint, curvePrc:Number = 0.5, yOffset:int = 0, waitEnd:Boolean = true, yOffsetOnHit:int = 0)
      {
         super();
         this._gfxEntity = gfxEntity;
         this._targetPoint = targetPoint;
         this._curvePrc = curvePrc;
         this._waitEnd = waitEnd;
         this._speed = speed;
         this._yOffset = yOffset;
         this._yOffsetOnHit = yOffsetOnHit;
      }
      
      override public function start() : void
      {
         var distance:Number = NaN;
         if(this._targetPoint.equals(this._gfxEntity.position))
         {
            if(this._waitEnd)
            {
               executeCallbacks();
            }
            return;
         }
         var start:Point = new Point(CellUtil.getPixelXFromMapPoint((this._gfxEntity as IEntity).position),CellUtil.getPixelYFromMapPoint((this._gfxEntity as IEntity).position) + this._yOffset);
         var end:Point = new Point(CellUtil.getPixelXFromMapPoint(this._targetPoint),CellUtil.getPixelYFromMapPoint(this._targetPoint) + (this._yOffsetOnHit != 0 ? this._yOffsetOnHit : this._yOffset));
         distance = Point.distance(start,end);
         var curvePoint:Point = Point.interpolate(start,end,0.5);
         curvePoint.y -= distance * this._curvePrc;
         DisplayObject(this._gfxEntity).y = DisplayObject(this._gfxEntity).y + this._yOffset;
         TweenMax.to(this._gfxEntity,distance / 100 * this._speed / 1000,{
            "x":end.x,
            "y":end.y,
            "orientToBezier":true,
            "bezier":[{
               "x":curvePoint.x,
               "y":curvePoint.y
            }],
            "scaleX":1,
            "scaleY":1,
            "alpha":1,
            "ease":Linear.easeNone,
            "immediateRender":true,
            "onComplete":(!!this._waitEnd ? executeCallbacks : null)
         });
         if(!this._waitEnd)
         {
            executeCallbacks();
         }
      }
   }
}
