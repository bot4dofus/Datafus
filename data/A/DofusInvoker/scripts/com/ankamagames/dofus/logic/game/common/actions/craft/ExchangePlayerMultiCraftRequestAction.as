package com.ankamagames.dofus.logic.game.common.actions.craft
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangePlayerMultiCraftRequestAction extends AbstractAction implements Action
   {
       
      
      public var exchangeType:int;
      
      public var target:Number;
      
      public var skillId:uint;
      
      public function ExchangePlayerMultiCraftRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pExchangeType:int, pTarget:Number, pSkillId:uint) : ExchangePlayerMultiCraftRequestAction
      {
         var action:ExchangePlayerMultiCraftRequestAction = new ExchangePlayerMultiCraftRequestAction(arguments);
         action.exchangeType = pExchangeType;
         action.target = pTarget;
         action.skillId = pSkillId;
         return action;
      }
   }
}
