package mx.core
{
   import flash.display.DisplayObject;
   import flash.system.Capabilities;
   import mx.managers.SystemManager;
   import mx.utils.Platform;
   
   use namespace mx_internal;
   
   public class RuntimeDPIProvider
   {
      
      mx_internal static const IPAD_MAX_EXTENT:int = 1024;
      
      mx_internal static const IPAD_RETINA_MAX_EXTENT:int = 2048;
       
      
      public function RuntimeDPIProvider()
      {
         super();
      }
      
      mx_internal static function classifyDPI(dpi:Number) : Number
      {
         if(dpi <= 140)
         {
            return DPIClassification.DPI_120;
         }
         if(dpi <= 200)
         {
            return DPIClassification.DPI_160;
         }
         if(dpi <= 280)
         {
            return DPIClassification.DPI_240;
         }
         if(dpi <= 400)
         {
            return DPIClassification.DPI_320;
         }
         if(dpi <= 560)
         {
            return DPIClassification.DPI_480;
         }
         return DPIClassification.DPI_640;
      }
      
      public function get runtimeDPI() : Number
      {
         var scX:Number = NaN;
         var scY:Number = NaN;
         var root:DisplayObject = null;
         if(Platform.isIOS)
         {
            scX = Capabilities.screenResolutionX;
            scY = Capabilities.screenResolutionY;
            if(Capabilities.isDebugger)
            {
               root = SystemManager.getSWFRoot(this);
               if(root && root.stage)
               {
                  scX = root.stage.fullScreenWidth;
                  scY = root.stage.fullScreenHeight;
               }
            }
            if(scX == mx_internal::IPAD_MAX_EXTENT || scY == mx_internal::IPAD_MAX_EXTENT)
            {
               return DPIClassification.DPI_160;
            }
            if(scX == mx_internal::IPAD_RETINA_MAX_EXTENT || scY == mx_internal::IPAD_RETINA_MAX_EXTENT)
            {
               return DPIClassification.DPI_320;
            }
         }
         return classifyDPI(Capabilities.screenDPI);
      }
   }
}
