package com.ankamagames.tiphon.display
{
   import com.ankamagames.jerakine.entities.interfaces.IAnimated;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.DefaultableColor;
   import com.ankamagames.jerakine.types.Swl;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.FpsControler;
   import com.ankamagames.jerakine.utils.display.MovieClipUtils;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import com.ankamagames.tiphon.TiphonConstants;
   import com.ankamagames.tiphon.engine.BoneIndexManager;
   import com.ankamagames.tiphon.engine.SubstituteAnimationManager;
   import com.ankamagames.tiphon.engine.Tiphon;
   import com.ankamagames.tiphon.engine.TiphonCacheManager;
   import com.ankamagames.tiphon.engine.TiphonDebugManager;
   import com.ankamagames.tiphon.engine.TiphonEventsManager;
   import com.ankamagames.tiphon.engine.TiphonFpsManager;
   import com.ankamagames.tiphon.error.TiphonError;
   import com.ankamagames.tiphon.events.AnimationEvent;
   import com.ankamagames.tiphon.events.ScriptedAnimationEvent;
   import com.ankamagames.tiphon.events.SwlEvent;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.tiphon.types.BehaviorData;
   import com.ankamagames.tiphon.types.CarriedSprite;
   import com.ankamagames.tiphon.types.ColoredSprite;
   import com.ankamagames.tiphon.types.DisplayInfoSprite;
   import com.ankamagames.tiphon.types.EquipmentSprite;
   import com.ankamagames.tiphon.types.EventListener;
   import com.ankamagames.tiphon.types.IAnimationModifier;
   import com.ankamagames.tiphon.types.IAnimationSpriteHandler;
   import com.ankamagames.tiphon.types.ISkinModifier;
   import com.ankamagames.tiphon.types.ISubEntityBehavior;
   import com.ankamagames.tiphon.types.ISubEntityHandler;
   import com.ankamagames.tiphon.types.ScriptedAnimation;
   import com.ankamagames.tiphon.types.Skin;
   import com.ankamagames.tiphon.types.SubEntityTempInfo;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import com.ankamagames.tiphon.types.TransformData;
   import com.ankamagames.tiphon.types.look.EntityLookObserver;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.clearTimeout;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class TiphonSprite extends Sprite implements IAnimated, IAnimationSpriteHandler, IDestroyable, EntityLookObserver
   {
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      public static var MEMORY_LOG2:Dictionary = new Dictionary(true);
      
      private static const _log:Logger = Log.getLogger(getQualifiedClassName(TiphonSprite));
      
      private static var _point:Point = new Point(0,0);
      
      public static var useEnterFrameDispatcher:Boolean = true;
      
      public static var subEntityHandler:ISubEntityHandler;
       
      
      private var _init:Boolean = false;
      
      private var _currentAnimation:String;
      
      private var _rawAnimation:String;
      
      private var _lastAnimation:String;
      
      private var _transitionStartAnimation:String;
      
      private var _transitionEndAnimation:String;
      
      private var _currentDirection:int;
      
      protected var _animMovieClip:TiphonAnimation;
      
      private var _customColoredParts:Array;
      
      private var _customView:String;
      
      private var _aTransformColors:Array;
      
      private var _skin:Skin;
      
      private var _aSubEntities:Array;
      
      private var _subEntitiesList:Array;
      
      private var _look:TiphonEntityLook;
      
      private var _lookCode:String;
      
      private var _parentSprite:TiphonSprite;
      
      private var _rendered:Boolean = false;
      
      private var _libReady:Boolean = false;
      
      private var _subEntityBehaviors:Array;
      
      private var _backgroundTemp:Array;
      
      private var _subEntitiesTemp:Vector.<SubEntityTempInfo>;
      
      private var _lastClassName:String;
      
      private var _alternativeSkinIndex:int = -1;
      
      private var _recursiveAlternativeSkinIndex:Boolean = false;
      
      private var _background:Array;
      
      private var _deactivatedSubEntityCategory:Array;
      
      private var _waitingEventInitList:Vector.<Event>;
      
      private var _backgroundOnly:Boolean = false;
      
      private var _tiphonEventManager:TiphonEventsManager;
      
      private var _animationModifier:Array;
      
      private var _skinModifier:ISkinModifier;
      
      private var _savedMouseEnabled:Boolean = true;
      
      private var _carriedEntity:TiphonSprite;
      
      private var _lastCarriedEntity:TiphonSprite;
      
      private var _isCarrying:Boolean;
      
      private var _changeDispatched:Boolean;
      
      private var _newAnimationStartFrame:int = -1;
      
      private var _alpha:Number = 1;
      
      private var _rect:Rectangle;
      
      public var _flipped:Boolean = false;
      
      public var destroyed:Boolean = false;
      
      public var overrideNextAnimation:Boolean = false;
      
      public var disableMouseEventWhenAnimated:Boolean = false;
      
      public var useProgressiveLoading:Boolean = false;
      
      public var allowMovementThrough:Boolean = false;
      
      private var _lastRenderRequest:uint;
      
      private var _timeoutId:uint;
      
      public function TiphonSprite(look:TiphonEntityLook)
      {
         this._backgroundTemp = [];
         this._deactivatedSubEntityCategory = [];
         this._waitingEventInitList = new Vector.<Event>();
         this._lastRenderRequest = getTimer();
         super();
         if(!this._init && look != null)
         {
            this.init(look);
         }
      }
      
      public function get flipped() : Boolean
      {
         return this._flipped;
      }
      
      public function get tiphonEventManager() : TiphonEventsManager
      {
         if(this._tiphonEventManager == null)
         {
            throw new TiphonError("_tiphonEventManager is null, can\'t access so");
         }
         return this._tiphonEventManager;
      }
      
      override public function set visible(v:Boolean) : void
      {
         super.visible = v;
      }
      
      override public function set alpha(a:Number) : void
      {
         this._alpha = a;
         this.refreshAlpha();
      }
      
      public function refreshAlpha() : void
      {
         var m:Number = 1;
         var p:TiphonSprite = this.parentSprite;
         while(p)
         {
            m *= 1 / p.realAlpha;
            p = p.parentSprite;
         }
         super.alpha = this._alpha * m;
         var carried:TiphonSprite = (TiphonUtility.getEntityWithoutMount(this) as TiphonSprite).carriedEntity;
         if(carried)
         {
            carried.refreshAlpha();
         }
      }
      
      override public function get alpha() : Number
      {
         return this._alpha;
      }
      
      public function get realAlpha() : Number
      {
         return super.alpha;
      }
      
      override public function set mouseEnabled(enabled:Boolean) : void
      {
         this._savedMouseEnabled = enabled;
         super.mouseEnabled = enabled;
      }
      
      override public function get mouseEnabled() : Boolean
      {
         return this._savedMouseEnabled;
      }
      
      public function init(look:TiphonEntityLook) : void
      {
         var num:int = 0;
         var cat:* = null;
         var i:int = 0;
         var skin:uint = 0;
         var category:int = 0;
         var subIndex:* = undefined;
         var subEntity:TiphonSprite = null;
         this._libReady = false;
         this._background = [];
         this._backgroundTemp = [];
         this.scaleX = 1;
         this.scaleY = 1;
         this._look = look;
         this._lookCode = this._look.toString();
         this.skinModifier = this._look.skinModifier;
         this.initializeLibrary(look.getBone());
         this._subEntityBehaviors = [];
         this._currentAnimation = null;
         this._currentDirection = -1;
         this._customColoredParts = [];
         this._aTransformColors = [];
         this._aSubEntities = [];
         this._subEntitiesList = [];
         this._subEntitiesTemp = new Vector.<SubEntityTempInfo>();
         this._skin = new Skin();
         this._skin.addEventListener(Event.COMPLETE,this.checkRessourceState);
         this._animationModifier = [];
         var skinList:Vector.<uint> = this._look.getSkins(true);
         if(skinList)
         {
            num = skinList.length;
            for(i = 0; i < num; i++)
            {
               skin = skinList[i];
               skin = this._skin.add(skin,this._alternativeSkinIndex);
            }
         }
         var subEntitiesLook:Dictionary = this._look.getSubEntities(true);
         for(cat in subEntitiesLook)
         {
            category = int(cat);
            for(subIndex in subEntitiesLook[category])
            {
               if(subEntityHandler != null)
               {
                  if(!subEntityHandler.onSubEntityAdded(this,this._look.getSubEntity(category,subIndex),category,subIndex))
                  {
                     continue;
                  }
               }
               subEntity = new TiphonSprite(this._look.getSubEntity(category,subIndex));
               subEntity.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onSubEntityRendered,false,0,true);
               this.addSubEntity(subEntity,category,subIndex);
            }
         }
         this._look.addObserver(this);
         this.mouseChildren = false;
         this._tiphonEventManager = new TiphonEventsManager(this);
         this.destroyed = false;
         this._init = true;
         if(this._waitingEventInitList.length)
         {
            if(useEnterFrameDispatcher)
            {
               EnterFrameDispatcher.addEventListener(this.dispatchWaitingEvents,EnterFrameConst.DISPATCH_EVENTS_TIPHON_SPRITE);
            }
            else
            {
               StageShareManager.stage.addEventListener(Event.ENTER_FRAME,this.dispatchWaitingEvents);
            }
         }
      }
      
      public function get rect() : Rectangle
      {
         return this._rect;
      }
      
      public function get carriedEntity() : TiphonSprite
      {
         var carried:TiphonSprite = this._carriedEntity;
         if(!carried && this._subEntitiesList[0])
         {
            carried = this._subEntitiesList[0].carriedEntity;
         }
         return carried;
      }
      
      public function set carriedEntity(pTs:TiphonSprite) : void
      {
         this._carriedEntity = pTs;
      }
      
      public function set isCarrying(pIsCarrying:Boolean) : void
      {
         this._isCarrying = pIsCarrying;
      }
      
      public function get isCarrying() : Boolean
      {
         return this._isCarrying;
      }
      
      public function get bitmapData() : BitmapData
      {
         var bounds:Rectangle = getBounds(this);
         if(bounds.height * bounds.width == 0)
         {
            return null;
         }
         var bitmapdata:BitmapData = new BitmapData(bounds.right - bounds.left,bounds.bottom - bounds.top,true,22015);
         var m:Matrix = new Matrix();
         m.translate(-bounds.left,-bounds.top);
         bitmapdata.draw(this,m);
         return bitmapdata;
      }
      
      public function get look() : TiphonEntityLook
      {
         return this._look;
      }
      
      public function get rawAnimation() : TiphonAnimation
      {
         return this._animMovieClip;
      }
      
      public function get libraryIsAvailable() : Boolean
      {
         return this._libReady;
      }
      
      public function get skinIsAvailable() : Boolean
      {
         return this._skin.complete;
      }
      
      public function get parentSprite() : TiphonSprite
      {
         return this._parentSprite;
      }
      
      public function get rootEntity() : TiphonSprite
      {
         var currentSprite:TiphonSprite = this;
         while(currentSprite._parentSprite)
         {
            currentSprite = currentSprite._parentSprite;
         }
         return currentSprite;
      }
      
      public function get maxFrame() : uint
      {
         if(this._animMovieClip)
         {
            return this._animMovieClip.totalFrames;
         }
         return 0;
      }
      
      public function get framesLeft() : Number
      {
         if(this._animMovieClip === null)
         {
            return 0;
         }
         return this._animMovieClip.totalFrames - this._animMovieClip.currentFrame;
      }
      
      public function get animationModifiers() : Array
      {
         return this._animationModifier;
      }
      
      public function get animationList() : Array
      {
         var boneId:uint = this._look.getBone();
         if(BoneIndexManager.getInstance().hasCustomBone(boneId))
         {
            return BoneIndexManager.getInstance().getAllCustomAnimations(boneId);
         }
         var resource:Swl = Tiphon.skullLibrary.getResourceById(boneId);
         return !!resource ? resource.getDefinitions() : null;
      }
      
      public function set skinModifier(sm:ISkinModifier) : void
      {
         this._skinModifier = sm;
      }
      
      public function get skinModifier() : ISkinModifier
      {
         return this._skinModifier;
      }
      
      public function get rendered() : Boolean
      {
         return this._rendered;
      }
      
      public function isPlayingAnimation() : Boolean
      {
         var playing:* = false;
         if(this._animMovieClip)
         {
            playing = this._animMovieClip.currentFrame != this._animMovieClip.totalFrames;
         }
         return playing;
      }
      
      public function stopAnimation(frame:int = 0) : void
      {
         if(this._animMovieClip)
         {
            if(frame)
            {
               this._animMovieClip.gotoAndStop(frame);
            }
            else
            {
               this._animMovieClip.stop();
            }
            FpsControler.uncontrolFps(this._animMovieClip);
         }
      }
      
      public function stopAnimationAtLastFrame() : void
      {
         if(this._animMovieClip && this._rendered && this._lastAnimation == this._currentAnimation)
         {
            this.stopAnimationAtEnd();
            this.restartAnimation();
         }
         else
         {
            addEventListener(TiphonEvent.RENDER_SUCCEED,this.onLoadComplete);
         }
      }
      
      public function isCurrentAnimationStatic() : Boolean
      {
         return this._currentAnimation.indexOf("_Statique_") !== -1;
      }
      
      protected function onLoadComplete(pEvt:TiphonEvent) : void
      {
         removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onLoadComplete);
         var customStaticAnim:String = this._currentAnimation.indexOf("_Statique_") == -1 ? this._currentAnimation.replace("_","_Statique_") : null;
         var rider:TiphonSprite = this.getSubEntitySlot(2,0) as TiphonSprite;
         if(this._currentAnimation != "AnimStatique")
         {
            if(customStaticAnim && this.hasAnimation(customStaticAnim,this._currentDirection) || rider && rider.hasAnimation(customStaticAnim,rider.getDirection()))
            {
               this.setAnimation(customStaticAnim);
            }
            else
            {
               this.stopAnimation(this.maxFrame);
            }
         }
         this.visible = true;
         if(this.parentSprite)
         {
            this.parentSprite.visible = true;
         }
      }
      
      public function restartAnimation(frame:int = -1) : void
      {
         var lib:Swl = Tiphon.skullLibrary.getResourceById(this._look.getBone(),this._currentAnimation);
         if(this._animMovieClip && lib)
         {
            if(frame != -1)
            {
               this._animMovieClip.gotoAndStop(frame);
            }
            FpsControler.controlFps(this._animMovieClip,lib.frameRate);
         }
      }
      
      public function stopAnimationAtEnd() : void
      {
         var child:MovieClip = null;
         if(this._animMovieClip)
         {
            this._animMovieClip.gotoAndStop(this._animMovieClip.totalFrames);
            if(this._animMovieClip.numChildren)
            {
               child = this._animMovieClip.getChildAt(0) as MovieClip;
               if(child)
               {
                  child.gotoAndStop(child.totalFrames);
               }
            }
            FpsControler.uncontrolFps(this._animMovieClip);
            this._animMovieClip.cacheAsBitmap = true;
         }
      }
      
      public function setDirection(newDirection:uint) : void
      {
         if(this._currentAnimation)
         {
            this.setAnimationAndDirection(this._rawAnimation,newDirection);
         }
         else
         {
            this._currentDirection = newDirection;
         }
      }
      
      public function getDirection() : uint
      {
         return this._currentDirection > 0 ? uint(this._currentDirection) : uint(0);
      }
      
      public function setAnimation(newAnimation:String, startFrame:int = -1) : void
      {
         this._newAnimationStartFrame = startFrame;
         this.setAnimationAndDirection(newAnimation,this._currentDirection);
      }
      
      public function getAnimation() : String
      {
         return this._currentAnimation;
      }
      
      public function addAnimationModifier(modifier:IAnimationModifier, noDuplicate:Boolean = true) : void
      {
         if(!noDuplicate || this._animationModifier.indexOf(modifier) == -1)
         {
            this._animationModifier.push(modifier);
         }
         this._animationModifier.sortOn("priority",Array.NUMERIC);
      }
      
      public function removeAnimationModifier(modifier:IAnimationModifier) : void
      {
         var currentModifier:IAnimationModifier = null;
         var tmp:Array = [];
         for each(currentModifier in this._animationModifier)
         {
            if(modifier != currentModifier)
            {
               tmp.push(currentModifier);
            }
         }
         this._animationModifier = tmp;
      }
      
      public function removeAnimationModifierByClass(modifier:Class) : void
      {
         var currentModifier:IAnimationModifier = null;
         var tmp:Array = [];
         for each(currentModifier in this._animationModifier)
         {
            if(!(currentModifier is modifier))
            {
               tmp.push(currentModifier);
            }
         }
         this._animationModifier = tmp;
      }
      
      public function setAnimationAndDirection(animation:String, direction:uint, pDisableAnimModifier:Boolean = false) : void
      {
         var catId:* = null;
         var eListener:EventListener = null;
         var cat:Array = null;
         var subEntity:DisplayObject = null;
         var newAnimationName:String = null;
         var modifier:IAnimationModifier = null;
         var te:TiphonEvent = null;
         var transitionalAnim:String = null;
         var boneFileUri:Uri = null;
         if(animation != this._currentAnimation)
         {
            this.dispatchEvent(new TiphonEvent(TiphonEvent.ANIMATION_CHANGED,this));
         }
         if(this.destroyed)
         {
            return;
         }
         FpsManager.getInstance().startTracking("animation",40277);
         this._rawAnimation = animation;
         if(!animation)
         {
            animation = this._currentAnimation;
         }
         if(this is IEntity)
         {
            if(this._currentAnimation && (this._currentAnimation.indexOf("AnimMarche") == 0 || this._currentAnimation.indexOf("AnimCourse") == 0) && animation == "AnimStatique")
            {
               for each(eListener in TiphonEventsManager.listeners)
               {
                  eListener.listener.removeEntitySound(this as IEntity);
               }
            }
         }
         var behaviorData:BehaviorData = new BehaviorData(animation,direction,this);
         for(catId in this._aSubEntities)
         {
            cat = this._aSubEntities[catId];
            if(cat)
            {
               for each(subEntity in cat)
               {
                  if(subEntity is TiphonSprite)
                  {
                     if(this._subEntityBehaviors[catId])
                     {
                        (this._subEntityBehaviors[catId] as ISubEntityBehavior).updateFromParentEntity(TiphonSprite(subEntity),behaviorData);
                     }
                     else
                     {
                        this.updateFromParentEntity(TiphonSprite(subEntity),behaviorData);
                     }
                  }
               }
            }
         }
         if(this._animationModifier.length)
         {
            newAnimationName = behaviorData.animation;
            for each(modifier in this._animationModifier)
            {
               behaviorData.animation = modifier.getModifiedAnimation(newAnimationName,this.look);
            }
         }
         if(pDisableAnimModifier)
         {
            this._currentAnimation = animation;
            this.overrideNextAnimation = true;
         }
         if(!this.overrideNextAnimation && behaviorData.animation == this._currentAnimation && direction == this._currentDirection && this._rendered)
         {
            if(this._animMovieClip && this._animMovieClip.totalFrames > 1)
            {
               this.restartAnimation();
            }
            this._changeDispatched = true;
            if(this._subEntitiesList.length)
            {
               this.dispatchEvent(new TiphonEvent(TiphonEvent.RENDER_FATHER_SUCCEED,this));
            }
            te = new TiphonEvent(TiphonEvent.RENDER_SUCCEED,this);
            te.animationName = this._currentAnimation + "_" + this._currentDirection;
            this.dispatchEvent(te);
            return;
         }
         this.overrideNextAnimation = false;
         this._changeDispatched = false;
         this._lastAnimation = this._currentAnimation;
         this._currentDirection = direction;
         if(!pDisableAnimModifier)
         {
            if(BoneIndexManager.getInstance().hasTransition(this._look.getBone(),this._lastAnimation,behaviorData.animation,this._currentDirection))
            {
               transitionalAnim = BoneIndexManager.getInstance().getTransition(this._look.getBone(),this._lastAnimation,behaviorData.animation,this._currentDirection);
               this._currentAnimation = transitionalAnim;
               this._transitionStartAnimation = transitionalAnim;
               this._transitionEndAnimation = behaviorData.animation;
            }
            else
            {
               this._currentAnimation = behaviorData.animation;
            }
         }
         if(BoneIndexManager.getInstance().hasCustomBone(this._look.getBone()))
         {
            boneFileUri = BoneIndexManager.getInstance().getBoneFile(this._look.getBone(),this._currentAnimation);
            if(boneFileUri.fileName != this._look.getBone() + ".swl" || BoneIndexManager.getInstance().hasAnim(this._look.getBone(),this._currentAnimation,this._currentDirection))
            {
               this.initializeLibrary(this._look.getBone(),boneFileUri);
            }
            else
            {
               this._currentAnimation = !this._isCarrying ? "AnimStatique" : "AnimStatiqueCarrying";
            }
         }
         this._rendered = false;
         this.finalize();
         FpsManager.getInstance().stopTracking("animation");
      }
      
      public function setView(view:String) : void
      {
         this._customView = view;
         var infoSprite:DisplayObject = this.getDisplayInfoSprite(view);
         if(infoSprite)
         {
            if(this.mask != null && this.mask.parent)
            {
               this.mask.parent.removeChild(this.mask);
            }
            if(!infoSprite.parent)
            {
               addChild(infoSprite);
            }
            this.mask = infoSprite;
         }
      }
      
      public function getSubEntityBehavior(pCategory:int) : ISubEntityBehavior
      {
         return this._subEntityBehaviors[pCategory];
      }
      
      public function setSubEntityBehaviour(category:int, behaviour:ISubEntityBehavior) : void
      {
         this._subEntityBehaviors[category] = behaviour;
      }
      
      public function updateFromParentEntity(subEntity:TiphonSprite, parentData:BehaviorData) : void
      {
         if(!subEntity)
         {
            return;
         }
         var animExist:Boolean = false;
         var ad:Array = subEntity.getAvaibleDirection(parentData.animation);
         for(var i:int = 0; i < 8; i++)
         {
            animExist = ad[i] || animExist;
         }
         if(animExist || !this._libReady)
         {
            subEntity.setAnimationAndDirection(parentData.animation,parentData.direction);
         }
      }
      
      public function destroy() : void
      {
         var i:int = 0;
         var num:int = 0;
         var subEntity:TiphonSprite = null;
         var isCarriedEntity:Boolean = false;
         try
         {
            clearTimeout(this._timeoutId);
            if(!this.destroyed)
            {
               if(parent)
               {
                  parent.removeChild(this);
               }
               this.destroyed = true;
               this._parentSprite = null;
               if(this._look)
               {
                  this._look.removeObserver(this);
               }
               this.clearAnimation();
               if(this._tiphonEventManager)
               {
                  this._tiphonEventManager.destroy();
                  this._tiphonEventManager = null;
               }
               if(this._subEntitiesList.length)
               {
                  i = -1;
                  num = this._subEntitiesList.length;
                  while(++i < num)
                  {
                     subEntity = this._subEntitiesList[i] as TiphonSprite;
                     if(subEntity)
                     {
                        isCarriedEntity = this._aSubEntities["3"] && subEntity == this._aSubEntities["3"]["0"];
                        this.removeSubEntity(subEntity);
                        if(!isCarriedEntity)
                        {
                           subEntity.destroy();
                        }
                     }
                  }
               }
               if(this._subEntitiesTemp.length)
               {
                  i = -1;
                  num = this._subEntitiesTemp.length;
                  while(++i < num)
                  {
                     subEntity = this._subEntitiesTemp[i].entity as TiphonSprite;
                     if(subEntity)
                     {
                        subEntity.destroy();
                     }
                  }
                  this._subEntitiesTemp = null;
               }
               if(this._skin)
               {
                  this._skin.reset();
                  this._skin.removeEventListener(Event.COMPLETE,this.checkRessourceState);
                  this._skin = null;
               }
               this._subEntitiesList.length = 0;
               this._aSubEntities = null;
               this._subEntityBehaviors = null;
               this._customColoredParts = null;
               this._aTransformColors.length = 0;
               this._backgroundTemp = null;
               this._subEntitiesTemp.length = 0;
               this._background = [];
               this._animationModifier = null;
               this._currentDirection = -1;
               this._currentAnimation = null;
               this._rawAnimation = null;
               this._lastAnimation = null;
               this._lastClassName = null;
               this._transitionStartAnimation = null;
               this._transitionEndAnimation = null;
               this._rect = new Rectangle();
               this._init = false;
            }
         }
         catch(e:Error)
         {
            _log.fatal("TiphonSprite impossible à détruire !");
         }
      }
      
      public function getAvaibleDirection(anim:String = null, flipped:Boolean = false) : Array
      {
         var bone:uint = this._look.getBone();
         var isCustomBone:Boolean = BoneIndexManager.getInstance().hasCustomBone(bone);
         var lib:Swl = Tiphon.skullLibrary.getResourceById(bone);
         var res:Array = [];
         if(!lib)
         {
            return res;
         }
         for(var i:uint = 0; i < 8; i++)
         {
            if(!isCustomBone)
            {
               res[i] = lib.getDefinitions().indexOf((!!anim ? anim : this._currentAnimation) + "_" + i) != -1;
               if(flipped && !res[i])
               {
                  res[i] = lib.getDefinitions().indexOf((!!anim ? anim : this._currentAnimation) + "_" + TiphonUtility.getFlipDirection(i)) != -1;
               }
            }
            else
            {
               res[i] = Tiphon.skullLibrary.hasAnim(bone,anim,i);
               if(flipped && !res[i])
               {
                  res[i] = Tiphon.skullLibrary.hasAnim(bone,anim,TiphonUtility.getFlipDirection(i));
               }
            }
         }
         return res;
      }
      
      public function hasAnimation(anim:String, direction:int = -1) : Boolean
      {
         var i:int = 0;
         var subEntityLook:TiphonEntityLook = null;
         if(!anim)
         {
            anim = this._currentAnimation;
         }
         var result:Boolean = false;
         var bone:uint = this._look.getBone();
         if(direction != -1)
         {
            result = Tiphon.skullLibrary.hasAnim(bone,anim,direction) || Tiphon.skullLibrary.hasAnim(bone,anim,TiphonUtility.getFlipDirection(direction));
         }
         else
         {
            for(i = 0; i < 8; i++)
            {
               if(Tiphon.skullLibrary.hasAnim(bone,anim,i))
               {
                  result = true;
                  break;
               }
            }
         }
         if(!result)
         {
            subEntityLook = this._look.getSubEntity(2,0);
            if(subEntityLook)
            {
               bone = subEntityLook.getBone();
               if(direction != -1)
               {
                  result = Tiphon.skullLibrary.hasAnim(bone,anim,direction) || Tiphon.skullLibrary.hasAnim(bone,anim,TiphonUtility.getFlipDirection(direction));
               }
               else
               {
                  for(i = 0; i < 8; i++)
                  {
                     if(Tiphon.skullLibrary.hasAnim(bone,anim,i))
                     {
                        result = true;
                        break;
                     }
                  }
               }
            }
         }
         return result;
      }
      
      public function getSlot(name:String = "") : DisplayObject
      {
         var i:uint = 0;
         if(numChildren && this._animMovieClip)
         {
            for(i = 0; i < this._animMovieClip.numChildren; i++)
            {
               if(getQualifiedClassName(this._animMovieClip.getChildAt(i)).indexOf(name) == 0)
               {
                  return this._animMovieClip.getChildAt(i);
               }
            }
         }
         return null;
      }
      
      public function getColorTransform(index:uint) : ColorTransform
      {
         var ct:ColorTransform = null;
         if(this._aTransformColors[index])
         {
            return this._aTransformColors[index];
         }
         var c:DefaultableColor = this._look.getColor(index);
         if(!c.isDefault)
         {
            ct = new ColorTransform();
            ct.color = c.color;
            this._aTransformColors[index] = ct;
            return ct;
         }
         return null;
      }
      
      public function getSkinSprite(sprite:EquipmentSprite) : Sprite
      {
         if(!this._skin)
         {
            return null;
         }
         var className:String = getQualifiedClassName(sprite);
         if(this._skinModifier != null)
         {
            className = this._skinModifier.getModifiedSkin(this._skin,className,this._look);
         }
         return this._skin.getPart(className);
      }
      
      public function getPartTransformData(part:String) : TransformData
      {
         return !!this._skin ? this._skin.getTransformData(part) : null;
      }
      
      public function addSubEntity(entity:DisplayObject, category:uint, slot:uint) : void
      {
         var tiphonEntity:TiphonSprite = null;
         if(category == 3 && slot == 0)
         {
            this._carriedEntity = entity as TiphonSprite;
         }
         if(this._rendered)
         {
            entity.x = 0;
            entity.y = 0;
            tiphonEntity = entity as TiphonSprite;
            if(tiphonEntity)
            {
               tiphonEntity._parentSprite = this;
               tiphonEntity.overrideNextAnimation = true;
               tiphonEntity.setDirection(this._currentDirection);
            }
            if(!this._aSubEntities[category])
            {
               this._aSubEntities[category] = [];
            }
            this._aSubEntities[category][slot] = entity;
            this.dispatchEvent(new TiphonEvent(TiphonEvent.SUB_ENTITY_ADDED,this));
            this._subEntitiesList.push(entity);
            _log.info("Add subentity " + entity.name + " to " + name + " (cat: " + category + ")");
            if(this._recursiveAlternativeSkinIndex && tiphonEntity)
            {
               tiphonEntity.setAlternativeSkinIndex(this._alternativeSkinIndex);
            }
            this.finalize();
         }
         else
         {
            this._subEntitiesTemp.push(new SubEntityTempInfo(entity,category,slot));
         }
      }
      
      public function removeSubEntity(entity:DisplayObject) : void
      {
         var found:Boolean = false;
         var i:* = null;
         var index:int = 0;
         var j:* = null;
         if(entity == this._carriedEntity)
         {
            this._carriedEntity = null;
            this._isCarrying = false;
         }
         if(this.destroyed)
         {
            return;
         }
         for(i in this._aSubEntities)
         {
            for(j in this._aSubEntities[i])
            {
               if(entity === this._aSubEntities[i][j])
               {
                  if(this._subEntityBehaviors[i] is ISubEntityBehavior)
                  {
                     ISubEntityBehavior(this._subEntityBehaviors[i]).remove();
                  }
                  delete this._subEntityBehaviors[i];
                  delete this._aSubEntities[i][j];
                  found = true;
                  break;
               }
            }
            if(found)
            {
               break;
            }
         }
         index = this._subEntitiesList.indexOf(entity);
         if(index != -1)
         {
            this._subEntitiesList.splice(index,1);
         }
         var tiphonSprite:TiphonSprite = entity as TiphonSprite;
         if(tiphonSprite)
         {
            tiphonSprite._parentSprite = null;
            tiphonSprite.overrideNextAnimation = true;
         }
      }
      
      public function getSubEntitySlot(category:uint, slot:uint) : DisplayObjectContainer
      {
         if(this.destroyed)
         {
            return null;
         }
         if(this._aSubEntities[category] && this._aSubEntities[category][slot])
         {
            if(this._aSubEntities[category][slot] is TiphonSprite)
            {
               (this._aSubEntities[category][slot] as TiphonSprite)._parentSprite = this;
            }
            return this._aSubEntities[category][slot];
         }
         return null;
      }
      
      public function getSubEntitiesList() : Array
      {
         return this._subEntitiesList;
      }
      
      public function getTmpSubEntitiesNb() : uint
      {
         return this._subEntitiesTemp.length;
      }
      
      public function registerColoredSprite(sprite:ColoredSprite, nColorIndex:uint) : void
      {
         if(!this._customColoredParts[nColorIndex])
         {
            this._customColoredParts[nColorIndex] = new Dictionary(true);
         }
         this._customColoredParts[nColorIndex][sprite] = 1;
      }
      
      public function registerInfoSprite(sprite:DisplayInfoSprite, nViewIndex:String) : void
      {
         if(nViewIndex == this._customView)
         {
            this.setView(nViewIndex);
         }
      }
      
      public function getDisplayInfoSprite(nViewIndex:String) : DisplayObject
      {
         if(!this._animMovieClip)
         {
            return null;
         }
         return (this._animMovieClip as ScriptedAnimation).getDisplayInfoSprite(nViewIndex);
      }
      
      public function addBackground(name:String, sprite:DisplayObject, posAuto:Boolean = false) : void
      {
         var pos:Rectangle = null;
         if(!this._background[name])
         {
            this._background[name] = sprite;
            if(this._rendered)
            {
               if(posAuto)
               {
                  pos = this.getRect(this);
                  sprite.y = pos.y - 10;
               }
               addChildAt(sprite,0);
               this.updateScale();
            }
            else
            {
               this._backgroundTemp.push(sprite,posAuto);
            }
         }
      }
      
      public function removeBackground(name:String) : void
      {
         var i:int = 0;
         if(this._rendered && this._background[name])
         {
            if(this.getChildByName(this._background[name].name))
            {
               removeChild(this._background[name]);
            }
         }
         var nbTempBgClips:int = this._backgroundTemp.length;
         for(i = 0; i < nbTempBgClips; i += 2)
         {
            if(this._backgroundTemp[i] == this._background[name])
            {
               this._backgroundTemp.splice(i,2);
               break;
            }
         }
         this._background[name] = null;
      }
      
      public function getBackground(pBackgroundName:String) : DisplayObject
      {
         return this._background[pBackgroundName];
      }
      
      public function showOnlyBackground(pOnlyBackground:Boolean) : void
      {
         this._backgroundOnly = pOnlyBackground;
         if(pOnlyBackground && this._animMovieClip && contains(this._animMovieClip))
         {
            removeChild(this._animMovieClip);
         }
         else if(!pOnlyBackground && this._animMovieClip)
         {
            addChild(this._animMovieClip);
         }
      }
      
      public function isShowingOnlyBackground() : Boolean
      {
         return this._backgroundOnly;
      }
      
      public function setAlternativeSkinIndex(index:int = -1, recursiveAlternativeSkinIndex:Boolean = false) : void
      {
         var i:int = 0;
         var num:int = 0;
         var entity:TiphonSprite = null;
         this._recursiveAlternativeSkinIndex = recursiveAlternativeSkinIndex;
         if(this._recursiveAlternativeSkinIndex)
         {
            i = -1;
            num = this._subEntitiesList.length;
            while(++i < num)
            {
               entity = this._subEntitiesList[i] as TiphonSprite;
               if(entity)
               {
                  entity.setAlternativeSkinIndex(index);
               }
            }
         }
         if(index != this._alternativeSkinIndex)
         {
            this._alternativeSkinIndex = index;
            this.resetSkins();
         }
      }
      
      public function getAlternativeSkinIndex() : int
      {
         return this._alternativeSkinIndex;
      }
      
      public function getGlobalScale() : Number
      {
         var globalScale:Number = 1;
         var currentParentSprite:TiphonSprite = this.parentSprite;
         while(currentParentSprite)
         {
            globalScale *= !!currentParentSprite._animMovieClip ? currentParentSprite._animMovieClip.scaleX : 1;
            currentParentSprite = currentParentSprite.parentSprite;
         }
         return globalScale;
      }
      
      public function reprocessSkin() : void
      {
         if(this._skin)
         {
            this._skin.reprocess();
         }
      }
      
      private function initializeLibrary(gfxId:uint, file:Uri = null) : void
      {
         if(!file)
         {
            if(BoneIndexManager.getInstance().hasCustomBone(gfxId))
            {
               return;
            }
            file = new Uri(TiphonConstants.SWF_SKULL_PATH + gfxId + ".swl");
         }
         this._libReady = false;
         Tiphon.skullLibrary.addResource(gfxId,file);
         Tiphon.skullLibrary.askResource(gfxId,this._currentAnimation,new Callback(this.onSkullLibraryReady,gfxId),new Callback(this.onSkullLibraryError));
      }
      
      private function applyColor(index:uint) : void
      {
         var colorTransform:ColorTransform = null;
         var coloredPart:ColoredSprite = null;
         var coloredPartKey:* = undefined;
         var coloredParts:Dictionary = this._customColoredParts[index];
         if(coloredParts)
         {
            colorTransform = this.getColorTransform(index);
            for(coloredPartKey in coloredParts)
            {
               coloredPart = coloredPartKey as ColoredSprite;
               coloredPart.colorize(colorTransform);
            }
         }
      }
      
      private function resetSkins() : void
      {
         var skin:uint = 0;
         this._skin.validate = false;
         this._skin.reset();
         for each(skin in this._look.getSkins(true))
         {
            skin = this._skin.add(skin,this._alternativeSkinIndex);
         }
         this._skin.validate = true;
      }
      
      private function resetSubEntities() : void
      {
         var mountCarriedEntity:TiphonSprite = null;
         var subEntitiesCategory:* = null;
         var entity:TiphonSprite = null;
         var subEntityIndex:* = null;
         var subEntityLook:TiphonEntityLook = null;
         var subEntity:TiphonSprite = null;
         while(this._subEntitiesList.length)
         {
            entity = this._subEntitiesList.shift() as TiphonSprite;
            if(entity && !(this._carriedEntity && entity == this._carriedEntity))
            {
               if(this._aSubEntities["2"] && this._aSubEntities["2"]["0"] && entity == this._aSubEntities["2"]["0"])
               {
                  if(this._deactivatedSubEntityCategory.indexOf("2") != -1 && entity.carriedEntity)
                  {
                     this._carriedEntity = entity.carriedEntity;
                  }
                  else
                  {
                     mountCarriedEntity = entity.getSubEntitySlot(3,0) as TiphonSprite;
                  }
               }
               entity.destroy();
            }
         }
         this._aSubEntities = [];
         var subEntities:Dictionary = this._look.getSubEntities(true);
         for(subEntitiesCategory in subEntities)
         {
            if(this._deactivatedSubEntityCategory.indexOf(subEntitiesCategory) == -1)
            {
               if(subEntitiesCategory == "2" && this._carriedEntity)
               {
                  mountCarriedEntity = this._carriedEntity;
                  this.removeSubEntity(this._carriedEntity);
               }
               for(subEntityIndex in subEntities[subEntitiesCategory])
               {
                  subEntityLook = subEntities[subEntitiesCategory][subEntityIndex];
                  if(subEntityHandler != null)
                  {
                     if(!subEntityHandler.onSubEntityAdded(this,subEntityLook,parseInt(subEntitiesCategory),parseInt(subEntityIndex)))
                     {
                        continue;
                     }
                  }
                  subEntity = new TiphonSprite(subEntityLook);
                  subEntity.setAnimationAndDirection("AnimStatique",this._currentDirection);
                  if(!subEntity.rendered)
                  {
                     subEntity.addEventListener(TiphonEvent.RENDER_SUCCEED,this.onSubEntityRendered,false,0,true);
                  }
                  this.addSubEntity(subEntity,parseInt(subEntitiesCategory),parseInt(subEntityIndex));
                  if(parseInt(subEntitiesCategory) == 2 && parseInt(subEntityIndex) == 0 && mountCarriedEntity)
                  {
                     subEntity.isCarrying = true;
                     subEntity.addSubEntity(mountCarriedEntity,3,0);
                  }
               }
            }
         }
         if(this._carriedEntity)
         {
            if(!this._aSubEntities["3"])
            {
               this._aSubEntities["3"] = [];
            }
            this._aSubEntities["3"]["0"] = this._carriedEntity;
            this._subEntitiesList.push(entity);
         }
      }
      
      protected function finalize() : void
      {
         if(this.destroyed)
         {
            return;
         }
         Tiphon.skullLibrary.askResource(this._look.getBone(),this._currentAnimation,new Callback(this.checkRessourceState),new Callback(this.onRenderFail));
      }
      
      protected function checkRessourceState(e:Event = null) : void
      {
         Tiphon.skullLibrary.removeEventListener(SwlEvent.SWL_LOADED,this.checkRessourceState);
         if(this.destroyed)
         {
            return;
         }
         if((this._skin.complete || this.useProgressiveLoading && this._lastRenderRequest > 60) && this._currentAnimation != null && Tiphon.skullLibrary.isLoaded(this._look.getBone(),this._currentAnimation) && this._currentDirection >= 0)
         {
            this.render();
         }
         this._lastRenderRequest = getTimer();
      }
      
      protected function render() : void
      {
         var bgElement:DisplayObject = null;
         var outterSubEntity:DisplayObject = null;
         var currentBone:int = 0;
         var log:String = null;
         var defaultAnimation:String = null;
         var defaultOrientation:uint = 0;
         var carrying:int = 0;
         var dirs:Array = null;
         var dir:* = undefined;
         var sprite:Sprite = null;
         var pos:Rectangle = null;
         var subEntityInfo:SubEntityTempInfo = null;
         var tiphonSprite:TiphonSprite = null;
         var animList:Array = null;
         var subEntityAnimation:String = null;
         var l:int = 0;
         var animName:String = null;
         var i:int = 0;
         if(this.destroyed)
         {
            return;
         }
         FpsManager.getInstance().startTracking("animation",40277);
         var animClass:Class = null;
         var lib:Swl = Tiphon.skullLibrary.getResourceById(this._look.getBone(),this._currentAnimation);
         var finalDirection:int = this._currentDirection;
         if(this.parentSprite)
         {
            if(this.getGlobalScale() < 0)
            {
               finalDirection = TiphonUtility.getFlipDirection(finalDirection);
            }
         }
         this._flipped = false;
         var className:String = this._currentAnimation + "_" + finalDirection;
         if(lib.hasDefinition(className))
         {
            animClass = lib.getDefinition(className) as Class;
         }
         else
         {
            className = this._currentAnimation + "_" + TiphonUtility.getFlipDirection(finalDirection);
            if(lib.hasDefinition(className))
            {
               animClass = lib.getDefinition(className) as Class;
               this._flipped = true;
            }
         }
         if(animClass == null)
         {
            log = "Class [" + this._currentAnimation + "_" + finalDirection + "] or [" + this._currentAnimation + "_" + TiphonUtility.getFlipDirection(finalDirection) + "] cannot be found in library " + this._look.getBone();
            _log.error(log);
            defaultAnimation = SubstituteAnimationManager.getDefaultAnimation(this._currentAnimation);
            defaultOrientation = this._currentDirection;
            if(defaultAnimation)
            {
               dirs = this.getAvaibleDirection(defaultAnimation,true);
               for(dir in dirs)
               {
                  if(dirs[dir])
                  {
                     defaultOrientation = int(dir);
                     break;
                  }
               }
            }
            carrying = this._currentAnimation.indexOf("Carrying");
            if(!defaultAnimation && carrying != -1)
            {
               defaultAnimation = this._currentAnimation.substring(0,carrying);
            }
            if(defaultAnimation && this._currentAnimation != defaultAnimation)
            {
               _log.error("On ne trouve cette animation, on va jouer l\'animation " + defaultAnimation + "_" + this._currentDirection + " à la place.");
               this.setAnimationAndDirection(defaultAnimation,this._currentDirection,true);
            }
            else if(defaultAnimation && this._currentAnimation == defaultAnimation && this._currentDirection != defaultOrientation)
            {
               _log.error("On ne trouve pas cette animation dans cette direction, on va jouer l\'animation " + defaultAnimation + "_" + defaultOrientation + " à la place.");
               this.setAnimationAndDirection(defaultAnimation,defaultOrientation,true);
            }
            else
            {
               this.onRenderFail();
            }
            return;
         }
         if((this._lastAnimation == "AnimPickup" || this._lastAnimation == "AnimStatiqueCarrying") && this._currentAnimation == "AnimStatiqueCarrying")
         {
            this._isCarrying = true;
         }
         var gotoFrame:int = -1;
         if(this._currentAnimation == this._lastClassName && this._animMovieClip)
         {
            gotoFrame = this._animMovieClip.currentFrame;
         }
         else if(this._newAnimationStartFrame != -1)
         {
            gotoFrame = this._newAnimationStartFrame;
            this._newAnimationStartFrame = -1;
         }
         this._lastClassName = this._currentAnimation;
         this.clearAnimation();
         for each(bgElement in this._background)
         {
            if(bgElement)
            {
               addChild(bgElement);
            }
         }
         for each(outterSubEntity in this._aSubEntities[99])
         {
            if(outterSubEntity)
            {
               addChild(outterSubEntity);
            }
         }
         this._customColoredParts = [];
         ScriptedAnimation.currentSpriteHandler = this;
         currentBone = this._look.getBone();
         if(Tiphon.getInstance().useOptimization && Tiphon.getInstance().options.getOption("useAnimationCache") && TiphonCacheManager.getInstance().hasCache(this._currentAnimation,this._lookCode) && (!this._aSubEntities.length && this._subEntitiesTemp.length <= 0))
         {
            this._animMovieClip = TiphonCacheManager.getInstance().getScriptedAnimation(currentBone,this._currentAnimation,finalDirection,this._lookCode);
            (this._animMovieClip as ScriptedAnimation).init();
            this.restartAnimation();
         }
         else
         {
            this._animMovieClip = new animClass() as ScriptedAnimation;
            (this._animMovieClip as ScriptedAnimation).bone = currentBone;
            (this._animMovieClip as ScriptedAnimation).animationName = this._currentAnimation;
            (this._animMovieClip as ScriptedAnimation).direction = finalDirection;
         }
         if(StageShareManager.rootContainer)
         {
            StageShareManager.rootContainer.dispatchEvent(new ScriptedAnimationEvent(ScriptedAnimationEvent.SCRIPTED_ANIMATION_ADDED,this));
         }
         ScriptedAnimation.currentSpriteHandler = null;
         MEMORY_LOG2[this._animMovieClip] = 1;
         if(!this._animMovieClip)
         {
            _log.error("Class [" + this._currentAnimation + "_" + finalDirection + "] is not a ScriptedAnimation");
            return;
         }
         this._animMovieClip.addEventListener(Event.ADDED_TO_STAGE,this.onAdded);
         if(this._flipped && this._animMovieClip.scaleX > 0)
         {
            this._animMovieClip.scaleX *= -1;
         }
         else if(!this._flipped && this._animMovieClip.scaleX < 0)
         {
            this._animMovieClip.scaleX *= -1;
         }
         var isSingleFrame:Boolean = MovieClipUtils.isSingleFrame(this._animMovieClip);
         this._animMovieClip.cacheAsBitmap = isSingleFrame;
         if(this.disableMouseEventWhenAnimated)
         {
            super.mouseEnabled = isSingleFrame && this.mouseEnabled;
         }
         if(!this._backgroundOnly)
         {
            this.addChild(this._animMovieClip);
         }
         if((this._currentAnimation.indexOf("AnimStatique") != -1 || this._currentAnimation.indexOf("AnimState") != -1) && this._currentAnimation.indexOf("_to_") == -1 && !isSingleFrame)
         {
            _log.error("/!\\ ATTENTION, l\'animation [" + this._currentAnimation + "_" + finalDirection + "] sur le squelette [" + this._look.getBone() + "] contient un clip qui contient plusieurs frames. C\'est mal.");
         }
         if(!isSingleFrame)
         {
            FpsControler.controlFps(this._animMovieClip,lib.frameRate);
         }
         this._animMovieClip.addEventListener(AnimationEvent.EVENT,this.animEventHandler);
         this._animMovieClip.addEventListener(AnimationEvent.ANIM,this.animSwitchHandler);
         if(!isSingleFrame && gotoFrame != -1)
         {
            this._animMovieClip.gotoAndStop(gotoFrame);
            if(this._animMovieClip is ScriptedAnimation)
            {
               (this._animMovieClip as ScriptedAnimation).playEventAtFrame(gotoFrame);
            }
         }
         this._rendered = true;
         if(this._subEntitiesList.length)
         {
            this.dispatchEvent(new TiphonEvent(TiphonEvent.RENDER_FATHER_SUCCEED,this));
         }
         var nbb:int = this._backgroundTemp.length;
         for(var m:int = 0; m < nbb; m += 2)
         {
            sprite = this._backgroundTemp.shift();
            if(this._backgroundTemp.shift())
            {
               pos = this.getRect(this);
               sprite.y = pos.y - 10;
            }
            addChildAt(sprite,0);
         }
         while(this._subEntitiesTemp.length)
         {
            subEntityInfo = this._subEntitiesTemp.shift();
            tiphonSprite = subEntityInfo.entity as TiphonSprite;
            if(tiphonSprite && !tiphonSprite._currentAnimation)
            {
               animList = tiphonSprite.animationList;
               subEntityAnimation = "AnimStatique";
               if(animList && animList.length)
               {
                  l = animList.length;
                  for(i = 0; i < l; i++)
                  {
                     animName = animList[i];
                     if(animName && animName == this._currentAnimation)
                     {
                        subEntityAnimation = animName;
                        break;
                     }
                  }
               }
               tiphonSprite._currentAnimation = subEntityAnimation;
            }
            this.addSubEntity(subEntityInfo.entity,subEntityInfo.category,subEntityInfo.slot);
         }
         FpsManager.getInstance().stopTracking("animation");
         this._rect = this.getRect(this);
         this.checkRenderState();
      }
      
      public function forceRender() : void
      {
         var lib:Swl = Tiphon.skullLibrary.getResourceById(this._look.getBone(),this._currentAnimation,true);
         if(lib == null)
         {
            Tiphon.skullLibrary.addEventListener(SwlEvent.SWL_LOADED,this.checkRessourceState);
         }
         else
         {
            this.checkRessourceState();
         }
      }
      
      protected function clearAnimation() : void
      {
         var num:int = 0;
         var i:int = 0;
         if(this._animMovieClip)
         {
            this._animMovieClip.removeEventListener(AnimationEvent.EVENT,this.animEventHandler);
            this._animMovieClip.removeEventListener(AnimationEvent.ANIM,this.animSwitchHandler);
            this._animMovieClip.removeEventListener(Event.ADDED_TO_STAGE,this.onAdded);
            FpsControler.uncontrolFps(this._animMovieClip);
            if(this._animMovieClip.parent)
            {
               removeChild(this._animMovieClip);
            }
            if(!Tiphon.getInstance().useOptimization || !Tiphon.getInstance().options.getOption("useAnimationCache") || this._aSubEntities.length || this._subEntitiesTemp.length > 0)
            {
               TiphonFpsManager.addOldScriptedAnimation(this._animMovieClip as ScriptedAnimation,true);
               if(this._animMovieClip is ScriptedAnimation)
               {
                  (this._animMovieClip as ScriptedAnimation).destroy();
               }
               num = this._animMovieClip.numChildren;
               i = -1;
               while(++i < num)
               {
                  this._animMovieClip.removeChildAt(0);
               }
            }
            else
            {
               this._animMovieClip.gotoAndStop(1);
               TiphonCacheManager.getInstance().pushScriptedAnimation(this._animMovieClip as ScriptedAnimation,this._lookCode);
            }
            this._animMovieClip = null;
         }
         while(numChildren)
         {
            this.removeChildAt(0);
         }
      }
      
      private function animEventHandler(event:AnimationEvent) : void
      {
         this.dispatchEvent(new TiphonEvent(event.id,this));
         this.dispatchEvent(new TiphonEvent(TiphonEvent.ANIMATION_EVENT,this));
      }
      
      private function animSwitchHandler(event:AnimationEvent) : void
      {
         this.setAnimation(event.id);
      }
      
      override public function dispatchEvent(event:Event) : Boolean
      {
         var anim:String = null;
         if(event.type == TiphonEvent.ANIMATION_END && this._transitionEndAnimation)
         {
            if(this._transitionStartAnimation == this._currentAnimation)
            {
               super.dispatchEvent(new TiphonEvent(TiphonEvent.ANIMATION_TRANSITION_END,(event as TiphonEvent).sprite,(event as TiphonEvent).params));
               anim = this._transitionEndAnimation;
               this._transitionEndAnimation = null;
               this.setAnimation(anim);
               return false;
            }
            _log.debug("/!\\ Cut a transition anim! from " + this._transitionStartAnimation + " to " + this._transitionEndAnimation + " in profit of " + this._currentAnimation);
            this._transitionStartAnimation = null;
            this._transitionEndAnimation = null;
         }
         return super.dispatchEvent(event);
      }
      
      private function checkRenderState() : void
      {
         var subEntity:DisplayObject = null;
         for each(subEntity in this._subEntitiesList)
         {
            if(subEntity is TiphonSprite && !TiphonSprite(subEntity)._rendered)
            {
               return;
            }
         }
         if(!this._skin || !this._skin.complete)
         {
            return;
         }
         var te:TiphonEvent = new TiphonEvent(TiphonEvent.RENDER_SUCCEED,this);
         te.animationName = this._currentAnimation + "_" + this._currentDirection;
         if(!this._changeDispatched)
         {
            this._changeDispatched = true;
            this._timeoutId = setTimeout(this.dispatchEvent,1,te);
         }
      }
      
      private function updateScale() : void
      {
         var bg:DisplayObject = null;
         if(!this._animMovieClip)
         {
            return;
         }
         var valueX:int = this._animMovieClip.scaleX >= 0 ? 1 : -1;
         var valueY:int = this._animMovieClip.scaleY >= 0 ? 1 : -1;
         var ent:DisplayObject = this;
         var parentSprite:TiphonSprite = null;
         while(ent.parent)
         {
            valueX *= ent.parent.scaleX >= 0 ? 1 : -1;
            valueY *= ent.parent.scaleY >= 0 ? 1 : -1;
            if(ent.parent is TiphonSprite && parentSprite == null)
            {
               parentSprite = ent.parent as TiphonSprite;
            }
            ent = ent.parent;
         }
         var parentLook:TiphonEntityLook = !!parentSprite ? parentSprite.look : null;
         if(parentLook && (parentLook.getScaleX() != 1 || parentLook.getScaleY() != 1))
         {
            this._animMovieClip.scaleX = this.look.getScaleX() / parentLook.getScaleX() * (this._animMovieClip.scaleX < 0 ? -1 : 1);
            this._animMovieClip.scaleY = this.look.getScaleY() / parentLook.getScaleY();
         }
         else
         {
            this._animMovieClip.scaleX = this.look.getScaleX() * (this._animMovieClip.scaleX < 0 ? -1 : 1);
            this._animMovieClip.scaleY = this.look.getScaleY();
         }
         for each(bg in this._background)
         {
            if(bg)
            {
               if(parentLook)
               {
                  bg.scaleX = 1 / parentLook.getScaleX() * valueX;
                  bg.scaleY = 1 / parentLook.getScaleY() * valueY;
               }
               else
               {
                  bg.scaleX = bg.scaleY = 1;
               }
            }
         }
      }
      
      private function dispatchWaitingEvents(e:Event) : void
      {
         if(useEnterFrameDispatcher)
         {
            EnterFrameDispatcher.removeEventListener(this.dispatchWaitingEvents);
         }
         else
         {
            StageShareManager.stage.removeEventListener(Event.ENTER_FRAME,this.dispatchWaitingEvents);
         }
         while(this._waitingEventInitList.length)
         {
            this.dispatchEvent(this._waitingEventInitList.shift());
         }
      }
      
      public function onAnimationEvent(eventName:String, params:String = "") : void
      {
         var entity:DisplayObject = null;
         var subAnimEvent:TiphonEvent = null;
         var subEvent:TiphonEvent = null;
         if(eventName == TiphonEvent.PLAYER_STOP)
         {
            this.stopAnimation();
         }
         var event:TiphonEvent = new TiphonEvent(eventName,this,params);
         var animEvent:TiphonEvent = new TiphonEvent(TiphonEvent.ANIMATION_EVENT,this);
         if(this._init)
         {
            this.dispatchEvent(event);
            this.dispatchEvent(animEvent);
         }
         else
         {
            this._waitingEventInitList.push(event,animEvent);
         }
         for each(entity in this._subEntitiesList)
         {
            if(entity is TiphonSprite)
            {
               if((entity as TiphonSprite)._isCarrying && eventName != TiphonEvent.PLAYER_STOP)
               {
                  subAnimEvent = new TiphonEvent(TiphonEvent.ANIMATION_EVENT,entity);
                  entity.dispatchEvent(subAnimEvent);
                  subEvent = new TiphonEvent(eventName,entity,params);
                  entity.dispatchEvent(subEvent);
               }
            }
         }
         if(eventName != TiphonEvent.PLAYER_STOP && this.parentSprite)
         {
            this.parentSprite.onAnimationEvent(eventName,params);
         }
      }
      
      private function onRenderFail() : void
      {
         var event:TiphonEvent = new TiphonEvent(TiphonEvent.RENDER_FAILED,this);
         if(this._init)
         {
            this.dispatchEvent(event);
         }
         else
         {
            this._waitingEventInitList.push(event);
         }
         TiphonDebugManager.displayDofusScriptError("Rendu impossible : " + this._currentAnimation + ", " + this._currentDirection,this);
      }
      
      private function onSubEntityRendered(e:Event) : void
      {
         e.currentTarget.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onSubEntityRendered);
         this.checkRenderState();
      }
      
      private function onSkullLibraryReady(pBoneId:uint) : void
      {
         this._libReady = true;
         var event:TiphonEvent = new TiphonEvent(TiphonEvent.SPRITE_INIT,this,pBoneId);
         if(this._init)
         {
            this.dispatchEvent(event);
         }
         else
         {
            this._waitingEventInitList.push(event);
         }
      }
      
      private function onSkullLibraryError() : void
      {
         var event:TiphonEvent = new TiphonEvent(TiphonEvent.SPRITE_INIT_FAILED,this);
         if(this._init)
         {
            this.dispatchEvent(event);
         }
         else
         {
            this._waitingEventInitList.push(event);
         }
         TiphonDebugManager.displayDofusScriptError("Initialisation impossible : " + this._currentAnimation + ", " + this._currentDirection,this);
      }
      
      protected function onAdded(e:Event) : void
      {
         var carriedSprite:CarriedSprite = null;
         var child:DisplayObject = null;
         var splitedName:Array = null;
         this.updateScale();
         var nc:int = this._animMovieClip.numChildren;
         for(var i:int = 0; i < nc; i++)
         {
            child = this._animMovieClip.getChildAt(i);
            if(child is CarriedSprite)
            {
               splitedName = getQualifiedClassName(child).split("_");
               if(splitedName[1] == "3" && splitedName[2] == "0")
               {
                  carriedSprite = this._animMovieClip.getChildAt(i) as CarriedSprite;
               }
            }
         }
         if(this._isCarrying && this._carriedEntity)
         {
            if(carriedSprite)
            {
               this._carriedEntity.y = this._carriedEntity.x = 0;
               this._carriedEntity.setDirection(this._currentDirection);
               carriedSprite.addChild(this._carriedEntity);
            }
            else if(this._animMovieClip.width > 0 && this._animMovieClip.height > 0)
            {
               if(this._carriedEntity.parent == this._animMovieClip)
               {
                  this._animMovieClip.removeChild(this._carriedEntity);
               }
               this._carriedEntity.y = -(this._animMovieClip.localToGlobal(_point).y - this._animMovieClip.getBounds(StageShareManager.stage).y);
               this._animMovieClip.addChild(this._carriedEntity);
            }
         }
         if(this._carriedEntity && (e.target.animationName === "AnimPickup" || e.target.animationName === "AnimDrop"))
         {
            this._lastCarriedEntity = this._carriedEntity;
            this._lastCarriedEntity.dispatchEvent(new TiphonEvent(TiphonEvent.ANIMATION_PICKUP_START,this));
         }
         else if(this._lastAnimation === "AnimDrop" && this._lastCarriedEntity)
         {
            this._lastCarriedEntity.dispatchEvent(new TiphonEvent(TiphonEvent.ANIMATION_PICKUP_END,this));
            this._lastCarriedEntity = null;
         }
         this.dispatchEvent(new TiphonEvent(TiphonEvent.ANIMATION_ADDED,this));
      }
      
      public function boneChanged(look:TiphonEntityLook) : void
      {
         if(Tiphon.getInstance().useOptimization && Tiphon.getInstance().options.getOption("useAnimationCache"))
         {
            this.clearAnimation();
         }
         this._look = look;
         this._lookCode = this._look.toString();
         this._tiphonEventManager = new TiphonEventsManager(this);
         this._rendered = false;
         var boneFileUri:Uri = BoneIndexManager.getInstance().getBoneFile(this._look.getBone(),this._currentAnimation);
         if(BoneIndexManager.getInstance().hasCustomBone(this._look.getBone()))
         {
            if(boneFileUri.fileName != this._look.getBone() + ".swl" || BoneIndexManager.getInstance().hasAnim(this._look.getBone(),this._currentAnimation,this._currentDirection))
            {
               this.initializeLibrary(look.getBone(),boneFileUri);
               this.setAnimation(this._rawAnimation);
            }
            else
            {
               this.setAnimationAndDirection("AnimStatique",this._currentDirection,true);
            }
         }
         else
         {
            this.initializeLibrary(look.getBone(),boneFileUri);
            this.setAnimation(this._rawAnimation);
         }
      }
      
      public function skinsChanged(look:TiphonEntityLook) : void
      {
         if(Tiphon.getInstance().useOptimization && Tiphon.getInstance().options.getOption("useAnimationCache"))
         {
            this.clearAnimation();
         }
         this._look = look;
         this._lookCode = this._look.toString();
         this._rendered = false;
         this.resetSkins();
         this.finalize();
      }
      
      public function colorsChanged(look:TiphonEntityLook) : void
      {
         var colorIndex:* = null;
         if(Tiphon.getInstance().useOptimization && Tiphon.getInstance().options.getOption("useAnimationCache"))
         {
            this.clearAnimation();
         }
         this._look = look;
         this._lookCode = this._look.toString();
         this._aTransformColors.length = 0;
         if(Tiphon.getInstance().useOptimization && Tiphon.getInstance().options.getOption("useAnimationCache"))
         {
            this.finalize();
         }
         else
         {
            for(colorIndex in this._customColoredParts)
            {
               this.applyColor(uint(colorIndex));
            }
         }
      }
      
      public function scalesChanged(look:TiphonEntityLook) : void
      {
         this._look = look;
         this._lookCode = this._look.toString();
         if(this._animMovieClip != null)
         {
            this.updateScale();
         }
      }
      
      public function subEntitiesChanged(look:TiphonEntityLook) : void
      {
         this._look = look;
         this._lookCode = this._look.toString();
         this.resetSubEntities();
         this.finalize();
      }
      
      public function enableSubCategory(catId:int, isEnabled:Boolean = true) : void
      {
         if(isEnabled)
         {
            this._deactivatedSubEntityCategory.splice(this._deactivatedSubEntityCategory.indexOf(catId.toString()),1);
         }
         else if(this._deactivatedSubEntityCategory.indexOf(catId.toString()) == -1)
         {
            this._deactivatedSubEntityCategory.push(catId.toString());
         }
      }
      
      override public function toString() : String
      {
         return "[TiphonSprite] " + this._look.toString();
      }
      
      public function forceVisibilityRefresh() : void
      {
         this.refreshAlpha();
      }
   }
}
