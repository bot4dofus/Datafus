package Ankama_Social.ui
{
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextAreaInput;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildDirectoryFiltersWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildSubmitApplicationAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildUpdateApplicationAction;
   import flash.utils.getTimer;
   
   public class GuildApplyPopup extends GuildJoinPopup
   {
      
      private static const MAX_PREZ_LENGTH:uint = 200;
       
      
      public var btn_close:ButtonContainer;
      
      public var inp_applyPrezInput:TextAreaInput;
      
      public var lbl_prez:Label;
      
      public var tx_applyPrezInput:TextureBitmap;
      
      public var ctr_prez:GraphicContainer;
      
      private var _isEdition:Boolean = false;
      
      private var _filters:GuildDirectoryFiltersWrapper = null;
      
      private var _uiOpeningTime:Number;
      
      public function GuildApplyPopup()
      {
         super();
      }
      
      override public function main(params:Object) : void
      {
         this._uiOpeningTime = getTimer();
         uiApi.addComponentHook(this.btn_close,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.inp_applyPrezInput,ComponentHookList.ON_CHANGE);
         uiApi.addComponentHook(btn_primary,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(btn_primary,ComponentHookList.ON_ROLL_OUT);
         this.inp_applyPrezInput.multiline = false;
         soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         this.updatePrez();
         tx_emblemBackGuild.dispatchMessages = true;
         tx_emblemUpGuild.dispatchMessages = true;
         params.title = uiApi.getText("ui.guild.joinAGuild");
         params.content = uiApi.getText("ui.guild.applyText");
         params.buttonText = [uiApi.getText("ui.guild.apply"),uiApi.getText("ui.common.cancel")];
         params.buttonCallback = [this.apply,null];
         params.onCancel = function():void
         {
         };
         params.onEnterKey = this.apply;
         _ignoreShortcuts = true;
         this.inp_applyPrezInput.placeholderText = uiApi.getText("ui.guild.applyPlaceholder");
         if(params.hasOwnProperty("presentation"))
         {
            this.inp_applyPrezInput.text = params.presentation;
            this._isEdition = true;
            this.updatePrez();
         }
         if(params.hasOwnProperty("filters") && !this._isEdition)
         {
            this._filters = params.filters;
         }
         height += this.lbl_prez.height + this.ctr_prez.anchorY + this.tx_applyPrezInput.height + this.tx_applyPrezInput.anchorY;
         super.main(params);
      }
      
      private function apply() : void
      {
         if(this.inp_applyPrezInput.text.length <= MAX_PREZ_LENGTH)
         {
            if(this._isEdition)
            {
               sysApi.sendAction(GuildUpdateApplicationAction.create(this.inp_applyPrezInput.text,guild.guildId));
            }
            else
            {
               sysApi.sendAction(GuildSubmitApplicationAction.create(this.inp_applyPrezInput.text,guild.guildId,(getTimer() - this._uiOpeningTime) / 1000,this._filters));
            }
         }
      }
      
      private function updatePrez() : void
      {
         var hexColor:Number = NaN;
         var currentLength:int = !!this.inp_applyPrezInput.placeholderActivated ? 0 : int(this.inp_applyPrezInput.text.length);
         var delta:int = MAX_PREZ_LENGTH - currentLength;
         var deltaLabel:* = delta.toString();
         if(delta < 0)
         {
            hexColor = Number(sysApi.getConfigEntry("colors.tooltip.text.red"));
            deltaLabel = "<font color=\'" + "#" + hexColor.toString(16) + "\'>" + deltaLabel + "</font>";
         }
         btn_primary.softDisabled = delta < 0;
         btn_primary.handCursor = !btn_primary.softDisabled;
         this.lbl_prez.text = uiApi.getText("ui.guild.applyPresentation") + " (" + deltaLabel + ")";
      }
      
      private function isApplicationPossible() : Boolean
      {
         return MAX_PREZ_LENGTH - this.inp_applyPrezInput.text.length >= 0;
      }
      
      public function onChange(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.inp_applyPrezInput:
               this.updatePrez();
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var point:uint = 7;
         var relPoint:uint = 1;
         if(target == btn_primary && this.inp_applyPrezInput.text.length > MAX_PREZ_LENGTH)
         {
            uiApi.showTooltip(uiApi.textTooltipInfo(uiApi.getText("ui.guild.applyPrezTooLong")),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         uiApi.hideTooltip();
      }
   }
}
