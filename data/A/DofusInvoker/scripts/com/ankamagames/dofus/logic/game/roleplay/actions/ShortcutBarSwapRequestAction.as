package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ShortcutBarSwapRequestAction extends AbstractAction implements Action
   {
       
      
      public var barType:uint;
      
      public var firstSlot:uint;
      
      public var secondSlot:uint;
      
      public function ShortcutBarSwapRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(barType:uint, firstSlot:uint, secondSlot:uint) : ShortcutBarSwapRequestAction
      {
         var a:ShortcutBarSwapRequestAction = new ShortcutBarSwapRequestAction(arguments);
         a.barType = barType;
         a.firstSlot = firstSlot;
         a.secondSlot = secondSlot;
         return a;
      }
   }
}
