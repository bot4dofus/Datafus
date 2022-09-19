package Ankama_ContextMenu.makers
{
   import Ankama_ContextMenu.Api;
   import Ankama_ContextMenu.ContextMenu;
   import chat.protocol.user.data.Friend;
   import com.ankamagames.berilia.interfaces.IMenuMaker;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.actions.social.RemoveFriendAction;
   import com.ankamagames.dofus.logic.game.spin2.chat.ChatService;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.jerakine.enum.SocialCharacterCategoryEnum;
   
   public class AccountMenuMaker implements IMenuMaker
   {
      
      public static var disabled:Boolean = false;
       
      
      protected var _accountId:String;
      
      private var _chatService:ChatService;
      
      public function AccountMenuMaker()
      {
         super();
      }
      
      protected function onWhisperMessage(accountName:String) : void
      {
         var friend:Friend = this._chatService.getFriend(accountName);
         Api.system.dispatchHook(ChatHookList.ChatFocusInterGame,friend.user.name,friend.user.tag);
      }
      
      protected function onRemoveContact(accountName:String, accountTag:String, accountId:String) : void
      {
         this._accountId = accountId;
         Api.modCommon.openPopup(Api.ui.getText("ui.popup.warning"),Api.ui.getText("ui.social.doUDeleteContact",PlayerManager.getInstance().formatTagName(accountName,accountTag,null,false)),[Api.ui.getText("ui.common.yes"),Api.ui.getText("ui.common.no")],[this.onAcceptRemoveContact],this.onAcceptRemoveContact);
      }
      
      protected function onAcceptRemoveContact() : void
      {
         Api.system.sendAction(new RemoveFriendAction([parseInt(this._accountId)]));
      }
      
      protected function onRemoveFriends(accountName:String, accountTag:String, accountId:String) : void
      {
         this._accountId = accountId;
         Api.modCommon.openPopup(Api.ui.getText("ui.popup.warning"),Api.ui.getText("ui.social.doUDeleteFriend",PlayerManager.getInstance().formatTagName(accountName,accountTag,null,false)),[Api.ui.getText("ui.common.yes"),Api.ui.getText("ui.common.no")],[this.onAcceptRemoveFriends],this.onAcceptRemoveFriends);
      }
      
      protected function onAcceptRemoveFriends() : void
      {
         this._chatService.deleteUserFriend(this._accountId);
      }
      
      public function createMenu(data:*, param:Object) : Array
      {
         var menu:Array = [];
         this._chatService = Api.chatServiceApi.service;
         if(this._chatService !== null && data.category == SocialCharacterCategoryEnum.CATEGORY_FRIEND_ANKAMA)
         {
            menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.common.wisperMessage"),this.onWhisperMessage,[data.id],disabled));
         }
         if(data.category && Api.system.getPlayerManager().accountId != data.id)
         {
            menu.push(ContextMenu.static_createContextMenuSeparatorObject());
            if(this._chatService !== null && data.category == SocialCharacterCategoryEnum.CATEGORY_FRIEND_ANKAMA)
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.social.removeFromAnkamaFriends"),this.onRemoveFriends,[data.name,data.tag,data.id],disabled));
            }
            if(data.category == SocialCharacterCategoryEnum.CATEGORY_CONTACT || data.category == SocialCharacterCategoryEnum.CATEGORY_FRIEND)
            {
               menu.push(ContextMenu.static_createContextMenuItemObject(Api.ui.getText("ui.social.removeFromContacts"),this.onRemoveContact,[data.name,data.tag,data.id],disabled));
            }
         }
         return menu;
      }
   }
}
