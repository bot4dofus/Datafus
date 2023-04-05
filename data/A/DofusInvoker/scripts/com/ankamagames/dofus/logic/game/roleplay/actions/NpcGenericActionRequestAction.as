package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class NpcGenericActionRequestAction extends AbstractAction implements Action
   {
       
      
      public var npcId:int;
      
      public var actionId:int;
      
      public function NpcGenericActionRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(npcId:int, actionId:int) : NpcGenericActionRequestAction
      {
         var a:NpcGenericActionRequestAction = new NpcGenericActionRequestAction(arguments);
         a.npcId = npcId;
         a.actionId = actionId;
         return a;
      }
   }
}
