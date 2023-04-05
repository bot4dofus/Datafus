package com.ankamagames.dofus.logic.game.common.actions.externalGame
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ConsumeCodeAction extends AbstractAction implements Action
   {
       
      
      public var code:String;
      
      public function ConsumeCodeAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(code:String) : ConsumeCodeAction
      {
         var a:ConsumeCodeAction = new ConsumeCodeAction(arguments);
         a.code = code;
         return a;
      }
   }
}
