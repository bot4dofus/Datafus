package com.ankamagames.dofus.logic.game.common.actions.exchange
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ExchangeReadyCrushAction extends AbstractAction implements Action
   {
       
      
      public var isReady:Boolean;
      
      public var focusActionId:uint;
      
      public function ExchangeReadyCrushAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pIsReady:Boolean, pFocusActionId:uint) : ExchangeReadyCrushAction
      {
         var a:ExchangeReadyCrushAction = new ExchangeReadyCrushAction(arguments);
         a.isReady = pIsReady;
         a.focusActionId = pFocusActionId;
         return a;
      }
   }
}
