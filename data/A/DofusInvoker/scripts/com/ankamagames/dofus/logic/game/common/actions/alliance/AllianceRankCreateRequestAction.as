package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceRankCreateRequestAction extends AbstractAction implements Action
   {
       
      
      public var parentRankId:uint;
      
      public var gfxId:uint;
      
      public var name:String;
      
      public function AllianceRankCreateRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(parentRankId:uint, gfxId:uint, name:String) : AllianceRankCreateRequestAction
      {
         var action:AllianceRankCreateRequestAction = new AllianceRankCreateRequestAction(arguments);
         action.parentRankId = parentRankId;
         action.gfxId = gfxId;
         action.name = name;
         return action;
      }
   }
}
