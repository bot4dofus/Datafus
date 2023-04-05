package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceRightsUpdateAction extends AbstractAction implements Action
   {
       
      
      public var rankId:uint;
      
      public var rights:Vector.<uint>;
      
      public function AllianceRightsUpdateAction(params:Array = null)
      {
         this.rights = new Vector.<uint>();
         super(params);
      }
      
      public static function create(rankId:uint, rights:Vector.<uint>) : AllianceRightsUpdateAction
      {
         var action:AllianceRightsUpdateAction = new AllianceRightsUpdateAction(arguments);
         action.rankId = rankId;
         action.rights = rights;
         return action;
      }
   }
}
