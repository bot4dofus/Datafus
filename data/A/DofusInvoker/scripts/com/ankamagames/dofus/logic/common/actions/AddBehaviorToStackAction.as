package com.ankamagames.dofus.logic.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AddBehaviorToStackAction extends AbstractAction implements Action
   {
       
      
      public var behavior:Array;
      
      public function AddBehaviorToStackAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(data:Array) : AddBehaviorToStackAction
      {
         var s:AddBehaviorToStackAction = new AddBehaviorToStackAction(arguments);
         s.behavior = data;
         return s;
      }
   }
}
