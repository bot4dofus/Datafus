package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HaapiCancelBidRequestAction extends AbstractAction implements Action
   {
       
      
      public var id:int;
      
      public var type:uint;
      
      public function HaapiCancelBidRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(id:int, type:uint) : HaapiCancelBidRequestAction
      {
         var action:HaapiCancelBidRequestAction = new HaapiCancelBidRequestAction(arguments);
         action.id = id;
         action.type = type;
         return action;
      }
   }
}
