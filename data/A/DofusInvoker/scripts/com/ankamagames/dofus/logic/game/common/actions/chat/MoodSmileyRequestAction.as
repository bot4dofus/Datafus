package com.ankamagames.dofus.logic.game.common.actions.chat
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class MoodSmileyRequestAction extends AbstractAction implements Action
   {
       
      
      public var smileyId:uint;
      
      public function MoodSmileyRequestAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(id:uint) : MoodSmileyRequestAction
      {
         var a:MoodSmileyRequestAction = new MoodSmileyRequestAction(arguments);
         a.smileyId = id;
         return a;
      }
   }
}
