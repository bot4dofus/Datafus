package mx.formatters
{
   import flash.events.Event;
   import mx.core.mx_internal;
   import mx.resources.IResourceManager;
   import mx.resources.ResourceManager;
   
   use namespace mx_internal;
   
   public class DateBase
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      private static var initialized:Boolean = false;
      
      private static var _resourceManager:IResourceManager;
      
      private static var _dayNamesLong:Array;
      
      private static var dayNamesLongOverride:Array;
      
      private static var _dayNamesShort:Array;
      
      private static var dayNamesShortOverride:Array;
      
      private static var _monthNamesLong:Array;
      
      private static var monthNamesLongOverride:Array;
      
      private static var _monthNamesShort:Array;
      
      private static var monthNamesShortOverride:Array;
      
      private static var _timeOfDay:Array;
      
      private static var timeOfDayOverride:Array;
      
      private static var _timezoneName:String = "GMT";
      
      private static var _timezoneHourMinuteSeperator:String = ":";
       
      
      public function DateBase()
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
      
      public static function get dayNamesLong() : Array
      {
         initialize();
         return _dayNamesLong;
      }
      
      public static function set dayNamesLong(value:Array) : void
      {
         dayNamesLongOverride = value;
         _dayNamesLong = value != null ? value : resourceManager.getStringArray("SharedResources","dayNames");
      }
      
      public static function get dayNamesShort() : Array
      {
         initialize();
         return _dayNamesShort;
      }
      
      public static function set dayNamesShort(value:Array) : void
      {
         dayNamesShortOverride = value;
         _dayNamesShort = value != null ? value : resourceManager.getStringArray("formatters","dayNamesShort");
      }
      
      mx_internal static function get defaultStringKey() : Array
      {
         initialize();
         return monthNamesLong.concat(timeOfDay);
      }
      
      public static function get monthNamesLong() : Array
      {
         initialize();
         return _monthNamesLong;
      }
      
      public static function set monthNamesLong(value:Array) : void
      {
         var monthSymbol:String = null;
         var n:int = 0;
         var i:int = 0;
         monthNamesLongOverride = value;
         _monthNamesLong = value != null ? value : resourceManager.getStringArray("SharedResources","monthNames");
         if(value == null)
         {
            monthSymbol = resourceManager.getString("SharedResources","monthSymbol");
            if(monthSymbol != " ")
            {
               n = !!_monthNamesLong ? int(_monthNamesLong.length) : 0;
               for(i = 0; i < n; i++)
               {
                  _monthNamesLong[i] += monthSymbol;
               }
            }
         }
      }
      
      public static function get monthNamesShort() : Array
      {
         initialize();
         return _monthNamesShort;
      }
      
      public static function set monthNamesShort(value:Array) : void
      {
         var monthSymbol:String = null;
         var n:int = 0;
         var i:int = 0;
         monthNamesShortOverride = value;
         _monthNamesShort = value != null ? value : resourceManager.getStringArray("formatters","monthNamesShort");
         if(value == null)
         {
            monthSymbol = resourceManager.getString("SharedResources","monthSymbol");
            if(monthSymbol != " ")
            {
               n = !!_monthNamesShort ? int(_monthNamesShort.length) : 0;
               for(i = 0; i < n; i++)
               {
                  _monthNamesShort[i] += monthSymbol;
               }
            }
         }
      }
      
      public static function get timeOfDay() : Array
      {
         initialize();
         return _timeOfDay;
      }
      
      public static function set timeOfDay(value:Array) : void
      {
         timeOfDayOverride = value;
         var am:String = resourceManager.getString("formatters","am");
         var pm:String = resourceManager.getString("formatters","pm");
         _timeOfDay = value != null ? value : [am,pm];
      }
      
      public static function get timezoneName() : String
      {
         return _timezoneName;
      }
      
      public static function set timezoneName(value:String) : void
      {
         _timezoneName = value;
      }
      
      public static function get timezoneHourMinuteSeperator() : String
      {
         return _timezoneHourMinuteSeperator;
      }
      
      public static function set timezoneHourMinuteSeperator(value:String) : void
      {
         _timezoneHourMinuteSeperator = value;
      }
      
      private static function initialize() : void
      {
         if(!initialized)
         {
            resourceManager.addEventListener(Event.CHANGE,static_resourceManager_changeHandler,false,0,true);
            static_resourcesChanged();
            initialized = true;
         }
      }
      
      private static function static_resourcesChanged() : void
      {
         dayNamesLong = dayNamesLongOverride;
         dayNamesShort = dayNamesShortOverride;
         monthNamesLong = monthNamesLongOverride;
         monthNamesShort = monthNamesShortOverride;
         timeOfDay = timeOfDayOverride;
      }
      
      mx_internal static function extractTokenDate(date:Date, tokenInfo:Object) : String
      {
         var day:int = 0;
         var hours:int = 0;
         var year:String = null;
         var month:int = 0;
         var mins:int = 0;
         var sec:int = 0;
         var ms:int = 0;
         var offset:int = 0;
         var tzStr:String = null;
         initialize();
         var result:String = "";
         var key:int = int(tokenInfo.end) - int(tokenInfo.begin);
         switch(tokenInfo.token)
         {
            case "Y":
               year = date.getFullYear().toString();
               if(key < 3)
               {
                  return year.substr(2);
               }
               if(key > 4)
               {
                  return setValue(Number(year),key);
               }
               return year;
               break;
            case "M":
               month = int(date.getMonth());
               if(key < 3)
               {
                  month++;
                  return result + setValue(month,key);
               }
               if(key == 3)
               {
                  return monthNamesShort[month];
               }
               return monthNamesLong[month];
               break;
            case "D":
               day = int(date.getDate());
               return result + setValue(day,key);
            case "E":
               day = int(date.getDay());
               if(key < 3)
               {
                  return result + setValue(day,key);
               }
               if(key == 3)
               {
                  return dayNamesShort[day];
               }
               return dayNamesLong[day];
               break;
            case "A":
               hours = int(date.getHours());
               if(hours < 12)
               {
                  return timeOfDay[0];
               }
               return timeOfDay[1];
               break;
            case "H":
               hours = int(date.getHours());
               if(hours == 0)
               {
                  hours = 24;
               }
               return result + setValue(hours,key);
            case "J":
               hours = int(date.getHours());
               return result + setValue(hours,key);
            case "K":
               hours = int(date.getHours());
               if(hours >= 12)
               {
                  hours -= 12;
               }
               return result + setValue(hours,key);
            case "L":
               hours = int(date.getHours());
               if(hours == 0)
               {
                  hours = 12;
               }
               else if(hours > 12)
               {
                  hours -= 12;
               }
               return result + setValue(hours,key);
            case "N":
               mins = int(date.getMinutes());
               return result + setValue(mins,key);
            case "S":
               sec = int(date.getSeconds());
               return result + setValue(sec,key);
            case "Q":
               ms = int(date.getMilliseconds());
               return result + setValue(ms,key);
            case "Z":
               return result + timezoneName;
            case "O":
               offset = -1 * int(date.timezoneOffset);
               hours = offset / 60;
               mins = offset - hours * 60;
               tzStr = "";
               if(key <= 2 && mins == 0)
               {
                  tzStr += setValue(hours,key);
               }
               else
               {
                  tzStr += setValue(hours,key - 2) + timezoneHourMinuteSeperator + setValue(mins,2);
               }
               if(offset >= 0)
               {
                  tzStr = "+" + tzStr;
               }
               return result + tzStr;
            default:
               return result;
         }
      }
      
      private static function setValue(value:Object, key:int) : String
      {
         var n:int = 0;
         var i:int = 0;
         var result:* = "";
         var vLen:int = value.toString().length;
         if(vLen < key)
         {
            n = key - vLen;
            for(i = 0; i < n; i++)
            {
               result += "0";
            }
         }
         return result + value.toString();
      }
      
      private static function static_resourceManager_changeHandler(event:Event) : void
      {
         static_resourcesChanged();
      }
   }
}
