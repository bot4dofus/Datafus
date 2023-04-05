package com.ankamagames.dofus.logic.connection.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ServerSelectionAction extends AbstractAction implements Action
   {
       
      
      public var serverId:int;
      
      public function ServerSelectionAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(serverId:int) : ServerSelectionAction
      {
         var a:ServerSelectionAction = new ServerSelectionAction(arguments);
         a.serverId = serverId;
         return a;
      }
   }
}
