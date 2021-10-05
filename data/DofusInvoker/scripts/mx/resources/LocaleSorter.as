package mx.resources
{
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   [ExcludeClass]
   public class LocaleSorter
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
       
      
      public function LocaleSorter()
      {
         super();
      }
      
      public static function sortLocalesByPreference(appLocales:Array, systemPreferences:Array, ultimateFallbackLocale:String = null, addAll:Boolean = false) : Array
      {
         var result:Array = null;
         var hasLocale:Object = null;
         var i:int = 0;
         var j:int = 0;
         var plocale:LocaleID = null;
         var promote:Function = function(locale:String):void
         {
            if(typeof hasLocale[locale] != "undefined")
            {
               result.push(appLocales[hasLocale[locale]]);
               delete hasLocale[locale];
            }
         };
         result = [];
         hasLocale = {};
         var locales:Array = trimAndNormalize(appLocales);
         var preferenceLocales:Array = trimAndNormalize(systemPreferences);
         addUltimateFallbackLocale(preferenceLocales,ultimateFallbackLocale);
         var noLocales:int = locales.length;
         var noPreferenceLocales:int = preferenceLocales.length;
         for(j = 0; j < noLocales; j++)
         {
            hasLocale[locales[j]] = j;
         }
         var preferenceLocalesID:Vector.<LocaleID> = new Vector.<LocaleID>(noPreferenceLocales);
         for(i = 0; i < noPreferenceLocales; i++)
         {
            preferenceLocalesID[i] = LocaleID.fromString(preferenceLocales[i]);
         }
         var localesID:Vector.<LocaleID> = new Vector.<LocaleID>(noLocales);
         for(i = 0; i < noLocales; i++)
         {
            localesID[i] = LocaleID.fromString(locales[i]);
         }
         for(i = 0; i < noPreferenceLocales; i++)
         {
            plocale = preferenceLocalesID[i].clone();
            promote(preferenceLocales[i]);
            promote(plocale.toString());
            while(plocale.transformToParent())
            {
               promote(plocale.toString());
            }
            plocale = preferenceLocalesID[i].clone();
            for(j = 0; j < noPreferenceLocales; j++)
            {
               if(plocale.isSiblingOf(preferenceLocalesID[j]))
               {
                  promote(preferenceLocales[j]);
               }
            }
            for(j = 0; j < noLocales; j++)
            {
               if(plocale.isSiblingOf(localesID[j]))
               {
                  promote(locales[j]);
               }
            }
         }
         if(addAll)
         {
            for(j = 0; j < noLocales; j++)
            {
               promote(locales[j]);
            }
         }
         return result;
      }
      
      private static function trimAndNormalize(list:Array) : Array
      {
         var resultList:Array = [];
         for(var i:int = 0; i < list.length; i++)
         {
            resultList.push(normalizeLocale(list[i]));
         }
         return resultList;
      }
      
      private static function normalizeLocale(locale:String) : String
      {
         return locale.toLowerCase().replace(/-/g,"_");
      }
      
      private static function addUltimateFallbackLocale(preferenceLocales:Array, ultimateFallbackLocale:String) : void
      {
         var locale:String = null;
         if(ultimateFallbackLocale != null && ultimateFallbackLocale != "")
         {
            locale = normalizeLocale(ultimateFallbackLocale);
            if(preferenceLocales.indexOf(locale) == -1)
            {
               preferenceLocales.push(locale);
            }
         }
      }
   }
}

class LocaleID
{
   
   public static const STATE_PRIMARY_LANGUAGE:int = 0;
   
   public static const STATE_EXTENDED_LANGUAGES:int = 1;
   
   public static const STATE_SCRIPT:int = 2;
   
   public static const STATE_REGION:int = 3;
   
   public static const STATE_VARIANTS:int = 4;
   
   public static const STATE_EXTENSIONS:int = 5;
   
