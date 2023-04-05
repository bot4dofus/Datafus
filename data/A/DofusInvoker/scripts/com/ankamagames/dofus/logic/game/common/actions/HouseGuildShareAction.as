package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class HouseGuildShareAction extends AbstractAction implements Action
   {
       
      
      public var houseId:int;
      
      public var instanceId:int;
      
      public var enabled:Boolean;
      
      public var rights:int;
      
      public function HouseGuildShareAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(houseId:int, instanceId:int, enabled:Boolean, rights:int = 0) : HouseGuildShareAction
      {
         var action:HouseGuildShareAction = new HouseGuildShareAction(arguments);
         action.houseId = houseId;
         action.instanceId = instanceId;
         action.enabled = enabled;
         action.rights = rights;
         return action;
      }
   }
}
