package Ankama_Common.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextArea;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.geom.Rectangle;
   
   public class LargePopup
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      protected var _aEventIndex:Array;
      
      protected var onCancelFunction:Function = null;
      
      protected var onEnterKey:Function = null;
      
      protected var numberButton:uint;
      
      protected var defaultShortcutFunction:Function;
      
      public var popCtr:GraphicContainer;
      
      public var btn_close_popup:ButtonContainer;
      
      public var ctr_buttons:GraphicContainer;
      
      public var lbl_title_popup:Label;
      
      public var lbl_content:TextArea;
      
      public var tx_background:Texture;
      
      public var tx_externalLink:Texture;
      
      public function LargePopup()
      {
         this._aEventIndex = new Array();
         super();
      }
      
      public function main(param:Object) : void
      {
         var btn:ButtonContainer = null;
         var btnTx:GraphicContainer = null;
         var btnIconTxt:Texture = null;
         var btnLbl:Label = null;
         var stateChangingProperties:Array = null;
         this.sysApi.log(2,"go large popup " + param);
         this.soundApi.playSound(SoundTypeEnum.POPUP_INFO);
         this.btn_close_popup.soundId = SoundEnum.WINDOW_CLOSE;
         this.tx_background.autoGrid = true;
         this.lbl_content.multiline = true;
         this.lbl_content.wordWrap = true;
         this.lbl_content.allowTextMouse(true);
         var customBtnIcons:Boolean = param.hasOwnProperty("buttonIcons") && param.buttonIcons;
         if(param)
         {
            if(param.hideModalContainer)
            {
               this.popCtr.getUi().showModalContainer = false;
            }
            else
            {
               this.popCtr.getUi().showModalContainer = true;
            }
            this.lbl_title_popup.text = param.title;
            if(param.useHyperLink)
            {
               this.lbl_content.hyperlinkEnabled = true;
               this.lbl_content.useStyleSheet = true;
            }
            this.lbl_content.text = param.content;
            if(!param.buttonText || !param.buttonText.length)
            {
               throw new Error("Can\'t create popup without any button");
            }
            var btnWidth:uint = 100;
            var btnHeight:uint = 32;
            var padding:uint = 20;
            this.sysApi.log(2,"hauteur " + this.popCtr.height);
            this.numberButton = param.buttonText.length;
            if(this.numberButton == 1 && param.buttonCallback && param.buttonCallback.length == 1)
            {
               this.defaultShortcutFunction = param.buttonCallback[0];
            }
            for(var i:uint = 0; i < this.numberButton; i++)
            {
               btn = this.uiApi.createContainer("ButtonContainer") as ButtonContainer;
               if(i == 0)
               {
                  btn.soundId = SoundEnum.POPUP_YES;
               }
               else
               {
                  btn.soundId = SoundEnum.POPUP_NO;
               }
               btn.width = btnWidth;
               btn.height = btnHeight;
               btn.x = i * (padding + btnWidth);
               btn.name = "btn" + (i + 1);
               btnTx = this.uiApi.createComponent("TextureBitmap");
               btnTx.width = btnWidth;
               btnTx.height = btnHeight;
               btnTx.themeDataId = this.uiApi.me().getConstant("txBtnBg_normal") as String;
               btnTx.name = btn.name + "_tx";
               this.uiApi.me().registerId(btnTx.name,this.uiApi.createContainer("GraphicElement",btnTx,[],btnTx.name));
               btnTx.finalize();
               btnIconTxt = this.uiApi.createComponent("Texture") as Texture;
               btnIconTxt.height = btnHeight;
               if(customBtnIcons && param.buttonIcons[i])
               {
                  btnIconTxt.uri = this.uiApi.createUri(param.buttonIcons[i].uri);
                  if(param.buttonIcons[i].hasOwnProperty("size"))
                  {
                     btnIconTxt.height = Math.min(btnHeight,param.buttonIcons[i].size);
                     btnIconTxt.width = Math.min(btnHeight,param.buttonIcons[i].size);
                     btnIconTxt.x = 5 + (btnHeight - btnIconTxt.width) / 2;
                     btnIconTxt.y = (btnHeight - btnIconTxt.height) / 2;
                  }
                  else
                  {
                     btnIconTxt.x = 5;
                  }
               }
               else
               {
                  if(i == 0)
                  {
                     btnIconTxt.uri = this.uiApi.createUri(this.uiApi.me().getConstant("btnOkIcon.file"));
                  }
                  else
                  {
                     btnIconTxt.uri = this.uiApi.createUri(this.uiApi.me().getConstant("btnCancelIcon.file"));
                  }
                  btnIconTxt.x = 5;
               }
               btnIconTxt.autoGrid = true;
               btnIconTxt.name = btn.name + "_tx_icon";
               this.uiApi.me().registerId(btnIconTxt.name,this.uiApi.createContainer("GraphicElement",btnIconTxt,new Array(),btnIconTxt.name));
               btnIconTxt.finalize();
               btnLbl = this.uiApi.createComponent("Label") as Label;
               btnLbl.x = 30;
               btnLbl.width = btnWidth - 30;
               btnLbl.height = btnHeight;
               btnLbl.verticalAlign = "center";
               btnLbl.css = this.uiApi.createUri(this.uiApi.me().getConstant("btn.css"));
               btnLbl.text = this.uiApi.replaceKey(param.buttonText[i]);
               btn.addChild(btnTx);
               btn.addChild(btnIconTxt);
               btn.addChild(btnLbl);
               stateChangingProperties = new Array();
               stateChangingProperties[1] = new Array();
               stateChangingProperties[1][btnTx.name] = new Array();
               stateChangingProperties[1][btnTx.name]["gotoAndStop"] = "over";
               stateChangingProperties[2] = new Array();
               stateChangingProperties[2][btnTx.name] = new Array();
               stateChangingProperties[2][btnTx.name]["gotoAndStop"] = "pressed";
               btn.changingStateData = stateChangingProperties;
               if(param.buttonCallback && param.buttonCallback[i])
               {
                  this._aEventIndex[btn.name] = param.buttonCallback[i];
               }
               this.uiApi.addComponentHook(btn,"onRelease");
               this.ctr_buttons.addChild(btn);
            }
            if(param.onCancel)
            {
               this.onCancelFunction = param.onCancel;
            }
            if(param.onEnterKey)
            {
               this.onEnterKey = param.onEnterKey;
            }
            this.uiApi.me().render();
            if(param.addExternalPicto)
            {
               this.addExternalLinkPicto();
            }
            return;
         }
         throw new Error("Can\'t load popup without properties.");
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         if(this._aEventIndex[target.name])
         {
            this._aEventIndex[target.name].apply(null);
         }
         else if(target == this.btn_close_popup && this.onCancelFunction != null)
         {
            this.onCancelFunction();
         }
         if(this.uiApi && this.uiApi.me() && this.uiApi.getUi(this.uiApi.me().name))
         {
            this.closeMe();
         }
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "validUi":
               if(this.onEnterKey == null && this.numberButton > 1)
               {
                  throw new Error("onEnterKey method is null");
               }
               if(this.onEnterKey != null)
               {
                  this.onEnterKey();
               }
               else if(this.defaultShortcutFunction != null)
               {
                  this.defaultShortcutFunction();
               }
               this.closeMe();
               return true;
               break;
            case "closeUi":
               if(this.onCancelFunction == null && this.numberButton > 1)
               {
                  throw new Error("onCancelFunction method is null");
               }
               if(this.onCancelFunction != null)
               {
                  this.onCancelFunction();
               }
               this.closeMe();
               return true;
               break;
            default:
               return false;
         }
      }
      
      private function closeMe() : void
      {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      public function unload() : void
      {
         this.sysApi.dispatchHook(HookList.ClosePopup);
      }
      
      private function addExternalLinkPicto() : void
      {
         this.tx_externalLink.visible = true;
         var lastChar:Rectangle = this.lbl_content.getCharBoundaries(this.lbl_content.text.length - 2);
         this.tx_externalLink.x = this.lbl_content.x + lastChar.x + lastChar.width + 7;
         this.tx_externalLink.y = this.lbl_content.y + lastChar.y + 3;
      }
   }
}
