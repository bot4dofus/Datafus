package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class KohOverAction extends AbstractAction implements Action
   {
       
      
      public function KohOverAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : KohOverAction
      {
         return new KohOverAction();
      }
   }
}
