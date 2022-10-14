package com.ankamagames.dofus.console.chat
{
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyInvitationAction;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.network.messages.game.friend.FriendAddRequestMessage;
   import com.ankamagames.dofus.network.messages.game.friend.IgnoredAddRequestMessage;
   import com.ankamagames.dofus.network.types.common.PlayerSearchCharacterNameInformation;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.data.I18n;
   
   public class SocialInstructionHandler implements ConsoleInstructionHandler
   {
       
      
      public function SocialInstructionHandler()
      {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         var s:String = null;
         var friend:String = null;
         var name:String = null;
         var inviteAction:PartyInvitationAction = null;
         var reason:String = null;
         var farmsg:FriendAddRequestMessage = null;
         var player_FARMSG:PlayerSearchCharacterNameInformation = null;
         var iarmsg:IgnoredAddRequestMessage = null;
         var player_IARMSG:PlayerSearchCharacterNameInformation = null;
         switch(cmd)
         {
            case "f":
               if(args.length != 2)
               {
                  return;
               }
               s = args[0] as String;
               friend = args[1] as String;
               if(friend.length < 2 || friend.length > 20)
               {
                  reason = I18n.getUiText("ui.social.friend.addFailureNotFound");
                  console.output(reason);
                  return;
               }
               if(friend != PlayedCharacterManager.getInstance().infos.name)
               {
                  if(s == "a" || s == "+")
                  {
                     farmsg = new FriendAddRequestMessage();
                     player_FARMSG = new PlayerSearchCharacterNameInformation().initPlayerSearchCharacterNameInformation(friend);
                     farmsg.initFriendAddRequestMessage(player_FARMSG);
                     ConnectionsHandler.getConnection().send(farmsg);
                  }
               }
               else
               {
                  console.output(I18n.getUiText("ui.social.friend.addFailureEgocentric"));
               }
               break;
            case "ignore":
               if(args.length != 2)
               {
                  return;
               }
               s = args[0] as String;
               friend = args[1] as String;
               if(friend.length < 2 || friend.length > 20)
               {
                  reason = I18n.getUiText("ui.social.friend.addFailureNotFound");
                  console.output(reason);
                  return;
               }
               if(friend == PlayedCharacterManager.getInstance().infos.name)
               {
                  console.output(I18n.getUiText("ui.social.friend.addFailureEgocentric"));
                  return;
               }
               if(s == "a" || s == "+")
               {
                  iarmsg = new IgnoredAddRequestMessage();
                  player_IARMSG = new PlayerSearchCharacterNameInformation().initPlayerSearchCharacterNameInformation(friend);
                  iarmsg.initIgnoredAddRequestMessage(player_IARMSG);
                  ConnectionsHandler.getConnection().send(iarmsg);
               }
               break;
            case "invite":
               if(args.length != 1)
               {
                  return;
               }
               name = args[0] as String;
               if(name == "" || name.length < 2 || name.length > 19)
               {
                  return;
               }
               inviteAction = PartyInvitationAction.create(name);
               Kernel.getWorker().process(inviteAction);
               break;
         }
      }
      
      public function getHelp(cmd:String) : String
      {
         switch(cmd)
         {
            case "f":
               return I18n.getUiText("ui.chat.console.help.friendhelp");
            case "ignore":
               return I18n.getUiText("ui.chat.console.help.enemyhelp");
            case "invite":
               return I18n.getUiText("ui.chat.console.help.invite");
            default:
               return I18n.getUiText("ui.chat.console.noHelp",[cmd]);
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array
      {
         return [];
      }
   }
}
