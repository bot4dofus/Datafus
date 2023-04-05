package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShortcutBarRemoveRequestAction extends AbstractAction implements Action
   {
       
      
      public var barType:uint;
      
      public var slot:uint;
      
      public function ShortcutBarRemoveRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(barType:uint, slot:uint) : ShortcutBarRemoveRequestAction
      {
         var a:ShortcutBarRemoveRequestAction = new ShortcutBarRemoveRequestAction(arguments);
         a.barType = barType;
         a.slot = slot;
         return a;
      }
   }
}
