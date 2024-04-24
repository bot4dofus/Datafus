package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ReportPlayerAction extends AbstractAction implements Action
   {
       
      
      public var description:String;
      
      public var categories:Vector.<uint>;
      
      public var targetId:Number;
      
      public function ReportPlayerAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(targetId:Number, categories:Vector.<uint>, description:String) : ReportPlayerAction
      {
         var action:ReportPlayerAction = new ReportPlayerAction(arguments);
         action.description = description;
         action.categories = categories;
         action.targetId = targetId;
         return action;
      }
   }
}
