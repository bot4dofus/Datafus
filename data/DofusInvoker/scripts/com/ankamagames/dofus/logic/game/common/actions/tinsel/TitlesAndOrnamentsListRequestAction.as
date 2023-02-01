package com.ankamagames.dofus.logic.game.common.actions.tinsel
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TitlesAndOrnamentsListRequestAction extends AbstractAction implements Action
   {
       
      
      public function TitlesAndOrnamentsListRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : TitlesAndOrnamentsListRequestAction
      {
         return new TitlesAndOrnamentsListRequestAction(arguments);
      }
   }
}
