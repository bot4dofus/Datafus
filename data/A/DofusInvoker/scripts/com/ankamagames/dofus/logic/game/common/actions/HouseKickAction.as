package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseKickAction extends AbstractAction implements Action
   {
       
      
      public var id:Number;
      
      public function HouseKickAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(id:Number) : HouseKickAction
      {
         var action:HouseKickAction = new HouseKickAction(arguments);
         action.id = id;
         return action;
      }
   }
}
