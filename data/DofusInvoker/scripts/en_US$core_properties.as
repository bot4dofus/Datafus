package
{
   import mx.resources.ResourceBundle;
   
   [ExcludeClass]
   public class en_US$core_properties extends ResourceBundle
   {
       
      
      public function en_US$core_properties()
      {
         super("en_US","core");
      }
      
      override protected function getContent() : Object
      {
         return {
            "badIndex":"The supplied index is out of bounds.",
            "notImplementedInFTETextField":"\'{0}\' is not implemented in FTETextField.",
            "stateUndefined":"Undefined state \'{0}\'.",
            "remoteClassMemoryLeak":"warning: The class {0} has been used in a call to net.registerClassAlias() in {2}. This will cause {1} to be leaked. To resolve the leak, define {0} in the top-level application.   ",
            "versionAlreadyRead":"Compatibility version has already been read.",
            "nullParameter":"Parameter {0} must be non-null.",
            "multipleChildSets_ClassAndSubclass":"Multiple sets of visual children have been specified for this component (base component definition and derived component definition).",
            "fontIncompatible":"warning: incompatible embedded font \'{0}\' specified for {1}. This component requires that the embedded font be declared with embedAsCFF={2}.",
            "badFile":"File does not exist.",
            "badParameter":"Parameter {0} must be one of the accepted values.",
            "notExecuting":"Repeater is not executing.",
            "multipleChildSets_ClassAndInstance":"Multiple sets of visual children have been specified for this component (component definition and component instance).",
            "unsupportedTypeInFTETextField":"FTETextField does not support setting type to \"input\".",
            "truncationIndicator":"...",
            "versionAlreadySet":"Compatibility version has already been set.",
            "viewSource":"View Source"
         };
      }
   }
}
