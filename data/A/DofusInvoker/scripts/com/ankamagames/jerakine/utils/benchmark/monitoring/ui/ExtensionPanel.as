package com.ankamagames.jerakine.utils.benchmark.monitoring.ui
{
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerConst;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerEvent;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.MonitoredObject;
   import flash.display.Sprite;
   
   public class ExtensionPanel extends Sprite
   {
       
      
      private var _parent:Sprite;
      
      private var _currentState:int = 0;
      
      private var _memoryState:MemoryPanel;
      
      private var _leakState:LeakDetectionPanel;
      
      public function ExtensionPanel(pRoot:Sprite)
      {
         super();
         this._parent = pRoot;
         y = FpsManagerConst.BOX_HEIGHT;
         this._memoryState = new MemoryPanel();
         this._leakState = new LeakDetectionPanel();
         this._leakState.addEventListener("follow",this.addGraphToMemory);
      }
      
      public function dumpData() : String
      {
         return this._leakState.dumpData();
      }
      
      public function get lastGc() : int
      {
         return this._memoryState.lastGc;
      }
      
      public function changeState(forceState:int = -1) : void
      {
         if(forceState != -1)
         {
            if(forceState == 1)
            {
               this._currentState = 0;
            }
            else if(forceState == 2)
            {
               this._currentState = 1;
            }
            else
            {
               this._currentState = 2;
            }
         }
         switch(this._currentState)
         {
            case 0:
               this._parent.addChild(this);
               this._memoryState.initMemGraph();
               this._memoryState.y = 5;
               addChild(this._memoryState);
               ++this._currentState;
               break;
            case 1:
               ++this._currentState;
               this._leakState.y = this._memoryState.y + FpsManagerConst.BOX_HEIGHT + 5;
               addChild(this._leakState);
               break;
            case 2:
               if(this.parent)
               {
                  this._parent.removeChild(this);
               }
               if(this._memoryState.parent)
               {
                  removeChild(this._memoryState);
                  this._memoryState.clearOtherGraph();
               }
               if(this._leakState.parent)
               {
                  removeChild(this._leakState);
               }
               this._currentState = 0;
         }
      }
      
      public function update() : void
      {
         this._memoryState.updateData();
         this._leakState.updateData();
         if(this._currentState == 1 || this._currentState == 2)
         {
            this._memoryState.render();
         }
      }
      
      private function addGraphToMemory(pEvt:FpsManagerEvent) : void
      {
         var mo:MonitoredObject = pEvt.data as MonitoredObject;
         this._memoryState.addNewGraph(mo);
      }
      
      public function set lastGc(val:int) : void
      {
         this._memoryState.lastGc = val;
      }
      
      public function watchObject(o:Object, pColor:uint, pIncrementParents:Boolean = false, objectClassName:String = null) : void
      {
         this._leakState.watchObject(o,pColor,pIncrementParents,objectClassName);
      }
      
      public function updateGc(max_memory:Number = 0) : void
      {
         this._memoryState.updateGc(max_memory);
      }
   }
}
