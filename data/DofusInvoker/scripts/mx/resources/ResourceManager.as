package mx.resources
{
   import flash.utils.getDefinitionByName;
   import mx.core.Singleton;
   import mx.core.mx_internal;
   
   use namespace mx_internal;
   
   public class ResourceManager
   {
      
      mx_internal static const VERSION:String = "4.16.1.0";
      
      private static var implClassDependency:ResourceManagerImpl;
      
      private static var instance:IResourceManager;
       
      
      public function ResourceManager()
      {
         super();
      }
      
      public static function getInstance() : IResourceManager
      {
         if(!instance)
         {
            if(!Singleton.getClass("mx.resources::IResourceManager"))
            {
               Singleton.registerClass("mx.resources::IResourceManager",Class(getDefinitionByName("mx.resources::ResourceManagerImpl")));
            }
            try
            {
               instance = IResourceManager(Singleton.getInstance("mx.resources::IResourceManager"));
            }
            catch(e:Error)
            {
            }
            if(!instance)
            {
               instance = new ResourceManagerImpl();
            }
         }
         return instance;
      }
   }
}
