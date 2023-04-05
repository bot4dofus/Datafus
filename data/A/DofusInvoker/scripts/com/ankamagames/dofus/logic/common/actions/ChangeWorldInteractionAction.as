package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChangeWorldInteractionAction extends AbstractAction implements Action
   {
       
      
      public var enabled:Boolean;
      
      public var total:Boolean;
      
      public function ChangeWorldInteractionAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(enabled:Boolean, total:Boolean = true) : ChangeWorldInteractionAction
      {
         var a:ChangeWorldInteractionAction = new ChangeWorldInteractionAction(arguments);
         a.enabled = enabled;
         a.total = total;
         return a;
      }
   }
}
