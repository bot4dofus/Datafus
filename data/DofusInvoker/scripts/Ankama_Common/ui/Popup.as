package Ankama_Common.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   
   public class Popup
   {
      
      private static const MAX_WIDTH_BUTTON:int = 150;
       
      
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
      
      public var tx_background_close_button_popup:TextureBitmap;
      
      public var ctr_buttons:GraphicContainer;
      
      public var lbl_title_popup:Label;
      
      public var lbl_content:Label;
      
      public var tx_externalLink:Texture;
      
      protected var _ignoreShortcuts:Boolean = false;
      
      private var _timer:BenchmarkTimer;
      
      private var _canValidUI:Boolean = false;
      
      public function Popup()
      {
         this._aEventIndex = [];
         super();
      }
      
      public function set content(v:String) : void
      {
         if(this.lbl_content)
         {
            this.lbl_content.text = v;
         }
      }
      
      public function main(param:Object) : void
      {
         var btn:ButtonContainer = null;
         var btnTx:TextureBitmap = null;
         var btnIconTxt:Texture = null;
         var btnLbl:Label = null;
         var ctr_buttons_height:int = 0;
         var ctr_buttons_y:int = 0;
         var i:uint = 0;
         var stateChangingProperties:Array = null;
         this.startValidationTimer(50);
         this.soundApi.playSound(SoundTypeEnum.POPUP_INFO);
         this.btn_close_popup.soundId = SoundEnum.WINDOW_CLOSE;
         this.lbl_content.multiline = true;
         this.lbl_content.wordWrap = true;
         var noButton:Boolean = param.hasOwnProperty("noButton");
         var displayBtnIcons:Boolean = param.hasOwnProperty("displayBtnIcons") && param.displayBtnIcons;
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
            if(param.noHtml)
            {
               this.lbl_content.html = false;
            }
            else if(param.useHyperLink)
            {
               this.lbl_content.hyperlinkEnabled = true;
               this.lbl_content.useStyleSheet = true;
            }
            this.lbl_content.text = param.content;
            if(!noButton && (!param.buttonText || !param.buttonText.length))
            {
               throw new Error("Can\'t create popup without any button");
            }
            var btnWidth:uint = MAX_WIDTH_BUTTON;
            var btnHeight:uint = 32;
            var padding:uint = 20;
            var totalWidth:uint = 0;
            this.popCtr.height = Math.floor(this.lbl_content.textfield.textHeight) + 150;
            var popup_width:int = this.uiApi.me().getConstant("popWidth");
            if(!noButton)
            {
               ctr_buttons_height = this.uiApi.me().getConstant("ctrButtonsHeight");
               ctr_buttons_y = this.uiApi.me().getConstant("ctrButtonsY");
               this.ctr_buttons.height = ctr_buttons_height;
               this.numberButton = param.buttonText.length;
               if(this.numberButton == 1 && param.buttonCallback && param.buttonCallback.length == 1)
               {
                  this.defaultShortcutFunction = param.buttonCallback[0];
               }
               for(i = 0; i < this.numberButton; i++)
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
                  btn.height = btnHeight;
                  btn.x = i == 0 ? Number(0) : Number(totalWidth + i * padding);
                  btn.name = "btn" + (i + 1);
                  this.uiApi.me().registerId(btn.name,this.uiApi.createContainer("GraphicElement",btn,[],btn.name));
                  btnTx = this.uiApi.createComponent("TextureBitmap") as TextureBitmap;
                  btnTx.height = btnHeight;
                  btnTx.themeDataId = this.uiApi.me().getConstant("txBtnBg_normal") as String;
                  btnTx.name = btn.name + "_tx";
                  this.uiApi.me().registerId(btnTx.name,this.uiApi.createContainer("GraphicElement",btnTx,[],btnTx.name));
                  btnTx.finalize();
                  if(displayBtnIcons)
                  {
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
                     this.uiApi.me().registerId(btnIconTxt.name,this.uiApi.createContainer("GraphicElement",btnIconTxt,[],btnIconTxt.name));
                     btnIconTxt.finalize();
                  }
                  btnLbl = this.uiApi.createComponent("Label") as Label;
                  btnLbl.height = btnHeight;
                  btnLbl.verticalAlign = "center";
                  btnLbl.css = this.uiApi.createUri(this.uiApi.me().getConstant("btn.css"));
                  btnLbl.text = this.uiApi.replaceKey(param.buttonText[i]);
                  if(displayBtnIcons)
                  {
                     btnLbl.x = 30;
                     btnWidth = Math.max(btnLbl.textWidth + 20 + 30,MAX_WIDTH_BUTTON);
                     btnLbl.width = btnWidth - 30;
                  }
                  else
                  {
                     btnLbl.x = 0;
                     btnWidth = Math.max(btnLbl.textWidth + 20,MAX_WIDTH_BUTTON);
                     btnLbl.width = btnWidth;
                  }
                  btn.width = btnWidth;
                  btnTx.width = btnWidth;
                  totalWidth += btnWidth;
                  btn.addChild(btnTx);
                  if(displayBtnIcons)
                  {
                     btn.addChild(btnIconTxt);
                  }
                  btn.addChild(btnLbl);
                  stateChangingProperties = [];
                  stateChangingProperties[1] = [];
                  stateChangingProperties[1][btnTx.name] = [];
                  stateChangingProperties[1][btnTx.name]["themeDataId"] = this.uiApi.me().getConstant("txBtnBg_over") as String;
                  stateChangingProperties[2] = [];
                  stateChangingProperties[2][btnTx.name] = [];
                  stateChangingProperties[2][btnTx.name]["themeDataId"] = this.uiApi.me().getConstant("txBtnBg_pressed") as String;
                  btn.changingStateData = stateChangingProperties;
                  if(param.buttonCallback && param.buttonCallback[i])
                  {
                     this._aEventIndex[btn.name] = param.buttonCallback[i];
                  }
                  this.uiApi.addComponentHook(btn,"onRelease");
                  this.ctr_buttons.addChild(btn);
               }
               this.popCtr.width = Math.max(btn.x + btnWidth + padding * (this.numberButton - 1),popup_width);
               this.ctr_buttons.width = totalWidth + (this.numberButton - 1) * padding;
               this.ctr_buttons.x = this.popCtr.width / 2 - this.ctr_buttons.width / 2;
               this.ctr_buttons.y = this.popCtr.height + ctr_buttons_y;
               if(param.onCancel)
               {
                  this.onCancelFunction = param.onCancel;
               }
               if(param.onEnterKey)
               {
                  this.onEnterKey = param.onEnterKey;
               }
            }
            else
            {
               this.popCtr.getUi().showModalContainer = true;
               this._ignoreShortcuts = true;
               this.btn_close_popup.visible = false;
               this.tx_background_close_button_popup.visible = false;
               this.popCtr.height -= btnHeight;
               this.popCtr.width = popup_width;
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
      
      protected function startValidationTimer(delay:int) : void
      {
         this._timer = new BenchmarkTimer(delay,1,"Popup._timer");
         this._timer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
         this._timer.start();
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
         if(this._ignoreShortcuts)
         {
            return true;
         }
         switch(s)
         {
            case "validUi":
               if(!this._canValidUI)
               {
                  return false;
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
               if(this.onCancelFunction != null)
               {
                  this.onCancelFunction();
               }
               this.closeMe();
               return true;
            default:
               return false;
         }
      }
      
      public function unload() : void
      {
         this.sysApi.dispatchHook(HookList.ClosePopup);
      }
      
      private function closeMe() : void
      {
         if(this.uiApi)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      private function onTimerComplete(e:TimerEvent) : void
      {
         this._canValidUI = true;
         this._timer.stop();
         this._timer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerComplete);
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
