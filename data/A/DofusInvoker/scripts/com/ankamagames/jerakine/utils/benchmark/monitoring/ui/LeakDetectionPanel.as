package com.ankamagames.jerakine.utils.benchmark.monitoring.ui
{
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerConst;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerEvent;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerUtils;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.List;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.MonitoredObject;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import flash.display.Sprite;
   import flash.events.TextEvent;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class LeakDetectionPanel extends Sprite
   {
      
      private static const WIDTH:int = FpsManagerConst.BOX_WIDTH;
       
      
      private var _listDataObject:Dictionary;
      
      private var _dataTf:TextField;
      
      public function LeakDetectionPanel()
      {
         super();
         this._listDataObject = new Dictionary();
         this._dataTf = new TextField();
         this._dataTf.multiline = true;
         this._dataTf.thickness = 200;
         this._dataTf.autoSize = "left";
         this._dataTf.addEventListener(TextEvent.LINK,this.linkHandler);
         addChild(this._dataTf);
         this.drawBG();
      }
      
      private function drawBG() : void
      {
         graphics.clear();
         graphics.beginFill(FpsManagerConst.BOX_COLOR,0.7);
         graphics.lineStyle(2,FpsManagerConst.BOX_COLOR);
         graphics.drawRoundRect(0,0,WIDTH,this._dataTf.textHeight + 8,8,8);
         graphics.endFill();
      }
      
      public function watchObject(o:Object, pColor:uint, incrementParents:Boolean = false, objectClassName:String = null) : void
      {
         var qualifiedClassName:String = null;
         var list:List = null;
         var firstList:List = null;
         var secondList:List = null;
         var ex:String = null;
         var c:String = null;
         if(objectClassName == null)
         {
            qualifiedClassName = getQualifiedClassName(o);
            objectClassName = qualifiedClassName.substring(qualifiedClassName.indexOf("::") + 2);
         }
         var mObject:MonitoredObject = this._listDataObject[objectClassName];
         if(mObject == null)
         {
            if(incrementParents)
            {
               list = new List(objectClassName);
               firstList = list;
               for each(ex in DescribeTypeCache.getExtendsClasses(o))
               {
                  if(ex.indexOf("::") != -1)
                  {
                     c = ex.substring(ex.indexOf("::") + 2);
                  }
                  else
                  {
                     c = ex;
                  }
                  if(this._listDataObject[c] != null)
                  {
                     firstList.next = (this._listDataObject[c] as MonitoredObject).extendsClass;
                     break;
                  }
                  secondList = new List(c);
                  firstList.next = secondList;
                  secondList = firstList;
               }
            }
            mObject = new MonitoredObject(objectClassName,pColor,list);
            this._listDataObject[objectClassName] = mObject;
            if(incrementParents && list != null)
            {
               this.updateParents(list,mObject);
            }
         }
         else if(mObject.color == 16777215)
         {
            mObject.color = pColor;
         }
         mObject.addNewValue(o);
      }
      
      private function updateParents(list:List, o:Object) : void
      {
         while(list != null)
         {
            if(list.value != null)
            {
               this.updateParent(list.value.toString(),o,list.next);
            }
            list = list.next;
         }
      }
      
      private function updateParent(pName:String, pValue:Object, pList:List) : void
      {
         var mObject:MonitoredObject = this._listDataObject[pName];
         if(mObject == null)
         {
            mObject = new MonitoredObject(pName,16777215,pList);
            this._listDataObject[pName] = mObject;
         }
         mObject.addNewValue(pValue);
      }
      
      public function dumpData() : String
      {
         var mo:MonitoredObject = null;
         var moList:Array = [];
         var toReturn:String = "";
         for each(mo in this._listDataObject)
         {
            moList.push(mo);
         }
         moList.sortOn("name");
         for each(mo in moList)
         {
            toReturn += mo.name + " " + FpsManagerUtils.countKeys(mo.list) + "\n";
         }
         return toReturn;
      }
      
      public function updateData() : void
      {
         var mo:MonitoredObject = null;
         var str:* = "";
         var moList:Array = [];
         for each(mo in this._listDataObject)
         {
            moList.push(mo);
            mo.update();
         }
         moList.sortOn("name");
         for each(mo in moList)
         {
            str += "<font face=\'Verdana\' size=\'15\' color=\'#" + mo.color.toString(16) + "\' >";
            if(mo.selected)
            {
               str += "(*) ";
            }
            str += "<a href=\'event:" + mo.name + "\'>[" + mo.name + "]</a> : " + FpsManagerUtils.countKeys(mo.list);
            str += "</font>\n";
         }
         this._dataTf.htmlText = str;
         this._dataTf.width = this._dataTf.textWidth + 10;
         this.drawBG();
      }
      
      private function linkHandler(pEvt:TextEvent) : void
      {
         var mo:MonitoredObject = this._listDataObject[pEvt.text];
         if(mo == null)
         {
            return;
         }
         var evt:FpsManagerEvent = new FpsManagerEvent("follow");
         evt.data = mo;
         dispatchEvent(evt);
      }
   }
}
