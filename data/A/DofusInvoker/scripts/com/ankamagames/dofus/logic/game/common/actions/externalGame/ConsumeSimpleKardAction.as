package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ConsumeSimpleKardAction extends AbstractAction implements Action
   {
       
      
      public var id:uint;
      
      public function ConsumeSimpleKardAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(id:uint) : ConsumeSimpleKardAction
      {
         var a:ConsumeSimpleKardAction = new ConsumeSimpleKardAction(arguments);
         a.id = id;
         return a;
      }
   }
}
