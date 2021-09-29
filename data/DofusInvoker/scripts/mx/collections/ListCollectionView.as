package mx.collections
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   import flash.utils.getQualifiedClassName;
   import mx.collections.errors.CollectionViewError;
   import mx.collections.errors.ItemPendingError;
   import mx.collections.errors.SortError;
   import mx.core.IMXMLObject;
   import mx.core.mx_internal;
   import mx.events.CollectionEvent;
   import mx.events.CollectionEventKind;
   import mx.events.PropertyChangeEvent;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   import mx.utils.ObjectUtil;
   
   use namespace mx_internal;
   
   [Event(name="collectionChange",type="mx.events.CollectionEvent")]
   public class ListCollectionView extends Proxy implements ICollectionView, IList, IMXMLObject
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
       
      
      private var _complexFieldWatcher:ComplexFieldChangeWatcher;
      
      private var eventDispatcher:EventDispatcher;
      
      private var revision:int;
      
      private var autoUpdateCounter:int;
      
      private var pendingUpdates:Array;
      
      mx_internal var dispatchResetEvent:Boolean = true;
      
      private var resourceManager:IResourceManager;
      
      protected var localIndex:Array;
      
      private var _list:IList;
      
      private var _filterFunction:Function;
      
      private var _sort:ISort;
      
      public function ListCollectionView(list:IList = null)
      {
         this.resourceManager = ResourceManager.getInstance();
         super();
         this.eventDispatcher = new EventDispatcher(this);
         this.list = list;
      }
      
      public function initialized(document:Object, id:String) : void
      {
         this.refresh();
      }
      
      [Bindable("collectionChange")]
      public function get length() : int
      {
         if(this.localIndex)
         {
            return this.localIndex.length;
         }
         if(this.list)
         {
            return this.list.length;
         }
         return 0;
      }
      
      [Bindable("listChanged")]
      [Inspectable(category="General")]
      public function get list() : IList
      {
         return this._list;
      }
      
      public function set list(value:IList) : void
      {
         var oldHasItems:* = false;
         var newHasItems:* = false;
         if(this._list != value)
         {
            if(this._list)
            {
               this._list.removeEventListener(CollectionEvent.COLLECTION_CHANGE,this.listChangeHandler);
               oldHasItems = this._list.length > 0;
            }
            this._list = value;
            if(this._list)
            {
               this._list.addEventListener(CollectionEvent.COLLECTION_CHANGE,this.listChangeHandler,false,0,true);
               newHasItems = this._list.length > 0;
            }
            if(oldHasItems || newHasItems)
            {
               this.reset();
            }
            this.dispatchEvent(new Event("listChanged"));
         }
      }
      
      [Inspectable(category="General")]
      [Bindable("filterFunctionChanged")]
      public function get filterFunction() : Function
      {
         return this._filterFunction;
      }
      
      public function set filterFunction(f:Function) : void
      {
         this._filterFunction = f;
         this.dispatchEvent(new Event("filterFunctionChanged"));
      }
      
      [Inspectable(category="General")]
      [Bindable("sortChanged")]
      public function get sort() : ISort
      {
         return this._sort;
      }
      
      public function set sort(value:ISort) : void
      {
         if(this._sort != value)
         {
            this.stopWatchingForComplexFieldsChanges();
            this._sort = value;
            this.startWatchingForComplexFieldsChanges();
            this.dispatchEvent(new Event("sortChanged"));
         }
      }
      
      public function contains(item:Object) : Boolean
      {
         return this.getItemIndex(item) != -1;
      }
      
      public function disableAutoUpdate() : void
      {
         ++this.autoUpdateCounter;
      }
      
      public function enableAutoUpdate() : void
      {
         if(this.autoUpdateCounter > 0)
         {
            --this.autoUpdateCounter;
            if(this.autoUpdateCounter == 0)
            {
               this.handlePendingUpdates();
            }
         }
      }
      
      public function createCursor() : IViewCursor
      {
         return new ListCollectionViewCursor(this);
      }
      
      public function itemUpdated(item:Object, property:Object = null, oldValue:Object = null, newValue:Object = null) : void
      {
         this.list.itemUpdated(item,property,oldValue,newValue);
      }
      
      public function refresh() : Boolean
      {
         return this.internalRefresh(true);
      }
      
      [Bindable("collectionChange")]
      public function getItemAt(index:int, prefetch:int = 0) : Object
      {
         var message:String = null;
         if(index < 0 || index >= this.length)
         {
            message = this.resourceManager.getString("collections","outOfBounds",[index]);
            throw new RangeError(message);
         }
         if(this.localIndex)
         {
            return this.localIndex[index];
         }
         if(this.list)
         {
            return this.list.getItemAt(index,prefetch);
         }
         return null;
      }
      
      public function setItemAt(item:Object, index:int) : Object
      {
         var message:String = null;
         var oldItem:Object = null;
         if(index < 0 || !this.list || index >= this.length)
         {
            message = this.resourceManager.getString("collections","outOfBounds",[index]);
            throw new RangeError(message);
         }
         var listIndex:int = index;
         if(this.localIndex)
         {
            if(index > this.localIndex.length)
            {
               listIndex = this.list.length;
            }
            else
            {
               oldItem = this.localIndex[index];
               listIndex = this.list.getItemIndex(oldItem);
            }
         }
         return this.list.setItemAt(item,listIndex);
      }
      
      public function addItem(item:Object) : void
      {
         if(this.localIndex)
         {
            this.addItemAt(item,this.localIndex.length);
         }
         else
         {
            this.addItemAt(item,this.length);
         }
      }
      
      public function addItemAt(item:Object, index:int) : void
      {
         var message:String = null;
         if(index < 0 || !this.list || index > this.length)
         {
            message = this.resourceManager.getString("collections","outOfBounds",[index]);
            throw new RangeError(message);
         }
         var listIndex:int = index;
         if(this.localIndex && this.sort)
         {
            listIndex = this.list.length;
         }
         else if(this.localIndex && this.filterFunction != null)
         {
            if(listIndex == this.localIndex.length)
            {
               listIndex = this.list.length;
            }
            else
            {
               listIndex = this.list.getItemIndex(this.localIndex[index]);
            }
         }
         else if(this.localIndex)
         {
            listIndex = this.list.length;
         }
         this.list.addItemAt(item,listIndex);
      }
      
      public function addAll(addList:IList) : void
      {
         if(this.localIndex)
         {
            this.addAllAt(addList,this.localIndex.length);
         }
         else
         {
            this.addAllAt(addList,this.length);
         }
      }
      
      public function addAllAt(addList:IList, index:int) : void
      {
         var message:String = null;
         var insertIndex:int = 0;
         if(index < 0 || index > this.length)
         {
            message = this.resourceManager.getString("collections","outOfBounds",[index]);
            throw new RangeError(message);
         }
         var length:int = addList.length;
         for(var i:int = 0; i < length; i++)
         {
            insertIndex = i + index;
            if(insertIndex > this.length)
            {
               insertIndex = this.length;
            }
            this.addItemAt(addList.getItemAt(i),insertIndex);
         }
      }
      
      public function getItemIndex(item:Object) : int
      {
         var i:int = 0;
         var len:int = 0;
         var startIndex:int = 0;
         var endIndex:int = 0;
         if(this.localIndex && this.filterFunction != null)
         {
            len = this.localIndex.length;
            for(i = 0; i < len; i++)
            {
               if(this.localIndex[i] == item)
               {
                  return i;
               }
            }
            return -1;
         }
         if(this.localIndex && this.sort)
         {
            startIndex = this.findItem(item,Sort.FIRST_INDEX_MODE);
            if(startIndex == -1)
            {
               return -1;
            }
            endIndex = this.findItem(item,Sort.LAST_INDEX_MODE);
            for(i = startIndex; i <= endIndex; i++)
            {
               if(this.localIndex[i] == item)
               {
                  return i;
               }
            }
            return -1;
         }
         if(this.localIndex)
         {
            len = this.localIndex.length;
            for(i = 0; i < len; i++)
            {
               if(this.localIndex[i] == item)
               {
                  return i;
               }
            }
            return -1;
         }
         return this.list.getItemIndex(item);
      }
      
      mx_internal function getLocalItemIndex(item:Object) : int
      {
         var i:int = 0;
         var len:int = this.localIndex.length;
         for(i = 0; i < len; i++)
         {
            if(this.localIndex[i] == item)
            {
               return i;
            }
         }
         return -1;
      }
      
      private function getFilteredItemIndex(item:Object) : int
      {
         var prevItem:Object = null;
         var len:int = 0;
         var j:int = 0;
         var loc:int = this.list.getItemIndex(item);
         if(this.filterFunction == null)
         {
            return loc;
         }
         if(loc == 0)
         {
            return 0;
         }
         for(var i:int = loc - 1; i >= 0; i--)
         {
            prevItem = this.list.getItemAt(i);
            if(this.filterFunction(prevItem))
            {
               len = this.localIndex.length;
               for(j = 0; j < len; j++)
               {
                  if(this.localIndex[j] == prevItem)
                  {
                     return j + 1;
                  }
               }
            }
         }
         return 0;
      }
      
      public function removeItem(item:Object) : Boolean
      {
         if("removeItem" in this.list)
         {
            return this.list["removeItem"](item);
         }
         return false;
      }
      
      public function removeItemAt(index:int) : Object
      {
         var message:String = null;
         var oldItem:Object = null;
         if(index < 0 || index >= this.length)
         {
            message = this.resourceManager.getString("collections","outOfBounds",[index]);
            throw new RangeError(message);
         }
         var listIndex:int = index;
         if(this.localIndex)
         {
            oldItem = this.localIndex[index];
            listIndex = this.list.getItemIndex(oldItem);
         }
         return this.list.removeItemAt(listIndex);
      }
      
      public function removeAll() : void
      {
         var i:int = 0;
         var len:int = this.length;
         if(len > 0)
         {
            if(this.localIndex && this.filterFunction != null)
            {
               len = this.localIndex.length;
               for(i = len - 1; i >= 0; i--)
               {
                  this.removeItemAt(i);
               }
            }
            else
            {
               this.localIndex = null;
               this.list.removeAll();
            }
         }
      }
      
      public function toArray() : Array
      {
         var ret:Array = null;
         if(this.localIndex)
         {
            ret = this.localIndex.concat();
         }
         else
         {
            ret = this.list.toArray();
         }
         return ret;
      }
      
      public function toString() : String
      {
         if(this.localIndex)
         {
            return ObjectUtil.toString(this.localIndex);
         }
         if(this.list && Object(this.list).toString)
         {
            return Object(this.list).toString();
         }
         return getQualifiedClassName(this);
      }
      
      override flash_proxy function getProperty(name:*) : *
      {
         var n:Number = NaN;
         var message:String = null;
         if(name is QName)
         {
            name = name.localName;
         }
         try
         {
            n = parseInt(String(name));
         }
         catch(e:Error)
         {
         }
         if(isNaN(n))
         {
            message = this.resourceManager.getString("collections","unknownProperty",[name]);
            throw new Error(message);
         }
         return this.getItemAt(int(n));
      }
      
      override flash_proxy function setProperty(name:*, value:*) : void
      {
         var n:Number = NaN;
         var message:String = null;
         if(name is QName)
         {
            name = name.localName;
         }
         try
         {
            n = parseInt(String(name));
         }
         catch(e:Error)
         {
         }
         if(isNaN(n))
         {
            message = this.resourceManager.getString("collections","unknownProperty",[name]);
            throw new Error(message);
         }
         this.setItemAt(value,int(n));
      }
      
      override flash_proxy function hasProperty(name:*) : Boolean
      {
         var n:Number = NaN;
         if(name is QName)
         {
            name = name.localName;
         }
         var index:int = -1;
         try
         {
            n = parseInt(String(name));
            if(!isNaN(n))
            {
               index = int(n);
            }
         }
         catch(e:Error)
         {
         }
         if(index == -1)
         {
            return false;
         }
         return index >= 0 && index < this.length;
      }
      
      override flash_proxy function nextNameIndex(index:int) : int
      {
         return index < this.length ? int(index + 1) : 0;
      }
      
      override flash_proxy function nextName(index:int) : String
      {
         return (index - 1).toString();
      }
      
      override flash_proxy function nextValue(index:int) : *
      {
         return this.getItemAt(index - 1);
      }
      
      override flash_proxy function callProperty(name:*, ... rest) : *
      {
         return null;
      }
      
      public function addEventListener(eventType:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         this.eventDispatcher.addEventListener(eventType,listener,useCapture,priority,useWeakReference);
      }
      
      public function removeEventListener(eventType:String, listener:Function, useCapture:Boolean = false) : void
      {
         this.eventDispatcher.removeEventListener(eventType,listener,useCapture);
      }
      
      public function dispatchEvent(event:Event) : Boolean
      {
         return this.eventDispatcher.dispatchEvent(event);
      }
      
      public function hasEventListener(eventType:String) : Boolean
      {
         return this.eventDispatcher.hasEventListener(eventType);
      }
      
      public function willTrigger(eventType:String) : Boolean
      {
         return this.eventDispatcher.willTrigger(eventType);
      }
      
      private function addItemsToView(items:Array, sourceLocation:int, dispatch:Boolean = true) : int
      {
         var loc:int = 0;
         var length:int = 0;
         var i:int = 0;
         var item:Object = null;
         var message:String = null;
         var event:CollectionEvent = null;
         var addedItems:Array = !!this.localIndex ? [] : items;
         var addLocation:int = sourceLocation;
         var firstOne:Boolean = true;
         if(this.localIndex)
         {
            loc = sourceLocation;
            length = items.length;
            for(i = 0; i < length; i++)
            {
               item = items[i];
               if(this.filterFunction != null)
               {
                  if(this.filterFunction(item))
                  {
                     if(this.sort)
                     {
                        loc = this.findItem(item,Sort.ANY_INDEX_MODE,true);
                     }
                     else
                     {
                        loc = this.getFilteredItemIndex(item);
                     }
                     if(firstOne)
                     {
                        addLocation = loc;
                        firstOne = false;
                     }
                  }
                  else
                  {
                     loc = -1;
                     addLocation = -1;
                  }
               }
               else if(this.sort)
               {
                  loc = this.findItem(item,Sort.ANY_INDEX_MODE,true);
                  if(firstOne)
                  {
                     addLocation = loc;
                     firstOne = false;
                  }
               }
               else
               {
                  loc = this.localIndex.length;
                  addLocation = loc;
               }
               if(loc != -1)
               {
                  this.localIndex.splice(loc++,0,item);
                  addedItems.push(item);
               }
            }
         }
         if(this.sort && this.sort.unique && this.sort.compareFunction(item,this.localIndex[loc]) == 0)
         {
            message = this.resourceManager.getString("collections","incorrectAddition");
            throw new CollectionViewError(message);
         }
         if(this.localIndex && addedItems.length > 1)
         {
            addLocation = -1;
         }
         if(dispatch && addedItems.length > 0)
         {
            event = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            event.kind = CollectionEventKind.ADD;
            event.location = addLocation;
            event.items = addedItems;
            this.dispatchEvent(event);
         }
         return addLocation;
      }
      
      mx_internal function findItem(values:Object, mode:String, insertIndex:Boolean = false) : int
      {
         var message:String = null;
         if(!this.sort || !this.localIndex)
         {
            message = this.resourceManager.getString("collections","itemNotFound");
            throw new CollectionViewError(message);
         }
         if(this.localIndex.length == 0)
         {
            return !!insertIndex ? 0 : -1;
         }
         try
         {
            return this.sort.findItem(this.localIndex,values,mode,insertIndex);
         }
         catch(e:SortError)
         {
            return -1;
         }
      }
      
      mx_internal function getBookmark(index:int) : ListCollectionViewBookmark
      {
         var value:Object = null;
         var message:String = null;
         if(index < 0 || index > this.length)
         {
            message = this.resourceManager.getString("collections","invalidIndex",[index]);
            throw new CollectionViewError(message);
         }
         try
         {
            value = this.getItemAt(index);
         }
         catch(e:Error)
         {
         }
         return new ListCollectionViewBookmark(value,this,this.revision,index);
      }
      
      mx_internal function getBookmarkIndex(bookmark:CursorBookmark) : int
      {
         var bm:ListCollectionViewBookmark = null;
         var message:String = null;
         if(!(bookmark is ListCollectionViewBookmark) || ListCollectionViewBookmark(bookmark).view != this)
         {
            message = this.resourceManager.getString("collections","bookmarkNotFound");
            throw new CollectionViewError(message);
         }
         bm = ListCollectionViewBookmark(bookmark);
         if(bm.viewRevision != this.revision)
         {
            if(bm.index < 0 || bm.index >= this.length || this.getItemAt(bm.index) != bm.value)
            {
               try
               {
                  bm.index = this.getItemIndex(bm.value);
               }
               catch(e:SortError)
               {
                  bm.index = getLocalItemIndex(bm.value);
               }
            }
            bm.viewRevision = this.revision;
         }
         return bm.index;
      }
      
      private function listChangeHandler(event:CollectionEvent) : void
      {
         var n:int = 0;
         var i:int = 0;
         if(this.autoUpdateCounter > 0)
         {
            if(!this.pendingUpdates)
            {
               this.pendingUpdates = [];
            }
            this.pendingUpdates.push(event);
         }
         else
         {
            switch(event.kind)
            {
               case CollectionEventKind.ADD:
                  this.addItemsToView(event.items,event.location);
                  break;
               case CollectionEventKind.MOVE:
                  n = event.items.length;
                  for(i = 0; i < n; i++)
                  {
                     this.moveItemInView(event.items[i]);
                  }
                  break;
               case CollectionEventKind.RESET:
                  this.reset();
                  break;
               case CollectionEventKind.REMOVE:
                  this.removeItemsFromView(event.items,event.location);
                  break;
               case CollectionEventKind.REPLACE:
                  this.replaceItemsInView(event.items,event.location);
                  break;
               case CollectionEventKind.UPDATE:
                  this.handlePropertyChangeEvents(event.items);
                  break;
               default:
                  this.dispatchEvent(event);
            }
         }
      }
      
      private function handlePropertyChangeEvents(events:Array) : void
      {
         var updatedItems:Array = null;
         var updateEntry:Object = null;
         var i:int = 0;
         var temp:Array = null;
         var ctr:int = 0;
         var updateInfo:PropertyChangeEvent = null;
         var item:Object = null;
         var defaultMove:* = false;
         var j:int = 0;
         var evts:Array = null;
         var l:int = 0;
         var k:int = 0;
         var oldOrNewValueSpecified:Boolean = false;
         var objectReplacedInCollection:Boolean = false;
         var somethingUnknownAboutTheObjectChanged:Boolean = false;
         var ctr1:int = 0;
         var updateEvent:CollectionEvent = null;
         var eventItems:Array = events;
         if(this.sort || this.filterFunction != null)
         {
            updatedItems = [];
            for(i = 0; i < events.length; i++)
            {
               updateInfo = events[i];
               if(updateInfo.target)
               {
                  item = updateInfo.target;
                  defaultMove = updateInfo.target != updateInfo.source;
               }
               else
               {
                  item = updateInfo.source;
                  defaultMove = false;
               }
               for(j = 0; j < updatedItems.length; )
               {
                  if(updatedItems[j].item == item)
                  {
                     evts = updatedItems[j].events as Array;
                     l = evts.length;
                     for(k = 0; k < l; k++)
                     {
                        if(evts[k].property != updateInfo.property)
                        {
                           evts.push(updateInfo);
                           break;
                        }
                     }
                     break;
                  }
                  j++;
               }
               if(j < updatedItems.length)
               {
                  updateEntry = updatedItems[j];
               }
               else
               {
                  oldOrNewValueSpecified = updateInfo.oldValue != null || updateInfo.newValue != null;
                  objectReplacedInCollection = updateInfo.property == null && oldOrNewValueSpecified;
                  somethingUnknownAboutTheObjectChanged = updateInfo.property == null && !oldOrNewValueSpecified;
                  updateEntry = {
                     "item":item,
                     "move":defaultMove,
                     "events":[updateInfo],
                     "undefinedChange":somethingUnknownAboutTheObjectChanged,
                     "objectReplacedWithAnother":objectReplacedInCollection,
                     "oldItem":updateInfo.oldValue
                  };
                  updatedItems.push(updateEntry);
               }
               updateEntry.move = updateEntry.move || this.filterFunction != null || updateEntry.objectReplacedWithAnother || updateEntry.undefinedChange || this.sort && this.sort.propertyAffectsSort(String(updateInfo.property));
            }
            eventItems = [];
            for(i = 0; i < updatedItems.length; i++)
            {
               updateEntry = updatedItems[i];
               if(updateEntry.move)
               {
                  if(updateEntry.objectReplacedWithAnother)
                  {
                     this.removeItemsFromView([updateEntry.oldItem],-1,true);
                  }
                  this.moveItemInView(updateEntry.item,updateEntry.item != null,eventItems);
               }
               else
               {
                  eventItems.push(updateEntry.item);
               }
            }
            temp = [];
            for(ctr = 0; ctr < eventItems.length; ctr++)
            {
               for(ctr1 = 0; ctr1 < updatedItems.length; ctr1++)
               {
                  if(eventItems[ctr] == updatedItems[ctr1].item)
                  {
                     temp = temp.concat(updatedItems[ctr1].events);
                  }
               }
            }
            eventItems = temp;
         }
         if(eventItems.length > 0)
         {
            updateEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            updateEvent.kind = CollectionEventKind.UPDATE;
            updateEvent.items = eventItems;
            this.dispatchEvent(updateEvent);
         }
      }
      
      private function handlePendingUpdates() : void
      {
         var pu:Array = null;
         var singleUpdateEvent:CollectionEvent = null;
         var i:int = 0;
         var event:CollectionEvent = null;
         var j:int = 0;
         if(this.pendingUpdates)
         {
            pu = this.pendingUpdates;
            this.pendingUpdates = null;
            for(i = 0; i < pu.length; i++)
            {
               event = pu[i];
               if(event.kind == CollectionEventKind.UPDATE)
               {
                  if(!singleUpdateEvent)
                  {
                     singleUpdateEvent = event;
                  }
                  else
                  {
                     for(j = 0; j < event.items.length; j++)
                     {
                        singleUpdateEvent.items.push(event.items[j]);
                     }
                  }
               }
               else
               {
                  this.listChangeHandler(event);
               }
            }
            if(singleUpdateEvent)
            {
               this.listChangeHandler(singleUpdateEvent);
            }
         }
      }
      
      private function internalRefresh(dispatch:Boolean) : Boolean
      {
         var tmp:Array = null;
         var len:int = 0;
         var i:int = 0;
         var item:Object = null;
         var refreshEvent:CollectionEvent = null;
         if(this.sort || this.filterFunction != null)
         {
            try
            {
               this.populateLocalIndex();
            }
            catch(pending:ItemPendingError)
            {
               pending.addResponder(new ItemResponder(function(data:Object, token:Object = null):void
               {
                  internalRefresh(dispatch);
               },function(info:Object, token:Object = null):void
               {
               }));
               return false;
            }
            if(this.filterFunction != null)
            {
               tmp = [];
               len = this.localIndex.length;
               for(i = 0; i < len; i++)
               {
                  item = this.localIndex[i];
                  if(this.filterFunction(item))
                  {
                     tmp.push(item);
                  }
               }
               this.localIndex = tmp;
            }
            if(this.sort)
            {
               this.sort.sort(this.localIndex);
               var dispatch:Boolean = true;
            }
         }
         else if(this.localIndex)
         {
            this.localIndex = null;
         }
         ++this.revision;
         this.pendingUpdates = null;
         if(dispatch)
         {
            refreshEvent = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            refreshEvent.kind = CollectionEventKind.REFRESH;
            this.dispatchEvent(refreshEvent);
         }
         return true;
      }
      
      private function moveItemInView(item:Object, dispatch:Boolean = true, updateEventItems:Array = null) : void
      {
         var removeLocation:int = 0;
         var i:int = 0;
         var addLocation:int = 0;
         var event:CollectionEvent = null;
         if(this.localIndex)
         {
            removeLocation = -1;
            for(i = 0; i < this.localIndex.length; i++)
            {
               if(this.localIndex[i] == item)
               {
                  removeLocation = i;
                  break;
               }
            }
            if(removeLocation > -1)
            {
               this.localIndex.splice(removeLocation,1);
            }
            addLocation = this.addItemsToView([item],removeLocation,false);
            if(dispatch)
            {
               event = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
               event.items.push(item);
               if(updateEventItems && addLocation == removeLocation && addLocation > -1)
               {
                  updateEventItems.push(item);
                  return;
               }
               if(addLocation > -1 && removeLocation > -1)
               {
                  event.kind = CollectionEventKind.MOVE;
                  event.location = addLocation;
                  event.oldLocation = removeLocation;
               }
               else if(addLocation > -1)
               {
                  event.kind = CollectionEventKind.ADD;
                  event.location = addLocation;
               }
               else if(removeLocation > -1)
               {
                  event.kind = CollectionEventKind.REMOVE;
                  event.location = removeLocation;
               }
               else
               {
                  dispatch = false;
               }
               if(dispatch)
               {
                  this.dispatchEvent(event);
               }
            }
         }
      }
      
      private function populateLocalIndex() : void
      {
         if(this.list)
         {
            this.localIndex = this.list.toArray();
         }
         else
         {
            this.localIndex = [];
         }
      }
      
      private function removeItemsFromView(items:Array, sourceLocation:int, dispatch:Boolean = true) : void
      {
         var i:int = 0;
         var item:Object = null;
         var loc:int = 0;
         var event:CollectionEvent = null;
         var removedItems:Array = !!this.localIndex ? [] : items;
         var removeLocation:int = sourceLocation;
         if(this.localIndex)
         {
            for(i = 0; i < items.length; i++)
            {
               item = items[i];
               loc = this.getItemIndex(item);
               if(loc > -1)
               {
                  this.localIndex.splice(loc,1);
                  removedItems.push(item);
                  removeLocation = loc;
               }
            }
         }
         if(dispatch && removedItems.length > 0)
         {
            event = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            event.kind = CollectionEventKind.REMOVE;
            event.location = !this.localIndex || removedItems.length == 1 ? int(removeLocation) : -1;
            event.items = removedItems;
            this.dispatchEvent(event);
         }
      }
      
      private function replaceItemsInView(changeEvents:Array, location:int, dispatch:Boolean = true) : void
      {
         var len:int = 0;
         var oldItems:Array = null;
         var newItems:Array = null;
         var i:int = 0;
         var propertyEvent:PropertyChangeEvent = null;
         var event:CollectionEvent = null;
         if(this.localIndex)
         {
            len = changeEvents.length;
            oldItems = [];
            newItems = [];
            for(i = 0; i < len; i++)
            {
               propertyEvent = changeEvents[i];
               oldItems.push(propertyEvent.oldValue);
               newItems.push(propertyEvent.newValue);
            }
            this.removeItemsFromView(oldItems,location,dispatch);
            this.addItemsToView(newItems,location,dispatch);
         }
         else
         {
            event = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            event.kind = CollectionEventKind.REPLACE;
            event.location = location;
            event.items = changeEvents;
            this.dispatchEvent(event);
         }
      }
      
      mx_internal function reset() : void
      {
         var event:CollectionEvent = null;
         this.internalRefresh(false);
         if(this.dispatchResetEvent)
         {
            event = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            event.kind = CollectionEventKind.RESET;
            this.dispatchEvent(event);
         }
      }
      
      public function get complexFieldWatcher() : ComplexFieldChangeWatcher
      {
         return this._complexFieldWatcher;
      }
      
      public function set complexFieldWatcher(value:ComplexFieldChangeWatcher) : void
      {
         if(this._complexFieldWatcher != value)
         {
            this.stopWatchingForComplexFieldsChanges();
            this._complexFieldWatcher = value;
            if(this._complexFieldWatcher)
            {
               this._complexFieldWatcher.list = this;
            }
            this.startWatchingForComplexFieldsChanges();
         }
      }
      
      private function startWatchingForComplexFieldsChanges() : void
      {
         if(this.complexFieldWatcher && this.sort && this.sort.fields)
         {
            this._complexFieldWatcher.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onComplexFieldValueChanged,false,0,true);
            this._complexFieldWatcher.startWatchingForComplexFieldChanges();
         }
      }
      
      private function stopWatchingForComplexFieldsChanges() : void
      {
         if(this.complexFieldWatcher)
         {
            this._complexFieldWatcher.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.onComplexFieldValueChanged);
            this._complexFieldWatcher.stopWatchingForComplexFieldChanges();
         }
      }
      
      private function onComplexFieldValueChanged(changeEvent:PropertyChangeEvent) : void
      {
         if(this.sort)
         {
            this.moveItemInView(changeEvent.source);
         }
      }
   }
}

