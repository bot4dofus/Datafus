package com.ankamagames.dofus.logic.game.common.actions.craft
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeSetCraftRecipeAction extends AbstractAction implements Action
   {
       
      
      public var recipeId:uint;
      
      public function ExchangeSetCraftRecipeAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(recipeId:uint) : ExchangeSetCraftRecipeAction
      {
         var action:ExchangeSetCraftRecipeAction = new ExchangeSetCraftRecipeAction(arguments);
         action.recipeId = recipeId;
         return action;
      }
   }
}
