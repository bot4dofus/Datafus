package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class CharacterAutoConnectAction extends AbstractAction implements Action
   {
       
      
      public function CharacterAutoConnectAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create() : CharacterAutoConnectAction
      {
         return new CharacterAutoConnectAction(arguments);
      }
   }
}
