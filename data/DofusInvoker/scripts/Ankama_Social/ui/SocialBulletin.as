package Ankama_Social.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextArea;
   import com.ankamagames.berilia.components.TextAreaInput;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.logic.game.common.actions.alliance.AllianceBulletinSetRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildBulletinSetRequestAction;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   
   public class SocialBulletin
   {
      
      private static const GUILD:int = 1;
      
      private static const ALLIANCE:int = 2;
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      private var _currentSocialGroup:int;
      
      private var _socialGroupData:Object;
      
      private var _playerId:Number;
      
      public var lbl_title:Label;
      
      public var ctr_text:GraphicContainer;
      
      public var lbl_bulletin:TextArea;
      
      public var btn_edit:ButtonContainer;
      
      public var lbl_lastEdit:Label;
      
      public var ctr_edit:GraphicContainer;
      
      public var inp_bulletin:TextAreaInput;
      
      public var btn_notifyMembers:ButtonContainer;
      
      public var btn_valid:ButtonContainer;
      
      public var btn_exit:ButtonContainer;
      
      public function SocialBulletin()
      {
         super();
      }
      
      public function main(... args) : void
      {
         this.sysApi.addHook(SocialHookList.GuildBulletin,this.onGuildBulletin);
         this.sysApi.addHook(SocialHookList.AllianceBulletin,this.onAllianceBulletin);
         this.uiApi.addComponentHook(this.lbl_lastEdit,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_lastEdit,ComponentHookList.ON_ROLL_OUT);
         this.inp_bulletin.maxChars = ProtocolConstantsEnum.USER_MAX_BULLETIN_LEN;
         this._currentSocialGroup = this.uiApi.getUi("socialBase").uiClass.getTab();
         this._playerId = this.playerApi.id();
         this.showEditButtonIfHasRight();
         this.btn_valid.visible = false;
         this.btn_exit.visible = false;
         this.btn_notifyMembers.visible = false;
         if(this._currentSocialGroup == ALLIANCE)
         {
            this._socialGroupData = this.socialApi.getAlliance();
            this.lbl_title.text = this._socialGroupData.allianceName;
         }
         else
         {
            this._socialGroupData = this.socialApi.getGuild();
            this.lbl_title.text = this._socialGroupData.guildName;
         }
         this.updateBulletin();
      }
      
      public function showEditButtonIfHasRight() : void
      {
         if(this.socialApi.hasGuildRight(this._playerId,"isBoss"))
         {
            this.btn_edit.visible = true;
         }
         else if(this._currentSocialGroup == GUILD && this.socialApi.hasGuildRank(this._playerId,2))
         {
            this.btn_edit.visible = true;
         }
         else
         {
            this.btn_edit.visible = false;
         }
      }
      
      public function unload() : void
      {
         var currentTimestamp:Number = Math.round(new Date().time / 1000);
         if(this._currentSocialGroup == GUILD)
         {
            this.sysApi.setData("guildBulletinLastVisitTimestamp",currentTimestamp);
         }
         else
         {
            this.sysApi.setData("allianceBulletinLastVisitTimestamp",currentTimestamp);
         }
      }
      
      private function switchEditMode(editMode:Boolean) : void
      {
         if(editMode)
         {
            this.inp_bulletin.text = this._socialGroupData.bulletin;
            this.inp_bulletin.focus();
            this.inp_bulletin.setSelection(8388607,8388607);
            this.ctr_edit.visible = true;
            this.ctr_text.visible = false;
            this.btn_edit.visible = false;
            this.btn_valid.visible = true;
            this.btn_exit.visible = true;
            this.btn_notifyMembers.visible = true;
         }
         else
         {
            this.ctr_edit.visible = false;
            this.ctr_text.visible = true;
            this.showEditButtonIfHasRight();
            this.btn_valid.visible = false;
            this.btn_exit.visible = false;
            this.btn_notifyMembers.visible = false;
         }
      }
      
      private function updateBulletin() : void
      {
         var date:Number = NaN;
         if(this._currentSocialGroup == ALLIANCE)
         {
            this._socialGroupData = this.socialApi.getAlliance();
         }
         else
         {
            this._socialGroupData = this.socialApi.getGuild();
         }
         this.lbl_bulletin.text = this._socialGroupData.formattedBulletin;
         this.inp_bulletin.text = this._socialGroupData.bulletin;
         if(!this.lbl_bulletin.text || this.lbl_bulletin.text == "")
         {
            if(this._currentSocialGroup == ALLIANCE)
            {
               this.lbl_bulletin.text = this.uiApi.getText("ui.motd.allianceBulletinDefault");
            }
            else
            {
               this.lbl_bulletin.text = this.uiApi.getText("ui.motd.guildBulletinDefault");
            }
         }
         if(this._socialGroupData.bulletinWriterName != "")
         {
            date = this._socialGroupData.bulletinTimestamp * 1000;
            this.lbl_lastEdit.text = this.uiApi.getText("ui.motd.lastModification",this.timeApi.getDate(date,true) + " " + this.timeApi.getClock(date,true,true),this._socialGroupData.bulletinWriterName);
         }
      }
      
      private function onAllianceBulletin() : void
      {
         var currentTimestamp:Number = NaN;
         if(this._currentSocialGroup == ALLIANCE)
         {
            this.updateBulletin();
            this.switchEditMode(false);
            currentTimestamp = Math.round(new Date().time / 1000);
            this.sysApi.setData("allianceBulletinLastVisitTimestamp",currentTimestamp);
         }
      }
      
      private function onGuildBulletin() : void
      {
         var currentTimestamp:Number = NaN;
         if(this._currentSocialGroup == GUILD)
         {
            this.updateBulletin();
            this.switchEditMode(false);
            currentTimestamp = Math.round(new Date().time / 1000);
            this.sysApi.setData("guildBulletinLastVisitTimestamp",currentTimestamp);
         }
      }
      
      public function showTabHints() : void
      {
         this.hintsApi.showSubHints();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var notifyMembers:Boolean = false;
         if(target == this.btn_edit)
         {
            this.switchEditMode(true);
         }
         else if(target == this.btn_exit)
         {
            this.switchEditMode(false);
         }
         else if(target == this.btn_valid)
         {
            if(this.inp_bulletin.text != this._socialGroupData.bulletin)
            {
               notifyMembers = this.btn_notifyMembers.selected;
               if(this._currentSocialGroup == GUILD)
               {
                  this.sysApi.sendAction(new GuildBulletinSetRequestAction([this.inp_bulletin.text,notifyMembers]));
               }
               else if(this._currentSocialGroup == ALLIANCE)
               {
                  this.sysApi.sendAction(new AllianceBulletinSetRequestAction([this.inp_bulletin.text,notifyMembers]));
               }
            }
            else
            {
               this.switchEditMode(false);
            }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var point:uint = 7;
         var relPoint:uint = 1;
         if(target == this.lbl_lastEdit)
         {
            if(this._currentSocialGroup == GUILD)
            {
               tooltipText = this.uiApi.getText("ui.motd.guildBulletinEdit");
            }
            else
            {
               tooltipText = this.uiApi.getText("ui.motd.allianceBulletinEdit");
            }
         }
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
   }
}
