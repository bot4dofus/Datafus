package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShopAuthentificationRequestAction extends AbstractAction implements Action
   {
       
      
      public function ShopAuthentificationRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : ShopAuthentificationRequestAction
      {
         return new ShopAuthentificationRequestAction(arguments);
      }
   }
}
