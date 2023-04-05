package com.ankamagames.dofus.logic.game.common.actions.tinsel
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class TitleSelectRequestAction extends AbstractAction implements Action
   {
       
      
      public var titleId:int;
      
      public function TitleSelectRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(titleId:int) : TitleSelectRequestAction
      {
         var action:TitleSelectRequestAction = new TitleSelectRequestAction(arguments);
         action.titleId = titleId;
         return action;
      }
   }
}
