package com.ankamagames.dofus.logic.game.common.actions.prism
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PrismsListRegisterAction extends AbstractAction implements Action
   {
       
      
      public var uiName:String;
      
      public var listen:uint;
      
      public function PrismsListRegisterAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(uiName:String, listen:uint) : PrismsListRegisterAction
      {
         var action:PrismsListRegisterAction = new PrismsListRegisterAction(arguments);
         action.uiName = uiName;
         action.listen = listen;
         return action;
      }
   }
}
