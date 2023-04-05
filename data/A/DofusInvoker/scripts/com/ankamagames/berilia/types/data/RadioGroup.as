package com.ankamagames.berilia.types.data
{
   import com.ankamagames.berilia.interfaces.IRadioItem;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class RadioGroup implements IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RadioGroup));
       
      
      private var _items:Array;
      
      private var _selected:IRadioItem;
      
      public var name:String;
      
      public function RadioGroup(name:String)
      {
         super();
         this.name = name;
         this._items = new Array();
      }
      
      public function addItem(item:IRadioItem) : void
      {
         this._items[item.id] = item;
         if(item.selected)
         {
            this._selected = item;
         }
      }
      
      public function removeItem(item:IRadioItem) : void
      {
         delete this._items[item.id];
      }
      
      public function destroy() : void
      {
         this._items = null;
         this._selected = null;
      }
      
      public function get value() : *
      {
         if(this._selected)
         {
            return this._selected.value;
         }
         return null;
      }
      
      public function set value(v:*) : void
      {
         var item:IRadioItem = null;
         for each(item in this._items)
         {
            if(item.value == v)
            {
               this.selectedItem = item;
            }
         }
      }
      
      public function set selectedItem(item:IRadioItem) : void
      {
         var currentItem:IRadioItem = null;
         if(this._selected == item)
         {
            return;
         }
         for each(currentItem in this._items)
         {
            if(currentItem.selected != (item == currentItem))
            {
               currentItem.selected = item == currentItem;
            }
         }
         this._selected = item;
      }
      
      public function get selectedItem() : IRadioItem
      {
         return this._selected;
      }
   }
}
