package com.ankamagames.berilia.types.graphic
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDoubleClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOutMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOverMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseReleaseOutsideMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.messages.MessageHandler;
   import com.ankamagames.jerakine.pools.PoolablePoint;
   import com.ankamagames.jerakine.pools.PoolsManager;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import flash.display.DisplayObjectContainer;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class DragControler implements MessageHandler
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DragControler));
      
      private static var _previewContainer:Sprite;
      
      private static var _currentDragControler:DragControler;
       
      
      private const MAGNET_LENGTH:int = 40;
      
      private var _dragControlCount:uint;
      
      private var _startDragPosition:Point;
      
      private var _visibleBounds:Rectangle;
      
      private var _currentBounds:Rectangle;
      
      private var _dragRestrictedArea:Rectangle;
      
      private var _indexInParentBeforeDrag:int;
      
      private var _boundsContainerId:String;
      
      private var _boundsContainer:WeakReference;
      
      private var _controler:WeakReference;
      
      private var _target:WeakReference;
      
      private var _targetId:String;
      
      private var _utilPoint:Point;
      
      private var _magneticUiRect:Vector.<MagnetGrid>;
      
      public var useDragMagnetism:Boolean;
      
      public var savePosition:Boolean = true;
      
      public var restrictionFunction:Function;
      
      private var mousePositionOnMouseDown:Point;
      
      public function DragControler()
      {
         this._utilPoint = new Point();
         this.restrictionFunction = this.restrictPosition;
         this.mousePositionOnMouseDown = new Point();
         super();
      }
      
      public static function get busy() : Boolean
      {
         return _currentDragControler != null;
      }
      
      public function get boundsContainer() : String
      {
         return this._boundsContainerId;
      }
      
      public function set boundsContainer(id:String) : void
      {
         this._boundsContainerId = id;
      }
      
      private function get boundsContainerRef() : GraphicContainer
      {
         if(this._boundsContainerId == null)
         {
            return this.targetContainer;
         }
         if(this._boundsContainer && (this._boundsContainerId == null || this._boundsContainer.object.name == this._boundsContainerId))
         {
            return this._boundsContainer.object;
         }
         var gc:GraphicContainer = this.controler.getUi().getElement(this._boundsContainerId);
         if(!gc)
         {
            return null;
         }
         if(this._boundsContainer)
         {
            this._boundsContainer.destroy();
         }
         this._boundsContainer = new WeakReference(gc);
         return gc;
      }
      
      public function get target() : String
      {
         return this._targetId;
      }
      
      public function set target(id:String) : void
      {
         this._targetId = id;
      }
      
      private function get targetContainer() : GraphicContainer
      {
         if(this._target && (this._targetId == null || this._target.object.name == this._targetId))
         {
            return this._target.object;
         }
         var gc:GraphicContainer = this.controler.getUi().getElement(this._targetId);
         if(!gc)
         {
            return null;
         }
         if(this._target)
         {
            this._target.destroy();
         }
         this._target = new WeakReference(gc);
         return gc;
      }
      
      public function get controler() : GraphicContainer
      {
         return this._controler.object;
      }
      
      public function set controler(gc:GraphicContainer) : void
      {
         if(this._controler)
         {
            if(this._controler.object)
            {
               this._controler.object.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
               this._controler.object.removeEventListener("releaseOutside",this.onMouseUp);
               this._controler.object.removeEventListener(MouseEvent.DOUBLE_CLICK,this.onMouseDlbClick);
            }
            this._controler.destroy();
         }
         if(gc)
         {
            this._controler = new WeakReference(gc);
            if(!this._target)
            {
               this._target = new WeakReference(gc);
            }
            gc.mouseEnabled = true;
         }
      }
      
      public function restrictPosition() : void
      {
         var localPos:Point = null;
         var tempPoint:PoolablePoint = null;
         if(!this._startDragPosition || !_currentDragControler)
         {
            this.setupDragVars();
         }
         this._utilPoint.x = this.targetContainer.x;
         this._utilPoint.y = this.targetContainer.y;
         var targetParent:DisplayObjectContainer = this.targetContainer.parent;
         if(!targetParent)
         {
            return;
         }
         var globalPos:Point = targetParent.localToGlobal(this._utilPoint);
         this._currentBounds.x = globalPos.x;
         this._currentBounds.y = globalPos.y;
         if(!this._dragRestrictedArea.containsRect(this._currentBounds))
         {
            this._utilPoint.x = this._dragRestrictedArea.x;
            this._utilPoint.y = this._dragRestrictedArea.y;
            localPos = targetParent.globalToLocal(this._utilPoint);
            if(this._currentBounds.x < this._dragRestrictedArea.x)
            {
               this.targetContainer.xNoCache = localPos.x;
            }
            else if(this._currentBounds.x > this._dragRestrictedArea.right)
            {
               this.targetContainer.xNoCache = this._dragRestrictedArea.width + localPos.x;
            }
            if(this._currentBounds.y < this._dragRestrictedArea.y)
            {
               this.targetContainer.yNoCache = localPos.y;
            }
            else if(this._currentBounds.y > this._dragRestrictedArea.bottom)
            {
               this.targetContainer.yNoCache = this._dragRestrictedArea.height + localPos.y;
            }
            if(this._currentBounds.x > this._dragRestrictedArea.right - 128 && this._currentBounds.y < 32)
            {
               tempPoint = PoolsManager.getInstance().getPointPool().checkOut() as PoolablePoint;
               tempPoint.renew(0,32);
               this.targetContainer.yNoCache = targetParent.globalToLocal(tempPoint).y;
               PoolsManager.getInstance().getPointPool().checkIn(tempPoint);
            }
         }
      }
      
      public function process(rawMsg:Message) : Boolean
      {
         var gc:GraphicContainer = null;
         if(!this.controler)
         {
            _currentDragControler = null;
            this.togglePreviewContainer(false);
            EnterFrameDispatcher.removeEventListener(this.onEnterframe);
            return false;
         }
         gc = this.controler.getUi().getElement(this._targetId);
         if(!(rawMsg is MouseMessage) || ResizeController.busy || OptionManager.getOptionManager("dofus").getOption("lockUI") == true && gc.name.indexOf("tooltip") == -1 || gc.notMovableUIUnderConditions)
         {
            return false;
         }
         var msg:MouseMessage = rawMsg as MouseMessage;
         switch(true)
         {
            case msg is MouseDownMessage:
               this.onMouseDown(null);
               break;
            case msg is MouseReleaseOutsideMessage:
            case msg is MouseUpMessage:
               this.onMouseUp(null);
               break;
            case msg is MouseDoubleClickMessage:
               this.onMouseDlbClick(null);
               break;
            case msg is MouseOverMessage:
               if(msg.target == this.controler)
               {
                  Mouse.cursor = "drag";
               }
               break;
            case msg is MouseOutMessage:
               if(msg.target == this.controler)
               {
                  Mouse.cursor = MouseCursor.AUTO;
               }
         }
         return false;
      }
      
      private function setupDragVars() : void
      {
         var ui:UiRootContainer = null;
         var magneticElements:Array = null;
         var gc:GraphicContainer = null;
         var gcBounds:Rectangle = null;
         this._startDragPosition = new Point();
         this._visibleBounds = this.boundsContainerRef.getBounds(StageShareManager.stage);
         this._visibleBounds.width = this.boundsContainerRef.width;
         this._visibleBounds.height = this.boundsContainerRef.height;
         this._currentBounds = this._visibleBounds.clone();
         this._dragRestrictedArea = StageShareManager.stageVisibleBounds.clone();
         this._magneticUiRect = new Vector.<MagnetGrid>();
         var uiList:Dictionary = Berilia.getInstance().uiList;
         for each(ui in uiList)
         {
            if(ui != this.targetContainer.getUi())
            {
               if(ui.visible != false)
               {
                  magneticElements = ui.magneticElements;
                  for each(gc in magneticElements)
                  {
                     gcBounds = gc.getBounds(StageShareManager.stage);
                     this._magneticUiRect.push(new MagnetGrid(new Rectangle(gcBounds.x,gcBounds.y - this.MAGNET_LENGTH,gcBounds.width,this.MAGNET_LENGTH),true,false,false,false,false,true,ui.name + " " + gc.name + "top_border"));
                     this._magneticUiRect.push(new MagnetGrid(new Rectangle(gcBounds.x,gcBounds.y + gcBounds.height,gcBounds.width,this.MAGNET_LENGTH),true,false,false,false,true,false,ui.name + " " + gc.name + "bot_border"));
                     this._magneticUiRect.push(new MagnetGrid(new Rectangle(gcBounds.x - this.MAGNET_LENGTH,gcBounds.y,this.MAGNET_LENGTH,gcBounds.height),false,true,true,false,false,false,ui.name + " " + gc.name + "left_border"));
                     this._magneticUiRect.push(new MagnetGrid(new Rectangle(gcBounds.x + gcBounds.width,gcBounds.y,this.MAGNET_LENGTH,gcBounds.height),false,true,false,true,false,false,ui.name + " " + gc.name + "right_border"));
                  }
               }
            }
         }
         this._magneticUiRect.push(new MagnetGrid(new Rectangle(this._dragRestrictedArea.left,this._dragRestrictedArea.top,this.MAGNET_LENGTH,this._dragRestrictedArea.height),false,true,false,true,false,false,"Screen left border"));
         this._magneticUiRect.push(new MagnetGrid(new Rectangle(this._dragRestrictedArea.right - this.MAGNET_LENGTH,this._dragRestrictedArea.top,this.MAGNET_LENGTH,this._dragRestrictedArea.height),false,true,true,false,false,false,"Screen right border"));
         this._magneticUiRect.push(new MagnetGrid(new Rectangle(this._dragRestrictedArea.left,this._dragRestrictedArea.top,this._dragRestrictedArea.width,this.MAGNET_LENGTH),true,false,false,false,true,false,"Screen top border"));
         this._magneticUiRect.push(new MagnetGrid(new Rectangle(this._dragRestrictedArea.left,this._dragRestrictedArea.bottom - this.MAGNET_LENGTH,this._dragRestrictedArea.width,this.MAGNET_LENGTH),true,false,false,false,false,true,"Screen bottom border"));
         this._dragRestrictedArea.width -= this._visibleBounds.width;
         this._dragRestrictedArea.height -= this._visibleBounds.height;
      }
      
      private function getMagneticResult(realBounds:Boolean = true) : Rectangle
      {
         var currentBounds:Rectangle = null;
         var mg:MagnetGrid = null;
         var collideZone:Rectangle = null;
         var r:Rectangle = null;
         var targetPoint:Point = null;
         var screenBounds:Rectangle = null;
         if(!this._magneticUiRect || this._magneticUiRect.length == 0)
         {
            return null;
         }
         if(this.targetContainer.getUi().magneticElements.length)
         {
            currentBounds = this.targetContainer.getUi().magneticElements[0].getBounds(StageShareManager.stage);
            currentBounds.width = this.targetContainer.getUi().magneticElements[0].width;
            currentBounds.height = this.targetContainer.getUi().magneticElements[0].height;
         }
         else
         {
            currentBounds = this.boundsContainerRef.getBounds(StageShareManager.stage);
            currentBounds.width = this.boundsContainerRef.width;
            currentBounds.height = this.boundsContainerRef.height;
         }
         var biggestCollisionAreaSurface:uint = 0;
         var biggestCollisionArea:MagnetGrid = null;
         for each(mg in this._magneticUiRect)
         {
            collideZone = mg.collidArea.intersection(currentBounds);
            if(collideZone.width * collideZone.height > biggestCollisionAreaSurface)
            {
               biggestCollisionAreaSurface = collideZone.width * collideZone.height;
               biggestCollisionArea = mg;
            }
         }
         if(biggestCollisionAreaSurface != 0)
         {
            r = this.getNewPosition(currentBounds,biggestCollisionArea);
            if(realBounds)
            {
               this._utilPoint.x = this.targetContainer.x;
               this._utilPoint.y = this.targetContainer.y;
               targetPoint = this.targetContainer.localToGlobal(this._utilPoint);
               r.x += targetPoint.x - currentBounds.x;
               r.y += targetPoint.y - currentBounds.y;
               if(this.targetContainer.getUi().fullscreen)
               {
                  r.x -= StageShareManager.stageVisibleBounds.left;
                  r.y -= StageShareManager.stageVisibleBounds.top;
               }
            }
            else
            {
               screenBounds = StageShareManager.stageVisibleBounds;
               if(r.x < screenBounds.left || r.y < screenBounds.top || r.x + r.width > screenBounds.width + screenBounds.left || r.y + r.height > screenBounds.height + screenBounds.top)
               {
                  return null;
               }
            }
            return r;
         }
         return null;
      }
      
      private function getNewPosition(target:Rectangle, magneticArea:MagnetGrid) : Rectangle
      {
         var leftDiff:int = 0;
         var rightDiff:int = 0;
         var topDiff:int = 0;
         var botDiff:int = 0;
         var result:Rectangle = new Rectangle(target.x,target.y,target.width,target.height);
         if(magneticArea.magnetOnBottomSide)
         {
            result.y = magneticArea.collidArea.bottom - target.height;
         }
         if(magneticArea.magnetOnTopSide)
         {
            result.y = magneticArea.collidArea.y;
         }
         if(magneticArea.magnetOnLeftSide)
         {
            result.x = magneticArea.collidArea.x;
         }
         if(magneticArea.magnetOnRightSide)
         {
            result.x = magneticArea.collidArea.right - target.width;
         }
         if(magneticArea.cornerX)
         {
            leftDiff = Math.abs(magneticArea.collidArea.left - target.x);
            rightDiff = Math.abs(magneticArea.collidArea.right - target.x - target.width);
            if(target.x - magneticArea.collidArea.left < this.MAGNET_LENGTH && target.x + target.width / 2 > magneticArea.collidArea.left && leftDiff <= rightDiff)
            {
               result.x = magneticArea.collidArea.left;
            }
            else if(magneticArea.collidArea.right - target.x - target.width < this.MAGNET_LENGTH && target.x + target.width / 2 < magneticArea.collidArea.right)
            {
               result.x = magneticArea.collidArea.right - target.width;
            }
         }
         if(magneticArea.cornerY)
         {
            topDiff = Math.abs(magneticArea.collidArea.top - target.y);
            botDiff = Math.abs(magneticArea.collidArea.bottom - target.y - target.height);
            if(target.y - magneticArea.collidArea.top < this.MAGNET_LENGTH && target.y + target.height / 2 > magneticArea.collidArea.top && topDiff <= botDiff)
            {
               result.y = magneticArea.collidArea.top;
            }
            else if(magneticArea.collidArea.bottom - target.y - target.height < this.MAGNET_LENGTH && target.y + target.height / 2 < magneticArea.collidArea.bottom)
            {
               result.y = magneticArea.collidArea.bottom - target.height;
            }
         }
         return result;
      }
      
      private function drawShape(rect:Rectangle, color:uint, alpha:Number) : Shape
      {
         var s:Shape = new Shape();
         s.graphics.beginFill(color,alpha);
         s.graphics.drawRect(rect.x,rect.y,rect.width,rect.height);
         s.graphics.endFill();
         return s;
      }
      
      private function togglePreviewContainer(visible:Boolean) : void
      {
         var screenBounds:Rectangle = null;
         if(visible)
         {
            screenBounds = StageShareManager.stageVisibleBounds;
            if(!_previewContainer)
            {
               _previewContainer = new Sprite();
            }
            else
            {
               _previewContainer.graphics.clear();
            }
            _previewContainer.graphics.beginFill(0,0);
            _previewContainer.graphics.drawRect(screenBounds.left,screenBounds.top,screenBounds.width,screenBounds.height);
            _previewContainer.graphics.endFill();
            Berilia.getInstance().docMain.addChildAt(_previewContainer,0);
         }
         else if(_previewContainer && _previewContainer.parent)
         {
            _previewContainer.parent.removeChild(_previewContainer);
            _previewContainer = null;
         }
      }
      
      private function onMouseDown(e:MouseEvent) : void
      {
         if(ResizeController.busy)
         {
            return;
         }
         this.togglePreviewContainer(true);
         this.setupDragVars();
         _currentDragControler = this;
         this.mousePositionOnMouseDown.x = StageShareManager.mouseX;
         this.mousePositionOnMouseDown.y = StageShareManager.mouseY;
         this._startDragPosition.x = StageShareManager.mouseX - this.targetContainer.x;
         this._startDragPosition.y = StageShareManager.mouseY - this.targetContainer.y;
         if(this.targetContainer.parent)
         {
            this._indexInParentBeforeDrag = this.targetContainer.parent.getChildIndex(this.targetContainer);
            this.targetContainer.parent.setChildIndex(this.targetContainer,this.targetContainer.parent.numChildren - 1);
         }
         EnterFrameDispatcher.addEventListener(this.onEnterframe,EnterFrameConst.REFRESH_DRAG_UI);
      }
      
      private function onMouseUp(e:Event) : void
      {
         var magneticResult:Rectangle = null;
         var fullscreenOffset:Number = NaN;
         if(EnterFrameDispatcher.hasEventListener(this.onEnterframe))
         {
            if(this.mousePositionOnMouseDown.x == StageShareManager.mouseX && this.mousePositionOnMouseDown.y == StageShareManager.mouseY)
            {
               _currentDragControler = null;
               this.togglePreviewContainer(false);
               EnterFrameDispatcher.removeEventListener(this.onEnterframe);
               return;
            }
            _currentDragControler = null;
            this.targetContainer.cacheAsBitmap = false;
            this.targetContainer.xNoCache = Math.round(StageShareManager.mouseX - this._startDragPosition.x);
            this.targetContainer.yNoCache = Math.round(StageShareManager.mouseY - this._startDragPosition.y);
            OptionManager.getOptionManager("dofus").setOption("resetUIPositions",true);
            if(this.useDragMagnetism)
            {
               magneticResult = this.getMagneticResult();
               if(magneticResult)
               {
                  this.targetContainer.xNoCache = magneticResult.x;
                  this.targetContainer.yNoCache = magneticResult.y;
               }
            }
            this.restrictionFunction();
            if(this.savePosition)
            {
               if(this.targetContainer.getUi().fullscreen)
               {
                  fullscreenOffset = StageShareManager.stageVisibleBounds.x;
                  this.targetContainer.setSavedPosition(this.targetContainer.x + fullscreenOffset,this.targetContainer.y);
               }
               else
               {
                  this.targetContainer.setSavedPosition(this.targetContainer.x,this.targetContainer.y);
               }
            }
            this.targetContainer.parent.setChildIndex(this.targetContainer,this._indexInParentBeforeDrag);
            this.togglePreviewContainer(false);
            EnterFrameDispatcher.removeEventListener(this.onEnterframe);
         }
      }
      
      private function onMouseDlbClick(e:Event) : void
      {
         Berilia.getInstance().resetUiSavedUserModification(this.targetContainer.getUi().name);
      }
      
      private function onEnterframe(e:Event) : void
      {
         var magneticResult:Rectangle = null;
         if(this.mousePositionOnMouseDown.x == StageShareManager.mouseX && this.mousePositionOnMouseDown.y == StageShareManager.mouseY)
         {
            return;
         }
         this.targetContainer.xNoCache = Math.round(StageShareManager.mouseX - this._startDragPosition.x);
         this.targetContainer.yNoCache = Math.round(StageShareManager.mouseY - this._startDragPosition.y);
         if(this.useDragMagnetism)
         {
            magneticResult = this.getMagneticResult(false);
            while(_previewContainer.numChildren)
            {
               _previewContainer.removeChildAt(0);
            }
            if(magneticResult)
            {
               _previewContainer.addChild(this.drawShape(magneticResult,2565891,0.6));
            }
         }
         this.restrictionFunction();
         var urc:UiRootContainer = this.targetContainer.getUi();
         if(urc && urc.uiClass && urc.uiClass.hasOwnProperty("dragUpdate"))
         {
            urc.uiClass.dragUpdate();
         }
      }
      
      public function destroy() : void
      {
         this.controler = null;
         _currentDragControler = null;
         EnterFrameDispatcher.removeEventListener(this.onEnterframe);
         if(Mouse.cursor == "drag")
         {
            Mouse.cursor = MouseCursor.AUTO;
            Mouse.show();
         }
      }
   }
}

import flash.geom.Rectangle;

class MagnetGrid
{
    
   
   public var collidArea:Rectangle;
   
   public var cornerX:Boolean = true;
   
   public var cornerY:Boolean = true;
   
   public var magnetOnRightSide:Boolean = true;
   
   public var magnetOnLeftSide:Boolean = true;
   
   public var magnetOnTopSide:Boolean = true;
   
   public var magnetOnBottomSide:Boolean = true;
   
   public var name:String;
   
   function MagnetGrid(collidArea:Rectangle = null, cornerX:Boolean = true, cornerY:Boolean = true, magnetOnRightSide:Boolean = true, magnetOnLeftSide:Boolean = true, magnetOnTopSide:Boolean = true, magnetOnBottomSide:Boolean = true, name:String = "")
   {
      super();
      this.collidArea = collidArea;
      this.cornerX = cornerX;
      this.cornerY = cornerY;
      this.magnetOnRightSide = magnetOnRightSide;
      this.magnetOnLeftSide = magnetOnLeftSide;
      this.magnetOnTopSide = magnetOnTopSide;
      this.magnetOnBottomSide = magnetOnBottomSide;
      this.name = name;
   }
}
