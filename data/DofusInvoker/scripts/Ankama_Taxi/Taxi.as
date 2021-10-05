package Ankama_Taxi
{
   import Ankama_Taxi.ui.ZaapSelection;
   import Ankama_Taxi.ui.ZaapiSelection;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.network.enums.TeleporterTypeEnum;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.display.Sprite;
   
   public class Taxi extends Sprite
   {
       
      
      protected var zaapSelection:ZaapSelection;
      
      protected var zaapiSelection:ZaapiSelection;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      public function Taxi()
      {
         super();
      }
      
      public function main() : void
      {
         this.sysApi.addHook(RoleplayHookList.TeleportDestinationList,this.onTeleportDestinationList);
      }
      
      private function onTeleportDestinationList(teleportList:Object, tpType:uint) : void
      {
         if(tpType == TeleporterTypeEnum.TELEPORTER_SUBWAY)
         {
            this.uiApi.loadUi("zaapiSelection","zaapiSelection",[teleportList,tpType]);
         }
         else if(!this.uiApi.getUi("zaapSelection"))
         {
            this.uiApi.loadUi("zaapSelection","zaapSelection",[teleportList,tpType]);
         }
      }
   }
}
