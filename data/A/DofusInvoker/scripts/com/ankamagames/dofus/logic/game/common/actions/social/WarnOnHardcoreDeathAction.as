package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class WarnOnHardcoreDeathAction extends AbstractAction implements Action
   {
       
      
      public var enable:Boolean;
      
      public function WarnOnHardcoreDeathAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(enable:Boolean) : WarnOnHardcoreDeathAction
      {
         var a:WarnOnHardcoreDeathAction = new WarnOnHardcoreDeathAction(arguments);
         a.enable = enable;
         return a;
      }
   }
}
