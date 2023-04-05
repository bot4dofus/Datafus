package com.ankamagames.dofus.logic.game.common.actions.guild
{
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.jerakine.handlers.messages.Action;
   
   public class GuildGetInformationsAction extends AbstractAction implements Action
   {
       
      
      public var infoType:uint;
      
      public function GuildGetInformationsAction(params:Array = null)
      {
         super(params);
      }
      
      public static function create(pInfoType:uint) : GuildGetInformationsAction
      {
         var action:GuildGetInformationsAction = new GuildGetInformationsAction(arguments);
         action.infoType = pInfoType;
         return action;
      }
   }
}
