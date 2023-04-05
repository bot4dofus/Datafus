package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShopSearchRequestAction extends AbstractAction implements Action
   {
       
      
      public var text:String;
      
      public function ShopSearchRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(text:String, pageId:int = 1) : ShopSearchRequestAction
      {
         var action:ShopSearchRequestAction = new ShopSearchRequestAction(arguments);
         action.text = text;
         return action;
      }
   }
}
