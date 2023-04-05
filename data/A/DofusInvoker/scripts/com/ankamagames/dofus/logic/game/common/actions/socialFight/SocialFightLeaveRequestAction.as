package com.ankamagames.dofus.logic.game.common.actions.socialFight
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.dofus.network.types.game.social.fight.SocialFightInfo;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SocialFightLeaveRequestAction extends AbstractAction implements Action
   {
       
      
      public var fightInfo:SocialFightInfo;
      
      public function SocialFightLeaveRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(fightInfo:SocialFightInfo) : SocialFightLeaveRequestAction
      {
         var action:SocialFightLeaveRequestAction = new SocialFightLeaveRequestAction(arguments);
         action.fightInfo = fightInfo;
         return action;
      }
   }
}