   public static const STATE_PRIVATES:int = 6;
    
   
   private var lang:String = "";
   
   private var script:String = "";
   
   private var region:String = "";
   
   private var extended_langs:Array;
   
   private var variants:Array;
   
   private var extensions:Object;
   
   private var privates:Array;
   
   private var privateLangs:Boolean = false;
   
   function LocaleID()
   {
      this.extended_langs = [];
      this.variants = [];
      this.extensions = {};
      this.privates = [];
      super();
   }
   
   private static function appendElements(dest:Array, src:Array) : void
   {
      for(var i:uint = 0,var argc:uint = src.length; i < argc; i++)
      {
         dest.push(src[i]);
      }
   }
   
   public static function fromString(str:String) : LocaleID
   {
      var last_extension:Array = null;
      var subtag:String = null;
      var subtag_length:int = 0;
      var firstChar:String = null;
      var localeID:LocaleID = new LocaleID();
      var state:int = STATE_PRIMARY_LANGUAGE;
      var subtags:Array = str.replace(/-/g,"_").split("_");
      for(var i:int = 0,var l:int = subtags.length; i < l; i++)
      {
         subtag = subtags[i].toLowerCase();
         if(state == STATE_PRIMARY_LANGUAGE)
         {
            if(subtag == "x")
            {
               localeID.privateLangs = true;
            }
            else if(subtag == "i")
            {
               localeID.lang += "i-";
            }
            else
            {
               localeID.lang += subtag;
               state = STATE_EXTENDED_LANGUAGES;
            }
         }
         else
         {
            subtag_length = subtag.length;
            if(subtag_length != 0)
            {
               firstChar = subtag.charAt(0).toLowerCase();
               if(state <= STATE_EXTENDED_LANGUAGES && subtag_length == 3)
               {
                  localeID.extended_langs.push(subtag);
                  if(localeID.extended_langs.length == 3)
                  {
                     state = STATE_SCRIPT;
                  }
               }
               else if(state <= STATE_SCRIPT && subtag_length == 4)
               {
                  localeID.script = subtag;
                  state = STATE_REGION;
               }
               else if(state <= STATE_REGION && (subtag_length == 2 || subtag_length == 3))
               {
                  localeID.region = subtag;
                  state = STATE_VARIANTS;
               }
               else if(state <= STATE_VARIANTS && (firstChar >= "a" && firstChar <= "z" && subtag_length >= 5 || firstChar >= "0" && firstChar <= "9" && subtag_length >= 4))
               {
                  localeID.variants.push(subtag);
                  state = STATE_VARIANTS;
               }
               else if(state < STATE_PRIVATES && subtag_length == 1)
               {
                  if(subtag == "x")
                  {
                     state = STATE_PRIVATES;
                     last_extension = localeID.privates;
                  }
                  else
                  {
                     state = STATE_EXTENSIONS;
                     last_extension = localeID.extensions[subtag] || [];
                     localeID.extensions[subtag] = last_extension;
                  }
               }
               else if(state >= STATE_EXTENSIONS)
               {
                  last_extension.push(subtag);
               }
            }
         }
      }
      localeID.canonicalize();
      return localeID;
   }
   
   public function clone() : LocaleID
   {
      var i:* = null;
      var copy:LocaleID = new LocaleID();
      copy.lang = this.lang;
      copy.script = this.script;
      copy.region = this.region;
      copy.extended_langs = this.extended_langs.concat();
      copy.variants = this.variants.concat();
      copy.extensions = {};
      for(i in this.extensions)
      {
         if(this.extensions.hasOwnProperty(i))
         {
            copy.extensions[i] = this.extensions[i].concat();
         }
      }
      copy.privates = this.privates.concat();
      copy.privateLangs = this.privateLangs;
      return copy;
   }
   
