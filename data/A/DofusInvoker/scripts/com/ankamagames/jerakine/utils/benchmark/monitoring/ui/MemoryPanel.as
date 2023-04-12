package com.ankamagames.jerakine.utils.benchmark.monitoring.ui
{
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerConst;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerUtils;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.MonitoredObject;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.system.System;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class MemoryPanel extends Sprite
   {
      
      private static var MAX_THEO_VALUE:int = 250;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MemoryPanel));
       
      
      private var _otherData:Dictionary;
      
      private var _memGraph:Bitmap;
      
      private var _memoryGraph:Vector.<Number>;
      
      private var _memoryLimits:Vector.<Number>;
      
      private var _lastTimer:int = 0;
      
      private var _infosTf:TextField;
      
      public var lastGc:int;
      
      public function MemoryPanel()
      {
         super();
         this.drawBG();
         this.init();
      }
      
      private function drawBG() : void
      {
         graphics.beginFill(FpsManagerConst.BOX_COLOR,0.7);
         graphics.lineStyle(2,FpsManagerConst.BOX_COLOR);
         graphics.drawRoundRect(0,0,FpsManagerConst.BOX_WIDTH,FpsManagerConst.BOX_HEIGHT,8,8);
         graphics.endFill();
      }
      
      private function init() : void
      {
         var tf:TextFormat = null;
         this._memoryGraph = new Vector.<Number>();
         this._memoryLimits = new Vector.<Number>();
         this._otherData = new Dictionary();
         tf = new TextFormat("Verdana",13);
         tf.color = 16777215;
         this._infosTf = new TextField();
         this._infosTf.y = FpsManagerConst.BOX_HEIGHT - 20;
         this._infosTf.x = 4;
         this._infosTf.defaultTextFormat = tf;
         this._infosTf.selectable = false;
         addEventListener(MouseEvent.CLICK,this.forceGC);
         addChild(this._infosTf);
      }
      
      private function forceGC(pEvt:MouseEvent) : void
      {
         System.gc();
         this.lastGc = getTimer();
      }
      
      public function updateData() : void
      {
         this._memoryGraph.push(FpsManagerUtils.calculateMB(System.totalMemory));
         this._memoryLimits.push(MAX_THEO_VALUE);
         if(this._memoryGraph.length > FpsManagerConst.BOX_WIDTH)
         {
            this._memoryGraph.shift();
            this._memoryLimits.shift();
         }
      }
      
      public function initMemGraph() : void
      {
         if(this._memGraph == null)
         {
            this._memGraph = new Bitmap(new BitmapData(FpsManagerConst.BOX_WIDTH,FpsManagerConst.BOX_HEIGHT,true,0));
            this._memGraph.smoothing = true;
            addChild(this._memGraph);
         }
         this.drawLine(this._memoryGraph,this._memoryLimits,4294967295);
      }
      
      public function render() : void
      {
         var mo:MonitoredObject = null;
         this._memGraph.bitmapData.lock();
         this._memGraph.bitmapData.scroll(-1,0);
         this._memGraph.bitmapData.fillRect(new Rectangle(FpsManagerConst.BOX_WIDTH - 1,1,1,FpsManagerConst.BOX_HEIGHT),16711680);
         for each(mo in this._otherData)
         {
            if(mo != null && mo.selected)
            {
               this.drawGraphValue(mo.data,mo.limits,FpsManagerUtils.addAlphaToColor(mo.color,4294967295));
            }
         }
         this.drawGraphValue(this._memoryGraph,this._memoryLimits,4294967295);
         this._memGraph.bitmapData.unlock();
      }
      
      private function drawGraphValue(pData:Vector.<Number>, pLimits:Vector.<Number>, pColor:uint) : void
      {
         var py:int = 0;
         var previousLimit:Number = NaN;
         var px:int = FpsManagerConst.BOX_WIDTH - 1;
         var currentLimit:Number = pLimits == null ? Number(MAX_THEO_VALUE) : Number(pLimits[pData.length - 1]);
         py = this.getGraphValue(pData,pData.length - 1,currentLimit);
         if(pData.length >= 2)
         {
            previousLimit = pLimits == null ? Number(MAX_THEO_VALUE) : Number(pLimits[pData.length - 2]);
            this.linkGraphValues(px,py,this.getGraphValue(pData,pData.length - 2,previousLimit),pColor);
         }
         this._memGraph.bitmapData.setPixel32(px,py,pColor);
      }
      
      public function clearOtherGraph() : void
      {
         var mo:MonitoredObject = null;
         for each(mo in this._otherData)
         {
            if(mo != null)
            {
               this.removeGraph(mo);
            }
         }
         removeChild(this._memGraph);
         this._memGraph.bitmapData.dispose();
         this._memGraph = null;
      }
      
      public function addNewGraph(o:MonitoredObject) : void
      {
         if(this._otherData[o.name] != null)
         {
            this.removeGraph(o);
         }
         else
         {
            o.selected = true;
            this._otherData[o.name] = o;
            this.drawLine(o.data,o.limits,FpsManagerUtils.addAlphaToColor(o.color,4294967295));
         }
      }
      
      public function removeGraph(o:MonitoredObject) : void
      {
         o.selected = false;
         this._otherData[o.name] = null;
         this.drawLine(o.data,o.limits);
      }
      
      private function drawLine(pData:Vector.<Number>, pLimits:Vector.<Number>, pColor:uint = 16711680) : void
      {
         var currentLimit:Number = NaN;
         var previousLimit:Number = NaN;
         var px:int = 0;
         var py:int = 0;
         var len:int = pData.length;
         var it:int = 0;
         for(it = 0; it < len; it++)
         {
            px = len < FpsManagerConst.BOX_WIDTH ? int(FpsManagerConst.BOX_WIDTH - len + it) : int(it);
            currentLimit = pLimits == null ? Number(MAX_THEO_VALUE) : Number(pLimits[it]);
            py = this.getGraphValue(pData,it,currentLimit);
            if(it != 0)
            {
               previousLimit = pLimits == null ? Number(MAX_THEO_VALUE) : Number(pLimits[it - 1]);
               this.linkGraphValues(px,py,this.getGraphValue(pData,it - 1,previousLimit),pColor);
            }
            this._memGraph.bitmapData.setPixel32(px,py,pColor);
         }
      }
      
      public function updateGc(max_memory:Number = 0) : void
      {
         if(max_memory > 0)
         {
            MAX_THEO_VALUE = Math.ceil(max_memory);
         }
         this._infosTf.text = "GC " + FpsManagerUtils.getTimeFromNow(this.lastGc);
      }
      
      private function getGraphValue(pData:Vector.<Number>, ind:int, pLimit:int = -1) : int
      {
         if(pLimit == -1)
         {
            pLimit = pLimit = FpsManagerUtils.getVectorMaxValue(pData);
         }
         var value:int = Math.floor(pData[ind] / pLimit * FpsManagerConst.BOX_HEIGHT * -1 + FpsManagerConst.BOX_HEIGHT);
         var bottom:int = FpsManagerConst.BOX_HEIGHT - 1;
         if(value < 1)
         {
            value = 1;
         }
         else if(value > bottom)
         {
            value = bottom;
         }
         return value;
      }
      
      private function linkGraphValues(px:int, py1:int, py2:int, pColor:uint) : void
      {
         if(Math.abs(py1 - py2) > 1)
         {
            this._memGraph.bitmapData.fillRect(new Rectangle(px - 1,(py1 > py2 ? py2 : py1) + 1,1,Math.abs(py1 - py2) - 1),pColor);
         }
      }
   }
}
