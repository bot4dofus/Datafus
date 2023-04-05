package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ConsumeMultipleKardAction extends AbstractAction implements Action
   {
       
      
      public var id:uint;
      
      public function ConsumeMultipleKardAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(id:uint) : ConsumeMultipleKardAction
      {
         var a:ConsumeMultipleKardAction = new ConsumeMultipleKardAction(arguments);
         a.id = id;
         return a;
      }
   }
}