   public function canonicalize() : void
   {
      var i:* = null;
      for(i in this.extensions)
      {
         if(this.extensions.hasOwnProperty(i))
         {
            if(this.extensions[i].length == 0)
            {
               delete this.extensions[i];
            }
            else
            {
               this.extensions[i] = this.extensions[i].sort();
            }
         }
      }
      this.extended_langs = this.extended_langs.sort();
      this.variants = this.variants.sort();
      this.privates = this.privates.sort();
      if(this.script == "")
      {
         this.script = LocaleRegistry.getScriptByLang(this.lang);
      }
      if(this.script == "" && this.region != "")
      {
         this.script = LocaleRegistry.getScriptByLangAndRegion(this.lang,this.region);
      }
      if(this.region == "" && this.script != "")
      {
         this.region = LocaleRegistry.getDefaultRegionForLangAndScript(this.lang,this.script);
      }
   }
   
   public function toString() : String
   {
      var i:* = null;
      var stack:Array = [this.lang];
      appendElements(stack,this.extended_langs);
      if(this.script != "")
      {
         stack.push(this.script);
      }
      if(this.region != "")
      {
         stack.push(this.region);
      }
      appendElements(stack,this.variants);
      for(i in this.extensions)
      {
         if(this.extensions.hasOwnProperty(i))
         {
            stack.push(i);
            appendElements(stack,this.extensions[i]);
         }
      }
      if(this.privates.length > 0)
      {
         stack.push("x");
         appendElements(stack,this.privates);
      }
      return stack.join("_");
   }
   
   public function equals(locale:LocaleID) : Boolean
   {
      return this.toString() == locale.toString();
   }
   
   public function isSiblingOf(other:LocaleID) : Boolean
   {
      return this.lang == other.lang && this.script == other.script;
   }
   
   public function transformToParent() : Boolean
   {
      var i:* = null;
      var lastExtension:Array = null;
      var defaultRegion:String = null;
      if(this.privates.length > 0)
      {
         this.privates.splice(this.privates.length - 1,1);
         return true;
      }
      var lastExtensionName:String = null;
      for(i in this.extensions)
      {
         if(this.extensions.hasOwnProperty(i))
         {
            lastExtensionName = i;
         }
      }
      if(lastExtensionName)
      {
         lastExtension = this.extensions[lastExtensionName];
         if(lastExtension.length == 1)
         {
            delete this.extensions[lastExtensionName];
            return true;
         }
         lastExtension.splice(lastExtension.length - 1,1);
         return true;
      }
      if(this.variants.length > 0)
      {
         this.variants.splice(this.variants.length - 1,1);
         return true;
      }
      if(this.script != "")
      {
         if(LocaleRegistry.getScriptByLang(this.lang) != "")
         {
            this.script = "";
            return true;
         }
         if(this.region == "")
         {
            defaultRegion = LocaleRegistry.getDefaultRegionForLangAndScript(this.lang,this.script);
            if(defaultRegion != "")
            {
               this.region = defaultRegion;
               this.script = "";
               return true;
            }
         }
      }
      if(this.region != "")
      {
         if(!(this.script == "" && LocaleRegistry.getScriptByLang(this.lang) == ""))
         {
            this.region = "";
            return true;
         }
      }
      if(this.extended_langs.length > 0)
      {
         this.extended_langs.splice(this.extended_langs.length - 1,1);
         return true;
      }
      return false;
   }
}

class LocaleRegistry
{
   
   private static const SCRIPTS:Array = ["","latn","ethi","arab","beng","cyrl","thaa","tibt","grek","gujr","hebr","deva","armn","jpan","geor","khmr","knda","kore","laoo","mlym","mymr","orya","guru","sinh","taml","telu","thai","nkoo","blis","hans","hant","mong","syrc"];
   
