package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceInsiderInfoRequestAction extends AbstractAction implements Action
   {
       
      
      public function AllianceInsiderInfoRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : AllianceInsiderInfoRequestAction
      {
         return new AllianceInsiderInfoRequestAction(arguments);
      }
   }
}
