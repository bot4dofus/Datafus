package Ankama_Exchange.ui
{
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.components.gridRenderer.SlotGridRenderer;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.CloseInventoryAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveKamaAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectTransfertAllToInvAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeReadyAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeRefuseAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.DisplayContextualMenuAction;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.uiApi.AveragePricesApi;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.StorageApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.display.Sprite;
   import flash.events.TimerEvent;
   
   public class ExchangeUi
   {
      
      public static const EXCHANGE_COLOR_OK:String = "EXCHANGE_COLOR_OK";
      
      public static const EXCHANGE_COLOR_CHANGE:String = "EXCHANGE_COLOR_CHANGE";
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Object;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="StorageApi")]
      public var storageApi:StorageApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="AveragePricesApi")]
      public var averagePricesApi:AveragePricesApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      private var _playerName:String;
      
      private var _otherPlayerName:String;
      
      private var _otherPlayerId:Number;
      
      private var _sourceName:String;
      
      private var _targetName:String;
      
      private var _currentPlayerKama:Number = 0;
      
      private var _leftItems:Array;
      
      private var _rightItems:Array;
      
      private var _leftCurrentPods:int;
      
      private var _rightCurrentPods:int;
      
      private var _leftMaxPods:int;
      
      private var _rightMaxPods:int;
      
      private var _leftExchangePods:int = 0;
      
      private var _rightExchangePods:int = 0;
      
      private var _rightPlayerKamaExchange:Number = 0;
      
      protected var _leftPlayerKamaExchange:Number = 0;
      
      private var _playerIsReady:Boolean = false;
      
      private var _timeDelay:Number = 2000;
      
      private var _timerDelay:BenchmarkTimer;
      
      private var _timeKamaDelay:Number = 1000;
      
      private var _timerKamaDelay:BenchmarkTimer;
      
      private var _timerPosButtons:BenchmarkTimer;
      
      private var _posXValid:int;
      
      private var _posYValid:int;
      
      private var _posXCancel:int;
      
      private var _posYCancel:int;
      
      private var _waitingObject:Object;
      
      private var _hasExchangeResult:Boolean = false;
      
      private var _success:Boolean = false;
      
      private var _myTopTimer:BenchmarkTimer;
      
      private var _myBottomTimer:BenchmarkTimer;
      
      private var _redTop:Boolean;
      
      private var _redBottom:Boolean;
      
      private var _myPodsTimer:BenchmarkTimer;
      
      private var _redPods:Boolean;
      
      private var _lbl_estimated_value_left_default_x:Number;
      
      private var _lbl_estimated_value_right_default_x:Number;
      
      private var estimated_value_left:Number;
      
      private var estimated_value_right:Number;
      
      private var _cancelKamaModification:Boolean;
      
      private var _errorItem:ItemWrapper = null;
      
      public var ctr_main:GraphicContainer;
      
      public var ctr_itemBlock:GraphicContainer;
      
      public var ctr_item:GraphicContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_validate:ButtonContainer;
      
      public var btn_cancel:ButtonContainer;
      
      public var btn_moveAll:ButtonContainer;
      
      public var lbl_leftPlayerName:Label;
      
      public var lbl_rightPlayerName:Label;
      
      public var lbl_kamaLeft:Label;
      
      public var input_kamaRight:Input;
      
      public var lbl_estimated_left:Label;
      
      public var lbl_estimated_value_left:Label;
      
      public var lbl_estimated_right:Label;
      
      public var lbl_estimated_value_right:Label;
      
      public var tx_podsBar_right:Texture;
      
      public var tx_podsBar_left:Texture;
      
      public var tx_estimated_value_warning_left:Texture;
      
      public var tx_estimated_value_warning_right:Texture;
      
      public var gd_left:Grid;
      
      public var gd_right:Grid;
      
      public var ed_leftPlayer:EntityDisplayer;
      
      public var ed_rightPlayer:EntityDisplayer;
      
      public var tx_kamaRight:TextureBitmap;
      
      public var tx_warningLeftTop:TextureBitmap;
      
      public var tx_warningLeftPods:TextureBitmap;
      
      public var tx_warningLeftBottom:TextureBitmap;
      
      public var tx_validatedLeftTop:TextureBitmap;
      
      public var tx_validatedLeftBottom:TextureBitmap;
      
      public var tx_validatedRightTop:TextureBitmap;
      
      public var tx_validatedRightBottom:TextureBitmap;
      
      public function ExchangeUi()
      {
         this._myTopTimer = new BenchmarkTimer(250,12,"ExchangeUi._myTopTimer");
         this._myBottomTimer = new BenchmarkTimer(250,12,"ExchangeUi._myBottomTimer");
         this._myPodsTimer = new BenchmarkTimer(250,12,"ExchangeUi._myPodsTimer");
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         this.sysApi.disableWorldInteraction(false);
         this.btn_cancel.soundId = SoundEnum.CANCEL_BUTTON;
         this.btn_validate.soundId = SoundEnum.OK_BUTTON;
         this.sysApi.addHook(ExchangeHookList.ExchangeObjectModified,this.onExchangeObjectModified);
         this.sysApi.addHook(ExchangeHookList.ExchangeObjectAdded,this.onExchangeObjectAdded);
         this.sysApi.addHook(ExchangeHookList.ExchangeObjectRemoved,this.onExchangeObjectRemoved);
         this.sysApi.addHook(ExchangeHookList.ExchangeKamaModified,this.onExchangeKamaModified);
         this.sysApi.addHook(ExchangeHookList.ExchangePodsModified,this.onExchangePodsModified);
         this.sysApi.addHook(ExchangeHookList.AskExchangeMoveObject,this.onAskExchangeMoveObject);
         this.sysApi.addHook(ExchangeHookList.ExchangeIsReady,this.onExchangeIsReady);
         this.sysApi.addHook(HookList.DoubleClickItemInventory,this.onDoubleClickItemInventory);
         this.sysApi.addHook(InventoryHookList.ObjectSelected,this.onObjectSelected);
         this.sysApi.addHook(ExchangeHookList.ExchangeLeave,this.onExchangeLeave);
         this.sysApi.addHook(ExchangeHookList.ExchangeObjectListAdded,this.onExchangeObjectListAdded);
         this.sysApi.addHook(ExchangeHookList.ExchangeObjectListModified,this.onExchangeObjectListModified);
         this.sysApi.addHook(ExchangeHookList.ExchangeObjectListRemoved,this.onExchangeObjectListRemoved);
         this.sysApi.addHook(BeriliaHookList.DropEnd,this.onDropEnd);
         this.uiApi.addComponentHook(this.ed_leftPlayer,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ed_leftPlayer,ComponentHookList.ON_RIGHT_CLICK);
         this.uiApi.addComponentHook(this.ed_rightPlayer,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ed_rightPlayer,ComponentHookList.ON_RIGHT_CLICK);
         this.uiApi.addComponentHook(this.gd_left,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.gd_left,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.gd_left,ComponentHookList.ON_ITEM_RIGHT_CLICK);
         this.uiApi.addComponentHook(this.gd_left,ComponentHookList.ON_ITEM_ROLL_OVER);
         this.uiApi.addComponentHook(this.gd_left,ComponentHookList.ON_ITEM_ROLL_OUT);
         this.uiApi.addComponentHook(this.gd_right,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.gd_right,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.gd_right,ComponentHookList.ON_ITEM_RIGHT_CLICK);
         this.uiApi.addComponentHook(this.gd_right,ComponentHookList.ON_ITEM_ROLL_OVER);
         this.uiApi.addComponentHook(this.gd_right,ComponentHookList.ON_ITEM_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_estimated_value_warning_left,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_estimated_value_warning_left,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.tx_estimated_value_warning_right,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_estimated_value_warning_right,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_kamaLeft,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_kamaLeft,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_estimated_left,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_estimated_left,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_estimated_value_left,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_estimated_value_left,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_estimated_right,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_estimated_right,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_estimated_value_right,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_estimated_value_right,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_moveAll,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_moveAll,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_validate,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_validate,ComponentHookList.ON_ROLL_OUT);
         this.btn_moveAll.disabled = this.playerApi.hasDebt();
         this.btn_moveAll.handCursor = !this.btn_moveAll.disabled;
         this.lbl_estimated_left.text = this.lbl_estimated_right.text = this.uiApi.getText("ui.exchange.estimatedValue") + " :";
         this._lbl_estimated_value_left_default_x = this.lbl_estimated_value_left.x;
         this._lbl_estimated_value_right_default_x = this.lbl_estimated_value_right.x;
         this.ed_leftPlayer.mouseEnabled = true;
         this.ed_leftPlayer.handCursor = true;
         this.ed_rightPlayer.mouseEnabled = true;
         this.ed_rightPlayer.handCursor = true;
         this.ctr_itemBlock.visible = false;
         this._leftItems = [];
         this._rightItems = [];
         this._playerName = this.playerApi.getPlayedCharacterInfo().name;
         this._sourceName = oParam.sourceName;
         this._targetName = oParam.targetName;
         this._currentPlayerKama = this.playerApi.characteristics().kamas;
         this.input_kamaRight.restrictChars = "0-9  ";
         this.input_kamaRight.disabled = this.playerApi.hasDebt();
         this.input_kamaRight.cssClass = !!this.playerApi.hasDebt() ? "disabledright" : "whiteboldright";
         this.tx_kamaRight.alpha = !!this.playerApi.hasDebt() ? Number(0.4) : Number(1);
         this.input_kamaRight.numberMax = ProtocolConstantsEnum.MAX_KAMA;
         this.uiApi.addComponentHook(this.input_kamaRight,ComponentHookList.ON_CHANGE);
         this.checkAcceptButton();
         this._otherPlayerId = oParam.otherId;
         if(this._sourceName == this._playerName)
         {
            this._otherPlayerName = this._targetName;
            this.ed_rightPlayer.look = oParam.sourceLook;
            if(oParam.targetLook.getBone() == 2241)
            {
               this.ed_leftPlayer.yOffset = -44;
            }
            this.ed_leftPlayer.look = oParam.targetLook;
            this._leftCurrentPods = oParam.targetCurrentPods;
            this._leftMaxPods = oParam.targetMaxPods;
            this._rightCurrentPods = oParam.sourceCurrentPods;
            this._rightMaxPods = oParam.sourceMaxPods;
         }
         else
         {
            this._otherPlayerName = this._sourceName;
            this.ed_leftPlayer.look = oParam.sourceLook;
            this.ed_rightPlayer.look = oParam.targetLook;
            this._rightCurrentPods = oParam.targetCurrentPods;
            this._rightMaxPods = oParam.targetMaxPods;
            this._leftCurrentPods = oParam.sourceCurrentPods;
            this._leftMaxPods = oParam.sourceMaxPods;
         }
         var charMaskL:Sprite = new Sprite();
         charMaskL.graphics.beginFill(16733440,0.5);
         charMaskL.graphics.drawRect(this.ed_leftPlayer.x,this.ed_leftPlayer.y,this.ed_leftPlayer.width,100);
         charMaskL.graphics.endFill();
         this.ctr_main.addChild(charMaskL);
         this.ed_leftPlayer.mask = charMaskL;
         var charMaskR:Sprite = new Sprite();
         charMaskR.graphics.beginFill(16733440,0.5);
         charMaskR.graphics.drawRect(this.ed_rightPlayer.x,this.ed_rightPlayer.y,this.ed_rightPlayer.width,100);
         charMaskR.graphics.endFill();
         this.ctr_main.addChild(charMaskR);
         this.ed_rightPlayer.mask = charMaskR;
         this.updatePods();
         this.lbl_rightPlayerName.text = this._playerName;
         this.lbl_leftPlayerName.text = this._otherPlayerName;
         this._rightPlayerKamaExchange = 0;
         this._leftPlayerKamaExchange = 0;
         this.estimated_value_left = this.estimated_value_right = 0;
         this.updateEstimatedValue(this._leftItems,0,this.lbl_estimated_value_left);
         this.updateEstimatedValue(this._rightItems,0,this.lbl_estimated_value_right);
         this.gd_left.dataProvider = [];
         (this.gd_left.renderer as SlotGridRenderer).dropValidatorFunction = this.dropValidatorFalse;
         (this.gd_left.renderer as SlotGridRenderer).processDropFunction = this.processDropNull;
         (this.gd_left.renderer as SlotGridRenderer).removeDropSourceFunction = this.removeDropSource;
         this.gd_right.dataProvider = [];
         (this.gd_right.renderer as SlotGridRenderer).dropValidatorFunction = this.dropValidator;
         (this.gd_right.renderer as SlotGridRenderer).processDropFunction = this.processDrop;
         (this.gd_right.renderer as SlotGridRenderer).removeDropSourceFunction = this.removeDropSource;
         this.gd_right.mouseEnabled = true;
         if(oParam.sourceCurrentPods > 0)
         {
            this.uiApi.addComponentHook(this.tx_podsBar_left,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_podsBar_left,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(this.tx_podsBar_right,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(this.tx_podsBar_right,ComponentHookList.ON_ROLL_OUT);
         }
         else
         {
            this.tx_podsBar_left.visible = false;
            this.tx_podsBar_right.visible = false;
         }
      }
      
      private function redWink(top:Boolean) : void
      {
         if(top)
         {
            this._myTopTimer.start();
            this._myTopTimer.addEventListener(TimerEvent.TIMER,this.topTimerHandler);
            this._myTopTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.topCompleteHandler);
         }
         else
         {
            this._myBottomTimer.start();
            this._myBottomTimer.addEventListener(TimerEvent.TIMER,this.bottomTimerHandler);
            this._myBottomTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.bottomCompleteHandler);
         }
      }
      
      private function redPodsWink() : void
      {
         this._myPodsTimer.start();
         this._myPodsTimer.addEventListener(TimerEvent.TIMER,this.podsTimerHandler);
         this._myPodsTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.podsCompleteHandler);
      }
      
      private function topTimerHandler(e:TimerEvent) : void
      {
         if(this._redTop)
         {
            this.tx_warningLeftTop.visible = false;
            this._redTop = false;
         }
         else
         {
            this.tx_warningLeftTop.visible = true;
            this._redTop = true;
         }
      }
      
      private function topCompleteHandler(e:TimerEvent) : void
      {
         this.tx_warningLeftTop.visible = false;
         this._redTop = false;
         this._myTopTimer.reset();
      }
      
      private function bottomTimerHandler(e:TimerEvent) : void
      {
         if(this._redBottom)
         {
            this.tx_warningLeftBottom.visible = false;
            this._redBottom = false;
         }
         else
         {
            this.tx_warningLeftBottom.visible = true;
            this._redBottom = true;
         }
      }
      
      private function bottomCompleteHandler(e:TimerEvent) : void
      {
         this.tx_warningLeftBottom.visible = false;
         this._redBottom = false;
         this._myBottomTimer.reset();
      }
      
      private function podsTimerHandler(e:TimerEvent) : void
      {
         if(this._redPods)
         {
            this.tx_warningLeftPods.visible = false;
            this._redPods = false;
         }
         else
         {
            this.tx_warningLeftPods.visible = true;
            this._redPods = true;
         }
      }
      
      private function podsCompleteHandler(e:TimerEvent) : void
      {
         this.tx_warningLeftPods.visible = false;
         this._redPods = false;
         this._myPodsTimer.reset();
      }
      
      public function onChange(target:GraphicContainer) : void
      {
         var value:Number = this.utilApi.stringToKamas(this.input_kamaRight.text,"");
         if(value > this._currentPlayerKama)
         {
            value = this._currentPlayerKama;
            this.input_kamaRight.text = this.utilApi.kamasToString(value,"");
         }
         if(this._timerKamaDelay)
         {
            this._timerKamaDelay.stop();
            this._timerKamaDelay.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerKamaDelay);
            this._cancelKamaModification = true;
         }
         this._timerKamaDelay = new BenchmarkTimer(this._timeKamaDelay,1,"ExchangeUi._timerKamaDelay");
         this._timerKamaDelay.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerKamaDelay);
         this.onExchangeIsReady(this.playerApi.getPlayedCharacterInfo().name,false);
         this.delayEnableValidateButton();
         this._timerKamaDelay.start();
      }
      
      private function onTimerDelayValidateButton(e:TimerEvent) : void
      {
         this._timerDelay.removeEventListener(TimerEvent.TIMER,this.onTimerDelayValidateButton);
         this.checkAcceptButton();
      }
      
      private function onTimerKamaDelay(e:TimerEvent) : void
      {
         this._timerKamaDelay.removeEventListener(TimerEvent.TIMER,this.onTimerKamaDelay);
         var value:Number = this.utilApi.stringToKamas(this.input_kamaRight.text,"");
         if(value != this._rightPlayerKamaExchange)
         {
            this._rightPlayerKamaExchange = value;
            this._cancelKamaModification = false;
            this.sysApi.sendAction(new ExchangeObjectMoveKamaAction([this._rightPlayerKamaExchange]));
         }
      }
      
      public function onObjectSelected(item:Object) : void
      {
         if(!this.sysApi.getOption("displayTooltips","dofus"))
         {
            if(item)
            {
               this.modCommon.createItemBox("itemBox",this.ctr_item,item);
               this.ctr_itemBlock.visible = true;
            }
            else
            {
               this.ctr_itemBlock.visible = false;
            }
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var contextMenu:Array = null;
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_cancel:
               if(this._playerIsReady)
               {
                  this.validateExchange(false);
               }
               else
               {
                  this.uiApi.unloadUi(this.uiApi.me().name);
               }
               break;
            case this.btn_validate:
               if(!this._playerIsReady)
               {
                  this.validateExchange(true);
               }
               break;
            case this.ed_leftPlayer:
               this.sysApi.sendAction(new DisplayContextualMenuAction([this._otherPlayerId]));
               break;
            case this.ed_rightPlayer:
               this.sysApi.sendAction(new DisplayContextualMenuAction([this.playerApi.id()]));
               break;
            case this.btn_moveAll:
               contextMenu = [];
               contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.storage.getAll"),this.transfertAll,null,false,null,false,true));
               this.modContextMenu.createContextMenu(contextMenu);
         }
      }
      
      public function onSelectItem(target:Grid, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var selectedItem:Object = null;
         var selectedItem2:Object = null;
         switch(target)
         {
            case this.gd_right:
               selectedItem = this.gd_right.selectedItem;
               if(selectMethod == SelectMethodEnum.DOUBLE_CLICK)
               {
                  this.sysApi.sendAction(new ExchangeObjectMoveAction([selectedItem.objectUID,-1]));
               }
               else if(selectMethod == SelectMethodEnum.CTRL_DOUBLE_CLICK)
               {
                  this.sysApi.sendAction(new ExchangeObjectMoveAction([selectedItem.objectUID,-selectedItem.quantity]));
               }
               else if(selectMethod == SelectMethodEnum.ALT_DOUBLE_CLICK)
               {
                  this._waitingObject = selectedItem;
                  this.modCommon.openQuantityPopup(1,this._waitingObject.quantity,this._waitingObject.quantity,this.onAltValidQty);
               }
               else
               {
                  this.onObjectSelected(selectedItem);
               }
               break;
            case this.gd_left:
               selectedItem2 = this.gd_left.selectedItem;
               this.onObjectSelected(selectedItem2);
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var pos:Object = {};
         pos.point = LocationEnum.POINT_BOTTOM;
         pos.relativePoint = LocationEnum.POINT_TOP;
         switch(target)
         {
            case this.tx_podsBar_left:
               tooltipText = this.uiApi.getText("ui.common.player.weight",this.utilApi.kamasToString(this._leftCurrentPods + this._leftExchangePods,""),this.utilApi.kamasToString(this._leftMaxPods,""));
               break;
            case this.tx_podsBar_right:
               tooltipText = this.uiApi.getText("ui.common.player.weight",this.utilApi.kamasToString(this._rightCurrentPods + this._rightExchangePods,""),this.utilApi.kamasToString(this._rightMaxPods,""));
               break;
            case this.lbl_kamaLeft:
               tooltipText = this.uiApi.getText("ui.exchange.kamas");
               break;
            case this.lbl_estimated_left:
            case this.lbl_estimated_value_left:
            case this.lbl_estimated_right:
            case this.lbl_estimated_value_right:
               tooltipText = this.uiApi.getText("ui.exchange.estimatedValue.description");
               break;
            case this.tx_estimated_value_warning_left:
            case this.tx_estimated_value_warning_right:
               tooltipText = this.uiApi.getText("ui.exchange.warning");
               break;
            case this.btn_moveAll:
               tooltipText = this.uiApi.getText("ui.storage.advancedTransferts");
         }
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onRightClick(target:GraphicContainer) : void
      {
         if(target == this.ed_leftPlayer)
         {
            this.sysApi.sendAction(new DisplayContextualMenuAction([this._otherPlayerId]));
         }
         else if(target == this.ed_rightPlayer)
         {
            this.sysApi.sendAction(new DisplayContextualMenuAction([this.playerApi.id()]));
         }
      }
      
      public function onItemRollOver(target:GraphicContainer, item:Object) : void
      {
         var itemTooltipSettings:ItemTooltipSettings = null;
         var settings:Object = null;
         var setting:String = null;
         if(item.data)
         {
            itemTooltipSettings = this.tooltipApi.createItemSettings();
            settings = {};
            for each(setting in this.sysApi.getObjectVariables(itemTooltipSettings))
            {
               settings[setting] = itemTooltipSettings[setting];
            }
            settings.ref = item.container;
            this.uiApi.showTooltip(item.data,item.container,false,"standard",8,0,0,"itemName",null,settings,"ItemInfo");
         }
      }
      
      public function onItemRollOut(target:GraphicContainer, item:Object) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onItemRightClick(target:GraphicContainer, item:Object) : void
      {
         if(item.data == null)
         {
            return;
         }
         var data:Object = item.data;
         var contextMenu:ContextMenuData = this.menuApi.create(data);
         var itemTooltipSettings:ItemTooltipSettings = this.sysApi.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
         if(!itemTooltipSettings)
         {
            itemTooltipSettings = this.tooltipApi.createItemSettings();
            this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
         }
         var disabled:Boolean = contextMenu.content[0].disabled;
         this.modContextMenu.createContextMenu(contextMenu);
      }
      
      public function unload() : void
      {
         if(this._timerPosButtons)
         {
            this._timerPosButtons.removeEventListener(TimerEvent.TIMER,this.onTimerDelayValidateButton);
            this._timerPosButtons.stop();
            this._timerPosButtons = null;
         }
         if(this._timerDelay)
         {
            this._timerDelay.removeEventListener(TimerEvent.TIMER,this.onTimerDelayValidateButton);
            this._timerDelay.stop();
            this._timerDelay = null;
         }
         this._myTopTimer.removeEventListener(TimerEvent.TIMER,this.topTimerHandler);
         this._myTopTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.topCompleteHandler);
         this._myBottomTimer.removeEventListener(TimerEvent.TIMER,this.bottomTimerHandler);
         this._myBottomTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.bottomCompleteHandler);
         this._myPodsTimer.removeEventListener(TimerEvent.TIMER,this.podsTimerHandler);
         this._myPodsTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.podsCompleteHandler);
         this.storageApi.removeAllItemMasks("exchange");
         this.storageApi.releaseHooks();
         if(this._timerKamaDelay)
         {
            this._timerKamaDelay.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerKamaDelay);
         }
         this.uiApi.hideTooltip();
         this.uiApi.unloadUi("itemBox");
         if(!this._hasExchangeResult)
         {
            this.sysApi.sendAction(new ExchangeRefuseAction([]));
         }
         this.sysApi.sendAction(new CloseInventoryAction([]));
         if(this._success)
         {
            this.sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.exchange.success"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,this.timeApi.getTimestamp());
         }
         else
         {
            this.sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.exchange.cancel"),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,this.timeApi.getTimestamp());
         }
         this.sysApi.enableWorldInteraction();
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case ShortcutHookListEnum.CLOSE_UI:
            case ShortcutHookListEnum.VALID_UI:
               return true;
            default:
               return false;
         }
      }
      
      public function dropValidatorFalse(target:Object, data:Object, source:Object) : Boolean
      {
         return false;
      }
      
      public function dropValidator(target:Object, data:Object, source:Object) : Boolean
      {
         this._errorItem = null;
         if(target.getUi().name != source.getUi().name)
         {
            if(data is ItemWrapper)
            {
               if((data as ItemWrapper).position != 63)
               {
                  this._errorItem = data.realItem;
                  return false;
               }
            }
            else if(data.hasOwnProperty("realItem") && data.realItem is ItemWrapper)
            {
               if((data.realItem as ItemWrapper).position != 63)
               {
                  this._errorItem = data.realItem;
                  return false;
               }
            }
            return true;
         }
         return false;
      }
      
      public function removeDropSource(target:Object) : void
      {
      }
      
      public function processDrop(target:Object, data:Object, source:Object) : void
      {
         if(this.dropValidator(target,data,source))
         {
            this._waitingObject = data;
            if(data.quantity > 1)
            {
               this.modCommon.openQuantityPopup(1,data.quantity,data.quantity,this.onValidQty);
            }
            else
            {
               this.onValidQty(1);
            }
         }
      }
      
      public function processDropNull(target:Object, data:Object, source:Object) : void
      {
      }
      
      private function delayEnableValidateButton() : void
      {
         if(this._timerDelay)
         {
            this._timerDelay.stop();
            this._timerDelay.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerDelayValidateButton);
         }
         this._timerDelay = new BenchmarkTimer(this._timeDelay,1,"ExchangeUi._timerDelay");
         this._timerDelay.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerDelayValidateButton);
         this.btn_validate.disabled = true;
         this._timerDelay.start();
      }
      
      protected function checkAcceptButton() : void
      {
         if(this.gd_left.dataProvider.length > 0 || this.gd_right.dataProvider.length > 0 || this._rightPlayerKamaExchange > 0 || this._leftPlayerKamaExchange > 0)
         {
            this.btn_validate.disabled = false;
         }
         else
         {
            this.btn_validate.disabled = true;
         }
      }
      
      private function addItemInLeftGrid(pItemWrapper:Object) : void
      {
         var item:Item = this.dataApi.getItem(pItemWrapper.objectGID);
         this._leftExchangePods -= pItemWrapper.quantity * pItemWrapper.weight;
         this._rightExchangePods += pItemWrapper.quantity * pItemWrapper.weight;
         this.updatePods();
         this._leftItems.push(pItemWrapper);
         this.gd_left.dataProvider = this._leftItems;
         this.gd_left.moveTo(this.gd_left.dataProvider.length - 1,true);
         this.updateEstimatedValue(this._leftItems,this._leftPlayerKamaExchange,this.lbl_estimated_value_left);
         this.redWink(false);
      }
      
      private function addItemListInLeftGrid(pItemWrapperList:Object) : void
      {
         var pItemWrapper:ItemWrapper = null;
         for each(pItemWrapper in pItemWrapperList)
         {
            this._leftExchangePods -= pItemWrapper.quantity * pItemWrapper.weight;
            this._rightExchangePods += pItemWrapper.quantity * pItemWrapper.weight;
            this._leftItems.push(pItemWrapper);
            this.storageApi.addItemMask(pItemWrapper.objectUID,"exchange",pItemWrapper.quantity);
         }
         this.storageApi.releaseHooks();
         this.updatePods();
         this.gd_left.dataProvider = this._leftItems;
         this.gd_left.moveTo(this.gd_left.dataProvider.length - 1,true);
         this.updateEstimatedValue(this._leftItems,this._leftPlayerKamaExchange,this.lbl_estimated_value_left);
         this.redWink(false);
      }
      
      private function addItemInRightGrid(pItemWrapper:Object) : void
      {
         this._leftExchangePods += pItemWrapper.quantity * pItemWrapper.weight;
         this._rightExchangePods -= pItemWrapper.quantity * pItemWrapper.weight;
         this.updatePods();
         this._rightItems.push(pItemWrapper);
         this.gd_right.dataProvider = this._rightItems;
         this.gd_right.moveTo(this.gd_right.dataProvider.length - 1,true);
         this.updateEstimatedValue(this._rightItems,this._rightPlayerKamaExchange,this.lbl_estimated_value_right);
      }
      
      private function addItemListInRightGrid(pItemWrapperList:Object) : void
      {
         var wrapper:ItemWrapper = null;
         for each(wrapper in pItemWrapperList)
         {
            this._leftExchangePods += wrapper.quantity * wrapper.weight;
            this._rightExchangePods -= wrapper.quantity * wrapper.weight;
            this._rightItems.push(wrapper);
            this.storageApi.addItemMask(wrapper.objectUID,"exchange",wrapper.quantity);
         }
         this.storageApi.releaseHooks();
         this.updatePods();
         this.gd_right.dataProvider = this._rightItems;
         this.gd_right.moveTo(this.gd_right.dataProvider.length - 1,true);
         this.updateEstimatedValue(this._rightItems,this._rightPlayerKamaExchange,this.lbl_estimated_value_right);
      }
      
      private function removeItemInRightGrid(pItemUID:int) : void
      {
         var index:String = null;
         var i:* = null;
         var item:Item = null;
         var scrollIndex:int = 0;
         for(i in this._rightItems)
         {
            if(this._rightItems[i].objectUID == pItemUID)
            {
               index = i;
               break;
            }
         }
         if(index)
         {
            item = this.dataApi.getItem(this._rightItems[index].objectGID);
            this._leftExchangePods -= this._rightItems[index].quantity * this._rightItems[index].weight;
            this._rightExchangePods += this._rightItems[index].quantity * this._rightItems[index].weight;
            this.updatePods();
            this._rightItems.splice(index,1);
            scrollIndex = this.gd_right.verticalScrollValue * this.gd_right.slotByRow + 1;
            this.gd_right.dataProvider = this._rightItems;
            this.gd_right.moveTo(scrollIndex,true);
            this.updateEstimatedValue(this._rightItems,this._rightPlayerKamaExchange,this.lbl_estimated_value_right);
         }
      }
      
      private function removeItemInLeftGrid(pItemUID:int) : void
      {
         var index:String = null;
         var i:* = null;
         var item:Item = null;
         var scrollIndex:int = 0;
         for(i in this._leftItems)
         {
            if(this._leftItems[i].objectUID == pItemUID)
            {
               index = i;
               break;
            }
         }
         if(index)
         {
            item = this.dataApi.getItem(this._leftItems[index].objectGID);
            this._leftExchangePods += this._leftItems[index].quantity * this._leftItems[index].weight;
            this._rightExchangePods -= this._leftItems[index].quantity * this._leftItems[index].weight;
            this.updatePods();
            this._leftItems.splice(index,1);
            scrollIndex = this.gd_left.verticalScrollValue * this.gd_left.slotByRow + 1;
            this.gd_left.dataProvider = this._leftItems;
            this.gd_left.moveTo(scrollIndex,true);
            this.updateEstimatedValue(this._leftItems,this._leftPlayerKamaExchange,this.lbl_estimated_value_left);
            this.redWink(false);
         }
      }
      
      private function modifyItemInRightGrid(pItemWrapper:Object) : void
      {
         var index:String = null;
         var i:* = null;
         var item:Item = null;
         var scrollIndex:int = 0;
         for(i in this._rightItems)
         {
            if(this._rightItems[i].objectUID == pItemWrapper.objectUID)
            {
               index = i;
               break;
            }
         }
         if(index)
         {
            item = this.dataApi.getItem(pItemWrapper.objectGID);
            this._leftExchangePods -= this._rightItems[index].quantity * this._rightItems[index].weight;
            this._rightExchangePods += this._rightItems[index].quantity * this._rightItems[index].weight;
            this._leftExchangePods += pItemWrapper.quantity * pItemWrapper.weight;
            this._rightExchangePods -= pItemWrapper.quantity * pItemWrapper.weight;
            this.updatePods();
            this._rightItems.splice(index,1,pItemWrapper);
            scrollIndex = this.gd_right.verticalScrollValue * this.gd_right.slotByRow + 1;
            this.gd_right.dataProvider = this._rightItems;
            this.gd_right.moveTo(scrollIndex,true);
            this.updateEstimatedValue(this._rightItems,this._rightPlayerKamaExchange,this.lbl_estimated_value_right);
         }
      }
      
      private function modifyItemListInRightGrid(pItemWrapperList:Object) : void
      {
         var index:String = null;
         var pItemWrapper:ItemWrapper = null;
         var scrollIndex:int = 0;
         var i:* = null;
         var item:Item = null;
         for each(pItemWrapper in pItemWrapperList)
         {
            for(i in this._rightItems)
            {
               if(this._rightItems[i].objectUID == pItemWrapper.objectUID)
               {
                  index = i;
                  break;
               }
            }
            if(index)
            {
               item = this.dataApi.getItem(pItemWrapper.objectGID);
               this._leftExchangePods -= this._rightItems[index].quantity * this._rightItems[index].weight;
               this._rightExchangePods += this._rightItems[index].quantity * this._rightItems[index].weight;
               this._leftExchangePods += pItemWrapper.quantity * pItemWrapper.weight;
               this._rightExchangePods -= pItemWrapper.quantity * pItemWrapper.weight;
               this._rightItems.splice(index,1,pItemWrapper);
               this.storageApi.addItemMask(pItemWrapper.objectUID,"exchange",pItemWrapper.quantity);
            }
         }
         scrollIndex = this.gd_right.verticalScrollValue * this.gd_right.slotByRow + 1;
         this.gd_right.dataProvider = this._rightItems;
         this.gd_right.moveTo(scrollIndex,true);
         this.updatePods();
         this.storageApi.releaseHooks();
         this.updateEstimatedValue(this._rightItems,this._rightPlayerKamaExchange,this.lbl_estimated_value_right);
      }
      
      private function modifyItemInLeftGrid(pItemWrapper:Object) : void
      {
         var index:String = null;
         var i:* = null;
         var item:Item = null;
         var scrollIndex:int = 0;
         for(i in this._leftItems)
         {
            if(this._leftItems[i].objectUID == pItemWrapper.objectUID)
            {
               index = i;
               break;
            }
         }
         if(index)
         {
            item = this.dataApi.getItem(pItemWrapper.objectGID);
            this._leftExchangePods += this._leftItems[index].quantity * this._leftItems[index].weight;
            this._rightExchangePods -= this._leftItems[index].quantity * this._leftItems[index].weight;
            this._leftExchangePods -= pItemWrapper.quantity * pItemWrapper.weight;
            this._rightExchangePods += pItemWrapper.quantity * pItemWrapper.weight;
            this.updatePods();
            this._leftItems.splice(index,1,pItemWrapper);
            scrollIndex = this.gd_left.verticalScrollValue * this.gd_left.slotByRow + 1;
            this.gd_left.dataProvider = this._leftItems;
            this.gd_left.moveTo(scrollIndex,true);
            this.updateEstimatedValue(this._leftItems,this._leftPlayerKamaExchange,this.lbl_estimated_value_left);
            this.redWink(false);
         }
      }
      
      private function modifyItemListInLeftGrid(pItemWrapperList:Object) : void
      {
         var index:String = null;
         var pItemWrapper:ItemWrapper = null;
         var scrollIndex:int = 0;
         var i:* = null;
         for each(pItemWrapper in pItemWrapperList)
         {
            for(i in this._leftItems)
            {
               if(this._leftItems[i].objectUID == pItemWrapper.objectUID)
               {
                  index = i;
                  break;
               }
            }
            if(index)
            {
               this._leftExchangePods += this._leftItems[index].quantity * this._leftItems[index].weight;
               this._rightExchangePods -= this._leftItems[index].quantity * this._leftItems[index].weight;
               this._leftExchangePods -= pItemWrapper.quantity * pItemWrapper.weight;
               this._rightExchangePods += pItemWrapper.quantity * pItemWrapper.weight;
               this._leftItems.splice(index,1,pItemWrapper);
            }
         }
         scrollIndex = this.gd_left.verticalScrollValue * this.gd_left.slotByRow + 1;
         this.gd_left.dataProvider = this._leftItems;
         this.gd_left.moveTo(scrollIndex,true);
         this.updatePods();
         this.updateEstimatedValue(this._leftItems,this._leftPlayerKamaExchange,this.lbl_estimated_value_left);
         this.redWink(false);
      }
      
      private function validateExchange(ready:Boolean) : void
      {
         var value:Number = NaN;
         if(this._timerKamaDelay && this._timerKamaDelay.running)
         {
            value = this.utilApi.stringToKamas(this.input_kamaRight.text,"");
            if(value != this._rightPlayerKamaExchange)
            {
               this._rightPlayerKamaExchange = value;
               this.sysApi.sendAction(new ExchangeObjectMoveKamaAction([this._rightPlayerKamaExchange]));
            }
         }
         else
         {
            this.sysApi.sendAction(new ExchangeReadyAction([ready]));
         }
      }
      
      private function changeBackgroundGrid(value:String, grid:Object) : void
      {
         switch(value)
         {
            case EXCHANGE_COLOR_OK:
               switch(grid)
               {
                  case this.gd_left:
                     this.tx_validatedLeftTop.visible = true;
                     this.tx_validatedLeftBottom.visible = true;
                     break;
                  case this.gd_right:
                     this.tx_validatedRightTop.visible = true;
                     this.tx_validatedRightBottom.visible = true;
               }
               break;
            case EXCHANGE_COLOR_CHANGE:
               switch(grid)
               {
                  case this.gd_left:
                     this.tx_validatedLeftTop.visible = false;
                     this.tx_validatedLeftBottom.visible = false;
                     break;
                  case this.gd_right:
                     this.tx_validatedRightTop.visible = false;
                     this.tx_validatedRightBottom.visible = false;
               }
         }
      }
      
      private function updatePods() : void
      {
         this.tx_podsBar_left.gotoAndStop = Math.min(100,Math.floor(100 * (this._leftCurrentPods + this._leftExchangePods) / this._leftMaxPods));
         this.tx_podsBar_right.gotoAndStop = Math.min(100,Math.floor(100 * (this._rightCurrentPods + this._rightExchangePods) / this._rightMaxPods));
      }
      
      private function updateEstimatedValue(pItemsList:Array, pKamas:Number, pLabel:Label) : void
      {
         var i:* = null;
         var averagePrice:Number = NaN;
         var itemsValue:Number = 0;
         for(i in pItemsList)
         {
            averagePrice = this.averagePricesApi.getItemAveragePrice(pItemsList[i].objectGID);
            if(averagePrice > 0)
            {
               itemsValue += averagePrice * pItemsList[i].quantity;
            }
         }
         pLabel.text = this.utilApi.kamasToString(itemsValue + pKamas);
         if(pLabel.name == "lbl_estimated_value_left")
         {
            this.estimated_value_left = itemsValue + pKamas;
         }
         else if(pLabel.name == "lbl_estimated_value_right")
         {
            this.estimated_value_right = itemsValue + pKamas;
         }
         this.checkFairTrade();
      }
      
      private function checkFairTrade() : void
      {
         var fairTrade:Boolean = true;
         if(this.estimated_value_left > 0 && this.estimated_value_left >= 2 * this.estimated_value_right)
         {
            this.tx_estimated_value_warning_left.visible = true;
            this.lbl_estimated_value_left.x = this._lbl_estimated_value_left_default_x - 20;
            fairTrade = false;
         }
         else
         {
            this.tx_estimated_value_warning_left.visible = false;
            this.lbl_estimated_value_left.x = this._lbl_estimated_value_left_default_x;
         }
         if(this.estimated_value_right > 0 && this.estimated_value_right >= 2 * this.estimated_value_left)
         {
            this.tx_estimated_value_warning_right.visible = true;
            this.lbl_estimated_value_right.x = this._lbl_estimated_value_right_default_x - 20;
            fairTrade = false;
         }
         else
         {
            this.tx_estimated_value_warning_right.visible = false;
            this.lbl_estimated_value_right.x = this._lbl_estimated_value_right_default_x;
         }
         if(!fairTrade)
         {
            this.lbl_estimated_value_left.cssClass = this.lbl_estimated_value_right.cssClass = "orangeright";
         }
         else
         {
            this.lbl_estimated_value_left.cssClass = this.lbl_estimated_value_right.cssClass = "right";
         }
      }
      
      private function transfertAll() : void
      {
         this.sysApi.sendAction(new ExchangeObjectTransfertAllToInvAction([]));
      }
      
      private function onExchangeIsReady(playerName:String, isReady:Boolean) : void
      {
         if(playerName != this._playerName)
         {
            if(isReady)
            {
               this.changeBackgroundGrid(EXCHANGE_COLOR_OK,this.gd_left);
            }
            else
            {
               this.changeBackgroundGrid(EXCHANGE_COLOR_CHANGE,this.gd_left);
            }
         }
         else
         {
            this._playerIsReady = isReady;
            if(isReady)
            {
               this.changeBackgroundGrid(EXCHANGE_COLOR_OK,this.gd_right);
            }
            else
            {
               this.changeBackgroundGrid(EXCHANGE_COLOR_CHANGE,this.gd_right);
            }
         }
      }
      
      private function onAskExchangeMoveObject(itemUID:int, itemQuantity:int) : void
      {
      }
      
      private function onExchangeObjectModified(pObjectModified:Object, remote:Boolean) : void
      {
         if(remote)
         {
            this.modifyItemInLeftGrid(pObjectModified);
         }
         else
         {
            this.modifyItemInRightGrid(pObjectModified);
         }
         this.gd_left.updateItems();
         this.gd_right.updateItems();
         this.storageApi.addItemMask(pObjectModified.objectUID,"exchange",pObjectModified.quantity);
         this.storageApi.releaseHooks();
         this.checkAcceptButton();
         this.delayEnableValidateButton();
      }
      
      private function onExchangeObjectAdded(itemWrapper:ItemWrapper, remote:Object) : void
      {
         this.soundApi.playSound(SoundTypeEnum.SWITCH_RIGHT_TO_LEFT);
         if(!remote)
         {
            this.addItemInRightGrid(itemWrapper);
         }
         else
         {
            this.addItemInLeftGrid(itemWrapper);
         }
         this.storageApi.addItemMask(itemWrapper.objectUID,"exchange",itemWrapper.quantity);
         this.storageApi.releaseHooks();
         this.delayEnableValidateButton();
      }
      
      private function onExchangeObjectListAdded(objectList:Array, remote:Boolean) : void
      {
         if(!remote)
         {
            this.addItemListInRightGrid(objectList);
         }
         else
         {
            this.addItemListInLeftGrid(objectList);
         }
         this.delayEnableValidateButton();
      }
      
      private function onExchangeObjectListModified(objectList:Array, remote:Boolean) : void
      {
         if(remote)
         {
            this.modifyItemListInLeftGrid(objectList);
         }
         else
         {
            this.modifyItemListInRightGrid(objectList);
         }
         this.gd_left.updateItems();
         this.gd_right.updateItems();
         this.checkAcceptButton();
         this.delayEnableValidateButton();
      }
      
      private function onExchangeObjectRemoved(itemUID:int, remote:Boolean) : void
      {
         this.soundApi.playSound(SoundTypeEnum.SWITCH_LEFT_TO_RIGHT);
         if(!remote)
         {
            this.removeItemInRightGrid(itemUID);
         }
         else
         {
            this.removeItemInLeftGrid(itemUID);
         }
         this.storageApi.removeItemMask(itemUID,"exchange");
         this.storageApi.releaseHooks();
         this.checkAcceptButton();
         this.delayEnableValidateButton();
      }
      
      private function onExchangeObjectListRemoved(itemUIDList:Object, remote:Boolean) : void
      {
         var itemUID:int = 0;
         this.soundApi.playSound(SoundTypeEnum.SWITCH_LEFT_TO_RIGHT);
         for each(itemUID in itemUIDList)
         {
            if(!remote)
            {
               this.removeItemInRightGrid(itemUID);
            }
            else
            {
               this.removeItemInLeftGrid(itemUID);
            }
            this.storageApi.removeItemMask(itemUID,"exchange");
         }
         this.storageApi.releaseHooks();
         this.checkAcceptButton();
         this.delayEnableValidateButton();
      }
      
      private function onExchangeKamaModified(kamas:Number, remote:Boolean) : void
      {
         if(remote)
         {
            this.lbl_kamaLeft.text = this.utilApi.kamasToString(kamas,"");
            this._leftPlayerKamaExchange = kamas;
            this.updateEstimatedValue(this._leftItems,this._leftPlayerKamaExchange,this.lbl_estimated_value_left);
            this.redWink(true);
         }
         else
         {
            if(this._cancelKamaModification)
            {
               return;
            }
            this.input_kamaRight.text = this.utilApi.kamasToString(kamas,"");
            this._rightPlayerKamaExchange = kamas;
            this.updateEstimatedValue(this._rightItems,this._rightPlayerKamaExchange,this.lbl_estimated_value_right);
         }
         this.checkAcceptButton();
         this.delayEnableValidateButton();
      }
      
      private function onExchangePodsModified(currentWeight:uint, maxWeight:uint, remote:Boolean) : void
      {
         if(remote)
         {
            this._leftCurrentPods = currentWeight;
            this._leftMaxPods = maxWeight;
         }
         else
         {
            this._rightCurrentPods = currentWeight;
            this._rightMaxPods = maxWeight;
         }
         this.updatePods();
         this.redPodsWink();
         this.delayEnableValidateButton();
      }
      
      public function onDoubleClickItemInventory(pItem:Object, pQuantity:int = 1) : void
      {
         this._waitingObject = pItem;
         this.onValidQty(pQuantity);
      }
      
      private function onValidQty(qty:Number) : void
      {
         this.sysApi.sendAction(new ExchangeObjectMoveAction([this._waitingObject.objectUID,qty]));
      }
      
      private function onAltValidQty(qty:Number) : void
      {
         this.sysApi.sendAction(new ExchangeObjectMoveAction([this._waitingObject.objectUID,-qty]));
      }
      
      private function onTimerPosButtons(pEvent:TimerEvent) : void
      {
         this.btn_validate.x = this._posXValid;
         this.btn_validate.y = this._posYValid;
         this.btn_cancel.x = this._posXCancel;
         this.btn_cancel.y = this._posYCancel;
         this._timerPosButtons.stop();
         this._timerPosButtons.removeEventListener(TimerEvent.TIMER,this.onTimerPosButtons);
         this._timerPosButtons = null;
      }
      
      private function onExchangeLeave(success:Boolean) : void
      {
         this._hasExchangeResult = true;
         this._success = success;
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      private function onDropEnd(src:GraphicContainer, target:Object) : void
      {
         if(!(target is GraphicContainer))
         {
            return;
         }
         if(target.getUi() == this.uiApi.me() && this._errorItem)
         {
            this.chatApi.sendErrorOnChat(this.uiApi.getText("ui.exchange.cantExchangeEquippedItem",this._errorItem.objectGID,this._errorItem.objectUID));
            this._errorItem = null;
         }
      }
   }
}
