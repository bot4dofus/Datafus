package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CreateGuildRankRequestAction extends AbstractAction implements Action
   {
       
      
      public var parentRankId:uint;
      
      public var gfxId:uint;
      
      public var name:String;
      
      public function CreateGuildRankRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(parentRankId:uint, gfxId:uint, name:String) : CreateGuildRankRequestAction
      {
         var action:CreateGuildRankRequestAction = new CreateGuildRankRequestAction(arguments);
         action.parentRankId = parentRankId;
         action.gfxId = gfxId;
         action.name = name;
         return action;
      }
   }
}
