package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CloseInventoryAction extends AbstractAction implements Action
   {
       
      
      public var uiName:String = "storage";
      
      public function CloseInventoryAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(uiName:String = "storage") : CloseInventoryAction
      {
         var a:CloseInventoryAction = new CloseInventoryAction(arguments);
         a.uiName = uiName;
         return a;
      }
   }
}
