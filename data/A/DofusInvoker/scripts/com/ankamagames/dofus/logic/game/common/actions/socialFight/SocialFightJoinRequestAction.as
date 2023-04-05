package com.ankamagames.dofus.logic.game.common.actions.socialFight
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.dofus.network.types.game.social.fight.SocialFightInfo;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SocialFightJoinRequestAction extends AbstractAction implements Action
   {
       
      
      public var fightInfo:SocialFightInfo;
      
      public function SocialFightJoinRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(fightInfo:SocialFightInfo) : SocialFightJoinRequestAction
      {
         var action:SocialFightJoinRequestAction = new SocialFightJoinRequestAction(arguments);
         action.fightInfo = fightInfo;
         return action;
      }
   }
}
