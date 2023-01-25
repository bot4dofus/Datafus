package com.ankamagames.jerakine.managers
{
   import by.blooddy.crypto.MD5;
   import com.ankamagames.jerakine.JerakineConstants;
   import com.ankamagames.jerakine.interfaces.Secure;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.CustomSharedObject;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.jerakine.types.events.RegisterClassLogEvent;
   import com.ankamagames.jerakine.utils.crypto.Base64;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import flash.net.ObjectEncoding;
   import flash.net.registerClassAlias;
   import flash.utils.Dictionary;
   import flash.utils.IExternalizable;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   public class StoreDataManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(StoreDataManager));
      
      private static var _self:StoreDataManager;
       
      
      private var _aData:Array;
      
      private var _bStoreSequence:Boolean;
      
      private var _nCurrentSequenceNum:uint = 0;
      
      private var _aStoreSequence:Array;
      
      private var _aSharedObjectCache:Array;
      
      private var _aRegisteredClassAlias:Dictionary;
      
      public function StoreDataManager()
      {
         var oClass:Class = null;
         var className:String = null;
         var s:String = null;
         super();
         if(_self != null)
         {
            throw new SingletonError("DataManager is a singleton and should not be instanciated directly.");
         }
         this._bStoreSequence = false;
         this._aData = [];
         this._aSharedObjectCache = [];
         this._aRegisteredClassAlias = new Dictionary();
         var aClass:Array = this.getData(JerakineConstants.DATASTORE_CLASS_ALIAS,"classAliasList");
         for(s in aClass)
         {
            className = Base64.decode(s);
            _log.logDirectly(new RegisterClassLogEvent(className));
            try
            {
               oClass = Class(getDefinitionByName(className));
               registerClassAlias(aClass[s],oClass);
            }
            catch(e:ReferenceError)
            {
               _log.warn("Impossible de trouver la classe " + className);
            }
            this._aRegisteredClassAlias[className] = true;
         }
      }
      
      public static function getInstance() : StoreDataManager
      {
         if(_self == null)
         {
            _self = new StoreDataManager();
         }
         return _self;
      }
      
      private static function isComplexType(o:*) : Boolean
      {
         switch(true)
         {
            case o is int:
            case o is uint:
            case o is Number:
            case o is Boolean:
            case o is Array:
            case o is String:
            case o == null:
            case o == undefined:
               return false;
            default:
               return true;
         }
      }
      
      public function getData(dataType:DataStoreType, sKey:String) : *
      {
         var so:CustomSharedObject = null;
         if(dataType.persistant)
         {
            switch(dataType.location)
            {
               case DataStoreEnum.LOCATION_LOCAL:
                  so = this.getSharedObject(dataType.category);
                  if(so.data)
                  {
                     return so.data[sKey];
                  }
                  break;
               case DataStoreEnum.LOCATION_SERVER:
            }
            return null;
         }
         if(this._aData[dataType.category] != null)
         {
            return this._aData[dataType.category][sKey];
         }
         return null;
      }
      
      public function registerClass(oInstance:*, deepClassScan:Boolean = false, keepClassInSo:Boolean = true) : void
      {
         var className:String = null;
         var sAlias:String = null;
         var aClassAlias:Array = null;
         var desc:Object = null;
         var key:String = null;
         var tmp:String = null;
         var leftBracePos:int = 0;
         if(oInstance is IExternalizable)
         {
            throw new ArgumentError("Can\'t store a customized IExternalizable in a shared object.");
         }
         if(oInstance is Secure)
         {
            throw new ArgumentError("Can\'t store a Secure class");
         }
         if(isComplexType(oInstance))
         {
            className = getQualifiedClassName(oInstance);
            if(this._aRegisteredClassAlias[className] != null)
            {
               return;
            }
            sAlias = MD5.hash(className);
            _log.logDirectly(new RegisterClassLogEvent(className));
            try
            {
               registerClassAlias(sAlias,Class(getDefinitionByName(className)));
               _log.warn("Register " + className);
            }
            catch(e:Error)
            {
               _aRegisteredClassAlias[className] = true;
               _log.fatal("Impossible de trouver la classe " + className + " dans l\'application domain courant");
               return;
            }
            if(keepClassInSo)
            {
               aClassAlias = this.getSetData(JerakineConstants.DATASTORE_CLASS_ALIAS,"classAliasList",[]);
               aClassAlias[Base64.encode(className)] = sAlias;
               this.setData(JerakineConstants.DATASTORE_CLASS_ALIAS,"classAliasList",aClassAlias);
            }
            this._aRegisteredClassAlias[className] = true;
         }
         if(deepClassScan)
         {
            if(oInstance is Dictionary || oInstance is Array || oInstance is Vector.<*> || oInstance is Vector.<uint>)
            {
               desc = oInstance;
               if(oInstance is Vector.<*>)
               {
                  tmp = getQualifiedClassName(oInstance);
                  leftBracePos = tmp.indexOf("<");
                  tmp = tmp.substr(leftBracePos + 1,tmp.lastIndexOf(">") - leftBracePos - 1);
                  this.registerClass(new (getDefinitionByName(tmp) as Class)(),true,keepClassInSo);
               }
            }
            else
            {
               desc = this.scanType(oInstance);
            }
            for(key in desc)
            {
               if(isComplexType(oInstance[key]))
               {
                  this.registerClass(oInstance[key],true);
               }
               if(desc === oInstance)
               {
                  break;
               }
            }
         }
      }
      
      public function setData(dataType:DataStoreType, sKey:String, oValue:*, deepClassScan:Boolean = false) : Boolean
      {
         var so:CustomSharedObject = null;
         if(this._aData[dataType.category] == null)
         {
            this._aData[dataType.category] = new Dictionary(true);
         }
         this._aData[dataType.category][sKey] = oValue;
         if(dataType.persistant)
         {
            switch(dataType.location)
            {
               case DataStoreEnum.LOCATION_LOCAL:
                  this.registerClass(oValue,deepClassScan);
                  so = this.getSharedObject(dataType.category);
                  if(!so.data)
                  {
                     so.data = {};
                  }
                  so.data[sKey] = oValue;
                  if(!this._bStoreSequence)
                  {
                     if(!so.flush())
                     {
                        return false;
                     }
                  }
                  else
                  {
                     this._aStoreSequence[dataType.category] = dataType;
                  }
                  return true;
               case DataStoreEnum.LOCATION_SERVER:
                  return false;
            }
         }
         return true;
      }
      
      public function getKeys(dataType:DataStoreType) : Array
      {
         var data:Object = null;
         var so:CustomSharedObject = null;
         var key:* = null;
         var result:Array = [];
         if(dataType.persistant)
         {
            switch(dataType.location)
            {
               case DataStoreEnum.LOCATION_LOCAL:
                  so = this.getSharedObject(dataType.category);
                  data = so.data;
                  break;
               case DataStoreEnum.LOCATION_SERVER:
            }
         }
         else if(this._aData[dataType.category] != null)
         {
            data = this._aData[dataType.category];
         }
         if(data)
         {
            for(key in data)
            {
               result.push(key);
            }
         }
         return result;
      }
      
      public function getSetData(dataType:DataStoreType, sKey:String, oValue:*) : *
      {
         var o:* = this.getData(dataType,sKey);
         if(o != null)
         {
            return o;
         }
         this.setData(dataType,sKey,oValue);
         return oValue;
      }
      
      public function startStoreSequence() : void
      {
         this._bStoreSequence = true;
         if(!this._nCurrentSequenceNum)
         {
            this._aStoreSequence = [];
         }
         ++this._nCurrentSequenceNum;
      }
      
      public function stopStoreSequence() : void
      {
         var dt:DataStoreType = null;
         var s:* = null;
         this._bStoreSequence = --this._nCurrentSequenceNum != 0;
         if(this._bStoreSequence)
         {
            return;
         }
         for(s in this._aStoreSequence)
         {
            dt = this._aStoreSequence[s];
            switch(dt.location)
            {
               case DataStoreEnum.LOCATION_LOCAL:
                  this.getSharedObject(dt.category).flush();
                  break;
               case DataStoreEnum.LOCATION_SERVER:
                  break;
            }
         }
         this._aStoreSequence = null;
      }
      
      public function clear(dataType:DataStoreType) : void
      {
         this._aData = [];
         var so:CustomSharedObject = this.getSharedObject(dataType.category);
         so.clear();
      }
      
      public function reset() : void
      {
         var s:CustomSharedObject = null;
         for each(s in this._aSharedObjectCache)
         {
            try
            {
               s.clear();
               s.close();
            }
            catch(e:Error)
            {
            }
         }
         this._aSharedObjectCache = [];
         _self = null;
      }
      
      public function close(dataType:DataStoreType) : void
      {
         switch(dataType.location)
         {
            case DataStoreEnum.LOCATION_LOCAL:
               this._aSharedObjectCache[dataType.category].close();
               delete this._aSharedObjectCache[dataType.category];
         }
      }
      
      private function getSharedObject(sName:String) : CustomSharedObject
      {
         if(this._aSharedObjectCache[sName] != null)
         {
            return this._aSharedObjectCache[sName];
         }
         var so:CustomSharedObject = CustomSharedObject.getLocal(sName);
         so.objectEncoding = ObjectEncoding.AMF3;
         this._aSharedObjectCache[sName] = so;
         return so;
      }
      
      private function isComplexTypeFromString(name:String) : Boolean
      {
         switch(name)
         {
            case "int":
            case "uint":
            case "Number":
            case "Boolean":
            case "Array":
            case "String":
            case null:
               return false;
            default:
               return this._aRegisteredClassAlias[name] !== true;
         }
      }
      
      private function scanType(obj:*) : Object
      {
         var name:String = null;
         var result:Object = {};
         var desc:Vector.<String> = DescribeTypeCache.getVariables(obj,false,true,true,true);
         for each(name in desc)
         {
            if(this.isComplexTypeFromString(getQualifiedClassName(obj[name])))
            {
               result[name] = true;
            }
         }
         return result;
      }
   }
}
