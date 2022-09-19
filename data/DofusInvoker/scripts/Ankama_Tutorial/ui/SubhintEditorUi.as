package Ankama_Tutorial.ui
{
   import Ankama_Common.Common;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextAreaInput;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.tutorial.SubhintWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.OpenSubhintListAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.TimerEvent;
   import flash.filesystem.File;
   import flash.net.FileFilter;
   import flash.utils.Dictionary;
   
   public class SubhintEditorUi
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _subhintArrayOfCurrentUi:Array;
      
      public var allSubhintsInUisOpened:Array;
      
      private var _currentSubhintIndex:int = 0;
      
      private var _posChoices:Array;
      
      public var currentSubhint:SubhintWrapper;
      
      private var _dataToSend:Object;
      
      private var _maxTtWidth:int = 300;
      
      private var _minTtWidth:int = 30;
      
      private var _arrowInputList:Array;
      
      private var _currentInputToUpdate:Input;
      
      private var _timer:BenchmarkTimer;
      
      private var _pressingInputArrow:Boolean = false;
      
      private var _canUpdateInput:Boolean = true;
      
      private var _increaseSpeedValue:int = 0;
      
      private var _increasing:Boolean = false;
      
      private var _previewMode:Boolean = false;
      
      private var _createOrChange:String = "";
      
      private var _totalName:String = "";
      
      private var _realUri:String = "";
      
      public var btn_subhintList:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_createSubhint:ButtonContainer;
      
      public var btn_lbl_btn_createSubhint:Label;
      
      public var btn_changeAnchoredElement:ButtonContainer;
      
      public var btn_cancelChangeAnchoredElement:ButtonContainer;
      
      public var btn_previsualiseSubhint:ButtonContainer;
      
      public var btn_deleteSubhint:ButtonContainer;
      
      public var btn_validateSubhint:ButtonContainer;
      
      public var btn_prevSubhint:ButtonContainer;
      
      public var btn_nextSubhint:ButtonContainer;
      
      public var btn_selectUri:ButtonContainer;
      
      public var btn_upArrowTtOffsetX:ButtonContainer;
      
      public var btn_downArrowTtOffsetX:ButtonContainer;
      
      public var btn_upArrowTtOffsetY:ButtonContainer;
      
      public var btn_downArrowTtOffsetY:ButtonContainer;
      
      public var btn_upArrowTtWidth:ButtonContainer;
      
      public var btn_downArrowTtWidth:ButtonContainer;
      
      public var btn_upArrowShOffsetX:ButtonContainer;
      
      public var btn_downArrowShOffsetX:ButtonContainer;
      
      public var btn_upArrowShOffsetY:ButtonContainer;
      
      public var btn_downArrowShOffsetY:ButtonContainer;
      
      public var btn_guidedPreview:ButtonContainer;
      
      public var btn_dropTabName:ButtonContainer;
      
      public var lbl_ttText:Label;
      
      public var lbl_ttUri:Label;
      
      public var lbl_ttAnchor:Label;
      
      public var lbl_ttOffsetXY:Label;
      
      public var lbl_ttWidth:Label;
      
      public var lbl_uiName:Label;
      
      public var lbl_anchoredElement:Label;
      
      public var lbl_subhintAnchor:Label;
      
      public var lbl_shOffsetXY:Label;
      
      public var lbl_highlight:Label;
      
      public var lbl_widthHeight:Label;
      
      public var lbl_order:Label;
      
      public var cb_shPos:ComboBox;
      
      public var lbl_uiNameDisplay:Label;
      
      public var inp_anchoredElement:Input;
      
      public var inp_highlight:Input;
      
      public var inp_width:Input;
      
      public var inp_height:Input;
      
      public var inp_offsetX:Input;
      
      public var inp_offsetY:Input;
      
      public var inp_order:Input;
      
      public var inp_ttText:TextAreaInput;
      
      public var inp_ttUri:Input;
      
      public var cb_ttPos:ComboBox;
      
      public var inp_ttOffsetX:Input;
      
      public var inp_ttOffsetY:Input;
      
      public var inp_ttWidth:Input;
      
      public function SubhintEditorUi()
      {
         super();
      }
      
      public function main(params:Object) : void
      {
         var input:Input = null;
         var arrowButton:ButtonContainer = null;
         var uiArr:Array = null;
         var uirc:UiRootContainer = null;
         var inputs:Array = [this.inp_anchoredElement,this.inp_highlight,this.inp_width,this.inp_height,this.inp_offsetX,this.inp_offsetY,this.inp_order,this.inp_ttUri,this.inp_ttOffsetX,this.inp_ttOffsetY,this.inp_ttWidth];
         for each(input in inputs)
         {
            this.uiApi.addComponentHook(input,ComponentHookList.ON_CHANGE);
         }
         this.uiApi.addComponentHook(this.inp_ttText,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.cb_shPos,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.cb_ttPos,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.btn_guidedPreview,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_dropTabName,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_previsualiseSubhint,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.lbl_ttText,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_ttUri,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_ttAnchor,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_ttOffsetXY,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_ttWidth,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_uiName,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_anchoredElement,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_subhintAnchor,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_shOffsetXY,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_highlight,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_widthHeight,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_order,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_ttText,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_ttUri,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_ttAnchor,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_ttOffsetXY,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_ttWidth,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_uiName,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_anchoredElement,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_subhintAnchor,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_shOffsetXY,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_highlight,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_widthHeight,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_order,ComponentHookList.ON_ROLL_OUT);
         this.inp_ttText.addEventListener(FocusEvent.FOCUS_IN,this.onGainFocus);
         this._arrowInputList = [this.btn_upArrowTtOffsetX,this.btn_downArrowTtOffsetX,this.btn_upArrowTtOffsetY,this.btn_downArrowTtOffsetY,this.btn_upArrowTtWidth,this.btn_downArrowTtWidth,this.btn_upArrowShOffsetX,this.btn_downArrowShOffsetX,this.btn_upArrowShOffsetY,this.btn_downArrowShOffsetY];
         for each(arrowButton in this._arrowInputList)
         {
            this.uiApi.addComponentHook(arrowButton,ComponentHookList.ON_PRESS);
            this.uiApi.addComponentHook(arrowButton,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(arrowButton,ComponentHookList.ON_RELEASE_OUTSIDE);
            this.uiApi.addComponentHook(arrowButton,ComponentHookList.ON_MOUSE_UP);
         }
         this.sysApi.addHook(HookList.SubhintEditorUpdated,this.onSubhintEditorUpdated);
         this.sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         this.sysApi.addHook(BeriliaHookList.UiUnloaded,this.onUiUnloaded);
         this.currentSubhint = null;
         this._posChoices = ["TOPLEFT (0)","TOP (1)","TOPRIGHT (2)","LEFT (3)","CENTER (4)","RIGHT (5)","BOTTOMLEFT (6)","BOTTOM (7)","BOTTOMRIGHT (8)"];
         this.cb_shPos.dataProvider = this._posChoices;
         this.cb_shPos.value = this._posChoices[3];
         this.cb_ttPos.dataProvider = this._posChoices;
         this.cb_ttPos.value = this._posChoices[0];
         this.btn_previsualiseSubhint.selected = true;
         this.getAllSubhintsInUisOpened();
         this.resetBaseData();
         uiArr = this.hintsApi.getAllOpenedUiWithSubHints();
         for each(uirc in uiArr)
         {
            uirc.getElement("btn_help").visible = true;
         }
      }
      
      private function resetBaseData() : void
      {
         this.closeSubhintPreview();
         this.enableInputsAndButtons(false);
         this.hintsApi.getSubhintInspector().enable = false;
         this.currentSubhint = null;
         this._currentSubhintIndex = 0;
         this._subhintArrayOfCurrentUi = null;
         this._totalName = "";
         this._realUri = "";
         this.inp_ttText.text = "";
         this.inp_ttUri.text = "";
         this.cb_ttPos.value = this._posChoices[3];
         this.inp_ttOffsetX.text = "5";
         this.inp_ttOffsetY.text = "5";
         this.inp_ttWidth.text = "300";
         this.lbl_uiNameDisplay.text = "";
         this.inp_anchoredElement.text = "";
         this.cb_shPos.value = this._posChoices[0];
         this.inp_highlight.text = "";
         this.inp_width.text = "20";
         this.inp_height.text = "20";
         this.inp_offsetX.text = "0";
         this.inp_offsetY.text = "0";
         this.inp_order.text = "1";
      }
      
      private function onUiLoaded(uiName:String) : void
      {
         if(uiName == UIEnum.SUBHINT_LIST)
         {
            this.uiApi.me().setOnTop();
            this.uiApi.me().setOnTopBeforeMe.push(this.uiApi.getUi(UIEnum.SUBHINT_LIST));
         }
         if(this.uiApi.getUi(uiName) && this.uiApi.getUi(uiName).getElement("btn_help"))
         {
            this.uiApi.getUi(uiName).getElement("btn_help").visible = true;
         }
         if((this.currentSubhint || this.allSubhintsInUisOpened.length <= 0) && uiName.indexOf("tooltip_") == -1 && uiName.indexOf("popup") == -1 && uiName.indexOf("extNotif") == -1)
         {
            this.showCurrentSubhintInEditor();
         }
      }
      
      private function onUiUnloaded(uiName:String) : void
      {
         if(uiName.indexOf("tooltip_") != -1 || uiName.indexOf("popup") != -1 || uiName.indexOf("extNotif") != -1)
         {
            return;
         }
         this.closeSubhintPreview();
         if(uiName == UIEnum.SUBHINT_LIST)
         {
            this.uiApi.me().setOnTopBeforeMe = [];
         }
         if(this.allSubhintsInUisOpened.length > 0)
         {
            this.showCurrentSubhintInEditor();
         }
         else if(this.uiApi.getUi(this.lbl_uiNameDisplay.text.split("_")[0]))
         {
            this.resetBaseData();
         }
      }
      
      private function onSubhintEditorUpdated(data:SubhintWrapper) : void
      {
         this.subhintEditorUpdated(data,true);
      }
      
      public function subhintEditorUpdated(data:SubhintWrapper, withInspector:Boolean = false) : void
      {
         var myPattern:RegExp = null;
         var imagePath:String = null;
         if(this._createOrChange == "create")
         {
            this.resetBaseData();
         }
         var uiRoot:UiRootContainer = this.hintsApi.getUiClass(data.hint_parent_uid.split("_")[0]) as UiRootContainer;
         if(withInspector)
         {
            if(uiRoot.uiClass.hasOwnProperty("currentTabName") && uiRoot.uiClass.currentTabName != "")
            {
               this._totalName = data.hint_parent_uid + "_" + uiRoot.uiClass.currentTabName;
            }
            else
            {
               this._totalName = data.hint_parent_uid;
            }
         }
         else
         {
            this._totalName = data.hint_parent_uid.split("_")[0] + (uiRoot.uiClass.hasOwnProperty("currentTabName") && uiRoot.uiClass.currentTabName != "" ? "_" + uiRoot.uiClass.currentTabName : "");
         }
         this._subhintArrayOfCurrentUi = this.getSubhintArrayOfCurrentUi(data.hint_parent_uid);
         this.lbl_uiNameDisplay.text = data.hint_parent_uid;
         this.inp_anchoredElement.text = data.hint_anchored_element;
         this.enableInputsAndButtons(true);
         if(withInspector)
         {
            this.closeSubhintPreview();
            if(data.hint_anchored_element.indexOf("btn_help") != -1)
            {
               this.inp_highlight.text = "";
               this.inp_width.text = "25";
               this.inp_height.text = "25";
            }
            else
            {
               this.inp_highlight.text = data.hint_anchored_element;
            }
            if(this._createOrChange == "create")
            {
               this.inp_order.text = this.setOrderOfNewSubhint().toString();
            }
            else if(this._createOrChange == "change")
            {
               if(data.hint_anchored_element.indexOf("btn_help") != -1)
               {
                  this.cb_shPos.value = this._posChoices[0];
               }
               else
               {
                  this.inp_width.text = "20";
                  this.inp_height.text = "20";
               }
               this.btn_cancelChangeAnchoredElement.visible = false;
               this.btn_changeAnchoredElement.visible = true;
            }
            this._createOrChange = "";
         }
         else
         {
            this.getAllSubhintsInUisOpened();
            this._currentSubhintIndex = this.allSubhintsInUisOpened.indexOf(data as SubhintWrapper);
            this.currentSubhint = SubhintWrapper(data);
            this.inp_highlight.text = data.hint_highlighted_element;
            this.inp_ttText.text = "" + data.hint_tooltip_text;
            myPattern = /"/g;
            imagePath = data.hint_tooltip_url;
            imagePath = imagePath.replace(myPattern,"");
            this.inp_ttUri.text = imagePath;
            this._realUri = imagePath.substring(imagePath.indexOf("content\\") + 8);
            this.cb_ttPos.value = this._posChoices[data.hint_tooltip_position_enum];
            this.inp_ttOffsetX.text = "" + data.hint_tooltip_offset_x;
            this.inp_ttOffsetY.text = "" + data.hint_tooltip_offset_y;
            this.inp_ttWidth.text = "" + data.hint_tooltip_width;
            this.cb_shPos.value = this._posChoices[data.hint_anchor];
            this.inp_offsetX.text = "" + data.hint_position_x;
            this.inp_offsetY.text = "" + data.hint_position_y;
            if(data.hint_anchored_element.indexOf("btn_help") == -1)
            {
               this.inp_width.text = "" + data.hint_width;
               this.inp_height.text = "" + data.hint_height;
            }
            else
            {
               this.inp_width.text = "25";
               this.inp_height.text = "25";
            }
            this.inp_order.text = "" + data.hint_order;
            this.btn_deleteSubhint.disabled = false;
            if(this._currentSubhintIndex <= 0)
            {
               this.btn_prevSubhint.disabled = true;
            }
            else
            {
               this.btn_prevSubhint.disabled = false;
            }
            if(this._currentSubhintIndex >= this.allSubhintsInUisOpened.length - 1)
            {
               this.btn_nextSubhint.disabled = true;
            }
            else
            {
               this.btn_nextSubhint.disabled = false;
            }
            if(this.uiApi.getUi(UIEnum.SUBHINT_LIST) && this.uiApi.getUi(UIEnum.SUBHINT_LIST).uiClass.gd_subhints.selectedItem != this.currentSubhint)
            {
               this.uiApi.getUi(UIEnum.SUBHINT_LIST).uiClass.gd_subhints.selectedItem = this.currentSubhint;
            }
         }
         if(this.btn_previsualiseSubhint.selected)
         {
            this._previewMode = true;
            this.updateSubhintWrapper("preview");
         }
      }
      
      public function unload() : void
      {
         var uirc:UiRootContainer = null;
         if(this.uiApi.getUi("SubhintList"))
         {
            this.uiApi.unloadUi("SubhintList");
         }
         this.closeSubhintPreview();
         this.hintsApi.getSubhintInspector().enable = false;
         var uiArr:Array = this.hintsApi.getAllOpenedUiWithSubHints();
         for each(uirc in uiArr)
         {
            uirc.getElement("btn_help").visible = this.hintsApi.canDisplayHelp(uirc);
         }
      }
      
      public function onPress(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_upArrowTtOffsetX:
               this.setInputToUpdate(this.inp_ttOffsetX,true);
               break;
            case this.btn_downArrowTtOffsetX:
               this.setInputToUpdate(this.inp_ttOffsetX,false);
               break;
            case this.btn_upArrowTtOffsetY:
               this.setInputToUpdate(this.inp_ttOffsetY,true);
               break;
            case this.btn_downArrowTtOffsetY:
               this.setInputToUpdate(this.inp_ttOffsetY,false);
               break;
            case this.btn_upArrowTtWidth:
               this.setInputToUpdate(this.inp_ttWidth,true);
               break;
            case this.btn_downArrowTtWidth:
               this.setInputToUpdate(this.inp_ttWidth,false);
               break;
            case this.btn_upArrowShOffsetX:
               this.setInputToUpdate(this.inp_offsetX,true);
               break;
            case this.btn_downArrowShOffsetX:
               this.setInputToUpdate(this.inp_offsetX,false);
               break;
            case this.btn_upArrowShOffsetY:
               this.setInputToUpdate(this.inp_offsetY,true);
               break;
            case this.btn_downArrowShOffsetY:
               this.setInputToUpdate(this.inp_offsetY,false);
         }
      }
      
      private function setInputToUpdate(input:Input, increase:Boolean) : void
      {
         if(this._canUpdateInput)
         {
            this._pressingInputArrow = true;
            this.updateInput(input,increase);
         }
      }
      
      private function updateInput(input:Input, increase:Boolean) : void
      {
         this._currentInputToUpdate = input;
         var currentValue:int = int(this._currentInputToUpdate.text);
         var limitValue:int = 0;
         if(increase)
         {
            if(this._currentInputToUpdate == this.inp_ttWidth)
            {
               limitValue = 300;
            }
            else if(this._currentInputToUpdate.maxChars == 2)
            {
               limitValue = 99;
            }
            else if(this._currentInputToUpdate.maxChars == 3)
            {
               limitValue = 999;
            }
            else if(this._currentInputToUpdate.maxChars == 4)
            {
               limitValue = 9999;
            }
            if(currentValue < limitValue)
            {
               this._canUpdateInput = false;
               currentValue++;
               this._increaseSpeedValue += 2;
               this._currentInputToUpdate.text = currentValue.toString();
               this._increasing = true;
               this.startTimer(Math.max(10,100 - this._increaseSpeedValue));
            }
         }
         else
         {
            if(this._currentInputToUpdate == this.inp_ttWidth || this._currentInputToUpdate == this.inp_ttOffsetX || this._currentInputToUpdate == this.inp_ttOffsetY || this._currentInputToUpdate == this.inp_width || this._currentInputToUpdate == this.inp_height)
            {
               limitValue = 0;
            }
            else if(this._currentInputToUpdate.maxChars == 2)
            {
               limitValue = -9;
            }
            else if(this._currentInputToUpdate.maxChars == 3)
            {
               limitValue = -99;
            }
            else if(this._currentInputToUpdate.maxChars == 4)
            {
               limitValue = -999;
            }
            if(currentValue > limitValue)
            {
               this._canUpdateInput = false;
               currentValue--;
               this._increaseSpeedValue += 2;
               this._currentInputToUpdate.text = currentValue.toString();
               this._increasing = false;
               this.startTimer(Math.max(10,100 - this._increaseSpeedValue));
            }
         }
      }
      
      private function startTimer(duration:uint) : void
      {
         this._timer = new BenchmarkTimer(duration,0,"SubhintEditorUi._timer");
         this._timer.addEventListener(TimerEvent.TIMER,this.onTimerEnd);
         this._timer.start();
      }
      
      private function onTimerEnd(pEvent:TimerEvent) : void
      {
         if(this._timer)
         {
            this._timer.removeEventListener(TimerEvent.TIMER,this.onTimerEnd);
            this._timer = null;
            this._canUpdateInput = true;
            if(this._pressingInputArrow)
            {
               this.updateInput(this._currentInputToUpdate,this._increasing);
            }
         }
      }
      
      public function updateChangeButton(modify:Boolean) : void
      {
         this.btn_cancelChangeAnchoredElement.visible = modify;
         this.btn_changeAnchoredElement.visible = !modify;
         this._createOrChange = !!modify ? "change" : "";
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = "";
         switch(target)
         {
            case this.lbl_ttText:
               text = "Texte de la bulle d\'aide (Description OU Image obligatoire)";
               break;
            case this.lbl_ttUri:
               text = "Image de la bulle d\'aide (Description OU Image obligatoire)";
               break;
            case this.lbl_ttAnchor:
               text = "Côté du point d\'aide où sera placée l\'infobulle";
               break;
            case this.lbl_ttOffsetXY:
               text = "Ecart entre la bulle et le point d\'aide (en pixels)";
               break;
            case this.lbl_ttWidth:
               text = "Largeur de la bulle d\'aide (en pixels)";
               break;
            case this.lbl_uiName:
               text = "Nom de l\'interface qui contiendra cette bulle d\'aide";
               break;
            case this.lbl_anchoredElement:
               text = "Elément auquel le point d\'aide est accroché (Obligatoire)";
               break;
            case this.lbl_subhintAnchor:
               text = "Point de l\'élément d\'ancrage où sera placé le point d\'aide";
               break;
            case this.lbl_shOffsetXY:
               text = "Ecart entre le point d\'aide et l\'élément d\'ancrage (en pixels)";
               break;
            case this.lbl_highlight:
               text = "Elément qui sera encadré au survol du point d\'aide";
               break;
            case this.lbl_widthHeight:
               text = "Largeur et hauteur du point d\'aide (par défaut la taille de la texture en pixels)";
               break;
            case this.lbl_order:
               text = "Numéro d\'apparition du point d\'aide en mode guidé (Obligatoire)";
         }
         this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",7,1,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var shArr:Array = null;
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(UIEnum.SUBHINT_LIST);
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_subhintList:
               this.sysApi.sendAction(new OpenSubhintListAction([]));
               break;
            case this.btn_createSubhint:
               this.closeSubhintPreview();
               if(this._createOrChange != "create")
               {
                  this.btn_lbl_btn_createSubhint.text = this.uiApi.getText("ui.common.cancel");
                  this.hintsApi.getSubhintInspector().enable = true;
                  this.enableInputsAndButtons(false);
                  this._createOrChange = "create";
               }
               else
               {
                  this.btn_lbl_btn_createSubhint.text = this.uiApi.getText("ui.uiTutorial.createSubhint");
                  this.hintsApi.getSubhintInspector().enable = false;
                  this.updateChangeButton(false);
                  if(this.lbl_uiNameDisplay.text && this.lbl_uiNameDisplay.text != "")
                  {
                     this.enableInputsAndButtons(true);
                  }
                  else
                  {
                     this.resetBaseData();
                  }
               }
               break;
            case this.btn_dropTabName:
               if(this.btn_dropTabName.selected)
               {
                  this.lbl_uiNameDisplay.text = this._totalName.split("_")[0];
               }
               else
               {
                  this.lbl_uiNameDisplay.text = this._totalName;
               }
               shArr = this.getSubhintArrayOfCurrentUi(this.lbl_uiNameDisplay.text);
               if(shArr)
               {
                  this._subhintArrayOfCurrentUi = shArr;
                  if(this.currentSubhint)
                  {
                     if(this.lbl_uiNameDisplay.text == this.currentSubhint.hint_parent_uid)
                     {
                        this.inp_order.text = "" + this.currentSubhint.hint_order;
                     }
                     else
                     {
                        this.inp_order.text = "" + shArr.length + 1;
                     }
                  }
                  else
                  {
                     this.inp_order.text = "" + shArr.length + 1;
                  }
               }
               else
               {
                  this.inp_order.text = "1";
               }
               break;
            case this.btn_changeAnchoredElement:
               this.updateChangeButton(true);
               this.hintsApi.getSubhintInspector().enable = true;
               break;
            case this.btn_cancelChangeAnchoredElement:
               this.updateChangeButton(false);
               this.hintsApi.getSubhintInspector().enable = false;
               break;
            case this.btn_validateSubhint:
               this.updateChangeButton(false);
               this.closeSubhintPreview();
               this.hintsApi.getSubhintInspector().enable = false;
               if(this.currentSubhint)
               {
                  this.updateSubhintWrapper("update");
               }
               else
               {
                  this.updateSubhintWrapper("create");
               }
               break;
            case this.btn_previsualiseSubhint:
               this.updateChangeButton(false);
               this.hintsApi.getSubhintInspector().enable = false;
               if(!this._previewMode)
               {
                  this.updateSubhintWrapper("preview");
               }
               else
               {
                  this.closeSubhintPreview();
               }
               this.btn_guidedPreview.disabled = !this._previewMode;
               break;
            case this.btn_deleteSubhint:
               this.updateChangeButton(false);
               this.closeSubhintPreview();
               this.hintsApi.getSubhintInspector().enable = false;
               this.updateSubhintWrapper("delete");
               break;
            case this.btn_prevSubhint:
               this.updateChangeButton(false);
               this.closeSubhintPreview();
               this.showPrevSubhint();
               if(this.uiApi.getUi(UIEnum.SUBHINT_LIST))
               {
                  this.uiApi.getUi(UIEnum.SUBHINT_LIST).uiClass.gd_subhints.selectedItem = this.currentSubhint;
               }
               break;
            case this.btn_nextSubhint:
               this.updateChangeButton(false);
               this.closeSubhintPreview();
               this.showNextSubhint();
               if(this.uiApi.getUi(UIEnum.SUBHINT_LIST))
               {
                  this.uiApi.getUi(UIEnum.SUBHINT_LIST).uiClass.gd_subhints.selectedItem = this.currentSubhint;
               }
               break;
            case this.btn_selectUri:
               this.updateChangeButton(false);
               this.selectDirectory();
               break;
            case this.btn_guidedPreview:
               if(this._previewMode)
               {
                  this.closeSubhintPreview();
                  if(this._dataToSend)
                  {
                     this._dataToSend.hint_tooltip_guided = this.btn_guidedPreview.selected;
                     this._previewMode = true;
                     this.hintsApi.previewSubhint(this._dataToSend);
                  }
               }
               break;
            case this.btn_upArrowTtOffsetX:
            case this.btn_downArrowTtOffsetX:
            case this.btn_upArrowTtOffsetY:
            case this.btn_downArrowTtOffsetY:
            case this.btn_upArrowTtWidth:
            case this.btn_downArrowTtWidth:
            case this.btn_upArrowShOffsetX:
            case this.btn_downArrowShOffsetX:
            case this.btn_upArrowShOffsetY:
            case this.btn_downArrowShOffsetY:
               this._pressingInputArrow = false;
               this._increaseSpeedValue = 0;
               if(this._previewMode && this._dataToSend)
               {
                  this.updateSubhintWrapper("preview");
               }
         }
      }
      
      public function onMouseUp(target:GraphicContainer) : void
      {
         this.onRelease(target);
      }
      
      public function onReleaseOutside(target:GraphicContainer) : void
      {
         this.onRelease(target);
      }
      
      public function onSelectItem(target:ComboBox, selectMethod:uint, isNewSelection:Boolean) : void
      {
         switch(target)
         {
            case this.cb_shPos:
            case this.cb_ttPos:
               if(this._previewMode && this._dataToSend)
               {
                  this.updateSubhintWrapper("preview");
               }
         }
      }
      
      public function onChange(target:Object) : void
      {
         var currentWidthInput:int = 0;
         var currentOrderInput:int = 0;
         var pattern:RegExp = null;
         var input:Input = null;
         var myPattern:RegExp = null;
         switch(target)
         {
            case this.inp_ttWidth:
               currentWidthInput = int(this.inp_ttWidth.text);
               if(currentWidthInput > this._maxTtWidth)
               {
                  this.inp_ttWidth.text = this._maxTtWidth.toString();
               }
               else if(currentWidthInput < this._minTtWidth)
               {
                  this.inp_ttWidth.text = this._minTtWidth.toString();
               }
               break;
            case this.inp_order:
               if(this.inp_order.text == "")
               {
                  this.inp_order.addEventListener(FocusEvent.FOCUS_OUT,this.onLoseFocus);
                  break;
               }
               currentOrderInput = int(this.inp_order.text);
               if(currentOrderInput < 1 || !this._subhintArrayOfCurrentUi && this.inp_order.text != "1")
               {
                  this.inp_order.text = "1";
               }
               if(this._subhintArrayOfCurrentUi && currentOrderInput > this._subhintArrayOfCurrentUi.length + 1)
               {
                  this.inp_order.text = (this._subhintArrayOfCurrentUi.length + 1).toString();
               }
               break;
            case this.inp_offsetX:
            case this.inp_offsetY:
               pattern = /-/g;
               input = target as Input;
               if(input.text.indexOf("-") != -1 && input.text.indexOf("-") == 0)
               {
                  if(input.text.match(/-/g).length > 1)
                  {
                     input.text = "-" + input.text.replace(pattern,"");
                  }
                  input.maxChars = 4;
               }
               else if(input.text.indexOf("-") != -1 && input.text.indexOf("-") != 0)
               {
                  input.text = input.text.replace(pattern,"");
                  input.maxChars = 3;
               }
               else if(input.maxChars != 3)
               {
                  input.maxChars = 3;
               }
               break;
            case this.inp_ttUri:
               if(this.inp_ttUri.text.indexOf("\"") != -1)
               {
                  myPattern = /"/g;
                  this.inp_ttUri.text = this.inp_ttUri.text.replace(myPattern,"");
               }
               this._realUri = this.inp_ttUri.text.substring(this.inp_ttUri.text.indexOf("]") + 1);
               break;
            case this.inp_ttText:
               this.inp_ttText.addEventListener(FocusEvent.FOCUS_IN,this.onGainFocus);
         }
         if(this._previewMode && !this._pressingInputArrow && this._dataToSend)
         {
            this.updateSubhintWrapper("preview");
         }
      }
      
      private function onGainFocus(e:FocusEvent) : void
      {
         switch(e.target)
         {
            case this.inp_ttText:
               this.inp_ttText.removeEventListener(FocusEvent.FOCUS_IN,this.onGainFocus);
               this.inp_ttText.focus();
               this.inp_ttText.setSelection(8388607,8388607);
         }
      }
      
      private function onLoseFocus(e:FocusEvent) : void
      {
         switch(e.target)
         {
            case this.inp_order:
               this.inp_order.removeEventListener(FocusEvent.FOCUS_OUT,this.onLoseFocus);
               if(this.inp_order.text == "")
               {
                  this.inp_order.text = !!this.currentSubhint ? "" + this.currentSubhint.hint_order : "1";
               }
         }
      }
      
      private function getSubhintArrayOfCurrentUi(parentUID:String) : Array
      {
         return this.hintsApi.getSubhintDataArrayWithParentUID(parentUID);
      }
      
      private function enableInputsAndButtons(enable:Boolean) : void
      {
         var arrowButtonToDisabled:ButtonContainer = null;
         this.inp_anchoredElement.disabled = !enable;
         this.cb_shPos.disabled = !enable;
         this.inp_highlight.disabled = !enable;
         this.inp_width.disabled = !enable;
         this.inp_height.disabled = !enable;
         this.inp_offsetX.disabled = !enable;
         this.inp_offsetY.disabled = !enable;
         this.inp_order.disabled = !enable;
         this.inp_ttText.disabled = !enable;
         this.inp_ttUri.disabled = !enable;
         this.cb_ttPos.disabled = !enable;
         this.inp_ttOffsetX.disabled = !enable;
         this.inp_ttOffsetY.disabled = !enable;
         this.inp_ttWidth.disabled = !enable;
         this.btn_previsualiseSubhint.disabled = !enable;
         this.btn_validateSubhint.disabled = !enable;
         this.btn_selectUri.disabled = !enable;
         this.btn_changeAnchoredElement.disabled = !enable;
         this.btn_cancelChangeAnchoredElement.disabled = !enable;
         this.btn_dropTabName.disabled = !enable;
         for each(arrowButtonToDisabled in this._arrowInputList)
         {
            arrowButtonToDisabled.disabled = !enable;
         }
         this.btn_guidedPreview.disabled = !!enable ? !this.btn_previsualiseSubhint.selected : true;
         if(enable)
         {
            this.btn_lbl_btn_createSubhint.text = this.uiApi.getText("ui.uiTutorial.createSubhint");
            this.btn_dropTabName.selected = this.lbl_uiNameDisplay.text.split("_").length < 2;
            if(this.currentSubhint)
            {
               this.btn_deleteSubhint.disabled = false;
            }
         }
         else
         {
            this.btn_deleteSubhint.disabled = true;
            this.btn_dropTabName.selected = false;
         }
      }
      
      private function getAllSubhintsInUisOpened() : void
      {
         var key:* = undefined;
         var uiName:Array = null;
         var subhints:Array = null;
         var sh:SubhintWrapper = null;
         this.btn_prevSubhint.disabled = true;
         this.allSubhintsInUisOpened = [];
         var dict:Dictionary = this.hintsApi.getSubhintData() as Dictionary;
         for(key in dict)
         {
            uiName = key.split("_");
            if(this.uiApi.getUiByName(uiName[0]))
            {
               subhints = this.hintsApi.getSubhintDataArrayWithParentUID(key);
               for each(sh in subhints)
               {
                  if(sh)
                  {
                     this.allSubhintsInUisOpened.push(sh);
                  }
               }
            }
         }
         this.btn_nextSubhint.disabled = this.allSubhintsInUisOpened.length <= 0;
      }
      
      private function showCurrentSubhintInEditor() : void
      {
         this.getAllSubhintsInUisOpened();
         if(this.allSubhintsInUisOpened.length > 0)
         {
            if(this.currentSubhint)
            {
               this._currentSubhintIndex = this.allSubhintsInUisOpened.indexOf(this.currentSubhint);
               if(this._currentSubhintIndex == -1 || this._currentSubhintIndex >= this.allSubhintsInUisOpened.length)
               {
                  this._currentSubhintIndex = 0;
               }
               this.subhintEditorUpdated(this.allSubhintsInUisOpened[this._currentSubhintIndex]);
            }
         }
         else if(!this.uiApi.getUiByName(this.lbl_uiNameDisplay.text.split("_")[0]))
         {
            this.resetBaseData();
         }
      }
      
      private function showNextSubhint() : void
      {
         if(!this.allSubhintsInUisOpened || this.allSubhintsInUisOpened.length <= 1)
         {
            return;
         }
         if(this._currentSubhintIndex < this.allSubhintsInUisOpened.length - 1)
         {
            ++this._currentSubhintIndex;
            this.subhintEditorUpdated(this.allSubhintsInUisOpened[this._currentSubhintIndex]);
         }
      }
      
      private function showPrevSubhint() : void
      {
         if(!this.allSubhintsInUisOpened || this.allSubhintsInUisOpened.length <= 1)
         {
            return;
         }
         if(this._currentSubhintIndex > 0)
         {
            --this._currentSubhintIndex;
            this.subhintEditorUpdated(this.allSubhintsInUisOpened[this._currentSubhintIndex]);
         }
      }
      
      private function compareAllParameters(op:String) : void
      {
         this._dataToSend = {};
         if(op == "delete")
         {
            this._dataToSend.hint_id = this.currentSubhint.hint_id;
            this._dataToSend.hint_parent_uid = this.lbl_uiNameDisplay.text;
            this._dataToSend.hint_order = uint(this.inp_order.text);
         }
         else if(!this.currentSubhint || op == "preview")
         {
            this._dataToSend.hint_id = !!this.currentSubhint ? this.currentSubhint.hint_id : -1;
            this._dataToSend.hint_parent_uid = this.lbl_uiNameDisplay.text;
            this._dataToSend.hint_order = uint(this.inp_order.text);
            this._dataToSend.hint_anchored_element = this.inp_anchoredElement.text;
            this._dataToSend.hint_anchor = this.cb_shPos.selectedIndex;
            this._dataToSend.hint_position_x = int(this.inp_offsetX.text);
            this._dataToSend.hint_position_y = int(this.inp_offsetY.text);
            this._dataToSend.hint_highlighted_element = this.inp_highlight.text;
            this._dataToSend.hint_width = uint(this.inp_width.text);
            this._dataToSend.hint_height = uint(this.inp_height.text);
            this._dataToSend.hint_tooltip_text = this.formatText(this.inp_ttText.text);
            this._dataToSend.hint_tooltip_url = this._realUri;
            this._dataToSend.hint_tooltip_offset_x = int(this.inp_ttOffsetX.text);
            this._dataToSend.hint_tooltip_offset_y = int(this.inp_ttOffsetY.text);
            this._dataToSend.hint_tooltip_position_enum = this.cb_ttPos.selectedIndex;
            this._dataToSend.hint_tooltip_width = int(this.inp_ttWidth.text);
            if(op == "preview")
            {
               this._dataToSend.hint_tooltip_guided = this.btn_guidedPreview.selected;
            }
         }
         else
         {
            this._dataToSend.hint_id = !!this.currentSubhint ? this.currentSubhint.hint_id : -1;
            if(this.currentSubhint.hint_parent_uid != this.lbl_uiNameDisplay.text)
            {
               this._dataToSend.hint_parent_uid = this.lbl_uiNameDisplay.text;
               this._dataToSend.previousParent = this.currentSubhint.hint_parent_uid;
            }
            if(this.currentSubhint.hint_anchored_element != this.inp_anchoredElement.text)
            {
               this._dataToSend.hint_anchored_element = this.inp_anchoredElement.text;
            }
            if(this.currentSubhint.hint_anchor != this.cb_shPos.selectedIndex)
            {
               this._dataToSend.hint_anchor = this.cb_shPos.selectedIndex;
            }
            if(this.currentSubhint.hint_position_x != int(this.inp_offsetX.text))
            {
               this._dataToSend.hint_position_x = int(this.inp_offsetX.text);
            }
            if(this.currentSubhint.hint_position_y != int(this.inp_offsetY.text))
            {
               this._dataToSend.hint_position_y = int(this.inp_offsetY.text);
            }
            if(this.currentSubhint.hint_highlighted_element != this.inp_highlight.text)
            {
               this._dataToSend.hint_highlighted_element = this.inp_highlight.text;
            }
            if(this.currentSubhint.hint_width != uint(this.inp_width.text))
            {
               this._dataToSend.hint_width = uint(this.inp_width.text);
            }
            if(this.currentSubhint.hint_height != uint(this.inp_height.text))
            {
               this._dataToSend.hint_height = uint(this.inp_height.text);
            }
            if(this.currentSubhint.hint_order != uint(this.inp_order.text))
            {
               this._dataToSend.hint_order = uint(this.inp_order.text);
            }
            if(this.currentSubhint.hint_tooltip_text != this.formatText(this.inp_ttText.text))
            {
               this._dataToSend.hint_tooltip_text = this.formatText(this.inp_ttText.text);
            }
            if(this.currentSubhint.hint_tooltip_url != this._realUri)
            {
               this._dataToSend.hint_tooltip_url = this._realUri;
            }
            if(this.currentSubhint.hint_tooltip_offset_x != int(this.inp_ttOffsetX.text))
            {
               this._dataToSend.hint_tooltip_offset_x = int(this.inp_ttOffsetX.text);
            }
            if(this.currentSubhint.hint_tooltip_offset_y != int(this.inp_ttOffsetY.text))
            {
               this._dataToSend.hint_tooltip_offset_y = int(this.inp_ttOffsetY.text);
            }
            if(this.currentSubhint.hint_tooltip_position_enum != this.cb_ttPos.selectedIndex)
            {
               this._dataToSend.hint_tooltip_position_enum = this.cb_ttPos.selectedIndex;
            }
            if(this.currentSubhint.hint_tooltip_width != int(this.inp_ttWidth.text))
            {
               this._dataToSend.hint_tooltip_width = int(this.inp_ttWidth.text);
            }
         }
      }
      
      private function formatText(text:String) : String
      {
         var regexp:RegExp = /\r/g;
         return text.replace(regexp,"\n");
      }
      
      private function updateSubhintWrapper(op:String) : void
      {
         this.compareAllParameters(op);
         if(!this.checkDataToSendLenght() || !this.checkAllParameters(op))
         {
            return;
         }
         this.resetBaseData();
      }
      
      private function setOrderOfNewSubhint() : uint
      {
         if(!this._subhintArrayOfCurrentUi || this._subhintArrayOfCurrentUi.length <= 0)
         {
            return 1;
         }
         return this._subhintArrayOfCurrentUi.length + 1;
      }
      
      private function checkDataToSendLenght() : Boolean
      {
         var property:* = null;
         var numberOfProperties:int = 0;
         for(property in this._dataToSend)
         {
            numberOfProperties++;
         }
         return numberOfProperties > 1;
      }
      
      private function checkAllParameters(op:String) : Boolean
      {
         switch(op)
         {
            case "update":
               if(!this.checkOrder(op) || !this.checkParentUID(op) || !this.checkTooltipTextOrUri(op) || !this.checkAnchoredElement(op) || !this.checkHighlightedElement(op))
               {
                  return false;
               }
               this.hintsApi.updateSubhint(this._dataToSend);
               break;
            case "create":
               if(!this.checkOrder(op) || !this.checkParentUID(op) || !this.checkTooltipTextOrUri(op) || !this.checkAnchoredElement(op) || !this.checkHighlightedElement(op))
               {
                  return false;
               }
               this.hintsApi.createSubhint(this._dataToSend);
               break;
            case "preview":
               if(!this.checkOrder(op) || !this.checkParentUID(op) || !this.checkAnchoredElement(op) || !this.checkHighlightedElement(op))
               {
                  this._previewMode = false;
                  this.btn_previsualiseSubhint.selected = false;
                  return false;
               }
               if(this._dataToSend.hint_tooltip_text == "" && this._dataToSend.hint_tooltip_url == "")
               {
                  this._dataToSend.hint_tooltip_text = "Aperçu";
               }
               this._previewMode = true;
               this.hintsApi.previewSubhint(this._dataToSend);
               return false;
               break;
            case "delete":
               this.createPopupWarning("delete",op);
         }
         return true;
      }
      
      private function checkAnchoredElement(op:String) : Boolean
      {
         var subhints:Array = null;
         var name:String = null;
         var uiRoot:UiRootContainer = null;
         var data:Object = null;
         if(!this._dataToSend.hasOwnProperty("hint_anchored_element"))
         {
            return true;
         }
         if(this._dataToSend.hint_anchored_element == "")
         {
            if(!this._previewMode)
            {
               this.createPopupWarning("anchoredElement",op);
            }
            return false;
         }
         if(this._dataToSend.hint_anchored_element.indexOf("instance") != -1)
         {
            if(!this._previewMode)
            {
               this.createPopupWarning("anchoredElement",op,"instance");
            }
            return false;
         }
         subhints = this.hintsApi.getSubhintDataArrayWithParentUID(this._dataToSend.hint_parent_uid);
         if(op != "preview" && subhints)
         {
            for each(data in subhints)
            {
               if(data && data.hint_anchored_element == this._dataToSend.hint_anchored_element)
               {
                  if(!this._previewMode)
                  {
                     this.createPopupWarning("anchoredElement",op,"elementAlreadyExist");
                  }
                  return false;
               }
            }
         }
         name = !!this._dataToSend.hint_parent_uid ? this._dataToSend.hint_parent_uid : this.currentSubhint.hint_parent_uid;
         uiRoot = this.hintsApi.getUiClass(name.split("_")[0]) as UiRootContainer;
         if(uiRoot && !uiRoot.getElement(this._dataToSend.hint_anchored_element))
         {
            if(!this._previewMode)
            {
               this.createPopupWarning("anchoredElement",op,"elementNotFound");
            }
            return false;
         }
         return true;
      }
      
      private function checkOrder(op:String) : Boolean
      {
         if(!this._dataToSend.hasOwnProperty("hint_order"))
         {
            return true;
         }
         if(this._dataToSend.hint_order < 1)
         {
            this.createPopupWarning("order",op,"lowOrder");
            return false;
         }
         switch(op)
         {
            case "update":
               if(this._dataToSend.hint_order > this._subhintArrayOfCurrentUi.length - 1)
               {
                  this.createPopupWarning("order",op,"highOrder");
                  return false;
               }
               break;
            case "create":
               if(this._subhintArrayOfCurrentUi && this._dataToSend.hint_order > this._subhintArrayOfCurrentUi.length + 1)
               {
                  this.createPopupWarning("order",op,"highOrder");
                  return false;
               }
               if(!this._subhintArrayOfCurrentUi && this._dataToSend.hint_order > 1)
               {
                  this.createPopupWarning("order",op,"highOrder");
                  return false;
               }
               break;
         }
         return true;
      }
      
      private function checkTooltipTextOrUri(op:String) : Boolean
      {
         if(!this._dataToSend.hasOwnProperty("hint_tooltip_text") && !this._dataToSend.hasOwnProperty("hint_tooltip_url"))
         {
            return true;
         }
         if(this._dataToSend.hint_tooltip_text != "" || this._dataToSend.hint_tooltip_url != "")
         {
            return true;
         }
         if(!this._previewMode)
         {
            this.createPopupWarning("text",op);
         }
         return false;
      }
      
      private function checkParentUID(op:String) : Boolean
      {
         if(!this._dataToSend.hasOwnProperty("hint_parent_uid"))
         {
            return true;
         }
         if(this._dataToSend.hint_parent_uid != "")
         {
            return true;
         }
         if(!this._previewMode)
         {
            this.createPopupWarning("parentUID",op);
         }
         return false;
      }
      
      private function checkHighlightedElement(op:String) : Boolean
      {
         var uiName:Array = null;
         var uiRoot:UiRootContainer = null;
         if(!this._dataToSend.hasOwnProperty("hint_highlighted_element"))
         {
            return true;
         }
         if(this._dataToSend.hint_highlighted_element == "")
         {
            return true;
         }
         if(this._dataToSend.hint_highlighted_element.indexOf("instance") != -1)
         {
            if(!this._previewMode)
            {
               this.createPopupWarning("highlightedElement",op,"instance");
            }
            return false;
         }
         uiName = this.lbl_uiNameDisplay.text.split("_");
         uiRoot = this.hintsApi.getUiClass(uiName[0]) as UiRootContainer;
         if(!uiRoot.getElement(this._dataToSend.hint_highlighted_element))
         {
            if(!this._previewMode)
            {
               this.createPopupWarning("highlightedElement",op,"elementNotFound");
            }
            return false;
         }
         return true;
      }
      
      private function closeSubhintPreview() : void
      {
         if(this._previewMode)
         {
            this.btn_previsualiseSubhint.selected = false;
            this.btn_guidedPreview.disabled = true;
            this.hintsApi.closeSubhintPreview();
            this._previewMode = false;
         }
      }
      
      private function createPopupWarning(reason:String, op:String, optionalReason:String = "") : void
      {
         var warningText:* = null;
         var callBack:Function = null;
         var maxOrder:int = 0;
         switch(reason)
         {
            case "order":
               if(optionalReason == "lowOrder")
               {
                  warningText = "L\'ordre " + this.inp_order.text + " est trop petit, l\'ordre minimum doit être 1";
               }
               else if(optionalReason == "highOrder")
               {
                  if(!this._subhintArrayOfCurrentUi)
                  {
                     maxOrder = 0;
                  }
                  else
                  {
                     maxOrder = this._subhintArrayOfCurrentUi.length - 1;
                  }
                  warningText = "L\'ordre " + this.inp_order.text + " est trop grand, l\'interface " + this.lbl_uiNameDisplay.text + " ne possède que " + maxOrder + " subhints.";
               }
               this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),warningText,[this.uiApi.getText("ui.common.ok")],[this.onPopupClose]);
               break;
            case "parentUID":
               warningText = "Il semblerait qu\'il n\'y ai pas de nom d\'UI renseigné";
               this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),warningText,[this.uiApi.getText("ui.common.ok")],[this.onPopupClose]);
               break;
            case "text":
               warningText = "Aucun texte n\'a été écrit pour le tooltip";
               this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),warningText,[this.uiApi.getText("ui.common.ok")],[this.onPopupClose]);
               break;
            case "anchoredElement":
               if(optionalReason == "instance")
               {
                  warningText = "Une instance d\'élément ne peut être choisie comme élément d\'ancrage, merci de choisir un autre élément ou de renommer celui-ci dans le .xml correspondant (voir les Devs)";
               }
               else if(optionalReason == "elementNotFound")
               {
                  warningText = "Il semblerait que l\'élément d\'ancrage indiqué n\'existe pas";
               }
               else
               {
                  if(optionalReason == "elementAlreadyExist")
                  {
                     warningText = "Il semblerait que l\'élément choisi possède déjà un tooltip.\nEtes vous sûr de vouloir le créer ?";
                     if(op == "update")
                     {
                        callBack = this.onValidateConfirmedUpdate;
                     }
                     else if(op == "create")
                     {
                        callBack = this.onValidateConfirmedCreate;
                     }
                     this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),warningText,[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.cancel")],[callBack]);
                     break;
                  }
                  warningText = "Il semblerait qu\'il n\'y ai pas d\'élément d\'ancrage renseigné";
               }
               this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),warningText,[this.uiApi.getText("ui.common.ok")],[this.onPopupClose]);
               break;
            case "highlightedElement":
               if(optionalReason == "instance")
               {
                  warningText = "Une instance d\'élément ne peut être choisi comme élément à mettre en avant, merci de choisir un autre élément ou de renommer celui-ci dans le .xml correspondant (voir les Devs)";
               }
               else
               {
                  if(optionalReason != "elementNotFound")
                  {
                     if(this._dataToSend.hint_anchored_element != "btn_help")
                     {
                        warningText = "Il semblerait qu\'il n\'y ai pas d\'élément à mettre en avant de renseigné.\nEtes vous sûr de vouloir continuer ?";
                        if(op == "update")
                        {
                           callBack = this.onValidateConfirmedUpdate;
                        }
                        else if(op == "create")
                        {
                           callBack = this.onValidateConfirmedCreate;
                        }
                        this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),warningText,[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.cancel")],[callBack]);
                     }
                     break;
                  }
                  warningText = "Il semblerait que l\'élément à metre en avant n\'existe pas";
               }
               this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),warningText,[this.uiApi.getText("ui.common.ok")],[this.onPopupClose]);
               break;
            case "delete":
               warningText = "Êtes-vous sûr de vouloir supprimer ce hint ?";
               this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),warningText,[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.cancel")],[this.onDeleteConfirmed]);
         }
      }
      
      private function onDeleteConfirmed() : void
      {
         this.hintsApi.deleteSubhint(this._dataToSend);
      }
      
      private function onValidateConfirmedUpdate() : void
      {
         this.hintsApi.updateSubhint(this._dataToSend);
         this.resetBaseData();
      }
      
      private function onValidateConfirmedCreate() : void
      {
         this.hintsApi.createSubhint(this._dataToSend);
         this.resetBaseData();
      }
      
      private function onPopupClose() : void
      {
      }
      
      private function selectDirectory() : void
      {
         var dir:String = "\\\\bise.ankama.lan\\dofus2-resources\\content\\gfx\\illusUi\\helpTooltips";
         var f:File = new File(dir);
         var imageFileTypes:FileFilter = new FileFilter("Images (*.jpg, *.jpeg, *.png)","*.jpg;*.jpeg;*.png");
         f.browseForOpen("Selection de l\'image",[imageFileTypes]);
         f.addEventListener(Event.SELECT,this.onFileSelect);
      }
      
      private function onFileSelect(pEvent:Event) : void
      {
         var f:File = pEvent.currentTarget as File;
         f.removeEventListener(Event.SELECT,this.onFileSelect);
         var path:String = f.nativePath;
         var indexOfSubPath:int = path.indexOf("helpTooltips\\");
         if(indexOfSubPath < 0)
         {
            this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),"Le chemin fourni n\'est pas correct (" + path + ")",[this.uiApi.getText("ui.common.ok")],[this.onPopupClose()]);
            this.inp_ttUri.text = "";
            this._realUri = "";
         }
         else
         {
            this.inp_ttUri.text = "[gfx.path.helpTooltips]" + path.substring(indexOfSubPath + 13);
            this._realUri = path.substring(indexOfSubPath + 13);
         }
      }
   }
}