   private static const SCRIPT_BY_ID:Object = {
      "latn":1,
      "ethi":2,
      "arab":3,
      "beng":4,
      "cyrl":5,
      "thaa":6,
      "tibt":7,
      "grek":8,
      "gujr":9,
      "hebr":10,
      "deva":11,
      "armn":12,
      "jpan":13,
      "geor":14,
      "khmr":15,
      "knda":16,
      "kore":17,
      "laoo":18,
      "mlym":19,
      "mymr":20,
      "orya":21,
      "guru":22,
      "sinh":23,
      "taml":24,
      "telu":25,
      "thai":26,
      "nkoo":27,
      "blis":28,
      "hans":29,
      "hant":30,
      "mong":31,
      "syrc":32
   };
   
   private static const DEFAULT_REGION_BY_LANG_AND_SCRIPT:Object = {
      "bg":{5:"bg"},
      "ca":{1:"es"},
      "zh":{
         30:"tw",
         29:"cn"
      },
      "cs":{1:"cz"},
      "da":{1:"dk"},
      "de":{1:"de"},
      "el":{8:"gr"},
      "en":{1:"us"},
      "es":{1:"es"},
      "fi":{1:"fi"},
      "fr":{1:"fr"},
      "he":{10:"il"},
      "hu":{1:"hu"},
      "is":{1:"is"},
      "it":{1:"it"},
      "ja":{13:"jp"},
      "ko":{17:"kr"},
      "nl":{1:"nl"},
      "nb":{1:"no"},
      "pl":{1:"pl"},
      "pt":{1:"br"},
      "ro":{1:"ro"},
      "ru":{5:"ru"},
      "hr":{1:"hr"},
      "sk":{1:"sk"},
      "sq":{1:"al"},
      "sv":{1:"se"},
      "th":{26:"th"},
      "tr":{1:"tr"},
      "ur":{3:"pk"},
      "id":{1:"id"},
      "uk":{5:"ua"},
      "be":{5:"by"},
      "sl":{1:"si"},
      "et":{1:"ee"},
      "lv":{1:"lv"},
      "lt":{1:"lt"},
      "fa":{3:"ir"},
      "vi":{1:"vn"},
      "hy":{12:"am"},
      "az":{
         1:"az",
         5:"az"
      },
      "eu":{1:"es"},
      "mk":{5:"mk"},
      "af":{1:"za"},
      "ka":{14:"ge"},
      "fo":{1:"fo"},
      "hi":{11:"in"},
      "ms":{1:"my"},
      "kk":{5:"kz"},
      "ky":{5:"kg"},
      "sw":{1:"ke"},
      "uz":{
         1:"uz",
         5:"uz"
      },
      "tt":{5:"ru"},
      "pa":{22:"in"},
      "gu":{9:"in"},
      "ta":{24:"in"},
      "te":{25:"in"},
      "kn":{16:"in"},
      "mr":{11:"in"},
      "sa":{11:"in"},
      "mn":{5:"mn"},
      "gl":{1:"es"},
      "kok":{11:"in"},
      "syr":{32:"sy"},
      "dv":{6:"mv"},
      "nn":{1:"no"},
      "sr":{
         1:"cs",
         5:"cs"
      },
      "cy":{1:"gb"},
      "mi":{1:"nz"},
      "mt":{1:"mt"},
      "quz":{1:"bo"},
      "tn":{1:"za"},
      "xh":{1:"za"},
      "zu":{1:"za"},
      "nso":{1:"za"},
      "se":{1:"no"},
      "smj":{1:"no"},
      "sma":{1:"no"},
      "sms":{1:"fi"},
      "smn":{1:"fi"},
      "bs":{1:"ba"}
   };
   
