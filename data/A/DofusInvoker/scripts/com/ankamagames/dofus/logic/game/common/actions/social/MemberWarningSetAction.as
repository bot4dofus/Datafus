package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MemberWarningSetAction extends AbstractAction implements Action
   {
       
      
      public var enable:Boolean;
      
      public function MemberWarningSetAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(enable:Boolean) : MemberWarningSetAction
      {
         var a:MemberWarningSetAction = new MemberWarningSetAction(arguments);
         a.enable = enable;
         return a;
      }
   }
}
