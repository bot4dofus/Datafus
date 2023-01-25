package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceKickRequestAction extends AbstractAction implements Action
   {
       
      
      public var guildId:uint;
      
      public function AllianceKickRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pGuildId:uint) : AllianceKickRequestAction
      {
         var action:AllianceKickRequestAction = new AllianceKickRequestAction(arguments);
         action.guildId = pGuildId;
         return action;
      }
   }
}
