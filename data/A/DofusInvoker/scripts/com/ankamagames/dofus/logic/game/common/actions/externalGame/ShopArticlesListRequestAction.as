package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShopArticlesListRequestAction extends AbstractAction implements Action
   {
       
      
      public var categoryId:int;
      
      public function ShopArticlesListRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(categoryId:int) : ShopArticlesListRequestAction
      {
         var action:ShopArticlesListRequestAction = new ShopArticlesListRequestAction(arguments);
         action.categoryId = categoryId;
         return action;
      }
   }
}
