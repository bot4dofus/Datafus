package mx.collections
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.IExternalizable;
   import flash.utils.getQualifiedClassName;
   import mx.core.IPropertyChangeNotifier;
   import mx.core.mx_internal;
   import mx.events.CollectionEvent;
   import mx.events.CollectionEventKind;
   import mx.events.PropertyChangeEvent;
   import mx.events.PropertyChangeEventKind;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   import mx.utils.ArrayUtil;
   import mx.utils.UIDUtil;
   
   use namespace mx_internal;
   
   [Event(name="collectionChange",type="mx.events.CollectionEvent")]
   public class ArrayList extends EventDispatcher implements IList, IExternalizable, IPropertyChangeNotifier
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
       
      
      private var resourceManager:IResourceManager;
      
      private var _dispatchEvents:int = 0;
      
      private var _source:Array;
      
      private var _uid:String;
      
      public function ArrayList(source:Array = null)
      {
         this.resourceManager = ResourceManager.getInstance();
         super();
         this.disableEvents();
         this.source = source;
         this.enableEvents();
      }
      
      [Bindable("collectionChange")]
      public function get length() : int
      {
         if(this.source)
         {
            return this.source.length;
         }
         return 0;
      }
      
      public function get source() : Array
      {
         return this._source;
      }
      
      public function set source(s:Array) : void
      {
         var i:int = 0;
         var len:int = 0;
         var event:CollectionEvent = null;
         if(this._source && this._source.length)
         {
            len = this._source.length;
            for(i = 0; i < len; i++)
            {
               this.stopTrackUpdates(this._source[i]);
            }
         }
         this._source = !!s ? s : [];
         len = this._source.length;
         for(i = 0; i < len; i++)
         {
            this.startTrackUpdates(this._source[i]);
         }
         if(this._dispatchEvents == 0)
         {
            event = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            event.kind = CollectionEventKind.RESET;
            dispatchEvent(event);
         }
      }
      
      public function get uid() : String
      {
         if(!this._uid)
         {
            this._uid = UIDUtil.createUID();
         }
         return this._uid;
      }
      
      public function set uid(value:String) : void
      {
         this._uid = value;
      }
      
      public function toJSON(s:String) : *
      {
         return this.toArray();
      }
      
      public function getItemAt(index:int, prefetch:int = 0) : Object
      {
         var message:String = null;
         if(index < 0 || index >= this.length)
         {
            message = this.resourceManager.getString("collections","outOfBounds",[index]);
            throw new RangeError(message);
         }
         return this.source[index];
      }
      
      public function setItemAt(item:Object, index:int) : Object
      {
         var message:String = null;
         var hasCollectionListener:Boolean = false;
         var hasPropertyListener:Boolean = false;
         var updateInfo:PropertyChangeEvent = null;
         var event:CollectionEvent = null;
         if(index < 0 || index >= this.length)
         {
            message = this.resourceManager.getString("collections","outOfBounds",[index]);
            throw new RangeError(message);
         }
         var oldItem:Object = this.source[index];
         this.source[index] = item;
         this.stopTrackUpdates(oldItem);
         this.startTrackUpdates(item);
         if(this._dispatchEvents == 0)
         {
            hasCollectionListener = hasEventListener(CollectionEvent.COLLECTION_CHANGE);
            hasPropertyListener = hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE);
            if(hasCollectionListener || hasPropertyListener)
            {
               updateInfo = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
               updateInfo.kind = PropertyChangeEventKind.UPDATE;
               updateInfo.oldValue = oldItem;
               updateInfo.newValue = item;
               updateInfo.property = index;
            }
            if(hasCollectionListener)
            {
               event = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
               event.kind = CollectionEventKind.REPLACE;
               event.location = index;
               event.items.push(updateInfo);
               dispatchEvent(event);
            }
            if(hasPropertyListener)
            {
               dispatchEvent(updateInfo);
            }
         }
         return oldItem;
      }
      
      public function addItem(item:Object) : void
      {
         this.addItemAt(item,this.length);
      }
      
      public function addItemAt(item:Object, index:int) : void
      {
         var message:String = null;
         var spliceUpperBound:int = this.length;
         if(index < spliceUpperBound && index > 0)
         {
            this.source.splice(index,0,item);
         }
         else if(index == spliceUpperBound)
         {
            this.source.push(item);
         }
         else
         {
            if(index != 0)
            {
               message = this.resourceManager.getString("collections","outOfBounds",[index]);
               throw new RangeError(message);
            }
            this.source.unshift(item);
         }
         this.startTrackUpdates(item);
         this.internalDispatchEvent(CollectionEventKind.ADD,item,index);
      }
      
      public function addAll(addList:IList) : void
      {
         this.addAllAt(addList,this.length);
      }
      
      public function addAllAt(addList:IList, index:int) : void
      {
         var item:Object = null;
         var event:CollectionEvent = null;
         var addListLength:int = addList.length;
         if(addListLength == 0)
         {
            return;
         }
         var addedItems:Array = [];
         this.disableEvents();
         for(var i:int = 0; i < addListLength; i++)
         {
            item = addList.getItemAt(i);
            this.addItemAt(item,i + index);
            addedItems.push(item);
         }
         this.enableEvents();
         if(this._dispatchEvents == 0)
         {
            event = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
            event.kind = CollectionEventKind.ADD;
            event.location = index;
            event.items = addedItems;
            dispatchEvent(event);
         }
      }
      
      public function getItemIndex(item:Object) : int
      {
         return ArrayUtil.getItemIndex(item,this.source);
      }
      
      public function removeItem(item:Object) : Boolean
      {
         var index:int = this.getItemIndex(item);
         var result:* = index >= 0;
         if(result)
         {
            this.removeItemAt(index);
         }
         return result;
      }
      
      public function removeItemAt(index:int) : Object
      {
         var removed:Object = null;
         var message:String = null;
         var spliceUpperBound:int = this.length - 1;
         if(index > 0 && index < spliceUpperBound)
         {
            removed = this.source.splice(index,1)[0];
         }
         else if(index == spliceUpperBound)
         {
            removed = this.source.pop();
         }
         else
         {
            if(index != 0)
            {
               message = this.resourceManager.getString("collections","outOfBounds",[index]);
               throw new RangeError(message);
            }
            removed = this.source.shift();
         }
         this.stopTrackUpdates(removed);
         this.internalDispatchEvent(CollectionEventKind.REMOVE,removed,index);
         return removed;
      }
      
      public function removeAll() : void
      {
         var len:int = 0;
         var i:int = 0;
         if(this.length > 0)
         {
            len = this.length;
            for(i = 0; i < len; i++)
            {
               this.stopTrackUpdates(this.source[i]);
            }
            this.source.splice(0,this.length);
            this.internalDispatchEvent(CollectionEventKind.RESET);
         }
      }
      
      public function itemUpdated(item:Object, property:Object = null, oldValue:Object = null, newValue:Object = null) : void
      {
         var event:PropertyChangeEvent = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
         event.kind = PropertyChangeEventKind.UPDATE;
         event.source = item;
         event.property = property;
         event.oldValue = oldValue;
         event.newValue = newValue;
         if(!property)
         {
            this.stopTrackUpdates(oldValue);
            this.startTrackUpdates(newValue);
         }
         this.itemUpdateHandler(event);
      }
      
      public function toArray() : Array
      {
         return this.source.concat();
      }
      
      public function readExternal(input:IDataInput) : void
      {
         this.source = input.readObject();
      }
      
      public function writeExternal(output:IDataOutput) : void
      {
         output.writeObject(this._source);
      }
      
      override public function toString() : String
      {
         if(this.source)
         {
            return this.source.toString();
         }
         return getQualifiedClassName(this);
      }
      
      private function enableEvents() : void
      {
         ++this._dispatchEvents;
         if(this._dispatchEvents > 0)
         {
            this._dispatchEvents = 0;
         }
      }
      
      private function disableEvents() : void
      {
         --this._dispatchEvents;
      }
      
      private function internalDispatchEvent(kind:String, item:Object = null, location:int = -1) : void
      {
         var event:CollectionEvent = null;
         var objEvent:PropertyChangeEvent = null;
         if(this._dispatchEvents == 0)
         {
            if(hasEventListener(CollectionEvent.COLLECTION_CHANGE))
            {
               event = new CollectionEvent(CollectionEvent.COLLECTION_CHANGE);
               event.kind = kind;
               if(kind != CollectionEventKind.RESET && kind != CollectionEventKind.REFRESH)
               {
                  event.items.push(item);
               }
               event.location = location;
               dispatchEvent(event);
            }
            if(hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE) && (kind == CollectionEventKind.ADD || kind == CollectionEventKind.REMOVE))
            {
               objEvent = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
               objEvent.property = location;
               if(kind == CollectionEventKind.ADD)
               {
                  objEvent.newValue = item;
               }
               else
               {
                  objEvent.oldValue = item;
               }
               dispatchEvent(objEvent);
            }
         }
      }
      
      protected function itemUpdateHandler(event:PropertyChangeEvent) : void
      {
         var objEvent:PropertyChangeEvent = null;
         var index:uint = 0;
         this.internalDispatchEvent(CollectionEventKind.UPDATE,event);
         if(this._dispatchEvents == 0 && hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE))
         {
            objEvent = PropertyChangeEvent(event.clone());
            index = this.getItemIndex(event.target);
            objEvent.property = index.toString() + "." + event.property;
            dispatchEvent(objEvent);
         }
      }
      
      protected function startTrackUpdates(item:Object) : void
      {
         if(item && item is IEventDispatcher)
         {
            IEventDispatcher(item).addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.itemUpdateHandler,false,0,true);
         }
      }
      
      protected function stopTrackUpdates(item:Object) : void
      {
         if(item && item is IEventDispatcher)
         {
            IEventDispatcher(item).removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.itemUpdateHandler);
         }
      }
   }
}
