package com.ankamagames.dofus.logic.game.roleplay.actions.estate
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseToSellFilterAction extends AbstractAction implements Action
   {
       
      
      public var areaId:int;
      
      public var atLeastNbRoom:uint;
      
      public var atLeastNbChest:uint;
      
      public var skillRequested:uint;
      
      public var maxPrice:Number = 0;
      
      public var orderBy:uint = 0;
      
      public function HouseToSellFilterAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(areaId:int, atLeastNbRoom:uint, atLeastNbChest:uint, skillRequested:uint, maxPrice:Number, orderBy:uint) : HouseToSellFilterAction
      {
         var a:HouseToSellFilterAction = new HouseToSellFilterAction(arguments);
         a.areaId = areaId;
         a.atLeastNbRoom = atLeastNbRoom;
         a.atLeastNbChest = atLeastNbChest;
         a.skillRequested = skillRequested;
         a.maxPrice = maxPrice;
         a.orderBy = orderBy;
         return a;
      }
   }
}
