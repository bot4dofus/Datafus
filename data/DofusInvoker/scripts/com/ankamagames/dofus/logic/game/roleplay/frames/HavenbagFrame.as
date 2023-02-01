package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankama.haapi.client.api.KardApi;
   import com.ankama.haapi.client.model.KardKard;
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.atouin.managers.HavenbagFurnituresManager;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.atouin.types.IFurniture;
   import com.ankamagames.atouin.types.miscs.HavenbagPackedInfos;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagClearAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagEditModeAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagExitAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagFurnitureSelectedAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagPermissionsUpdateRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagResetAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagRoomSelectedAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagSaveAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagThemeSelectedAction;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.utils.GameID;
   import com.ankamagames.dofus.misc.utils.HaapiKeyManager;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.HavenBagDailyLoteryErrorEnum;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.ChangeHavenBagRoomRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.ChangeThemeRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.CloseHavenBagFurnitureSequenceRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.EditHavenBagCancelRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.EditHavenBagFinishedMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.EditHavenBagRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.EditHavenBagStartMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.ExitHavenBagRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.HavenBagDailyLoteryMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.HavenBagFurnituresMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.HavenBagFurnituresRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.OpenHavenBagFurnitureSequenceRequestMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.meeting.HavenBagPermissionsUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.meeting.HavenBagPermissionsUpdateRequestMessage;
   import com.ankamagames.dofus.network.messages.game.dialog.LeaveDialogRequestMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.ExchangeWeightMessage;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalInformations;
   import com.ankamagames.dofus.types.entities.HavenbagFurnitureSprite;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.handlers.HumanInputHandler;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOutMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseOverMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightClickOutsideMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseRightUpMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.CustomSharedObject;
   import com.ankamagames.jerakine.types.enums.Priority;
   import flash.ui.Keyboard;
   import flash.utils.getQualifiedClassName;
   import org.openapitools.common.ApiUserCredentials;
   import org.openapitools.event.ApiClientEvent;
   
   public class HavenbagFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HavenbagFrame));
      
      private static var _furnituresInEdit;
       
      
      private var _furnitureDragFrame:HavenbagFurnitureDragFrame;
      
      private var _isInEditMode:Boolean;
      
      private var _rightMouseIsDown:Boolean;
      
      private var _furnituresBeforeEdit:HavenbagPackedInfos;
      
      private var _currentRoomId:uint;
      
      private var _currentRoomThemeId:int;
      
      private var _ownerInfos:CharacterMinimalInformations;
      
      private var _previewCacheKey:String;
      
      private var _lotteryApi:KardApi;
      
      private var _furnituresDisplayed:uint = 0;
      
      private var _totalFurnituresToBeDisplayed:uint = 0;
      
      private var _sharePermissions:uint;
      
      public function HavenbagFrame(currentRoomId:uint, currentRoomThemeId:int, ownerInfos:CharacterMinimalInformations)
      {
         var so:CustomSharedObject = null;
         super();
         this._currentRoomId = currentRoomId;
         this._currentRoomThemeId = currentRoomThemeId;
         this._ownerInfos = ownerInfos;
         if(!_furnituresInEdit)
         {
            so = CustomSharedObject.getLocal("havenbag");
            if(so && so.data)
            {
               _furnituresInEdit = so.data;
            }
         }
      }
      
      public function get sharePermissions() : uint
      {
         return this._sharePermissions;
      }
      
      public function pushed() : Boolean
      {
         KernelEventsManager.getInstance().processCallback(HookList.HavenbagDisplayUi,true,this._currentRoomId,PlayedCharacterManager.getInstance().currentHavenbagRooms,this._currentRoomThemeId,PlayerManager.getInstance().havenbagAvailableThemes,this._ownerInfos);
         this._previewCacheKey = PlayerManager.getInstance().server.id + "-" + PlayerManager.getInstance().accountId + "-" + this._currentRoomId + "-" + this._currentRoomThemeId;
         this._isInEditMode = false;
         this._rightMouseIsDown = false;
         PlayedCharacterManager.getInstance().isInHisHavenbag = this._ownerInfos.id == PlayedCharacterManager.getInstance().id;
         return true;
      }
      
      public function pulled() : Boolean
      {
         KernelEventsManager.getInstance().processCallback(HookList.HavenbagDisplayUi,false,0,null,0,null,null);
         if(this._isInEditMode)
         {
            this.exitEditMode();
         }
         PlayedCharacterManager.getInstance().isInHavenbag = false;
         PlayedCharacterManager.getInstance().isInHisHavenbag = false;
         if(Berilia.getInstance().getUi("zaapSelection"))
         {
            ConnectionsHandler.getConnection().send(new LeaveDialogRequestMessage());
         }
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var furniture:HavenbagFurnitureSprite = null;
         var hema:HavenbagEditModeAction = null;
         var hbfmsg:HavenBagFurnituresMessage = null;
         var furnitureSprites:Array = null;
         var packedFurnitures:HavenbagPackedInfos = null;
         var ohbfsrmsg:OpenHavenBagFurnitureSequenceRequestMessage = null;
         var chbfsrmsg:CloseHavenBagFurnitureSequenceRequestMessage = null;
         var hfsa:HavenbagFurnitureSelectedAction = null;
         var mcmsg:MouseClickMessage = null;
         var clickedFurniture:IFurniture = null;
         var mrumsg:MouseRightUpMessage = null;
         var momsg:MouseOverMessage = null;
         var htsa:HavenbagThemeSelectedAction = null;
         var ctrmsg:ChangeThemeRequestMessage = null;
         var hrsa:HavenbagRoomSelectedAction = null;
         var chbrrmsg:ChangeHavenBagRoomRequestMessage = null;
         var hbpumsg:HavenBagPermissionsUpdateMessage = null;
         var hpura:HavenbagPermissionsUpdateRequestAction = null;
         var hbpurmsg:HavenBagPermissionsUpdateRequestMessage = null;
         var exithbrmsg:ExitHavenBagRequestMessage = null;
         var ewmsg:ExchangeWeightMessage = null;
         var hbdlmsg:HavenBagDailyLoteryMessage = null;
         var ehbrmsg:EditHavenBagRequestMessage = null;
         var ehbcrmsg:EditHavenBagCancelRequestMessage = null;
         var j:int = 0;
         var f:HavenbagFurnitureSprite = null;
         var k:int = 0;
         var hfrmsg:HavenBagFurnituresRequestMessage = null;
         var ehbcrmsg2:EditHavenBagCancelRequestMessage = null;
         var errorMsgId:String = null;
         switch(true)
         {
            case msg is HavenbagEditModeAction:
               hema = msg as HavenbagEditModeAction;
               if(hema.isActive)
               {
                  ehbrmsg = new EditHavenBagRequestMessage();
                  ehbrmsg.initEditHavenBagRequestMessage();
                  ConnectionsHandler.getConnection().send(ehbrmsg);
               }
               else
               {
                  ehbcrmsg = new EditHavenBagCancelRequestMessage();
                  ehbcrmsg.initEditHavenBagCancelRequestMessage();
                  ConnectionsHandler.getConnection().send(ehbcrmsg);
                  this.cacheFurnituresInPreview(HavenbagFurnituresManager.getInstance().pack());
                  this.restoreFurnitures(this._furnituresBeforeEdit);
               }
               return true;
            case msg is EditHavenBagStartMessage:
               this.enterEditMode();
               return true;
            case msg is EditHavenBagFinishedMessage:
               KernelEventsManager.getInstance().processCallback(HookList.HavenbagExitEditMode);
               this.exitEditMode();
               return true;
            case msg is HavenBagFurnituresMessage:
               hbfmsg = msg as HavenBagFurnituresMessage;
               HavenbagFurnituresManager.getInstance().removeAllFurnitures();
               this._totalFurnituresToBeDisplayed = hbfmsg.furnituresInfos.length;
               furnitureSprites = new Array();
               for(j = 0; j < this._totalFurnituresToBeDisplayed; j++)
               {
                  furniture = new HavenbagFurnitureSprite(hbfmsg.furnituresInfos[j].funitureId,this.onFurnitureDisplayed);
                  furniture.position.cellId = hbfmsg.furnituresInfos[j].cellId;
                  furniture.orientation = hbfmsg.furnituresInfos[j].orientation;
                  if(furniture.layerId == 1)
                  {
                     HavenbagFurnituresManager.getInstance().addFurniture(furniture);
                  }
                  else
                  {
                     furnitureSprites.push(furniture);
                  }
               }
               for each(f in furnitureSprites)
               {
                  HavenbagFurnituresManager.getInstance().addFurniture(f);
               }
               HavenbagFurnituresManager.getInstance().updateMovOnFurnitureCells();
               if(!this._totalFurnituresToBeDisplayed)
               {
                  Atouin.getInstance().showWorld(true);
               }
               return true;
            case msg is HavenbagClearAction:
               HavenbagFurnituresManager.getInstance().removeAllFurnitures();
               return true;
            case msg is HavenbagResetAction:
               this.restoreFurnitures(this._furnituresBeforeEdit);
               return true;
            case msg is HavenbagSaveAction:
               packedFurnitures = HavenbagFurnituresManager.getInstance().pack();
               ohbfsrmsg = new OpenHavenBagFurnitureSequenceRequestMessage();
               ohbfsrmsg.initOpenHavenBagFurnitureSequenceRequestMessage();
               ConnectionsHandler.getConnection().send(ohbfsrmsg);
               for(k = 0; k < packedFurnitures.furnitureCellIds.length; k += ProtocolConstantsEnum.MAX_FURNITURES_PER_PACKET)
               {
                  hfrmsg = new HavenBagFurnituresRequestMessage();
                  hfrmsg.initHavenBagFurnituresRequestMessage(packedFurnitures.furnitureCellIds.slice(k,k + ProtocolConstantsEnum.MAX_FURNITURES_PER_PACKET),packedFurnitures.furnitureTypeIds.slice(k,k + ProtocolConstantsEnum.MAX_FURNITURES_PER_PACKET),packedFurnitures.furnitureOrientations.slice(k,k + ProtocolConstantsEnum.MAX_FURNITURES_PER_PACKET));
                  ConnectionsHandler.getConnection().send(hfrmsg);
               }
               chbfsrmsg = new CloseHavenBagFurnitureSequenceRequestMessage();
               chbfsrmsg.initCloseHavenBagFurnitureSequenceRequestMessage();
               ConnectionsHandler.getConnection().send(chbfsrmsg);
               this.cacheFurnituresInPreview(null);
               return true;
            case msg is HavenbagFurnitureSelectedAction:
               hfsa = msg as HavenbagFurnitureSelectedAction;
               _log.debug("FurnitureTypeId " + hfsa.furnitureTypeId + " selected");
               this.startDragFurniture(hfsa.furnitureTypeId);
               return true;
            case msg is MouseClickMessage:
               mcmsg = msg as MouseClickMessage;
               clickedFurniture = mcmsg.target as IFurniture;
               if(this._isInEditMode && clickedFurniture && !this._furnitureDragFrame)
               {
                  this.startDragFurniture(clickedFurniture.typeId,clickedFurniture.orientation,true);
                  HavenbagFurnituresManager.getInstance().removeFurniture(clickedFurniture.id);
                  return true;
               }
               return false;
               break;
            case msg is MouseRightClickOutsideMessage:
            case msg is MouseRightClickMessage:
               if(this._furnitureDragFrame)
               {
                  HavenbagFurnituresManager.getInstance().cancelPreviewFurniture(this._furnitureDragFrame.furniture);
                  Kernel.getWorker().removeFrame(this._furnitureDragFrame);
                  this._furnitureDragFrame = null;
                  return true;
               }
               if(this._isInEditMode)
               {
                  return true;
               }
               return false;
               break;
            case msg is MouseRightDownMessage:
               this._rightMouseIsDown = true;
               return false;
            case msg is MouseRightUpMessage:
               mrumsg = msg as MouseRightUpMessage;
               this._rightMouseIsDown = false;
               if(this._isInEditMode)
               {
                  if(mrumsg.target is IFurniture && (mrumsg.target as IFurniture).displayed)
                  {
                     if(HumanInputHandler.getInstance().getKeyboardPoll().isDown(Keyboard.SHIFT))
                     {
                        HavenbagFurnituresManager.getInstance().removeFurnituresOnCell((mrumsg.target as IFurniture).position.cellId);
                     }
                     else
                     {
                        HavenbagFurnituresManager.getInstance().removeFurniture((mrumsg.target as IFurniture).id);
                     }
                     return true;
                  }
               }
               return false;
            case msg is MouseOverMessage:
               momsg = msg as MouseOverMessage;
               if(!this._furnitureDragFrame && this._isInEditMode && momsg.target is IFurniture && (momsg.target as IFurniture).displayed)
               {
                  if(this._rightMouseIsDown)
                  {
                     if(HumanInputHandler.getInstance().getKeyboardPoll().isDown(Keyboard.SHIFT))
                     {
                        HavenbagFurnituresManager.getInstance().removeFurnituresOnCell((momsg.target as IFurniture).position.cellId);
                     }
                     else
                     {
                        HavenbagFurnituresManager.getInstance().removeFurniture((momsg.target as IFurniture).id);
                     }
                  }
                  else
                  {
                     (momsg.target as IFurniture).displayHighlight(true);
                  }
                  return true;
               }
               return false;
               break;
            case msg is MouseOutMessage:
               if(this._isInEditMode && msg["target"] is IFurniture)
               {
                  (msg["target"] as IFurniture).displayHighlight(false);
                  return true;
               }
               return false;
               break;
            case msg is HavenbagThemeSelectedAction:
               htsa = msg as HavenbagThemeSelectedAction;
               this.cacheFurnituresInPreview(HavenbagFurnituresManager.getInstance().pack());
               ctrmsg = new ChangeThemeRequestMessage();
               ctrmsg.initChangeThemeRequestMessage(htsa.themeId);
               ConnectionsHandler.getConnection().send(ctrmsg);
               return true;
            case msg is HavenbagRoomSelectedAction:
               hrsa = msg as HavenbagRoomSelectedAction;
               chbrrmsg = new ChangeHavenBagRoomRequestMessage();
               chbrrmsg.initChangeHavenBagRoomRequestMessage(hrsa.room);
               ConnectionsHandler.getConnection().send(chbrrmsg);
               return true;
            case msg is HavenBagPermissionsUpdateMessage:
               hbpumsg = msg as HavenBagPermissionsUpdateMessage;
               this._sharePermissions = hbpumsg.permissions;
               KernelEventsManager.getInstance().processCallback(HookList.HavenBagPermissionsUpdate);
               return true;
            case msg is HavenbagPermissionsUpdateRequestAction:
               hpura = msg as HavenbagPermissionsUpdateRequestAction;
               hbpurmsg = new HavenBagPermissionsUpdateRequestMessage();
               hbpurmsg.initHavenBagPermissionsUpdateRequestMessage(hpura.permissions);
               ConnectionsHandler.getConnection().send(hbpurmsg);
               return true;
            case msg is HavenbagExitAction:
               if(this._isInEditMode)
               {
                  ehbcrmsg2 = new EditHavenBagCancelRequestMessage();
                  ehbcrmsg2.initEditHavenBagCancelRequestMessage();
                  ConnectionsHandler.getConnection().send(ehbcrmsg2);
                  this.cacheFurnituresInPreview(HavenbagFurnituresManager.getInstance().pack());
               }
               exithbrmsg = new ExitHavenBagRequestMessage();
               exithbrmsg.initExitHavenBagRequestMessage();
               ConnectionsHandler.getConnection().send(exithbrmsg);
               return true;
            case msg is CellClickMessage:
               return this._isInEditMode;
            case msg is ExchangeWeightMessage:
               ewmsg = msg as ExchangeWeightMessage;
               KernelEventsManager.getInstance().processCallback(ExchangeHookList.ExchangeWeight,ewmsg.currentWeight,ewmsg.maxWeight);
               return true;
            case msg is HavenBagDailyLoteryMessage:
               hbdlmsg = msg as HavenBagDailyLoteryMessage;
               if(hbdlmsg.returnType == HavenBagDailyLoteryErrorEnum.HAVENBAG_DAILY_LOTERY_OK)
               {
                  HaapiKeyManager.getInstance().callWithApiKey(function(apiKey:String):void
                  {
                     var apiCredentials:ApiUserCredentials = new ApiUserCredentials("",XmlConfig.getInstance().getEntry("config.haapiUrlAnkama"),apiKey);
                     _lotteryApi = new KardApi(apiCredentials);
                     _lotteryApi.consume_by_id(XmlConfig.getInstance().getEntry("config.lang.current"),parseFloat(hbdlmsg.gameActionId),GameID.current).onSuccess(onSuccess).onError(onError).call();
                  });
               }
               else
               {
                  errorMsgId = hbdlmsg.returnType == HavenBagDailyLoteryErrorEnum.HAVENBAG_DAILY_LOTERY_ALREADYUSED ? "ui.havenbag.lottery.alreadyUsed" : "ui.common.error";
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText(errorMsgId),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               return true;
            default:
               return false;
         }
      }
      
      public function get priority() : int
      {
         return Priority.HIGH;
      }
      
      public function get isInEditMode() : Boolean
      {
         return this._isInEditMode;
      }
      
      public function clearFurnitureDragFrame() : void
      {
         this._furnitureDragFrame = null;
      }
      
      private function startDragFurniture(furnitureTypeId:uint, orientation:uint = 0, moveOnly:Boolean = false) : void
      {
         if(this._furnitureDragFrame)
         {
            this._furnitureDragFrame.clear();
         }
         this._furnitureDragFrame = new HavenbagFurnitureDragFrame(furnitureTypeId,orientation,this,moveOnly);
         Kernel.getWorker().addFrame(this._furnitureDragFrame);
      }
      
      private function enterEditMode() : void
      {
         this._isInEditMode = true;
         this._furnituresBeforeEdit = HavenbagFurnituresManager.getInstance().pack();
         if(_furnituresInEdit[this._previewCacheKey])
         {
            this.restoreFurnitures(HavenbagPackedInfos.createFromSharedObject(_furnituresInEdit[this._previewCacheKey]));
         }
         InteractiveCellManager.getInstance().show(true);
         HavenbagFurnituresManager.getInstance().enableMouseEvents();
         HavenbagFurnituresManager.getInstance().allowMovOnFurnitureCells();
         EntitiesManager.getInstance().setEntitiesVisibility(false);
         (Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame).enableInteractiveElements(false);
      }
      
      private function exitEditMode() : void
      {
         this._isInEditMode = false;
         this._furnituresBeforeEdit = null;
         InteractiveCellManager.getInstance().show(Atouin.getInstance().options.getOption("alwaysShowGrid"));
         if(this._furnitureDragFrame)
         {
            Kernel.getWorker().removeFrame(this._furnitureDragFrame);
            this._furnitureDragFrame = null;
         }
         HavenbagFurnituresManager.getInstance().disableMouseEvents();
         HavenbagFurnituresManager.getInstance().updateMovOnFurnitureCells();
         EntitiesManager.getInstance().setEntitiesVisibility(true);
         if(Kernel.getWorker().contains(RoleplayInteractivesFrame))
         {
            (Kernel.getWorker().getFrame(RoleplayInteractivesFrame) as RoleplayInteractivesFrame).enableInteractiveElements(true);
         }
      }
      
      private function restoreFurnitures(furnituresInfo:HavenbagPackedInfos) : void
      {
         var furniture:HavenbagFurnitureSprite = null;
         HavenbagFurnituresManager.getInstance().removeAllFurnitures();
         for(var i:int = 0; i < furnituresInfo.furnitureTypeIds.length; i++)
         {
            furniture = new HavenbagFurnitureSprite(furnituresInfo.furnitureTypeIds[i]);
            furniture.position.cellId = furnituresInfo.furnitureCellIds[i];
            furniture.orientation = furnituresInfo.furnitureOrientations[i];
            HavenbagFurnituresManager.getInstance().addFurniture(furniture);
         }
         HavenbagFurnituresManager.getInstance().enableMouseEvents();
      }
      
      private function cacheFurnituresInPreview(furnitureInfos:HavenbagPackedInfos) : void
      {
         _furnituresInEdit[this._previewCacheKey] = furnitureInfos;
         var so:CustomSharedObject = CustomSharedObject.getLocal("havenbag");
         if(so)
         {
            if(!so.data)
            {
               so.data = new Object();
            }
            so.data[this._previewCacheKey] = furnitureInfos;
            so.flush();
         }
      }
      
      private function onSuccess(pEvent:ApiClientEvent) : void
      {
         var kard:KardKard = null;
         var payload:* = pEvent.response.payload;
         if(payload && payload is Array && payload.length == 1 && payload[0] is KardKard)
         {
            kard = payload[0] as KardKard;
            KernelEventsManager.getInstance().processCallback(HookList.HavenBagLotteryGift,kard.name);
         }
      }
      
      private function onError(pEvent:ApiClientEvent) : void
      {
         KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.common.error"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
         _log.error(pEvent.response.errorMessage);
         throw new Error(pEvent.response.errorMessage);
      }
      
      private function onFurnitureDisplayed() : void
      {
         ++this._furnituresDisplayed;
         if(this._furnituresDisplayed == this._totalFurnituresToBeDisplayed)
         {
            Atouin.getInstance().showWorld(true);
         }
      }
   }
}
