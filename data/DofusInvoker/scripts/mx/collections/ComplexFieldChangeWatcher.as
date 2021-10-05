package mx.collections
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import mx.binding.utils.ChangeWatcher;
   import mx.core.mx_internal;
   import mx.events.CollectionEvent;
   import mx.events.CollectionEventKind;
   import mx.events.PropertyChangeEvent;
   
   public class ComplexFieldChangeWatcher extends EventDispatcher
   {
       
      
      private var _complexFieldWatchers:Dictionary;
      
      private var _list:IList;
      
      private var _listCollection:ICollectionView;
      
      public function ComplexFieldChangeWatcher()
      {
         this._complexFieldWatchers = new Dictionary(true);
         super();
      }
      
      public function stopWatchingForComplexFieldChanges() : void
      {
         this.unwatchListForChanges();
         this.unwatchAllItems();
      }
      
      private function unwatchAllItems() : void
      {
         var item:* = null;
         for(item in this._complexFieldWatchers)
         {
            this.unwatchItem(item);
            delete this._complexFieldWatchers[item];
         }
      }
      
      private function unwatchArrayOfItems(items:Array) : void
      {
         for(var i:int = 0; i < items.length; i++)
         {
            this.unwatchItem(items[i]);
         }
      }
      
      private function unwatchItem(item:Object) : void
      {
         var watcher:ChangeWatcher = null;
         var watchersForItem:Array = this._complexFieldWatchers[item] as Array;
         while(watchersForItem && watchersForItem.length)
         {
            watcher = watchersForItem.pop() as ChangeWatcher;
            if(watcher)
            {
               watcher.unwatch();
            }
         }
      }
      
      public function startWatchingForComplexFieldChanges() : void
      {
         this.watchListForChanges();
         this.watchAllItems();
      }
      
      private function watchAllItems() : void
      {
         this.watchItems(this.list);
      }
      
      private function watchItems(items:IList) : void
      {
         var i:int = 0;
         if(this.sortFields)
         {
            for(i = 0; i < items.length; i++)
            {
               this.watchItem(items.getItemAt(i),this.sortFields);
            }
         }
      }
      
      private function watchArrayOfItems(items:Array) : void
      {
         var i:int = 0;
         if(this.sortFields)
         {
            for(i = 0; i < items.length; i++)
            {
               this.watchItem(items[i],this.sortFields);
            }
         }
      }
      
      private function watchItem(item:Object, fieldsToWatch:Array) : void
      {
         var i:int = 0;
         var sortField:IComplexSortField = null;
         if(item)
         {
            for(i = 0; i < fieldsToWatch.length; i++)
            {
               sortField = fieldsToWatch[i] as IComplexSortField;
               if(sortField && sortField.nameParts)
               {
                  this.watchItemForField(item,sortField.nameParts);
               }
            }
         }
      }
      
      private function watchItemForField(item:Object, chain:Array) : void
      {
         var watcher:ChangeWatcher = ChangeWatcher.watch(item,chain,new Closure(item,this.onComplexValueChanged).callFunctionOnObject,false,true);
         if(watcher)
         {
            this.addWatcher(watcher,item);
         }
      }
      
      private function addWatcher(watcher:ChangeWatcher, forItem:Object) : void
      {
         if(!this._complexFieldWatchers[forItem])
         {
            this._complexFieldWatchers[forItem] = [];
         }
         (this._complexFieldWatchers[forItem] as Array).push(watcher);
      }
      
      private function onComplexValueChanged(item:Object) : void
      {
         dispatchEvent(PropertyChangeEvent.createUpdateEvent(item,null,null,null));
      }
      
      private function get sortFields() : Array
      {
         return this._listCollection && this._listCollection.sort ? this._listCollection.sort.fields : null;
      }
      
      mx_internal function set list(value:IList) : void
      {
         if(this._list != value)
         {
            this.stopWatchingForComplexFieldChanges();
            this._list = value;
            this._listCollection = value as ICollectionView;
         }
      }
      
      protected function get list() : IList
      {
         return this._list;
      }
      
      private function watchListForChanges() : void
      {
         if(this.list)
         {
            this.list.addEventListener(CollectionEvent.COLLECTION_CHANGE,this.onCollectionChanged,false,0,true);
         }
      }
      
      private function unwatchListForChanges() : void
      {
         if(this.list)
         {
            this.list.removeEventListener(CollectionEvent.COLLECTION_CHANGE,this.onCollectionChanged);
         }
      }
      
      private function onCollectionChanged(event:CollectionEvent) : void
      {
         switch(event.kind)
         {
            case CollectionEventKind.ADD:
               this.watchArrayOfItems(event.items);
               break;
            case CollectionEventKind.REMOVE:
               this.unwatchArrayOfItems(event.items);
               break;
            case CollectionEventKind.REFRESH:
            case CollectionEventKind.RESET:
               this.reset();
         }
      }
      
      private function reset() : void
      {
         this.unwatchAllItems();
         this.watchAllItems();
      }
   }
}

import flash.events.Event;

class Closure
{
    
   
   private var _object:Object;
   
   private var _function:Function;
   
   function Closure(cachedObject:Object, cachedFunction:Function)
   {
      super();
      this._object = cachedObject;
      this._function = cachedFunction;
   }
   
   public function callFunctionOnObject(event:Event) : void
   {
      this._function.apply(null,[this._object]);
   }
}
