package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseGuildRightsChangeAction extends AbstractAction implements Action
   {
       
      
      public var rights:int;
      
      public function HouseGuildRightsChangeAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(rights:int) : HouseGuildRightsChangeAction
      {
         var action:HouseGuildRightsChangeAction = new HouseGuildRightsChangeAction(arguments);
         action.rights = rights;
         return action;
      }
   }
}
