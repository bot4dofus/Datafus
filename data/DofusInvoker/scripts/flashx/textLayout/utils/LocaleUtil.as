package flashx.textLayout.utils
{
   import flash.text.engine.JustificationStyle;
   import flash.text.engine.TextBaseline;
   import flash.utils.Dictionary;
   import flashx.textLayout.formats.JustificationRule;
   import flashx.textLayout.formats.LeadingModel;
   import flashx.textLayout.tlf_internal;
   
   use namespace tlf_internal;
   
   [ExcludeClass]
   public final class LocaleUtil
   {
      
      private static var _localeSettings:Dictionary = null;
      
      private static var _lastLocaleKey:String = "";
      
      private static var _lastLocale:LocaleSettings = null;
       
      
      public function LocaleUtil()
      {
         super();
      }
      
      public static function justificationRule(locale:String) : String
      {
         var localeSet:LocaleSettings = fetchLocaleSet(locale);
         return localeSet.justificationRule;
      }
      
      public static function justificationStyle(locale:String) : String
      {
         var localeSet:LocaleSettings = fetchLocaleSet(locale);
         return localeSet.justificationStyle;
      }
      
      public static function leadingModel(locale:String) : String
      {
         var localeSet:LocaleSettings = fetchLocaleSet(locale);
         return localeSet.leadingModel;
      }
      
      public static function dominantBaseline(locale:String) : String
      {
         var localeSet:LocaleSettings = fetchLocaleSet(locale);
         return localeSet.dominantBaseline;
      }
      
      private static function addLocale(locale:String) : LocaleSettings
      {
         _localeSettings[locale] = new LocaleSettings();
         return _localeSettings[locale];
      }
      
      private static function initializeDefaultLocales() : void
      {
         _localeSettings = new Dictionary();
         var locale:LocaleSettings = addLocale("en");
         locale.justificationRule = JustificationRule.SPACE;
         locale.justificationStyle = JustificationStyle.PUSH_IN_KINSOKU;
         locale.leadingModel = LeadingModel.ROMAN_UP;
         locale.dominantBaseline = TextBaseline.ROMAN;
         locale = addLocale("ja");
         locale.justificationRule = JustificationRule.EAST_ASIAN;
         locale.justificationStyle = JustificationStyle.PUSH_IN_KINSOKU;
         locale.leadingModel = LeadingModel.IDEOGRAPHIC_TOP_DOWN;
         locale.dominantBaseline = TextBaseline.IDEOGRAPHIC_CENTER;
         locale = addLocale("zh");
         locale.justificationRule = JustificationRule.EAST_ASIAN;
         locale.justificationStyle = JustificationStyle.PUSH_IN_KINSOKU;
         locale.leadingModel = LeadingModel.IDEOGRAPHIC_TOP_DOWN;
         locale.dominantBaseline = TextBaseline.IDEOGRAPHIC_CENTER;
      }
      
      private static function getLocale(locale:String) : LocaleSettings
      {
         var lowerLocale:String = locale.toLowerCase().substr(0,2);
         var rslt:LocaleSettings = _localeSettings[lowerLocale];
         return rslt == null ? _localeSettings["en"] : rslt;
      }
      
      private static function fetchLocaleSet(locale:String) : LocaleSettings
      {
         if(_localeSettings == null)
         {
            initializeDefaultLocales();
         }
         if(locale == _lastLocaleKey)
         {
            return _lastLocale;
         }
         var localeSet:LocaleSettings = getLocale(locale);
         _lastLocale = localeSet;
         _lastLocaleKey = locale;
         return localeSet;
      }
   }
}

import flashx.textLayout.formats.TextLayoutFormat;

class LocaleSettings
{
    
   
   private var _justificationRule:String = null;
   
   private var _justificationStyle:String = null;
   
   private var _leadingModel:String = null;
   
   private var _dominantBaseline:String = null;
   
   function LocaleSettings()
   {
      super();
   }
   
   public function get justificationRule() : String
   {
      return this._justificationRule;
   }
   
   public function set justificationRule(newValue:String) : void
   {
      var setValue:Object = TextLayoutFormat.justificationRuleProperty.setHelper(this._justificationRule,newValue);
      this._justificationRule = setValue == null ? null : setValue as String;
   }
   
   public function get justificationStyle() : String
   {
      return this._justificationStyle;
   }
   
   public function set justificationStyle(newValue:String) : void
   {
      var setValue:Object = TextLayoutFormat.justificationStyleProperty.setHelper(this._justificationStyle,newValue);
      this._justificationStyle = setValue == null ? null : setValue as String;
   }
   
   public function get leadingModel() : String
   {
      return this._leadingModel;
   }
   
   public function set leadingModel(newValue:String) : void
   {
      var setValue:Object = TextLayoutFormat.leadingModelProperty.setHelper(this._leadingModel,newValue);
      this._leadingModel = setValue == null ? null : setValue as String;
   }
   
   public function get dominantBaseline() : String
   {
      return this._dominantBaseline;
   }
   
   public function set dominantBaseline(newValue:String) : void
   {
      var setValue:Object = TextLayoutFormat.dominantBaselineProperty.setHelper(this._dominantBaseline,newValue);
      this._dominantBaseline = setValue == null ? null : setValue as String;
   }
}
