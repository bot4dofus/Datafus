package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceChangeGuildRightsAction extends AbstractAction implements Action
   {
       
      
      public var guildId:uint;
      
      public var rights:uint;
      
      public function AllianceChangeGuildRightsAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(guildId:uint, rights:uint) : AllianceChangeGuildRightsAction
      {
         var action:AllianceChangeGuildRightsAction = new AllianceChangeGuildRightsAction(arguments);
         action.guildId = guildId;
         action.rights = rights;
         return action;
      }
   }
}
