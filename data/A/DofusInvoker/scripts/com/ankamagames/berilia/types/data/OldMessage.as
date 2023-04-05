package com.ankamagames.berilia.types.data
{
   import flash.utils.Dictionary;
   
   public class OldMessage
   {
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
       
      
      public var hook:String;
      
      public var args:Array;
      
      public function OldMessage(pHook:String, pArgs:Array)
      {
         super();
         this.hook = pHook;
         this.args = pArgs;
         MEMORY_LOG[this] = 1;
      }
   }
}
