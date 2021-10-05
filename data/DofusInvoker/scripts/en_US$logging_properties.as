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
            "invalidTarget":"Invalid target specified.",
            "charsInvalid":"Error for filter \'{0}\': The following characters are not valid: []~$^&/(){}<>+=_-`!@#%?,:;\'\".",
            "charPlacement":"Error for filter \'{0}\': \'*\' must be the right most character.",
            "levelLimit":"Logging level cannot be set to LogEventLevel.ALL.",
            "invalidChars":"Categories can not contain any of the following characters: []`~,!@#$%*^&()]{}+=|\';?><./\".",
            "invalidLen":"Categories must be at least one character in length."
         };
      }
   }
}
