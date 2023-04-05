package com.ankamagames.dofus.logic.game.common.actions.livingObject
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MimicryObjectEraseRequestAction extends AbstractAction implements Action
   {
       
      
      public var hostUID:uint;
      
      public var hostPos:uint;
      
      public function MimicryObjectEraseRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(hostUID:uint, hostPos:uint) : MimicryObjectEraseRequestAction
      {
         var action:MimicryObjectEraseRequestAction = new MimicryObjectEraseRequestAction(arguments);
         action.hostUID = hostUID;
         action.hostPos = hostPos;
         return action;
      }
   }
}
