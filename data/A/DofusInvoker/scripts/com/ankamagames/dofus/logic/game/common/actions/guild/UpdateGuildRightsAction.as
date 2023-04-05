package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class UpdateGuildRightsAction extends AbstractAction implements Action
   {
       
      
      public var rankId:uint;
      
      public var rights:Vector.<uint>;
      
      public function UpdateGuildRightsAction(params:Array = null)
      {
         this.rights = new Vector.<uint>();
         super(params);
      }
      
      public static function create(rankId:uint, rights:Vector.<uint>) : UpdateGuildRightsAction
      {
         var action:UpdateGuildRightsAction = new UpdateGuildRightsAction(arguments);
         action.rankId = rankId;
         action.rights = rights;
         return action;
      }
   }
}
