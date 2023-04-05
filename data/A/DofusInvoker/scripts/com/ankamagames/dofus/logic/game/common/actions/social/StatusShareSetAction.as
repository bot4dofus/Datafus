package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class StatusShareSetAction extends AbstractAction implements Action
   {
       
      
      public var enable:Boolean;
      
      public function StatusShareSetAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(enable:Boolean) : StatusShareSetAction
      {
         var a:StatusShareSetAction = new StatusShareSetAction(arguments);
         a.enable = enable;
         return a;
      }
   }
}
