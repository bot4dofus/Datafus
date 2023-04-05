package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ArenaFightAnswerAction extends AbstractAction implements Action
   {
       
      
      public var fightId:uint;
      
      public var accept:Boolean;
      
      public function ArenaFightAnswerAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(fightId:uint, accept:Boolean) : ArenaFightAnswerAction
      {
         var a:ArenaFightAnswerAction = new ArenaFightAnswerAction(arguments);
         a.fightId = fightId;
         a.accept = accept;
         return a;
      }
   }
}
