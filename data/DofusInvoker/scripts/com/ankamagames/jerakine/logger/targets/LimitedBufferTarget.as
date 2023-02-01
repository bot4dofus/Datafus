package com.ankamagames.jerakine.logger.targets
{
   import com.ankamagames.jerakine.json.JSON;
   import com.ankamagames.jerakine.logger.LogEvent;
   import com.hurlant.util.Base64;
   import damageCalculation.tools.LinkedList;
   import damageCalculation.tools.LinkedListIterator;
   import damageCalculation.tools.LinkedListNode;
   
   public class LimitedBufferTarget extends AbstractTarget
   {
       
      
      private var _buffer:LinkedList;
      
      private var _limit:int;
      
      private var _currentAddedElement:int = 0;
      
      public function LimitedBufferTarget(pLimit:int = 50)
      {
         super();
         this._limit = pLimit;
         this._currentAddedElement = 0;
         this._buffer = new LinkedList();
      }
      
      override public function logEvent(event:LogEvent) : void
      {
         if(this._currentAddedElement >= this._limit)
         {
            this._buffer.remove(this._buffer.head);
         }
         else
         {
            ++this._currentAddedElement;
         }
         this._buffer.add(event);
      }
      
      public function getFormatedBuffer() : String
      {
         var log:LinkedListNode = null;
         var obj:Object = null;
         var node:LogEvent = null;
         var newArray:Array = new Array();
         var iterator:LinkedListIterator = this._buffer.iterator();
         while(iterator.hasNext())
         {
            log = iterator.next();
            node = log.item as LogEvent;
            obj = new Object();
            obj.message = node.message;
            obj.level = node.level;
            newArray.push(obj);
         }
         var json:String = com.ankamagames.jerakine.json.JSON.encode(newArray);
         return Base64.encode(json);
      }
      
      public function clearBuffer() : void
      {
         this._buffer.clear();
         this._buffer = new LinkedList();
         this._currentAddedElement = 0;
      }
      
      public function getBuffer() : LinkedList
      {
         return this._buffer;
      }
   }
}
