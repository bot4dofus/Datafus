package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShowAllNamesAction extends AbstractAction implements Action
   {
       
      
      public function ShowAllNamesAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ShowAllNamesAction
      {
         return new ShowAllNamesAction(arguments);
      }
   }
}
