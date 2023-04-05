package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class ChatHookList
   {
      
      public static const ChatSendPreInit:String = "ChatSendPreInit";
      
      public static const ChatAppendLine:String = "ChatAppendLine";
      
      public static const ChatError:String = "ChatError";
      
      public static const ChatServer:String = "ChatServer";
      
      public static const ChatServerWithObject:String = "ChatServerWithObject";
      
      public static const ChatServerCopy:String = "ChatServerCopy";
      
      public static const ChatServerCopyWithObject:String = "ChatServerCopyWithObject";
      
      public static const ChatSmiley:String = "ChatSmiley";
      
      public static const MoodResult:String = "MoodResult";
      
      public static const SmileyListUpdated:String = "SmileyListUpdated";
      
      public static const NewMessage:String = "NewMessage";
      
      public static const ChatSpeakingItem:String = "ChatSpeakingItem";
      
      public static const TextInformation:String = "TextInformation";
      
      public static const TextActionInformation:String = "TextActionInformation";
      
      public static const ChatFocus:String = "ChatFocus";
      
      public static const ChatFocusInterGame:String = "ChatFocusInterGame";
      
      public static const ChannelEnablingChange:String = "ChannelEnablingChange";
      
      public static const EnabledChannels:String = "EnabledChannels";
      
      public static const ChatCommunityChannelCommunity:String = "ChatCommunityChannelCommunity";
      
      public static const LivingObjectMessage:String = "LivingObjectMessage";
      
      public static const InsertRecipeHyperlink:String = "InsertRecipeHyperlink";
      
      public static const Notification:String = "Notification";
      
      public static const PopupWarning:String = "PopupWarning";
      
      public static const ChatWarning:String = "ChatWarning";
      
      public static const ChatLinkRelease:String = "ChatLinkRelease";
      
      public static const AddItemHyperlink:String = "AddItemHyperlink";
      
      public static const ShowObjectLinked:String = "ShowObjectLinked";
      
      public static const ToggleChatLog:String = "ToggleChatLog";
      
      public static const ClearChat:String = "ClearChat";
      
      public static const NumericWhoIs:String = "NumericWhoIs";
      
      public static const SilentWhoIs:String = "SilentWhoIs";
       
      
      public function ChatHookList()
      {
         super();
      }
      
      public static function initHooks() : void
      {
         Hook.createHook(ChatSendPreInit);
         Hook.createHook(ChatAppendLine);
         Hook.createHook(ChatError);
         Hook.createHook(ChatServer);
         Hook.createHook(ChatServerWithObject);
         Hook.createHook(ChatServerCopy);
         Hook.createHook(ChatServerCopyWithObject);
         Hook.createHook(ChatSmiley);
         Hook.createHook(MoodResult);
         Hook.createHook(SmileyListUpdated);
         Hook.createHook(NewMessage);
         Hook.createHook(ChatSpeakingItem);
         Hook.createHook(TextInformation);
         Hook.createHook(TextActionInformation);
         Hook.createHook(ChatFocus);
         Hook.createHook(ChatFocusInterGame);
         Hook.createHook(ChannelEnablingChange);
         Hook.createHook(EnabledChannels);
         Hook.createHook(ChatCommunityChannelCommunity);
         Hook.createHook(LivingObjectMessage);
         Hook.createHook(InsertRecipeHyperlink);
         Hook.createHook(Notification);
         Hook.createHook(PopupWarning);
         Hook.createHook(ChatWarning);
         Hook.createHook(ChatLinkRelease);
         Hook.createHook(AddItemHyperlink);
         Hook.createHook(ShowObjectLinked);
         Hook.createHook(ToggleChatLog);
         Hook.createHook(ClearChat);
         Hook.createHook(NumericWhoIs);
         Hook.createHook(SilentWhoIs);
      }
   }
}