import flash.events.EventDispatcher;
import mx.collections.CursorBookmark;
import mx.collections.ICollectionView;
import mx.collections.IViewCursor;
import mx.collections.ListCollectionView;
import mx.collections.Sort;
import mx.collections.errors.CollectionViewError;
import mx.collections.errors.CursorError;
import mx.collections.errors.ItemPendingError;
import mx.collections.errors.SortError;
import mx.core.mx_internal;
import mx.events.CollectionEvent;
import mx.events.CollectionEventKind;
import mx.events.FlexEvent;
import mx.resources.IResourceManager;
import mx.resources.ResourceManager;

use namespace mx_internal;

[Event(name="cursorUpdate",type="mx.events.FlexEvent")]
class ListCollectionViewCursor extends EventDispatcher implements IViewCursor
{
   
   private static const BEFORE_FIRST_INDEX:int = -1;
   
   private static const AFTER_LAST_INDEX:int = -2;
    
   
   private var _view:ListCollectionView;
   
   private var currentIndex:int;
   
   private var currentValue:Object;
   
   private var invalid:Boolean;
   
   private var resourceManager:IResourceManager;
   
   function ListCollectionViewCursor(view:ListCollectionView)
   {
      this.resourceManager = ResourceManager.getInstance();
      super();
      this._view = view;
      this._view.addEventListener(CollectionEvent.COLLECTION_CHANGE,this.collectionEventHandler,false,0,true);
      this.currentIndex = view.length > 0 ? 0 : int(AFTER_LAST_INDEX);
      if(this.currentIndex == 0)
      {
         try
         {
            this.setCurrent(view.getItemAt(0),false);
         }
         catch(e:ItemPendingError)
         {
            currentIndex = BEFORE_FIRST_INDEX;
            setCurrent(null,false);
         }
      }
   }
   
