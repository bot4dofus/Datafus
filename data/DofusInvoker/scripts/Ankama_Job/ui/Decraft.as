package Ankama_Job.ui
{
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   
   public class Decraft extends Craft
   {
       
      
      public function Decraft()
      {
         super();
      }
      
      override public function main(params:Object) : void
      {
         showRecipes = false;
         btn_lbl_btn_ok.text = uiApi.getText("ui.common.decraft");
         super.main(params);
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case btn_ok:
               modCommon.openPopup(uiApi.getText("ui.popup.warning"),uiApi.getText("ui.craft.decraftConfirm"),[uiApi.getText("ui.common.yes"),uiApi.getText("ui.common.no")],[onConfirmCraftRecipe,onCancelCraftRecipe],onConfirmCraftRecipe,onCancelCraftRecipe);
               break;
            default:
               super.onRelease(target);
         }
      }
   }
}
