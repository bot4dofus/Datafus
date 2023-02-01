package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.managers.AlwaysAnimatedElementManager;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.berilia.factories.MenusFactory;
   import com.ankamagames.berilia.frames.ShortcutsFrame;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.dofus.datacenter.interactives.Interactive;
   import com.ankamagames.dofus.datacenter.jobs.Skill;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.actions.ChangeWorldInteractionAction;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.roleplay.actions.HighlightInteractiveElementsAction;
   import com.ankamagames.dofus.logic.game.roleplay.managers.SkillManager;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementActivationMessage;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementMouseOutMessage;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementMouseOverMessage;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.MapObstacleStateEnum;
   import com.ankamagames.dofus.network.enums.PlayerLifeStatusEnum;
   import com.ankamagames.dofus.network.messages.game.context.GameContextDestroyMessage;
   import com.ankamagames.dofus.network.messages.game.context.roleplay.MapObstacleUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveElementUpdatedMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveMapUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveUseEndedMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveUseErrorMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.InteractiveUsedMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.StatedElementUpdatedMessage;
   import com.ankamagames.dofus.network.messages.game.interactive.StatedMapUpdateMessage;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElementSkill;
   import com.ankamagames.dofus.network.types.game.interactive.MapObstacle;
   import com.ankamagames.dofus.network.types.game.interactive.StatedElement;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.dofus.uiApi.JobsApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.entities.interfaces.IAnimated;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.enum.OperatingSystem;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.CursorSpriteManager;
   import com.ankamagames.jerakine.managers.FiltersManager;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.managers.PerformanceManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.tiphon.sequence.SetDirectionStep;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.filters.ColorMatrixFilter;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.getQualifiedClassName;
   
   public class RoleplayInteractivesFrame implements Frame
   {
      
      private static const INTERACTIVE_CURSOR_0:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_0;
      
      private static const INTERACTIVE_CURSOR_1:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_1;
      
      private static const INTERACTIVE_CURSOR_2:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_2;
      
      private static const INTERACTIVE_CURSOR_3:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_3;
      
      private static const INTERACTIVE_CURSOR_4:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_4;
      
      private static const INTERACTIVE_CURSOR_5:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_5;
      
      private static const INTERACTIVE_CURSOR_6:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_6;
      
      private static const INTERACTIVE_CURSOR_7:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_7;
      
      private static const INTERACTIVE_CURSOR_8:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_8;
      
      private static const INTERACTIVE_CURSOR_9:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_9;
      
      private static const INTERACTIVE_CURSOR_10:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_10;
      
      private static const INTERACTIVE_CURSOR_11:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_11;
      
      private static const INTERACTIVE_CURSOR_DISABLED:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_DISABLED;
      
      private static const INTERACTIVE_CURSOR_WAIT:Class = RoleplayInteractivesFrame_INTERACTIVE_CURSOR_WAIT;
      
      private static const INTERACTIVE_CURSOR_DISABLED_INDEX:int = 999;
      
      private static const INTERACTIVE_CURSOR_WAIT_INDEX:int = 1000;
      
      private static var cursorList:Array = new Array();
      
      private static var cursorClassList:Array;
      
      private static const INTERACTIVE_CURSOR_NAME:String = "interactiveCursor";
      
      private static const LUMINOSITY_FACTOR:Number = 1.2;
      
      private static const LUMINOSITY_EFFECTS:ColorMatrixFilter = new ColorMatrixFilter([LUMINOSITY_FACTOR,0,0,0,0,0,LUMINOSITY_FACTOR,0,0,0,0,0,LUMINOSITY_FACTOR,0,0,0,0,0,1,0]);
      
      private static const HIGHLIGHT_HINT_FILTER:GlowFilter = new GlowFilter(16777215,0.8,6,6,4,1);
      
      private static const ALPHA_MODIFICATOR:Number = 0.2;
      
      private static const COLLECTABLE_COLLECTING_STATE_ID:uint = 2;
      
      private static const COLLECTABLE_CUT_STATE_ID:uint = 1;
      
      private static const ACTION_COLLECTABLE_RESOURCES:uint = 1;
      
      private static var _highlightInteractiveElements:Boolean;
      
      public static var currentlyHighlighted:Sprite;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(RoleplayInteractivesFrame));
       
      
      private var _modContextMenu:Object;
      
      private var _ie:Dictionary;
      
      private var _currentUsages:Array;
      
      private var _baseAlpha:Number;
      
      private var i:int;
      
      private var _entities:Dictionary;
      
      private var _usingInteractive:Boolean = false;
      
      private var _nextInteractiveUsed:Object;
      
      private var _interactiveActionTimers:Dictionary;
      
      private var _enableWorldInteraction:Boolean = true;
      
      private var _collectableSpritesToBeStopped:Dictionary;
      
      private var _currentRequestedElementId:int = -1;
      
      private var _currentUsedElementId:int = -1;
      
      private var _statedElementsTargetAnimation:Dictionary;
      
      private var _mouseDown:Boolean;
      
      private var dirmov:uint = 666;
      
      public function RoleplayInteractivesFrame()
      {
         this._ie = new Dictionary(true);
         this._currentUsages = new Array();
         this._entities = new Dictionary();
         this._interactiveActionTimers = new Dictionary(true);
         this._collectableSpritesToBeStopped = new Dictionary(true);
         this._statedElementsTargetAnimation = new Dictionary(true);
         super();
         this._modContextMenu = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
         if(!cursorClassList)
         {
            cursorClassList = new Array();
            cursorClassList[0] = INTERACTIVE_CURSOR_0;
            cursorClassList[1] = INTERACTIVE_CURSOR_1;
            cursorClassList[2] = INTERACTIVE_CURSOR_2;
            cursorClassList[3] = INTERACTIVE_CURSOR_3;
            cursorClassList[4] = INTERACTIVE_CURSOR_4;
            cursorClassList[5] = INTERACTIVE_CURSOR_5;
            cursorClassList[6] = INTERACTIVE_CURSOR_6;
            cursorClassList[7] = INTERACTIVE_CURSOR_7;
            cursorClassList[8] = INTERACTIVE_CURSOR_8;
            cursorClassList[9] = INTERACTIVE_CURSOR_9;
            cursorClassList[10] = INTERACTIVE_CURSOR_10;
            cursorClassList[11] = INTERACTIVE_CURSOR_11;
            cursorClassList[INTERACTIVE_CURSOR_DISABLED_INDEX] = INTERACTIVE_CURSOR_DISABLED;
            cursorClassList[INTERACTIVE_CURSOR_WAIT_INDEX] = INTERACTIVE_CURSOR_WAIT;
         }
      }
      
      public static function getCursor(id:int, pEnabled:Boolean = true, pCache:Boolean = true, pWait:Boolean = false) : Sprite
      {
         var cross:Sprite = null;
         var hourglass:Sprite = null;
         var cursor:Sprite = null;
         var cursorClass:Class = null;
         if(!pEnabled)
         {
            if(cursorList[INTERACTIVE_CURSOR_DISABLED_INDEX])
            {
               cross = cursorList[INTERACTIVE_CURSOR_DISABLED_INDEX];
            }
            else
            {
               cursorClass = cursorClassList[INTERACTIVE_CURSOR_DISABLED_INDEX];
               if(cursorClass)
               {
                  cross = new cursorClass();
                  cursorList[INTERACTIVE_CURSOR_DISABLED_INDEX] = cross;
               }
            }
         }
         else if(pWait)
         {
            if(cursorList[INTERACTIVE_CURSOR_WAIT_INDEX])
            {
               hourglass = cursorList[INTERACTIVE_CURSOR_WAIT_INDEX];
            }
            else
            {
               cursorClass = cursorClassList[INTERACTIVE_CURSOR_WAIT_INDEX];
               if(cursorClass)
               {
                  hourglass = new cursorClass();
                  cursorList[INTERACTIVE_CURSOR_WAIT_INDEX] = hourglass;
               }
            }
         }
         if(cursorList[id] && pCache)
         {
            cursor = cursorList[id];
         }
         cursorClass = cursorClassList[id];
         if(cursorClass)
         {
            cursor = new cursorClass();
            if(pCache)
            {
               cursorList[id] = cursor;
            }
            cursor.cacheAsBitmap = true;
            if(cross != null)
            {
               cursor.addChild(cross);
            }
            else if(hourglass != null)
            {
               cursor.addChild(hourglass);
            }
         }
         if(cursor)
         {
            if(cross != null)
            {
               cursor.addChild(cross);
            }
            else if(hourglass != null)
            {
               cursor.addChild(hourglass);
            }
            else if(cursor.numChildren > 1)
            {
               cursor.removeChildAt(0);
            }
            return cursor;
         }
         return new INTERACTIVE_CURSOR_0();
      }
      
      public function get priority() : int
      {
         return Priority.HIGH;
      }
      
      private function get roleplayContextFrame() : RoleplayContextFrame
      {
         return Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
      }
      
      private function get roleplayWorldFrame() : RoleplayWorldFrame
      {
         return Kernel.getWorker().getFrame(RoleplayWorldFrame) as RoleplayWorldFrame;
      }
      
      public function get currentRequestedElementId() : int
      {
         return this._currentRequestedElementId;
      }
      
      public function set currentRequestedElementId(pElementId:int) : void
      {
         this._currentRequestedElementId = pElementId;
      }
      
      public function get usingInteractive() : Boolean
      {
         return this._usingInteractive;
      }
      
      public function get nextInteractiveUsed() : Object
      {
         return this._nextInteractiveUsed;
      }
      
      public function set nextInteractiveUsed(object:Object) : void
      {
         this._nextInteractiveUsed = object;
      }
      
      public function get worldInteractionIsEnable() : Boolean
      {
         return this._enableWorldInteraction;
      }
      
      public function pushed() : Boolean
      {
         StageShareManager.stage.addEventListener(Event.DEACTIVATE,this.onWindowDeactivate);
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var sf:ShortcutsFrame = null;
         var imumsg:InteractiveMapUpdateMessage = null;
         var shortcutsFrame:ShortcutsFrame = null;
         var mousePos:Point = null;
         var objectsUnder:Array = null;
         var o:DisplayObject = null;
         var ieObj:* = undefined;
         var ieumsg:InteractiveElementUpdatedMessage = null;
         var iumsg:InteractiveUsedMessage = null;
         var worldPos:MapPoint = null;
         var user:IEntity = null;
         var iuem:InteractiveUseErrorMessage = null;
         var smumsg:StatedMapUpdateMessage = null;
         var seumsg:StatedElementUpdatedMessage = null;
         var moumsg:MapObstacleUpdateMessage = null;
         var iuemsg:InteractiveUseEndedMessage = null;
         var iemimsg:InteractiveElementMouseOverMessage = null;
         var iel:Object = null;
         var hliea:HighlightInteractiveElementsAction = null;
         var mum:MouseUpMessage = null;
         var ie:InteractiveElement = null;
         var useAnimation:String = null;
         var useDirection:uint = 0;
         var t:BenchmarkTimer = null;
         var tiphonSprite:TiphonSprite = null;
         var currentSpriteAnimation:String = null;
         var fct:Function = null;
         var seq:SerialSequencer = null;
         var sprite:TiphonSprite = null;
         var rwf:RoleplayWorldFrame = null;
         var se:StatedElement = null;
         var mo:MapObstacle = null;
         var skills:Vector.<InteractiveElementSkill> = null;
         switch(true)
         {
            case msg is InteractiveMapUpdateMessage:
               imumsg = msg as InteractiveMapUpdateMessage;
               this.clear();
               for each(ie in imumsg.interactiveElements)
               {
                  if(ie.enabledSkills.length)
                  {
                     this.registerInteractive(ie,ie.enabledSkills[0].skillId);
                  }
                  else if(ie.disabledSkills.length)
                  {
                     this.registerInteractive(ie,ie.disabledSkills[0].skillId);
                  }
               }
               AlwaysAnimatedElementManager.startAnims();
               shortcutsFrame = Kernel.getWorker().getFrame(ShortcutsFrame) as ShortcutsFrame;
               _highlightInteractiveElements = StageShareManager.isActive && shortcutsFrame.heldShortcuts.indexOf("highlightInteractiveElements") != -1;
               this.highlightInteractiveElements(_highlightInteractiveElements);
               mousePos = new Point(StageShareManager.stage.mouseX,StageShareManager.stage.mouseY);
               objectsUnder = StageShareManager.stage.getObjectsUnderPoint(mousePos);
               for each(o in objectsUnder)
               {
                  for(ieObj in this._ie)
                  {
                     if(ieObj.contains(o))
                     {
                        Kernel.getWorker().process(new InteractiveElementMouseOverMessage(this._ie[ieObj].element,ieObj));
                        return true;
                     }
                  }
               }
               return true;
            case msg is InteractiveElementUpdatedMessage:
               ieumsg = msg as InteractiveElementUpdatedMessage;
               if(ieumsg.interactiveElement.enabledSkills.length)
               {
                  this.registerInteractive(ieumsg.interactiveElement,ieumsg.interactiveElement.enabledSkills[0].skillId);
               }
               else if(ieumsg.interactiveElement.disabledSkills.length)
               {
                  this.registerInteractive(ieumsg.interactiveElement,ieumsg.interactiveElement.disabledSkills[0].skillId);
               }
               else
               {
                  this.removeInteractive(ieumsg.interactiveElement);
               }
               return true;
            case msg is InteractiveUsedMessage:
               iumsg = msg as InteractiveUsedMessage;
               if(PlayedCharacterManager.getInstance().id == iumsg.entityId && iumsg.duration > 0)
               {
                  this._currentUsedElementId = iumsg.elemId;
               }
               if(this._currentRequestedElementId == iumsg.elemId)
               {
                  this._currentRequestedElementId = -1;
               }
               worldPos = Atouin.getInstance().getIdentifiedElementPosition(iumsg.elemId);
               user = DofusEntities.getEntity(iumsg.entityId);
               if(user is IAnimated)
               {
                  useAnimation = Skill.getSkillById(iumsg.skillId).useAnimation;
                  useDirection = this.getUseDirection(user as TiphonSprite,useAnimation,worldPos);
                  if(iumsg.duration > 0)
                  {
                     if(!this._interactiveActionTimers[user])
                     {
                        this._interactiveActionTimers[user] = new BenchmarkTimer(1,1,"RoleplayInteractivesFrame._interactiveActionTimers[user]");
                     }
                     t = this._interactiveActionTimers[user];
                     if(t.running)
                     {
                        t.stop();
                        t.dispatchEvent(new TimerEvent(TimerEvent.TIMER));
                     }
                     tiphonSprite = user as TiphonSprite;
                     tiphonSprite.setAnimationAndDirection(useAnimation,useDirection);
                     currentSpriteAnimation = tiphonSprite.getAnimation();
                     t.delay = iumsg.duration * 100;
                     fct = function():void
                     {
                        var userTs:TiphonSprite = null;
                        t.removeEventListener(TimerEvent.TIMER,fct);
                        if(currentSpriteAnimation.indexOf((user as TiphonSprite).getAnimation()) != -1)
                        {
                           userTs = user as TiphonSprite;
                           if(userTs is AnimatedCharacter && userTs.getDirection() != DirectionsEnum.DOWN)
                           {
                              (userTs as AnimatedCharacter).visibleAura = false;
                           }
                           userTs.setAnimation(AnimationEnum.ANIM_STATIQUE);
                        }
                     };
                     if(!t.hasEventListener(TimerEvent.TIMER))
                     {
                        t.addEventListener(TimerEvent.TIMER,fct);
                     }
                     t.start();
                  }
                  else
                  {
                     seq = new SerialSequencer();
                     sprite = user as TiphonSprite;
                     seq.addStep(new SetDirectionStep(sprite,useDirection));
                     seq.addStep(new PlayAnimationStep(sprite,useAnimation));
                     seq.start();
                  }
               }
               if(iumsg.duration > 0)
               {
                  if(PlayedCharacterManager.getInstance().id == iumsg.entityId)
                  {
                     this._usingInteractive = true;
                     this.resetInteractiveApparence(false);
                     rwf = this.roleplayWorldFrame;
                     if(rwf)
                     {
                        rwf.cellClickEnabled = false;
                     }
                  }
                  this._entities[iumsg.elemId] = iumsg.entityId;
               }
               return false;
            case msg is InteractiveUseErrorMessage:
               iuem = msg as InteractiveUseErrorMessage;
               if(iuem.elemId == this._currentRequestedElementId)
               {
                  this._currentRequestedElementId = -1;
               }
               KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.popup.impossible_action"),ChatFrame.RED_CHANNEL_ID);
               return false;
            case msg is StatedMapUpdateMessage:
               smumsg = msg as StatedMapUpdateMessage;
               this._usingInteractive = false;
               for each(se in smumsg.statedElements)
               {
                  this.updateStatedElement(se,true);
               }
               return true;
            case msg is StatedElementUpdatedMessage:
               seumsg = msg as StatedElementUpdatedMessage;
               this.updateStatedElement(seumsg.statedElement);
               return true;
            case msg is MapObstacleUpdateMessage:
               moumsg = msg as MapObstacleUpdateMessage;
               for each(mo in moumsg.obstacles)
               {
                  InteractiveCellManager.getInstance().updateCell(mo.obstacleCellId,mo.state == MapObstacleStateEnum.OBSTACLE_OPENED);
               }
               return true;
            case msg is InteractiveUseEndedMessage:
               iuemsg = InteractiveUseEndedMessage(msg);
               this.interactiveUsageFinished(this._entities[iuemsg.elemId],iuemsg.elemId,iuemsg.skillId);
               delete this._entities[iuemsg.elemId];
               return false;
            case msg is InteractiveElementMouseOverMessage:
               if(OptionManager.getOptionManager("dofus").getOption("enableForceWalk") == true && (ShortcutsFrame.ctrlKeyDown || SystemManager.getSingleton().os == OperatingSystem.MAC_OS && ShortcutsFrame.altKeyDown))
               {
                  return false;
               }
               iemimsg = msg as InteractiveElementMouseOverMessage;
               iel = this._ie[iemimsg.sprite];
               if(iel && iel.element)
               {
                  skills = iel.element.enabledSkills;
                  skills = !!skills ? skills.concat(iel.element.disabledSkills) : iel.element.disabledSkills;
                  this.highlightInteractiveApparence(iemimsg.sprite,skills,iel.element.enabledSkills.length > 0);
               }
               return false;
               break;
            case msg is InteractiveElementMouseOutMessage:
               this.resetInteractiveApparence();
               currentlyHighlighted = null;
               return false;
            case msg is HighlightInteractiveElementsAction:
               hliea = msg as HighlightInteractiveElementsAction;
               sf = Kernel.getWorker().getFrame(ShortcutsFrame) as ShortcutsFrame;
               if(_highlightInteractiveElements)
               {
                  _highlightInteractiveElements = false;
                  this.highlightInteractiveElements(_highlightInteractiveElements);
               }
               else if(StageShareManager.isActive && (hliea.fromShortcut && sf.heldShortcuts.indexOf("highlightInteractiveElements") != -1 || this._mouseDown))
               {
                  _highlightInteractiveElements = true;
                  this.highlightInteractiveElements(_highlightInteractiveElements);
               }
               return true;
            case msg is MouseDownMessage:
               this._mouseDown = true;
               break;
            case msg is MouseUpMessage:
               this._mouseDown = false;
               mum = msg as MouseUpMessage;
               sf = Kernel.getWorker().getFrame(ShortcutsFrame) as ShortcutsFrame;
               if(sf.heldShortcuts.indexOf("highlightInteractiveElements") == -1 && _highlightInteractiveElements)
               {
                  _highlightInteractiveElements = false;
                  this.highlightInteractiveElements(_highlightInteractiveElements);
               }
               break;
            case msg is GameContextDestroyMessage:
               _highlightInteractiveElements = false;
               this.highlightInteractiveElements(_highlightInteractiveElements);
               return false;
         }
         return false;
      }
      
      public function pulled() : Boolean
      {
         var sprite:* = undefined;
         var ts:TiphonSprite = null;
         for(sprite in this._collectableSpritesToBeStopped)
         {
            ts = sprite as TiphonSprite;
            if(ts)
            {
               ts.setAnimationAndDirection("AnimState" + COLLECTABLE_CUT_STATE_ID,0);
            }
         }
         this._collectableSpritesToBeStopped = new Dictionary(true);
         this._entities = new Dictionary();
         this._ie = new Dictionary(true);
         this._modContextMenu = null;
         this._currentUsages = new Array();
         this._nextInteractiveUsed = null;
         this._interactiveActionTimers = new Dictionary(true);
         StageShareManager.stage.removeEventListener(Event.DEACTIVATE,this.onWindowDeactivate);
         KernelEventsManager.getInstance().processCallback(HookList.HighlightInteractiveElements,false);
         return true;
      }
      
      public function enableWorldInteraction(pEnable:Boolean) : void
      {
         this._enableWorldInteraction = pEnable;
      }
      
      public function clear() : void
      {
         var timeout:int = 0;
         var ieObj:* = undefined;
         for each(timeout in this._currentUsages)
         {
            clearTimeout(timeout);
         }
         for(ieObj in this._ie)
         {
            if(_highlightInteractiveElements)
            {
               this.highlightInteractiveElement(ieObj,false);
            }
            this.removeInteractive(this._ie[ieObj].element);
         }
      }
      
      public function getInteractiveElementsCells() : Vector.<uint>
      {
         var cellObj:Object = null;
         var cells:Vector.<uint> = new Vector.<uint>();
         for each(cellObj in this._ie)
         {
            if(cellObj != null)
            {
               cells.push(cellObj.position.cellId);
            }
         }
         return cells;
      }
      
      public function getInteractiveActionTimer(pUser:*) : BenchmarkTimer
      {
         return this._interactiveActionTimers[pUser];
      }
      
      public function isElementChangingState(pElementId:int) : Boolean
      {
         var animData:Object = null;
         var changing:Boolean = false;
         for each(animData in this._statedElementsTargetAnimation)
         {
            if(animData.elemId == pElementId)
            {
               changing = true;
               break;
            }
         }
         return changing;
      }
      
      public function getUseDirection(user:TiphonSprite, useAnimation:String, worldPos:MapPoint) : uint
      {
         var useDirection:uint = 0;
         var k:int = 0;
         var playerPos:MapPoint = (user as IMovable).position;
         if(playerPos.x == worldPos.x && playerPos.y == worldPos.y)
         {
            useDirection = user.getDirection();
         }
         else
         {
            useDirection = (user as IMovable).position.advancedOrientationTo(worldPos,true);
         }
         var availableDirections:Array = user.getAvaibleDirection(useAnimation);
         if(availableDirections[5])
         {
            availableDirections[7] = true;
         }
         if(availableDirections[1])
         {
            availableDirections[3] = true;
         }
         if(availableDirections[7])
         {
            availableDirections[5] = true;
         }
         if(availableDirections[3])
         {
            availableDirections[1] = true;
         }
         if(availableDirections[useDirection] == false)
         {
            for(k = 0; k < 8; k++)
            {
               if(useDirection == 7)
               {
                  useDirection = 0;
               }
               else
               {
                  useDirection++;
               }
               if(availableDirections[useDirection] == true)
               {
                  break;
               }
            }
         }
         return useDirection;
      }
      
      public function enableInteractiveElements(enabled:Boolean) : void
      {
         var worldObject:* = undefined;
         for(worldObject in this._ie)
         {
            worldObject.mouseEnabled = enabled;
            worldObject.useHandCursor = enabled;
            worldObject.buttonMode = enabled;
         }
      }
      
      public function getInteractiveElement(pObject:DisplayObject) : InteractiveElement
      {
         var ie:Object = this._ie[pObject];
         return !!ie ? ie.element : null;
      }
      
      private function registerInteractive(ie:InteractiveElement, firstSkill:int) : void
      {
         var skill:InteractiveElementSkill = null;
         var skilld:InteractiveElementSkill = null;
         var entitiesFrame:RoleplayEntitiesFrame = null;
         var found:Boolean = false;
         var s:* = null;
         var cie:InteractiveElement = null;
         var worldObject:InteractiveObject = Atouin.getInstance().getIdentifiedElement(ie.elementId);
         if(!worldObject)
         {
            _log.error("Unknown identified element " + ie.elementId + ", unable to register it as interactive.");
            return;
         }
         for each(skill in ie.enabledSkills)
         {
            if(SkillManager.getInstance().isDoorCursorSkill(skill.skillId))
            {
               MapDisplayManager.getInstance().getDataMapContainer().addAlwayAnimatedElement(ie.elementId);
               break;
            }
         }
         for each(skilld in ie.disabledSkills)
         {
            if(SkillManager.getInstance().isDoorCursorSkill(skilld.skillId))
            {
               MapDisplayManager.getInstance().getDataMapContainer().addAlwayAnimatedElement(ie.elementId);
               break;
            }
         }
         entitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         if(entitiesFrame)
         {
            found = false;
            for(s in entitiesFrame.interactiveElements)
            {
               cie = entitiesFrame.interactiveElements[int(s)];
               if(cie.elementId == ie.elementId)
               {
                  found = true;
                  entitiesFrame.interactiveElements[int(s)] = ie;
                  break;
               }
            }
            if(!found)
            {
               entitiesFrame.interactiveElements.push(ie);
            }
         }
         var worldPos:MapPoint = Atouin.getInstance().getIdentifiedElementPosition(ie.elementId);
         if(ie.onCurrentMap)
         {
            if(!worldObject.hasEventListener(MouseEvent.MOUSE_OVER))
            {
               worldObject.addEventListener(MouseEvent.MOUSE_OVER,this.over,false,0,true);
               worldObject.addEventListener(MouseEvent.MOUSE_OUT,this.out,false,0,true);
               worldObject.addEventListener(MouseEvent.CLICK,this.click,false,0,true);
            }
            if(worldObject is Sprite)
            {
               (worldObject as Sprite).useHandCursor = true;
               (worldObject as Sprite).buttonMode = true;
            }
         }
         this._ie[worldObject] = {
            "element":ie,
            "position":worldPos,
            "firstSkill":firstSkill
         };
      }
      
      private function removeInteractive(ie:InteractiveElement) : void
      {
         var interactiveElement:InteractiveObject = Atouin.getInstance().getIdentifiedElement(ie.elementId);
         if(interactiveElement != null)
         {
            interactiveElement.removeEventListener(MouseEvent.MOUSE_OVER,this.over);
            interactiveElement.removeEventListener(MouseEvent.MOUSE_OUT,this.out);
            interactiveElement.removeEventListener(MouseEvent.CLICK,this.click);
            if(interactiveElement is Sprite)
            {
               (interactiveElement as Sprite).useHandCursor = false;
               (interactiveElement as Sprite).buttonMode = false;
            }
         }
         if(currentlyHighlighted == interactiveElement as Sprite)
         {
            this.resetInteractiveApparence();
         }
         delete this._ie[interactiveElement];
      }
      
      private function updateStatedElement(se:StatedElement, global:Boolean = false) : void
      {
         var interactive:Interactive = null;
         var isCollectable:Boolean = false;
         var skill:Skill = null;
         var interactiveSkill:InteractiveElementSkill = null;
         var worldObject:InteractiveObject = Atouin.getInstance().getIdentifiedElement(se.elementId);
         if(!worldObject)
         {
            _log.error("Unknown identified element " + se.elementId + "; unable to change its state to " + se.elementState + " !");
            return;
         }
         var ts:TiphonSprite = worldObject is DisplayObjectContainer ? this.findTiphonSprite(worldObject as DisplayObjectContainer) : null;
         if(!ts)
         {
            _log.warn("Unable to find an animated element for the stated element " + se.elementId + " on cell " + se.elementCellId + ", this element is probably invisible or is not configured as an animated element.");
            return;
         }
         if(se.elementId == this._currentUsedElementId)
         {
            this._usingInteractive = true;
            this.resetInteractiveApparence();
         }
         if(this._ie[worldObject] && this._ie[worldObject].element && this._ie[worldObject].element.elementId == se.elementId)
         {
            interactive = Interactive.getInteractiveById(this._ie[worldObject].element.elementTypeId);
            if(interactive)
            {
               isCollectable = false;
               for each(interactiveSkill in this._ie[worldObject].element.enabledSkills)
               {
                  skill = Skill.getSkillById(interactiveSkill.skillId);
                  if(skill.elementActionId == ACTION_COLLECTABLE_RESOURCES)
                  {
                     isCollectable = true;
                     break;
                  }
               }
               if(!isCollectable)
               {
                  for each(interactiveSkill in this._ie[worldObject].element.disabledSkills)
                  {
                     skill = Skill.getSkillById(interactiveSkill.skillId);
                     if(skill.elementActionId == ACTION_COLLECTABLE_RESOURCES)
                     {
                        isCollectable = true;
                        break;
                     }
                  }
               }
               if(isCollectable)
               {
                  this._collectableSpritesToBeStopped[ts] = null;
               }
               else
               {
                  if(ts.hasAnimation("AnimStatique") && !Atouin.getInstance().options.getOption("allowAnimatedGfx"))
                  {
                     this._statedElementsTargetAnimation[ts] = {
                        "elemId":se.elementId,
                        "animation":"AnimStatique"
                     };
                  }
                  else
                  {
                     this._statedElementsTargetAnimation[ts] = {
                        "elemId":se.elementId,
                        "animation":"AnimState" + se.elementState
                     };
                  }
                  ts.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onAnimRendered);
               }
            }
         }
         else
         {
            delete this._collectableSpritesToBeStopped[ts];
         }
         if(ts.look.getBone() == 5247 || ts.look.getBone() == 5249 || ts.look.getBone() == 5250 || ts.look.getBone() == 5251)
         {
            if(ts.hasAnimation("AnimStatique") && !Atouin.getInstance().options.getOption("allowAnimatedGfx"))
            {
               ts.setAnimationAndDirection("AnimStatique",se.elementState,global);
            }
            else
            {
               ts.setAnimationAndDirection("AnimState" + se.elementState,0,global);
            }
         }
         else
         {
            ts.setAnimationAndDirection("AnimState" + se.elementState,0,global);
         }
      }
      
      private function findTiphonSprite(doc:DisplayObjectContainer) : TiphonSprite
      {
         var child:DisplayObject = null;
         if(doc is TiphonSprite)
         {
            return doc as TiphonSprite;
         }
         if(!doc.numChildren)
         {
            return null;
         }
         for(var i:uint = 0; i < doc.numChildren; i++)
         {
            child = doc.getChildAt(i);
            if(child is TiphonSprite)
            {
               return child as TiphonSprite;
            }
            if(child is DisplayObjectContainer)
            {
               return this.findTiphonSprite(child as DisplayObjectContainer);
            }
         }
         return null;
      }
      
      private function highlightInteractiveApparence(ie:Sprite, skills:Vector.<InteractiveElementSkill>, pSkillIsEnabled:Boolean = true) : void
      {
         var skill:Skill = null;
         var cursorId:int = 0;
         var jobsApi:JobsApi = null;
         var jobXp:* = undefined;
         var cursorNamesuffix:String = null;
         var cursorSprite:Sprite = null;
         var cursorName:String = null;
         var infos:Object = this._ie[ie];
         if(!infos)
         {
            return;
         }
         if(currentlyHighlighted != null)
         {
            this.resetInteractiveApparence(false);
         }
         if(ie.getChildAt(0) is TiphonSprite)
         {
            FiltersManager.getInstance().addEffect((ie.getChildAt(0) as TiphonSprite).rawAnimation,LUMINOSITY_EFFECTS);
         }
         else
         {
            FiltersManager.getInstance().addEffect(ie,LUMINOSITY_EFFECTS);
         }
         if(MapDisplayManager.getInstance().isBoundingBox(infos.element.elementId))
         {
            ie.alpha = ALPHA_MODIFICATOR;
         }
         if(skills)
         {
            if(SkillManager.getInstance().isDirectionalPanel(skills[0].skillId) && skills.length > 1)
            {
               skill = Skill.getSkillById(skills[1].skillId);
            }
            else if(!SkillManager.getInstance().isDirectionalPanel(skills[0].skillId))
            {
               skill = Skill.getSkillById(skills[0].skillId);
            }
            if(PlayedCharacterManager.getInstance().state == PlayerLifeStatusEnum.STATUS_ALIVE_AND_KICKING && !PerformanceManager.optimize && skill)
            {
               cursorId = skill.cursor;
               jobsApi = new JobsApi();
               jobXp = jobsApi.getJobExperience(skill.parentJobId);
               cursorNamesuffix = "";
               if(!pSkillIsEnabled)
               {
                  if(!jobXp || jobXp.currentLevel < skill.levelMin)
                  {
                     cursorSprite = getCursor(cursorId,false);
                     cursorNamesuffix = "Cross";
                  }
                  else
                  {
                     cursorSprite = getCursor(cursorId,true,true,true);
                     cursorNamesuffix = "Hourglass";
                  }
               }
               else
               {
                  cursorSprite = getCursor(cursorId,true);
               }
               cursorName = INTERACTIVE_CURSOR_NAME + cursorId + cursorNamesuffix;
               CursorSpriteManager.displaySpecificCursor(cursorName,cursorSprite);
            }
         }
         currentlyHighlighted = ie;
      }
      
      private function resetInteractiveApparence(removeIcon:Boolean = true) : void
      {
         if(currentlyHighlighted == null)
         {
            return;
         }
         if(removeIcon && currentlyHighlighted.numChildren && currentlyHighlighted.getChildAt(0) is TiphonSprite)
         {
            FiltersManager.getInstance().removeEffect((currentlyHighlighted.getChildAt(0) as TiphonSprite).rawAnimation,LUMINOSITY_EFFECTS);
         }
         else if(removeIcon)
         {
            FiltersManager.getInstance().removeEffect(currentlyHighlighted,LUMINOSITY_EFFECTS);
         }
         if(removeIcon)
         {
            CursorSpriteManager.resetCursor();
         }
         var infos:Object = this._ie[currentlyHighlighted];
         if(!infos)
         {
            return;
         }
         if(MapDisplayManager.getInstance().isBoundingBox(infos.element.elementId))
         {
            if(currentlyHighlighted.filters.length == 0)
            {
               currentlyHighlighted.alpha = 0;
            }
            currentlyHighlighted = null;
         }
      }
      
      private function over(me:MouseEvent) : void
      {
         if(!this.roleplayWorldFrame || !this.roleplayContextFrame.hasWorldInteraction)
         {
            return;
         }
         var ie:Object = this._ie[me.target as Sprite];
         if(ie && me)
         {
            Kernel.getWorker().process(new InteractiveElementMouseOverMessage(ie.element,me.target));
         }
      }
      
      private function out(me:Object) : void
      {
         var ie:Object = this._ie[me.target as Sprite];
         if(ie)
         {
            Kernel.getWorker().process(new InteractiveElementMouseOutMessage(ie.element));
         }
      }
      
      private function click(me:MouseEvent) : void
      {
         if(!this.roleplayWorldFrame || !this.roleplayContextFrame.hasWorldInteraction)
         {
            return;
         }
         TooltipManager.hide();
         var ie:Object = this._ie[me.target as Sprite];
         var interactive:Interactive = null;
         if(ie.element.elementTypeId > 0)
         {
            interactive = Interactive.getInteractiveById(ie.element.elementTypeId);
         }
         if(OptionManager.getOptionManager("dofus").getOption("enableForceWalk") == true && (ShortcutsFrame.ctrlKeyDown || SystemManager.getSingleton().os == OperatingSystem.MAC_OS && ShortcutsFrame.altKeyDown))
         {
            this.out(me);
            InteractiveCellManager.getInstance().getCell(ie.position.cellId).dispatchEvent(new MouseEvent(MouseEvent.CLICK));
            return;
         }
         var skills:Array = [];
         var result:Object = SkillManager.getInstance().prepareContextualMenu(skills,ie);
         if(result.nbSkills == 1 && !result.severalInstances)
         {
            this.skillClicked(ie,skills[result.skillIndex].instanceId);
         }
         else if(result.nbSkills > 0 && (skills.length > 1 || result.severalInstances))
         {
            this._modContextMenu = UiModuleManager.getInstance().getModule("Ankama_ContextMenu").mainClass;
            this._modContextMenu.createContextMenu(MenusFactory.create(skills,"skill",[ie,interactive]));
         }
      }
      
      private function skillClicked(ie:Object, skillInstanceId:int) : void
      {
         var msg:InteractiveElementActivationMessage = new InteractiveElementActivationMessage(ie.element,ie.position,skillInstanceId);
         Kernel.getWorker().process(msg);
      }
      
      private function interactiveUsageFinished(entityId:Number, elementId:uint, skillId:uint) : void
      {
         var ieamsg:InteractiveElementActivationMessage = null;
         if(entityId == PlayedCharacterManager.getInstance().id)
         {
            Kernel.getWorker().process(ChangeWorldInteractionAction.create(true));
            if(this.roleplayWorldFrame)
            {
               this.roleplayWorldFrame.cellClickEnabled = true;
            }
            this._usingInteractive = false;
            this._currentUsedElementId = -1;
            if(this._nextInteractiveUsed)
            {
               ieamsg = new InteractiveElementActivationMessage(this._nextInteractiveUsed.ie,this._nextInteractiveUsed.position,this._nextInteractiveUsed.skillInstanceId);
               this._nextInteractiveUsed = null;
               Kernel.getWorker().process(ieamsg);
            }
         }
      }
      
      private function onAnimRendered(pEvent:TiphonEvent) : void
      {
         var ts:TiphonSprite = pEvent.currentTarget as TiphonSprite;
         if(this._statedElementsTargetAnimation[ts] && pEvent.animationType == this._statedElementsTargetAnimation[ts].animation)
         {
            ts.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onAnimRendered);
            if(this._statedElementsTargetAnimation[ts].elemId == this._currentUsedElementId)
            {
               this._usingInteractive = false;
               this._currentUsedElementId = -1;
            }
            if(ts.getBounds(StageShareManager.stage).contains(StageShareManager.stage.mouseX,StageShareManager.stage.mouseY) && this._ie[currentlyHighlighted] && this._ie[currentlyHighlighted].element.elementId == this._statedElementsTargetAnimation[ts].elemId)
            {
               Kernel.getWorker().process(new InteractiveElementMouseOverMessage(this._ie[currentlyHighlighted].element,currentlyHighlighted));
            }
            delete this._statedElementsTargetAnimation[ts];
         }
      }
      
      private function highlightInteractiveElements(pHighlight:Boolean) : void
      {
         var ieObj:* = undefined;
         for(ieObj in this._ie)
         {
            if(!(ieObj is DisplayObject && !ieObj.hasEventListener(MouseEvent.MOUSE_OVER)))
            {
               this.highlightInteractiveElement(ieObj,pHighlight);
            }
         }
         KernelEventsManager.getInstance().processCallback(HookList.HighlightInteractiveElements,pHighlight);
      }
      
      private function highlightInteractiveElement(ieSprite:Sprite, highlight:Boolean) : void
      {
         if(highlight)
         {
            FiltersManager.getInstance().addEffect(ieSprite,HIGHLIGHT_HINT_FILTER);
         }
         else
         {
            FiltersManager.getInstance().removeEffect(ieSprite,HIGHLIGHT_HINT_FILTER);
         }
         if(MapDisplayManager.getInstance().isBoundingBox(this._ie[ieSprite].element.elementId))
         {
            ieSprite.alpha = ieSprite.filters.length > 0 ? Number(ALPHA_MODIFICATOR) : Number(0);
         }
      }
      
      private function onWindowDeactivate(pEvent:Event) : void
      {
         _highlightInteractiveElements = false;
         this.highlightInteractiveElements(_highlightInteractiveElements);
      }
   }
}
