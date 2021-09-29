package Ankama_Social.ui
{
   import chat.protocol.friendinvite.data.FriendInvite;
   import chat.protocol.transport.Payload;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.actions.social.AddEnemyAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.AddFriendAction;
   import com.ankamagames.dofus.logic.game.common.actions.social.AddIgnoredAction;
   import com.ankamagames.dofus.misc.lists.ChatServiceHookList;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.ChatServiceApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.enum.SocialCharacterCategoryEnum;
   import mx.utils.StringUtil;
   
   public class AddFriendWindow
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="ChatServiceApi")]
      public var chatServiceApi:ChatServiceApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      public var lbl_title:Label;
      
      public var lbl_account:Label;
      
      public var inp_account:Input;
      
      public var btn_close:ButtonContainer;
      
      public var btn_sendInvite:ButtonContainer;
      
      public var btn_lbl_btn_sendInvite:Label;
      
      public var lbl_error:Label;
      
      private var _category:uint;
      
      public function AddFriendWindow()
      {
         super();
      }
      
      public function main(params:Array) : void
      {
         this._category = params[0];
         switch(this._category)
         {
            case SocialCharacterCategoryEnum.CATEGORY_FRIEND_ANKAMA:
               this.lbl_title.text = this.uiApi.getText("ui.common.invitation");
               break;
            case SocialCharacterCategoryEnum.CATEGORY_FRIEND:
            case SocialCharacterCategoryEnum.CATEGORY_CONTACT:
               this.lbl_title.text = this.uiApi.getText("ui.social.addContact");
               break;
            case SocialCharacterCategoryEnum.CATEGORY_IGNORED:
               this.lbl_title.text = this.uiApi.getText("ui.social.ignoreContact");
               break;
            case SocialCharacterCategoryEnum.CATEGORY_ENEMY:
               this.lbl_title.text = this.uiApi.getText("ui.social.blockContact");
         }
         this.btn_lbl_btn_sendInvite.text = this.uiApi.getText(this._category == SocialCharacterCategoryEnum.CATEGORY_FRIEND_ANKAMA ? "ui.social.reportSend" : "ui.common.validation");
         this.btn_sendInvite.soundId = SoundEnum.OK_BUTTON;
         this.uiApi.getUi("addFriendWindow").strata = this.uiApi.getUi("socialBase").strata - 1;
         this.lbl_account.text = this.uiApi.getText(this._category == SocialCharacterCategoryEnum.CATEGORY_FRIEND_ANKAMA ? "ui.header.dofusPseudo" : "ui.common.accountOrCharName");
         this.inp_account.focus();
         this.sysApi.addHook(SocialHookList.FailInvitation,this.failInvitation);
         this.sysApi.addHook(ChatServiceHookList.ChatServiceFriendInviteCreated,this.onFriendInviteLauncherCreated);
         this.sysApi.addHook(SocialHookList.FriendsListUpdated,this.onFriendsOrContactUpdated);
         this.sysApi.addHook(SocialHookList.ContactsListUpdated,this.onFriendsOrContactUpdated);
         this.sysApi.addHook(SocialHookList.EnemiesListUpdated,this.onEnemiesUpdated);
         this.sysApi.addHook(SocialHookList.IgnoredListUpdated,this.onIgnoredUpdated);
         this.uiApi.addComponentHook(this.btn_sendInvite,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.inp_account,ComponentHookList.ON_RELEASE);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.inp_account.text = params[1];
      }
      
      private function failInvitation(response:String) : void
      {
         this.lbl_error.text = response;
         this.inp_account.blur();
      }
      
      private function failChatServiceInvitation(payload:Payload, status:String) : void
      {
         this.lbl_error.text = this.uiApi.getText("ui.socialError.doesNotExist");
         this.inp_account.blur();
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "validUi":
               this.sendInvite();
               return true;
            case "closeUi":
               this.closeMe();
               return true;
            default:
               return false;
         }
      }
      
      public function unload() : void
      {
         this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_close:
               this.closeMe();
               break;
            case this.btn_sendInvite:
               this.sendInvite();
               break;
            case this.inp_account:
               this.lbl_error.text = "";
         }
      }
      
      private function closeMe() : void
      {
         if(this.uiApi)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      private function sendInvite() : void
      {
         var containsTag:* = false;
         var recipientArray:Array = null;
         var recipient:String = null;
         var recipientTag:String = null;
         if(this.inp_account.text)
         {
            containsTag = this.inp_account.text.indexOf(PlayerManager.TAG_PREFIX) != -1;
            recipientArray = StringUtil.trim(this.inp_account.text.toLowerCase()).split(PlayerManager.TAG_PREFIX);
            recipient = recipientArray[0];
            recipientTag = recipientArray.length > 1 ? recipientArray[1] : "";
            this.inp_account.text = "";
            if(containsTag && !recipientTag.match(/^\d{4}$/))
            {
               this.lbl_error.text = this.uiApi.getText("ui.social.friend.addFailureNotFound");
               return;
            }
            switch(this._category)
            {
               case SocialCharacterCategoryEnum.CATEGORY_FRIEND_ANKAMA:
                  if(!this.chatServiceApi.service.authenticated)
                  {
                     this.lbl_error.text = this.uiApi.getText("ui.secureMode.error.checkCode.503");
                  }
                  else if(recipient == this.sysApi.getPlayerManager().nickname.toLowerCase())
                  {
                     this.lbl_error.text = this.uiApi.getText("ui.social.friend.addFailureEgocentric");
                  }
                  else if(this.chatServiceApi.service.getFriend(recipient))
                  {
                     this.lbl_error.text = this.uiApi.getText("ui.socialError.alreadyInList");
                  }
                  else if(recipient != "")
                  {
                     this.chatServiceApi.service.sendFriendInvite(recipient,recipientTag,this.failChatServiceInvitation);
                  }
                  break;
               case SocialCharacterCategoryEnum.CATEGORY_FRIEND:
               case SocialCharacterCategoryEnum.CATEGORY_CONTACT:
                  this.sysApi.sendAction(new AddFriendAction([recipient,recipientTag]));
                  break;
               case SocialCharacterCategoryEnum.CATEGORY_ENEMY:
                  this.sysApi.sendAction(new AddEnemyAction([recipient,recipientTag]));
                  break;
               case SocialCharacterCategoryEnum.CATEGORY_IGNORED:
                  this.sysApi.sendAction(new AddIgnoredAction([recipient,recipientTag]));
            }
         }
      }
      
      private function onFriendInviteLauncherCreated(friendInvite:FriendInvite) : void
      {
         if(friendInvite.inviter.userId == this.sysApi.getPlayerManager().accountId.toString())
         {
            this.chatApi.sendInfoOnChat(this.uiApi.getText("ui.social.friendInviteSent",PlayerManager.getInstance().formatTagName(friendInvite.recipient.name,friendInvite.recipient.tag,null,false)));
            this.closeMe();
         }
      }
      
      private function onFriendsOrContactUpdated() : void
      {
         this.closeMe();
      }
      
      private function onEnemiesUpdated() : void
      {
         this.closeMe();
      }
      
      private function onIgnoredUpdated() : void
      {
         this.closeMe();
      }
   }
}
