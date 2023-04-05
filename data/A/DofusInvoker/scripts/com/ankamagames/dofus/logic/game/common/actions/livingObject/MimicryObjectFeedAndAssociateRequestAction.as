package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MimicryObjectFeedAndAssociateRequestAction extends AbstractAction implements Action
   {
       
      
      public var mimicryUID:uint;
      
      public var symbiotePos:uint;
      
      public var foodUID:uint;
      
      public var foodPos:uint;
      
      public var hostUID:uint;
      
      public var hostPos:uint;
      
      public var preview:Boolean;
      
      public function MimicryObjectFeedAndAssociateRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(mimicryUID:uint, symbiotePos:uint, foodUID:uint, foodPos:uint, hostUID:uint, hostPos:uint, preview:Boolean) : MimicryObjectFeedAndAssociateRequestAction
      {
         var action:MimicryObjectFeedAndAssociateRequestAction = new MimicryObjectFeedAndAssociateRequestAction(arguments);
         action.mimicryUID = mimicryUID;
         action.symbiotePos = symbiotePos;
         action.foodUID = foodUID;
         action.foodPos = foodPos;
         action.hostUID = hostUID;
         action.hostPos = hostPos;
         action.preview = preview;
         return action;
      }
   }
}
