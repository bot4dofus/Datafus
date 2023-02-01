package com.ankamagames.jerakine.messages
{
   public class ForTreatment extends Treatment
   {
       
      
      private var _maxIterations:uint;
      
      private var _iterations:uint = 0;
      
      private var _worker:Worker;
      
      public function ForTreatment(object:*, func:Function, params:Array, iterations:uint, worker:Worker)
      {
         params.insertAt(0,null);
         super(object,func,params);
         this._maxIterations = iterations;
         this._worker = worker;
      }
      
      override public function process() : Boolean
      {
         params[0] = this._iterations;
         calledfunction.apply(object,params);
         return ++this._iterations >= this._maxIterations;
      }
   }
}
