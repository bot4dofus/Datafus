package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class WrapperObjectDissociateRequestAction extends AbstractAction implements Action
   {
       
      
      public var hostUID:uint;
      
      public var hostPosition:uint;
      
      public function WrapperObjectDissociateRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(hostUID:uint, hostPosition:uint) : WrapperObjectDissociateRequestAction
      {
         var action:WrapperObjectDissociateRequestAction = new WrapperObjectDissociateRequestAction(arguments);
         action.hostUID = hostUID;
         action.hostPosition = hostPosition;
         return action;
      }
   }
}
