package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class BasicWhoIsRequestAction extends AbstractAction implements Action
   {
       
      
      public var playerName:String;
      
      public var verbose:Boolean;
      
      public function BasicWhoIsRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(playerName:String, verbose:Boolean) : BasicWhoIsRequestAction
      {
         var a:BasicWhoIsRequestAction = new BasicWhoIsRequestAction(arguments);
         a.playerName = playerName;
         a.verbose = verbose;
         return a;
      }
   }
}
