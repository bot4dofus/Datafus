package com.ankamagames.jerakine.utils.benchmark.monitoring
{
   import com.ankamagames.jerakine.utils.benchmark.monitoring.ui.ExtensionPanel;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.ui.GraphDisplayer;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.ui.RedrawRegionButton;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.ui.StateButton;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.profiler.showRedrawRegions;
   import flash.system.System;
   import flash.utils.getTimer;
   
   public class FpsManager extends Sprite
   {
      
      private static var _instance:FpsManager;
       
      
      private var _decal:Point;
      
      private var _btnStateSpr:StateButton;
      
      private var _btnRetrace:RedrawRegionButton;
      
      private var _graphPanel:GraphDisplayer;
      
      private var _extensionPanel:ExtensionPanel;
      
      private var _redrawRegionsVisible:Boolean = false;
      
      private var _ticks:uint = 0;
      
      private var _last:uint;
      
      public function FpsManager()
      {
         this._last = getTimer();
         super();
         this._btnRetrace = new RedrawRegionButton(FpsManagerConst.BOX_WIDTH + 30,0);
         this._btnRetrace.addEventListener(MouseEvent.CLICK,this.redrawRegionHandler);
         addChild(this._btnRetrace);
         this._graphPanel = new GraphDisplayer();
         addChild(this._graphPanel);
         this._extensionPanel = new ExtensionPanel(this);
         this._btnStateSpr = new StateButton(FpsManagerConst.BOX_WIDTH + 5,0);
         this._btnStateSpr.addEventListener(MouseEvent.CLICK,this.changeState);
         addChild(this._btnStateSpr);
         FpsManagerConst.PLAYER_VERSION = FpsManagerUtils.getVersion();
         x = y = 50;
         if(FpsManagerConst.PLAYER_VERSION >= 10)
         {
            this._graphPanel.previousFreeMem = FpsManagerUtils.calculateMB(System["freeMemory"]);
            this._extensionPanel.lastGc = getTimer();
         }
         this.startTracking(FpsManagerConst.SPECIAL_GRAPH[1].name,FpsManagerConst.SPECIAL_GRAPH[1].color);
      }
      
      public static function getInstance() : FpsManager
      {
         if(_instance == null)
         {
            _instance = new FpsManager();
         }
         return _instance;
      }
      
      public function dumpData() : String
      {
         return this._extensionPanel.dumpData();
      }
      
      public function display() : void
      {
         if(_instance == null)
         {
            throw new Error("FpsManager is not initialized");
         }
         StageShareManager.stage.addChild(_instance);
         this._graphPanel.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         EnterFrameDispatcher.addEventListener(this.loop,EnterFrameConst.LOOP_FPS_MANAGER);
      }
      
      public function hide() : void
      {
         if(_instance == null)
         {
            throw new Error("FpsManager is not initialized");
         }
         StageShareManager.stage.removeChild(_instance);
         this._graphPanel.removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         EnterFrameDispatcher.removeEventListener(this.loop);
      }
      
      private function onMouseDown(pEvt:MouseEvent) : void
      {
         this._decal = new Point(pEvt.localX,pEvt.localY);
         StageShareManager.stage.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         StageShareManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
      }
      
      private function onMouseUp(pEvt:MouseEvent) : void
      {
         this._decal = null;
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
      }
      
      private function onMouseMove(pEvt:MouseEvent) : void
      {
         x = StageShareManager.stage.mouseX - this._decal.x;
         y = StageShareManager.stage.mouseY - this._decal.y;
         pEvt.updateAfterEvent();
      }
      
      private function redrawRegionHandler(pEvt:MouseEvent) : void
      {
         this._redrawRegionsVisible = !this._redrawRegionsVisible;
         showRedrawRegions(this._redrawRegionsVisible,17595);
      }
      
      public function changeState(pEvt:MouseEvent = null) : void
      {
         this._extensionPanel.changeState();
      }
      
      private function loop(pEvt:Event) : void
      {
         var fpsValue:Number = NaN;
         this.stopTracking(FpsManagerConst.SPECIAL_GRAPH[0].name);
         this.startTracking(FpsManagerConst.SPECIAL_GRAPH[0].name,FpsManagerConst.SPECIAL_GRAPH[0].color);
         this._graphPanel.update();
         this.updateMem();
         ++this._ticks;
         var now:uint = getTimer();
         var delta:uint = now - this._last;
         if(delta >= 500)
         {
            fpsValue = this._ticks / delta * 1000;
            this._graphPanel.updateFpsValue(fpsValue);
            this._extensionPanel.update();
            this._ticks = 0;
            this._last = now;
         }
      }
      
      private function updateMem() : void
      {
         var currentFreeMem:Number = NaN;
         var max_memory:Number = NaN;
         this._graphPanel.memory = FpsManagerUtils.calculateMB(System.totalMemory).toPrecision(4);
         if(FpsManagerConst.PLAYER_VERSION >= 10)
         {
            currentFreeMem = FpsManagerUtils.calculateMB(System["freeMemory"]);
            if(currentFreeMem - this._graphPanel.previousFreeMem > 1)
            {
               this._extensionPanel.lastGc = getTimer();
            }
            max_memory = FpsManagerUtils.calculateMB(System["privateMemory"]);
            this._graphPanel.memory += "/" + max_memory.toPrecision(4);
            this._graphPanel.previousFreeMem = currentFreeMem;
            this._extensionPanel.updateGc(max_memory);
         }
         this._graphPanel.memory += " MB";
      }
      
      public function startTracking(pIndice:String, pColor:uint = 16777215) : void
      {
         this._graphPanel.startTracking(pIndice,pColor);
      }
      
      public function stopTracking(pIndice:String) : void
      {
         this._graphPanel.stopTracking(pIndice);
      }
      
      public function watchObject(o:Object, incrementParents:Boolean = false, objectClassName:String = null) : void
      {
         this._extensionPanel.watchObject(o,FpsManagerUtils.getBrightRandomColor(),incrementParents,objectClassName);
      }
   }
}
