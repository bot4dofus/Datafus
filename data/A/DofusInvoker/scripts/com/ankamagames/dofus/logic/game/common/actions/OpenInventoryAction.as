package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class OpenInventoryAction extends AbstractAction implements Action
   {
       
      
      public var behavior:String;
      
      public var uiName:String = "storage";
      
      public function OpenInventoryAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(behavior:String = "bag", uiName:String = "storage") : OpenInventoryAction
      {
         var a:OpenInventoryAction = new OpenInventoryAction(arguments);
         a.behavior = behavior;
         a.uiName = uiName;
         return a;
      }
   }
}
