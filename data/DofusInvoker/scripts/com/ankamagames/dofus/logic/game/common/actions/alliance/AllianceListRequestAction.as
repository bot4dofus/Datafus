package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceListRequestAction extends AbstractAction implements Action
   {
       
      
      public function AllianceListRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : AllianceListRequestAction
      {
         return new AllianceListRequestAction(arguments);
      }
   }
}