   public function get view() : ICollectionView
   {
      this.checkValid();
      return this._view;
   }
   
   [Bindable("cursorUpdate")]
   public function get current() : Object
   {
      this.checkValid();
      return this.currentValue;
   }
   
   [Bindable("cursorUpdate")]
   public function get bookmark() : CursorBookmark
   {
      this.checkValid();
      if(this.view.length == 0 || this.beforeFirst)
      {
         return CursorBookmark.FIRST;
      }
      if(this.afterLast)
      {
         return CursorBookmark.LAST;
      }
      return ListCollectionView(this.view).getBookmark(this.currentIndex);
   }
   
   [Bindable("cursorUpdate")]
   public function get beforeFirst() : Boolean
   {
      this.checkValid();
      return this.currentIndex == BEFORE_FIRST_INDEX || this.view.length == 0;
   }
   
   [Bindable("cursorUpdate")]
   public function get afterLast() : Boolean
   {
      this.checkValid();
      return this.currentIndex == AFTER_LAST_INDEX || this.view.length == 0;
   }
   
   public function findAny(values:Object) : Boolean
   {
      var index:int = 0;
      this.checkValid();
      var lcView:ListCollectionView = ListCollectionView(this.view);
      try
      {
         index = lcView.findItem(values,Sort.ANY_INDEX_MODE);
      }
      catch(e:SortError)
      {
         throw new CursorError(e.message);
      }
      if(index > -1)
      {
         this.currentIndex = index;
         this.setCurrent(lcView.getItemAt(this.currentIndex));
      }
      return index > -1;
   }
   
