package com.ankamagames.dofus.logic.game.common.steps
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.types.GraphicCell;
   import com.ankamagames.dofus.misc.utils.Camera;
   import com.ankamagames.dofus.scripts.ScriptsUtil;
   import com.ankamagames.jerakine.sequencer.AbstractSequencable;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   import gs.TweenLite;
   
   public class CameraMoveStep extends AbstractSequencable
   {
       
      
      private var _camera:Camera;
      
      private var _args:Array;
      
      private var _instant:Boolean;
      
      private var _targetPos:Point;
      
      private var _container:DisplayObjectContainer;
      
      public function CameraMoveStep(pCamera:Camera, pArgs:Array, pInstant:Boolean)
      {
         super();
         this._camera = pCamera;
         this._args = pArgs;
         this._instant = pInstant;
         this._container = Atouin.getInstance().worldContainer;
      }
      
      override public function start() : void
      {
         var mp:MapPoint = null;
         var cell:GraphicCell = null;
         var cellPos:Point = null;
         var camPosObj:Object = null;
         var t:TweenLite = null;
         if(this._camera.currentZoom > Atouin.getInstance().options.getOption("frustum").scale && !isNaN(this._camera.x) && !isNaN(this._camera.y))
         {
            mp = ScriptsUtil.getMapPoint(this._args);
            cell = InteractiveCellManager.getInstance().getCell(mp.cellId);
            cellPos = cell.parent.localToGlobal(new Point(cell.x + cell.width / 2,cell.y + cell.height / 2));
            this._targetPos = this._container.globalToLocal(cellPos);
            if(this._instant)
            {
               this._camera.zoomOnPos(this._camera.currentZoom,this._targetPos.x,this._targetPos.y);
               executeCallbacks();
            }
            else
            {
               camPosObj = {
                  "x":this._camera.x,
                  "y":this._camera.y
               };
               t = new TweenLite(camPosObj,2,{
                  "x":this._targetPos.x,
                  "y":this._targetPos.y,
                  "onUpdate":this.updatePos,
                  "onUpdateParams":[camPosObj],
                  "onComplete":this.moveComplete
               });
            }
         }
      }
      
      private function updatePos(pCamPosObj:Object) : void
      {
         this._camera.zoomOnPos(this._camera.currentZoom,pCamPosObj.x,pCamPosObj.y);
      }
      
      private function moveComplete() : void
      {
         executeCallbacks();
      }
   }
}
