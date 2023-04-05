package com.ankamagames.jerakine.tasking
{
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.utils.errors.AbstractMethodCallError;
   import com.ankamagames.jerakine.utils.misc.Prioritizable;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public class SplittedTask extends EventDispatcher implements Prioritizable
   {
       
      
      private var _nPriority:int;
      
      public function SplittedTask()
      {
         super();
      }
      
      public function step(e:Event) : void
      {
         throw new AbstractMethodCallError("step() must be redefined");
      }
      
      public function stepsPerFrame() : uint
      {
         throw new AbstractMethodCallError("stepsPerFrame() must be redefined");
      }
      
      public function get priority() : int
      {
         if(isNaN(this._nPriority))
         {
            return Priority.NORMAL;
         }
         return this._nPriority;
      }
      
      public function set priority(p:int) : void
      {
         this._nPriority = p;
      }
   }
}
