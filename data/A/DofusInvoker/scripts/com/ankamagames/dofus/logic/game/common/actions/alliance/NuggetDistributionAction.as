package com.ankamagames.dofus.logic.game.common.actions.alliance
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.dofus.network.types.game.nuggets.NuggetsBeneficiary;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class NuggetDistributionAction extends AbstractAction implements Action
   {
       
      
      public var beneficiaries:Vector.<NuggetsBeneficiary>;
      
      public function NuggetDistributionAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(beneficiaries:Vector.<NuggetsBeneficiary>) : NuggetDistributionAction
      {
         var action:NuggetDistributionAction = new NuggetDistributionAction(arguments);
         action.beneficiaries = beneficiaries;
         return action;
      }
   }
}
