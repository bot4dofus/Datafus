package Ankama_Grimoire.ui.optionalFeatures
{
   import Ankama_Common.Common;
   import Ankama_ContextMenu.ContextMenu;
   import Ankama_Grimoire.enum.EnumTab;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.ProgressBar;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.logic.game.common.actions.alignment.AlignmentWarEffortDonateAction;
   import com.ankamagames.dofus.logic.game.common.actions.alignment.AlignmentWarEffortProgressionRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alignment.CharacterAlignmentWarEffortProgressionRequestAction;
   import com.ankamagames.dofus.misc.lists.AlignmentHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.geom.Rectangle;
   
   public class AlignmentWarEffortTab
   {
       
      
      public var sysApi:SystemApi;
      
      public var uiApi:UiApi;
      
      public var utilApi:UtilApi;
      
      public var dataApi:DataApi;
      
      public var playerApi:PlayedCharacterApi;
      
      public var hintsApi:UiTutoApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _characterInfos;
      
      private var limitReached:Boolean;
      
      private var _alignmentTab:GraphicContainer;
      
      private var _bontaParticipation:Number = 0;
      
      private var _brakmarParticipation:Number = 0;
      
      private var _actualDailyParticipation:Number;
      
      private var _maxDailyParticipation:Number;
      
      public var alignmentWarEffortTab:GraphicContainer;
      
      public var lbl_parti:Label;
      
      public var lbl_bonta:Label;
      
      public var lbl_brakmar:Label;
      
      public var lbl_warEffortDay:Label;
      
      public var lbl_warEffortDayKamas:Label;
      
      public var lbl_warEffortDayKamasMax:Label;
      
      public var lbl_warEffortTotal:Label;
      
      public var lbl_warEffortTotalKamas:Label;
      
      public var hint_warEffort:Texture;
      
      public var hint_warEffortDay:Texture;
      
      public var tx_bonta:Texture;
      
      public var tx_brakmar:Texture;
      
      public var inp_dotation:Input;
      
      public var btn_sendKamas:ButtonContainer;
      
      public var pb_brakmar:ProgressBar;
      
      public var pb_bonta:ProgressBar;
      
      public function AlignmentWarEffortTab()
      {
         super();
      }
      
      public function main(params:Object) : void
      {
         this.sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         this.sysApi.addHook(BeriliaHookList.WindowResize,this.onWindowResize);
         this.sysApi.addHook(AlignmentHookList.UpdateWarEffortHook,this.updateWarEffort);
         this.sysApi.addHook(AlignmentHookList.CharacterAlignmentWarEffortProgressionHook,this.onCharacterAlignmentWarEffortProgression);
         this.sysApi.addHook(AlignmentHookList.AlignmentWarEffortProgressionMessageHook,this.onAlignmentWarEffortProgressionMessage);
         this.uiApi.addComponentHook(this.hint_warEffort,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.hint_warEffort,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.hint_warEffortDay,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.hint_warEffortDay,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.pb_brakmar,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.pb_brakmar,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.pb_bonta,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.pb_bonta,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_sendKamas,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_sendKamas,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.inp_dotation,ComponentHookList.ON_CHANGE);
         this.uiApi.addComponentHook(this.alignmentWarEffortTab,ComponentHookList.ON_DOUBLE_CLICK);
         this.uiApi.addComponentHook(this.btn_sendKamas,ComponentHookList.ON_RELEASE);
         this._characterInfos = this.playerApi.getPlayedCharacterInfo();
         this.inp_dotation.restrictChars = "0-9  ";
         this.inp_dotation.numberMax = ProtocolConstantsEnum.MAX_KAMA;
         this.inp_dotation.text = "0";
         this.inp_dotation.focus();
         this.inp_dotation.setSelection(0,8388607);
         this.updateLabels();
         this.updateWarEffort();
         this.checkDisableButton();
      }
      
      public function updateWarEffort() : void
      {
         this.sysApi.sendAction(new AlignmentWarEffortProgressionRequestAction([]));
         this.sysApi.sendAction(new CharacterAlignmentWarEffortProgressionRequestAction([]));
      }
      
      public function onUiLoaded(pUiName:String) : void
      {
         if(pUiName == "alignmentWarEffortTab")
         {
            this.uiApi.me().setOnTop();
            this.stickToAlignmentTab();
         }
      }
      
      public function onWindowResize(width:uint, height:uint, scale:Number) : void
      {
         this.stickToAlignmentTab();
      }
      
      private function stickToAlignmentTab() : void
      {
         var rectangleAlign:Rectangle = null;
         this._alignmentTab = this.uiApi.getUi(EnumTab.ALIGNMENT_TAB);
         if(this._alignmentTab)
         {
            rectangleAlign = this._alignmentTab.getStageRect();
            this.alignmentWarEffortTab.x = rectangleAlign.x + rectangleAlign.width - 10;
            this.alignmentWarEffortTab.y = rectangleAlign.y + 10;
         }
      }
      
      private function updateLabels() : void
      {
         this.lbl_parti.removeTooltipExtension();
         this.lbl_warEffortDay.removeTooltipExtension();
         this.lbl_warEffortDayKamas.removeTooltipExtension();
         this.lbl_warEffortDayKamasMax.removeTooltipExtension();
         this.lbl_warEffortTotal.removeTooltipExtension();
         this.lbl_warEffortTotalKamas.removeTooltipExtension();
         this.lbl_parti.fullWidthAndHeight();
         this.lbl_bonta.fullWidthAndHeight(0,10);
         this.lbl_brakmar.fullWidthAndHeight();
         this.lbl_warEffortDay.fullWidthAndHeight();
         this.lbl_warEffortDayKamas.fullWidthAndHeight();
         this.lbl_warEffortDayKamasMax.fullWidthAndHeight();
         this.lbl_warEffortTotal.fullWidthAndHeight();
         this.lbl_warEffortTotalKamas.fullWidthAndHeight();
         this.uiApi.me().render();
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         if(target == this.btn_sendKamas && !this.limitReached)
         {
            return;
         }
         switch(target)
         {
            case this.hint_warEffort:
               text = this.uiApi.getText("ui.temporis.warEffortTooltip");
               break;
            case this.hint_warEffortDay:
               text = this.uiApi.getText("ui.temporis.dailyParticipationTooltip");
               break;
            case this.pb_bonta:
            case this.pb_brakmar:
               text = this.uiApi.getText("ui.temporis.warEffortBarTooltip",this.utilApi.kamasToString(this._bontaParticipation,""),this.utilApi.kamasToString(this._brakmarParticipation,""));
               break;
            case this.btn_sendKamas:
               text = this.uiApi.getText("ui.temporis.buttonDisableTooltip");
         }
         this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onCharacterAlignmentWarEffortProgression(dailyLimit:Number, dailyDonation:Number, personalDonation:Number) : void
      {
         this._actualDailyParticipation = dailyDonation;
         this._maxDailyParticipation = dailyLimit;
         this.limitReached = Math.round(this._actualDailyParticipation) == Math.round(this._maxDailyParticipation);
         this.lbl_warEffortDayKamasMax.text = "/ " + this.utilApi.kamasToString(dailyLimit,"");
         this.lbl_warEffortDayKamas.text = this.utilApi.kamasToString(dailyDonation,"");
         this.lbl_warEffortTotalKamas.text = this.utilApi.kamasToString(personalDonation,"");
         this.updateLabels();
      }
      
      public function onAlignmentWarEffortProgressionMessage(bontaParticipation:Number, brakmarParticipation:Number) : void
      {
         this._bontaParticipation = bontaParticipation;
         this._brakmarParticipation = brakmarParticipation;
         if(Math.round(bontaParticipation) == Math.round(brakmarParticipation) && Math.round(bontaParticipation) == 0)
         {
            this.pb_bonta.value = 0.5;
         }
         else
         {
            this.pb_bonta.value = bontaParticipation / (bontaParticipation + brakmarParticipation);
         }
         this.pb_brakmar.value = 1;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         if(target == this.btn_sendKamas)
         {
            this.sendKamas();
         }
      }
      
      public function sendKamas() : void
      {
         this.sysApi.sendAction(new AlignmentWarEffortDonateAction([this.utilApi.stringToKamas(this.inp_dotation.text)]));
         this.inp_dotation.text = "0";
         this.inp_dotation.setSelection(0,8388607);
      }
      
      public function onChange(target:GraphicContainer) : void
      {
         var value:Number = this.utilApi.stringToKamas(this.inp_dotation.text,"");
         var _currentPlayerKama:Number = this.playerApi.characteristics().kamas;
         if(value > this._maxDailyParticipation - this._actualDailyParticipation || value > _currentPlayerKama)
         {
            value = Math.min(this._maxDailyParticipation - this._actualDailyParticipation,_currentPlayerKama);
            this.inp_dotation.text = this.utilApi.kamasToString(value,"");
         }
         this.checkDisableButton();
      }
      
      public function onDoubleClick(target:GraphicContainer) : void
      {
         if(target == this.alignmentWarEffortTab)
         {
            this.stickToAlignmentTab();
         }
      }
      
      public function checkDisableButton() : void
      {
         this.btn_sendKamas.softDisabled = Math.round(this._actualDailyParticipation) == Math.round(this._maxDailyParticipation) || parseInt(this.inp_dotation.text) == 0;
         this.btn_sendKamas.useHandCursor = !this.btn_sendKamas.softDisabled;
      }
   }
}
