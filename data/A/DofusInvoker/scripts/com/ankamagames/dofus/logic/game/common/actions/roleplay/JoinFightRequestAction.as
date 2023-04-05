package com.ankamagames.dofus.logic.game.common.actions.roleplay
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class JoinFightRequestAction extends AbstractAction implements Action
   {
       
      
      public var fightId:uint;
      
      public var teamLeaderId:Number;
      
      public function JoinFightRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(fightId:uint, teamLeaderId:Number) : JoinFightRequestAction
      {
         var a:JoinFightRequestAction = new JoinFightRequestAction(arguments);
         a.fightId = fightId;
         a.teamLeaderId = teamLeaderId;
         return a;
      }
   }
}
