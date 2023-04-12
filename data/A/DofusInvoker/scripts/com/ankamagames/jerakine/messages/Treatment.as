package com.ankamagames.jerakine.messages
{
   public class Treatment
   {
       
      
      private var _object;
      
      private var _calledFunction:Function;
      
      private var _params:Array;
      
      public function Treatment(object:*, func:Function, params:Array)
      {
         super();
         this._object = object;
         this._calledFunction = func;
         this._params = params;
      }
      
      public function get calledfunction() : Function
      {
         return this._calledFunction;
      }
      
      public function get params() : Array
      {
         return this._params;
      }
      
      public function get object() : *
      {
         return this._object;
      }
      
      public function process() : Boolean
      {
         this._calledFunction.apply(this._object,this._params);
         return true;
      }
      
      public function isSameTreatment(object:*, func:Function, params:Array) : Boolean
      {
         if(object != this._object || func != this._calledFunction || this._params.length != params.length)
         {
            return false;
         }
         for(var i:int = 0; i < this._params.length; i++)
         {
            if(params[i] != this._params[i])
            {
               return false;
            }
         }
         return true;
      }
      
      public function isCloseTreatment(object:*, func:Function, params:Array) : Boolean
      {
         var param:* = undefined;
         if(object && object != this._object || func && func != this._calledFunction)
         {
            return false;
         }
         for each(param in params)
         {
            if(this._params.indexOf(param) == -1)
            {
               return false;
            }
         }
         return true;
      }
   }
}
