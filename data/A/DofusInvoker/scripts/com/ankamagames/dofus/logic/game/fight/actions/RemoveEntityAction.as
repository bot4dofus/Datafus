package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class RemoveEntityAction extends AbstractAction implements Action
   {
       
      
      public var actorId:Number;
      
      public function RemoveEntityAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(actorId:Number) : RemoveEntityAction
      {
         var o:RemoveEntityAction = new RemoveEntityAction(arguments);
         o.actorId = actorId;
         return o;
      }
   }
}
