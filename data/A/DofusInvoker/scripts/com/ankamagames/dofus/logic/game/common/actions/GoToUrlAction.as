package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GoToUrlAction extends AbstractAction implements Action
   {
       
      
      public var url:String;
      
      public function GoToUrlAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pUrl:String) : GoToUrlAction
      {
         var action:GoToUrlAction = new GoToUrlAction(arguments);
         action.url = pUrl;
         return action;
      }
   }
}
