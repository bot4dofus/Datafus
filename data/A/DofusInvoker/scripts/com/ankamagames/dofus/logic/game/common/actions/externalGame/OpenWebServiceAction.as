package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenWebServiceAction extends AbstractAction implements Action
   {
       
      
      public var uiName:String;
      
      public var uiParams:Object;
      
      public function OpenWebServiceAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(uiName:String = "", uiParams:Object = null) : OpenWebServiceAction
      {
         var action:OpenWebServiceAction = new OpenWebServiceAction(arguments);
         action.uiName = uiName;
         action.uiParams = uiParams;
         return action;
      }
   }
}
