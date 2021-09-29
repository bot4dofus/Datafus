package Ankama_Fight
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.FightApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class Api
   {
      
      public static var sysApi:SystemApi;
      
      public static var fightApi:FightApi;
      
      public static var uiApi:UiApi;
      
      public static var dataApi:DataApi;
      
      public static var configApi:ConfigApi;
      
      public static var chatApi:ChatApi;
      
      public static var playerApi:PlayedCharacterApi;
       
      
      public function Api()
      {
         super();
      }
   }
}
