package Ankama_Tutorial
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.dofus.uiApi.BindsApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.FightApi;
   import com.ankamagames.dofus.uiApi.HighlightApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.QuestApi;
   import com.ankamagames.dofus.uiApi.RoleplayApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.StorageApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class Api
   {
      
      public static var ui:UiApi;
      
      public static var system:SystemApi;
      
      public static var modMenu:Object;
      
      public static var player:PlayedCharacterApi;
      
      public static var data:DataApi;
      
      public static var highlight:HighlightApi;
      
      public static var fight:FightApi;
      
      public static var storage:StorageApi;
      
      public static var binds:BindsApi;
      
      public static var sound:SoundApi;
      
      public static var roleplay:RoleplayApi;
      
      public static var quest:QuestApi;
       
      
      public function Api()
      {
         super();
      }
   }
}
