package Ankama_Common.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextArea;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.types.Uri;
   
   public class PollPopup
   {
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      private var _validCallBack:Function;
      
      private var _cancelCallback:Function;
      
      private var _btnAnswers:Array;
      
      private var _onlyOneAnswer:Boolean;
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_answers:GraphicContainer;
      
      public var tx_background:Texture;
      
      public var lbl_title_popup:Label;
      
      public var lbl_description:TextArea;
      
      public var btn_ok:ButtonContainer;
      
      public function PollPopup()
      {
         this._btnAnswers = new Array();
         super();
      }
      
      public function main(param:Object) : void
      {
         var bonusHeightBg:int = 0;
         var btn:ButtonContainer = null;
         var btnTx:Texture = null;
         var btnLbl:Label = null;
         var heightOffset:int = 0;
         var answerContent:String = null;
         var stateChangingProperties:Array = null;
         this.soundApi.playSound(SoundTypeEnum.POPUP_INFO);
         this.btn_ok.soundId = SoundEnum.OK_BUTTON;
         this.lbl_title_popup.text = param.title;
         this.lbl_description.text = param.content;
         this._validCallBack = param.validCallBack;
         this._cancelCallback = param.cancelCallback;
         this._onlyOneAnswer = param.onlyOneAnswer;
         var labelHeight:int = this.uiApi.me().getConstant("labelHeight");
         var labelPosX:int = this.uiApi.me().getConstant("labelPosX");
         var textureSize:int = this.uiApi.me().getConstant("textureSize");
         var labelWidth:int = this.lbl_description.width - 20 - labelPosX - textureSize - this.ctr_answers.x;
         var cssUri:Uri = this.uiApi.createUri(this.uiApi.me().getConstant("css") + "normal.css");
         var btnTxUri:Uri = !!this._onlyOneAnswer ? this.uiApi.createUri(this.uiApi.me().getConstant("uriRadio")) : this.uiApi.createUri(this.uiApi.me().getConstant("uriCheck"));
         var numberCheckboxes:int = param.answers.length;
         var lblHidden:Label = this.uiApi.createComponent("Label") as Label;
         lblHidden.width = this.lbl_description.width - 20;
         lblHidden.multiline = true;
         lblHidden.wordWrap = true;
         lblHidden.fixedHeight = false;
         lblHidden.css = cssUri;
         lblHidden.text = param.content;
         bonusHeightBg = lblHidden.height - this.lbl_description.height;
         this.lbl_description.height = lblHidden.height;
         this.ctr_answers.width = this.lbl_description.width - 20;
         for(var i:uint = 0; i < numberCheckboxes; i++)
         {
            btn = this.uiApi.createContainer("ButtonContainer") as ButtonContainer;
            btn.width = this.lbl_description.width - 20;
            btn.height = labelHeight;
            btn.y = heightOffset;
            btn.name = "checkBtn" + (i + 1);
            if(this._onlyOneAnswer)
            {
               btn.radioMode = true;
               btn.radioGroup = "answerGroup";
            }
            else
            {
               btn.radioMode = false;
            }
            btnTx = this.uiApi.createComponent("Texture") as Texture;
            btnTx.y = 8;
            btnTx.width = textureSize;
            btnTx.height = textureSize;
            btnTx.uri = btnTxUri;
            btnTx.autoGrid = true;
            btnTx.name = btn.name + "_tx";
            this.uiApi.me().registerId(btnTx.name,this.uiApi.createContainer("GraphicElement",btnTx,new Array(),btnTx.name));
            btnTx.finalize();
            answerContent = this.uiApi.replaceKey(param.answers[i]);
            lblHidden.width = labelWidth;
            lblHidden.text = answerContent;
            btnLbl = this.uiApi.createComponent("Label") as Label;
            btnLbl.width = labelWidth;
            btnLbl.height = lblHidden.height;
            btnLbl.x = labelPosX + textureSize;
            btnLbl.verticalAlign = "center";
            btnLbl.css = cssUri;
            btnLbl.wordWrap = true;
            btnLbl.multiline = true;
            btnLbl.text = answerContent;
            btn.addChild(btnTx);
            btn.addChild(btnLbl);
            heightOffset += lblHidden.height + 10;
            stateChangingProperties = new Array();
            stateChangingProperties[StatesEnum.STATE_NORMAL] = new Array();
            stateChangingProperties[StatesEnum.STATE_NORMAL][btnTx.name] = new Array();
            stateChangingProperties[StatesEnum.STATE_NORMAL][btnTx.name]["gotoAndStop"] = "normal";
            stateChangingProperties[StatesEnum.STATE_OVER] = new Array();
            stateChangingProperties[StatesEnum.STATE_OVER][btnTx.name] = new Array();
            stateChangingProperties[StatesEnum.STATE_OVER][btnTx.name]["gotoAndStop"] = "over";
            stateChangingProperties[StatesEnum.STATE_CLICKED] = new Array();
            stateChangingProperties[StatesEnum.STATE_CLICKED][btnTx.name] = new Array();
            stateChangingProperties[StatesEnum.STATE_CLICKED][btnTx.name]["gotoAndStop"] = "pressed";
            stateChangingProperties[StatesEnum.STATE_SELECTED] = new Array();
            stateChangingProperties[StatesEnum.STATE_SELECTED][btnTx.name] = new Array();
            stateChangingProperties[StatesEnum.STATE_SELECTED][btnTx.name]["gotoAndStop"] = "selected";
            btn.changingStateData = stateChangingProperties;
            this.uiApi.addComponentHook(btn,"onRelease");
            this.ctr_answers.addChild(btn);
            this._btnAnswers.push(btn);
            btn.finalize();
         }
         this.ctr_answers.height = heightOffset + 10;
         bonusHeightBg += this.ctr_answers.height;
         this.tx_background.height += bonusHeightBg;
         this.uiApi.me().render();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var answers:Array = null;
         var btn:ButtonContainer = null;
         if(target.name.indexOf("checkBtn") == 0)
         {
            if(this._onlyOneAnswer)
            {
               (target as ButtonContainer).selected = true;
            }
            else
            {
               (target as ButtonContainer).selected = !(target as ButtonContainer).selected;
            }
            return;
         }
         if(target == this.btn_ok)
         {
            if(this._validCallBack != null)
            {
               answers = [];
               for each(btn in this._btnAnswers)
               {
                  if(btn.selected)
                  {
                     answers.push(int(btn.name.substr(8)));
                  }
               }
               this._validCallBack(answers);
            }
         }
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      public function unload() : void
      {
         this.sysApi.dispatchHook(HookList.ClosePopup);
      }
   }
}
