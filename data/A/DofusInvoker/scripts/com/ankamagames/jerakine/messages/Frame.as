package com.ankamagames.jerakine.messages
{
   import com.ankamagames.jerakine.utils.misc.Prioritizable;
   
   public interface Frame extends MessageHandler, Prioritizable
   {
       
      
      function pushed() : Boolean;
      
      function pulled() : Boolean;
   }
}
