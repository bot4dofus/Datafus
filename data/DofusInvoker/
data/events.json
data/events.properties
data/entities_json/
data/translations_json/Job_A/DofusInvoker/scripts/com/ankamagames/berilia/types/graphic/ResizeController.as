package com.ankamagames.berilia.types.graphic
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.types.data.Margin;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOutMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOverMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseReleaseOutsideMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.messages.MessageHandler;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   import flash.utils.getQualifiedClassName;
   
   public class ResizeController extends Sprite implements MessageHandler
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ResizeController));
      
      public static var DEBUG_SHAPE:Boolean = false;
      
      private static var _currentResizeController:ResizeController;
      
      private static var _busy:Boolean = false;
      
      private static var _previewContainer:Sprite;
       
      
      private var _lastWidth:int;
      
      private var _lastHeight:int;
      
      private var _mouseX:int;
      
      private var _mouseY:int;
      
      private var _startWidth:int;
      
      private var _startHeight:int;
      
      private var _startX:Number;
      
      private var _startY:Number;
      
      private var _resizing:Boolean;
      
      private var _width:Number;
      
      private var _height:Number;
      
      private var _margin:Margin;
      
      private var _controler:WeakReference;
      
      private var _target:WeakReference;
      
      private var _targetId:String;
      
      private var _stageBounds:Rectangle;
      
      private var _canUseVerticalResize:Boolean = true;
      
      private var _canUseHorizontalResize:Boolean = true;
      
      private var _verticalResize:Boolean;
      
      private var _horizontalResize:Boolean;
      
      private var _topLeft:UiBorder;
      
      private var _top:UiBorder;
      
      private var _topRight:UiBorder;
      
      private var _left:UiBorder;
      
      private var _right:UiBorder;
      
      private var _bottomLeft:UiBorder;
      
      private var _bottom:UiBorder;
      
      private var _bottomRight:UiBorder;
      
      private var _currentBorder:UiBorder;
      
      private var _nextCursorId:String;
      
      private var _resizeStartCallBack:Callback;
      
      public function ResizeController()
      {
         this._margin = new Margin(5,5,5,5);
         super();
         this._topLeft = this.configShape(0,0,1,1,null,true,true,"resizeR");
         this._top = this.configShape(0,0,1,1,null,false,true,"resizeV");
         this._topRight = this.configShape(0,0,1,1,null,true,true,"resizeL");
         this._left = this.configShape(0,0,1,1,null,true,false,"resizeH");
         this._right = this.configShape(0,0,1,1,null,true,false,"resizeH");
         this._bottomLeft = this.configShape(0,0,1,1,null,true,true,"resizeL");
         this._bottom = this.configShape(0,0,1,1,null,false,true,"resizeV");
         this._bottomRight = this.configShape(0,0,1,1,null,true,true,"resizeR");
         mouseEnabled = false;
      }
      
      public static function get busy() : Boolean
      {
         return _currentResizeController != null;
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
            this._controler.destroy();
         }
         this._controler = new WeakReference(gc);
         if(!this._target)
         {
            this._target = new WeakReference(gc);
         }
      }
      
      override public function set width(w:Number) : void
      {
         this._width = w;
         this.draw();
      }
      
      override public function set height(h:Number) : void
      {
         this._height = h;
         this.draw();
      }
      
      override public function get width() : Number
      {
         return !!isNaN(this._width) ? Number(super.width) : Number(this._width);
      }
      
      override public function get height() : Number
      {
         return !!isNaN(this._height) ? Number(super.height) : Number(this._height);
      }
      
      public function set topResize(value:Boolean) : void
      {
         this._top.enabled = this._topLeft.enabled = this._topRight.enabled = value;
      }
      
      public function set bottomResize(value:Boolean) : void
      {
         this._bottom.enabled = this._bottomLeft.enabled = this._bottomRight.enabled = value;
      }
      
      public function set leftResize(value:Boolean) : void
      {
         this._left.enabled = this._topLeft.enabled = this._bottomLeft.enabled = value;
      }
      
      public function set rightResize(value:Boolean) : void
      {
         this._right.enabled = this._topRight.enabled = this._bottomRight.enabled = value;
      }
      
      public function set resizeStartCallBack(f:Function) : void
      {
         this._resizeStartCallBack = new Callback(f);
      }
      
      public function update() : void
      {
         this.draw();
      }
      
      public function process(rawMsg:Message) : Boolean
      {
         if(_currentResizeController && _currentResizeController != this || !(rawMsg is MouseMessage) || DragControler.busy)
         {
            if(this._resizeStartCallBack)
            {
               this._resizeStartCallBack.args = [false];
               this._resizeStartCallBack.exec();
            }
            return false;
         }
         var msg:MouseMessage = rawMsg as MouseMessage;
         if(msg.target is UiBorder && !(msg.target as UiBorder).enabled)
         {
            return false;
         }
         switch(true)
         {
            case msg is MouseDownMessage:
               if(msg.target is UiBorder)
               {
                  this._currentBorder = msg.target as UiBorder;
                  this.resizeStart();
               }
               if(this._resizeStartCallBack)
               {
                  this._resizeStartCallBack.args = [this._resizing];
                  this._resizeStartCallBack.exec();
               }
               break;
            case msg is MouseReleaseOutsideMessage:
            case msg is MouseUpMessage:
               if(this._resizing)
               {
                  this.resizeEnd();
               }
               break;
            case msg is MouseOverMessage:
               if(msg.target is UiBorder)
               {
                  this._nextCursorId = UiBorder(msg.target).cursorId;
               }
               else
               {
                  this._nextCursorId = MouseCursor.AUTO;
               }
               break;
            case msg is MouseOutMessage:
               if(msg.target is UiBorder)
               {
                  this._nextCursorId = MouseCursor.AUTO;
               }
         }
         if(!this._resizing && this._nextCursorId)
         {
            Mouse.cursor = this._nextCursorId;
            this._nextCursorId = null;
         }
         return false;
      }
      
      public function destroy() : void
      {
         EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
      }
      
      public function hasResizeStartCallBack() : Boolean
      {
         return this._resizeStartCallBack != null;
      }
      
      private function draw() : void
      {
         this.configShape(0,0,this._margin.left,this._margin.top,this._topLeft);
         this.configShape(this._margin.left,0,this.width - this._margin.left - this._margin.right,this._margin.top,this._top);
         this.configShape(this.width - this._margin.right,0,this._margin.left,this._margin.top,this._topRight);
         this.configShape(0,this._margin.top,this._margin.left,this.height - this._margin.top - this._margin.bottom,this._left);
         this.configShape(this.width - this._margin.right,this._margin.top,this._margin.right,this.height - this._margin.top - this._margin.bottom,this._right);
         this.configShape(0,this.height - this._margin.bottom,this._margin.left,this._margin.bottom,this._bottomLeft);
         this.configShape(this._margin.left,this.height - this._margin.bottom,this.width - this._margin.left - this._margin.right,this._margin.bottom,this._bottom);
         this.configShape(this.width - this._margin.right,this.height - this._margin.bottom,this._margin.right,this._margin.bottom,this._bottomRight);
      }
      
      private function resizeStart() : void
      {
         this._resizing = true;
         _currentResizeController = this;
         this._stageBounds = StageShareManager.stageVisibleBounds;
         this._mouseX = Math.min(this._stageBounds.right,Math.max(this._stageBounds.left,StageShareManager.mouseX));
         this._mouseY = Math.min(this._stageBounds.bottom,Math.max(this._stageBounds.top,StageShareManager.mouseY));
         this._startWidth = this.targetContainer.width;
         this._startHeight = this.targetContainer.height;
         this._startX = this.targetContainer.x;
         this._startY = this.targetContainer.y;
         this._horizontalResize = this._currentBorder.horizontalResize && this._canUseHorizontalResize;
         this._verticalResize = this._currentBorder.verticalResize && this._canUseVerticalResize;
         if(!this._horizontalResize && !this._verticalResize)
         {
            this._horizontalResize = true;
            this._verticalResize = true;
         }
         this.togglePreviewContainer(true);
         EnterFrameDispatcher.addEventListener(this.onEnterFrame,EnterFrameConst.GRAPHIC_CONTAINER);
      }
      
      private function onEnterFrame(e:Event) : void
      {
         var currentMouseX:Number = Math.min(this._stageBounds.right,Math.max(this._stageBounds.left,StageShareManager.mouseX));
         var currentMouseY:Number = Math.min(this._stageBounds.bottom,Math.max(this._stageBounds.top,StageShareManager.mouseY));
         var gc:GraphicContainer = this.targetContainer;
         var newX:Number = this._startX;
         var newY:Number = this._startY;
         var w:int = this.targetContainer.width;
         var h:int = this.targetContainer.height;
         switch(this._currentBorder)
         {
            case this._topLeft:
               newX = this._startX + currentMouseX - this._mouseX;
               newY = this._startY + currentMouseY - this._mouseY;
               w = this._startWidth + this._mouseX - currentMouseX;
               h = this._startHeight + this._mouseY - currentMouseY;
               break;
            case this._top:
               newY = this._startY + currentMouseY - this._mouseY;
               h = this._startHeight + this._mouseY - currentMouseY;
               break;
            case this._topRight:
               newY = this._startY + currentMouseY - this._mouseY;
               w = this._startWidth + currentMouseX - this._mouseX;
               h = this._startHeight + this._mouseY - currentMouseY;
               break;
            case this._left:
               newX = this._startX + currentMouseX - this._mouseX;
               w = this._startWidth + this._mouseX - currentMouseX;
               break;
            case this._right:
               w = this._startWidth + currentMouseX - this._mouseX;
               break;
            case this._bottomLeft:
               newX = this._startX + currentMouseX - this._mouseX;
               w = this._startWidth + this._mouseX - currentMouseX;
               h = this._startHeight + currentMouseY - this._mouseY;
               break;
            case this._bottom:
               h = this._startHeight + currentMouseY - this._mouseY;
               break;
            case this._bottomRight:
               h = this._startHeight + currentMouseY - this._mouseY;
               w = this._startWidth + currentMouseX - this._mouseX;
         }
         if(gc.minSize != null)
         {
            if(!isNaN(gc.minSize.x) && w < gc.minSize.x)
            {
               if(this._currentBorder == this._topLeft || this._currentBorder == this._left || this._currentBorder == this._bottomLeft)
               {
                  newX += w - gc.minSize.x;
               }
               w = gc.minSize.x;
            }
            if(!isNaN(gc.minSize.y) && h < gc.minSize.y)
            {
               if(this._currentBorder == this._topLeft || this._currentBorder == this._top || this._currentBorder == this._topRight)
               {
                  newY -= gc.minSize.y - h;
               }
               h = gc.minSize.y;
            }
         }
         if(gc.maxSize != null)
         {
            if(!isNaN(gc.maxSize.x) && w > gc.maxSize.x)
            {
               if(this._currentBorder == this._topLeft || this._currentBorder == this._left || this._currentBorder == this._bottomLeft)
               {
                  newX += w - gc.maxSize.x;
               }
               w = gc.maxSize.x;
            }
            if(!isNaN(gc.maxSize.y) && h > gc.maxSize.y)
            {
               if(this._currentBorder == this._topLeft || this._currentBorder == this._top || this._currentBorder == this._topRight)
               {
                  newY -= gc.minSize.y - h;
               }
               h = gc.maxSize.y;
            }
         }
         newX = Math.min(int(this._stageBounds.right),Math.max(int(this._stageBounds.left),newX));
         newY = Math.min(int(this._stageBounds.bottom),Math.max(int(this._stageBounds.top),newY));
         var change:Boolean = false;
         gc.getUi()._lock = true;
         if(this._horizontalResize && gc.width != w)
         {
            gc.xNoCache = newX;
            gc.widthNoCache = w;
            change = true;
         }
         if(this._verticalResize && gc.height != h)
         {
            gc.yNoCache = newY;
            gc.heightNoCache = h;
            change = true;
         }
         gc.getUi()._lock = false;
         if(change)
         {
            gc.setSavedDimension(gc.width,gc.height);
            gc.setSavedPosition(gc.x,gc.y);
            try
            {
               gc.getUi().render();
               if(gc.getUi().windowOwner)
               {
                  gc.xNoCache = 0;
                  gc.yNoCache = 0;
                  gc.getUi().windowOwner.width = gc.width + 10 * 2;
                  gc.getUi().windowOwner.height = gc.height + 10 * 2;
               }
            }
            catch(err:Error)
            {
            }
         }
      }
      
      private function resizeEnd() : void
      {
         _currentResizeController = null;
         EnterFrameDispatcher.removeEventListener(this.onEnterFrame);
         this._resizing = false;
         if(this._nextCursorId)
         {
            Mouse.cursor = this._nextCursorId;
            this._nextCursorId = null;
         }
         this.togglePreviewContainer(false);
         if(this._mouseX != StageShareManager.mouseX || this._mouseY != StageShareManager.mouseY)
         {
            this.targetContainer.getUi().render();
         }
         if(this.targetContainer.getUi().windowOwner)
         {
            this.targetContainer.xNoCache = this.targetContainer.yNoCache = 0;
            this.targetContainer.getUi().windowOwner.width = this.targetContainer.width + 10 * 2;
            this.targetContainer.getUi().windowOwner.height = this.targetContainer.height + 10 * 2;
         }
      }
      
      private function configShape(x:int, y:int, width:int, height:int, target:UiBorder = null, resizeH:Boolean = false, resizeV:Boolean = false, cursorId:String = null) : UiBorder
      {
         if(target == null)
         {
            target = new UiBorder();
            target.graphics.beginFill(16777215 * Math.random(),!!DEBUG_SHAPE ? Number(0.8) : Number(0));
            target.graphics.drawRect(0,0,1,1);
            target.graphics.endFill();
            target.cursorId = cursorId;
            target.horizontalResize = resizeH;
            target.verticalResize = resizeV;
            addChild(target);
         }
         target.x = x;
         target.y = y;
         target.width = width;
         target.height = height;
         return target;
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
   }
}
