package com.ankamagames.dofus.console
{
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.console.chat.DieRollInstructionHandler;
   import com.ankamagames.dofus.console.chat.EmoteInstructionHandler;
   import com.ankamagames.dofus.console.chat.FightInstructionHandler;
   import com.ankamagames.dofus.console.chat.InfoInstructionHandler;
   import com.ankamagames.dofus.console.chat.MessagingInstructionHandler;
   import com.ankamagames.dofus.console.chat.OptionsInstructionHandler;
   import com.ankamagames.dofus.console.chat.SocialInstructionHandler;
   import com.ankamagames.dofus.console.chat.StatusInstructionHandler;
   import com.ankamagames.dofus.console.common.LatencyInstructionHandler;
   import com.ankamagames.dofus.console.debug.BenchmarkInstructionHandler;
   import com.ankamagames.dofus.console.debug.MiscInstructionHandler;
   import com.ankamagames.dofus.console.debug.TiphonInstructionHandler;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.dofus.internalDatacenter.FeatureEnum;
   import com.ankamagames.dofus.logic.common.managers.FeatureManager;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.jerakine.console.ConsoleHandler;
   import com.ankamagames.jerakine.console.ConsoleInstructionRegistar;
   import com.ankamagames.jerakine.data.I18n;
   
   public class ChatConsoleInstructionRegistrar implements ConsoleInstructionRegistar
   {
       
      
      public function ChatConsoleInstructionRegistrar()
      {
         super();
      }
      
      public function registerInstructions(console:ConsoleHandler) : void
      {
         var emote:Emoticon = null;
         var emoteShortcuts:Array = [];
         for each(emote in Emoticon.getEmoticons())
         {
            emoteShortcuts.push(emote.shortcut);
         }
         console.addHandler(["whois","version","about","whoami","mapid","cellid","time","travel"],new InfoInstructionHandler());
         console.addHandler(["aping","ping"],new LatencyInstructionHandler());
         console.addHandler(["fps"],new BenchmarkInstructionHandler());
         console.addHandler(["f","ignore","invite"],new SocialInstructionHandler());
         console.addHandler(["castshadow"],new TiphonInstructionHandler());
         console.addHandler(["w","t","g","p","a","r","b"],new MessagingInstructionHandler());
         console.addHandler(["s","spectator","list","players","kick"],new FightInstructionHandler());
         console.addHandler(emoteShortcuts,new EmoteInstructionHandler());
         console.addHandler(["clear"],new OptionsInstructionHandler());
         if(BuildInfos.BUILD_TYPE != BuildTypeEnum.RELEASE)
         {
            console.addHandler(["sd","colorui","coloruilist","coloruisave","coloruireset","celebration","uiinspector","clearcsscache"],new MiscInstructionHandler());
         }
         else
         {
            console.addHandler(["celebration"],new MiscInstructionHandler());
         }
         console.addHandler(["away",I18n.getUiText("ui.chat.status.away").toLocaleLowerCase(),I18n.getUiText("ui.chat.status.solo").toLocaleLowerCase(),I18n.getUiText("ui.chat.status.private").toLocaleLowerCase(),I18n.getUiText("ui.chat.status.availiable").toLocaleLowerCase(),"release"],new StatusInstructionHandler());
         if(FeatureManager.getInstance().isFeatureWithKeywordEnabled(FeatureEnum.CHAT_DICE_ROLL))
         {
            console.addHandler([DieRollInstructionHandler.ROLL_COMMAND],new DieRollInstructionHandler());
         }
      }
   }
}
