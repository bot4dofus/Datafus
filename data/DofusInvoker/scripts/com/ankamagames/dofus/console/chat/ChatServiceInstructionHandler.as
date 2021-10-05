package com.ankamagames.dofus.console.chat
{
   import chat.protocol.friendinvite.data.DeleteFriendInviteReason;
   import chat.protocol.user.data.Friend;
   import chat.protocol.user.data.FriendList;
   import chat.protocol.user.data.User;
   import chat.protocol.user.data.UserList;
   import com.ankamagames.dofus.logic.game.spin2.chat.ChatService;
   import com.ankamagames.dofus.logic.game.spin2.chat.ChatServiceManager;
   import com.ankamagames.dofus.logic.game.spin2.chat.data.GameActivities;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import flash.utils.Dictionary;
   
   public class ChatServiceInstructionHandler implements ConsoleInstructionHandler
   {
       
      
      public function ChatServiceInstructionHandler()
      {
         super();
      }
      
      public function handle(param1:ConsoleHandler, param2:String, param3:Array) : void
      {
         var _loc4_:ChatService = null;
         var _loc5_:Vector.<String> = null;
         var _loc6_:Dictionary = null;
         var _loc7_:Vector.<GameActivities> = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:FriendList = null;
         var _loc13_:Friend = null;
         var _loc14_:String = null;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:GameActivities = null;
         var _loc18_:String = null;
         var _loc19_:UserList = null;
         var _loc20_:User = null;
         _loc4_ = ChatServiceManager.getInstance().chatService;
         if(_loc4_ == null)
         {
            param1.output("Can\'t find chat service. probably not connected...");
            return;
         }
         switch(param2)
         {
            case "friendinvite":
               if(param3.length == 4)
               {
                  _loc8_ = param3[0];
                  _loc9_ = param3[1];
                  _loc10_ = param3[2];
                  _loc11_ = param3[3];
                  if(_loc9_ != "" && _loc10_ != "" && (_loc11_ == DeleteFriendInviteReason.CANCELED || _loc11_ == DeleteFriendInviteReason.REJECTED || _loc11_ == DeleteFriendInviteReason.ACCEPTED))
                  {
                     if(_loc8_ == "process")
                     {
                        if(_loc9_ == "all")
                        {
                           _loc4_.processAllUserFriendInvites(_loc11_);
                        }
                        else
                        {
                           _loc4_.processUserFriendInvite(_loc9_,_loc10_,_loc11_);
                        }
                     }
                  }
               }
               if(param3.length == 1)
               {
                  _loc4_.sendFriendInvite(param3[0],"");
               }
               else if(param3.length == 2)
               {
                  _loc4_.sendFriendInvite(param3[0],param3[1]);
               }
               break;
            case "friend":
               if(param3.length == 1)
               {
                  _loc8_ = param3[0];
                  if(_loc8_ == "list")
                  {
                     _loc12_ = _loc4_.friendList;
                     for each(_loc13_ in _loc12_.values)
                     {
                        param1.output(_loc13_.toString());
                     }
                  }
               }
               if(param3.length == 2)
               {
                  _loc8_ = param3[0];
                  _loc9_ = param3[1];
                  if(_loc8_ == "delete" && _loc9_ != "")
                  {
                     if(_loc9_ == "all")
                     {
                        _loc4_.deleteAllUserFriend();
                     }
                     else
                     {
                        _loc4_.deleteUserFriend(_loc9_);
                     }
                  }
               }
               if(param3.length == 3)
               {
                  _loc8_ = param3[0];
                  _loc9_ = param3[1];
                  if(_loc8_ == "update" && _loc9_ != "")
                  {
                     _loc4_.updateUserFriend(_loc9_,param3[2]);
                  }
               }
               break;
            case "friendgroup":
               if(param3.length == 2)
               {
                  _loc8_ = param3[0];
                  _loc9_ = param3[1];
                  if(_loc8_ == "create" && _loc9_ != "")
                  {
                     _loc4_.createFriendGroup(_loc9_);
                  }
                  if(_loc8_ == "delete" && _loc9_ != "")
                  {
                     _loc4_.deleteFriendGroup(_loc9_);
                  }
               }
               break;
            case "msg":
               if(param3.length >= 2)
               {
                  _loc9_ = param3[0];
                  _loc14_ = "";
                  _loc15_ = param3.length;
                  for(_loc16_ = 1; _loc16_ < _loc15_; _loc16_++)
                  {
                     _loc14_ += param3[_loc16_] + " ";
                  }
                  if(_loc9_ != "" && _loc14_ != "")
                  {
                     _loc4_.sendMessage(_loc9_,_loc14_);
                  }
               }
               break;
            case "mystatus":
               if(param3.length == 1)
               {
                  _loc4_.updateUserStatus(param3[0]);
               }
               break;
            case "myactivity":
               _loc5_ = new Vector.<String>();
               _loc6_ = new Dictionary();
               if(param3.length > 1)
               {
                  _loc5_.push(param3[0]);
                  if(param3.length >= 3)
                  {
                     _loc6_[param3[1]] = param3[2];
                  }
               }
               _loc4_.updateUserActivity(_loc5_,_loc6_);
               break;
            case "listactivities":
               _loc7_ = _loc4_.getGameActivities();
               for each(_loc17_ in _loc7_)
               {
                  param1.output(_loc17_.toString());
               }
               break;
            case "blockuser":
               if(param3.length == 2)
               {
                  param2 = param3[0];
                  _loc18_ = param3[1];
                  if(param2 == "add")
                  {
                     _loc4_.blockUser(_loc18_);
                  }
                  else if(param2 == "delete")
                  {
                     _loc4_.deleteBlockedUser(_loc18_);
                  }
               }
               else if(param3.length == 1 && param3[0] == "list")
               {
                  _loc19_ = _loc4_.blockedUserList;
                  for each(_loc20_ in _loc19_.values)
                  {
                     param1.output(_loc20_.toString());
                  }
               }
         }
      }
      
      public function getHelp(cmd:String) : String
      {
         switch(cmd)
         {
            case "friendinvite":
               return "\n/friendinvite userId|userName\n/friendinvite process inviterId recipientId Accepted|Rejected|Canceled\n/friendinvite process all Accepted|Rejected|Canceled";
            case "friend":
               return "\n/friend list\n/friend delete userId|userName|all\n/friend update userId|userName groupName";
            case "friendgroup":
               return "\n/friendgroup create groupName\n/friendgroup delete groupName";
            case "msg":
               return "/msg userId|userName hello spin world !!!";
            case "mystatus":
               return "/mystatus Available|Away|Busy";
            case "myactivity":
               return "/myactivity properties";
            case "listactivities":
               return "/listactivities";
            case "blockuser":
               return "\n/blockuser add|delete userId\n/blockuser list";
            default:
               return "";
         }
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array
      {
         return [];
      }
   }
}
