package com.ankamagames.dofus.logic.game.common.actions.mount
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MountHarnessColorsUpdateRequestAction extends AbstractAction implements Action
   {
       
      
      public var useHarnessColors:Boolean;
      
      public function MountHarnessColorsUpdateRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(useHarnessColors:Boolean) : MountHarnessColorsUpdateRequestAction
      {
         var a:MountHarnessColorsUpdateRequestAction = new MountHarnessColorsUpdateRequestAction(arguments);
         a.useHarnessColors = useHarnessColors;
         return a;
      }
   }
}
