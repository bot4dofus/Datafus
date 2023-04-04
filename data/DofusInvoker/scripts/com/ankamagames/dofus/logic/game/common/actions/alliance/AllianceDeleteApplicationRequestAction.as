package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceDeleteApplicationRequestAction extends AbstractAction implements Action
   {
       
      
      public function AllianceDeleteApplicationRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : AllianceDeleteApplicationRequestAction
      {
         return new AllianceDeleteApplicationRequestAction(arguments);
      }
   }
}
