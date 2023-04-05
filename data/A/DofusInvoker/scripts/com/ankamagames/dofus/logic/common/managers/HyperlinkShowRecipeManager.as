package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.data.I18n;
   import flash.geom.Rectangle;
   
   public class HyperlinkShowRecipeManager
   {
       
      
      public function HyperlinkShowRecipeManager()
      {
         super();
      }
      
      public static function showRecipe(recipeId:uint) : void
      {
         var item:ItemWrapper = ItemWrapper.create(0,0,recipeId,1,null,false);
         if(item)
         {
            KernelEventsManager.getInstance().processCallback(HookList.OpenRecipe,item);
         }
      }
      
      public static function getRecipeName(recipeId:int) : String
      {
         var item:Item = Item.getItemById(recipeId);
         if(item)
         {
            return "[" + I18n.getUiText("ui.common.recipe") + I18n.getUiText("ui.common.colon") + item.name + "]";
         }
         return "[null]";
      }
      
      public static function rollOver(pX:int, pY:int, recipeId:uint) : void
      {
         var target:Rectangle = new Rectangle(pX,pY,10,10);
         var info:TextTooltipInfo = new TextTooltipInfo(I18n.getUiText("ui.tooltip.chat.recipe"));
         TooltipManager.show(info,target,UiModuleManager.getInstance().getModule("Ankama_GameUiCore"),false,"HyperLink",6,2,3,true,null,null,null,null,false,StrataEnum.STRATA_TOOLTIP,1);
      }
   }
}
