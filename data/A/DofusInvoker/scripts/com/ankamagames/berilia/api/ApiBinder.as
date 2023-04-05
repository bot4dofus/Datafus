package com.ankamagames.berilia.api
{
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.utils.errors.ApiError;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import com.ankamagames.jerakine.utils.misc.classInfo.MetadataInfo;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class ApiBinder
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ApiBinder));
      
      private static var _apiClass:Dictionary = new Dictionary();
      
      private static var _apiInstance:Dictionary = new Dictionary();
      
      private static var _apiData:Dictionary = new Dictionary();
      
      private static var _apiDataTagsCache:Dictionary = new Dictionary();
      
      private static var _apiConfigurationsCache:Dictionary = new Dictionary();
       
      
      public function ApiBinder()
      {
         super();
      }
      
      public static function addApi(name:String, apiClass:Class) : void
      {
         var className:String = getQualifiedClassName(apiClass);
         _apiClass[className.substring(className.indexOf("::") + 2)] = apiClass;
      }
      
      public static function removeApi(apiClass:Class) : void
      {
         _apiClass[getQualifiedClassName(apiClass)] = null;
      }
      
      public static function reset() : void
      {
         _apiInstance = new Dictionary();
         _apiData = new Dictionary();
      }
      
      public static function addApiData(name:String, value:*) : void
      {
         _apiData[name] = value;
      }
      
      public static function getApiData(name:String) : *
      {
         return _apiData[name];
      }
      
      public static function removeApiData(name:String) : void
      {
         _apiData[name] = null;
      }
      
      public static function initApi(target:Object, module:UiModule) : void
      {
         var api:Object = null;
         var configCache:ApiConfigurationCache = null;
         var tuple:Vector.<String> = null;
         var cache:ApiConfigurationCache = null;
         var variables:Vector.<String> = null;
         var varDecl:String = null;
         var metaData:MetadataInfo = null;
         var modName:String = null;
         var apiName:String = null;
         addApiData("module",module);
         var targetClassName:String = getQualifiedClassName(target);
         if(_apiConfigurationsCache[targetClassName])
         {
            configCache = _apiConfigurationsCache[targetClassName];
            for each(tuple in configCache.apisToBind)
            {
               api = getApiInstance(tuple[1]);
               if(module.apiList.indexOf(api) == -1)
               {
                  module.apiList.push(api);
               }
               target[tuple[0]] = api;
            }
            for each(tuple in configCache.modulesToBind)
            {
               target[tuple[0]] = UiModuleManager.getInstance().getModule(tuple[1]).mainClass;
            }
         }
         else
         {
            cache = new ApiConfigurationCache();
            _apiConfigurationsCache[targetClassName] = cache;
            variables = DescribeTypeCache.getVariables(target,true);
            for each(varDecl in variables)
            {
               for each(metaData in DescribeTypeCache.getVariableMetadata(target,varDecl))
               {
                  if(metaData && metaData.name == "Module")
                  {
                     modName = metaData.args["name"];
                     if(modName)
                     {
                        if(!UiModuleManager.getInstance().getModules()[modName])
                        {
                           throw new ApiError("Module " + modName + " does not exist (in " + module.id + ")");
                        }
                        target[varDecl] = UiModuleManager.getInstance().getModule(modName).mainClass;
                        cache.modulesToBind.push(new <String>[varDecl,modName]);
                     }
                  }
                  if(metaData && metaData.name == "Api")
                  {
                     apiName = metaData.args["name"];
                     if(apiName)
                     {
                        if(!_apiClass[apiName])
                        {
                           throw new ApiError("Api " + apiName + " does not exist");
                        }
                        api = getApiInstance(apiName);
                        if(module.apiList.indexOf(api) == -1)
                        {
                           module.apiList.push(api);
                        }
                        target[varDecl] = api;
                        cache.apisToBind.push(new <String>[varDecl,apiName]);
                     }
                  }
               }
            }
         }
      }
      
      public static function getApiInstance(name:String) : Object
      {
         var keyVal:Vector.<String> = null;
         if(_apiInstance[name])
         {
            return _apiInstance[name];
         }
         if(!_apiClass[name])
         {
            _log.error("Api [" + name + "] is not available");
            return null;
         }
         var descCache:ApiDataTagCache = _apiDataTagsCache[name];
         if(!descCache)
         {
            descCache = new ApiDataTagCache(_apiClass[name]);
            _apiDataTagsCache[name] = descCache;
         }
         var api:Object = new (_apiClass[name] as Class)();
         for each(keyVal in descCache.tags)
         {
            api[keyVal[0]] = _apiData[keyVal[1]];
         }
         if(!descCache.isInstancied)
         {
            _apiInstance[name] = api;
         }
         return api;
      }
   }
}

class ApiConfigurationCache
{
    
   
   public var apisToBind:Vector.<Vector.<String>>;
   
   public var modulesToBind:Vector.<Vector.<String>>;
   
   function ApiConfigurationCache()
   {
      this.apisToBind = new Vector.<Vector.<String>>();
      this.modulesToBind = new Vector.<Vector.<String>>();
      super();
   }
}

import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
import com.ankamagames.jerakine.utils.misc.classInfo.MetadataInfo;

class ApiDataTagCache
{
    
   
   public var isInstancied:Boolean = false;
   
   public var tags:Vector.<Vector.<String>>;
   
   function ApiDataTagCache(apiClass:Class)
   {
      var tag:MetadataInfo = null;
      var accessor:String = null;
      var accessorMetadata:MetadataInfo = null;
      this.tags = new Vector.<Vector.<String>>();
      super();
      for each(tag in DescribeTypeCache.getMetadata(apiClass))
      {
         if(tag.name == "InstanciedApi")
         {
            this.isInstancied = true;
            break;
         }
      }
      for each(accessor in DescribeTypeCache.getAccessors(apiClass))
      {
         for each(accessorMetadata in DescribeTypeCache.getVariableMetadata(apiClass,accessor))
         {
            if(accessorMetadata.name == "ApiData")
            {
               this.tags.push(new <String>[accessor,accessorMetadata.args["name"]]);
            }
         }
      }
   }
}
