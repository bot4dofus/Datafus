package com.ankamagames.dofus.logic.game.common.actions.social
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class AllianceMemberWarningSetAction extends AbstractAction implements Action
   {
       
      
      public var enable:Boolean;
      
      public function AllianceMemberWarningSetAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(enable:Boolean) : AllianceMemberWarningSetAction
      {
         var a:AllianceMemberWarningSetAction = new AllianceMemberWarningSetAction(arguments);
         a.enable = enable;
         return a;
      }
   }
}
