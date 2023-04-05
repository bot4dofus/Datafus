package com.ankamagames.dofus.logic.game.common.actions.party
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class ArenaRegisterAction extends AbstractAction implements Action
   {
       
      
      public var fightTypeId:uint;
      
      public var shortcut:Boolean;
      
      public function ArenaRegisterAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(fightTypeId:uint, shortcut:Boolean) : ArenaRegisterAction
      {
         var a:ArenaRegisterAction = new ArenaRegisterAction(arguments);
         a.fightTypeId = fightTypeId;
         a.shortcut = shortcut;
         return a;
      }
   }
}