   public function findFirst(values:Object) : Boolean
   {
      var index:int = 0;
      this.checkValid();
      var lcView:ListCollectionView = ListCollectionView(this.view);
      try
      {
         index = lcView.findItem(values,Sort.FIRST_INDEX_MODE);
      }
      catch(sortError:SortError)
      {
         throw new CursorError(sortError.message);
      }
      if(index > -1)
      {
         this.currentIndex = index;
         this.setCurrent(lcView.getItemAt(this.currentIndex));
      }
      return index > -1;
   }
   
   public function findLast(values:Object) : Boolean
   {
      var index:int = 0;
      this.checkValid();
      var lcView:ListCollectionView = ListCollectionView(this.view);
      try
      {
         index = lcView.findItem(values,Sort.LAST_INDEX_MODE);
      }
      catch(sortError:SortError)
      {
         throw new CursorError(sortError.message);
      }
      if(index > -1)
      {
         this.currentIndex = index;
         this.setCurrent(lcView.getItemAt(this.currentIndex));
      }
      return index > -1;
   }
   
   public function insert(item:Object) : void
   {
      var insertIndex:int = 0;
      var message:String = null;
      if(this.afterLast)
      {
         insertIndex = this.view.length;
      }
      else if(this.beforeFirst)
      {
         if(this.view.length > 0)
         {
            message = this.resourceManager.getString("collections","invalidInsert");
            throw new CursorError(message);
         }
         insertIndex = 0;
      }
      else
      {
         insertIndex = this.currentIndex;
      }
      ListCollectionView(this.view).addItemAt(item,insertIndex);
   }
   
