package com.ankamagames.jerakine.managers
{
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class OptionManager implements IEventDispatcher
   {
      
      private static var _optionsManager:Array = [];
       
      
      private var _defaultValue:Dictionary;
      
      private var _properties:Dictionary;
      
      private var _useCache:Dictionary;
      
      private var _allOptions:Array;
      
      private var _eventDispatcher:EventDispatcher;
      
      private var _customName:String;
      
      private var _dataStore:DataStoreType;
      
      public function OptionManager(customName:String = null)
      {
         this._defaultValue = new Dictionary();
         this._properties = new Dictionary();
         this._useCache = new Dictionary();
         this._allOptions = [];
         super();
         if(customName)
         {
            this._customName = customName;
         }
         else
         {
            this._customName = getQualifiedClassName(this).split("::").join("_");
         }
         if(_optionsManager[this._customName])
         {
            throw new Error(customName + " is already used by an other option manager.");
         }
         _optionsManager[this._customName] = this;
         this._eventDispatcher = new EventDispatcher(this);
         this._dataStore = new DataStoreType(this._customName,true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_ACCOUNT);
      }
      
      public static function getOptionManager(name:String) : OptionManager
      {
         return _optionsManager[name];
      }
      
      public static function getOptionManagers() : Array
      {
         var s:* = null;
         var managers:Array = [];
         for(s in _optionsManager)
         {
            managers.push(s);
         }
         return managers;
      }
      
      public static function reset() : void
      {
         _optionsManager = [];
      }
      
      public function add(name:String, value:* = null, useCache:Boolean = true) : void
      {
         if(this._allOptions.indexOf(name) == -1)
         {
            this._allOptions.push(name);
         }
         this._useCache[name] = useCache;
         this._defaultValue[name] = value;
         if(useCache && StoreDataManager.getInstance().getData(this._dataStore,name) != null)
         {
            this._properties[name] = StoreDataManager.getInstance().getData(this._dataStore,name);
         }
         else
         {
            this._properties[name] = value;
         }
      }
      
      public function getDefaultValue(name:String) : *
      {
         return this._defaultValue[name];
      }
      
      public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         this._eventDispatcher.addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
      
      public function dispatchEvent(event:Event) : Boolean
      {
         return this._eventDispatcher.dispatchEvent(event);
      }
      
      public function hasEventListener(type:String) : Boolean
      {
         return this._eventDispatcher.hasEventListener(type);
      }
      
      public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         this._eventDispatcher.removeEventListener(type,listener,useCapture);
      }
      
      public function willTrigger(type:String) : Boolean
      {
         return this._eventDispatcher.willTrigger(type);
      }
      
      public function restaureDefaultValue(name:String) : void
      {
         if(this._useCache[name] != null)
         {
            this.setOption(name,this._defaultValue[name]);
         }
      }
      
      public function getOption(name:String) : *
      {
         return this._properties[name];
      }
      
      public function allOptions() : Array
      {
         return this._allOptions;
      }
      
      public function setOption(name:String, value:*) : *
      {
         var oldValue:* = undefined;
         if(this._useCache[name] != null)
         {
            oldValue = this._properties[name];
            this._properties[name] = value;
            if(this._useCache[name] && !(value is DisplayObject))
            {
               StoreDataManager.getInstance().setData(this._dataStore,name,value);
            }
            this._eventDispatcher.dispatchEvent(new PropertyChangeEvent(this,name,value,oldValue));
         }
      }
   }
}
