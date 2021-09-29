package com.ankamagames.dofus.logic.game.common.misc.inventoryView
{
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.AveragePricesFrame;
   import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
   import com.ankamagames.dofus.logic.game.common.misc.HookLock;
   import com.ankamagames.dofus.logic.game.common.misc.IStorageView;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class StorageGenericView implements IStorageView
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(StorageGenericView));
       
      
      protected var _content:Vector.<ItemWrapper>;
      
      protected var _sortedContent:Vector.<ItemWrapper>;
      
      protected var _hookLock:HookLock;
      
      protected var _sorted:Boolean = false;
      
      private var _sortFieldsCache:Array;
      
      private var _sortRevertCache:Boolean;
      
      protected var _typesQty:Dictionary;
      
      protected var _types:Dictionary;
      
      public function StorageGenericView(hookLock:HookLock)
      {
         this._typesQty = new Dictionary();
         this._types = new Dictionary();
         super();
         this._hookLock = hookLock;
      }
      
      public function initialize(items:Vector.<ItemWrapper>) : void
      {
         var item:ItemWrapper = null;
         if(!this._content)
         {
            this._content = new Vector.<ItemWrapper>();
         }
         else
         {
            this._content.length = 0;
         }
         this._typesQty = new Dictionary();
         this._types = new Dictionary();
         this._sortedContent = null;
         for each(item in items)
         {
            if(this.isListening(item))
            {
               this.addItem(item,0,false);
            }
         }
         this._content.sort(this.sortItemsByIndex);
         this.updateView();
      }
      
      public function get name() : String
      {
         throw new Error("StorageGenericView class must be extended");
      }
      
      public function get content() : Vector.<ItemWrapper>
      {
         if(this._sorted)
         {
            return this._sortedContent;
         }
         return this._content;
      }
      
      public function get types() : Dictionary
      {
         return this._types;
      }
      
      public function addItem(item:ItemWrapper, invisible:int, needUpdateView:Boolean = true) : void
      {
         var clone:ItemWrapper = item.clone();
         clone.quantity -= invisible;
         this._content.unshift(clone);
         if(this._sortedContent)
         {
            this._sortedContent.unshift(clone);
         }
         if(this._typesQty[item.typeId] && this._typesQty[item.typeId] > 0)
         {
            ++this._typesQty[item.typeId];
         }
         else
         {
            this._typesQty[item.typeId] = 1;
            this._types[item.typeId] = item.type;
         }
         if(needUpdateView)
         {
            this.updateView();
         }
      }
      
      public function removeItem(item:ItemWrapper, invisible:int) : void
      {
         var idx:int = this.getItemIndex(item);
         if(idx == -1)
         {
            return;
         }
         if(this._typesQty[item.typeId] && this._typesQty[item.typeId] > 0)
         {
            --this._typesQty[item.typeId];
            if(this._typesQty[item.typeId] == 0)
            {
               delete this._types[item.typeId];
            }
         }
         this._content.splice(idx,1);
         if(this._sortedContent)
         {
            idx = this.getItemIndex(item,this._sortedContent);
            if(idx != -1)
            {
               this._sortedContent.splice(idx,1);
            }
         }
         this.updateView();
      }
      
      public function modifyItem(item:ItemWrapper, oldItem:ItemWrapper, invisible:int) : void
      {
         var iw:ItemWrapper = null;
         var idx:int = this.getItemIndex(item);
         if(idx != -1)
         {
            iw = this._content[idx];
            if(iw.quantity == item.quantity - invisible)
            {
               iw.update(item.position,item.objectUID,item.objectGID,iw.quantity,item.effectsList);
               this.updateView();
            }
            else if(item.quantity <= invisible)
            {
               this.removeItem(iw,invisible);
            }
            else
            {
               iw.update(item.position,item.objectUID,item.objectGID,item.quantity - invisible,item.effectsList);
               this.updateView();
            }
         }
         else if(invisible < item.quantity)
         {
            this.addItem(item,invisible);
         }
      }
      
      public function isListening(item:ItemWrapper) : Boolean
      {
         return item.position == 63 && Item.getItemById(item.objectGID).typeId != DataEnum.ITEM_TYPE_HIDDEN;
      }
      
      public function getItemTypes() : Dictionary
      {
         return this._types;
      }
      
      protected function getItemIndex(item:ItemWrapper, list:Vector.<ItemWrapper> = null) : int
      {
         var iw:ItemWrapper = null;
         if(list == null)
         {
            list = this._content;
         }
         for(var i:int = 0; i < list.length; i++)
         {
            iw = list[i];
            if(iw.objectUID == item.objectUID)
            {
               return i;
            }
         }
         return -1;
      }
      
      private function sortItemsByIndex(a:ItemWrapper, b:ItemWrapper) : int
      {
         if(a.sortOrder > b.sortOrder)
         {
            return -1;
         }
         if(a.sortOrder == b.sortOrder)
         {
            return 0;
         }
         return 1;
      }
      
      private function compareFunction(a:ItemWrapper, b:ItemWrapper, sortDepth:uint = 0) : int
      {
         var returnValue:int = 0;
         switch(this._sortFieldsCache[sortDepth])
         {
            case StorageOptionManager.SORT_FIELD_NAME:
               if(!this._sortRevertCache)
               {
                  returnValue = a.nameWithoutAccent > b.nameWithoutAccent ? 1 : (a.nameWithoutAccent < b.nameWithoutAccent ? -1 : 0);
               }
               else
               {
                  returnValue = a.nameWithoutAccent < b.nameWithoutAccent ? 1 : (a.nameWithoutAccent > b.nameWithoutAccent ? -1 : 0);
               }
               break;
            case StorageOptionManager.SORT_FIELD_WEIGHT:
               if(!this._sortRevertCache)
               {
                  returnValue = a.weight < b.weight ? 1 : (a.weight > b.weight ? -1 : 0);
               }
               else
               {
                  returnValue = a.weight > b.weight ? 1 : (a.weight < b.weight ? -1 : 0);
               }
               break;
            case StorageOptionManager.SORT_FIELD_LOT_WEIGHT:
               if(!this._sortRevertCache)
               {
                  returnValue = a.weight * a.quantity < b.weight * b.quantity ? 1 : (a.weight * a.quantity > b.weight * b.quantity ? -1 : 0);
               }
               else
               {
                  returnValue = a.weight * a.quantity > b.weight * b.quantity ? 1 : (a.weight * a.quantity < b.weight * b.quantity ? -1 : 0);
               }
               break;
            case StorageOptionManager.SORT_FIELD_QUANTITY:
               if(!this._sortRevertCache)
               {
                  returnValue = a.quantity < b.quantity ? 1 : (a.quantity > b.quantity ? -1 : 0);
               }
               else
               {
                  returnValue = a.quantity > b.quantity ? 1 : (a.quantity < b.quantity ? -1 : 0);
               }
               break;
            case StorageOptionManager.SORT_FIELD_DEFAULT:
               if(!this._sortRevertCache)
               {
                  returnValue = a.objectUID < b.objectUID ? 1 : (a.objectUID > b.objectUID ? -1 : 0);
               }
               else
               {
                  returnValue = a.objectUID > b.objectUID ? 1 : (a.objectUID < b.objectUID ? -1 : 0);
               }
               break;
            case StorageOptionManager.SORT_FIELD_AVERAGEPRICE:
               if(!this._sortRevertCache)
               {
                  returnValue = this.getItemAveragePrice(a.objectGID) < this.getItemAveragePrice(b.objectGID) ? 1 : (this.getItemAveragePrice(a.objectGID) > this.getItemAveragePrice(b.objectGID) ? -1 : 0);
               }
               else
               {
                  returnValue = this.getItemAveragePrice(a.objectGID) > this.getItemAveragePrice(b.objectGID) ? 1 : (this.getItemAveragePrice(a.objectGID) < this.getItemAveragePrice(b.objectGID) ? -1 : 0);
               }
               break;
            case StorageOptionManager.SORT_FIELD_LOT_AVERAGEPRICE:
               if(!this._sortRevertCache)
               {
                  returnValue = this.getItemAveragePrice(a.objectGID) * a.quantity < this.getItemAveragePrice(b.objectGID) * b.quantity ? 1 : (this.getItemAveragePrice(a.objectGID) * a.quantity > this.getItemAveragePrice(b.objectGID) * b.quantity ? -1 : 0);
               }
               else
               {
                  returnValue = this.getItemAveragePrice(a.objectGID) * a.quantity > this.getItemAveragePrice(b.objectGID) * b.quantity ? 1 : (this.getItemAveragePrice(a.objectGID) * a.quantity < this.getItemAveragePrice(b.objectGID) * b.quantity ? -1 : 0);
               }
               break;
            case StorageOptionManager.SORT_FIELD_LEVEL:
               if(!this._sortRevertCache)
               {
                  returnValue = a.level < b.level ? 1 : (a.level > b.level ? -1 : 0);
               }
               else
               {
                  returnValue = a.level > b.level ? 1 : (a.level < b.level ? -1 : 0);
               }
               break;
            case StorageOptionManager.SORT_FIELD_ITEM_TYPE:
               if(!this._sortRevertCache)
               {
                  returnValue = a.type.name > b.type.name ? 1 : (a.type.name < b.type.name ? -1 : 0);
               }
               else
               {
                  returnValue = a.type.name < b.type.name ? 1 : (a.type.name > b.type.name ? -1 : 0);
               }
               break;
            default:
               returnValue = 0;
         }
         if(returnValue != 0)
         {
            return returnValue;
         }
         if(sortDepth == this._sortFieldsCache.length - 1)
         {
            return 0;
         }
         return this.compareFunction(a,b,++sortDepth);
      }
      
      private function getItemAveragePrice(pItemGID:uint) : Number
      {
         var avgPricesFrame:AveragePricesFrame = Kernel.getWorker().getFrame(AveragePricesFrame) as AveragePricesFrame;
         return !isNaN(avgPricesFrame.pricesData.items[pItemGID]) ? Number(avgPricesFrame.pricesData.items[pItemGID]) : Number(0);
      }
      
      public function updateView() : void
      {
         var i:int = 0;
         var len:int = 0;
         var iw:ItemWrapper = null;
         var sameSort:Boolean = true;
         if(this._sortFieldsCache && this._sortFieldsCache.length == this.sortFields().length)
         {
            len = this._sortFieldsCache.length;
            for(i = 0; i < len; i++)
            {
               if(this._sortFieldsCache[i] != this.sortFields()[i])
               {
                  sameSort = false;
                  break;
               }
            }
         }
         else
         {
            sameSort = false;
         }
         this._sortFieldsCache = this.sortFields();
         if(this._sortFieldsCache[0] != StorageOptionManager.SORT_FIELD_NONE)
         {
            if(!sameSort)
            {
               this._sortRevertCache = this.sortRevert();
            }
            else if(StorageOptionManager.getInstance().newSort)
            {
               this._sortRevertCache = !this._sortRevertCache;
            }
            if(!this._sortedContent)
            {
               this._sortedContent = new Vector.<ItemWrapper>();
               for each(iw in this._content)
               {
                  this._sortedContent.push(iw);
               }
            }
            this._sortedContent.sort(this.compareFunction);
            this._sorted = true;
         }
         else
         {
            this._sorted = false;
         }
      }
      
      public function sortFields() : Array
      {
         return StorageOptionManager.getInstance().sortFields;
      }
      
      public function sortRevert() : Boolean
      {
         return StorageOptionManager.getInstance().sortRevert;
      }
      
      public function empty() : void
      {
         this._content = new Vector.<ItemWrapper>();
         this._sortedContent = null;
         this.updateView();
      }
   }
}
