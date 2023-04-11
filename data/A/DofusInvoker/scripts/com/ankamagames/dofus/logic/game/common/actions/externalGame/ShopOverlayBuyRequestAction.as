package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShopOverlayBuyRequestAction extends AbstractAction implements Action
   {
       
      
      public var articleId:int;
      
      public function ShopOverlayBuyRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(articleId:int) : ShopOverlayBuyRequestAction
      {
         var action:ShopOverlayBuyRequestAction = new ShopOverlayBuyRequestAction(arguments);
         action.articleId = articleId;
         return action;
      }
   }
}
