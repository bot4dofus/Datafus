package com.ankamagames.dofus.logic.game.common.actions.alignment
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AlignmentWarEffortDonateAction extends AbstractAction implements Action
   {
       
      
      public var donation:Number;
      
      public function AlignmentWarEffortDonateAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(donation:Number) : AlignmentWarEffortDonateAction
      {
         var a:AlignmentWarEffortDonateAction = new AlignmentWarEffortDonateAction(arguments);
         a.donation = donation;
         return a;
      }
   }
}
