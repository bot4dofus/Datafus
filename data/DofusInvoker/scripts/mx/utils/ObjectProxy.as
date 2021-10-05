package mx.utils
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.IExternalizable;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   import flash.utils.getQualifiedClassName;
   import mx.core.IPropertyChangeNotifier;
   import mx.events.PropertyChangeEvent;
   import mx.events.PropertyChangeEventKind;
   
   use namespace object_proxy;
   use namespace flash_proxy;
   
   [Bindable("propertyChange")]
   public dynamic class ObjectProxy extends Proxy implements IExternalizable, IPropertyChangeNotifier
   {
       
      
      protected var dispatcher:EventDispatcher;
      
      protected var notifiers:Object;
      
      protected var proxyClass:Class;
      
      protected var propertyList:Array;
      
      private var _proxyLevel:int;
      
      private var _item:Object;
      
      private var _type:QName;
      
      private var _id:String;
      
      public function ObjectProxy(item:Object = null, uid:String = null, proxyDepth:int = -1)
      {
         this.proxyClass = ObjectProxy;
         super();
         if(!item)
         {
            item = {};
         }
         this._item = item;
         this._proxyLevel = proxyDepth;
         this.notifiers = {};
         this.dispatcher = new EventDispatcher(this);
         if(uid)
         {
            this._id = uid;
         }
      }
      
      object_proxy function get object() : Object
      {
         return this._item;
      }
      
      object_proxy function get type() : QName
      {
         return this._type;
      }
      
      object_proxy function set type(value:QName) : void
      {
         this._type = value;
      }
      
      public function get uid() : String
      {
         if(this._id === null)
         {
            this._id = UIDUtil.createUID();
         }
         return this._id;
      }
      
      public function set uid(value:String) : void
      {
         this._id = value;
      }
      
      override flash_proxy function getProperty(name:*) : *
      {
         var result:* = undefined;
         if(this.notifiers[name.toString()])
         {
            return this.notifiers[name];
         }
         result = this._item[name];
         if(result)
         {
            if(this._proxyLevel == 0 || ObjectUtil.isSimple(result))
            {
               return result;
            }
            result = this.getComplexProperty(name,result);
         }
         return result;
      }
      
      override flash_proxy function callProperty(name:*, ... rest) : *
      {
         return this._item[name].apply(this._item,rest);
      }
      
      override flash_proxy function deleteProperty(name:*) : Boolean
      {
         var event:PropertyChangeEvent = null;
         var notifier:IPropertyChangeNotifier = IPropertyChangeNotifier(this.notifiers[name]);
         if(notifier)
         {
            notifier.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.propertyChangeHandler);
            delete this.notifiers[name];
         }
         var oldVal:* = this._item[name];
         var deleted:* = delete this._item[name];
         if(this.dispatcher.hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE))
         {
            event = new PropertyChangeEvent(PropertyChangeEvent.PROPERTY_CHANGE);
            event.kind = PropertyChangeEventKind.DELETE;
            event.property = name;
            event.oldValue = oldVal;
            event.source = this;
            this.dispatcher.dispatchEvent(event);
         }
         return deleted;
      }
      
      override flash_proxy function hasProperty(name:*) : Boolean
      {
         return name in this._item;
      }
      
      override flash_proxy function nextName(index:int) : String
      {
         return this.propertyList[index - 1];
      }
      
      override flash_proxy function nextNameIndex(index:int) : int
      {
         if(index == 0)
         {
            this.setupPropertyList();
         }
         if(index < this.propertyList.length)
         {
            return index + 1;
         }
         return 0;
      }
      
      override flash_proxy function nextValue(index:int) : *
      {
         return this._item[this.propertyList[index - 1]];
      }
      
      override flash_proxy function setProperty(name:*, value:*) : void
      {
         var notifier:IPropertyChangeNotifier = null;
         var event:PropertyChangeEvent = null;
         var oldVal:* = this._item[name];
         if(oldVal !== value)
         {
            this._item[name] = value;
            notifier = IPropertyChangeNotifier(this.notifiers[name]);
            if(notifier)
            {
               notifier.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.propertyChangeHandler);
               delete this.notifiers[name];
            }
            if(this.dispatcher.hasEventListener(PropertyChangeEvent.PROPERTY_CHANGE))
            {
               if(name is QName)
               {
                  name = QName(name).localName;
               }
               event = PropertyChangeEvent.createUpdateEvent(this,name.toString(),oldVal,value);
               this.dispatcher.dispatchEvent(event);
            }
         }
      }
      
      object_proxy function getComplexProperty(name:*, value:*) : *
      {
         if(value is IPropertyChangeNotifier)
         {
            value.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.propertyChangeHandler);
            this.notifiers[name] = value;
            return value;
         }
         if(getQualifiedClassName(value) == "Object")
         {
            value = new this.proxyClass(this._item[name],null,this._proxyLevel > 0 ? this._proxyLevel - 1 : this._proxyLevel);
            value.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE,this.propertyChangeHandler);
            this.notifiers[name] = value;
            return value;
         }
         return value;
      }
      
      public function readExternal(input:IDataInput) : void
      {
         var value:Object = input.readObject();
         this._item = value;
      }
      
      public function writeExternal(output:IDataOutput) : void
      {
         output.writeObject(this._item);
      }
      
      public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         this.dispatcher.addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
      
      public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         this.dispatcher.removeEventListener(type,listener,useCapture);
      }
      
      public function dispatchEvent(event:Event) : Boolean
      {
         return this.dispatcher.dispatchEvent(event);
      }
      
      public function hasEventListener(type:String) : Boolean
      {
         return this.dispatcher.hasEventListener(type);
      }
      
      public function willTrigger(type:String) : Boolean
      {
         return this.dispatcher.willTrigger(type);
      }
      
      public function propertyChangeHandler(event:PropertyChangeEvent) : void
      {
         this.dispatcher.dispatchEvent(event);
      }
      
      protected function setupPropertyList() : void
      {
         var prop:* = null;
         if(getQualifiedClassName(this._item) == "Object")
         {
            this.propertyList = [];
            for(prop in this._item)
            {
               this.propertyList.push(prop);
            }
         }
         else
         {
            this.propertyList = ObjectUtil.getClassInfo(this._item,null,{
               "includeReadOnly":true,
               "uris":["*"]
            }).properties;
         }
      }
   }
}
