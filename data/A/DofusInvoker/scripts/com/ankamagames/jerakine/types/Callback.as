package com.ankamagames.jerakine.types
{
   public class Callback
   {
       
      
      public var method:Function;
      
      public var args:Array;
      
      public function Callback(fMethod:Function, ... aArgs)
      {
         super();
         this.method = fMethod;
         this.args = aArgs;
      }
      
      public static function argFromArray(fMethod:Function, args:Array = null) : Callback
      {
         var cb:Callback = new Callback(fMethod);
         cb.args = args;
         return cb;
      }
      
      public function exec() : *
      {
         return this.method.apply(null,this.args);
      }
   }
}
