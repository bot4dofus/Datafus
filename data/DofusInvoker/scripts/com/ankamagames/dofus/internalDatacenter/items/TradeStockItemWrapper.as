package com.ankamagames.dofus.internalDatacenter.items
{
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class TradeStockItemWrapper implements IDataCenter
   {
       
      
      public var itemWrapper:ItemWrapper;
      
      public var price:Number = 0;
      
      public var category:int;
      
      public var criterion:GroupItemCriterion;
      
      public function TradeStockItemWrapper()
      {
         super();
      }
      
      public static function create(itemWrapper:ItemWrapper, price:Number, criterion:GroupItemCriterion = null) : TradeStockItemWrapper
      {
         var obj:TradeStockItemWrapper = new TradeStockItemWrapper();
         var cat:uint = Item.getItemById(itemWrapper.objectGID).category;
         obj.itemWrapper = itemWrapper;
         obj.price = price;
         obj.category = cat;
         obj.criterion = criterion;
         return obj;
      }
   }
}
