package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SurrenderVoteAction extends AbstractAction implements Action
   {
       
      
      private var _vote:Boolean = false;
      
      public function SurrenderVoteAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(voteValue:Boolean) : SurrenderVoteAction
      {
         var action:SurrenderVoteAction = new SurrenderVoteAction(arguments);
         action.vote = voteValue;
         return action;
      }
      
      public function get vote() : Boolean
      {
         return this._vote;
      }
      
      public function set vote(value:Boolean) : void
      {
         this._vote = value;
      }
   }
}
