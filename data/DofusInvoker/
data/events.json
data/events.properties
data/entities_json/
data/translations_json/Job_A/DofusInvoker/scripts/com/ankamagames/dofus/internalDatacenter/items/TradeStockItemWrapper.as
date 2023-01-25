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
      
      public static function createFromObjectItemToSell(object:Object, criterion:GroupItemCriterion = null) : TradeStockItemWrapper
      {
         var obj:TradeStockItemWrapper = new TradeStockItemWrapper();
         var iw:ItemWrapper = ItemWrapper.create(0,object.objectUID,object.objectGID,object.quantity,object.effects,false);
         var cat:uint = Item.getItemById(object.objectGID).category;
         obj.itemWrapper = iw;
         obj.price = object.objectPrice;
         obj.category = cat;
         obj.criterion = criterion;
         return obj;
      }
   }
}
