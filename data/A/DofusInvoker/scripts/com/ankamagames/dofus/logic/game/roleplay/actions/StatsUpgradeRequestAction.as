package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class StatsUpgradeRequestAction extends AbstractAction implements Action
   {
       
      
      public var useAdditionnal:Boolean;
      
      public var statId:uint;
      
      public var boostPoint:uint;
      
      public function StatsUpgradeRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(useAdditionnal:Boolean, statId:uint, boostPoint:uint) : StatsUpgradeRequestAction
      {
         var a:StatsUpgradeRequestAction = new StatsUpgradeRequestAction(arguments);
         a.useAdditionnal = useAdditionnal;
         a.statId = statId;
         a.boostPoint = boostPoint;
         return a;
      }
   }
}
