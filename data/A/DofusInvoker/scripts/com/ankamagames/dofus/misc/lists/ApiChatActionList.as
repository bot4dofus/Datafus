package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChannelEnablingAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatCommunityChannelSetCommunityAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatRefreshChannelAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatRefreshChatAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatSmileyRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatTextOutputAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.FightOutputAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.LivingObjectMessageRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.MoodSmileyRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.SaveMessageAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.TabsUpdateAction;
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   
   public class ApiChatActionList
   {
      
      public static const ChannelEnabling:DofusApiAction = new DofusApiAction("ChannelEnablingAction",ChannelEnablingAction);
      
      public static const ChatCommunityChannelSetCommunity:DofusApiAction = new DofusApiAction("ChatCommunityChannelSetCommunityAction",ChatCommunityChannelSetCommunityAction);
      
      public static const TabsUpdate:DofusApiAction = new DofusApiAction("TabsUpdateAction",TabsUpdateAction);
      
      public static const ChatSmileyRequest:DofusApiAction = new DofusApiAction("ChatSmileyRequestAction",ChatSmileyRequestAction);
      
      public static const MoodSmileyRequest:DofusApiAction = new DofusApiAction("MoodSmileyRequestAction",MoodSmileyRequestAction);
      
      public static const ChatRefreshChannel:DofusApiAction = new DofusApiAction("ChatRefreshChannelAction",ChatRefreshChannelAction);
      
      public static const ChatRefreshChat:DofusApiAction = new DofusApiAction("ChatRefreshChatAction",ChatRefreshChatAction);
      
      public static const ChatTextOutput:DofusApiAction = new DofusApiAction("ChatTextOutputAction",ChatTextOutputAction);
      
      public static const SaveMessage:DofusApiAction = new DofusApiAction("SaveMessageAction",SaveMessageAction);
      
      public static const FightOutput:DofusApiAction = new DofusApiAction("FightOutputAction",FightOutputAction);
      
      public static const LivingObjectMessageRequest:DofusApiAction = new DofusApiAction("LivingObjectMessageRequestAction",LivingObjectMessageRequestAction);
       
      
      public function ApiChatActionList()
      {
         super();
      }
   }
}
