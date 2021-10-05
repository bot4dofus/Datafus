package mx.logging
{
   import mx.core.mx_internal;
   import mx.logging.errors.InvalidCategoryError;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   
   use namespace mx_internal;
   
   public class Log
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      private static var NONE:int = int.MAX_VALUE;
      
      private static var _targetLevel:int = NONE;
      
      private static var _loggers:Array;
      
      private static var _targets:Array = [];
      
      private static var _resourceManager:IResourceManager;
       
      
      public function Log()
      {
         super();
      }
      
      private static function get resourceManager() : IResourceManager
      {
         if(!_resourceManager)
         {
            _resourceManager = ResourceManager.getInstance();
         }
         return _resourceManager;
      }
      
      public static function isFatal() : Boolean
      {
         return _targetLevel <= LogEventLevel.FATAL ? true : false;
      }
      
      public static function isError() : Boolean
      {
         return _targetLevel <= LogEventLevel.ERROR ? true : false;
      }
      
      public static function isWarn() : Boolean
      {
         return _targetLevel <= LogEventLevel.WARN ? true : false;
      }
      
      public static function isInfo() : Boolean
      {
         return _targetLevel <= LogEventLevel.INFO ? true : false;
      }
      
      public static function isDebug() : Boolean
      {
         return _targetLevel <= LogEventLevel.DEBUG ? true : false;
      }
      
      public static function addTarget(target:ILoggingTarget) : void
      {
         var filters:Array = null;
         var logger:ILogger = null;
         var i:* = null;
         var message:String = null;
         if(target)
         {
            filters = target.filters;
            for(i in _loggers)
            {
               if(categoryMatchInFilterList(i,filters))
               {
                  target.addLogger(ILogger(_loggers[i]));
               }
            }
            _targets.push(target);
            if(_targetLevel == NONE)
            {
               _targetLevel = target.level;
            }
            else if(target.level < _targetLevel)
            {
               _targetLevel = target.level;
            }
            return;
         }
         message = resourceManager.getString("logging","invalidTarget");
         throw new ArgumentError(message);
      }
      
      public static function removeTarget(target:ILoggingTarget) : void
      {
         var filters:Array = null;
         var logger:ILogger = null;
         var i:* = null;
         var j:int = 0;
         var message:String = null;
         if(target)
         {
            filters = target.filters;
            for(i in _loggers)
            {
               if(categoryMatchInFilterList(i,filters))
               {
                  target.removeLogger(ILogger(_loggers[i]));
               }
            }
            for(j = 0; j < _targets.length; j++)
            {
               if(target == _targets[j])
               {
                  _targets.splice(j,1);
                  j--;
               }
            }
            resetTargetLevel();
            return;
         }
         message = resourceManager.getString("logging","invalidTarget");
         throw new ArgumentError(message);
      }
      
      public static function getLogger(category:String) : ILogger
      {
         var target:ILoggingTarget = null;
         checkCategory(category);
         if(!_loggers)
         {
            _loggers = [];
         }
         var result:ILogger = _loggers[category];
         if(result == null)
         {
            result = new LogLogger(category);
            _loggers[category] = result;
         }
         for(var i:int = 0; i < _targets.length; i++)
         {
            target = ILoggingTarget(_targets[i]);
            if(categoryMatchInFilterList(category,target.filters))
            {
               target.addLogger(result);
            }
         }
         return result;
      }
      
      public static function flush() : void
      {
         _loggers = [];
         _targets = [];
         _targetLevel = NONE;
      }
      
      public static function hasIllegalCharacters(value:String) : Boolean
      {
         return value.search(/[\[\]\~\$\^\&\\(\)\{\}\+\?\/=`!@#%,:;'"<>\s]/) != -1;
      }
      
      private static function categoryMatchInFilterList(category:String, filters:Array) : Boolean
      {
         var filter:String = null;
         var result:Boolean = false;
         var index:int = -1;
         for(var i:uint = 0; i < filters.length; i++)
         {
            filter = filters[i];
            index = filter.indexOf("*");
            if(index == 0)
            {
               return true;
            }
            index = index < 0 ? (int(index = category.length)) : int(index - 1);
            if(category.substring(0,index) == filter.substring(0,index))
            {
               return true;
            }
         }
         return false;
      }
      
      private static function checkCategory(category:String) : void
      {
         var message:String = null;
         if(category == null || category.length == 0)
         {
            message = resourceManager.getString("logging","invalidLen");
            throw new InvalidCategoryError(message);
         }
         if(hasIllegalCharacters(category) || category.indexOf("*") != -1)
         {
            message = resourceManager.getString("logging","invalidChars");
            throw new InvalidCategoryError(message);
         }
      }
      
      private static function resetTargetLevel() : void
      {
         var minLevel:int = NONE;
         for(var i:int = 0; i < _targets.length; i++)
         {
            if(minLevel == NONE || _targets[i].level < minLevel)
            {
               minLevel = _targets[i].level;
            }
         }
         _targetLevel = minLevel;
      }
   }
}
