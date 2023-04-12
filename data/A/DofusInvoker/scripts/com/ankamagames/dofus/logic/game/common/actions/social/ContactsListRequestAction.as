package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ContactsListRequestAction extends AbstractAction implements Action
   {
       
      
      public function ContactsListRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ContactsListRequestAction
      {
         return new ContactsListRequestAction(arguments);
      }
   }
}
