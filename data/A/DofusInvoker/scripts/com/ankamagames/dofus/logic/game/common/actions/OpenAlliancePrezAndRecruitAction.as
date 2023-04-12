package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenAlliancePrezAndRecruitAction extends AbstractAction implements Action
   {
       
      
      public function OpenAlliancePrezAndRecruitAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : OpenAlliancePrezAndRecruitAction
      {
         return new OpenAlliancePrezAndRecruitAction();
      }
   }
}
