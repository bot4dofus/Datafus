package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkDisplayArrowManager;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowCellManager;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowMonsterManager;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowNpcManager;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.types.Callback;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   [InstanciedApi]
   public class HighlightApi implements IApi
   {
      
      private static var _showCellTimer:BenchmarkTimer;
      
      private static var _cellIds:Array;
      
      private static var _currentCell:int;
       
      
      private var _nextDelayBeforeShow:uint = 0;
      
      private var _delayBeforeShowTimer:BenchmarkTimer;
      
      private var _delayBeforeShowCallback:Callback;
      
      public function HighlightApi()
      {
         super();
         this._delayBeforeShowTimer = new BenchmarkTimer(0,0,"HighlightApi._delayBeforeShowTimer");
      }
      
      private static function onCellTimer(e:Event) : void
      {
         if(e == null && _showCellTimer && !_showCellTimer.running)
         {
            _showCellTimer.addEventListener(TimerEvent.TIMER,onCellTimer);
            _showCellTimer.start();
         }
         HyperlinkShowCellManager.showCell(_cellIds[_currentCell]);
         ++_currentCell;
         if(_currentCell >= _cellIds.length)
         {
            _currentCell = 0;
         }
      }
      
      public function setDisplayDelay(milleseconds:uint) : void
      {
         this._nextDelayBeforeShow = milleseconds;
      }
      
      public function forceArrowPosition(pUiName:String, pComponentName:String, pPosition:Point) : void
      {
         this.show(HyperlinkDisplayArrowManager.setArrowPosition,pUiName,pComponentName,pPosition);
      }
      
      public function highlightUi(uiName:String, componentName:String, pos:int = 0, reverse:int = 0, strata:int = 5, loop:Boolean = false) : void
      {
         this.show(HyperlinkDisplayArrowManager.showArrow,uiName,componentName,pos,reverse,strata,!!loop ? 1 : 0);
      }
      
      public function highlightCell(cellIds:Array, loop:Boolean = false) : void
      {
         if(loop)
         {
            if(!_showCellTimer)
            {
               _showCellTimer = new BenchmarkTimer(2000,0,"HighlightApi._showCellTimer");
            }
            _cellIds = cellIds;
            _currentCell = 0;
            _showCellTimer.reset();
            this.show(onCellTimer,null);
         }
         else
         {
            if(_showCellTimer)
            {
               _showCellTimer.reset();
            }
            this.show(HyperlinkShowCellManager.showCell,cellIds);
         }
      }
      
      public function highlightAbsolute(targetRect:Rectangle, pos:uint, reverse:int = 0, strata:int = 5, loop:Boolean = false) : void
      {
         this.show(HyperlinkDisplayArrowManager.showAbsoluteArrow,targetRect,pos,reverse,strata,!!loop ? 1 : 0);
      }
      
      public function highlightMapTransition(mapId:Number, shapeOrientation:int, position:int, reverse:Boolean = false, strata:int = 5, loop:Boolean = false) : void
      {
         this.show(HyperlinkDisplayArrowManager.showMapTransition,mapId,shapeOrientation,position,!!reverse ? 1 : 0,strata,!!loop ? 1 : 0);
      }
      
      public function highlightNpc(npcId:int, loop:Boolean = false) : void
      {
         this.show(HyperlinkShowNpcManager.showNpc,npcId,!!loop ? 1 : 0);
      }
      
      public function highlightMonster(monsterId:Number, loop:Boolean = false) : void
      {
         this.show(HyperlinkShowMonsterManager.showMonster,monsterId,!!loop ? 1 : 0);
      }
      
      public function stop() : void
      {
         this.clearDelayedShow();
         HyperlinkDisplayArrowManager.destroyArrow();
         if(_showCellTimer)
         {
            _showCellTimer.reset();
            _showCellTimer.removeEventListener(TimerEvent.TIMER,onCellTimer);
         }
      }
      
      public function getArrowUiProperties() : Object
      {
         return HyperlinkDisplayArrowManager.getArrowUiProperties();
      }
      
      protected function onDelayBeforeShowTimer(event:TimerEvent) : void
      {
         if(this._delayBeforeShowCallback)
         {
            try
            {
               this._delayBeforeShowCallback.exec();
            }
            catch(e:Error)
            {
            }
         }
         this._delayBeforeShowCallback = null;
      }
      
      private function show(fct:Function, ... args) : void
      {
         this.clearDelayedShow();
         this._delayBeforeShowCallback = Callback.argFromArray(fct,args);
         if(this._nextDelayBeforeShow == 0)
         {
            this.onDelayBeforeShowTimer(null);
         }
         else
         {
            this._delayBeforeShowTimer.delay = this._nextDelayBeforeShow;
            this._delayBeforeShowTimer.addEventListener(TimerEvent.TIMER,this.onDelayBeforeShowTimer,false,0,true);
            this._delayBeforeShowTimer.start();
         }
         this._nextDelayBeforeShow = 0;
      }
      
      private function clearDelayedShow() : void
      {
         this._delayBeforeShowCallback = null;
         this._delayBeforeShowTimer.reset();
         this._delayBeforeShowTimer.removeEventListener(TimerEvent.TIMER,this.onDelayBeforeShowTimer);
      }
   }
}
