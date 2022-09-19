package Ankama_Tutorial.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.data.Hook;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.GoToUrlAction;
   import com.ankamagames.dofus.logic.game.common.actions.NotificationUpdateFlagAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenBookAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenForgettableSpellsUiAction;
   import com.ankamagames.dofus.logic.game.common.actions.OpenSmileysAction;
   import com.ankamagames.dofus.logic.game.common.actions.SurveyNotificationAnswerAction;
   import com.ankamagames.dofus.logic.game.common.actions.breach.BreachInvitationAnswerAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.ArenaFightAnswerAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyAcceptInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyInvitationDetailsRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.PartyRefuseInvitationAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.TeleportToBuddyAnswerAction;
   import com.ankamagames.dofus.logic.game.common.actions.roleplay.JoinFightRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.havenbag.HavenbagInvitePlayerAnswerAction;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.utils.AbstractAction;
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.HighlightApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.QuestApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.system.ApplicationDomain;
   import flash.utils.getDefinitionByName;
   import flash.utils.getTimer;
   
   public class TipsUi
   {
      
      private static const MAX_VISIBLE_NOTIFICATION:uint = 3;
      
      private static const PADDING_BOTTOM:uint = 15;
      
      private static const NOTIFICATION_HEIGHT:uint = 55;
      
      private static const LUMINOSITY_EFFECTS:Array = [new ColorMatrixFilter([1.4,0,0,0,0,0,1.4,0,0,0,0,0,1.4,0,0,0,0,0,1,0])];
      
      private static const CTR_TEXT_MARGIN_TOP:uint = 0;
      
      private static const BACKGROUND_MESSAGE_GEIGHT_ADDITION:uint = 15;
      
      private static const BUTTON_ICON_MARGIN:uint = 5;
      
      private static const BUTTON_ICON_DEFAULT_SIZE:uint = 32;
      
      private static const GAIN_SPELL_LEVELUP_NOTIF_ID:uint = 11;
      
      private static var QUIET_MODE:Boolean = true;
       
      
      private var _include_action_PartyAction:PartyInvitationDetailsRequestAction;
      
      private var _include_action_PartyAcceptInvitation:PartyAcceptInvitationAction;
      
      private var _include_action_ArenaFightAnswer:ArenaFightAnswerAction;
      
      private var _include_action_TeleportToBuddyAnswer:TeleportToBuddyAnswerAction;
      
      private var _include_action_OpenSmileys:OpenSmileysAction;
      
      private var _include_action_OpenBook:OpenBookAction;
      
      private var _include_action_PartyRefuseInvitation:PartyRefuseInvitationAction;
      
      private var _include_action_NotificationUpdateFlag:NotificationUpdateFlagAction;
      
      private var _include_action_JoinFightRequest:JoinFightRequestAction;
      
      private var _include_action_HavenbagInvitePlayerAnswer:HavenbagInvitePlayerAnswerAction;
      
      private var _include_action_SurveyNotificationAnswer:SurveyNotificationAnswerAction;
      
      private var _include_action_GoToUrl:GoToUrlAction;
      
      private var _include_BreachInvitationAnswer:BreachInvitationAnswerAction;
      
      private var _include_OpenForgettableSpellsUi:OpenForgettableSpellsUiAction;
      
      private var _enabled:Boolean = true;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="HighlightApi")]
      public var highlightApi:HighlightApi;
      
      [Api(name="QuestApi")]
      public var questApi:QuestApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      public var ctr_main:GraphicContainer;
      
      public var ctr_visible:GraphicContainer;
      
      public var ctr_tips:GraphicContainer;
      
      public var ctr_text:GraphicContainer;
      
      public var ctr_down:GraphicContainer;
      
      public var ctr_nocheat:GraphicContainer;
      
      public var ctr_effect:GraphicContainer;
      
      public var mask_tips:GraphicContainer;
      
      public var btn_hide:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var ctr_background_message:GraphicContainer;
      
      public var tx_minMax:Texture;
      
      public var lbl_message:Label;
      
      public var lbl_title_message:Label;
      
      public var lbl_down:Label;
      
      private var _tipsList:Array;
      
      private var _currentTips:NotificationWrapper;
      
      private var _timerSlide:BenchmarkTimer;
      
      private var _btnListDisplay:Array;
      
      private var _imgListDisplay:Array;
      
      private var _noCheatTimer:BenchmarkTimer;
      
      private var _notificationsDisabled:Array;
      
      private var _contextualTipsList:Array;
      
      private var _triggersInit:Boolean = false;
      
      private var _tmpTimer:int = 0;
      
      private var _isUnloading:Boolean = false;
      
      public function TipsUi()
      {
         this._tipsList = [];
         this._timerSlide = new BenchmarkTimer(50,1,"TipsUi._timerSlide");
         this._btnListDisplay = [];
         this._imgListDisplay = [];
         this._noCheatTimer = new BenchmarkTimer(1000,1,"TipsUi._noCheatTimer");
         super();
      }
      
      public function main(param:Object) : void
      {
         this._isUnloading = false;
         this.sysApi.addHook(CustomUiHookList.FoldAll,this.onFoldAll);
         this.sysApi.addHook(ChatHookList.Notification,this.onNewNotification);
         this.sysApi.addHook(HookList.CloseNotification,this.onCloseNotification);
         this.sysApi.addHook(HookList.HideNotification,this.onHideNotification);
         this.uiApi.addComponentHook(this.lbl_message,"onTextClick");
         this.uiApi.addComponentHook(this.ctr_nocheat,"onRelease");
         this.uiApi.addComponentHook(this.ctr_visible,"onRollOver");
         this.uiApi.addComponentHook(this.ctr_visible,"onRollOut");
         this.ctr_tips.mask = this.mask_tips;
         this.checkQuietMode();
         this._timerSlide.addEventListener(TimerEvent.TIMER,this.showMessage);
         this._noCheatTimer.addEventListener(TimerEvent.TIMER,this.closeNoCheatContainer);
         if(param && param[0])
         {
            this.forceNewNotification(param[0]);
         }
      }
      
      public function checkQuietMode() : void
      {
         var activated:* = !this.sysApi.getOption("showNotifications","dofus");
         if(activated == QUIET_MODE)
         {
            return;
         }
         QUIET_MODE = activated;
         this._contextualTipsList = this.dataApi.getNotifications();
         this._notificationsDisabled = this.questApi.getNotificationList();
         if(this._notificationsDisabled)
         {
            this._triggersInit = false;
         }
         if(activated)
         {
            this.clearAllNotification(NotificationTypeEnum.TUTORIAL);
         }
         else if(!this._triggersInit)
         {
            this.initContextualHelpTriggers();
         }
      }
      
      public function resetTips(notifs:Array) : void
      {
         this._notificationsDisabled = notifs;
         this.clearAllNotification(NotificationTypeEnum.TUTORIAL);
         this.initContextualHelpTriggers();
      }
      
      public function unload() : void
      {
         this._isUnloading = true;
         this.updateTimer();
         this._timerSlide.removeEventListener(TimerEvent.TIMER,this.showMessage);
         this._noCheatTimer.removeEventListener(TimerEvent.TIMER,this.closeNoCheatContainer);
         this.sysApi.removeEventListener(this.onUpdateTimer);
      }
      
      private function addNewNotification(pNotification:NotificationWrapper) : void
      {
         if(QUIET_MODE && pNotification.type == NotificationTypeEnum.TUTORIAL)
         {
            return;
         }
         if(!this._enabled)
         {
            this.sendCallback(pNotification);
            return;
         }
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         if(!this.ctr_effect)
         {
            return;
         }
         this.ctr_effect.visible = true;
         this.btn_hide.visible = true;
         var oldNotif:NotificationWrapper = this.getNotificationByName(pNotification.name);
         if(oldNotif != null)
         {
            if(oldNotif.refreshWithoutCallback)
            {
               this.removeNotification(oldNotif,true);
            }
            else
            {
               this.removeNotification(oldNotif);
            }
         }
         this._tipsList = this.sortByPriority(this._tipsList,pNotification);
         this.updateVisibleNotification();
         this.configApi.setConfigProperty("dofus","resetNotifications",true);
      }
      
      private function sortByPriority(data:Array, pushValue:NotificationWrapper = null) : Array
      {
         var t:Object = null;
         var sortArray:Array = null;
         var type:uint = 0;
         var priorityArray:Array = [];
         for each(t in data)
         {
            if(priorityArray[t.type] == null)
            {
               priorityArray[t.type] = [];
            }
            priorityArray[t.type].push(t);
         }
         sortArray = [];
         for each(type in NotificationTypeEnum.NOTIFICATION_PRIORITY)
         {
            if(priorityArray[type])
            {
               if(pushValue != null && pushValue.type == type)
               {
                  sortArray.push(pushValue);
               }
               sortArray = sortArray.concat(priorityArray[type]);
            }
            else if(type == pushValue.type)
            {
               sortArray.push(pushValue);
            }
         }
         priorityArray = null;
         data = null;
         return sortArray.concat();
      }
      
      private function removeNotification(pNotification:NotificationWrapper, pBlockCallback:Boolean = false) : void
      {
         if(pNotification == null)
         {
            return;
         }
         if(!pBlockCallback)
         {
            this.sendCallback(pNotification);
         }
         if(pNotification.maskTimer)
         {
            pNotification.texture.removeChild(pNotification.maskTimer);
         }
         if(pNotification.tutorialId > 0)
         {
            this.sysApi.sendAction(new NotificationUpdateFlagAction([pNotification.tutorialId]));
         }
         if(pNotification == this._currentTips)
         {
            this.ctr_text.visible = false;
            this._currentTips = null;
            this.clearContainer();
         }
         if(pNotification.texture && pNotification.texture.parent == this.ctr_tips)
         {
            this.ctr_tips.removeChild(pNotification.texture);
         }
         this._tipsList.splice(this._tipsList.indexOf(pNotification),1);
         pNotification.texture = null;
         pNotification = null;
         if(this._tipsList.length <= 0)
         {
            this.ctr_effect.visible = false;
            this.ctr_visible.visible = false;
         }
         this.uiApi.hideTooltip();
         this._tmpTimer = 0;
         this.updateVisibleNotification();
         this.updateUi();
      }
      
      private function sendCallback(pNotification:NotificationWrapper) : Boolean
      {
         var apiAction:DofusApiAction = null;
         var action:AbstractAction = null;
         if(pNotification.callback)
         {
            if(pNotification.callbackType == "hook")
            {
               this.sysApi.dispatchHook(pNotification.callback,pNotification.callbackParams);
            }
            else if(pNotification.callbackType == "action")
            {
               apiAction = DofusApiAction.getApiActionByName(pNotification.callback);
               action = this.utilApi.callRWithParameters(apiAction.actionClass["create"],pNotification.callbackParams);
               this.sysApi.sendAction(action);
            }
            return true;
         }
         return false;
      }
      
      private function updateVisibleNotification() : void
      {
         var i:uint = 0;
         var notif:NotificationWrapper = null;
         var timerInit:Boolean = false;
         var openFirst:Boolean = true;
         for(i = 0; i < this._tipsList.length; i++)
         {
            notif = this._tipsList[i];
            if(i < MAX_VISIBLE_NOTIFICATION)
            {
               if(notif.texture == null)
               {
                  this.createNotificationTexture(notif);
                  timerInit = this.initTimer(notif);
                  if(timerInit)
                  {
                     openFirst = true;
                  }
               }
               else
               {
                  notif.texture.visible = true;
                  this.ctr_tips.addChild(notif.texture);
                  this.slide(notif.texture,0,i * NOTIFICATION_HEIGHT,500);
                  if(notif == this._currentTips)
                  {
                     this.slide(this.ctr_text,this.ctr_text.x,CTR_TEXT_MARGIN_TOP + i * NOTIFICATION_HEIGHT,500);
                  }
               }
            }
            else if(notif == this._currentTips)
            {
               this.ctr_text.visible = false;
               notif.texture.filters = null;
               notif.texture.visible = false;
               this._currentTips = null;
               openFirst = true;
            }
         }
         if(this._currentTips == null && openFirst)
         {
            this._currentTips = this._tipsList[0];
            this.showMessage();
         }
      }
      
      private function initTimer(pNotification:NotificationWrapper) : Boolean
      {
         var mask:Shape = null;
         if(pNotification.hasTimer && !pNotification.startTime)
         {
            if(pNotification.texture)
            {
               mask = new Shape();
               mask.graphics.beginFill(0,0.6);
               mask.graphics.drawRect(0,0,pNotification.texture.width,pNotification.texture.height);
               mask.graphics.endFill();
               pNotification.maskTimer = mask;
               pNotification.texture.addChild(mask);
            }
            pNotification.startTime = getTimer();
            this.sysApi.addEventListener(this.onUpdateTimer,"timerComplete");
            return true;
         }
         return false;
      }
      
      private function openNotification(pNotificationId:uint) : void
      {
         if(pNotificationId != this._tipsList.indexOf(this._currentTips))
         {
            this.hideNotification(this._currentTips);
         }
      }
      
      private function hideNotification(pNotification:NotificationWrapper) : void
      {
         if(pNotification == null || pNotification.texture == null)
         {
            return;
         }
         pNotification.texture.filters = null;
         if(pNotification == this._currentTips)
         {
            this._currentTips = null;
         }
         if(this.ctr_text.visible)
         {
            this.ctr_text.visible = false;
         }
      }
      
      private function getNotificationByName(pName:String) : NotificationWrapper
      {
         var i:uint = 0;
         var len:uint = this._tipsList.length;
         for(i = 0; i < len; i += 1)
         {
            if(this._tipsList[i].name == pName)
            {
               return this._tipsList[i];
            }
         }
         return null;
      }
      
      private function getNotificationData(tx:Texture) : NotificationWrapper
      {
         var i:uint = 0;
         var len:uint = this._tipsList.length;
         for(i = 0; i < len; i += 1)
         {
            if(this._tipsList[i].texture != null && this._tipsList[i].texture == tx)
            {
               return this._tipsList[i];
            }
         }
         return null;
      }
      
      private function hideAll() : void
      {
         this.ctr_visible.visible = false;
         this.tx_minMax.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "hud/icon_plus_floating_menu.png");
      }
      
      private function showAll() : void
      {
         this.ctr_visible.visible = true;
         this.tx_minMax.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "hud/icon_minus_floating_menu.png");
      }
      
      private function showMessage(pEvt:TimerEvent = null) : void
      {
         var i:int = 0;
         var len:int = 0;
         this._timerSlide.reset();
         if(this._currentTips == null || this.ctr_text == null)
         {
            return;
         }
         this.clearContainer();
         this.ctr_text.visible = true;
         this.ctr_effect.visible = true;
         this.lbl_message.height = 0;
         this.lbl_title_message.height = 0;
         this.ctr_background_message.height = 0;
         this.lbl_title_message.text = this._currentTips.title;
         this.lbl_message.text = this._currentTips.contentText;
         this.lbl_title_message.selectable = this._currentTips.type == NotificationTypeEnum.ERROR;
         this.lbl_message.selectable = this._currentTips.type == NotificationTypeEnum.ERROR;
         this.lbl_title_message.fixedWidth = true;
         this.lbl_title_message.width = 240;
         this.lbl_message.fullSize(300);
         this.ctr_background_message.height = this.lbl_message.textHeight + this.lbl_title_message.y + this.lbl_title_message.textHeight + PADDING_BOTTOM + BACKGROUND_MESSAGE_GEIGHT_ADDITION;
         this.slide(this.ctr_text,this.ctr_text.x,CTR_TEXT_MARGIN_TOP + this._tipsList.indexOf(this._currentTips) * NOTIFICATION_HEIGHT,0);
         this._currentTips.texture.filters = LUMINOSITY_EFFECTS;
         if(this._currentTips.imageList && this._currentTips.imageList.length > 0)
         {
            len = this._currentTips.imageList.length;
            for(i = 0; i < len; i++)
            {
               this.addImageToContainer(this._currentTips.imageList[i]);
            }
         }
         if(this._currentTips.buttonList && this._currentTips.buttonList.length > 0)
         {
            len = this._currentTips.buttonList.length;
            for(i = 0; i < len; i++)
            {
               this.addBtnToContainer(this._currentTips.buttonList[i],i);
            }
            this.ctr_background_message.height += this._currentTips.buttonList[0].height + 10 + BACKGROUND_MESSAGE_GEIGHT_ADDITION;
         }
         this.updateUi();
      }
      
      private function startAnim(tips:NotificationWrapper) : void
      {
         var tipsIndex:uint = this._tipsList.indexOf(tips);
         this.slide(tips.texture,0,tipsIndex * NOTIFICATION_HEIGHT,500);
         if(tipsIndex + 1 >= MAX_VISIBLE_NOTIFICATION)
         {
            tips.texture.visible = false;
            if(tips == this._currentTips)
            {
               this._currentTips = null;
               this.ctr_visible.visible = false;
            }
         }
         else if(tips == this._currentTips)
         {
            this._timerSlide.start();
         }
         else
         {
            this.updateUi();
         }
      }
      
      private function clearAllNotification(pType:int = -1) : void
      {
         var notif:NotificationWrapper = null;
         var tmp:Array = this._tipsList.concat();
         for each(notif in tmp)
         {
            if(notif.type == pType || pType == -1)
            {
               if(notif == this._currentTips)
               {
                  this.ctr_text.visible = false;
               }
               this.removeNotification(notif);
            }
         }
         if(pType == NotificationTypeEnum.TUTORIAL)
         {
            this.clearTutorialTriggers();
         }
      }
      
      private function getVisibleNotificationNumber() : uint
      {
         return this._tipsList.length > MAX_VISIBLE_NOTIFICATION ? uint(MAX_VISIBLE_NOTIFICATION) : uint(this._tipsList.length);
      }
      
      private function slide(tx:GraphicContainer, posX:Number, posY:Number, time:uint = 500) : void
      {
         tx.y = posY;
         tx.x = posX;
      }
      
      private function onFoldAll(folded:Boolean) : void
      {
         if(this._tipsList.length == 0)
         {
            return;
         }
         if(folded)
         {
            this.hideAll();
         }
         else
         {
            this.showAll();
         }
      }
      
      private function onNewNotification(pNotification:Object) : void
      {
         this.addNewNotification(NotificationWrapper.create(pNotification));
      }
      
      private function onCloseNotification(pName:String, pBlockCallback:Boolean = false) : void
      {
         var notif:NotificationWrapper = this.getNotificationByName(pName);
         if(notif != null)
         {
            this.soundApi.playSound(SoundTypeEnum.CLOSE_WINDOW);
            this.removeNotification(notif,pBlockCallback);
         }
      }
      
      private function onHideNotification(pName:String) : void
      {
         this.hideNotification(this.getNotificationByName(pName));
      }
      
      private function onUpdateTimer(e:Event) : void
      {
         this.updateTimer();
      }
      
      private function updateTimer() : void
      {
         var tips:NotificationWrapper = null;
         var currentTime:int = 0;
         var totalTime:int = 0;
         var perc:Number = NaN;
         for each(tips in this._tipsList)
         {
            if(tips.duration > 0)
            {
               if(!(this._currentTips == tips && this._tmpTimer > 0))
               {
                  currentTime = getTimer();
                  totalTime = tips.startTime + tips.duration;
                  if(this._isUnloading || currentTime > totalTime)
                  {
                     this.removeNotification(tips,tips.blockCallbackOnTimerEnds);
                  }
                  else
                  {
                     perc = (currentTime - tips.startTime) / (totalTime - tips.startTime);
                     tips.maskTimer.height = tips.texture.height * perc;
                     tips.maskTimer.y = tips.texture.height - tips.maskTimer.height;
                  }
               }
            }
         }
         if(this._isUnloading || this._tipsList.length == 0)
         {
            this.sysApi.removeEventListener(this.onUpdateTimer);
         }
      }
      
      private function closeNoCheatContainer(pEvt:TimerEvent) : void
      {
         this.ctr_nocheat.visible = false;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var notif:NotificationWrapper = null;
         var btn:Object = null;
         var apiAction:DofusApiAction = null;
         var action:AbstractAction = null;
         switch(target)
         {
            case this.btn_close:
               this.ctr_nocheat.visible = true;
               this._noCheatTimer.reset();
               this._noCheatTimer.start();
               this.removeNotification(this._currentTips);
               break;
            case this.btn_hide:
               if(this.ctr_visible.visible)
               {
                  this.hideAll();
               }
               else
               {
                  this.showAll();
               }
               break;
            case this.ctr_nocheat:
               return;
            default:
               if(this._btnListDisplay.indexOf(target) != -1)
               {
                  btn = this._currentTips.buttonList[this._btnListDisplay.indexOf(target)];
                  if(btn.actionType == "action")
                  {
                     apiAction = DofusApiAction.getApiActionByName(btn.action);
                     action = this.utilApi.callRWithParameters(apiAction.actionClass["create"],btn.params);
                     this.sysApi.sendAction(action);
                  }
                  else if(btn.actionType == "hook")
                  {
                     if(btn.params == null)
                     {
                        this.sysApi.dispatchHook(btn.action);
                     }
                     else
                     {
                        switch(btn.params.length)
                        {
                           case 1:
                              this.sysApi.dispatchHook(btn.action,btn.params[0]);
                              break;
                           case 2:
                              this.sysApi.dispatchHook(btn.action,btn.params[0],btn.params[1]);
                              break;
                           case 3:
                              this.sysApi.dispatchHook(btn.action,btn.params[0],btn.params[1],btn.params[2]);
                              break;
                           case 4:
                              this.sysApi.dispatchHook(btn.action,btn.params[0],btn.params[1],btn.params[2],btn.params[3]);
                              break;
                           case 5:
                              this.sysApi.dispatchHook(btn.action,btn.params[0],btn.params[1],btn.params[2],btn.params[3],btn.params[4]);
                              break;
                           case 6:
                              this.sysApi.dispatchHook(btn.action,btn.params[0],btn.params[1],btn.params[2],btn.params[3],btn.params[4],btn.params[5]);
                              break;
                           case 7:
                              this.sysApi.dispatchHook(btn.action,btn.params[0],btn.params[1],btn.params[2],btn.params[3],btn.params[4],btn.params[5],btn.params[6]);
                              break;
                           case 8:
                              this.sysApi.dispatchHook(btn.action,btn.params[0],btn.params[1],btn.params[2],btn.params[3],btn.params[4],btn.params[5],btn.params[6],btn.params[7]);
                        }
                     }
                  }
                  if(btn.forceClose)
                  {
                     this.removeNotification(this._currentTips,true);
                  }
                  return;
               }
               notif = this.getNotificationData(target as Texture);
               if(notif)
               {
                  if(notif != this._currentTips)
                  {
                     this.uiApi.hideTooltip();
                     if(this._currentTips != null)
                     {
                        this.hideNotification(this._currentTips);
                     }
                     this._currentTips = notif;
                     this.showMessage();
                  }
                  else
                  {
                     this.hideNotification(notif);
                  }
                  return;
               }
               break;
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var notif:NotificationWrapper = null;
         var img:Object = null;
         if(target == this.ctr_visible)
         {
            if(this._currentTips != null && this._currentTips.duration > 0 && this._currentTips.pauseOnOver && this._tmpTimer == 0)
            {
               this._tmpTimer = getTimer();
            }
         }
         else
         {
            notif = this.getNotificationData(target as Texture);
            if(notif)
            {
               if(notif != this._currentTips)
               {
                  this.uiApi.showTooltip(this.uiApi.textTooltipInfo(notif.title),target,false,"standard",3,5,3,null,null,null,"TextInfo");
               }
            }
            else if(this._currentTips && this._imgListDisplay.indexOf(target) != -1)
            {
               img = this._currentTips.imageList[this._imgListDisplay.indexOf(target)];
               if(img)
               {
                  this.uiApi.showTooltip(this.uiApi.textTooltipInfo(img.tips),target,false,"standard",3,5,3,null,null,null,"TextInfo");
               }
            }
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.ctr_visible:
               if(this._currentTips != null && this._currentTips.duration > 0 && this._currentTips.pauseOnOver)
               {
                  this._currentTips.startTime += getTimer() - this._tmpTimer;
                  this._tmpTimer = 0;
               }
               break;
            default:
               this.uiApi.hideTooltip();
         }
      }
      
      public function onMiddleClick(target:GraphicContainer) : void
      {
         var notif:NotificationWrapper = this.getNotificationData(target as Texture);
         if(notif)
         {
            this.removeNotification(notif);
         }
      }
      
      public function onTextClick(target:GraphicContainer, textEvent:String) : void
      {
         var infos:Array = null;
         var action:AbstractAction = null;
         if(target == this.lbl_message)
         {
            if(textEvent.indexOf("sendaction") == 0)
            {
               infos = textEvent.split(",");
               infos.splice(0,2);
               action = this.utilApi.callConstructorWithParameters(getDefinitionByName(infos[1]) as Class,infos);
               this.sysApi.sendAction(action);
            }
         }
      }
      
      public function forceNewNotification(pNotification:Object) : void
      {
         this.onNewNotification(pNotification);
      }
      
      private function createNotificationTexture(pNotification:NotificationWrapper) : void
      {
         this.ctr_main.visible = true;
         this.ctr_visible.visible = true;
         this.ctr_tips.visible = true;
         this.btn_hide.visible = true;
         var tx:Texture = this.uiApi.createComponent("Texture") as Texture;
         tx.name = "tips" + this._tipsList.indexOf(pNotification);
         tx.mouseEnabled = true;
         tx.cacheAsBitmap = true;
         tx.buttonMode = true;
         tx.useHandCursor = true;
         var typeIcon:int = pNotification.type;
         if(typeIcon == NotificationTypeEnum.SERVER_INFORMATION)
         {
            typeIcon = NotificationTypeEnum.TUTORIAL;
         }
         tx.uri = this.uiApi.createUri(this.uiApi.me().getConstant("assets") + "tips_icon" + typeIcon);
         this.uiApi.addComponentHook(tx,"onRelease");
         this.uiApi.addComponentHook(tx,"onRollOver");
         this.uiApi.addComponentHook(tx,"onRollOut");
         this.uiApi.addComponentHook(tx,"onMiddleClick");
         tx.finalize();
         pNotification.texture = tx;
         this.ctr_tips.addChild(tx);
         tx.visible = true;
         tx.y = 25 + this.getVisibleNotificationNumber() * NOTIFICATION_HEIGHT + 10;
         tx.x = 0;
         if(this._tipsList.length == 1)
         {
            this._currentTips = pNotification;
         }
         this.startAnim(pNotification);
      }
      
      private function addBtnToContainer(pData:Object, pPos:int) : void
      {
         var btn:ButtonContainer = null;
         var btnTx:TextureBitmap = null;
         var icnTx:TextureBitmap = null;
         var btnLbl:Label = null;
         var icnSize:uint = 0;
         var padding:uint = this.uiApi.me().getConstant("buttonPadding");
         var marginTop:uint = this.uiApi.me().getConstant("buttonMarginTop");
         var sideMargin:uint = this.uiApi.me().getConstant("buttonSideMargin");
         var numberButton:int = this._currentTips.buttonList.length;
         btn = this.uiApi.createContainer("ButtonContainer") as ButtonContainer;
         btn.width = pData.width;
         btn.height = pData.height;
         btn.x = (this.ctr_background_message.width - pData.width * numberButton - padding * numberButton) / 2 + (pData.width + padding) * pPos + sideMargin;
         btn.y = this.ctr_background_message.height;
         btn.name = pData.name;
         btn.finalize();
         btnTx = this.uiApi.createComponent("TextureBitmap") as TextureBitmap;
         btnTx.width = pData.width;
         btnTx.height = pData.height;
         btnTx.themeDataId = "button_normal";
         btnTx.name = btn.name + "_tx";
         btnTx.finalize();
         if(pData.icnDataId)
         {
            icnTx = this.uiApi.createComponent("TextureBitmap") as TextureBitmap;
            icnTx.themeDataId = pData.icnDataId;
            icnTx.name = btn.name + "_icn_tx";
            icnSize = pData.icnSize != 0 ? uint(pData.icnSize) : uint(BUTTON_ICON_DEFAULT_SIZE);
            icnTx.width = icnSize;
            icnTx.height = icnSize;
            icnTx.x = btn.width - (icnTx.width + BUTTON_ICON_MARGIN);
            icnTx.y = btn.height / 2 - icnTx.height / 2;
            icnTx.finalize();
         }
         btnLbl = this.uiApi.createComponent("Label") as Label;
         btnLbl.width = !!pData.icnDataId ? Number(pData.width - (icnTx.width + BUTTON_ICON_MARGIN)) : Number(pData.width);
         btnLbl.height = pData.height;
         btnLbl.verticalAlign = "center";
         btnLbl.css = this.uiApi.createUri(this.uiApi.me().getConstant("btn.css"));
         btnLbl.text = this.uiApi.replaceKey(pData.label);
         var stateChangingProperties:Array = [];
         stateChangingProperties[1] = [];
         stateChangingProperties[1][btnTx.name] = [];
         stateChangingProperties[1][btnTx.name]["themeDataId"] = "button_over";
         stateChangingProperties[2] = [];
         stateChangingProperties[2][btnTx.name] = [];
         stateChangingProperties[2][btnTx.name]["themeDataId"] = "button_pressed";
         btn.changingStateData = stateChangingProperties;
         btn.addChild(btnTx);
         btn.addChild(btnLbl);
         if(pData.icnDataId)
         {
            btn.addChild(icnTx);
         }
         this.uiApi.addComponentHook(btn,"onRelease");
         this._btnListDisplay.push(btn);
         this.ctr_text.addChild(btn);
      }
      
      private function addImageToContainer(pData:Object) : void
      {
         var marginTop:int = 0;
         var dataIndex:int = 0;
         var lbl:Label = null;
         var img:Texture = this.uiApi.createComponent("Texture") as Texture;
         img.uri = pData.uri;
         if(pData.width > 0)
         {
            img.width = pData.width;
         }
         if(pData.height > 0)
         {
            img.height = pData.height;
         }
         if(pData.horizontalAlign)
         {
            img.x = (this.ctr_background_message.width - img.width) / 2;
         }
         else
         {
            img.x = img.width / 2 + 5;
         }
         if(pData.verticalAlign)
         {
            marginTop = 10;
            dataIndex = this._imgListDisplay.indexOf(pData);
            img.y = this.lbl_message.height + this.lbl_message.y + (dataIndex > 0 ? this._imgListDisplay[this._imgListDisplay.indexOf(pData) - 1].y + this._imgListDisplay[this._imgListDisplay.indexOf(pData) - 1].height + marginTop : 1);
         }
         else
         {
            img.y = pData.y;
         }
         if(pData.tips != "")
         {
            img.buttonMode = true;
            this.uiApi.addComponentHook(img,"onRollOver");
            this.uiApi.addComponentHook(img,"onRollOut");
         }
         img.finalize();
         this.ctr_background_message.height += img.height + marginTop + BACKGROUND_MESSAGE_GEIGHT_ADDITION;
         if(pData.label != "")
         {
            lbl = this.uiApi.createComponent("Label") as Label;
            lbl.text = pData.label;
            lbl.css = this.uiApi.createUri(this.uiApi.me().getConstant("css") + "normal.css");
            lbl.x = img.x + img.contentWidth / 2;
            lbl.y = (img.contentHeight - lbl.textHeight) / 2;
            img.addChild(lbl);
         }
         this._imgListDisplay.push(img);
         this.ctr_text.addChild(img);
      }
      
      private function clearContainer() : void
      {
         var btn:* = undefined;
         var img:* = undefined;
         for each(btn in this._btnListDisplay)
         {
            this.ctr_text.removeChild(btn);
         }
         this._btnListDisplay = [];
         for each(img in this._imgListDisplay)
         {
            this.ctr_text.removeChild(img);
         }
         this._imgListDisplay = [];
      }
      
      private function updateUi() : void
      {
         var h:uint = 0;
         if(this._tipsList.length > 0)
         {
            h = 25 + this.getVisibleNotificationNumber() * NOTIFICATION_HEIGHT;
            this.ctr_down.y = h;
            this.mask_tips.height = h;
         }
         this.lbl_down.text = this._tipsList.length.toString();
         this.uiApi.me().render();
      }
      
      private function initContextualHelpTriggers() : void
      {
         var hookFunction:Function = null;
         var n:Object = null;
         var hookName:String = null;
         for each(n in this._contextualTipsList)
         {
            if(n && n.trigger && !this._notificationsDisabled[n.id])
            {
               hookName = this.getHookName(n.trigger);
               if(Hook.checkIfHookExists(hookName))
               {
                  hookFunction = this.createHook(n.title,n.message,"contextualHelp_" + n.id,hookName,n.id);
                  this.sysApi.addHook(hookName,hookFunction);
                  if(hookName == "GameStart")
                  {
                     hookFunction();
                  }
               }
               else
               {
                  this.sysApi.log(1,"Impossible d\'écouter le hook " + hookName + " pour l\'interface de tips (hook non existant)");
               }
            }
         }
         this._triggersInit = true;
      }
      
      private function getHookName(trigger:String) : String
      {
         var hookInfo:Array = trigger.split(",");
         return hookInfo[0];
      }
      
      private function createHook(pTitle:String, pMessage:String, pName:String, pHookName:String, pId:int) : Function
      {
         return function(... args):void
         {
            if(pId == 10 && playerApi.getPlayedCharacterInfo().level > ProtocolConstantsEnum.MAX_LEVEL || playerApi.isInTutorialArea() || pId == GAIN_SPELL_LEVELUP_NOTIF_ID && dataApi.getCurrentTemporisSeasonNumber() == 4)
            {
               return;
            }
            var tutoNotif:* = {};
            tutoNotif.title = pTitle;
            tutoNotif.contentText = pMessage;
            tutoNotif.name = pName;
            tutoNotif.type = NotificationTypeEnum.TUTORIAL;
            tutoNotif.tutorialId = pId;
            forceNewNotification(tutoNotif);
            sysApi.removeHook(pHookName);
         };
      }
      
      private function clearTutorialTriggers() : void
      {
         var n:Object = null;
         var hookName:String = null;
         for each(n in this._contextualTipsList)
         {
            if(n.trigger)
            {
               hookName = this.getHookName(n.trigger);
               if(ApplicationDomain.currentDomain.hasDefinition(hookName))
               {
                  this.sysApi.removeHook(hookName);
               }
            }
         }
         this._triggersInit = false;
      }
      
      public function activate() : void
      {
         this._enabled = true;
      }
      
      public function deactivate() : void
      {
         this.clearAllNotification();
         this._enabled = false;
      }
   }
}

