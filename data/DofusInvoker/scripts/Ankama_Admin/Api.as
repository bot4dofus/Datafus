package Ankama_Admin
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.FileApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class Api
   {
      
      public static var fileApi:FileApi;
      
      public static var uiApi:UiApi;
      
      public static var systemApi:SystemApi;
      
      public static var dataApi:DataApi;
      
      public static var playerApi:PlayedCharacterApi;
      
      public static var contextMod:Object;
      
      public static var consoleMod:Object;
       
      
      public function Api()
      {
         super();
      }
   }
}
