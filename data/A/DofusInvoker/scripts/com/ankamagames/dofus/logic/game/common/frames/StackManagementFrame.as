package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.managers.EntitiesDisplayManager;
   import com.ankamagames.atouin.messages.AdjacentMapClickMessage;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.actions.AddBehaviorToStackAction;
   import com.ankamagames.dofus.logic.common.actions.EmptyStackAction;
   import com.ankamagames.dofus.logic.common.actions.RemoveBehaviorToStackAction;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.common.misc.stackedMessages.AbstractBehavior;
   import com.ankamagames.dofus.logic.game.common.misc.stackedMessages.ChangeMapBehavior;
   import com.ankamagames.dofus.logic.game.common.misc.stackedMessages.InteractiveElementBehavior;
   import com.ankamagames.dofus.logic.game.common.misc.stackedMessages.MoveBehavior;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementActivationMessage;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.network.enums.GameContextEnum;
   import com.ankamagames.dofus.network.messages.game.context.GameContextCreateMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.emote.EmotePlayMessage;
   import com.ankamagames.dofus.types.entities.CheckPointEntity;
   import com.ankamagames.dofus.types.enums.StackActionEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.utils.display.KeyPoll;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.utils.getQualifiedClassName;
   
   public class StackManagementFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(StackManagementFrame));
      
      private static const LIMIT:int = 100;
      
      private static const KEY_CODE:uint = 16;
      
      private static const BEHAVIOR_LIST:Array = [MoveBehavior,InteractiveElementBehavior,ChangeMapBehavior];
      
      private static const ACTION_MESSAGES:Array = ["InteractiveElementActivationMessage","CellClickMessage","AdjacentMapClickMessage"];
       
      
      private var _stackInputMessage:Vector.<AbstractBehavior>;
      
      private var _stackOutputMessage:Vector.<AbstractBehavior>;
      
      private var _stopMessages:Vector.<String>;
      
      private var _unnoticeableMessages:Vector.<String>;
      
      private var _ignoredMsg:Vector.<Message>;
      
      private var _checkPointList:Vector.<CheckPointEntity>;
      
      private var _currentMode:String;
      
      private var _ignoreAllMessages:Boolean = false;
      
      private var _limitReached:Boolean = false;
      
      private var _keyDown:Boolean = false;
      
      private var _paused:Boolean = false;
      
      private var _waitingMessage:Message;
      
      private var _enabled:Boolean;
      
      private var _wasInFight:Boolean;
      
      public function StackManagementFrame()
      {
         super();
         this.initStackInputMessages(AbstractBehavior.ALWAYS);
         this._checkPointList = new Vector.<CheckPointEntity>();
         this._ignoredMsg = new Vector.<Message>();
         this._stackOutputMessage = new Vector.<AbstractBehavior>();
         this.initStopMessages();
         this._enabled = true;
      }
      
      private function onActivate(pEvt:Event) : void
      {
         if(!KeyPoll.getInstance().isDown(KEY_CODE) && this._keyDown)
         {
            this.onKeyUp(null);
         }
      }
      
      public function onKeyDown(pEvt:KeyboardEvent) : void
      {
         var m:AddBehaviorToStackAction = null;
         if(this._enabled && !this._keyDown && pEvt.keyCode == KEY_CODE)
         {
            this._keyDown = true;
            this.initStackInputMessages(AbstractBehavior.NORMAL);
            m = AddBehaviorToStackAction.create([StackActionEnum.MOVE,StackActionEnum.HARVEST]);
            Kernel.getWorker().process(m);
         }
      }
      
      public function onKeyUp(pEvt:KeyboardEvent = null) : void
      {
         var m:RemoveBehaviorToStackAction = null;
         var keyCode:uint = pEvt == null ? uint(KEY_CODE) : uint(pEvt.keyCode);
         if(this._keyDown && keyCode == KEY_CODE)
         {
            this._keyDown = false;
            m = new RemoveBehaviorToStackAction();
            m.behavior = StackActionEnum.REMOVE_ALL;
            Kernel.getWorker().process(m);
         }
      }
      
      private function getInputMessageAlreadyWatched(vector:Vector.<AbstractBehavior>, inpt:Class) : AbstractBehavior
      {
         var oldInput:AbstractBehavior = null;
         var behaviorStr:String = getQualifiedClassName(inpt);
         for each(oldInput in vector)
         {
            if(getQualifiedClassName(oldInput) == behaviorStr)
            {
               return oldInput;
            }
         }
         return null;
      }
      
      private function initStackInputMessages(newMode:String) : void
      {
         var c:Class = null;
         var b:AbstractBehavior = null;
         var tmp:AbstractBehavior = null;
         var tmpVector:Vector.<AbstractBehavior> = new Vector.<AbstractBehavior>();
         if(this._stackInputMessage != null)
         {
            tmpVector = this._stackInputMessage.concat();
         }
         this._stackInputMessage = new Vector.<AbstractBehavior>();
         for each(c in BEHAVIOR_LIST)
         {
            b = new c();
            if(newMode == AbstractBehavior.NORMAL || newMode == AbstractBehavior.ALWAYS && b.type == AbstractBehavior.ALWAYS)
            {
               tmp = this.getInputMessageAlreadyWatched(tmpVector,c);
               if(tmp != null)
               {
                  this._stackInputMessage.push(tmp);
               }
               else
               {
                  this.addBehaviorToInputStack(b,true);
               }
            }
            else
            {
               this.addBehaviorToInputStack(b,false);
            }
         }
         this._currentMode = newMode;
      }
      
      private function initStopMessages() : void
      {
         this._stopMessages = new Vector.<String>();
         this._stopMessages.push("NpcDialogCreationMessage");
         this._stopMessages.push("GameFightStartingMessage");
         this._stopMessages.push("DocumentReadingBeginMessage");
         this._stopMessages.push("LockableShowCodeDialogMessage");
         this._stopMessages.push("PaddockSellBuyDialogMessage");
         this._stopMessages.push("ExchangeStartedMessage");
         this._stopMessages.push("ExchangeStartOkCraftWithInformationMessage");
         this._stopMessages.push("ExchangeStartOkJobIndexMessage");
         this._stopMessages.push("EmotePlayMessage");
         this._stopMessages.push("GameMapNoMovementMessage");
         this._stopMessages.push("CheckFileRequestMessage");
         this._unnoticeableMessages = new Vector.<String>();
         this._unnoticeableMessages.push("MouseOverMessage");
         this._unnoticeableMessages.push("MouseOutMessage");
         this._unnoticeableMessages.push("EntityMouseOverMessage");
         this._unnoticeableMessages.push("EntityMouseOutMessage");
         this._unnoticeableMessages.push("MapContainerRollOutMessage");
         this._unnoticeableMessages.push("MapContainerRollOverMessage");
         this._unnoticeableMessages.push("InteractiveElementMouseOverMessage");
         this._unnoticeableMessages.push("InteractiveElementMouseOutMessage");
         this._unnoticeableMessages.push("ItemRollOverMessage");
         this._unnoticeableMessages.push("ItemRollOutMessage");
         this._unnoticeableMessages.push("AdjacentMapOverMessage");
         this._unnoticeableMessages.push("AdjacentMapOutMessage");
         this._unnoticeableMessages.push("MouseDownMessage");
         this._unnoticeableMessages.push("MouseUpMessage");
         this._unnoticeableMessages.push("MouseClickMessage");
         this._unnoticeableMessages.push("FocusChangeMessage");
         this._unnoticeableMessages.push("TextureReadyMessage");
         this._unnoticeableMessages.push("MapRenderProgressMessage");
         this._unnoticeableMessages.push("TextInformationMessage");
         this._unnoticeableMessages.push("RawDataMessage");
      }
      
      public function pushed() : Boolean
      {
         StageShareManager.stage.addEventListener(Event.ACTIVATE,this.onActivate);
         StageShareManager.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         StageShareManager.stage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         return true;
      }
      
      public function pulled() : Boolean
      {
         StageShareManager.stage.removeEventListener(Event.ACTIVATE,this.onActivate);
         StageShareManager.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
         StageShareManager.stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.onKeyDown);
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var gccmsg:GameContextCreateMessage = null;
         var elem:AbstractBehavior = null;
         var abtsmsg:AddBehaviorToStackAction = null;
         var rbtsmsg:RemoveBehaviorToStackAction = null;
         var msgClassName:String = null;
         var ieNotAvailableAnymore:Boolean = false;
         var catchInputMsg:Boolean = false;
         var catchOutputMsg:Boolean = false;
         var b:String = null;
         var behavior:AbstractBehavior = null;
         var moveBehavior:MoveBehavior = null;
         var changeMapBehavior:ChangeMapBehavior = null;
         var ieBehavior:InteractiveElementBehavior = null;
         var ieBehaviorIndex:int = 0;
         var ieam:InteractiveElementActivationMessage = null;
         var behaviour:AbstractBehavior = null;
         var stop:Boolean = false;
         if(msg is GameContextCreateMessage)
         {
            gccmsg = msg as GameContextCreateMessage;
            if(gccmsg.context == GameContextEnum.FIGHT)
            {
               this.stopWatchingActions();
               for each(elem in this._stackOutputMessage)
               {
                  this.removeCheckPoint(elem);
               }
               this._ignoredMsg = new Vector.<Message>();
               this._ignoreAllMessages = false;
               this._limitReached = false;
               this._keyDown = false;
               this._enabled = false;
               this._wasInFight = true;
            }
            else if(gccmsg.context == GameContextEnum.ROLE_PLAY)
            {
               this._enabled = true;
            }
         }
         if(!this._enabled)
         {
            return false;
         }
         switch(true)
         {
            case msg is AddBehaviorToStackAction:
               abtsmsg = msg as AddBehaviorToStackAction;
               for each(b in abtsmsg.behavior)
               {
                  switch(b)
                  {
                     case StackActionEnum.MOVE:
                        this.addBehaviorToInputStack(new MoveBehavior());
                        this.addBehaviorToInputStack(new ChangeMapBehavior());
                        break;
                     case StackActionEnum.HARVEST:
                        this.addBehaviorToInputStack(new InteractiveElementBehavior());
                        break;
                  }
               }
               return true;
            case msg is RemoveBehaviorToStackAction:
               rbtsmsg = msg as RemoveBehaviorToStackAction;
               switch(rbtsmsg.behavior)
               {
                  case StackActionEnum.REMOVE_ALL:
                     this.stopWatchingActions();
               }
               return true;
            case msg is EmptyStackAction:
               this.emptyStack();
               return true;
            default:
               msgClassName = getQualifiedClassName(msg).split("::")[1];
               ieNotAvailableAnymore = msgClassName == "InteractiveUsedMessage" || msgClassName == "InteractiveUseErrorMessage";
               if(this._unnoticeableMessages.indexOf(msgClassName) != -1)
               {
                  return false;
               }
               if(this._paused && (ACTION_MESSAGES.indexOf(msgClassName) != -1 || ieNotAvailableAnymore))
               {
                  for each(behavior in this._stackOutputMessage)
                  {
                     switch(true)
                     {
                        case behavior is MoveBehavior:
                           moveBehavior = behavior as MoveBehavior;
                           if(msg is CellClickMessage && (msg as CellClickMessage).cellId == moveBehavior.getMapPoint().cellId)
                           {
                              this._waitingMessage = msg;
                              return false;
                           }
                           break;
                        case behavior is ChangeMapBehavior:
                           changeMapBehavior = behavior as ChangeMapBehavior;
                           if(msg is AdjacentMapClickMessage && (msg as AdjacentMapClickMessage).cellId == changeMapBehavior.getMapPoint().cellId)
                           {
                              this._waitingMessage = msg;
                              return false;
                           }
                           break;
                        case behavior is InteractiveElementBehavior:
                           ieBehavior = behavior as InteractiveElementBehavior;
                           if(msg is InteractiveElementActivationMessage && (msg as InteractiveElementActivationMessage).interactiveElement.elementId == ieBehavior.interactiveElement.elementId)
                           {
                              this._waitingMessage = msg;
                              return false;
                           }
                           if(ieNotAvailableAnymore && ieBehavior.interactiveElement.elementId == (msg as Object).elemId)
                           {
                              ieBehavior.processOutputMessage(msg,this._currentMode);
                              this.removeCheckPoint(ieBehavior);
                              ieBehaviorIndex = this._stackOutputMessage.indexOf(ieBehavior);
                              ieam = this._waitingMessage as InteractiveElementActivationMessage;
                              if(ieam && ieam.interactiveElement.elementId == ieBehavior.interactiveElement.elementId)
                              {
                                 this._waitingMessage = null;
                              }
                              if(ieBehaviorIndex != -1)
                              {
                                 this._stackOutputMessage.splice(ieBehaviorIndex,1);
                                 return false;
                              }
                           }
                           break;
                     }
                  }
                  return false;
               }
               for each(behaviour in this._stackInputMessage)
               {
                  behaviour.checkAvailability(msg);
               }
               if(this._stopMessages.indexOf(msgClassName) != -1)
               {
                  stop = true;
                  if(msg is EmotePlayMessage)
                  {
                     if((msg as EmotePlayMessage).actorId != PlayedCharacterManager.getInstance().id)
                     {
                        stop = false;
                     }
                  }
                  if(stop)
                  {
                     this.emptyStack();
                     return false;
                  }
               }
               if(this._ignoredMsg.indexOf(msg) != -1)
               {
                  this._ignoredMsg.splice(this._ignoredMsg.indexOf(msg),1);
                  return false;
               }
               catchInputMsg = this.processStackInputMessages(msg);
               catchOutputMsg = this.processStackOutputMessages(msg);
               return catchInputMsg;
         }
      }
      
      private function processStackInputMessages(pMsg:Message) : Boolean
      {
         var elem:AbstractBehavior = null;
         var copy:AbstractBehavior = null;
         var elementInStack:AbstractBehavior = null;
         var tchatMessage:String = null;
         if(this._stackOutputMessage.length >= LIMIT)
         {
            this._limitReached = true;
         }
         for each(elem in this._stackInputMessage)
         {
            if(elem.processInputMessage(pMsg,this._currentMode))
            {
               if(this._currentMode == AbstractBehavior.ALWAYS && (!elem.isActive || this._stackOutputMessage.length > 0 && !elem.isAvailableToStart))
               {
                  this.emptyStack(false);
                  if(!elem.isActive)
                  {
                     return false;
                  }
               }
               if(elem.canBeStacked)
               {
                  copy = elem.copy();
                  elementInStack = this.getSameInOutputList(copy);
                  if(elementInStack == null)
                  {
                     if(this._ignoreAllMessages || this._limitReached)
                     {
                        tchatMessage = "";
                        if(this._ignoreAllMessages)
                        {
                           tchatMessage = I18n.getUiText("ui.stack.stop");
                        }
                        else if(this._limitReached)
                        {
                           tchatMessage = I18n.getUiText("ui.stack.limit",[LIMIT]);
                        }
                        KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,tchatMessage,ChatFrame.RED_CHANNEL_ID,TimeManager.getInstance().getTimestamp());
                        return true;
                     }
                     if(this._stackOutputMessage.length == 0 && elem.needToWait && this._currentMode == AbstractBehavior.NORMAL)
                     {
                        this._stackOutputMessage.push(AbstractBehavior.createFake(StackActionEnum.MOVE,[elem.getFakePosition()]));
                     }
                     this._stackOutputMessage.push(copy);
                     if(this._currentMode != AbstractBehavior.ALWAYS || this._currentMode == AbstractBehavior.ALWAYS && this._stackOutputMessage.length > 1)
                     {
                        this.addCheckPoint(copy);
                     }
                     if(elem.type == AbstractBehavior.STOP)
                     {
                        this._ignoreAllMessages = true;
                     }
                  }
                  else
                  {
                     if(elementInStack.type == AbstractBehavior.STOP)
                     {
                        this._ignoreAllMessages = false;
                     }
                     this.removeCheckPoint(elementInStack);
                     this._stackOutputMessage.splice(this._stackOutputMessage.indexOf(elementInStack),1);
                     if(this._limitReached && this._stackOutputMessage.length < LIMIT)
                     {
                        this._limitReached = false;
                     }
                  }
                  elem.reset();
                  return true;
               }
            }
         }
         return false;
      }
      
      private function getSameInOutputList(copy:AbstractBehavior) : AbstractBehavior
      {
         var be:AbstractBehavior = null;
         for each(be in this._stackOutputMessage)
         {
            if(be.getMapPoint() && be.getMapPoint().cellId == copy.getMapPoint().cellId)
            {
               if(!(be is InteractiveElementBehavior && copy is InteractiveElementBehavior))
               {
                  return be;
               }
               if((be as InteractiveElementBehavior).interactiveElement.elementId == (copy as InteractiveElementBehavior).interactiveElement.elementId)
               {
                  return be;
               }
            }
         }
         return null;
      }
      
      private function processStackOutputMessages(pMsg:Message) : Boolean
      {
         var currentStackElement:AbstractBehavior = null;
         var isCatched:Boolean = false;
         if(this._stackOutputMessage.length > 0)
         {
            currentStackElement = this._stackOutputMessage[0];
            if(currentStackElement.pendingMessage == null)
            {
               isCatched = currentStackElement.processOutputMessage(pMsg,this._currentMode);
               if(isCatched)
               {
                  this._stackOutputMessage.splice(this._stackOutputMessage.indexOf(currentStackElement),1);
                  if(this._limitReached && this._stackOutputMessage.length < LIMIT)
                  {
                     this._limitReached = false;
                  }
                  if(this._ignoreAllMessages && currentStackElement.type == AbstractBehavior.STOP)
                  {
                     this._ignoreAllMessages = false;
                  }
               }
               if(currentStackElement.actionStarted)
               {
                  this.removeCheckPoint(currentStackElement);
               }
            }
            else if(currentStackElement.pendingMessage != null)
            {
               while(this._stackOutputMessage.length > 0)
               {
                  currentStackElement = this._stackOutputMessage[0];
                  if(currentStackElement.isAvailableToProcess(pMsg))
                  {
                     this._ignoredMsg.push(currentStackElement.pendingMessage);
                     currentStackElement.processMessageToWorker();
                     break;
                  }
                  this.removeCheckPoint(currentStackElement);
                  this._stackOutputMessage.splice(this._stackOutputMessage.indexOf(currentStackElement),1);
                  if(this._limitReached && this._stackOutputMessage.length < LIMIT)
                  {
                     this._limitReached = false;
                  }
               }
            }
            return currentStackElement.isMessageCatchable(pMsg);
         }
         return false;
      }
      
      private function addCheckPoint(stackElement:AbstractBehavior) : void
      {
         var ch:CheckPointEntity = null;
         var che:CheckPointEntity = null;
         for each(ch in this._checkPointList)
         {
            if(stackElement.getMapPoint() && stackElement.getMapPoint().cellId == ch.position.cellId)
            {
               EntitiesDisplayManager.getInstance().removeEntity(ch);
            }
         }
         stackElement.addIcon();
         che = new CheckPointEntity(stackElement.sprite,stackElement.getMapPoint());
         this._checkPointList.push(che);
         EntitiesDisplayManager.getInstance().displayEntity(che,stackElement.getMapPoint(),PlacementStrataEnums.STRATA_AREA);
      }
      
      private function removeCheckPoint(stackElement:AbstractBehavior) : void
      {
         var ch:CheckPointEntity = null;
         stackElement.removeIcon();
         if(this._checkPointList.length > 0)
         {
            for each(ch in this._checkPointList)
            {
               if(stackElement.getMapPoint() && ch.position && stackElement.getMapPoint().cellId == ch.position.cellId && stackElement.sprite && stackElement.sprite.parent == ch)
               {
                  EntitiesDisplayManager.getInstance().removeEntity(ch);
                  this._checkPointList.splice(this._checkPointList.indexOf(ch),1);
                  return;
               }
            }
         }
      }
      
      public function removeAction(pAction:AbstractBehavior) : void
      {
         this.removeCheckPoint(pAction);
         pAction.remove();
         this._stackOutputMessage.splice(this._stackOutputMessage.indexOf(pAction),1);
      }
      
      public function resumeStack() : void
      {
         var elem:AbstractBehavior = null;
         if(this._wasInFight && this._stackOutputMessage.length > 0)
         {
            for each(elem in this._stackOutputMessage)
            {
               this.addCheckPoint(elem);
            }
            if(!this._stackOutputMessage[0].pendingMessage && !this._stackOutputMessage[0].actionStarted)
            {
               this._stackOutputMessage[0].pendingMessage = this._stackOutputMessage[0].processedMessage;
            }
            this.processStackOutputMessages(this._stackOutputMessage[0].pendingMessage);
         }
         this._wasInFight = false;
      }
      
      private function emptyStack(all:Boolean = true) : void
      {
         var outputMessage:AbstractBehavior = null;
         var checkpoint:CheckPointEntity = null;
         if(this._stackOutputMessage.length == 1 && this._stackOutputMessage[0].actionStarted == false)
         {
            this._stackOutputMessage[0].removeIcon();
            this._stackOutputMessage[0].remove();
            this._stackOutputMessage = new Vector.<AbstractBehavior>();
         }
         var cpy:Vector.<AbstractBehavior> = this._stackOutputMessage.concat();
         for each(outputMessage in cpy)
         {
            if(all || cpy.indexOf(outputMessage) != 0 || cpy.indexOf(outputMessage) == 0 && !outputMessage.actionStarted)
            {
               outputMessage.removeIcon();
               outputMessage.remove();
               this._stackOutputMessage.splice(this._stackOutputMessage.indexOf(outputMessage),1);
            }
         }
         cpy = null;
         for each(checkpoint in this._checkPointList)
         {
            EntitiesDisplayManager.getInstance().removeEntity(checkpoint);
         }
         this.initStackInputMessages(this._currentMode);
         this._checkPointList = new Vector.<CheckPointEntity>();
         this._ignoredMsg = new Vector.<Message>();
         this._ignoreAllMessages = false;
         this._limitReached = false;
         this._wasInFight = false;
      }
      
      private function stopWatchingActions() : void
      {
         this.initStackInputMessages(AbstractBehavior.ALWAYS);
      }
      
      private function addBehaviorToInputStack(behavior:AbstractBehavior, pIsActive:Boolean = true) : void
      {
         var typeOfOtherBehavior:String = null;
         var b:AbstractBehavior = null;
         var typeOfNewBehavior:String = getQualifiedClassName(behavior);
         for each(b in this._stackInputMessage)
         {
            typeOfOtherBehavior = getQualifiedClassName(b);
            if(typeOfNewBehavior == typeOfOtherBehavior)
            {
               b.isActive = pIsActive;
               return;
            }
         }
         behavior.isActive = pIsActive;
         this._stackInputMessage.push(behavior);
      }
      
      public function get priority() : int
      {
         return Priority.HIGHEST;
      }
      
      public function get stackInputMessage() : Vector.<AbstractBehavior>
      {
         return this._stackInputMessage;
      }
      
      public function get stackOutputMessage() : Vector.<AbstractBehavior>
      {
         return this._stackOutputMessage;
      }
      
      public function get waitingMessage() : Message
      {
         return this._waitingMessage;
      }
      
      public function set waitingMessage(pMsg:Message) : void
      {
         this._waitingMessage = pMsg;
      }
      
      public function get paused() : Boolean
      {
         return this._paused;
      }
      
      public function set paused(pPause:Boolean) : void
      {
         this._paused = pPause;
      }
   }
}
