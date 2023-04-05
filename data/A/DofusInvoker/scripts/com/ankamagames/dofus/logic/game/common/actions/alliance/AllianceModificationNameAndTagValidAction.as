package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceModificationNameAndTagValidAction extends AbstractAction implements Action
   {
       
      
      public var name:String;
      
      public var tag:String;
      
      public function AllianceModificationNameAndTagValidAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pName:String, pTag:String) : AllianceModificationNameAndTagValidAction
      {
         var action:AllianceModificationNameAndTagValidAction = new AllianceModificationNameAndTagValidAction(arguments);
         action.name = pName;
         action.tag = pTag;
         return action;
      }
   }
}
