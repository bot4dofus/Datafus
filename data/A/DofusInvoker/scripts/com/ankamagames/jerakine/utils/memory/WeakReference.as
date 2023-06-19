package com.ankamagames.jerakine.utils.memory
{
   import flash.utils.Dictionary;
   
   public class WeakReference
   {
       
      
      private var dictionary:Dictionary;
      
      public function WeakReference(obj:*)
      {
         super();
         this.dictionary = new Dictionary(true);
         this.dictionary[obj] = null;
      }
      
      public function get object() : *
      {
         var n:* = undefined;
         var _loc2_:int = 0;
         var _loc3_:* = this.dictionary;
         for(n in _loc3_)
         {
            return n;
         }
         return null;
      }
      
      public function destroy() : void
      {
         this.dictionary = null;
      }
   }
}
