package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenBookAction extends AbstractAction implements Action
   {
       
      
      public var value:String;
      
      public var param:Object;
      
      public function OpenBookAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(name:String = null, param:Object = null) : OpenBookAction
      {
         var action:OpenBookAction = new OpenBookAction(arguments);
         action.value = name;
         action.param = param;
         return action;
      }
   }
}
