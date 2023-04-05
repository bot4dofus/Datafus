package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseSellAction extends AbstractAction implements Action
   {
       
      
      public var instanceId:int = 0;
      
      public var amount:Number = 0;
      
      public var forSale:Boolean;
      
      public function HouseSellAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(instanceId:int, amount:Number, forSale:Boolean = true) : HouseSellAction
      {
         var action:HouseSellAction = new HouseSellAction(arguments);
         action.instanceId = instanceId;
         action.amount = amount;
         action.forSale = forSale;
         return action;
      }
   }
}
