package com.ankamagames.dofus.logic.game.common.actions.craft
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction extends AbstractAction implements Action
   {
       
      
      public var allow:Boolean;
      
      public function ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pAllow:Boolean) : ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction
      {
         var action:ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction = new ExchangeMultiCraftSetCrafterCanUseHisRessourcesAction(arguments);
         action.allow = pAllow;
         return action;
      }
   }
}