   public function moveNext() : Boolean
   {
      if(this.afterLast)
      {
         return false;
      }
      var tempIndex:int = !!this.beforeFirst ? 0 : int(this.currentIndex + 1);
      if(tempIndex >= this.view.length)
      {
         tempIndex = AFTER_LAST_INDEX;
         this.setCurrent(null);
      }
      else
      {
         this.setCurrent(ListCollectionView(this.view).getItemAt(tempIndex));
      }
      this.currentIndex = tempIndex;
      return !this.afterLast;
   }
   
   public function movePrevious() : Boolean
   {
      if(this.beforeFirst)
      {
         return false;
      }
      var tempIndex:int = !!this.afterLast ? int(this.view.length - 1) : int(this.currentIndex - 1);
      if(tempIndex == -1)
      {
         tempIndex = BEFORE_FIRST_INDEX;
         this.setCurrent(null);
      }
      else
      {
         this.setCurrent(ListCollectionView(this.view).getItemAt(tempIndex));
      }
      this.currentIndex = tempIndex;
      return !this.beforeFirst;
   }
   
   public function remove() : Object
   {
      var oldIndex:int = 0;
      var message:String = null;
      if(this.beforeFirst || this.afterLast)
      {
         message = this.resourceManager.getString("collections","invalidRemove");
         throw new CursorError(message);
      }
      oldIndex = this.currentIndex;
      ++this.currentIndex;
      if(this.currentIndex >= this.view.length)
      {
         this.currentIndex = AFTER_LAST_INDEX;
         this.setCurrent(null);
      }
      else
      {
         try
         {
            this.setCurrent(ListCollectionView(this.view).getItemAt(this.currentIndex));
         }
         catch(e:ItemPendingError)
         {
            setCurrent(null,false);
            ListCollectionView(view).removeItemAt(oldIndex);
            throw e;
         }
      }
      var removed:Object = ListCollectionView(this.view).removeItemAt(oldIndex);
      return removed;
   }
   
