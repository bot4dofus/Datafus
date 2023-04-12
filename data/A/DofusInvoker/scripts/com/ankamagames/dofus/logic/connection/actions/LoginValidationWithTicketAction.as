package com.ankamagames.dofus.logic.connection.actions
{
   public class LoginValidationWithTicketAction extends LoginValidationAction
   {
       
      
      public var ticket:String;
      
      public function LoginValidationWithTicketAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(username:String, ticket:String, autoSelectServer:Boolean, serverId:uint = 0, host:String = null) : LoginValidationWithTicketAction
      {
         var a:LoginValidationWithTicketAction = new LoginValidationWithTicketAction(arguments);
         a.password = "";
         a.username = username == null ? "" : username;
         a.ticket = ticket;
         a.autoSelectServer = autoSelectServer;
         a.serverId = serverId;
         a.host = host;
         return a;
      }
   }
}
