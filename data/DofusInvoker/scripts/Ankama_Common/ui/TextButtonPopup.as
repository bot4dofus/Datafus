package Ankama_Common.ui
{
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   
   public class TextButtonPopup extends Popup
   {
       
      
      public var btn_primary:ButtonContainer;
      
      public var btn_lbl_btn_primary:Label;
      
      public var lbl_btn_secondary:Label;
      
      public var popup:GraphicContainer;
      
      public function TextButtonPopup()
      {
         super();
      }
      
      override public function main(params:Object) : void
      {
         if(params)
         {
            if(params.buttonText.length != 2)
            {
               throw new Error("The TextButtonPopup needs 2 buttons to be created.");
            }
            startValidationTimer(50);
            lbl_title_popup.text = params.title;
            lbl_content.text = params.content;
            this.btn_lbl_btn_primary.text = params.buttonText[0];
            this.lbl_btn_secondary.text = params.buttonText[1];
            this.lbl_btn_secondary.fullWidth();
            this.lbl_btn_secondary.handCursor = true;
            uiApi.addComponentHook(this.lbl_btn_secondary,ComponentHookList.ON_RELEASE);
            _aEventIndex[this.btn_primary.name] = params.buttonCallback[0];
            _aEventIndex[this.lbl_btn_secondary.name] = params.buttonCallback[1];
            onEnterKey = !!params.onEnterKey ? params.onEnterKey : params.buttonCallback[0];
            onCancelFunction = !!params.onCancel ? params.onCancel : params.buttonCallback[0];
            lbl_content.fullWidthAndHeight();
            this.popup.height = lbl_content.y + lbl_content.height - lbl_title_popup.y + Number(uiApi.me().getConstant("bottom_margin"));
            uiApi.me().render();
            return;
         }
         throw new Error("Can\'t load popup without properties.");
      }
   }
}
