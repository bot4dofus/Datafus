package com.ankamagames.dofus.console.chat
{
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.roleplay.actions.EmotePlayRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.network.enums.PlayerLifeStatusEnum;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionHandler;
   import com.ankamagames.jerakine.data.I18n;
   
   public class EmoteInstructionHandler implements ConsoleInstructionHandler
   {
       
      
      public function EmoteInstructionHandler()
      {
         super();
      }
      
      public function handle(console:ConsoleHandler, cmd:String, args:Array) : void
      {
         var epra:EmotePlayRequestAction = null;
         var emoteId:uint = this.getEmoteId(cmd);
         var playerManager:PlayedCharacterManager = PlayedCharacterManager.getInstance();
         var entFrame:AbstractEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as AbstractEntitiesFrame;
         if(emoteId > 0 && playerManager.state == PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING && (playerManager.isRiding || playerManager.isPetsMounting || playerManager.infos.entityLook.bonesId == 1 || entFrame && entFrame.creaturesMode))
         {
            epra = EmotePlayRequestAction.create(emoteId);
            Kernel.getWorker().process(epra);
         }
      }
      
      public function getArgs(cmd:String) : Array
      {
         var _loc2_:* = cmd;
         switch(0)
         {
         }
         return [];
      }
      
      public function getHelp(cmd:String) : String
      {
         return null;
      }
      
      public function getMan(cmd:String) : String
      {
         var _loc2_:* = cmd;
         switch(0)
         {
         }
         return I18n.getUiText("ui.chat.console.noMan",[cmd]);
      }
      
      public function getExamples(cmd:String) : String
      {
         var _loc2_:* = cmd;
         switch(0)
         {
         }
         return I18n.getUiText("ui.chat.console.noExample",[cmd]);
      }
      
      private function getEmoteId(cmd:String) : uint
      {
         var emote:Emoticon = null;
         for each(emote in Emoticon.getEmoticons())
         {
            if(emote.shortcut == cmd)
            {
               return emote.id;
            }
         }
         return 0;
      }
      
      public function getParamPossibilities(cmd:String, paramIndex:uint = 0, currentParams:Array = null) : Array
      {
         return [];
      }
   }
}
