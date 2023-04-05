package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildCharacsUpgradeRequestAction extends AbstractAction implements Action
   {
       
      
      public var charaTypeTarget:uint;
      
      public function GuildCharacsUpgradeRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pCharaTypeTarget:uint) : GuildCharacsUpgradeRequestAction
      {
         var action:GuildCharacsUpgradeRequestAction = new GuildCharacsUpgradeRequestAction(arguments);
         action.charaTypeTarget = pCharaTypeTarget;
         return action;
      }
   }
}
