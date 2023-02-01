package com.ankamagames.jerakine.logger.targets
{
   import com.ankamagames.jerakine.logger.InvalidFilterError;
   import com.ankamagames.jerakine.logger.LogEvent;
   import com.ankamagames.jerakine.logger.LogTargetFilter;
   
   public class AbstractTarget implements LoggingTarget
   {
      
      private static const FILTERS_FORBIDDEN_CHARS:String = "[]~$^&/(){}<>+=`!#%?,:;\'\"@";
       
      
      private var _filters:Array;
      
      public function AbstractTarget()
      {
         this._filters = [];
         super();
      }
      
      private static function checkIsFiltersValid(filters:Array) : Boolean
      {
         var filter:LogTargetFilter = null;
         for each(filter in filters)
         {
            if(!checkIsFilterValid(filter.target))
            {
               return false;
            }
         }
         return true;
      }
      
      private static function checkIsFilterValid(filter:String) : Boolean
      {
         for(var i:int = 0; i < FILTERS_FORBIDDEN_CHARS.length; i++)
         {
            if(filter.indexOf(FILTERS_FORBIDDEN_CHARS.charAt(i)) > -1)
            {
               return false;
            }
         }
         return true;
      }
      
      public function set filters(value:Array) : void
      {
         if(!checkIsFiltersValid(value))
         {
            throw new InvalidFilterError("These characters are invalid on a filter : " + FILTERS_FORBIDDEN_CHARS);
         }
         this._filters = value;
      }
      
      public function get filters() : Array
      {
         return this._filters;
      }
      
      public function logEvent(event:LogEvent) : void
      {
      }
      
      public function onLog(e:LogEvent) : void
      {
         var filter:LogTargetFilter = null;
         var reg:RegExp = null;
         var testResult:Boolean = false;
         var passing:Boolean = false;
         if(this._filters.length > 0)
         {
            for each(filter in this._filters)
            {
               reg = new RegExp(filter.target.replace("*",".*"),"i");
               testResult = reg.test(e.category);
               if(e.category == filter.target && !filter.allow)
               {
                  passing = false;
                  break;
               }
               if(testResult && filter.allow)
               {
                  passing = true;
               }
            }
         }
         else
         {
            passing = true;
         }
         if(passing)
         {
            this.logEvent(e);
         }
      }
   }
}
