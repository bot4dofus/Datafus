package Ankama_Config.types
{
   public class ConfigProperty
   {
       
      
      public var associatedComponent:String;
      
      public var associatedProperty:String;
      
      public var associatedConfigModule:String;
      
      public function ConfigProperty(associatedComponent:String, associatedProperty:String, associatedConfigModule:String)
      {
         super();
         this.associatedComponent = associatedComponent;
         this.associatedConfigModule = associatedConfigModule;
         this.associatedProperty = associatedProperty;
      }
   }
}
