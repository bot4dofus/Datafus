package com.ankamagames.dofus.logic.game.roleplay.actions.estate
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PaddockToSellFilterAction extends AbstractAction implements Action
   {
       
      
      public var areaId:int;
      
      public var atLeastNbMount:uint;
      
      public var atLeastNbMachine:uint;
      
      public var maxPrice:Number = 0;
      
      public var orderBy:uint = 0;
      
      public function PaddockToSellFilterAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(areaId:int, atLeastNbMount:uint, atLeastNbMachine:uint, maxPrice:Number, orderBy:uint) : PaddockToSellFilterAction
      {
         var a:PaddockToSellFilterAction = new PaddockToSellFilterAction(arguments);
         a.areaId = areaId;
         a.atLeastNbMount = atLeastNbMount;
         a.atLeastNbMachine = atLeastNbMachine;
         a.maxPrice = maxPrice;
         a.orderBy = orderBy;
         return a;
      }
   }
}
