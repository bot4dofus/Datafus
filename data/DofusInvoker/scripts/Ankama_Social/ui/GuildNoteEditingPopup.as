package Ankama_Social.ui
{
   import Ankama_Common.ui.TextButtonPopup;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.guild.GuildNoteWrapper;
   import com.ankamagames.dofus.logic.common.managers.HyperlinkShowPlayerMenuManager;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildNoteUpdateAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.types.game.guild.GuildMember;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   
   public class GuildNoteEditingPopup extends TextButtonPopup
   {
      
      public static const MAX_NOTE_LENGTH:uint = 60;
      
      public static const TOOLTIP_UI_NAME:String = "GuildNoteEditingPopupUITooltip";
       
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      private var _guildMember:GuildMember = null;
      
      public var inp_guildNoteInput:Input;
      
      public var tx_help:Texture;
      
      public function GuildNoteEditingPopup()
      {
         super();
      }
      
      override public function main(params:Object) : void
      {
         if(params === null || !params.hasOwnProperty("guildMember"))
         {
            this.close();
            return;
         }
         this._guildMember = params.guildMember;
         if(this._guildMember === null)
         {
            this.close();
            return;
         }
         var title:String = this._guildMember.id === this.playerApi.id() ? uiApi.getText("ui.guild.note.editMyNote") : uiApi.getText("ui.guild.note.editNote");
         params.title = title.toUpperCase();
         params.content = "";
         params.buttonText = [uiApi.getText("ui.common.save"),uiApi.getText("ui.common.cancel")];
         params.buttonCallback = [this.submit,this.close];
         params.onCancel = this.close;
         params.onEnterKey = this.submit;
         uiApi.addComponentHook(this.inp_guildNoteInput,ComponentHookList.ON_CHANGE);
         uiApi.addComponentHook(this.tx_help,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.tx_help,ComponentHookList.ON_ROLL_OUT);
         sysApi.addHook(HookList.KISConnectingServer,this.onArenaConnectAttempt);
         super.main(params);
         var note:GuildNoteWrapper = !!params.hasOwnProperty("note") ? params.note : null;
         this.inp_guildNoteInput.text = note !== null ? note.text : "";
         this.updateNoteHeader();
      }
      
      override protected function computePopupHeight() : void
      {
         height += this.inp_guildNoteInput.y + this.inp_guildNoteInput.height - lbl_title_popup.y + Number(uiApi.me().getConstant("bottom_margin"));
         popup.height = height;
      }
      
      private function updateNoteHeader() : void
      {
         var hexColor:Number = NaN;
         var currentLength:int = this.inp_guildNoteInput.text.length;
         var delta:int = MAX_NOTE_LENGTH - currentLength;
         var deltaLabel:* = delta.toString();
         if(delta < 0)
         {
            hexColor = Number(sysApi.getConfigEntry("colors.input.tooManyCharacters"));
            deltaLabel = "<font color=\'" + "#" + hexColor.toString(16) + "\'>" + deltaLabel + "</font>";
         }
         var header:String = this._guildMember.id === this.playerApi.id() ? uiApi.getText("ui.guild.note.myNote") : uiApi.getText("ui.guild.note.someonesNote",HyperlinkShowPlayerMenuManager.getLink(this._guildMember.id,this._guildMember.name));
         lbl_content.text = header + " (" + deltaLabel + ")" + uiApi.getText("ui.common.colon");
         this.updateSaveButton(delta < 0);
      }
      
      private function updateSaveButton(isSaveDisabled:Boolean) : void
      {
         if(btn_primary.softDisabled === isSaveDisabled)
         {
            return;
         }
         btn_primary.softDisabled = isSaveDisabled;
         if(!isSaveDisabled)
         {
            uiApi.removeComponentHook(btn_primary,ComponentHookList.ON_ROLL_OVER);
            uiApi.removeComponentHook(btn_primary,ComponentHookList.ON_ROLL_OUT);
         }
         else
         {
            uiApi.addComponentHook(btn_primary,ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(btn_primary,ComponentHookList.ON_ROLL_OUT);
         }
      }
      
      private function close() : void
      {
         uiApi.unloadUi(uiApi.me().name);
      }
      
      private function submit() : void
      {
         sysApi.sendAction(GuildNoteUpdateAction.create(this._guildMember.id,this.inp_guildNoteInput.text));
         this.close();
      }
      
      public function onChange(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.inp_guildNoteInput:
               this.updateNoteHeader();
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         if(target === this.tx_help)
         {
            uiApi.showTooltip(uiApi.textTooltipInfo(uiApi.getText("ui.guild.note.visibleByAllMembers")),target,false,TOOLTIP_UI_NAME,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
         }
         else if(target === btn_primary)
         {
            uiApi.showTooltip(uiApi.textTooltipInfo(uiApi.getText("ui.common.tooManyCharacters")),target,false,TOOLTIP_UI_NAME,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         uiApi.hideTooltip(TOOLTIP_UI_NAME);
      }
      
      public function onArenaConnectAttempt() : void
      {
         this.close();
      }
   }
}
