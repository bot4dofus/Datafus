package Ankama_Common
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   
   public class Api
   {
      
      public static var ui:UiApi;
      
      public static var system:SystemApi;
      
      public static var tooltip:TooltipApi;
      
      public static var data:DataApi;
       
      
      public function Api()
      {
         super();
      }
   }
}
