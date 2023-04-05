package com.ankamagames.dofus.logic.game.common.actions.socialFight
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.dofus.network.types.game.social.fight.SocialFightInfo;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SocialFightTakePlaceRequestAction extends AbstractAction implements Action
   {
       
      
      public var fightInfo:SocialFightInfo;
      
      public var playerId:int;
      
      public function SocialFightTakePlaceRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(fightInfo:SocialFightInfo, playerId:int) : SocialFightTakePlaceRequestAction
      {
         var action:SocialFightTakePlaceRequestAction = new SocialFightTakePlaceRequestAction(arguments);
         action.fightInfo = fightInfo;
         action.playerId = playerId;
         return action;
      }
   }
}