   private static const SCRIPT_ID_BY_LANG:Object = {
      "ab":5,
      "af":1,
      "am":2,
      "ar":3,
      "as":4,
      "ay":1,
      "be":5,
      "bg":5,
      "bn":4,
      "bs":1,
      "ca":1,
      "ch":1,
      "cs":1,
      "cy":1,
      "da":1,
      "de":1,
      "dv":6,
      "dz":7,
      "el":8,
      "en":1,
      "eo":1,
      "es":1,
      "et":1,
      "eu":1,
      "fa":3,
      "fi":1,
      "fj":1,
      "fo":1,
      "fr":1,
      "frr":1,
      "fy":1,
      "ga":1,
      "gl":1,
      "gn":1,
      "gu":9,
      "gv":1,
      "he":10,
      "hi":11,
      "hr":1,
      "ht":1,
      "hu":1,
      "hy":12,
      "id":1,
      "in":1,
      "is":1,
      "it":1,
      "iw":10,
      "ja":13,
      "ka":14,
      "kk":5,
      "kl":1,
      "km":15,
      "kn":16,
      "ko":17,
      "la":1,
      "lb":1,
      "ln":1,
      "lo":18,
      "lt":1,
      "lv":1,
      "mg":1,
      "mh":1,
      "mk":5,
      "ml":19,
      "mo":1,
      "mr":11,
      "ms":1,
      "mt":1,
      "my":20,
      "na":1,
      "nb":1,
      "nd":1,
      "ne":11,
      "nl":1,
      "nn":1,
      "no":1,
      "nr":1,
      "ny":1,
      "om":1,
      "or":21,
      "pa":22,
      "pl":1,
      "ps":3,
      "pt":1,
      "qu":1,
      "rn":1,
      "ro":1,
      "ru":5,
      "rw":1,
      "sg":1,
      "si":23,
      "sk":1,
      "sl":1,
      "sm":1,
      "so":1,
      "sq":1,
      "ss":1,
      "st":1,
      "sv":1,
      "sw":1,
      "ta":24,
      "te":25,
      "th":26,
      "ti":2,
      "tl":1,
      "tn":1,
      "to":1,
      "tr":1,
      "ts":1,
      "uk":5,
      "ur":3,
      "ve":1,
      "vi":1,
      "wo":1,
      "xh":1,
      "yi":10,
      "zu":1,
      "cpe":1,
      "dsb":1,
      "frs":1,
      "gsw":1,
      "hsb":1,
      "kok":11,
      "mai":11,
      "men":1,
      "nds":1,
      "niu":1,
      "nqo":27,
      "nso":1,
      "son":1,
      "tem":1,
      "tkl":1,
      "tmh":1,
      "tpi":1,
      "tvl":1,
      "zbl":28
   };
   
   private static const SCRIPT_ID_BY_LANG_AND_REGION:Object = {
      "zh":{
         "cn":29,
         "sg":29,
         "tw":30,
         "hk":30,
         "mo":30
      },
      "mn":{
         "cn":31,
         "sg":5
      },
      "pa":{
         "pk":3,
         "in":22
      },
      "ha":{
         "gh":1,
         "ne":1
      }
   };
    
   
   function LocaleRegistry()
   {
      super();
   }
   
   public static function getScriptByLangAndRegion(lang:String, region:String) : String
   {
      var langRegions:Object = SCRIPT_ID_BY_LANG_AND_REGION[lang];
      if(langRegions == null)
      {
         return "";
      }
      var scriptID:Object = langRegions[region];
      if(scriptID == null)
      {
         return "";
      }
      return SCRIPTS[int(scriptID)].toLowerCase();
   }
   
   public static function getScriptByLang(lang:String) : String
   {
      var scriptID:Object = SCRIPT_ID_BY_LANG[lang];
      if(scriptID == null)
      {
         return "";
      }
      return SCRIPTS[int(scriptID)].toLowerCase();
   }
   
   public static function getDefaultRegionForLangAndScript(lang:String, script:String) : String
   {
      var langObj:Object = DEFAULT_REGION_BY_LANG_AND_SCRIPT[lang];
      var scriptID:Object = SCRIPT_BY_ID[script];
      if(langObj == null || scriptID == null)
      {
         return "";
      }
      return langObj[int(scriptID)] || "";
   }
}
