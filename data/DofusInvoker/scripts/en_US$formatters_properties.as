package
{
   import mx.resources.ResourceBundle;
   
   [ExcludeClass]
   public class en_US$formatters_properties extends ResourceBundle
   {
       
      
      public function en_US$formatters_properties()
      {
         super("en_US","formatters");
      }
      
      override protected function getContent() : Object
      {
         return {
            "zipCodeFormat":"#####",
            "useNegativeSignInCurrency":"true",
            "useNegativeSignInNumber":"true",
            "defaultInvalidFormatError":"Invalid format",
            "pm":"PM",
            "useThousandsSeparator":"true",
            "am":"AM",
            "areaCode":"-1",
            "validPatternChars":"+()#- .",
            "phoneNumberFormat":"(###) ###-####",
            "defaultInvalidValueError":"Invalid value",
            "areaCodeFormat":"(###)",
            "monthNamesShort":"Jan,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,Dec",
            "numberFormatterPrecision":"-1",
            "dayNamesShort":"Sun,Mon,Tue,Wed,Thu,Fri,Sat",
            "rounding":"none",
            "currencyFormatterPrecision":"-1"
         };
      }
   }
}
