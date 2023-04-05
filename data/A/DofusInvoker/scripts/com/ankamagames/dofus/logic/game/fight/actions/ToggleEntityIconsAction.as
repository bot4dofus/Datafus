package com.ankamagames.dofus.logic.game.fight.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ToggleEntityIconsAction extends AbstractAction implements Action
   {
       
      
      public var isVisible:Boolean;
      
      public function ToggleEntityIconsAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(isVisible:Boolean) : ToggleEntityIconsAction
      {
         var a:ToggleEntityIconsAction = new ToggleEntityIconsAction(arguments);
         a.isVisible = isVisible;
         return a;
      }
   }
}
