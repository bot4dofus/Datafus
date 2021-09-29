package Ankama_Social.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.people.SpouseWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.FriendSpouseFollowAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.JoinSpouseAction;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.uiApi.BindsApi;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.jerakine.types.Uri;
   
   public class Spouse
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="BindsApi")]
      public var bindsApi:BindsApi;
      
      private var _spouse:SpouseWrapper;
      
      private var _bgLevelUri:Uri;
      
      private var _bgPrestigeUri:Uri;
      
      public var spouseCtr:GraphicContainer;
      
      public var lbl_title:Label;
      
      public var lbl_name:Label;
      
      public var lbl_breed:Label;
      
      public var lbl_levelTitle:Label;
      
      public var tx_level:Texture;
      
      public var lbl_level:Label;
      
      public var lbl_guild:Label;
      
      public var lbl_state:Label;
      
      public var lbl_loc:Label;
      
      public var lbl_alignment:Label;
      
      public var btn_lbl_btn_follow:Label;
      
      public var lbl_badNews:Label;
      
      public var btn_group:ButtonContainer;
      
      public var btn_follow:ButtonContainer;
      
      public var btn_join:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var tx_inFight:Texture;
      
      public var ctr_spouseInfos:GraphicContainer;
      
      public var ent_spouse:EntityDisplayer;
      
      public function Spouse()
      {
         super();
      }
      
      public function main(... params) : void
      {
         this.sysApi.addHook(SocialHookList.SpouseFollowStatusUpdated,this.onSpouseFollowStatusUpdated);
         this.sysApi.addHook(SocialHookList.SpouseUpdated,this.onSpouseUpdated);
         this.uiApi.addComponentHook(this.btn_group,"onRelease");
         this.uiApi.addComponentHook(this.btn_follow,"onRelease");
         this.uiApi.addComponentHook(this.btn_join,"onRelease");
         this.uiApi.addComponentHook(this.btn_help,ComponentHookList.ON_RELEASE);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this._bgLevelUri = this.uiApi.createUri(this.uiApi.me().getConstant("bgLevel_uri"));
         this._bgPrestigeUri = this.uiApi.createUri(this.uiApi.me().getConstant("bgPrestige_uri"));
         this.displaySpouse();
      }
      
      private function displaySpouse() : void
      {
         var shortcut:String = this.bindsApi.getShortcutBindStr("openSocialSpouse");
         this._spouse = this.socialApi.getSpouse();
         if(!this._spouse)
         {
            this.lbl_badNews.visible = true;
            this.lbl_name.text = "";
            this.ctr_spouseInfos.visible = false;
            this.ent_spouse.visible = false;
            this.btn_follow.disabled = true;
            this.btn_group.disabled = true;
            this.btn_join.disabled = true;
            this.lbl_title.text = this.uiApi.processText(this.uiApi.getText("ui.common.spouse"),"m",true);
            if(shortcut != "")
            {
               this.lbl_title.text += " (" + shortcut + ")";
            }
         }
         else
         {
            this.ctr_spouseInfos.visible = true;
            this.ent_spouse.visible = true;
            this.lbl_badNews.visible = false;
            this.lbl_name.text = "{player," + this._spouse.name + "," + this._spouse.id + "::" + this._spouse.name + "}";
            this.lbl_title.text = this.uiApi.processText(this.uiApi.getText("ui.common.spouse"),this._spouse.sex > 0 ? "f" : "m",true);
            if(shortcut != "")
            {
               this.lbl_title.text += " (" + shortcut + ")";
            }
            if(this._spouse.level > ProtocolConstantsEnum.MAX_LEVEL)
            {
               this.lbl_levelTitle.text = this.uiApi.getText("ui.common.prestige") + this.uiApi.getText("ui.common.colon");
               this.lbl_level.cssClass = "darkboldcenter";
               this.lbl_level.text = "" + (this._spouse.level - ProtocolConstantsEnum.MAX_LEVEL);
               this.tx_level.uri = this._bgPrestigeUri;
               this.uiApi.addComponentHook(this.tx_level,"onRollOver");
               this.uiApi.addComponentHook(this.tx_level,"onRollOut");
            }
            else
            {
               this.lbl_levelTitle.text = this.uiApi.getText("ui.common.level") + this.uiApi.getText("ui.common.colon");
               this.lbl_level.cssClass = "boldcenter";
               this.lbl_level.text = this._spouse.level.toString();
               this.tx_level.uri = this._bgLevelUri;
            }
            if(this._spouse.breed > 0)
            {
               this.lbl_breed.text = this.dataApi.getBreed(this._spouse.breed).shortName;
            }
            else
            {
               this.lbl_breed.text = "-";
            }
            if(this._spouse.entityLook != this.ent_spouse.look)
            {
               this.ent_spouse.look = this._spouse.entityLook;
            }
            this.lbl_guild.text = this.chatApi.getGuildLink(this._spouse,this._spouse.guildName);
            this.lbl_alignment.text = this.dataApi.getAlignmentSide(this._spouse.alignmentSide).name;
            if(this._spouse.online)
            {
               this.lbl_state.text = this.uiApi.getText("ui.server.state.online");
               this.lbl_loc.text = this.dataApi.getSubArea(this._spouse.subareaId).name;
               this.tx_inFight.visible = this._spouse.inFight;
               if(this._spouse.followSpouse)
               {
                  this.btn_lbl_btn_follow.text = this.uiApi.getText("ui.common.stopFollow");
               }
               else
               {
                  this.btn_lbl_btn_follow.text = this.uiApi.getText("ui.common.follow");
               }
               if(this.btn_follow.disabled)
               {
                  this.btn_follow.disabled = false;
               }
               if(this.btn_group.disabled)
               {
                  this.btn_group.disabled = false;
               }
               if(this.btn_join.disabled)
               {
                  this.btn_join.disabled = false;
               }
            }
            else
            {
               if(this.tx_inFight.visible)
               {
                  this.tx_inFight.visible = false;
               }
               this.lbl_loc.text = "-";
               this.lbl_state.text = this.uiApi.getText("ui.server.state.offline");
               this.btn_follow.disabled = true;
               this.btn_group.disabled = true;
               this.btn_join.disabled = true;
            }
         }
      }
      
      private function onSpouseFollowStatusUpdated(enable:Boolean) : void
      {
         if(enable)
         {
            this.btn_lbl_btn_follow.text = this.uiApi.getText("ui.common.stopFollow");
         }
         else
         {
            this.btn_lbl_btn_follow.text = this.uiApi.getText("ui.common.follow");
         }
         this._spouse = this.socialApi.getSpouse();
      }
      
      private function onSpouseUpdated() : void
      {
         this._spouse = this.socialApi.getSpouse();
         this.displaySpouse();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_follow:
               this.sysApi.sendAction(new FriendSpouseFollowAction([!this._spouse.followSpouse]));
               break;
            case this.btn_group:
               this.sysApi.sendAction(new PartyInvitationAction([this._spouse.name]));
               break;
            case this.btn_join:
               this.sysApi.sendAction(new JoinSpouseAction([]));
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_help:
               this.hintsApi.showSubHints();
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.tx_level:
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.tooltip.OmegaLevel")),target,false,"standard",0,8,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "closeUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
   }
}
