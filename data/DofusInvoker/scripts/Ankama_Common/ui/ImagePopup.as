package Ankama_Common.ui
{
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   
   public class ImagePopup extends Popup
   {
       
      
      public var imgPopCtr:GraphicContainer;
      
      public var ctr_contents:Object;
      
      public var tx_image:Texture;
      
      public function ImagePopup()
      {
         super();
      }
      
      override public function main(param:Object) : void
      {
         var btn:ButtonContainer = null;
         var btnTx:TextureBitmap = null;
         var btnLbl:Label = null;
         var s:String = null;
         var stateChangingProperties:Array = null;
         lbl_content.multiline = true;
         lbl_content.wordWrap = true;
         lbl_content.html = true;
         lbl_content.border = false;
         if(param)
         {
            if(param.hideModalContainer)
            {
               this.imgPopCtr.getUi().showModalContainer = false;
            }
            else
            {
               this.imgPopCtr.getUi().showModalContainer = true;
            }
            lbl_title_popup.text = param.title;
            this.tx_image.uri = param.image;
            s = param.content;
            lbl_content.text = s;
            if(!param.buttonText || !param.buttonText.length)
            {
               throw new Error("Can\'t create popup without any button");
            }
            var btnWidth:uint = 100;
            var btnHeight:uint = 32;
            var padding:uint = 20;
            for(var i:uint = 0; i < param.buttonText.length; i++)
            {
               btn = uiApi.createContainer("ButtonContainer") as ButtonContainer;
               btn.width = btnWidth;
               btn.height = btnHeight;
               btn.x = i * (padding + btnWidth);
               btn.name = "btn" + (i + 1);
               uiApi.me().registerId(btn.name,uiApi.createContainer("GraphicElement",btn,new Array(),btn.name));
               btnTx = uiApi.createComponent("TextureBitmap") as TextureBitmap;
               btnTx.width = btnWidth;
               btnTx.height = btnHeight;
               btnTx.themeDataId = uiApi.me().getConstant("txBtnBg_normal") as String;
               btnTx.name = btn.name + "_tx";
               uiApi.me().registerId(btnTx.name,uiApi.createContainer("GraphicElement",btnTx,new Array(),btnTx.name));
               btnTx.finalize();
               btnLbl = uiApi.createComponent("Label") as Label;
               btnLbl.width = btnWidth;
               btnLbl.height = btnHeight;
               btnLbl.verticalAlign = "center";
               btnLbl.css = uiApi.createUri(uiApi.me().getConstant("btn.css"));
               btnLbl.text = uiApi.replaceKey(param.buttonText[i]);
               btn.addChild(btnTx);
               btn.addChild(btnLbl);
               stateChangingProperties = new Array();
               stateChangingProperties[1] = new Array();
               stateChangingProperties[1][btnTx.name] = new Array();
               stateChangingProperties[1][btnTx.name]["themeDataId"] = uiApi.me().getConstant("txBtnBg_over") as String;
               stateChangingProperties[2] = new Array();
               stateChangingProperties[2][btnTx.name] = new Array();
               stateChangingProperties[2][btnTx.name]["themeDataId"] = uiApi.me().getConstant("txBtnBg_pressed") as String;
               btn.changingStateData = stateChangingProperties;
               if(param.buttonCallback && param.buttonCallback[i])
               {
                  _aEventIndex[btn.name] = param.buttonCallback[i];
               }
               uiApi.addComponentHook(btn,"onRelease");
               ctr_buttons.addChild(btn);
            }
            var imageHeight:uint = this.tx_image.y + this.tx_image.height;
            var contentHeight:uint = lbl_content.y + lbl_content.textHeight + 20 + ctr_buttons.height;
            this.imgPopCtr.height = Math.floor(contentHeight > this.tx_image.height ? Number(contentHeight) : Number(imageHeight)) + 70;
            if(param.onCancel)
            {
               onCancelFunction = param.onCancel;
            }
            uiApi.me().render();
            return;
         }
         throw new Error("Can\'t load popup without properties.");
      }
   }
}
