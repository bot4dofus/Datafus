package Ankama_Grimoire.ui.optionalFeatures
{
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   
   public class ModsterGetScrollWarningPopUp extends ForgettableSpellGetScrollWarningPopUp
   {
       
      
      public var lbl_cancelSpellSetDeletion:Label;
      
      public function ModsterGetScrollWarningPopUp()
      {
         super();
      }
      
      override public function main(params:Array) : void
      {
         super.main(params);
         this.lbl_cancelSpellSetDeletion.fullWidth();
         btn_cancelGetScrollAction.width = this.lbl_cancelSpellSetDeletion.width + 3;
      }
      
      override protected function get uiName() : String
      {
         return UIEnum.MODSTER_GET_SCROLL_WARNING_POP_UP;
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         if(target.name.indexOf("btn_close") != -1)
         {
            closeMe();
         }
         else
         {
            super.onRelease(target);
         }
      }
   }
}
