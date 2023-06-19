package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.misc.lists.HookList;
   
   public class HyperlinkShowSubArea
   {
       
      
      public function HyperlinkShowSubArea()
      {
         super();
      }
      
      public static function showSubArea(pSubAreaId:int) : void
      {
         var subArea:SubArea = SubArea.getSubAreaById(pSubAreaId);
         if(subArea)
         {
            KernelEventsManager.getInstance().processCallback(HookList.OpenCartographyPopup,subArea.name,subArea.id,null,null);
         }
      }
      
      public static function getSubAreaName(pSubAreaId:int) : String
      {
         var subArea:SubArea = SubArea.getSubAreaById(pSubAreaId);
         return !!subArea ? "[" + subArea.name + "]" : "";
      }
   }
}
