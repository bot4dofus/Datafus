package com.ankamagames.dofus.logic.game.common.managers
{
   import com.ankamagames.dofus.datacenter.misc.Month;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   import flash.globalization.DateTimeFormatter;
   import flash.globalization.DateTimeNameContext;
   import flash.globalization.DateTimeNameStyle;
   import flash.utils.getQualifiedClassName;
   
   public class TimeManager implements IDestroyable
   {
      
      private static var _self:TimeManager;
       
      
      protected var _log:Logger;
      
      private var _bTextInit:Boolean = false;
      
      private var _nameYears:String;
      
      private var _nameMonths:String;
      
      private var _nameDays:String;
      
      private var _nameHours:String;
      
      private var _nameMinutes:String;
      
      private var _nameSeconds:String;
      
      private var _nameYearsShort:String;
      
      private var _nameMonthsShort:String;
      
      private var _nameDaysShort:String;
      
      private var _nameHoursShort:String;
      
      private var _nameAnd:String;
      
      public var serverTimeLag:Number = 0;
      
      public var serverUtcTimeLag:Number = 0;
      
      public var timezoneOffset:Number = 0;
      
      public var dofusTimeYearLag:int = 0;
      
      public function TimeManager()
      {
         this._log = Log.getLogger(getQualifiedClassName(TimeManager));
         super();
         if(_self != null)
         {
            throw new SingletonError("TimeManager is a singleton and should not be instanciated directly.");
         }
      }
      
      public static function getInstance() : TimeManager
      {
         if(_self == null)
         {
            _self = new TimeManager();
         }
         return _self;
      }
      
      public function destroy() : void
      {
         _self = null;
      }
      
      public function reset() : void
      {
         this.serverTimeLag = 0;
         this.dofusTimeYearLag = 0;
         this.timezoneOffset = 0;
      }
      
      public function getTimestamp() : Number
      {
         var date:Date = new Date();
         return date.getTime() + this.serverTimeLag;
      }
      
      public function getUtcTimestamp() : Number
      {
         var date:Date = new Date();
         return date.getTime() + this.serverUtcTimeLag;
      }
      
      public function formatClock(time:Number, unchanged:Boolean = false, useTimezoneOffset:Boolean = false) : String
      {
         var timeToUse:Number = time;
         if(unchanged && timeToUse > 0)
         {
            timeToUse -= this.serverTimeLag;
         }
         var date:Array = this.getDateFromTime(timeToUse,useTimezoneOffset);
         var hour:String = date[1] >= 10 ? date[1].toString() : "0" + date[1];
         var minute:String = date[0] >= 10 ? date[0].toString() : "0" + date[0];
         return hour + ":" + minute;
      }
      
      public function formatDateIRL(time:Number, useTimezoneOffset:Boolean = false, unchanged:Boolean = false) : String
      {
         var timeToUse:Number = time;
         if(unchanged && timeToUse > 0)
         {
            timeToUse -= this.serverTimeLag;
         }
         var date:Array = this.getDateFromTime(timeToUse,useTimezoneOffset);
         var day:String = date[2] > 9 ? date[2].toString() : "0" + date[2];
         var month:String = date[3] > 9 ? date[3].toString() : "0" + date[3];
         return I18n.getUiText("ui.time.dateNumbers",[day,month,date[4]]);
      }
      
      public function getLocaleIDName() : String
      {
         var currentLanguage:String = LangManager.getInstance().lang;
         switch(currentLanguage)
         {
            case "deDe":
               return "de-DE";
            case "enUk":
               return "en-GB";
            case "enUs":
               return "en-US";
            case "esEs":
               return "es-ES";
            case "frBe":
               return "fr-BE";
            case "frCa":
               return "fr-CA";
            case "frCh":
               return "fr-CH";
            case "frFr":
               return "fr-FR";
            case "itIt":
               return "it-IT";
            case "jaJp":
               return "ja";
            case "nlNl":
               return "nl-NL";
            case "ptBr":
               return "pt-BR";
            case "ptPt":
               return "pt-PT";
            case "ruRu":
               return "ru";
            default:
               return "en-US";
         }
      }
      
      public function getMonthIRL(month:uint) : String
      {
         if(month > 11)
         {
            return null;
         }
         var dateTimeFormatter:DateTimeFormatter = new DateTimeFormatter(this.getLocaleIDName());
         var months:Vector.<String> = dateTimeFormatter.getMonthNames(DateTimeNameStyle.FULL,DateTimeNameContext.STANDALONE);
         return months[month];
      }
      
      public function formatEndOfSeasonDate(time:Number, useTimezoneOffset:Boolean = false, unchanged:Boolean = false) : String
      {
         var timeToUse:Number = time;
         if(unchanged && timeToUse > 0)
         {
            timeToUse -= this.serverTimeLag;
         }
         var date:Array = this.getDateFromTime(timeToUse,useTimezoneOffset);
         var day:String = date[2] > 9 ? date[2].toString() : "0" + date[2];
         var month:String = this.getMonthIRL(date[3] - 1);
         var hours:String = date[1];
         var minutes:String = StringUtils.padNumber(date[0],2);
         return I18n.getUiText("ui.time.endSeasonDate",[day,month,hours,minutes]);
      }
      
      public function formatDateIG(time:Number) : String
      {
         var date:Array = this.getDateFromTime(time);
         var nyear:Number = date[4] + this.dofusTimeYearLag;
         var month:String = Month.getMonthById(date[3] - 1).name;
         return I18n.getUiText("ui.time.dateLetters",[date[2],month,nyear]);
      }
      
      public function getDateIG(time:Number) : Array
      {
         var date:Array = this.getDateFromTime(time);
         var nyear:Number = date[4] + this.dofusTimeYearLag;
         var month:String = Month.getMonthById(date[3] - 1).name;
         return [date[2],month,nyear];
      }
      
      public function getDuration(time:Number, short:Boolean = false, addSeconds:Boolean = false) : String
      {
         var result:String = null;
         var hour:String = null;
         var minute:String = null;
         var second:String = null;
         var day:String = null;
         var month:String = null;
         var year:String = null;
         var nsecond:Number = NaN;
         if(!this._bTextInit)
         {
            this.initText();
         }
         var showSeconds:Boolean = false;
         var date:Date = new Date(time);
         var nyear:Number = date.getUTCFullYear() - 1970;
         var nmonth:Number = date.getUTCMonth();
         var nday:Number = date.getUTCDate() - 1;
         var nhour:Number = date.getUTCHours();
         var nminute:Number = date.getUTCMinutes();
         if(addSeconds || nyear == 0 && nmonth == 0 && nday == 0 && nhour == 0 && nminute == 0)
         {
            nsecond = date.getUTCSeconds();
            if(nsecond > 0 || addSeconds)
            {
               showSeconds = true;
            }
         }
         if(!short)
         {
            if(showSeconds)
            {
               second = nsecond + " " + PatternDecoder.combine(this._nameSeconds,"f",nsecond <= 1,nsecond == 0);
            }
            minute = nminute + " " + PatternDecoder.combine(this._nameMinutes,"f",nminute <= 1,nminute == 0);
            hour = nhour + " " + PatternDecoder.combine(this._nameHours,"f",nhour <= 1,nhour == 0);
            day = nday + " " + PatternDecoder.combine(this._nameDays,"f",nday <= 1,nday == 0);
            month = nmonth + " " + PatternDecoder.combine(this._nameMonths,"f",nmonth <= 1,nmonth == 0);
            year = nyear + " " + PatternDecoder.combine(this._nameYears,"f",nyear <= 1,nyear == 0);
            if(nyear != 0)
            {
               if(nmonth != 0)
               {
                  result = year + " " + this._nameAnd + " " + month;
               }
               else
               {
                  result = year;
               }
            }
            else if(nmonth != 0)
            {
               if(nday != 0)
               {
                  result = month + " " + this._nameAnd + " " + day;
               }
               else
               {
                  result = month;
               }
            }
            else if(nday != 0)
            {
               if(nhour != 0)
               {
                  result = day + " " + this._nameAnd + " " + hour;
               }
               else
               {
                  result = day;
               }
            }
            else if(nhour != 0)
            {
               if(nminute != 0)
               {
                  result = hour + " " + this._nameAnd + " " + minute;
               }
               else
               {
                  result = hour;
               }
            }
            else if(showSeconds && nsecond != 0)
            {
               if(nminute == 0)
               {
                  result = second;
               }
               else
               {
                  result = minute + " " + this._nameAnd + " " + second;
               }
            }
            else
            {
               result = minute;
            }
            return result;
         }
         if(nyear != 0)
         {
            if(nmonth != 0)
            {
               result = nyear + this._nameYearsShort + " " + nmonth + this._nameMonthsShort;
            }
            else
            {
               result = nyear + this._nameYearsShort;
            }
         }
         else if(nmonth != 0)
         {
            if(nday != 0)
            {
               result = nmonth + this._nameMonthsShort + " " + nday + this._nameDaysShort;
            }
            else
            {
               result = nmonth + this._nameMonthsShort;
            }
         }
         else if(nday != 0)
         {
            if(nhour != 0)
            {
               result = nday + this._nameDaysShort + " " + nhour + this._nameHoursShort;
            }
            else
            {
               result = nday + this._nameDaysShort;
            }
         }
         else
         {
            hour = nhour >= 10 ? nhour.toString() : "0" + nhour;
            minute = nminute >= 10 ? nminute.toString() : "0" + nminute;
            if(showSeconds)
            {
               second = nsecond >= 10 ? nsecond.toString() : "0" + nsecond;
               result = hour + ":" + minute + ":" + second;
            }
            else
            {
               result = hour + ":" + minute;
            }
         }
         return result;
      }
      
      public function getDateFromTime(timeUTC:Number, useTimezoneOffset:Boolean = false) : Array
      {
         var date:Date = null;
         var nday:Number = NaN;
         var nmonth:Number = NaN;
         var nyear:Number = NaN;
         var nhour:Number = NaN;
         var nminute:Number = NaN;
         var date0:Date = null;
         if(timeUTC == 0)
         {
            date0 = new Date();
            date = new Date(date0.getTime() + this.serverTimeLag);
         }
         else
         {
            date = new Date(timeUTC + this.serverTimeLag);
         }
         if(useTimezoneOffset)
         {
            nday = date.getDate();
            nmonth = date.getMonth() + 1;
            nyear = date.getFullYear();
            nhour = date.getHours();
            nminute = date.getMinutes();
         }
         else
         {
            nday = date.getUTCDate();
            nmonth = date.getUTCMonth() + 1;
            nyear = date.getUTCFullYear();
            nhour = date.getUTCHours();
            nminute = date.getUTCMinutes();
         }
         return [nminute,nhour,nday,nmonth,nyear];
      }
      
      private function initText() : void
      {
         this._nameYears = I18n.getUiText("ui.time.years");
         this._nameMonths = I18n.getUiText("ui.time.months");
         this._nameDays = I18n.getUiText("ui.time.days");
         this._nameHours = I18n.getUiText("ui.time.hours");
         this._nameMinutes = I18n.getUiText("ui.time.minutes");
         this._nameSeconds = I18n.getUiText("ui.time.seconds");
         this._nameYearsShort = I18n.getUiText("ui.time.short.year");
         this._nameMonthsShort = I18n.getUiText("ui.time.short.month");
         this._nameDaysShort = I18n.getUiText("ui.time.short.day");
         this._nameHoursShort = I18n.getUiText("ui.time.short.hour");
         this._nameAnd = I18n.getUiText("ui.common.and").toLowerCase();
         this._bTextInit = true;
      }
   }
}
