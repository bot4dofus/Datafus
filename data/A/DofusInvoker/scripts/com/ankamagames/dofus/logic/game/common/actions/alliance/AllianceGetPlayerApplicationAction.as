package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceGetPlayerApplicationAction extends AbstractAction implements Action
   {
       
      
      public function AllianceGetPlayerApplicationAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : AllianceGetPlayerApplicationAction
      {
         return new AllianceGetPlayerApplicationAction(arguments);
      }
   }
}
