package com.ankamagames.dofus.logic.game.common.actions.roleplay
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class SwitchCreatureModeAction extends AbstractAction implements Action
   {
       
      
      public var isActivated:Boolean;
      
      public function SwitchCreatureModeAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pActivated:Boolean = false) : SwitchCreatureModeAction
      {
         var a:SwitchCreatureModeAction = new SwitchCreatureModeAction(arguments);
         a.isActivated = pActivated;
         return a;
      }
   }
}
