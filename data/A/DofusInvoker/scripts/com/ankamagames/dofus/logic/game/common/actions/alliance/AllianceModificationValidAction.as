package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceModificationValidAction extends AbstractAction implements Action
   {
       
      
      public var name:String;
      
      public var tag:String;
      
      public var upEmblemId:uint;
      
      public var upColorEmblem:uint;
      
      public var backEmblemId:uint;
      
      public var backColorEmblem:uint;
      
      public function AllianceModificationValidAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pName:String, pTag:String, pUpEmblemId:uint, pUpColorEmblem:uint, pBackEmblemId:uint, pBackColorEmblem:uint) : AllianceModificationValidAction
      {
         var action:AllianceModificationValidAction = new AllianceModificationValidAction(arguments);
         action.name = pName;
         action.tag = pTag;
         action.upEmblemId = pUpEmblemId;
         action.upColorEmblem = pUpColorEmblem;
         action.backEmblemId = pBackEmblemId;
         action.backColorEmblem = pBackColorEmblem;
         return action;
      }
   }
}
