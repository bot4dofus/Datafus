package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildDeleteApplicationRequestAction extends AbstractAction implements Action
   {
       
      
      public function GuildDeleteApplicationRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : GuildDeleteApplicationRequestAction
      {
         return new GuildDeleteApplicationRequestAction(arguments);
      }
   }
}