   public function seek(bookmark:CursorBookmark, offset:int = 0, prefetch:int = 0) : void
   {
      var message:String = null;
      this.checkValid();
      if(this.view.length == 0)
      {
         this.currentIndex = AFTER_LAST_INDEX;
         this.setCurrent(null,false);
         return;
      }
      var newIndex:int = this.currentIndex;
      if(bookmark == CursorBookmark.FIRST)
      {
         newIndex = 0;
      }
      else if(bookmark == CursorBookmark.LAST)
      {
         newIndex = this.view.length - 1;
      }
      else if(bookmark != CursorBookmark.CURRENT)
      {
         try
         {
            newIndex = ListCollectionView(this.view).getBookmarkIndex(bookmark);
            if(newIndex < 0)
            {
               this.setCurrent(null);
               message = this.resourceManager.getString("collections","bookmarkInvalid");
               throw new CursorError(message);
            }
         }
         catch(bmError:CollectionViewError)
         {
            message = resourceManager.getString("collections","bookmarkInvalid");
            throw new CursorError(message);
         }
      }
      newIndex += offset;
      var newCurrent:Object = null;
      if(newIndex >= this.view.length)
      {
         this.currentIndex = AFTER_LAST_INDEX;
      }
      else if(newIndex < 0)
      {
         this.currentIndex = BEFORE_FIRST_INDEX;
      }
      else
      {
         newCurrent = ListCollectionView(this.view).getItemAt(newIndex,prefetch);
         this.currentIndex = newIndex;
      }
      this.setCurrent(newCurrent);
   }
   
