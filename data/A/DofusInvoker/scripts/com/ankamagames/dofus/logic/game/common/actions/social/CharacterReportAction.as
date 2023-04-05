package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CharacterReportAction extends AbstractAction implements Action
   {
       
      
      public var reportedId:Number;
      
      public var reason:uint;
      
      public function CharacterReportAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(reportedId:Number, reason:uint) : CharacterReportAction
      {
         var a:CharacterReportAction = new CharacterReportAction(arguments);
         a.reportedId = reportedId;
         a.reason = reason;
         return a;
      }
   }
}
