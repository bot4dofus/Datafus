package com.ankamagames.jerakine.messages
{
   public class WhileTreatment extends Treatment
   {
       
      
      public function WhileTreatment(object:*, func:Function, params:Array)
      {
         super(object,func,params);
      }
      
      override public function process() : Boolean
      {
         return !calledfunction.apply(object,params);
      }
   }
}
