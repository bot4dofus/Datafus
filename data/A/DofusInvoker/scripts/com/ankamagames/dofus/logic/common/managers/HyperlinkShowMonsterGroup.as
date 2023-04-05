package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.RoleplayApi;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.geom.Rectangle;
   
   public class HyperlinkShowMonsterGroup
   {
      
      private static var roleplayApi:RoleplayApi = new RoleplayApi();
       
      
      public function HyperlinkShowMonsterGroup()
      {
         super();
      }
      
      public static function showMonsterGroup(pX:int, pY:int, pWorldMapId:int, pMonsterName:String, pGroupInfos:String, scaleMode:int = 0) : void
      {
         KernelEventsManager.getInstance().processCallback(HookList.AddMapFlag,"flag_chat_" + pX + "_" + pY + "_" + pMonsterName + "_" + pGroupInfos.split(";")[0],unescape(pMonsterName) + " (" + pX + "," + pY + ")",pWorldMapId,pX,pY,16737792,true,false,true,true);
      }
      
      public static function getText(pX:int, pY:int, pWorldMapId:int, pMonsterName:String, pGroupInfos:String, scaleMode:int = 0) : String
      {
         return unescape(pMonsterName) + " [" + pX + "," + pY + "]";
      }
      
      public static function rollOver(pMouseX:int, pMouseY:int, pMonsterX:int, pMonsterY:int, pWorldMapId:int, pMonsterName:String, pGroupInfos:String, scaleMode:int = 0) : void
      {
         showMonsterGroupTooltip(pGroupInfos,scaleMode);
      }
      
      private static function showMonsterGroupTooltip(pGroupInfos:String, scaleMode:int = 0) : void
      {
         var data:* = undefined;
         if(scaleMode != 0)
         {
            data = {
               "monsterGroupInfos":roleplayApi.getMonsterGroupFromString(pGroupInfos),
               "useScale":true
            };
         }
         else
         {
            data = roleplayApi.getMonsterGroupFromString(pGroupInfos);
         }
         TooltipManager.show(data,new Rectangle(StageShareManager.stage.mouseX,StageShareManager.stage.mouseY,10,10),UiModuleManager.getInstance().getModule("Ankama_Tooltips"),false,"HyperLink",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,0,true,"monsterGroup");
      }
   }
}
