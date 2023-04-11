package com.ankamagames.dofus.logic.connection.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   import com.ankamagames.jerakine.messages.IDontLogThisMessage;
   
   public class LoginValidationAction extends AbstractAction implements Action, IDontLogThisMessage
   {
       
      
      public var username:String;
      
      public var password:String;
      
      public var autoSelectServer:Boolean;
      
      public var serverId:uint;
      
      public var host:String;
      
      public function LoginValidationAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(username:String, password:String, autoSelectServer:Boolean, serverId:uint = 0, host:String = null) : LoginValidationAction
      {
         var a:LoginValidationAction = new LoginValidationAction(arguments);
         a.password = password;
         a.username = username;
         a.autoSelectServer = autoSelectServer;
         a.serverId = serverId;
         a.host = host;
         return a;
      }
   }
}
