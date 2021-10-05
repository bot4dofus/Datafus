package Ankama_ContextMenu
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.dofus.uiApi.AlignmentApi;
   import com.ankamagames.dofus.uiApi.BindsApi;
   import com.ankamagames.dofus.uiApi.BreachApi;
   import com.ankamagames.dofus.uiApi.ChatServiceApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.FightApi;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.JobsApi;
   import com.ankamagames.dofus.uiApi.MapApi;
   import com.ankamagames.dofus.uiApi.MountApi;
   import com.ankamagames.dofus.uiApi.PartyApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.RoleplayApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.StorageApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   
   public class Api
   {
      
      public static var ui:UiApi;
      
      public static var system:SystemApi;
      
      public static var config:ConfigApi;
      
      public static var menu:ContextMenuApi;
      
      public static var data:DataApi;
      
      public static var alignment:AlignmentApi;
      
      public static var fight:FightApi;
      
      public static var player:PlayedCharacterApi;
      
      public static var map:MapApi;
      
      public static var mount:MountApi;
      
      public static var social:SocialApi;
      
      public static var jobs:JobsApi;
      
      public static var modCommon:Common;
      
      public static var modMenu:ContextMenu;
      
      public static var roleplay:RoleplayApi;
      
      public static var party:PartyApi;
      
      public static var binds:BindsApi;
      
      public static var time:TimeApi;
      
      public static var storage:StorageApi;
      
      public static var tooltip:TooltipApi;
      
      public static var util:UtilApi;
      
      public static var breachApi:BreachApi;
      
      public static var inventoryApi:InventoryApi;
      
      public static var chatServiceApi:ChatServiceApi;
       
      
      public function Api()
      {
         super();
      }
   }
}
