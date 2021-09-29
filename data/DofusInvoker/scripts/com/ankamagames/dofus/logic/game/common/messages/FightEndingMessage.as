package com.ankamagames.dofus.logic.game.common.messages
{
   import com.ankamagames.jerakine.messages.Message;
   
   public class FightEndingMessage implements Message
   {
       
      
      public function FightEndingMessage()
      {
         super();
      }
      
      public function initFightEndingMessage() : FightEndingMessage
      {
         return this;
      }
   }
}
