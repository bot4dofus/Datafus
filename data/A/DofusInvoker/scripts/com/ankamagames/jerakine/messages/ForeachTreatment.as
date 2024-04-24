package com.ankamagames.jerakine.messages
{
   public class ForeachTreatment extends Treatment
   {
       
      
      private var _iterable;
      
      private var _iterator:uint = 0;
      
      private var _worker:Worker;
      
      public function ForeachTreatment(object:*, func:Function, params:Array, iterable:*, worker:Worker)
      {
         params.insertAt(0,null);
         super(object,func,params);
         this._iterable = iterable;
         this._worker = worker;
      }
      
      override public function process() : Boolean
      {
         if(this._iterable.length == 0)
         {
            return true;
         }
         if(this._iterable.length <= this._iterator)
         {
            return false;
         }
         params[0] = this._iterable[this._iterator];
         ++this._iterator;
         calledfunction.apply(object,params);
         return this._iterable.length <= this._iterator;
      }
   }
}