   private function checkValid() : void
   {
      var message:String = null;
      if(this.invalid)
      {
         message = this.resourceManager.getString("collections","invalidCursor");
         throw new CursorError(message);
      }
   }
   
   private function collectionEventHandler(event:CollectionEvent) : void
   {
      switch(event.kind)
      {
         case CollectionEventKind.ADD:
            if(event.location <= this.currentIndex)
            {
               this.currentIndex += event.items.length;
            }
            break;
         case CollectionEventKind.REMOVE:
            if(event.location < this.currentIndex)
            {
               this.currentIndex -= event.items.length;
            }
            else if(event.location == this.currentIndex)
            {
               if(this.currentIndex < this.view.length)
               {
                  try
                  {
                     this.setCurrent(ListCollectionView(this.view).getItemAt(this.currentIndex));
                  }
                  catch(error:ItemPendingError)
                  {
                     setCurrent(null,false);
                  }
               }
               else
               {
                  this.currentIndex = AFTER_LAST_INDEX;
                  this.setCurrent(null);
               }
            }
            break;
         case CollectionEventKind.MOVE:
            if(event.oldLocation == this.currentIndex)
            {
               this.currentIndex = event.location;
            }
            else
            {
               if(event.oldLocation < this.currentIndex)
               {
                  this.currentIndex -= event.items.length;
               }
               if(event.location <= this.currentIndex)
               {
                  this.currentIndex += event.items.length;
               }
            }
            break;
         case CollectionEventKind.REFRESH:
            if(!(this.beforeFirst || this.afterLast))
            {
               try
               {
                  this.currentIndex = ListCollectionView(this.view).getItemIndex(this.currentValue);
               }
               catch(e:SortError)
               {
                  if(ListCollectionView(view).sort)
                  {
                     currentIndex = ListCollectionView(view).getLocalItemIndex(currentValue);
                  }
               }
               if(this.currentIndex == -1)
               {
                  this.setCurrent(null);
               }
            }
            break;
         case CollectionEventKind.REPLACE:
            if(event.location == this.currentIndex)
            {
               try
               {
                  this.setCurrent(ListCollectionView(this.view).getItemAt(this.currentIndex));
               }
               catch(error:ItemPendingError)
               {
                  setCurrent(null,false);
               }
            }
            break;
         case CollectionEventKind.RESET:
            this.currentIndex = BEFORE_FIRST_INDEX;
            this.setCurrent(null);
      }
   }
   
   private function setCurrent(value:Object, dispatch:Boolean = true) : void
   {
      this.currentValue = value;
      if(dispatch)
      {
         dispatchEvent(new FlexEvent(FlexEvent.CURSOR_UPDATE));
      }
   }
}

import mx.collections.CursorBookmark;
import mx.collections.ListCollectionView;
import mx.core.mx_internal;

use namespace mx_internal;

class ListCollectionViewBookmark extends CursorBookmark
{
    
   
   mx_internal var index:int;
   
   mx_internal var view:ListCollectionView;
   
   mx_internal var viewRevision:int;
   
   function ListCollectionViewBookmark(value:Object, view:ListCollectionView, viewRevision:int, index:int)
   {
      super(value);
      this.view = view;
      this.viewRevision = viewRevision;
      this.index = index;
   }
   
   override public function getViewIndex() : int
   {
      return this.view.getBookmarkIndex(this);
   }
}
