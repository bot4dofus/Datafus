package com.ankamagames.berilia.components
{
   public class MultipleComboBoxGrid extends ComboBoxGrid
   {
       
      
      private var _selectedIndices:Vector.<int>;
      
      private var _selectedValues:Array;
      
      public function MultipleComboBoxGrid()
      {
         this._selectedIndices = new Vector.<int>(0);
         this._selectedValues = [];
         super();
      }
      
      public function get selectedValues() : Array
      {
         return this._selectedValues;
      }
      
      public function set selectedValues(values:Array) : void
      {
         var value:Object = null;
         var index:uint = 0;
         var data:* = undefined;
         if(_dataProvider === null)
         {
            return;
         }
         this._selectedValues = [];
         this._selectedIndices = new Vector.<int>(0);
         for each(value in values)
         {
            for(index = 0; index < _dataProvider.length; index++)
            {
               data = _dataProvider[index];
               if(data.typeId === value.typeId)
               {
                  this._selectedIndices.push(index);
                  this._selectedValues.push(value);
               }
            }
         }
      }
      
      public function get selectedIndices() : Vector.<int>
      {
         return this._selectedIndices;
      }
      
      public function set selectedIndices(indices:Vector.<int>) : void
      {
         var index:int = 0;
         if(_dataProvider === null)
         {
            return;
         }
         this._selectedIndices = new Vector.<int>(0);
         this._selectedValues = [];
         var maxLen:Number = _dataProvider.length;
         for each(index in indices)
         {
            if(index >= 0 && index < maxLen)
            {
               this._selectedIndices.push(index);
               this._selectedValues.push(_dataProvider[index]);
            }
         }
      }
      
      override public function set selectedIndex(i:int) : void
      {
         super.selectedIndex = i;
         this.handleItem(selectedItem);
      }
      
      override public function set selectedItem(o:*) : void
      {
         super.selectedItem = o;
         this.handleItem(o);
      }
      
      override public function setSelectedIndex(index:int, method:uint) : void
      {
         if(_dataProvider !== null && index >= 0 && index < _dataProvider.length)
         {
            this.handleItem(_dataProvider[index]);
         }
         super.setSelectedIndex(index,method);
      }
      
      protected function handleItem(item:Object) : void
      {
         if(this.hasValue(item))
         {
            this.removeValue(item);
         }
         else
         {
            this.addValue(item);
         }
      }
      
      public function addValue(value:Object) : void
      {
         if(this.hasValue(value))
         {
            return;
         }
         this._selectedValues.push(value);
      }
      
      public function removeValue(value:Object) : void
      {
         var index:int = this.getValueIndex(value);
         if(index === -1)
         {
            return;
         }
         this._selectedValues.removeAt(index);
      }
      
      public function getValueIndex(value:Object) : int
      {
         var item:Object = null;
         var index:uint = 0;
         for each(item in this._selectedValues)
         {
            if(item.typeId === value.typeId)
            {
               return index;
            }
            index++;
         }
         return -1;
      }
      
      public function hasValue(value:Object) : Boolean
      {
         return this.getValueIndex(value) !== -1;
      }
   }
}
