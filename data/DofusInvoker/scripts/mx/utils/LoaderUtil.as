package mx.utils
{
   import flash.display.DisplayObject;
   import flash.display.LoaderInfo;
   import flash.system.Capabilities;
   import flash.utils.Dictionary;
   import mx.core.ApplicationDomainTarget;
   import mx.core.IFlexModuleFactory;
   import mx.core.RSLData;
   import mx.core.mx_internal;
   import mx.events.Request;
   import mx.managers.SystemManagerGlobals;
   
   use namespace mx_internal;
   
   public class LoaderUtil
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      mx_internal static var urlFilters:Array = [{
         "searchString":"/[[DYNAMIC]]/",
         "filterFunction":dynamicURLFilter
      },{
         "searchString":"/[[IMPORT]]/",
         "filterFunction":importURLFilter
      }];
       
      
      public function LoaderUtil()
      {
         super();
      }
      
      public static function normalizeURL(loaderInfo:LoaderInfo) : String
      {
         var index:int = 0;
         var searchString:String = null;
         var urlFilter:Function = null;
         var url:String = loaderInfo.url;
         var n:uint = LoaderUtil.urlFilters.length;
         for(var i:uint = 0; i < n; i++)
         {
            searchString = LoaderUtil.urlFilters[i].searchString;
            if((index = url.indexOf(searchString)) != -1)
            {
               urlFilter = LoaderUtil.urlFilters[i].filterFunction;
               url = urlFilter(url,index);
            }
         }
         if(Platform.isMac)
         {
            return encodeURI(url);
         }
         return url;
      }
      
      public static function createAbsoluteURL(rootURL:String, url:String) : String
      {
         var index:int = 0;
         var lastIndex:int = 0;
         var absoluteURL:String = url;
         if(rootURL && !(url.indexOf(":") > -1 || url.indexOf("/") == 0 || url.indexOf("\\") == 0))
         {
            if((index = rootURL.indexOf("?")) != -1)
            {
               rootURL = rootURL.substring(0,index);
            }
            if((index = rootURL.indexOf("#")) != -1)
            {
               rootURL = rootURL.substring(0,index);
            }
            lastIndex = Math.max(rootURL.lastIndexOf("\\"),rootURL.lastIndexOf("/"));
            if(url.indexOf("./") == 0)
            {
               url = url.substring(2);
            }
            else
            {
               while(url.indexOf("../") == 0)
               {
                  url = url.substring(3);
                  lastIndex = Math.max(rootURL.lastIndexOf("\\",lastIndex - 1),rootURL.lastIndexOf("/",lastIndex - 1));
               }
            }
            if(lastIndex != -1)
            {
               absoluteURL = rootURL.substr(0,lastIndex + 1) + url;
            }
         }
         return absoluteURL;
      }
      
      mx_internal static function processRequiredRSLs(moduleFactory:IFlexModuleFactory, rsls:Array) : Array
      {
         var n:int = 0;
         var i:int = 0;
         var rsl:Array = null;
         var index:int = 0;
         var rslsToLoad:Array = [];
         var topLevelModuleFactory:IFlexModuleFactory = SystemManagerGlobals.topLevelSystemManagers[0];
         var currentModuleFactory:IFlexModuleFactory = topLevelModuleFactory;
         var parentModuleFactory:IFlexModuleFactory = null;
         var loaded:Dictionary = new Dictionary();
         var loadedLength:int = 0;
         var resolved:Dictionary = new Dictionary();
         var resolvedLength:int = 0;
         var moduleFactories:Array = null;
         while(currentModuleFactory != moduleFactory)
         {
            n = rsls.length;
            for(i = 0; i < n; i++)
            {
               rsl = rsls[i];
               if(!loaded[rsl])
               {
                  if(isRSLLoaded(currentModuleFactory,rsl[0].digest))
                  {
                     loaded[rsl] = 1;
                     loadedLength++;
                     if(currentModuleFactory != topLevelModuleFactory)
                     {
                        index = rslsToLoad.indexOf(rsl);
                        if(index != -1)
                        {
                           rslsToLoad.splice(index,1);
                        }
                     }
                  }
                  else if(rslsToLoad.indexOf(rsl) == -1)
                  {
                     rslsToLoad.push(rsl);
                  }
               }
               if(!loaded[rsl] && resolved[rsl] == null)
               {
                  if(!parentModuleFactory && RSLData(rsl[0]).applicationDomainTarget == ApplicationDomainTarget.PARENT)
                  {
                     parentModuleFactory = getParentModuleFactory(moduleFactory);
                  }
                  if(resolveApplicationDomainTarget(rsl,moduleFactory,currentModuleFactory,parentModuleFactory,topLevelModuleFactory))
                  {
                     resolved[rsl] = 1;
                     resolvedLength++;
                  }
               }
            }
            if(loadedLength + resolvedLength >= rsls.length)
            {
               break;
            }
            if(!moduleFactories)
            {
               moduleFactories = [moduleFactory];
               currentModuleFactory = moduleFactory;
               while(currentModuleFactory != topLevelModuleFactory)
               {
                  currentModuleFactory = getParentModuleFactory(currentModuleFactory);
                  if(!currentModuleFactory)
                  {
                     break;
                  }
                  if(currentModuleFactory != topLevelModuleFactory)
                  {
                     moduleFactories.push(currentModuleFactory);
                  }
                  if(!parentModuleFactory)
                  {
                     parentModuleFactory = currentModuleFactory;
                  }
               }
            }
            currentModuleFactory = moduleFactories.pop();
         }
         return rslsToLoad;
      }
      
      mx_internal static function isLocal(url:String) : Boolean
      {
         return url.indexOf("file:") == 0 || url.indexOf(":") == 1;
      }
      
      mx_internal static function OSToPlayerURI(url:String, local:Boolean) : String
      {
         var searchStringIndex:int = 0;
         var fragmentUrlIndex:int = 0;
         var index:int = 0;
         var decoded:String = url;
         if((searchStringIndex = decoded.indexOf("?")) != -1)
         {
            decoded = decoded.substring(0,searchStringIndex);
         }
         if((fragmentUrlIndex = decoded.indexOf("#")) != -1)
         {
            decoded = decoded.substring(0,fragmentUrlIndex);
         }
         try
         {
            decoded = decodeURI(decoded);
         }
         catch(e:Error)
         {
         }
         var extraString:String = null;
         if(searchStringIndex != -1 || fragmentUrlIndex != -1)
         {
            index = searchStringIndex;
            if(searchStringIndex == -1 || fragmentUrlIndex != -1 && fragmentUrlIndex < searchStringIndex)
            {
               index = fragmentUrlIndex;
            }
            extraString = url.substr(index);
         }
         if(local && Capabilities.playerType == "ActiveX")
         {
            if(extraString)
            {
               return decoded + extraString;
            }
            return decoded;
         }
         if(extraString)
         {
            return encodeURI(decoded) + extraString;
         }
         return encodeURI(decoded);
      }
      
      private static function getParentModuleFactory(moduleFactory:IFlexModuleFactory) : IFlexModuleFactory
      {
         var request:Request = new Request(Request.GET_PARENT_FLEX_MODULE_FACTORY_REQUEST);
         DisplayObject(moduleFactory).dispatchEvent(request);
         return request.value as IFlexModuleFactory;
      }
      
      private static function resolveApplicationDomainTarget(rsl:Array, moduleFactory:IFlexModuleFactory, currentModuleFactory:IFlexModuleFactory, parentModuleFactory:IFlexModuleFactory, topLevelModuleFactory:IFlexModuleFactory) : Boolean
      {
         var resolvedRSL:Boolean = false;
         var targetModuleFactory:IFlexModuleFactory = null;
         var applicationDomainTarget:String = rsl[0].applicationDomainTarget;
         if(isLoadedIntoTopLevelApplicationDomain(moduleFactory))
         {
            targetModuleFactory = topLevelModuleFactory;
         }
         else if(applicationDomainTarget == ApplicationDomainTarget.DEFAULT)
         {
            if(hasPlaceholderRSL(currentModuleFactory,rsl[0].digest))
            {
               targetModuleFactory = currentModuleFactory;
            }
         }
         else if(applicationDomainTarget == ApplicationDomainTarget.TOP_LEVEL)
         {
            targetModuleFactory = topLevelModuleFactory;
         }
         else if(applicationDomainTarget == ApplicationDomainTarget.CURRENT)
         {
            resolvedRSL = true;
         }
         else if(applicationDomainTarget == ApplicationDomainTarget.PARENT)
         {
            targetModuleFactory = parentModuleFactory;
         }
         else
         {
            resolvedRSL = true;
         }
         if(resolvedRSL || targetModuleFactory)
         {
            if(targetModuleFactory)
            {
               updateRSLModuleFactory(rsl,targetModuleFactory);
            }
            return true;
         }
         return false;
      }
      
      private static function isRSLLoaded(moduleFactory:IFlexModuleFactory, digest:String) : Boolean
      {
         var rsl:Vector.<RSLData> = null;
         var n:int = 0;
         var i:int = 0;
         var preloadedRSLs:Dictionary = moduleFactory.preloadedRSLs;
         if(preloadedRSLs)
         {
            for each(rsl in preloadedRSLs)
            {
               n = rsl.length;
               for(i = 0; i < n; i++)
               {
                  if(rsl[i].digest == digest)
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      private static function hasPlaceholderRSL(moduleFactory:IFlexModuleFactory, digest:String) : Boolean
      {
         var n:int = 0;
         var i:int = 0;
         var rsl:Object = null;
         var m:int = 0;
         var j:int = 0;
         var phRSLs:Array = moduleFactory.info()["placeholderRsls"];
         if(phRSLs)
         {
            n = phRSLs.length;
            for(i = 0; i < n; i++)
            {
               rsl = phRSLs[i];
               m = rsl.length;
               for(j = 0; j < m; j++)
               {
                  if(rsl[j].digest == digest)
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      private static function isLoadedIntoTopLevelApplicationDomain(moduleFactory:IFlexModuleFactory) : Boolean
      {
         var displayObject:DisplayObject = null;
         var loaderInfo:LoaderInfo = null;
         if(moduleFactory is DisplayObject)
         {
            displayObject = DisplayObject(moduleFactory);
            loaderInfo = displayObject.loaderInfo;
            if(loaderInfo && loaderInfo.applicationDomain && loaderInfo.applicationDomain.parentDomain == null)
            {
               return true;
            }
         }
         return false;
      }
      
      private static function updateRSLModuleFactory(rsl:Array, moduleFactory:IFlexModuleFactory) : void
      {
         var n:int = rsl.length;
         for(var i:int = 0; i < n; i++)
         {
            rsl[i].moduleFactory = moduleFactory;
         }
      }
      
      private static function dynamicURLFilter(url:String, index:int) : String
      {
         return url.substring(0,index);
      }
      
      private static function importURLFilter(url:String, index:int) : String
      {
         var protocolIndex:int = url.indexOf("://");
         return url.substring(0,protocolIndex + 3) + url.substring(index + 12);
      }
   }
}
