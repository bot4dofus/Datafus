package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildSpellUpgradeRequestAction extends AbstractAction implements Action
   {
       
      
      public var spellId:uint;
      
      public function GuildSpellUpgradeRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pSpellId:uint) : GuildSpellUpgradeRequestAction
      {
         var action:GuildSpellUpgradeRequestAction = new GuildSpellUpgradeRequestAction(arguments);
         action.spellId = pSpellId;
         return action;
      }
   }
}
