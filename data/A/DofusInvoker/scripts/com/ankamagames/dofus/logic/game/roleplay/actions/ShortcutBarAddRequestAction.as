package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShortcutBarAddRequestAction extends AbstractAction implements Action
   {
       
      
      public var barType:uint;
      
      public var id:uint;
      
      public var slot:uint;
      
      public function ShortcutBarAddRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(barType:uint, id:uint, slot:uint) : ShortcutBarAddRequestAction
      {
         var a:ShortcutBarAddRequestAction = new ShortcutBarAddRequestAction(arguments);
         a.barType = barType;
         a.id = id;
         a.slot = slot;
         return a;
      }
   }
}