import com.ankamagames.berilia.components.Texture;
import flash.display.Shape;

class NotificationWrapper
{
    
   
   public var callback:String;
   
   public var callbackType:String;
   
   public var callbackParams:Array;
   
   public var refreshWithoutCallback:Boolean;
   
   public var texture:Texture;
   
   public var maskTimer:Shape;
   
   public var duration:int;
   
   public var startTime:int;
   
   public var pauseOnOver:Boolean;
   
   public var title:String;
   
   public var contentText:String;
   
   public var type:int;
   
   public var name:String;
   
   public var buttonList:Array;
   
   public var imageList:Array;
   
   public var tutorialId:int;
   
   public var blockCallbackOnTimerEnds:Boolean;
   
   function NotificationWrapper()
   {
      super();
   }
   
   public static function create(data:Object) : NotificationWrapper
   {
      var b:Object = null;
      var i:Object = null;
      var notif:NotificationWrapper = new NotificationWrapper();
      notif.callback = data.callback;
      notif.callbackType = data.callbackType;
      notif.callbackParams = data.callbackParams;
      notif.texture = data.texture;
      notif.duration = data.duration;
      notif.startTime = data.startTime;
      notif.pauseOnOver = data.pauseOnOver;
      notif.title = data.title;
      if(data.contentText.length > 1000)
      {
         notif.contentText = data.contentText.substr(0,1000) + "...";
      }
      else
      {
         notif.contentText = data.contentText;
      }
      notif.name = data.name;
      notif.tutorialId = data.tutorialId;
      notif.refreshWithoutCallback = data.refreshWithoutCallback;
      notif.buttonList = [];
      for each(b in data.buttonList)
      {
         notif.buttonList.push(b);
      }
      notif.imageList = [];
      for each(i in data.imageList)
      {
         notif.imageList.push(i);
      }
      notif.type = data.type;
      notif.blockCallbackOnTimerEnds = data.blockCallbackOnTimerEnds;
      return notif;
   }
   
   public function get hasTimer() : Boolean
   {
      return this.duration && this.duration > 0;
   }
}
