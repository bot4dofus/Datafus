package mx.utils
{
   import mx.core.DPIClassification;
   import mx.core.RuntimeDPIProvider;
   import mx.core.Singleton;
   
   [ExcludeClass]
   public class DensityUtil
   {
      
      private static var runtimeDPI:Number;
       
      
      public function DensityUtil()
      {
         super();
      }
      
      public static function getRuntimeDPI() : Number
      {
         if(!isNaN(runtimeDPI))
         {
            return runtimeDPI;
         }
         var runtimeDPIProviderClass:Class = Singleton.getClass("mx.core::RuntimeDPIProvider");
         if(!runtimeDPIProviderClass)
         {
            runtimeDPIProviderClass = RuntimeDPIProvider;
         }
         var instance:RuntimeDPIProvider = RuntimeDPIProvider(new runtimeDPIProviderClass());
         runtimeDPI = instance.runtimeDPI;
         return runtimeDPI;
      }
      
      public static function getDPIScale(sourceDPI:Number, targetDPI:Number) : Number
      {
         if(sourceDPI != DPIClassification.DPI_120 && sourceDPI != DPIClassification.DPI_160 && sourceDPI != DPIClassification.DPI_240 && sourceDPI != DPIClassification.DPI_320 && sourceDPI != DPIClassification.DPI_480 && sourceDPI != DPIClassification.DPI_640 || targetDPI != DPIClassification.DPI_120 && targetDPI != DPIClassification.DPI_160 && targetDPI != DPIClassification.DPI_240 && targetDPI != DPIClassification.DPI_320 && targetDPI != DPIClassification.DPI_480 && targetDPI != DPIClassification.DPI_640)
         {
            return NaN;
         }
         return targetDPI / sourceDPI;
      }
   }
}
