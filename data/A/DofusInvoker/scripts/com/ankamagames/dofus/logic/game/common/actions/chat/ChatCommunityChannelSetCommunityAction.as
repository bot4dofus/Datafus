package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ChatCommunityChannelSetCommunityAction extends AbstractAction implements Action
   {
       
      
      public var communityId:int;
      
      public function ChatCommunityChannelSetCommunityAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(communityId:int) : ChatCommunityChannelSetCommunityAction
      {
         var a:ChatCommunityChannelSetCommunityAction = new ChatCommunityChannelSetCommunityAction(arguments);
         a.communityId = communityId;
         return a;
      }
   }
}
