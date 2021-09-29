package com.ankamagames.berilia.types.graphic
{
   import com.ankamagames.berilia.managers.ExternalUiManager;
   import com.ankamagames.berilia.types.event.UiRenderEvent;
   import com.ankamagames.jerakine.handlers.HumanInputHandler;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.NativeWindow;
   import flash.display.NativeWindowInitOptions;
   import flash.display.NativeWindowSystemChrome;
   import flash.display.NativeWindowType;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.getQualifiedClassName;
   
   public class ExternalUi extends NativeWindow
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ExternalUi));
       
      
      private var _mainContainer:Sprite;
      
      private var _uiRootContainer:UiRootContainer;
      
      private var _sizeControler:DisplayObject;
      
      private var _dragging:Boolean;
      
      private const margin:uint = 10;
      
      public function ExternalUi()
      {
         var nativeWinOpts:NativeWindowInitOptions = new NativeWindowInitOptions();
         nativeWinOpts.systemChrome = NativeWindowSystemChrome.NONE;
         nativeWinOpts.type = NativeWindowType.NORMAL;
         nativeWinOpts.resizable = false;
         nativeWinOpts.transparent = true;
         alwaysInFront = true;
         super(nativeWinOpts);
         visible = false;
         stage.scaleMode = StageScaleMode.NO_SCALE;
         stage.align = StageAlign.TOP_LEFT;
         HumanInputHandler.getInstance().registerListeners(stage);
         ExternalUiManager.getInstance().registerExternalUi(this);
         this._mainContainer = new Sprite();
         stage.addChild(this._mainContainer);
         addEventListener(Event.ACTIVATE,this.onActivate);
      }
      
      public function set uiRootContainer(urc:UiRootContainer) : void
      {
         while(this._mainContainer.numChildren)
         {
            this._mainContainer.removeChildAt(0);
         }
         if(this._uiRootContainer)
         {
            this._uiRootContainer.windowOwner = null;
         }
         this._sizeControler = urc;
         this._uiRootContainer = urc;
         urc.windowOwner = this;
         this._uiRootContainer.addEventListener(UiRenderEvent.UIRenderComplete,this.onUiRendered);
         this._mainContainer.addChild(urc);
      }
      
      public function get uiRootContainer() : UiRootContainer
      {
         return this._uiRootContainer;
      }
      
      public function set sizeControler(t:DisplayObject) : void
      {
         if(t == null)
         {
            this._sizeControler = this._uiRootContainer;
         }
         else
         {
            this._sizeControler = t;
         }
      }
      
      public function addDragController(target:InteractiveObject) : void
      {
         if(target is GraphicContainer && (target as GraphicContainer).getResizeController())
         {
            (target as GraphicContainer).getResizeController().resizeStartCallBack = this.resizeStartCallback;
         }
         target.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownForDrag,false,0,true);
         target.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUpForDrag,false,0,true);
         target.mouseEnabled = true;
      }
      
      public function removeDragController(target:InteractiveObject) : void
      {
         target.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownForDrag);
      }
      
      public function addResizeControler(target:InteractiveObject) : void
      {
         target.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownForResize,false,0,true);
      }
      
      public function removeResizeControler(target:InteractiveObject) : void
      {
         target.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownForResize);
      }
      
      protected function onUiRendered(e:UiRenderEvent) : void
      {
         visible = true;
         width = this._sizeControler.width + this.margin * 2;
         height = this._sizeControler.height + this.margin * 2;
         var firstCtr:GraphicContainer = Sprite(this._uiRootContainer.getChildAt(0)).getChildAt(0) as GraphicContainer;
         x = firstCtr.x + StageShareManager.stage.nativeWindow.x + this.margin;
         y = firstCtr.y + StageShareManager.stage.nativeWindow.y + this.margin;
         firstCtr.x = 0;
         firstCtr.y = 0;
      }
      
      private function exploreUi(target:DisplayObject, indent:String = "") : void
      {
         var doc:DisplayObjectContainer = null;
         var i:uint = 0;
         if(target is DisplayObjectContainer)
         {
            doc = target as DisplayObjectContainer;
            for(i = 0; i < doc.numChildren; i++)
            {
               this.exploreUi(doc.getChildAt(i),indent + ".   ");
            }
         }
      }
      
      private function colorUi(target:DisplayObject) : void
      {
         var doc:DisplayObjectContainer = null;
         var i:uint = 0;
         var s:Shape = null;
         if(target is DisplayObjectContainer)
         {
            doc = target as DisplayObjectContainer;
            for(i = 0; i < doc.numChildren; i++)
            {
               this.exploreUi(doc.getChildAt(i));
            }
         }
         if(target is Sprite)
         {
            s = new Shape();
            s.graphics.beginFill(16777215 * Math.random(),0.4);
            s.graphics.drawRect(target.x,target.y,target.width,target.height);
            s.graphics.endFill();
            Sprite(target).addChild(s);
         }
      }
      
      private function onActivate(event:Event) : void
      {
         alwaysInFront = true;
      }
      
      override public function startMove() : Boolean
      {
         var objects:Array = this._uiRootContainer.getObjectsUnderPoint(new Point(this._uiRootContainer.mouseX,this._uiRootContainer.mouseY));
         for(var i:int = 0; i < objects.length; i++)
         {
            if(objects[i] is TextField && (objects[i] as TextField).selectable)
            {
               return false;
            }
         }
         return super.startMove();
      }
      
      protected function onMouseOver(event:MouseEvent) : void
      {
      }
      
      protected function onMouseDownForResize(event:MouseEvent) : void
      {
         this.startResize();
      }
      
      protected function onMouseDownForDrag(event:MouseEvent) : void
      {
         this._dragging = true;
         if(event.currentTarget is GraphicContainer && event.currentTarget.getResizeController())
         {
            return;
         }
         this.startMove();
      }
      
      protected function resizeStartCallback(resizing:Boolean) : void
      {
         if(!resizing && this._dragging)
         {
            this.startMove();
         }
      }
      
      protected function onMouseUpForDrag(event:MouseEvent) : void
      {
         this._dragging = false;
      }
      
      public function destroy() : void
      {
         this._uiRootContainer.removeEventListener(UiRenderEvent.UIRenderComplete,this.onUiRendered);
         removeEventListener(Event.ACTIVATE,this.onActivate);
         ExternalUiManager.getInstance().unregisterExternalUi(this);
         close();
      }
   }
}
