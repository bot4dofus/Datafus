package com.ankamagames.dofus.logic.game.common.actions
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class PlaySoundAction extends AbstractAction implements Action
   {
       
      
      public var soundId:String;
      
      public function PlaySoundAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pSoundId:String) : PlaySoundAction
      {
         var action:PlaySoundAction = new PlaySoundAction(arguments);
         action.soundId = pSoundId;
         return action;
      }
   }
}
