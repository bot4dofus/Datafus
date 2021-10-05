package Ankama_Storage
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.JobsApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.StorageApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   
   public class Api
   {
      
      public static var ui:UiApi;
      
      public static var system:SystemApi;
      
      public static var storage:StorageApi;
      
      public static var inventory:InventoryApi;
      
      public static var player:PlayedCharacterApi;
      
      public static var menu:Object;
      
      public static var common:Object;
      
      public static var sound:SoundApi;
      
      public static var data:DataApi;
      
      public static var jobs:JobsApi;
       
      
      public function Api()
      {
         super();
      }
   }
}
