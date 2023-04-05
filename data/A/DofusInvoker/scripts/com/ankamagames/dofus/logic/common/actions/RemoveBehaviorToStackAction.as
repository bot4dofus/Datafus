package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class RemoveBehaviorToStackAction extends AbstractAction implements Action
   {
       
      
      public var behavior:String;
      
      public function RemoveBehaviorToStackAction(params:Array = null)
      {
         super(params);
      }
      
      public function create(name:String) : RemoveBehaviorToStackAction
      {
         var s:RemoveBehaviorToStackAction = new RemoveBehaviorToStackAction(arguments);
         s.behavior = name;
         return s;
      }
   }
}
