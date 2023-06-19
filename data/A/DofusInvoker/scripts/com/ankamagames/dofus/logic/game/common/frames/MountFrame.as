package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.dofus.datacenter.communication.Emoticon;
   import com.ankamagames.dofus.datacenter.mounts.MountBehavior;
   import com.ankamagames.dofus.internalDatacenter.mount.MountData;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.game.common.actions.mount.ExchangeHandleMountStableAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.ExchangeRequestOnMountStockAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountFeedRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountHarnessColorsUpdateRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountHarnessDissociateRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountInfoRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountInformationInPaddockRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountReleaseRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountRenameRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountSetXpRatioRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountSterilizeRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountToggleRidingRequestAction;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.logic.game.roleplay.managers.MountAutoTripManager;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.MountHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.MountCharacteristicEnum;
   import com.ankamagames.dofus.network.enums.MountEquipedErrorEnum;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountDataMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountEmoteIconUsedOkMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountEquipedErrorMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountFeedRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountHarnessColorsUpdateRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountHarnessDissociateRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountInformationInPaddockRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountInformationRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountReleaseRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountReleasedMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountRenameRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountRenamedMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountRidingMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountSetMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountSetXpRatioRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountSterilizeRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountSterilizedMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountToggleRidingRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountUnSetMessage;
   import com.ankamagames.dofus.network.messages.game.context.mount.MountXpRatioMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeHandleMountsMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeMountsPaddockAddMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeMountsPaddockRemoveMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeMountsStableAddMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeMountsStableBornAddMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeMountsStableRemoveMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeMountsTakenFromPaddockMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeRequestOnMountStockMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkMountMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkMountWithOutPaddockMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeWeightMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.UpdateMountCharacteristicsMessage;
   import com.ankamagames.dofus.network.types.game.mount.MountClientData;
   import com.ankamagames.dofus.network.types.game.mount.UpdateMountCharacteristic;
   import com.ankamagames.dofus.network.types.game.mount.UpdateMountIntegerCharacteristic;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.tiphon.sequence.SetAnimationStep;
   import flash.utils.getQualifiedClassName;
   
   public class MountFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MountFrame));
      
      public static const MAX_XP_RATIO:uint = 90;
       
      
      private var _mountDialogFrame:MountDialogFrame;
      
      private var _mountXpRatio:uint;
      
      private var _stableList:Array;
      
      private var _paddockList:Array;
      
      private var _inventoryWeight:uint;
      
      private var _inventoryMaxWeight:uint;
      
      public function MountFrame()
      {
         super();
      }
      
      public function get priority() : int
      {
         return 0;
      }
      
      public function get mountXpRatio() : uint
      {
         return this._mountXpRatio;
      }
      
      public function get stableList() : Array
      {
         return this._stableList;
      }
      
      public function get paddockList() : Array
      {
         return this._paddockList;
      }
      
      public function pushed() : Boolean
      {
         this._mountDialogFrame = new MountDialogFrame();
         return true;
      }
      
      public function initializeMountLists(stables:Vector.<MountClientData>, paddocks:Vector.<MountClientData>) : void
      {
         var mcd:MountClientData = null;
         this._stableList = new Array();
         if(stables)
         {
            for each(mcd in stables)
            {
               this._stableList.push(MountData.makeMountData(mcd,true,this._mountXpRatio));
            }
         }
         this._paddockList = new Array();
         if(paddocks)
         {
            for each(mcd in paddocks)
            {
               this._paddockList.push(MountData.makeMountData(mcd,true,this._mountXpRatio));
            }
         }
      }
      
      public function process(msg:Message) : Boolean
      {
         var mount:MountData = null;
         var mountData:MountClientData = null;
         var uMountId:uint = 0;
         var miipra:MountInformationInPaddockRequestAction = null;
         var miiprmsg:MountInformationInPaddockRequestMessage = null;
         var playerEntity:IMovable = null;
         var mtfra:MountFeedRequestAction = null;
         var mrrmsg:MountReleaseRequestMessage = null;
         var msrmsg:MountSterilizeRequestMessage = null;
         var mrra:MountRenameRequestAction = null;
         var mountRenameRequestMessage:MountRenameRequestMessage = null;
         var msxrra:MountSetXpRatioRequestAction = null;
         var msxrpmsg:MountSetXpRatioRequestMessage = null;
         var mira:MountInfoRequestAction = null;
         var mirmsg:MountInformationRequestMessage = null;
         var eromsmsg:ExchangeRequestOnMountStockMessage = null;
         var mrmsg:MountRenamedMessage = null;
         var mountId:Number = NaN;
         var mountName:String = null;
         var ehmsa:ExchangeHandleMountStableAction = null;
         var idsVector:Vector.<uint> = null;
         var vecLenght:uint = 0;
         var proxVector:Vector.<uint> = null;
         var emsbamsg:ExchangeMountsStableBornAddMessage = null;
         var emsamsg:ExchangeMountsStableAddMessage = null;
         var emsrmsg:ExchangeMountsStableRemoveMessage = null;
         var empamsg:ExchangeMountsPaddockAddMessage = null;
         var emprmsg:ExchangeMountsPaddockRemoveMessage = null;
         var mdmsg:MountDataMessage = null;
         var mrdmsg:MountRidingMessage = null;
         var isRiding:Boolean = false;
         var player:AnimatedCharacter = null;
         var rpEntitiesFrame:RoleplayEntitiesFrame = null;
         var meemsg:MountEquipedErrorMessage = null;
         var typeError:String = null;
         var ewmsg:ExchangeWeightMessage = null;
         var esokmmsg:ExchangeStartOkMountMessage = null;
         var esomwopmsg:ExchangeStartOkMountWithOutPaddockMessage = null;
         var umbmsg:UpdateMountCharacteristicsMessage = null;
         var isInPaddock:Boolean = false;
         var mountToUpdate:Object = null;
         var m:Object = null;
         var meiuomsg:MountEmoteIconUsedOkMessage = null;
         var mountSprite:TiphonSprite = null;
         var emtfpmsg:ExchangeMountsTakenFromPaddockMessage = null;
         var takenMessage:String = null;
         var mremsg:MountReleasedMessage = null;
         var mhdra:MountHarnessDissociateRequestAction = null;
         var mhdrmsg:MountHarnessDissociateRequestMessage = null;
         var mhcura:MountHarnessColorsUpdateRequestAction = null;
         var mhcurmsg:MountHarnessColorsUpdateRequestMessage = null;
         var mtrrmsg:MountToggleRidingRequestMessage = null;
         var mfrmsg:MountFeedRequestMessage = null;
         var ehmsmsg:ExchangeHandleMountsMessage = null;
         var i:int = 0;
         var currentEmote:Emoticon = null;
         var lastStaticAnim:String = null;
         var autopilotBehaviorId:int = 0;
         var behaviors:Vector.<uint> = null;
         var mountIsNowAutoTripable:Boolean = false;
         var mountWasNotAutoTripable:Boolean = false;
         var ability:MountBehavior = null;
         var autopilotMessage:String = null;
         var commonMod:Object = null;
         var boost:UpdateMountCharacteristic = null;
         var intBoost:UpdateMountIntegerCharacteristic = null;
         var animationName:String = null;
         var seq:SerialSequencer = null;
         switch(true)
         {
            case msg is MountInformationInPaddockRequestAction:
               miipra = msg as MountInformationInPaddockRequestAction;
               miiprmsg = new MountInformationInPaddockRequestMessage();
               miiprmsg.initMountInformationInPaddockRequestMessage(miipra.mountId);
               ConnectionsHandler.getConnection().send(miiprmsg);
               return true;
            case msg is MountToggleRidingRequestAction:
               playerEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as IMovable;
               if(playerEntity && !playerEntity.isMoving && !MountAutoTripManager.getInstance().isTravelling)
               {
                  mtrrmsg = new MountToggleRidingRequestMessage();
                  mtrrmsg.initMountToggleRidingRequestMessage();
                  ConnectionsHandler.getConnection().send(mtrrmsg);
               }
               return true;
            case msg is MountFeedRequestAction:
               mtfra = msg as MountFeedRequestAction;
               if(Kernel.getWorker().getFrame(FightBattleFrame) == null)
               {
                  mfrmsg = new MountFeedRequestMessage();
                  mfrmsg.initMountFeedRequestMessage(mtfra.mountId,mtfra.mountLocation,mtfra.mountFoodUid,mtfra.quantity);
                  ConnectionsHandler.getConnection().send(mfrmsg);
               }
               return true;
            case msg is MountReleaseRequestAction:
               mrrmsg = new MountReleaseRequestMessage();
               mrrmsg.initMountReleaseRequestMessage();
               ConnectionsHandler.getConnection().send(mrrmsg);
               return true;
            case msg is MountSterilizeRequestAction:
               msrmsg = new MountSterilizeRequestMessage();
               msrmsg.initMountSterilizeRequestMessage();
               ConnectionsHandler.getConnection().send(msrmsg);
               return true;
            case msg is MountRenameRequestAction:
               mrra = msg as MountRenameRequestAction;
               mountRenameRequestMessage = new MountRenameRequestMessage();
               mountRenameRequestMessage.initMountRenameRequestMessage(!!mrra.newName ? mrra.newName : "",mrra.mountId);
               ConnectionsHandler.getConnection().send(mountRenameRequestMessage);
               return true;
            case msg is MountSetXpRatioRequestAction:
               msxrra = msg as MountSetXpRatioRequestAction;
               msxrpmsg = new MountSetXpRatioRequestMessage();
               msxrpmsg.initMountSetXpRatioRequestMessage(msxrra.xpRatio > MAX_XP_RATIO ? uint(MAX_XP_RATIO) : uint(msxrra.xpRatio));
               ConnectionsHandler.getConnection().send(msxrpmsg);
               return true;
            case msg is MountInfoRequestAction:
               mira = msg as MountInfoRequestAction;
               mirmsg = new MountInformationRequestMessage();
               mirmsg.initMountInformationRequestMessage(mira.mountId,mira.time);
               ConnectionsHandler.getConnection().send(mirmsg);
               return true;
            case msg is ExchangeRequestOnMountStockAction:
               eromsmsg = new ExchangeRequestOnMountStockMessage();
               eromsmsg.initExchangeRequestOnMountStockMessage();
               ConnectionsHandler.getConnection().send(eromsmsg);
               return true;
            case msg is MountSterilizedMessage:
               mountId = MountSterilizedMessage(msg).mountId;
               mount = MountData.getMountFromCache(mountId);
               if(mount)
               {
                  mount.reproductionCount = -1;
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountSterilized,mountId);
               return true;
            case msg is MountRenamedMessage:
               mrmsg = msg as MountRenamedMessage;
               mountId = mrmsg.mountId;
               mountName = mrmsg.name;
               mount = MountData.getMountFromCache(mountId);
               if(mount)
               {
                  mount.name = mountName;
               }
               if(this._mountDialogFrame.inStable)
               {
                  KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate,this._stableList,null,null);
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountRenamed,mountId,mountName);
               return true;
            case msg is ExchangeHandleMountStableAction:
               ehmsa = msg as ExchangeHandleMountStableAction;
               idsVector = Vector.<uint>(ehmsa.ridesId);
               vecLenght = idsVector.length;
               while(vecLenght > 0)
               {
                  if(vecLenght > ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT)
                  {
                     proxVector = idsVector.splice(0,ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT);
                     vecLenght = idsVector.length;
                  }
                  else
                  {
                     proxVector = idsVector;
                     vecLenght = 0;
                  }
                  ehmsmsg = new ExchangeHandleMountsMessage();
                  ehmsmsg.initExchangeHandleMountsMessage(ehmsa.actionType,proxVector);
                  ConnectionsHandler.getConnection().send(ehmsmsg);
               }
               return true;
            case msg is ExchangeMountsStableBornAddMessage:
               emsbamsg = msg as ExchangeMountsStableBornAddMessage;
               for each(mountData in emsbamsg.mountDescription)
               {
                  mount = MountData.makeMountData(mountData,true,this._mountXpRatio);
                  mount.borning = true;
                  if(this._stableList)
                  {
                     this._stableList.push(mount);
                  }
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate,this._stableList,null,null);
               return true;
            case msg is ExchangeMountsStableAddMessage:
               emsamsg = msg as ExchangeMountsStableAddMessage;
               if(this._stableList)
               {
                  for each(mountData in emsamsg.mountDescription)
                  {
                     this._stableList.push(MountData.makeMountData(mountData,true,this._mountXpRatio));
                  }
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate,this._stableList,null,null);
               return true;
            case msg is ExchangeMountsStableRemoveMessage:
               emsrmsg = msg as ExchangeMountsStableRemoveMessage;
               for each(uMountId in emsrmsg.mountsId)
               {
                  for(i = 0; i < this._stableList.length; i++)
                  {
                     if(this._stableList[i].id == uMountId)
                     {
                        this._stableList.splice(i,1);
                        break;
                     }
                  }
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate,this._stableList,null,null);
               return true;
            case msg is ExchangeMountsPaddockAddMessage:
               empamsg = msg as ExchangeMountsPaddockAddMessage;
               for each(mountData in empamsg.mountDescription)
               {
                  this._paddockList.push(MountData.makeMountData(mountData,true,this._mountXpRatio));
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate,null,this._paddockList,null);
               return true;
            case msg is ExchangeMountsPaddockRemoveMessage:
               emprmsg = msg as ExchangeMountsPaddockRemoveMessage;
               for each(uMountId in emprmsg.mountsId)
               {
                  for(i = 0; i < this._paddockList.length; i++)
                  {
                     if(this._paddockList[i].id == uMountId)
                     {
                        this._paddockList.splice(i,1);
                        break;
                     }
                  }
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate,null,this._paddockList,null);
               return true;
            case msg is MountXpRatioMessage:
               this._mountXpRatio = MountXpRatioMessage(msg).ratio;
               mount = PlayedCharacterManager.getInstance().mount;
               if(mount)
               {
                  mount.xpRatio = this._mountXpRatio;
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountXpRatio,this._mountXpRatio);
               return true;
            case msg is MountDataMessage:
               mdmsg = msg as MountDataMessage;
               if(this._mountDialogFrame.inStable)
               {
                  KernelEventsManager.getInstance().processCallback(MountHookList.CertificateMountData,MountData.makeMountData(mdmsg.mountData,false,this.mountXpRatio));
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(MountHookList.PaddockedMountData,MountData.makeMountData(mdmsg.mountData,false,this.mountXpRatio));
               }
               return true;
            case msg is MountRidingMessage:
               mrdmsg = msg as MountRidingMessage;
               isRiding = mrdmsg.isRiding;
               player = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id) as AnimatedCharacter;
               rpEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
               if(player && rpEntitiesFrame)
               {
                  currentEmote = Emoticon.getEmoticonById(rpEntitiesFrame.currentEmoticon);
                  if(player.getAnimation().indexOf("_Statique_") != -1)
                  {
                     lastStaticAnim = player.getAnimation();
                  }
                  else if(currentEmote && currentEmote.persistancy)
                  {
                     lastStaticAnim = player.getAnimation().replace("_","_Statique_");
                  }
                  if(lastStaticAnim)
                  {
                     (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).lastStaticAnimations[player.id] = {"anim":lastStaticAnim};
                  }
                  player.setAnimation(AnimationEnum.ANIM_STATIQUE);
               }
               PlayedCharacterManager.getInstance().isRidding = isRiding;
               KernelEventsManager.getInstance().processCallback(MountHookList.MountRiding,isRiding);
               return true;
            case msg is MountEquipedErrorMessage:
               meemsg = MountEquipedErrorMessage(msg);
               switch(meemsg.errorType)
               {
                  case MountEquipedErrorEnum.UNSET:
                     typeError = "UNSET";
                     break;
                  case MountEquipedErrorEnum.SET:
                     typeError = "SET";
                     break;
                  case MountEquipedErrorEnum.RIDING:
                     typeError = "RIDING";
                     KernelEventsManager.getInstance().processCallback(MountHookList.MountRiding,false);
               }
               KernelEventsManager.getInstance().processCallback(MountHookList.MountEquipedError,typeError);
               return true;
            case msg is ExchangeWeightMessage:
               ewmsg = msg as ExchangeWeightMessage;
               this._inventoryWeight = ewmsg.currentWeight;
               this._inventoryMaxWeight = ewmsg.maxWeight;
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeWeight,ewmsg.currentWeight,ewmsg.maxWeight);
               return true;
            case msg is ExchangeStartOkMountMessage:
               esokmmsg = msg as ExchangeStartOkMountMessage;
               TooltipManager.hideAll();
               this.initializeMountLists(esokmmsg.stabledMountsDescription,esokmmsg.paddockedMountsDescription);
               Kernel.getWorker().addFrame(this._mountDialogFrame);
               return true;
            case msg is MountSetMessage:
               if(PlayedCharacterManager.getInstance().mount)
               {
                  autopilotBehaviorId = 10;
                  behaviors = MountSetMessage(msg).mountData.behaviors;
                  mountIsNowAutoTripable = false;
                  mountWasNotAutoTripable = true;
                  if(behaviors.length && behaviors.indexOf(autopilotBehaviorId) != -1)
                  {
                     mountIsNowAutoTripable = true;
                  }
                  if(PlayedCharacterManager.getInstance().mount.ability.length)
                  {
                     for each(ability in PlayedCharacterManager.getInstance().mount.ability)
                     {
                        if(ability.id == autopilotBehaviorId)
                        {
                           mountWasNotAutoTripable = false;
                        }
                     }
                  }
                  if(mountWasNotAutoTripable && mountIsNowAutoTripable)
                  {
                     autopilotMessage = I18n.getUiText("ui.mountTrip.autopilotActivated",[MountSetMessage(msg).mountData.name]);
                     commonMod = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
                     commonMod.openPopup(I18n.getUiText("ui.common.congratulation"),autopilotMessage,[I18n.getUiText("ui.common.ok")]);
                  }
               }
               PlayedCharacterManager.getInstance().mount = MountData.makeMountData(MountSetMessage(msg).mountData,false,this.mountXpRatio);
               KernelEventsManager.getInstance().processCallback(MountHookList.MountSet);
               return false;
            case msg is MountUnSetMessage:
               PlayedCharacterManager.getInstance().mount = null;
               KernelEventsManager.getInstance().processCallback(MountHookList.MountUnSet);
               return true;
            case msg is ExchangeStartOkMountWithOutPaddockMessage:
               esomwopmsg = msg as ExchangeStartOkMountWithOutPaddockMessage;
               this.initializeMountLists(esomwopmsg.stabledMountsDescription,null);
               Kernel.getWorker().addFrame(this._mountDialogFrame);
               return true;
            case msg is UpdateMountCharacteristicsMessage:
               umbmsg = msg as UpdateMountCharacteristicsMessage;
               isInPaddock = true;
               mountToUpdate = null;
               for each(m in this._paddockList)
               {
                  if(m.id == umbmsg.rideId)
                  {
                     mountToUpdate = m;
                     break;
                  }
               }
               if(!mountToUpdate)
               {
                  for each(m in this._stableList)
                  {
                     if(m.id == umbmsg.rideId)
                     {
                        mountToUpdate = m;
                        isInPaddock = false;
                        break;
                     }
                  }
               }
               if(!mountToUpdate)
               {
                  _log.error("Can\'t find " + umbmsg.rideId + " ride ID for update mount boost");
                  return true;
               }
               for each(boost in umbmsg.boostToUpdateList)
               {
                  if(boost is UpdateMountIntegerCharacteristic)
                  {
                     intBoost = boost as UpdateMountIntegerCharacteristic;
                     switch(intBoost.type)
                     {
                        case MountCharacteristicEnum.ENERGY:
                           mountToUpdate.energy = intBoost.value;
                           continue;
                        case MountCharacteristicEnum.LOVE:
                           mountToUpdate.love = intBoost.value;
                           continue;
                        case MountCharacteristicEnum.MATURITY:
                           mountToUpdate.maturity = intBoost.value;
                           continue;
                        case MountCharacteristicEnum.SERENITY:
                           mountToUpdate.serenity = intBoost.value;
                           continue;
                        case MountCharacteristicEnum.STAMINA:
                           mountToUpdate.stamina = intBoost.value;
                           continue;
                        case MountCharacteristicEnum.TIREDNESS:
                           mountToUpdate.boostLimiter = intBoost.value;
                           continue;
                        case MountCharacteristicEnum.CARRIER:
                           mountToUpdate.isRideable = intBoost.value;
                           continue;
                        case MountCharacteristicEnum.PREGNANT:
                           if(intBoost.value == 0)
                           {
                              mountToUpdate.fecondationTime = intBoost.value;
                           }
                           continue;
                        case MountCharacteristicEnum.FERTILE:
                           mountToUpdate.isFecondationReady = intBoost.value;
                     }
                  }
               }
               if(isInPaddock)
               {
                  KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate,null,this._paddockList,null);
               }
               else
               {
                  KernelEventsManager.getInstance().processCallback(MountHookList.MountStableUpdate,this._stableList,null,null);
               }
               return true;
               break;
            case msg is MountEmoteIconUsedOkMessage:
               meiuomsg = msg as MountEmoteIconUsedOkMessage;
               mountSprite = DofusEntities.getEntity(meiuomsg.mountId) as TiphonSprite;
               if(mountSprite)
               {
                  animationName = null;
                  switch(meiuomsg.reactionType)
                  {
                     case 1:
                        animationName = "AnimEmoteRest_Statique";
                        break;
                     case 2:
                        animationName = "AnimAttaque0";
                        break;
                     case 3:
                        animationName = "AnimEmoteCaresse";
                        break;
                     case 4:
                        animationName = "AnimEmoteReproductionF";
                        break;
                     case 5:
                        animationName = "AnimEmoteReproductionM";
                  }
                  if(animationName)
                  {
                     seq = new SerialSequencer();
                     seq.addStep(new PlayAnimationStep(mountSprite,animationName,false));
                     seq.addStep(new SetAnimationStep(mountSprite,AnimationEnum.ANIM_STATIQUE));
                     seq.start();
                  }
               }
               return true;
            case msg is ExchangeMountsTakenFromPaddockMessage:
               emtfpmsg = msg as ExchangeMountsTakenFromPaddockMessage;
               takenMessage = I18n.getUiText("ui.mount.takenFromPaddock",[emtfpmsg.name,"[" + emtfpmsg.worldX + "," + emtfpmsg.worldY + "]",emtfpmsg.ownername]);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,takenMessage,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is MountReleasedMessage:
               mremsg = msg as MountReleasedMessage;
               KernelEventsManager.getInstance().processCallback(MountHookList.MountReleased,mremsg.mountId);
               return true;
            case msg is MountHarnessDissociateRequestAction:
               mhdra = msg as MountHarnessDissociateRequestAction;
               mhdrmsg = new MountHarnessDissociateRequestMessage();
               mhdrmsg.initMountHarnessDissociateRequestMessage();
               ConnectionsHandler.getConnection().send(mhdrmsg);
               return true;
            case msg is MountHarnessColorsUpdateRequestAction:
               mhcura = msg as MountHarnessColorsUpdateRequestAction;
               mhcurmsg = new MountHarnessColorsUpdateRequestMessage();
               mhcurmsg.initMountHarnessColorsUpdateRequestMessage(mhcura.useHarnessColors);
               ConnectionsHandler.getConnection().send(mhcurmsg);
               return true;
            default:
               return false;
         }
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
      
      public function get inventoryWeight() : uint
      {
         return this._inventoryWeight;
      }
      
      public function get inventoryMaxWeight() : uint
      {
         return this._inventoryMaxWeight;
      }
   }
}
