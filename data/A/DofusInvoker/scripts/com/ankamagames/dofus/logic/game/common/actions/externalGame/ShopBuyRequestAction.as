package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShopBuyRequestAction extends AbstractAction implements Action
   {
       
      
      public var articleId:int;
      
      public var quantity:int;
      
      public var currency:String;
      
      public var amount:Number;
      
      public function ShopBuyRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(articleId:int, quantity:int, currency:String, amount:Number = 0) : ShopBuyRequestAction
      {
         var action:ShopBuyRequestAction = new ShopBuyRequestAction(arguments);
         action.articleId = articleId;
         action.quantity = quantity;
         action.currency = currency;
         action.amount = amount;
         return action;
      }
   }
}
