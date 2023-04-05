package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.actions.alignment.AlignmentWarEffortDonateAction;
   import com.ankamagames.dofus.logic.game.common.actions.alignment.AlignmentWarEffortProgressionRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alignment.CharacterAlignmentWarEffortProgressionRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.alignment.SetEnablePVPRequestAction;
   import com.ankamagames.dofus.misc.lists.AlignmentHookList;
   import com.ankamagames.dofus.network.enums.AlignmentSideEnum;
   import com.ankamagames.dofus.network.enums.AlignmentWarEffortDonationResultEnum;
   import com.ankamagames.dofus.network.messages.game.character.alignment.war.effort.AlignmentWarEffortDonateRequestMessage;
   import com.ankamagames.dofus.network.messages.game.character.alignment.war.effort.AlignmentWarEffortDonationResultMessage;
   import com.ankamagames.dofus.network.messages.game.character.alignment.war.effort.CharacterAlignmentWarEffortProgressionMessage;
   import com.ankamagames.dofus.network.messages.game.character.alignment.war.effort.CharacterAlignmentWarEffortProgressionRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.alignment.war.effort.AlignmentWarEffortProgressionMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.alignment.war.effort.AlignmentWarEffortProgressionRequestMessage;
   import com.ankamagames.dofus.network.messages.game.pvp.AlignmentRankUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.pvp.SetEnablePVPRequestMessage;
   import com.ankamagames.dofus.network.types.game.context.roleplay.alignment.war.effort.AlignmentWarEffortInformation;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.utils.getQualifiedClassName;
   
   public class AlignmentFrame implements Frame
   {
      
      private static var _instance:AlignmentFrame;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AlignmentFrame));
       
      
      private var _alignmentRank:int = -1;
      
      public function AlignmentFrame()
      {
         super();
      }
      
      public static function getInstance() : AlignmentFrame
      {
         return _instance;
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function get playerRank() : int
      {
         return this._alignmentRank;
      }
      
      public function pushed() : Boolean
      {
         _instance = this;
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var sepract:SetEnablePVPRequestAction = null;
         var seprmsg:SetEnablePVPRequestMessage = null;
         var arumsg:AlignmentRankUpdateMessage = null;
         var caweprm:CharacterAlignmentWarEffortProgressionRequestMessage = null;
         var cawepm:CharacterAlignmentWarEffortProgressionMessage = null;
         var aweprm:AlignmentWarEffortProgressionRequestMessage = null;
         var awepm:AlignmentWarEffortProgressionMessage = null;
         var bontaParticipation:Number = NaN;
         var brakmarParticipation:Number = NaN;
         var ainfo:AlignmentWarEffortInformation = null;
         var awedrm:AlignmentWarEffortDonationResultMessage = null;
         var awedma:AlignmentWarEffortDonateAction = null;
         var awedrqm:AlignmentWarEffortDonateRequestMessage = null;
         switch(true)
         {
            case msg is SetEnablePVPRequestAction:
               sepract = msg as SetEnablePVPRequestAction;
               seprmsg = new SetEnablePVPRequestMessage();
               seprmsg.initSetEnablePVPRequestMessage(sepract.enable);
               ConnectionsHandler.getConnection().send(seprmsg);
               return true;
            case msg is AlignmentRankUpdateMessage:
               arumsg = msg as AlignmentRankUpdateMessage;
               this._alignmentRank = arumsg.alignmentRank;
               if(arumsg.verbose)
               {
                  KernelEventsManager.getInstance().processCallback(AlignmentHookList.AlignmentRankUpdate,arumsg.alignmentRank);
               }
               return true;
            case msg is CharacterAlignmentWarEffortProgressionRequestAction:
               caweprm = new CharacterAlignmentWarEffortProgressionRequestMessage();
               ConnectionsHandler.getConnection().send(caweprm);
               return true;
            case msg is CharacterAlignmentWarEffortProgressionMessage:
               cawepm = msg as CharacterAlignmentWarEffortProgressionMessage;
               KernelEventsManager.getInstance().processCallback(AlignmentHookList.CharacterAlignmentWarEffortProgressionHook,cawepm.alignmentWarEffortDailyLimit,cawepm.alignmentWarEffortDailyDonation,cawepm.alignmentWarEffortPersonalDonation);
               return true;
            case msg is AlignmentWarEffortProgressionRequestAction:
               aweprm = new AlignmentWarEffortProgressionRequestMessage();
               ConnectionsHandler.getConnection().send(aweprm);
               return true;
            case msg is AlignmentWarEffortProgressionMessage:
               awepm = msg as AlignmentWarEffortProgressionMessage;
               for each(ainfo in awepm.effortProgressions)
               {
                  if(ainfo.alignmentSide == AlignmentSideEnum.ALIGNMENT_ANGEL)
                  {
                     bontaParticipation = ainfo.alignmentWarEffort;
                  }
                  if(ainfo.alignmentSide == AlignmentSideEnum.ALIGNMENT_EVIL)
                  {
                     brakmarParticipation = ainfo.alignmentWarEffort;
                  }
               }
               KernelEventsManager.getInstance().processCallback(AlignmentHookList.AlignmentWarEffortProgressionMessageHook,bontaParticipation,brakmarParticipation);
               return true;
            case msg is AlignmentWarEffortDonationResultMessage:
               awedrm = msg as AlignmentWarEffortDonationResultMessage;
               if(awedrm.result == AlignmentWarEffortDonationResultEnum.WAR_EFFORT_DONATION_SUCCESS)
               {
                  KernelEventsManager.getInstance().processCallback(AlignmentHookList.UpdateWarEffortHook);
               }
               return true;
            case msg is AlignmentWarEffortDonateAction:
               awedma = msg as AlignmentWarEffortDonateAction;
               awedrqm = new AlignmentWarEffortDonateRequestMessage();
               awedrqm.initAlignmentWarEffortDonateRequestMessage(awedma.donation);
               ConnectionsHandler.getConnection().send(awedrqm);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         _instance = null;
         return true;
      }
   }
}
