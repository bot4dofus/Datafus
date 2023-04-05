package com.ankamagames.dofus.logic.game.fight.messages
{
   import com.ankamagames.dofus.network.messages.game.actions.fight.GameActionFightDeathMessage;
   import com.ankamagames.jerakine.messages.Message;
   
   public class GameActionFightLeaveMessage extends GameActionFightDeathMessage implements Message
   {
       
      
      public function GameActionFightLeaveMessage()
      {
         super();
      }
      
      public function initGameActionFightLeaveMessage(actionId:uint = 0, sourceId:Number = 0, targetId:Number = 0) : GameActionFightLeaveMessage
      {
         super.initGameActionFightDeathMessage(actionId,sourceId,targetId);
         return this;
      }
   }
}
