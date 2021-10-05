package flashx.textLayout.property
{
   import flashx.textLayout.elements.ListElement;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   [ExcludeClass]
   public class CounterContentHandler extends PropertyHandler
   {
      
      private static const _counterContentPattern1:RegExp = /^\s*counter\s*\(\s*ordered\s*\)\s*$/;
      
      private static const _counterContentPattern2:RegExp = /^\s*counter\s*\(\s*ordered\s*,\s*\S+\s*\)\s*$/;
      
      private static const _countersContentPattern1:RegExp = /^\s*counters\s*\(\s*ordered\s*\)\s*$/;
      
      private static const _countersContentPattern2:RegExp = /^\s*counters\s*\(\s*ordered\s*,\s*".*"\s*\)\s*$/;
      
      private static const _countersContentPattern3:RegExp = /^\s*counters\s*\(\s*ordered\s*,\s*".*"\s*,\s*\S+\s*\)\s*$/;
      
      private static const _counterBeginPattern:RegExp = /^\s*counter\s*\(\s*ordered\s*,\s*/g;
      
      private static const _trailingStuff:RegExp = /\s*\)\s*/g;
      
      private static const _countersTillSuffixPattern:RegExp = /^\s*counters\s*\(\s*ordered\s*,\s*"/g;
      
      private static const _afterSuffixPattern2:RegExp = /^"\s*\)\s*$/;
      
      private static const _afterSuffixPattern3:RegExp = /^"\s*,\s*\S+\s*\)\s*$/;
      
      private static const _countersTillListStyleTypePattern:RegExp = /^\s*counters\s*\(\s*ordered\s*,\s*".*"\s*,\s*/g;
       
      
      public function CounterContentHandler()
      {
         super();
      }
      
      tlf_internal static function extractListStyleTypeFromCounter(s:String) : String
      {
         _counterBeginPattern.lastIndex = 0;
         _counterBeginPattern.test(s);
         s = s.substr(_counterBeginPattern.lastIndex);
         _trailingStuff.lastIndex = 0;
         _trailingStuff.test(s);
         return s.substr(0,_trailingStuff.lastIndex - 1);
      }
      
      tlf_internal static function extractSuffixFromCounters2(s:String) : String
      {
         _countersTillSuffixPattern.lastIndex = 0;
         _countersTillSuffixPattern.test(s);
         s = s.substr(_countersTillSuffixPattern.lastIndex);
         var rslt:String = "";
         while(!_afterSuffixPattern2.test(s))
         {
            rslt += s.substr(0,1);
            s = s.substr(1);
         }
         return rslt;
      }
      
      tlf_internal static function extractSuffixFromCounters3(s:String) : String
      {
         _countersTillSuffixPattern.lastIndex = 0;
         _countersTillSuffixPattern.test(s);
         s = s.substr(_countersTillSuffixPattern.lastIndex);
         var rslt:String = "";
         while(!_afterSuffixPattern3.test(s))
         {
            rslt += s.substr(0,1);
            s = s.substr(1);
         }
         return rslt;
      }
      
      tlf_internal static function extractListStyleTypeFromCounters(s:String) : String
      {
         _countersTillListStyleTypePattern.lastIndex = 0;
         _countersTillListStyleTypePattern.test(s);
         s = s.substr(_countersTillListStyleTypePattern.lastIndex);
         _trailingStuff.lastIndex = 0;
         _trailingStuff.test(s);
         return s.substr(0,_trailingStuff.lastIndex - 1);
      }
      
      override public function get customXMLStringHandler() : Boolean
      {
         return true;
      }
      
      override public function toXMLString(val:Object) : String
      {
         var rslt:String = null;
         if(val.hasOwnProperty("counter"))
         {
            return val.ordered == null ? "counter(ordered)" : "counter(ordered," + val.ordered + ")";
         }
         if(val.hasOwnProperty("counters"))
         {
            rslt = "counters(ordered";
            if(val.suffix != null)
            {
               rslt += ",\"" + val.suffix + "\"";
               if(val.ordered)
               {
                  rslt += "," + val.ordered;
               }
            }
            return rslt + ")";
         }
         return val.toString();
      }
      
      override public function owningHandlerCheck(newVal:*) : *
      {
         var listStyleType:String = null;
         if(!(newVal is String))
         {
            return newVal.hasOwnProperty("counter") || newVal.hasOwnProperty("counters") ? newVal : undefined;
         }
         if(_counterContentPattern1.test(newVal))
         {
            return newVal;
         }
         if(_counterContentPattern2.test(newVal))
         {
            listStyleType = extractListStyleTypeFromCounter(newVal);
            return ListElement.listSuffixes[listStyleType] !== undefined ? newVal : undefined;
         }
         if(_countersContentPattern1.test(newVal))
         {
            return newVal;
         }
         if(_countersContentPattern2.test(newVal))
         {
            return newVal;
         }
         if(_countersContentPattern3.test(newVal))
         {
            listStyleType = extractListStyleTypeFromCounters(newVal);
            return ListElement.listSuffixes[listStyleType] !== undefined ? newVal : undefined;
         }
         return undefined;
      }
      
      override public function setHelper(newVal:*) : *
      {
         var listStyleType:String = null;
         var suffix:String = null;
         var s:String = newVal as String;
         if(s == null)
         {
            return newVal;
         }
         if(_counterContentPattern1.test(newVal))
         {
            return {"counter":"ordered"};
         }
         if(_counterContentPattern2.test(newVal))
         {
            listStyleType = extractListStyleTypeFromCounter(newVal);
            return {
               "counter":"ordered",
               "ordered":listStyleType
            };
         }
         if(_countersContentPattern1.test(newVal))
         {
            return {"counters":"ordered"};
         }
         if(_countersContentPattern2.test(newVal))
         {
            suffix = extractSuffixFromCounters2(newVal);
            return {
               "counters":"ordered",
               "suffix":suffix
            };
         }
         if(_countersContentPattern3.test(newVal))
         {
            listStyleType = extractListStyleTypeFromCounters(newVal);
            suffix = extractSuffixFromCounters3(newVal);
            return {
               "counters":"ordered",
               "suffix":suffix,
               "ordered":listStyleType
            };
         }
         return undefined;
      }
   }
}
