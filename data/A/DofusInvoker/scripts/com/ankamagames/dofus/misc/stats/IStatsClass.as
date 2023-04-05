package com.ankamagames.dofus.misc.stats
{
   import com.ankamagames.jerakine.messages.Message;
   
   public interface IStatsClass
   {
       
      
      function process(param1:Message, param2:Array = null) : void;
      
      function remove() : void;
   }
}
