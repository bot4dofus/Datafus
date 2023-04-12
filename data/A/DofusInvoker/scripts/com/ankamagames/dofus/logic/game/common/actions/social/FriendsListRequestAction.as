package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class FriendsListRequestAction extends AbstractAction implements Action
   {
       
      
      public function FriendsListRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : FriendsListRequestAction
      {
         return new FriendsListRequestAction(arguments);
      }
   }
}
