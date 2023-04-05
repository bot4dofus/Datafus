package com.ankamagames.dofus.logic.game.roleplay.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class EmotePlayRequestAction extends AbstractAction implements Action
   {
       
      
      public var emoteId:uint;
      
      public function EmotePlayRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(emoteId:uint) : EmotePlayRequestAction
      {
         var a:EmotePlayRequestAction = new EmotePlayRequestAction(arguments);
         a.emoteId = emoteId;
         return a;
      }
   }
}
