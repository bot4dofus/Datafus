package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
   import com.ankamagames.dofus.datacenter.npcs.Npc;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.TradeStockItemWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
   import com.ankamagames.dofus.logic.game.common.actions.LeaveDialogAction;
   import com.ankamagames.dofus.logic.game.common.actions.StartGuildChestContributionAction;
   import com.ankamagames.dofus.logic.game.common.actions.StopGuildChestContributionAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveKamaAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveToTabAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertAllFromInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertAllToInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertExistingFromInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertExistingToInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertListFromInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertListToInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertListWithQuantityToInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.GuildSelectChestTabRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildGetChestTabContributionsRequestAction;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayMovementFrame;
   import com.ankamagames.dofus.logic.game.roleplay.managers.MountAutoTripManager;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.DialogTypeEnum;
   import com.ankamagames.dofus.network.enums.ExchangeTypeEnum;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildChestTabContributionMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildChestTabContributionsMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildGetChestTabContributionsRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.GuildSelectChestTabRequestMessage;
   import com.ankamagames.dofus.network.messages.game.guild.StartGuildChestContributionMessage;
   import com.ankamagames.dofus.network.messages.game.guild.StopGuildChestContributionMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeLeaveMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMoveKamaMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectMoveToTabMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectTransfertAllFromInvMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectTransfertAllToInvMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectTransfertExistingFromInvMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectTransfertExistingToInvMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectTransfertListFromInvMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectTransfertListToInvMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeObjectTransfertListWithQuantityToInvMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeRequestedTradeMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkNpcShopMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkNpcTradeMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkRecycleTradeMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartOkRunesTradeMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedTaxCollectorShopMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedWithMultiTabStorageMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedWithPodsMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeStartedWithStorageMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.RecycleResultMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.storage.StorageInventoryContentMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.storage.StorageObjectRemoveMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.storage.StorageObjectUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.storage.StorageObjectsRemoveMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.storage.StorageObjectsUpdateMessage;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNamedActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemToSellInNpcShop;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.utils.getQualifiedClassName;
   
   public class ExchangeManagementFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ExchangeManagementFrame));
       
      
      private var _priority:int = 0;
      
      private var _sourceInformations:GameRolePlayNamedActorInformations;
      
      private var _targetInformations:GameRolePlayNamedActorInformations;
      
      private var _meReady:Boolean = false;
      
      private var _youReady:Boolean = false;
      
      private var _exchangeInventory:Array;
      
      private var _success:Boolean;
      
      public function ExchangeManagementFrame()
      {
         super();
      }
      
      public function get priority() : int
      {
         return this._priority;
      }
      
      public function set priority(p:int) : void
      {
         this._priority = p;
      }
      
      private function get roleplayContextFrame() : RoleplayContextFrame
      {
         return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
      }
      
      private function get roleplayEntitiesFrame() : RoleplayEntitiesFrame
      {
         return Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
      }
      
      private function get roleplayMovementFrame() : RoleplayMovementFrame
      {
         return Kernel.getWorker().getFrame(RoleplayMovementFrame) as RoleplayMovementFrame;
      }
      
      public function initBankStock(objectsInfos:Vector.<ObjectItem>) : void
      {
         InventoryManager.getInstance().bankInventory.initializeFromObjectItems(objectsInfos);
         InventoryManager.getInstance().bankInventory.releaseHooks();
      }
      
      public function processExchangeRequestedTradeMessage(msg:ExchangeRequestedTradeMessage) : void
      {
         var socialFrame:SocialFrame = null;
         var lda:LeaveDialogAction = null;
         if(msg.exchangeType != ExchangeTypeEnum.PLAYER_TRADE)
         {
            return;
         }
         this._sourceInformations = this.roleplayEntitiesFrame.getEntityInfos(msg.source) as GameRolePlayNamedActorInformations;
         this._targetInformations = this.roleplayEntitiesFrame.getEntityInfos(msg.target) as GameRolePlayNamedActorInformations;
         var sourceName:String = this._sourceInformations.name;
         var targetName:String = this._targetInformations.name;
         if(msg.source == PlayedCharacterManager.getInstance().id)
         {
            this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeRequestCharacterFromMe,sourceName,targetName);
         }
         else
         {
            socialFrame = Kernel.getWorker().getFrame(SocialFrame) as SocialFrame;
            if(socialFrame && socialFrame.isIgnored(sourceName) || MountAutoTripManager.getInstance().isTravelling)
            {
               lda = new LeaveDialogAction();
               Kernel.getWorker().process(lda);
               return;
            }
            this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeRequestCharacterToMe,targetName,sourceName);
         }
      }
      
      public function processExchangeStartOkNpcTradeMessage(msg:ExchangeStartOkNpcTradeMessage) : void
      {
         var sourceName:String = PlayedCharacterManager.getInstance().infos.name;
         var NPCId:int = this.roleplayEntitiesFrame.getEntityInfos(msg.npcId).contextualId;
         var NPC:Npc = Npc.getNpcById(NPCId);
         var targetName:String = Npc.getNpcById((this.roleplayEntitiesFrame.getEntityInfos(msg.npcId) as GameRolePlayNpcInformations).npcId).name;
         var sourceLook:TiphonEntityLook = EntityLookAdapter.getRiderLook(PlayedCharacterManager.getInstance().infos.entityLook);
         var targetLook:TiphonEntityLook = EntityLookAdapter.getRiderLook(this.roleplayContextFrame.entitiesFrame.getEntityInfos(msg.npcId).look);
         var esonmsg:ExchangeStartOkNpcTradeMessage = msg as ExchangeStartOkNpcTradeMessage;
         PlayedCharacterManager.getInstance().isInExchange = true;
         this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartOkNpcTrade,esonmsg.npcId,sourceName,targetName,sourceLook,targetLook);
         this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedType,ExchangeTypeEnum.NPC_TRADE);
      }
      
      public function processExchangeStartOkRunesTradeMessage(msg:ExchangeStartOkRunesTradeMessage) : void
      {
         var esortmsg:ExchangeStartOkRunesTradeMessage = msg as ExchangeStartOkRunesTradeMessage;
         PlayedCharacterManager.getInstance().isInExchange = true;
         this._kernelEventsManager.processCallback(CraftHookList.ExchangeStartOkRunesTrade);
         this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedType,ExchangeTypeEnum.RUNES_TRADE);
      }
      
      public function processExchangeStartOkRecycleTradeMessage(msg:ExchangeStartOkRecycleTradeMessage) : void
      {
         var esorctmsg:ExchangeStartOkRecycleTradeMessage = msg as ExchangeStartOkRecycleTradeMessage;
         PlayedCharacterManager.getInstance().isInExchange = true;
         this._kernelEventsManager.processCallback(CraftHookList.ExchangeStartOkRecycleTrade,esorctmsg.percentToPlayer,esorctmsg.percentToPrism);
         this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedType,ExchangeTypeEnum.RECYCLE_TRADE);
      }
      
      public function process(msg:Message) : Boolean
      {
         var i:int = 0;
         var inventorySize:int = 0;
         var exwsmsg:ExchangeStartedWithStorageMessage = null;
         var commonExchangeFrame:CommonExchangeManagementFrame = null;
         var pods:int = 0;
         var eswmtsm:ExchangeStartedWithMultiTabStorageMessage = null;
         var commonExchangeManagementFrame:CommonExchangeManagementFrame = null;
         var esmsg:ExchangeStartedMessage = null;
         var commonExchangeFrame2:CommonExchangeManagementFrame = null;
         var estcsm:ExchangeStartedTaxCollectorShopMessage = null;
         var sicmsg:StorageInventoryContentMessage = null;
         var soumsg:StorageObjectUpdateMessage = null;
         var object:ObjectItem = null;
         var itemChanged:ItemWrapper = null;
         var sormsg:StorageObjectRemoveMessage = null;
         var sosumsg:StorageObjectsUpdateMessage = null;
         var sosrmsg:StorageObjectsRemoveMessage = null;
         var eomka:ExchangeObjectMoveKamaAction = null;
         var eomkmsg:ExchangeObjectMoveKamaMessage = null;
         var eotatia:ExchangeObjectTransfertAllToInvAction = null;
         var eotatimsg:ExchangeObjectTransfertAllToInvMessage = null;
         var eotltia:ExchangeObjectTransfertListToInvAction = null;
         var eotlwqtoia:ExchangeObjectTransfertListWithQuantityToInvAction = null;
         var eotetia:ExchangeObjectTransfertExistingToInvAction = null;
         var eotetimsg:ExchangeObjectTransfertExistingToInvMessage = null;
         var eotafia:ExchangeObjectTransfertAllFromInvAction = null;
         var eotafimsg:ExchangeObjectTransfertAllFromInvMessage = null;
         var eotlfia:ExchangeObjectTransfertListFromInvAction = null;
         var eotefia:ExchangeObjectTransfertExistingFromInvAction = null;
         var eotefimsg:ExchangeObjectTransfertExistingFromInvMessage = null;
         var esonmsg:ExchangeStartOkNpcShopMessage = null;
         var merchant:GameContextActorInformations = null;
         var merchantLook:TiphonEntityLook = null;
         var NPCShopItems:Array = null;
         var esortmsg:ExchangeStartOkRunesTradeMessage = null;
         var esorctmsg:ExchangeStartOkRecycleTradeMessage = null;
         var rrmsg:RecycleResultMessage = null;
         var elm:ExchangeLeaveMessage = null;
         var gcctra:GuildSelectChestTabRequestAction = null;
         var gcctrm:GuildSelectChestTabRequestMessage = null;
         var sgccm:StartGuildChestContributionMessage = null;
         var spgccm:StopGuildChestContributionMessage = null;
         var gctcm:GuildChestTabContributionMessage = null;
         var ggctcrm:GuildGetChestTabContributionsRequestMessage = null;
         var gctcsm:GuildChestTabContributionsMessage = null;
         var eomtta:ExchangeObjectMoveToTabAction = null;
         var eomttm:ExchangeObjectMoveToTabMessage = null;
         var sourceName:String = null;
         var targetName:String = null;
         var sourceLook:TiphonEntityLook = null;
         var targetLook:TiphonEntityLook = null;
         var eswpmsg:ExchangeStartedWithPodsMessage = null;
         var sourceCurrentPods:int = 0;
         var targetCurrentPods:int = 0;
         var sourceMaxPods:int = 0;
         var targetMaxPods:int = 0;
         var exchangeOtherCharacterId:Number = NaN;
         var sosuit:ObjectItem = null;
         var sosuobj:ObjectItem = null;
         var sosuic:ItemWrapper = null;
         var sosruid:uint = 0;
         var eotltimsg:ExchangeObjectTransfertListToInvMessage = null;
         var eotlwqtoimsg:ExchangeObjectTransfertListWithQuantityToInvMessage = null;
         var eotlfimsg:ExchangeObjectTransfertListFromInvMessage = null;
         var oitsins:ObjectItemToSellInNpcShop = null;
         var itemwra:ItemWrapper = null;
         var stockItem:TradeStockItemWrapper = null;
         switch(true)
         {
            case msg is ExchangeStartedWithStorageMessage:
               exwsmsg = msg as ExchangeStartedWithStorageMessage;
               PlayedCharacterManager.getInstance().isInExchange = true;
               commonExchangeFrame = Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame;
               if(commonExchangeFrame)
               {
                  commonExchangeFrame.resetEchangeSequence();
               }
               pods = exwsmsg.storageMaxSlot;
               this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeBankStartedWithStorage,exwsmsg.exchangeType,pods);
               return false;
            case msg is ExchangeStartedWithMultiTabStorageMessage:
               eswmtsm = msg as ExchangeStartedWithMultiTabStorageMessage;
               PlayedCharacterManager.getInstance().isInExchange = true;
               commonExchangeManagementFrame = Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame;
               if(commonExchangeManagementFrame)
               {
                  commonExchangeManagementFrame.resetEchangeSequence();
               }
               this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeBankStartedWithMultiTabStorage,eswmtsm.exchangeType,eswmtsm.storageMaxSlot,eswmtsm.tabNumber);
               return false;
            case msg is ExchangeStartedMessage:
               esmsg = msg as ExchangeStartedMessage;
               PlayedCharacterManager.getInstance().isInExchange = true;
               commonExchangeFrame2 = Kernel.getWorker().getFrame(CommonExchangeManagementFrame) as CommonExchangeManagementFrame;
               if(commonExchangeFrame2)
               {
                  commonExchangeFrame2.resetEchangeSequence();
               }
               switch(esmsg.exchangeType)
               {
                  case ExchangeTypeEnum.PLAYER_TRADE:
                     sourceName = this._sourceInformations.name;
                     targetName = this._targetInformations.name;
                     sourceLook = EntityLookAdapter.getRiderLook(this._sourceInformations.look);
                     targetLook = EntityLookAdapter.getRiderLook(this._targetInformations.look);
                     if(esmsg.getMessageId() == ExchangeStartedWithPodsMessage.protocolId)
                     {
                        eswpmsg = msg as ExchangeStartedWithPodsMessage;
                     }
                     sourceCurrentPods = -1;
                     targetCurrentPods = -1;
                     sourceMaxPods = -1;
                     targetMaxPods = -1;
                     if(eswpmsg != null)
                     {
                        if(eswpmsg.firstCharacterId == this._sourceInformations.contextualId)
                        {
                           sourceCurrentPods = eswpmsg.firstCharacterCurrentWeight;
                           targetCurrentPods = eswpmsg.secondCharacterCurrentWeight;
                           sourceMaxPods = eswpmsg.firstCharacterMaxWeight;
                           targetMaxPods = eswpmsg.secondCharacterMaxWeight;
                        }
                        else
                        {
                           targetCurrentPods = eswpmsg.firstCharacterCurrentWeight;
                           sourceCurrentPods = eswpmsg.secondCharacterCurrentWeight;
                           targetMaxPods = eswpmsg.firstCharacterMaxWeight;
                           sourceMaxPods = eswpmsg.secondCharacterMaxWeight;
                        }
                     }
                     if(PlayedCharacterManager.getInstance().id == eswpmsg.firstCharacterId)
                     {
                        exchangeOtherCharacterId = eswpmsg.secondCharacterId;
                     }
                     else
                     {
                        exchangeOtherCharacterId = eswpmsg.firstCharacterId;
                     }
                     this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStarted,sourceName,targetName,sourceLook,targetLook,sourceCurrentPods,targetCurrentPods,sourceMaxPods,targetMaxPods,exchangeOtherCharacterId);
                     this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedType,esmsg.exchangeType);
                     return true;
                  case ExchangeTypeEnum.STORAGE:
                     this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartedType,esmsg.exchangeType);
                     return true;
                  default:
                     return true;
               }
               break;
            case msg is ExchangeStartedTaxCollectorShopMessage:
               estcsm = msg as ExchangeStartedTaxCollectorShopMessage;
               PlayedCharacterManager.getInstance().isInExchange = true;
               InventoryManager.getInstance().bankInventory.kamas = estcsm.kamas;
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeBankStarted,ExchangeTypeEnum.MOUNT,estcsm.objects,estcsm.kamas);
               return true;
            case msg is StorageInventoryContentMessage:
               sicmsg = msg as StorageInventoryContentMessage;
               InventoryManager.getInstance().bankInventory.kamas = sicmsg.kamas;
               InventoryManager.getInstance().bankInventory.initializeFromObjectItems(sicmsg.objects);
               InventoryManager.getInstance().bankInventory.releaseHooks();
               return true;
            case msg is StorageObjectUpdateMessage:
               soumsg = msg as StorageObjectUpdateMessage;
               object = soumsg.object;
               itemChanged = ItemWrapper.create(object.position,object.objectUID,object.objectGID,object.quantity,object.effects);
               InventoryManager.getInstance().bankInventory.modifyItem(itemChanged);
               InventoryManager.getInstance().bankInventory.releaseHooks();
               return true;
            case msg is StorageObjectRemoveMessage:
               sormsg = msg as StorageObjectRemoveMessage;
               InventoryManager.getInstance().bankInventory.removeItem(sormsg.objectUID);
               InventoryManager.getInstance().bankInventory.releaseHooks();
               return true;
            case msg is StorageObjectsUpdateMessage:
               sosumsg = msg as StorageObjectsUpdateMessage;
               for each(sosuit in sosumsg.objectList)
               {
                  sosuobj = sosuit;
                  sosuic = ItemWrapper.create(sosuobj.position,sosuobj.objectUID,sosuobj.objectGID,sosuobj.quantity,sosuobj.effects);
                  InventoryManager.getInstance().bankInventory.modifyItem(sosuic);
               }
               InventoryManager.getInstance().bankInventory.releaseHooks();
               return true;
            case msg is StorageObjectsRemoveMessage:
               sosrmsg = msg as StorageObjectsRemoveMessage;
               for each(sosruid in sosrmsg.objectUIDList)
               {
                  InventoryManager.getInstance().bankInventory.removeItem(sosruid);
               }
               InventoryManager.getInstance().bankInventory.releaseHooks();
               return true;
            case msg is ExchangeObjectMoveKamaAction:
               eomka = msg as ExchangeObjectMoveKamaAction;
               eomkmsg = new ExchangeObjectMoveKamaMessage();
               eomkmsg.initExchangeObjectMoveKamaMessage(eomka.kamas);
               ConnectionsHandler.getConnection().send(eomkmsg);
               return true;
            case msg is ExchangeObjectTransfertAllToInvAction:
               eotatia = msg as ExchangeObjectTransfertAllToInvAction;
               eotatimsg = new ExchangeObjectTransfertAllToInvMessage();
               eotatimsg.initExchangeObjectTransfertAllToInvMessage();
               ConnectionsHandler.getConnection().send(eotatimsg);
               return true;
            case msg is ExchangeObjectTransfertListToInvAction:
               eotltia = msg as ExchangeObjectTransfertListToInvAction;
               if(eotltia.ids.length > ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.exchange.partialTransfert"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               if(eotltia.ids.length >= ProtocolConstantsEnum.MIN_OBJ_COUNT_BY_XFERT)
               {
                  eotltimsg = new ExchangeObjectTransfertListToInvMessage();
                  eotltimsg.initExchangeObjectTransfertListToInvMessage(eotltia.ids.slice(0,ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT));
                  ConnectionsHandler.getConnection().send(eotltimsg);
               }
               return true;
            case msg is ExchangeObjectTransfertListWithQuantityToInvAction:
               eotlwqtoia = msg as ExchangeObjectTransfertListWithQuantityToInvAction;
               if(eotlwqtoia.ids.length > ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT / 2)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.exchange.partialTransfert"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               if(eotlwqtoia.ids.length >= ProtocolConstantsEnum.MIN_OBJ_COUNT_BY_XFERT && eotlwqtoia.ids.length == eotlwqtoia.qtys.length)
               {
                  eotlwqtoimsg = new ExchangeObjectTransfertListWithQuantityToInvMessage();
                  eotlwqtoimsg.initExchangeObjectTransfertListWithQuantityToInvMessage(eotlwqtoia.ids.slice(0,ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT / 2),eotlwqtoia.qtys.slice(0,ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT / 2));
                  ConnectionsHandler.getConnection().send(eotlwqtoimsg);
               }
               return true;
            case msg is ExchangeObjectTransfertExistingToInvAction:
               eotetia = msg as ExchangeObjectTransfertExistingToInvAction;
               eotetimsg = new ExchangeObjectTransfertExistingToInvMessage();
               eotetimsg.initExchangeObjectTransfertExistingToInvMessage();
               ConnectionsHandler.getConnection().send(eotetimsg);
               return true;
            case msg is ExchangeObjectTransfertAllFromInvAction:
               eotafia = msg as ExchangeObjectTransfertAllFromInvAction;
               eotafimsg = new ExchangeObjectTransfertAllFromInvMessage();
               eotafimsg.initExchangeObjectTransfertAllFromInvMessage();
               ConnectionsHandler.getConnection().send(eotafimsg);
               return true;
            case msg is ExchangeObjectTransfertListFromInvAction:
               eotlfia = msg as ExchangeObjectTransfertListFromInvAction;
               if(eotlfia.ids.length > ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.exchange.partialTransfert"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               if(eotlfia.ids.length >= ProtocolConstantsEnum.MIN_OBJ_COUNT_BY_XFERT)
               {
                  eotlfimsg = new ExchangeObjectTransfertListFromInvMessage();
                  eotlfimsg.initExchangeObjectTransfertListFromInvMessage(eotlfia.ids.slice(0,ProtocolConstantsEnum.MAX_OBJ_COUNT_BY_XFERT));
                  ConnectionsHandler.getConnection().send(eotlfimsg);
               }
               return true;
            case msg is ExchangeObjectTransfertExistingFromInvAction:
               eotefia = msg as ExchangeObjectTransfertExistingFromInvAction;
               eotefimsg = new ExchangeObjectTransfertExistingFromInvMessage();
               eotefimsg.initExchangeObjectTransfertExistingFromInvMessage();
               ConnectionsHandler.getConnection().send(eotefimsg);
               return true;
            case msg is ExchangeStartOkNpcShopMessage:
               esonmsg = msg as ExchangeStartOkNpcShopMessage;
               PlayedCharacterManager.getInstance().isInExchange = true;
               Kernel.getWorker().process(ChangeWorldInteractionAction.create(false,true));
               merchant = this.roleplayContextFrame.entitiesFrame.getEntityInfos(esonmsg.npcSellerId);
               merchantLook = EntityLookAdapter.getRiderLook(merchant.look);
               NPCShopItems = new Array();
               for each(oitsins in esonmsg.objectsInfos)
               {
                  itemwra = ItemWrapper.create(63,0,oitsins.objectGID,0,oitsins.effects,false);
                  stockItem = TradeStockItemWrapper.create(itemwra,oitsins.objectPrice,new GroupItemCriterion(oitsins.buyCriterion));
                  NPCShopItems.push(stockItem);
               }
               this._kernelEventsManager.processCallback(ExchangeHookList.ExchangeStartOkNpcShop,esonmsg.npcSellerId,NPCShopItems,merchantLook,esonmsg.tokenId);
               return true;
            case msg is ExchangeStartOkRunesTradeMessage:
               esortmsg = msg as ExchangeStartOkRunesTradeMessage;
               PlayedCharacterManager.getInstance().isInExchange = true;
               KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkRunesTrade);
               return true;
            case msg is ExchangeStartOkRecycleTradeMessage:
               esorctmsg = msg as ExchangeStartOkRecycleTradeMessage;
               PlayedCharacterManager.getInstance().isInExchange = true;
               KernelEventsManager.getInstance().processCallback(CraftHookList.ExchangeStartOkRecycleTrade,esorctmsg.percentToPlayer,esorctmsg.percentToPrism);
               return true;
            case msg is RecycleResultMessage:
               rrmsg = msg as RecycleResultMessage;
               KernelEventsManager.getInstance().processCallback(CraftHookList.RecycleResult,rrmsg.nuggetsForPlayer,rrmsg.nuggetsForPrism);
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.recycle.resultDetailed",[rrmsg.nuggetsForPlayer,rrmsg.nuggetsForPrism,"{item," + DataEnum.ITEM_GID_NUGGET + "}"]),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               return true;
            case msg is LeaveDialogRequestAction:
               ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
               return true;
            case msg is ExchangeLeaveMessage:
               elm = msg as ExchangeLeaveMessage;
               if(elm.dialogType == DialogTypeEnum.DIALOG_EXCHANGE)
               {
                  PlayedCharacterManager.getInstance().isInExchange = false;
                  this._success = elm.success;
                  Kernel.getWorker().removeFrame(this);
               }
               return true;
            case msg is GuildSelectChestTabRequestAction:
               gcctra = msg as GuildSelectChestTabRequestAction;
               gcctrm = new GuildSelectChestTabRequestMessage();
               gcctrm.initGuildSelectChestTabRequestMessage(gcctra.tabNumber);
               ConnectionsHandler.getConnection().send(gcctrm);
               return true;
            case msg is StartGuildChestContributionAction:
               sgccm = new StartGuildChestContributionMessage();
               sgccm.initStartGuildChestContributionMessage();
               ConnectionsHandler.getConnection().send(sgccm);
               return true;
            case msg is StopGuildChestContributionAction:
               spgccm = new StopGuildChestContributionMessage();
               spgccm.initStopGuildChestContributionMessage();
               ConnectionsHandler.getConnection().send(spgccm);
               return true;
            case msg is GuildChestTabContributionMessage:
               gctcm = msg as GuildChestTabContributionMessage;
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.GuildChestTabContribution,gctcm.tabNumber,gctcm.requiredAmount,gctcm.currentAmount,gctcm.chestContributionEnrollmentDelay,gctcm.chestContributionDelay);
               return true;
            case msg is GuildGetChestTabContributionsRequestAction:
               ggctcrm = new GuildGetChestTabContributionsRequestMessage();
               ggctcrm.initGuildGetChestTabContributionsRequestMessage();
               ConnectionsHandler.getConnection().send(ggctcrm);
               return true;
            case msg is GuildChestTabContributionsMessage:
               gctcsm = msg as GuildChestTabContributionsMessage;
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.GuildChestContributions,gctcsm.contributions);
               return true;
            case msg is ExchangeObjectMoveToTabAction:
               eomtta = msg as ExchangeObjectMoveToTabAction;
               eomttm = new ExchangeObjectMoveToTabMessage();
               eomttm.initExchangeObjectMoveToTabMessage(eomtta.objectUID,eomtta.quantity,eomtta.tabNumber);
               ConnectionsHandler.getConnection().send(eomttm);
               return true;
            default:
               return false;
         }
      }
      
      private function proceedExchange() : void
      {
      }
      
      public function pushed() : Boolean
      {
         this._success = false;
         return true;
      }
      
      public function pulled() : Boolean
      {
         if(Kernel.getWorker().contains(CommonExchangeManagementFrame))
         {
            Kernel.getWorker().removeFrame(Kernel.getWorker().getFrame(CommonExchangeManagementFrame));
         }
         KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeLeave,this._success);
         this._exchangeInventory = null;
         return true;
      }
      
      private function get _kernelEventsManager() : KernelEventsManager
      {
         return KernelEventsManager.getInstance();
      }
   }
}
