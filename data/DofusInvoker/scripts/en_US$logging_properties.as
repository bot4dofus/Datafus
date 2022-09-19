package
{
   import mx.resources.ResourceBundle;
   
   [ExcludeClass]
   public class en_US$logging_properties extends ResourceBundle
   {
       
      
      public function en_US$logging_properties()
      {
         super("en_US","logging");
      }
      
      override protected function getContent() : Object
      {
         return {
            "levelLimit":"Logging level cannot be set to LogEventLevel.ALL.",
            "invalidLen":"Categories must be at least one character in length.",
            "charsInvalid":"Error for filter \'{0}\': The following characters are not valid: []~$^&/(){}<>+=_-`!@#%?,:;\'\".",
            "invalidTarget":"Invalid target specified.",
            "invalidChars":"Categories can not contain any of the following characters: []`~,!@#$%*^&()]{}+=|\';?><./\".",
            "charPlacement":"Error for filter \'{0}\': \'*\' must be the right most character."
         };
      }
   }
}
