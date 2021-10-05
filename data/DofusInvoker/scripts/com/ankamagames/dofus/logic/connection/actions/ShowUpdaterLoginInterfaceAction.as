package com.ankamagames.dofus.logic.connection.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShowUpdaterLoginInterfaceAction extends AbstractAction implements Action
   {
       
      
      public function ShowUpdaterLoginInterfaceAction(params:Array = null)
      {
         super(params);
      }
      
      public function create() : Action
      {
         return new ShowUpdaterLoginInterfaceAction(arguments);
      }
   }
}
