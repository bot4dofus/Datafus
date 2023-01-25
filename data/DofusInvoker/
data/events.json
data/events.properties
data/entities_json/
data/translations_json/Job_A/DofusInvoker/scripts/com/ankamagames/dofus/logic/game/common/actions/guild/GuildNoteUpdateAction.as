package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildNoteUpdateAction extends AbstractAction implements Action
   {
       
      
      public var memberId:Number = -1;
      
      public var text:String = null;
      
      public function GuildNoteUpdateAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(memberId:Number, text:String) : GuildNoteUpdateAction
      {
         var action:GuildNoteUpdateAction = new GuildNoteUpdateAction(arguments);
         action.memberId = memberId;
         action.text = text;
         return action;
      }
   }
}
