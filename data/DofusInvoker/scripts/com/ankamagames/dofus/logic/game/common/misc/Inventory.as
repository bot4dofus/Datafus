package com.ankamagames.dofus.logic.game.common.misc
{
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.StorageOptionManager;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class Inventory
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Inventory));
       
      
      private var _itemsDict:Dictionary;
      
      private var _views:Dictionary;
      
      private var _hookLock:HookLock;
      
      private var _kamas:Number = 0;
      
      public function Inventory()
      {
         this._itemsDict = new Dictionary();
         this._hookLock = new HookLock();
         super();
         this._views = new Dictionary();
      }
      
      public function get hookLock() : HookLock
      {
         return this._hookLock;
      }
      
      public function get kamas() : Number
      {
         return this._kamas;
      }
      
      public function set kamas(value:Number) : void
      {
         this._kamas = value;
         StorageOptionManager.getInstance().updateStorageView();
      }
      
      public function addView(view:IInventoryView) : void
      {
         this._views[view.name] = view;
      }
      
      public function getView(name:String) : IInventoryView
      {
         return this._views[name];
      }
      
      public function removeView(name:String) : void
      {
         var view:IInventoryView = this.getView(name);
         if(view)
         {
            delete this._views[name];
         }
      }
      
      public function getItem(uid:int) : ItemWrapper
      {
         if(this._itemsDict[uid])
         {
            return (this._itemsDict[uid] as ItemSet).item;
         }
         return null;
      }
      
      public function getItemMaskCount(uid:int, mask:String) : int
      {
         var itemSet:ItemSet = this._itemsDict[uid];
         if(!itemSet)
         {
            _log.error("Suppression d\'un item qui n\'existe pas");
            return 0;
         }
         if(itemSet.masks.hasOwnProperty(mask))
         {
            return itemSet.masks[mask];
         }
         return 0;
      }
      
      public function initialize(items:Vector.<ItemWrapper>) : void
      {
         var item:ItemWrapper = null;
         var itemSet:ItemSet = null;
         this._itemsDict = new Dictionary();
         for each(item in items)
         {
            itemSet = new ItemSet(item);
            this._itemsDict[item.objectUID] = itemSet;
         }
         this.initializeViews(items);
      }
      
      public function initializeFromObjectItems(items:Vector.<ObjectItem>) : void
      {
         var i:int = 0;
         var iw:ItemWrapper = null;
         var item:ObjectItem = null;
         this._itemsDict = new Dictionary();
         var list:Vector.<ItemWrapper> = new Vector.<ItemWrapper>();
         var l:int = items.length;
         for(i = 0; i < l; i++)
         {
            item = items[i];
            iw = ItemWrapper.create(item.position,item.objectUID,item.objectGID,item.quantity,item.effects);
            this._itemsDict[item.objectUID] = new ItemSet(iw);
            list.push(iw);
         }
         this.initializeViews(list);
      }
      
      public function addObjectItem(item:ObjectItem) : void
      {
         var iw:ItemWrapper = ItemWrapper.create(item.position,item.objectUID,item.objectGID,item.quantity,item.effects,false);
         this.addItem(iw);
      }
      
      public function addItem(item:ItemWrapper) : void
      {
         var oldItem:ItemWrapper = null;
         var itemSet:ItemSet = this._itemsDict[item.objectUID];
         if(itemSet)
         {
            oldItem = item.clone();
            itemSet.item.quantity += item.quantity;
            itemSet.masks = new Dictionary();
            this.modifyItemFromViews(itemSet,oldItem);
         }
         else
         {
            itemSet = new ItemSet(item);
            this._itemsDict[item.objectUID] = itemSet;
            this.addItemToViews(itemSet);
         }
      }
      
      public function removeItem(itemUID:int, quantity:int = -1) : void
      {
         var oldItem:ItemWrapper = null;
         var itemSet:ItemSet = this._itemsDict[itemUID];
         if(!itemSet)
         {
            _log.error("Suppression d\'un item qui n\'existe pas");
            return;
         }
         if(quantity == -1 || quantity == itemSet.item.quantity)
         {
            delete this._itemsDict[itemUID];
            this.removeItemFromViews(itemSet);
         }
         else
         {
            if(itemSet.item.quantity < quantity)
            {
               _log.error("On essaye de supprimer de l\'inventaire plus d\'objet qu\'il n\'en existe");
               return;
            }
            oldItem = itemSet.item.clone();
            itemSet.item.quantity -= quantity;
            this.modifyItemFromViews(itemSet,oldItem);
         }
      }
      
      public function modifyItemQuantity(itemUID:int, quantity:int) : void
      {
         var itemSet:ItemSet = this._itemsDict[itemUID];
         if(!itemSet)
         {
            _log.error("On essaye de modifier la quantité d\'un objet qui n\'existe pas");
            return;
         }
         var iw:ItemWrapper = itemSet.item.clone();
         iw.quantity = quantity;
         this.modifyItem(iw);
      }
      
      public function modifyItemPosition(itemUID:int, position:int) : void
      {
         var itemSet:ItemSet = this._itemsDict[itemUID];
         if(!itemSet)
         {
            _log.error("On essaye de modifier la position d\'un objet qui n\'existe pas");
            return;
         }
         var iw:ItemWrapper = itemSet.item.clone();
         iw.position = position;
         if(iw.typeId == DataEnum.ITEM_TYPE_PETSMOUNT)
         {
            if(position == CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS)
            {
               PlayedCharacterManager.getInstance().isPetsMounting = true;
               PlayedCharacterManager.getInstance().petsMount = itemSet.item;
            }
            else
            {
               PlayedCharacterManager.getInstance().isPetsMounting = false;
               PlayedCharacterManager.getInstance().petsMount = null;
            }
         }
         else if(iw.typeId == DataEnum.ITEM_TYPE_COMPANION)
         {
            if(position == CharacterInventoryPositionEnum.INVENTORY_POSITION_ENTITY)
            {
               PlayedCharacterManager.getInstance().hasCompanion = true;
            }
            else
            {
               PlayedCharacterManager.getInstance().hasCompanion = false;
            }
         }
         this.modifyItem(iw);
      }
      
      public function modifyObjectItem(item:ObjectItem) : ItemWrapper
      {
         var iw:ItemWrapper = ItemWrapper.create(item.position,item.objectUID,item.objectGID,item.quantity,item.effects,false);
         this.modifyItem(iw);
         return iw;
      }
      
      public function modifyItem(item:ItemWrapper) : void
      {
         var oldItem:ItemWrapper = null;
         var itemSet:ItemSet = this._itemsDict[item.objectUID];
         if(itemSet)
         {
            oldItem = itemSet.item.clone();
            this.copyItem(itemSet.item,item);
            this.modifyItemFromViews(itemSet,oldItem);
         }
         else
         {
            this.addItem(item);
         }
      }
      
      public function addItemMask(objectUID:int, name:String, size:int) : void
      {
         var itemSet:ItemSet = this._itemsDict[objectUID];
         if(!itemSet)
         {
            _log.error("On essaye de masquer un item qui n\'existe pas dans l\'inventaire");
            return;
         }
         itemSet.masks[name] = size;
         this.modifyItemFromViews(itemSet,itemSet.item);
      }
      
      public function removeItemMask(objectUID:int, name:String) : void
      {
         var itemSet:ItemSet = this._itemsDict[objectUID];
         if(!itemSet)
         {
            return;
         }
         delete itemSet.masks[name];
         this.modifyItemFromViews(itemSet,itemSet.item);
      }
      
      public function removeAllItemMasks(name:String) : void
      {
         var itemSet:ItemSet = null;
         for each(itemSet in this._itemsDict)
         {
            if(itemSet.masks[name])
            {
               delete itemSet.masks[name];
               this.modifyItemFromViews(itemSet,itemSet.item);
            }
         }
      }
      
      public function releaseHooks() : void
      {
         this._hookLock.release();
      }
      
      public function refillView(from:String, to:String) : void
      {
         var fromView:IInventoryView = this.getView(from);
         var toView:IInventoryView = this.getView(to);
         if(!fromView || !toView)
         {
            return;
         }
         toView.initialize(fromView.content);
      }
      
      protected function addItemToViews(itemSet:ItemSet) : void
      {
         var view:IInventoryView = null;
         for each(view in this._views)
         {
            if(view.isListening(itemSet.item))
            {
               view.addItem(itemSet.item,0);
            }
         }
      }
      
      protected function modifyItemFromViews(itemSet:ItemSet, oldItem:ItemWrapper) : void
      {
         var mask:int = 0;
         var view:IInventoryView = null;
         var quantity:int = 0;
         for each(mask in itemSet.masks)
         {
            quantity += mask;
         }
         for each(view in this._views)
         {
            if(view.isListening(itemSet.item))
            {
               if(view.isListening(oldItem))
               {
                  view.modifyItem(itemSet.item,oldItem,quantity);
               }
               else
               {
                  view.addItem(itemSet.item,quantity);
               }
            }
            else if(view.isListening(oldItem))
            {
               view.removeItem(oldItem,quantity);
            }
         }
      }
      
      protected function removeItemFromViews(itemSet:ItemSet) : void
      {
         var view:IInventoryView = null;
         for each(view in this._views)
         {
            if(view.isListening(itemSet.item))
            {
               view.removeItem(itemSet.item,0);
            }
         }
      }
      
      protected function initializeViews(items:Vector.<ItemWrapper>) : void
      {
         var view:IInventoryView = null;
         for each(view in this._views)
         {
            view.initialize(items);
         }
      }
      
      protected function copyItem(target:ItemWrapper, source:ItemWrapper) : void
      {
         target.update(source.position,source.objectUID,source.objectGID,source.quantity,source.effectsList);
      }
   }
}

import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
import flash.utils.Dictionary;

class ItemSet
{
    
   
   public var item:ItemWrapper;
   
   private var _masks:Dictionary;
   
   function ItemSet(iw:ItemWrapper)
   {
      super();
      this.item = iw;
   }
   
   public function get masks() : Dictionary
   {
      if(!this._masks)
      {
         this._masks = new Dictionary();
      }
      return this._masks;
   }
   
   public function set masks(value:Dictionary) : void
   {
      this._masks = value;
   }
}
