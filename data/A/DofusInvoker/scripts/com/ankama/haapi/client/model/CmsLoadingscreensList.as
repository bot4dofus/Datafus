package com.ankama.haapi.client.model
{
   public class CmsLoadingscreensList
   {
       
      
      public var total_count:Number = 0;
      
      private var _loadingscreens_obj_class:Array = null;
      
      public var loadingscreens:Vector.<CmsLoadingscreen>;
      
      public function CmsLoadingscreensList()
      {
         this.loadingscreens = new Vector.<CmsLoadingscreen>();
         super();
      }
      
      public function toString() : String
      {
         var str:String = "CmsLoadingscreensList: ";
         str += " (total_count: " + this.total_count + ")";
         return str + (" (loadingscreens: " + this.loadingscreens + ")");
      }
   }
}
