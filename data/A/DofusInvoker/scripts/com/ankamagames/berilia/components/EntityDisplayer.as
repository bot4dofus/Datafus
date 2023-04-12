package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.UIComponent;
   import com.ankamagames.berilia.components.messages.EntityReadyMessage;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.pools.PoolablePoint;
   import com.ankamagames.jerakine.pools.PoolsManager;
   import com.ankamagames.jerakine.sequencer.SerialSequencer;
   import com.ankamagames.jerakine.types.Swl;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.engine.BoneIndexManager;
   import com.ankamagames.tiphon.engine.Tiphon;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.tiphon.sequence.PlayAnimationStep;
   import com.ankamagames.tiphon.sequence.SetAnimationStep;
   import com.ankamagames.tiphon.sequence.SetDirectionStep;
   import com.ankamagames.tiphon.types.IAnimationModifier;
   import com.ankamagames.tiphon.types.ISkinModifier;
   import com.ankamagames.tiphon.types.ISubEntityBehavior;
   import com.ankamagames.tiphon.types.TiphonUtility;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.display.DisplayObject;
   import flash.display.InteractiveObject;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class EntityDisplayer extends GraphicContainer implements UIComponent, IRectangle
   {
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
      
      public static var lookAdaptater:Function;
      
      private static const _subEntitiesBehaviors:Dictionary = new Dictionary();
      
      private static const _animationModifier:Dictionary = new Dictionary();
      
      private static const _skinModifier:Dictionary = new Dictionary();
       
      
      private var _entity:TiphonSprite;
      
      private var _oldEntity:TiphonSprite;
      
      private var _direction:uint = 1;
      
      private var _animation:String = "AnimStatique";
      
      private var _view:String;
      
      private var _mask:Shape;
      
      private var _mask2:Shape;
      
      private var _lookUpdate:TiphonEntityLook;
      
      private var _listenForUpdate:Boolean = false;
      
      private var _waitingForEquipement:Array;
      
      private var _useCache:Boolean = false;
      
      private var _fromCache:Boolean = false;
      
      private var _cache:Object;
      
      private var _gotoAndStop:int = 0;
      
      private var _autoSize:Boolean = false;
      
      private var _sequencer:SerialSequencer;
      
      private var _realWidth:Number;
      
      private var _realHeight:Number;
      
      private var _characterReady:Boolean;
      
      private var _centerPos:Point;
      
      private var _animatedCharacter:TiphonSprite;
      
      public var yOffset:int = 0;
      
      public var xOffset:int = 0;
      
      public var entityScale:Number = 1;
      
      public var useFade:Boolean = true;
      
      public var clearSubEntities:Boolean = true;
      
      public var clearAuras:Boolean = true;
      
      public var withoutMount:Boolean = false;
      
      public var maskRect:String;
      
      public function EntityDisplayer()
      {
         super();
         mouseChildren = false;
         MEMORY_LOG[this] = 1;
      }
      
      public static function setSubEntityDefaultBehavior(category:uint, behavior:ISubEntityBehavior) : void
      {
         _subEntitiesBehaviors[category] = behavior;
      }
      
      public static function setAnimationModifier(boneId:uint, am:IAnimationModifier) : void
      {
         _animationModifier[boneId] = am;
      }
      
      public static function setSkinModifier(boneId:uint, sm:ISkinModifier) : void
      {
         _skinModifier[boneId] = sm;
      }
      
      public function set look(rawLook:*) : void
      {
         var look:TiphonEntityLook = null;
         var entity:TiphonSprite = null;
         this._characterReady = false;
         if(lookAdaptater != null)
         {
            look = lookAdaptater(rawLook);
         }
         else
         {
            if(!(rawLook is TiphonEntityLook))
            {
               throw new ArgumentError();
            }
            look = rawLook as TiphonEntityLook;
         }
         if(this._entity)
         {
            this._entity.stopAnimation();
            if(this._sequencer && this._sequencer.running)
            {
               this._sequencer.clear();
            }
            this._entity.visible = look != null;
         }
         if(look && this.withoutMount)
         {
            look = TiphonUtility.getLookWithoutMount(look);
         }
         if(look != null)
         {
            if(this.clearSubEntities)
            {
               look.resetSubEntities();
            }
            else if(this.clearAuras)
            {
               look.removeSubEntity(6);
            }
         }
         if(look && this._lookUpdate)
         {
            if(look.toString() == this._lookUpdate.toString())
            {
               if(this._entity && !this._entity.parent)
               {
                  addChild(this._entity);
               }
               return;
            }
         }
         this._lookUpdate = !!look ? look.clone() : look;
         if(this._lookUpdate && _skinModifier[this._lookUpdate.getBone()])
         {
            this._lookUpdate.skinModifier = _skinModifier[this._lookUpdate.getBone()];
         }
         if(this._useCache)
         {
            entity = this._cache[look.toString()];
            if(entity)
            {
               if(this._entity)
               {
                  this.destroyEntity(this._entity);
               }
               addChild(entity);
               this._entity = entity;
               this._fromCache = true;
               return;
            }
         }
         this._fromCache = false;
         this._listenForUpdate = true;
         EnterFrameDispatcher.addEventListener(this.needUpdate,EnterFrameConst.ENTITY_DISPLAYER_UPDATER);
      }
      
      public function get look() : TiphonEntityLook
      {
         return !!this._entity ? this._entity.look : this._lookUpdate;
      }
      
      public function set direction(n:uint) : void
      {
         this._direction = n;
         if(!this._listenForUpdate && this._entity is TiphonSprite)
         {
            TiphonSprite(this._entity).setDirection(n);
         }
      }
      
      public function get direction() : uint
      {
         return this._direction;
      }
      
      public function set animation(anim:String) : void
      {
         this._animation = anim;
         if(this._entity is TiphonSprite)
         {
            TiphonSprite(this._entity).setAnimation(anim);
         }
      }
      
      public function get animation() : String
      {
         return this._animation;
      }
      
      public function set animatedCharacter(entity:TiphonSprite) : void
      {
         if(this._animatedCharacter)
         {
            this._animatedCharacter.destroy();
            this._animatedCharacter = null;
         }
         this._animatedCharacter = entity;
      }
      
      public function set gotoAndStop(value:int) : void
      {
         if(this._entity)
         {
            if(value == -1)
            {
               this._entity.stopAnimationAtEnd();
            }
            else
            {
               this._entity.stopAnimation(value);
            }
         }
         else
         {
            this._gotoAndStop = value;
         }
      }
      
      public function get entity() : TiphonSprite
      {
         return this._entity;
      }
      
      public function get autoSize() : Boolean
      {
         return this._autoSize;
      }
      
      override public function set width(nW:Number) : void
      {
         super.width = nW;
         this._autoSize = nW != 0 && height != 0;
      }
      
      override public function set height(nH:Number) : void
      {
         super.height = nH;
         this._autoSize = nH != 0 && width != 0;
      }
      
      public function set view(value:String) : void
      {
         this._view = "DisplayInfo_" + value;
         if(this._entity is TiphonSprite)
         {
            this._entity.setView(value);
         }
      }
      
      override public function set handCursor(value:Boolean) : void
      {
         super.handCursor = value;
         if(value)
         {
            addEventListener(MouseEvent.MOUSE_OVER,this.mouseOver);
            addEventListener(MouseEvent.MOUSE_OUT,this.mouseOut);
         }
         else
         {
            removeEventListener(MouseEvent.MOUSE_OVER,this.mouseOver);
            removeEventListener(MouseEvent.MOUSE_OUT,this.mouseOut);
         }
      }
      
      public function get useCache() : Boolean
      {
         return this._useCache;
      }
      
      public function set useCache(value:Boolean) : void
      {
         this._useCache = value;
         if(!this._cache)
         {
            this._cache = new Object();
         }
      }
      
      override public function get cacheAsBitmap() : Boolean
      {
         return super.cacheAsBitmap;
      }
      
      override public function set cacheAsBitmap(value:Boolean) : void
      {
         _log.fatal("Attention : Il ne faut surtout pas utiliser la propriété cacheAsBitmap sur les EntityDisplayer. TiphonSprite le gère déjà.");
      }
      
      public function set fixedWidth(pFixedWidth:Number) : void
      {
         this._entity.height = pFixedWidth / (this._realWidth / this._realHeight) * this.entityScale;
         this._entity.width = pFixedWidth * this.entityScale;
      }
      
      public function set fixedHeight(pFixedHeight:Number) : void
      {
         this._entity.height = pFixedHeight * this.entityScale;
         this._entity.width = pFixedHeight / (this._realHeight / this._realWidth) * this.entityScale;
      }
      
      public function get characterReady() : Boolean
      {
         return this._characterReady;
      }
      
      public function get centerPos() : Point
      {
         return this._centerPos;
      }
      
      public function set centerPos(p:Point) : void
      {
         this._centerPos = p;
      }
      
      public function update() : void
      {
         this.needUpdate();
      }
      
      public function updateMask() : void
      {
         var rect:Object = null;
         var x:Number = NaN;
         var y:Number = NaN;
         var w:Number = NaN;
         var h:Number = NaN;
         if(this.entityScale > 1 || this.yOffset != 0 || this.xOffset != 0 || this.maskRect)
         {
            rect = !!this.maskRect ? this.maskRect.split(",") : null;
            x = !!rect ? Number(rect[0]) : Number(0);
            y = !!rect ? Number(rect[1]) : Number(0);
            w = !!rect ? Number(rect[2]) : Number(width);
            h = !!rect ? Number(rect[3]) : Number(height);
            if(this._mask)
            {
               this._mask.graphics.clear();
            }
            else
            {
               this._mask = new Shape();
            }
            this._mask.graphics.beginFill(0);
            this._mask.graphics.drawRect(x,y,w,h);
            addChild(this._mask);
            TiphonSprite(this._entity).mask = this._mask;
            if(this._oldEntity)
            {
               if(this._mask2)
               {
                  this._mask2.graphics.clear();
               }
               else
               {
                  this._mask2 = new Shape();
               }
               this._mask2.graphics.beginFill(0);
               this._mask2.graphics.drawRect(0,0,width,height);
               addChild(this._mask2);
               TiphonSprite(this._oldEntity).mask = this._mask2;
            }
         }
         else
         {
            if(this._mask && this._mask.parent && this._mask.parent == this)
            {
               removeChild(this._mask);
            }
            TiphonSprite(this._entity).mask = null;
            this._mask = null;
         }
      }
      
      public function updateScaleAndOffsets() : void
      {
         var entRatio:Number = NaN;
         var b:Rectangle = null;
         var dis:DisplayObject = null;
         var r:Number = NaN;
         var m:Number = NaN;
         this._entity.x = 0;
         this._entity.y = 0;
         this._entity.width = this._realWidth;
         this._entity.height = this._realHeight;
         if(this._view != null)
         {
            dis = TiphonSprite(this._entity).getDisplayInfoSprite(this._view);
            if(dis != null)
            {
               TiphonSprite(this._entity).look.setScales(1,1);
               TiphonSprite(this._entity).setView(this._view);
               entRatio = this._entity.width / this._entity.height;
               if(this._entity.width > this._entity.height)
               {
                  this._entity.height = width / entRatio * this.entityScale;
                  this._entity.width = width * this.entityScale;
               }
               else
               {
                  this._entity.width = height * entRatio * this.entityScale;
                  this._entity.height = height * this.entityScale;
               }
               b = TiphonSprite(this._entity).getBounds(this);
               this._entity.x = (width - this._entity.width) / 2 - b.left + this.xOffset;
               this._entity.y = (height - this._entity.height) / 2 - b.top + this.yOffset;
               r = dis.width / dis.height;
               m = width / height < dis.width / dis.height ? Number(width / dis.getRect(this).width) : Number(height / dis.getRect(this).height);
               this._entity.height *= m;
               this._entity.width *= m;
               this._entity.x -= dis.getRect(this).x;
               this._entity.y -= dis.getRect(this).y;
            }
         }
         else
         {
            entRatio = this._entity.width / this._entity.height;
            if(this._entity.width > this._entity.height)
            {
               this._entity.height = width / entRatio * this.entityScale;
               this._entity.width = width * this.entityScale;
            }
            else
            {
               this._entity.width = height * entRatio * this.entityScale;
               this._entity.height = height * this.entityScale;
            }
            b = TiphonSprite(this._entity).getBounds(this);
            this._entity.x = (width - this._entity.width) / 2 - b.left + this.xOffset;
            this._entity.y = (height - this._entity.height) / 2 - b.top + this.yOffset;
         }
      }
      
      public function setAnimationAndDirection(anim:String, dir:uint) : void
      {
         if(!this._fromCache)
         {
            this._animation = anim;
            this._direction = dir;
            if(this._entity is TiphonSprite && !this._listenForUpdate)
            {
               if(this._animation == "AnimStatique" || this._animation == "AnimArtwork" || this._animation == "AnimDialogue")
               {
                  TiphonSprite(this._entity).setAnimationAndDirection(this._animation,this._direction);
               }
               else
               {
                  if(!this._sequencer)
                  {
                     this._sequencer = new SerialSequencer();
                  }
                  else if(this._sequencer.running)
                  {
                     this._sequencer.clear();
                  }
                  this._sequencer.addStep(new SetDirectionStep(TiphonSprite(this._entity),this._direction));
                  this._sequencer.addStep(new PlayAnimationStep(TiphonSprite(this._entity),this._animation,false));
                  this._sequencer.addStep(new SetAnimationStep(TiphonSprite(this._entity),this._animation));
                  this._sequencer.start();
               }
            }
         }
      }
      
      public function equipCharacter(list:Array, numDelete:int = 0) : void
      {
         var base:Array = null;
         var tel:TiphonEntityLook = null;
         var bones:Array = null;
         var k:int = 0;
         if(this._entity is TiphonSprite)
         {
            base = TiphonSprite(this._entity).look.toString().split("|");
            if(list.length)
            {
               list.unshift(base[1].split(","));
               base[1] = list.join(",");
            }
            else if(numDelete < base[1].length)
            {
               bones = base[1].split(",");
               for(k = 0; k < numDelete; k++)
               {
                  bones.pop();
               }
               base[1] = bones.join(",");
            }
            tel = TiphonEntityLook.fromString(base.join("|"));
            this._entity.look.updateFrom(tel);
         }
         else if(!this._entity && list.length)
         {
            this._waitingForEquipement = list;
         }
      }
      
      public function getSlot(name:String) : DisplayObject
      {
         if(this._entity)
         {
            return this._entity.getSlot(name);
         }
         return null;
      }
      
      public function getSlotPosition(name:String) : Point
      {
         var s:Object = null;
         var temp:PoolablePoint = null;
         var p:Point = null;
         var point:Point = null;
         if(this._entity && this._entity is TiphonSprite)
         {
            s = TiphonSprite(this._entity).getSlot(name);
            if(s)
            {
               temp = PoolsManager.getInstance().getPointPool().checkOut() as PoolablePoint;
               temp.renew(s.x,s.y);
               p = s.localToGlobal(temp.renew(s.x,s.y));
               return this.globalToLocal(p);
            }
            _log.error("Null entity, cannot get slot position.");
            return null;
         }
         _log.error("Null entity, cannot get slot position.");
         return null;
      }
      
      public function getSlotBounds(pSlotName:String) : Rectangle
      {
         var bounds:Rectangle = null;
         var slot:DisplayObject = null;
         var localPos:Point = null;
         if(this._entity)
         {
            slot = this._entity.getSlot(pSlotName);
            if(slot)
            {
               localPos = this.getSlotPosition(pSlotName);
               bounds = new Rectangle(localPos.x,localPos.y,slot.width,slot.height);
            }
         }
         return bounds;
      }
      
      public function getEntityBounds() : Rectangle
      {
         return !!this._entity ? this._entity.getBounds(this) : null;
      }
      
      public function getEntityOrigin() : Point
      {
         return this._entity.localToGlobal(PoolsManager.getInstance().getPointPool().checkOut()["renew"]());
      }
      
      override public function remove() : void
      {
         var behavior:ISubEntityBehavior = null;
         var ts:TiphonSprite = null;
         if(this._entity)
         {
            (this._entity as EventDispatcher).removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onCharacterReady);
            (this._entity as EventDispatcher).removeEventListener(TiphonEvent.PLAYANIM_EVENT,this.onPlayAnim);
            this._entity.destroy();
            this._entity = null;
         }
         if(this._animatedCharacter)
         {
            this._animatedCharacter.destroy();
            this._animatedCharacter = null;
         }
         if(this._oldEntity)
         {
            (this._oldEntity as EventDispatcher).removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onCharacterReady);
            (this._oldEntity as EventDispatcher).removeEventListener(TiphonEvent.PLAYANIM_EVENT,this.onPlayAnim);
            this._oldEntity.destroy();
            this._oldEntity = null;
         }
         if(this._cache)
         {
            for each(ts in this._cache)
            {
               ts.destroy();
            }
            this._cache = null;
         }
         if(this._sequencer)
         {
            this._sequencer.clear();
            this._sequencer = null;
         }
         this._lookUpdate = null;
         this._waitingForEquipement = null;
         EnterFrameDispatcher.removeEventListener(this.onFade);
         removeEventListener(MouseEvent.MOUSE_OVER,this.mouseOver);
         removeEventListener(MouseEvent.MOUSE_OUT,this.mouseOut);
         for each(behavior in _subEntitiesBehaviors)
         {
            if(behavior)
            {
               behavior.remove();
            }
         }
         super.remove();
      }
      
      public function setColor(index:uint, color:uint) : void
      {
         if(TiphonSprite(this._entity) && TiphonSprite(this._entity).look)
         {
            TiphonSprite(this._entity).look.setColor(index,color);
         }
      }
      
      public function resetColor(index:uint) : void
      {
         if(TiphonSprite(this._entity) && TiphonSprite(this._entity).look)
         {
            TiphonSprite(this._entity).look.resetColor(index);
         }
      }
      
      public function destroyCurrentEntity() : void
      {
         if(this._entity && this._entity.parent)
         {
            removeChild(this._entity);
         }
      }
      
      public function hasAnimation(pBoneId:uint, pAnimation:String, pDirection:uint) : Boolean
      {
         var anims:Array = null;
         var resource:Swl = null;
         if(BoneIndexManager.getInstance().hasCustomBone(pBoneId))
         {
            anims = BoneIndexManager.getInstance().getAllCustomAnimations(pBoneId);
         }
         if(!anims)
         {
            resource = Tiphon.skullLibrary.getResourceById(pBoneId);
            anims = !!resource ? resource.getDefinitions() : null;
         }
         return !!anims ? anims.indexOf(pAnimation + "_" + pDirection) != -1 : false;
      }
      
      public function addEndAnimationListener(func:Function) : void
      {
         TiphonSprite(this._entity).addEventListener(TiphonEvent.ANIMATION_END,func);
      }
      
      public function removeEndAnimationListener(func:Function) : void
      {
         TiphonSprite(this._entity).removeEventListener(TiphonEvent.ANIMATION_END,func);
         if(this._oldEntity)
         {
            TiphonSprite(this._oldEntity).removeEventListener(TiphonEvent.ANIMATION_END,func);
         }
      }
      
      public function addShotAnimationListener(func:Function) : void
      {
         TiphonSprite(this._entity).addEventListener(TiphonEvent.ANIMATION_SHOT,func);
      }
      
      public function removeShotAnimationListener(func:Function) : void
      {
         TiphonSprite(this._entity).removeEventListener(TiphonEvent.ANIMATION_SHOT,func);
         if(this._oldEntity)
         {
            TiphonSprite(this._oldEntity).removeEventListener(TiphonEvent.ANIMATION_SHOT,func);
         }
      }
      
      private function onCharacterReady(e:Event) : void
      {
         var cat:* = undefined;
         var entityOrigin:Point = null;
         (this._entity as EventDispatcher).removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onCharacterReady);
         if(this._entity.rawAnimation)
         {
            this._entity.rawAnimation.gotoAndPlay(0);
         }
         if(this._gotoAndStop)
         {
            if(this._gotoAndStop == -1)
            {
               this._entity.stopAnimationAtEnd();
            }
            else
            {
               this._entity.stopAnimation(this._gotoAndStop);
            }
            this._gotoAndStop = 0;
         }
         if(_animationModifier[this._entity.look.getBone()])
         {
            this._entity.addAnimationModifier(_animationModifier[this._entity.look.getBone()]);
         }
         if(_skinModifier[this._entity.look.getBone()])
         {
            this._entity.skinModifier = _skinModifier[this._entity.look.getBone()];
         }
         for(cat in _subEntitiesBehaviors)
         {
            if(_subEntitiesBehaviors[cat])
            {
               (this._entity as TiphonSprite).setSubEntityBehaviour(cat,_subEntitiesBehaviors[cat]);
            }
         }
         if(!this._centerPos)
         {
            this._entity.visible = true;
         }
         this.updateMask();
         if(this._oldEntity)
         {
            if(this.useFade)
            {
               this._oldEntity.alpha = 1;
               this._entity.alpha = 0;
               EnterFrameDispatcher.addEventListener(this.onFade,EnterFrameConst.ENTITY_DISPLAYER_FADE);
            }
            else
            {
               this.destroyEntity(this._oldEntity);
               this._oldEntity = null;
            }
         }
         this._realWidth = this._entity.width;
         this._realHeight = this._entity.height;
         if(!this._entity.height || !this._autoSize)
         {
            Berilia.getInstance().handler.process(new EntityReadyMessage(InteractiveObject(this)));
            return;
         }
         this.updateScaleAndOffsets();
         if(this._centerPos)
         {
            entityOrigin = this._entity.localToGlobal(new Point());
            x -= entityOrigin.x - this.centerPos.x;
            y -= entityOrigin.y - this.centerPos.y;
         }
         this._entity.visible = true;
         if(Berilia.getInstance().handler)
         {
            Berilia.getInstance().handler.process(new EntityReadyMessage(InteractiveObject(this)));
         }
         this._characterReady = true;
      }
      
      private function destroyEntity(entity:TiphonSprite) : void
      {
         if(entity.parent)
         {
            removeChild(entity);
         }
         if(!this._useCache)
         {
            entity.destroy();
         }
      }
      
      private function needUpdate(e:Event = null) : void
      {
         var cat:* = undefined;
         var key:String = null;
         EnterFrameDispatcher.removeEventListener(this.needUpdate);
         this._listenForUpdate = false;
         if(this._oldEntity)
         {
            this.destroyEntity(this._oldEntity);
            this._oldEntity = null;
         }
         if(!this._lookUpdate)
         {
            if(this._entity)
            {
               this.destroyEntity(this._entity);
               this._entity = null;
            }
            return;
         }
         this._oldEntity = this._entity;
         this._entity = new TiphonSprite(this._lookUpdate.clone());
         this._entity.visible = false;
         if(_animationModifier[this._entity.look.getBone()])
         {
            this._entity.addAnimationModifier(_animationModifier[this._entity.look.getBone()]);
         }
         if(_skinModifier[this._entity.look.getBone()])
         {
            this._entity.skinModifier = _skinModifier[this._entity.look.getBone()];
         }
         if(this._useCache)
         {
            key = this._entity.look.toString();
            this._cache[key] = this._entity;
         }
         for(cat in _subEntitiesBehaviors)
         {
            if(_subEntitiesBehaviors[cat])
            {
               (this._entity as TiphonSprite).setSubEntityBehaviour(cat,_subEntitiesBehaviors[cat]);
            }
         }
         (this._entity as EventDispatcher).addEventListener(TiphonEvent.RENDER_SUCCEED,this.onCharacterReady);
         (this._entity as EventDispatcher).addEventListener(TiphonEvent.PLAYANIM_EVENT,this.onPlayAnim);
         addChild(this._entity);
         this.setAnimationAndDirection(this._animation,this._direction);
         if(this._waitingForEquipement && this._waitingForEquipement.length)
         {
            this.equipCharacter(this._waitingForEquipement,0);
         }
      }
      
      private function onPlayAnim(e:TiphonEvent) : void
      {
         var animsRandom:Array = null;
         (this._entity as EventDispatcher).removeEventListener(TiphonEvent.PLAYANIM_EVENT,this.onPlayAnim);
         var tempStr:String = e.params.substring(6,e.params.length - 1);
         animsRandom = tempStr.split(",");
         var anim:String = animsRandom[int(animsRandom.length * Math.random())];
         var dir:uint = parseInt(anim.substring(anim.lastIndexOf("_") + 1));
         anim = anim.substring(0,anim.lastIndexOf("_"));
         this.setAnimationAndDirection(anim,dir);
      }
      
      private function onFade(e:Event) : void
      {
         if(this._entity)
         {
            this._entity.alpha += (1 - this._entity.alpha) / 3;
            this._oldEntity.alpha += (0 - this._oldEntity.alpha) / 3;
            if(this._oldEntity.alpha < 0.05)
            {
               this._entity.alpha = 1;
               this.destroyEntity(this._oldEntity);
               this._oldEntity = null;
               EnterFrameDispatcher.removeEventListener(this.onFade);
            }
         }
         else
         {
            EnterFrameDispatcher.removeEventListener(this.onFade);
            _log.error("entity est null");
         }
      }
      
      private function mouseOver(e:MouseEvent) : void
      {
         this._entity.transform.colorTransform = new ColorTransform(1.3,1.3,1.3,1);
      }
      
      private function mouseOut(e:MouseEvent) : void
      {
         this._entity.transform.colorTransform = new ColorTransform(1,1,1,1);
      }
   }
}
