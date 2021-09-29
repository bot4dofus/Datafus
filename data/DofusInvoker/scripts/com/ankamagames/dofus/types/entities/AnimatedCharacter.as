package com.ankamagames.dofus.types.entities
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.entities.behaviours.display.AtouinDisplayBehavior;
   import com.ankamagames.atouin.entities.behaviours.movements.MountedMovementBehavior;
   import com.ankamagames.atouin.entities.behaviours.movements.RunningMovementBehavior;
   import com.ankamagames.atouin.entities.behaviours.movements.WalkingMovementBehavior;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.dofus.datacenter.npcs.Npc;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.behaviours.IEntityDeleteBehavior;
   import com.ankamagames.dofus.logic.game.fight.behaviours.FightEntityDeleteBehavior;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightTurnFrame;
   import com.ankamagames.dofus.logic.game.roleplay.behaviours.RoleplayEntityDeleteBehavior;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.misc.EntityLookAdapter;
   import com.ankamagames.dofus.network.enums.GameActionFightInvisibilityStateEnum;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayActorInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayHumanoidInformations;
   import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.types.data.Follower;
   import com.ankamagames.dofus.types.enums.AnimationEnum;
   import com.ankamagames.jerakine.entities.behaviours.IDisplayBehavior;
   import com.ankamagames.jerakine.entities.behaviours.IMovementBehavior;
   import com.ankamagames.jerakine.entities.interfaces.*;
   import com.ankamagames.jerakine.interfaces.ICustomUnicNameGetter;
   import com.ankamagames.jerakine.interfaces.IObstacle;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.interfaces.ITransparency;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.map.IDataMapProvider;
   import com.ankamagames.jerakine.messages.MessageHandler;
   import com.ankamagames.jerakine.pathfinding.Pathfinding;
   import com.ankamagames.jerakine.types.enums.DirectionsEnum;
   import com.ankamagames.jerakine.types.enums.InteractionsEnum;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.positions.MovementPath;
   import com.ankamagames.jerakine.types.positions.PathElement;
   import com.ankamagames.jerakine.utils.display.Rectangle2;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.tiphon.display.TiphonSprite;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import com.ankamagames.tiphon.types.look.TiphonEntityLook;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.ColorMatrixFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class AnimatedCharacter extends TiphonSprite implements IEntity, IMovable, IDisplayable, IAnimated, IInteractive, IRectangle, IObstacle, ITransparency, ICustomUnicNameGetter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AnimatedCharacter));
      
      private static const DEFAULT_ALPHA:Number = 1;
      
      private static const LUMINOSITY_FACTOR:Number = 1.2;
      
      private static const LUMINOSITY_TRANSFORM:ColorTransform = new ColorTransform(LUMINOSITY_FACTOR,LUMINOSITY_FACTOR,LUMINOSITY_FACTOR);
      
      private static const NORMAL_TRANSFORM:ColorTransform = new ColorTransform();
      
      private static const TRANSPARENCY_TRANSFORM:ColorTransform = new ColorTransform(1,1,1,AtouinConstants.OVERLAY_MODE_ALPHA);
      
      private static const SHADOW_TRANSFORM_MATRIX:Matrix = new Matrix(0.77740478515625,-0.62744140625,-0.8460540771484375,-0.5311126708984375);
      
      private static const SHADOW_MIRROR_TRANSFORM_MATRIX:Matrix = new Matrix(-0.77740478515625,0.62744140625,-0.8460540771484375,-0.5311126708984375);
       
      
      private var _id:Number;
      
      private var _position:MapPoint;
      
      private var _displayed:Boolean;
      
      private var _followers:Vector.<Follower>;
      
      private var _followed:AnimatedCharacter;
      
      private var _transparencyAllowed:Boolean = true;
      
      private var _name:String;
      
      private var _canSeeThrough:Boolean = false;
      
      private var _canWalkThrough:Boolean = false;
      
      private var _canWalkTo:Boolean = false;
      
      private var _shadow:TiphonSprite;
      
      protected var _movementBehavior:IMovementBehavior;
      
      protected var _displayBehavior:IDisplayBehavior;
      
      protected var _deleteBehavior:IEntityDeleteBehavior;
      
      private var _bmpAlpha:Bitmap;
      
      private var _auraEntity:TiphonSprite;
      
      private var _visibleAura:Boolean = true;
      
      private var _redrawMovementArea:Boolean = true;
      
      private var _savedAlpha:Number = NaN;
      
      private var _roleplayEntitiesFrame:RoleplayEntitiesFrame;
      
      public var speedAdjust:Number = 0.0;
      
      public var cantWalk8Directions:Boolean = false;
      
      public function AnimatedCharacter(nId:Number, look:TiphonEntityLook, followed:AnimatedCharacter = null, animation:String = "AnimStatique", direction:uint = 1)
      {
         this._roleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
         this.id = nId;
         name = "AnimatedCharacter" + nId;
         this._name = "entity::" + nId;
         this._followers = new Vector.<Follower>();
         this._followed = followed;
         super(look);
         this.updateWalkDirections();
         this._displayBehavior = AtouinDisplayBehavior.getInstance();
         this._movementBehavior = WalkingMovementBehavior.getInstance();
         this._deleteBehavior = Kernel.getWorker().getFrame(FightContextFrame) != null ? FightEntityDeleteBehavior.getInstance() : RoleplayEntityDeleteBehavior.getInstance();
         addEventListener(TiphonEvent.RENDER_SUCCEED,this.onFirstRender);
         addEventListener(TiphonEvent.RENDER_FAILED,this.onFirstError);
         if(animation)
         {
            this.setAnimationAndDirection(animation,direction);
         }
      }
      
      private static function getFollowerAvailiableDirectionNumber(follower:Follower) : uint
      {
         var b:Boolean = false;
         var avaibleDirection:Array = [];
         if(follower.entity is TiphonSprite)
         {
            avaibleDirection = TiphonSprite(follower.entity).getAvaibleDirection();
         }
         var avaibleDirectionCount:uint = 0;
         for each(b in avaibleDirection)
         {
            if(b)
            {
               avaibleDirectionCount++;
            }
         }
         if(avaibleDirection[1] && !avaibleDirection[3])
         {
            avaibleDirectionCount++;
         }
         if(!avaibleDirection[1] && avaibleDirection[3])
         {
            avaibleDirectionCount++;
         }
         if(avaibleDirection[7] && !avaibleDirection[5])
         {
            avaibleDirectionCount++;
         }
         if(!avaibleDirection[7] && avaibleDirection[5])
         {
            avaibleDirectionCount++;
         }
         if(!avaibleDirection[0] && avaibleDirection[4])
         {
            avaibleDirectionCount++;
         }
         if(avaibleDirection[0] && !avaibleDirection[4])
         {
            avaibleDirectionCount++;
         }
         return avaibleDirectionCount;
      }
      
      public static function getFirstAnimatedParent(entity:TiphonSprite) : AnimatedCharacter
      {
         var entityTmp:TiphonSprite = entity as TiphonSprite;
         while(entityTmp !== null && !(entityTmp is AnimatedCharacter))
         {
            entityTmp = entityTmp.parentSprite;
         }
         return entityTmp !== null ? entityTmp as AnimatedCharacter : null;
      }
      
      public function get id() : Number
      {
         return this._id;
      }
      
      public function set id(nValue:Number) : void
      {
         this._id = nValue;
      }
      
      public function get customUnicName() : String
      {
         return this._name;
      }
      
      public function saveVisibilityState() : void
      {
         this._savedAlpha = alpha;
      }
      
      public function restoreVisibilityState() : void
      {
         if(!isNaN(this._savedAlpha))
         {
            alpha = this._savedAlpha;
            this._savedAlpha = Number.NaN;
         }
         else
         {
            alpha = DEFAULT_ALPHA;
         }
      }
      
      public function get position() : MapPoint
      {
         return this._position;
      }
      
      public function set position(oValue:MapPoint) : void
      {
         var f:Follower = null;
         var lastPosition:MapPoint = this._position;
         this._position = oValue;
         if(!lastPosition)
         {
            for each(f in this._followers)
            {
               if(!f.entity.position)
               {
                  this.addFollower(f,true);
               }
            }
         }
      }
      
      public function get movementBehavior() : IMovementBehavior
      {
         return this._movementBehavior;
      }
      
      public function set movementBehavior(oValue:IMovementBehavior) : void
      {
         this._movementBehavior = oValue;
      }
      
      public function get followed() : AnimatedCharacter
      {
         return this._followed;
      }
      
      public function get displayBehaviors() : IDisplayBehavior
      {
         return this._displayBehavior;
      }
      
      public function set displayBehaviors(oValue:IDisplayBehavior) : void
      {
         this._displayBehavior = oValue;
      }
      
      public function get displayed() : Boolean
      {
         return this._displayed;
      }
      
      public function get handler() : MessageHandler
      {
         return Kernel.getWorker();
      }
      
      public function get enabledInteractions() : uint
      {
         var npc:Npc = null;
         var infos:* = !!this._roleplayEntitiesFrame ? this._roleplayEntitiesFrame.getEntityInfos(this.id) as GameRolePlayActorInformations : null;
         if(infos is GameRolePlayNpcInformations && (npc = Npc.getNpcById((infos as GameRolePlayNpcInformations).npcId)) != null && !npc.tooltipVisible)
         {
            return 0;
         }
         return InteractionsEnum.CLICK | InteractionsEnum.OUT | InteractionsEnum.OVER;
      }
      
      public function get isMoving() : Boolean
      {
         return this._movementBehavior.isMoving(this);
      }
      
      public function get absoluteBounds() : IRectangle
      {
         return this._displayBehavior.getAbsoluteBounds(this);
      }
      
      override public function get useHandCursor() : Boolean
      {
         return true;
      }
      
      public function get visibleAura() : Boolean
      {
         return this._visibleAura;
      }
      
      public function set visibleAura(visible:Boolean) : void
      {
         if(this._visibleAura == visible)
         {
            return;
         }
         this._visibleAura = visible;
         var currentAura:TiphonSprite = getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND,0) as TiphonSprite;
         if(currentAura && !this.auraEntity)
         {
            this.auraEntity = currentAura;
         }
         if(this.auraEntity)
         {
            this.auraEntity.visible = visible;
         }
      }
      
      public function get hasAura() : Boolean
      {
         return this.auraEntity != null || getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND,0) != null;
      }
      
      private function get auraEntity() : TiphonSprite
      {
         return this._auraEntity;
      }
      
      private function set auraEntity(aura:TiphonSprite) : void
      {
         if(this._auraEntity == aura)
         {
            return;
         }
         if(getSubEntitySlot(SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND,0) as TiphonSprite)
         {
            this.removeSubEntity(this._auraEntity);
         }
         this._auraEntity = aura;
         this._auraEntity.visible = this.visibleAura;
         this.addSubEntity(this._auraEntity,SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND,0);
      }
      
      public function getIsTransparencyAllowed() : Boolean
      {
         return this._transparencyAllowed;
      }
      
      public function set transparencyAllowed(allowed:Boolean) : void
      {
         this._transparencyAllowed = allowed;
      }
      
      public function get followers() : Vector.<Follower>
      {
         return this._followers;
      }
      
      private function onFirstError(e:TiphonEvent) : void
      {
         removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onFirstRender);
         removeEventListener(TiphonEvent.RENDER_FAILED,this.onFirstError);
         var dirList:Array = getAvaibleDirection(AnimationEnum.ANIM_STATIQUE);
         for(var dir:uint = DirectionsEnum.DOWN_RIGHT; dir < DirectionsEnum.DOWN_RIGHT + 7; dir++)
         {
            if(dirList[dir % 8])
            {
               this.setAnimationAndDirection(AnimationEnum.ANIM_STATIQUE,dir % 8);
            }
         }
      }
      
      private function onFirstRender(e:TiphonEvent) : void
      {
         removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onFirstRender);
         removeEventListener(TiphonEvent.RENDER_FAILED,this.onFirstError);
      }
      
      public function initShadow(force:Boolean = false) : void
      {
         var l:TiphonEntityLook = null;
         if(OptionManager.getOptionManager("dofus").getOption("shadowCharacter"))
         {
            if(this._shadow)
            {
               return;
            }
            if(look.getBone() == 1)
            {
               l = TiphonEntityLook.fromString("{1|1965,218}");
               l.setScales(look.getScaleX() * 1.5,look.getScaleY() * 1.5);
            }
            else
            {
               l = look;
            }
            this._shadow = new TiphonSprite(l);
            this._shadow.filters = [new ColorMatrixFilter([0,0,0,0,20,0,0,0,0,20,0,0,0,0,50,0,0,0,0.2,0])];
            addChildAt(this._shadow,0);
            if(force)
            {
               this.setAnimationAndDirection(getAnimation(),getDirection());
            }
         }
         else
         {
            if(!this._shadow)
            {
               return;
            }
            this._shadow.destroy();
            this._shadow = null;
         }
      }
      
      override public function subEntitiesChanged(look:TiphonEntityLook) : void
      {
         if(this._shadow)
         {
            this.removeSubEntity(this._shadow);
         }
         super.subEntitiesChanged(look);
         if(this._shadow)
         {
            addChildAt(this._shadow,0);
         }
         this.updateWalkDirections();
      }
      
      override protected function render() : void
      {
         super.render();
         this.initShadow();
         this.processShadow();
      }
      
      private function processShadow() : void
      {
         var direction:uint = 0;
         if(destroyed || !this._shadow)
         {
            return;
         }
         if(this._shadow)
         {
            direction = getDirection();
            this._shadow.transform.matrix = SHADOW_TRANSFORM_MATRIX;
            switch(direction)
            {
               case 1:
                  if(hasAnimation(getAnimation(),6))
                  {
                     direction = 6;
                  }
                  break;
               case 2:
                  if(hasAnimation(getAnimation(),3))
                  {
                     direction = 3;
                  }
                  break;
               case 5:
                  if(hasAnimation(getAnimation(),2))
                  {
                     direction = 2;
                  }
            }
            this._shadow.setAnimationAndDirection(getAnimation(),direction);
            addChildAt(this._shadow,0);
         }
      }
      
      public function canSeeThrough() : Boolean
      {
         return this._canSeeThrough;
      }
      
      public function setCanSeeThrough(value:Boolean) : void
      {
         this._canSeeThrough = value;
      }
      
      public function setCanWalkThrough(value:Boolean) : void
      {
         this._canWalkThrough = value;
      }
      
      public function canWalkThrough() : Boolean
      {
         return this._canWalkThrough;
      }
      
      public function setCanWalkTo(value:Boolean) : void
      {
         this._canWalkTo = value;
      }
      
      public function canWalkTo() : Boolean
      {
         return this._canWalkTo;
      }
      
      public function move(path:MovementPath, callback:Function = null, movementBehavior:IMovementBehavior = null) : void
      {
         var followerDirection:uint = 0;
         var forbidenCellsId:Array = null;
         var follower:Follower = null;
         var infos:GameContextActorInformations = null;
         var isCreatureMode:Boolean = false;
         var rpContextFrame:RoleplayContextFrame = null;
         var ies:Vector.<InteractiveElement> = null;
         var ie:InteractiveElement = null;
         var mp:MapPoint = null;
         var iePos:int = 0;
         var avaibleDirectionCount:uint = 0;
         var endpoint:MapPoint = null;
         var followerPoint:MapPoint = null;
         var followedMovPath:MovementPath = null;
         var firstDrawPath:Vector.<PathElement> = null;
         var followerPath:MovementPath = null;
         var i:uint = 0;
         var storedMovementPath:MovementPath = null;
         var pElem:PathElement = null;
         var lastElement:PathElement = null;
         if(!path.start.equals(this.position))
         {
            _log.warn("Unsynchronized position for entity " + this.id + ", jumping from " + this.position + " to " + path.start + ".");
            this.jump(path.start);
         }
         var distance:uint = path.path.length + 1;
         this._movementBehavior = movementBehavior;
         if(!this._movementBehavior)
         {
            if(Kernel.getWorker().contains(RoleplayEntitiesFrame))
            {
               infos = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).getEntityInfos(this.id);
               if(infos is GameRolePlayHumanoidInformations)
               {
                  if((infos as GameRolePlayHumanoidInformations).humanoidInfo.restrictions.cantRun)
                  {
                     this._movementBehavior = WalkingMovementBehavior.getInstance(this.speedAdjust);
                  }
               }
               else if(infos is GameRolePlayGroupMonsterInformations)
               {
                  this._movementBehavior = WalkingMovementBehavior.getInstance(this.speedAdjust);
               }
            }
            if(!this._movementBehavior)
            {
               if(distance > 3)
               {
                  isCreatureMode = false;
                  if(Kernel.getWorker().contains(RoleplayEntitiesFrame))
                  {
                     isCreatureMode = (Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame).isCreatureMode;
                  }
                  if(!isCreatureMode && this.isMounted())
                  {
                     this._movementBehavior = MountedMovementBehavior.getInstance();
                  }
                  else
                  {
                     this._movementBehavior = RunningMovementBehavior.getInstance(this.speedAdjust);
                  }
               }
               else
               {
                  if(distance <= 0)
                  {
                     return;
                  }
                  this._movementBehavior = WalkingMovementBehavior.getInstance(this.speedAdjust);
               }
            }
         }
         var mapData:IDataMapProvider = DataMapProvider.getInstance();
         if(this._followers.length > 0)
         {
            forbidenCellsId = [];
            rpContextFrame = Kernel.getWorker().getFrame(RoleplayContextFrame) as RoleplayContextFrame;
            if(rpContextFrame != null)
            {
               ies = rpContextFrame.entitiesFrame.interactiveElements;
               for each(ie in ies)
               {
                  if(ie)
                  {
                     mp = Atouin.getInstance().getIdentifiedElementPosition(ie.elementId);
                     if(mp)
                     {
                        iePos = mp.cellId;
                        forbidenCellsId.push(iePos);
                     }
                  }
               }
            }
         }
         var followersMovPath:Vector.<MovementPath> = new Vector.<MovementPath>();
         for each(follower in this._followers)
         {
            avaibleDirectionCount = getFollowerAvailiableDirectionNumber(follower);
            endpoint = path.end;
            forbidenCellsId.push(endpoint.cellId);
            if(follower.type != Follower.TYPE_MONSTER && (!avaibleDirectionCount < 8 && this._followers.indexOf(follower) != 0 && followersMovPath.length > 0))
            {
               endpoint = followersMovPath[followersMovPath.length - 1].end;
            }
            followerDirection = endpoint.advancedOrientationTo(this.position);
            followerPoint = endpoint.getNearestFreeCellInDirection(followerDirection,mapData,false,true,true,forbidenCellsId);
            if(followerPoint)
            {
               if(avaibleDirectionCount >= 8 && follower.type != Follower.TYPE_MONSTER)
               {
                  followerPath = new MovementPath();
                  if(this._followers.indexOf(follower) == 0 || followersMovPath.length <= 0)
                  {
                     followedMovPath = path;
                     firstDrawPath = followedMovPath.path.concat();
                     followerPath.end = followerPoint;
                     if(firstDrawPath.length > 0)
                     {
                        firstDrawPath = firstDrawPath.concat(Pathfinding.findPath(mapData,firstDrawPath[firstDrawPath.length - 1].step,followerPoint).path);
                     }
                     else
                     {
                        firstDrawPath = firstDrawPath.concat(Pathfinding.findPath(mapData,path.start,followerPoint).path);
                     }
                  }
                  else
                  {
                     followedMovPath = followersMovPath[followersMovPath.length - 1];
                     firstDrawPath = followedMovPath.path.concat();
                     if(followedMovPath.length > 0)
                     {
                        followerPath.end = followedMovPath.getPointAtIndex(followedMovPath.length - 1).step;
                     }
                     else
                     {
                        followerPath.end = followedMovPath.start;
                     }
                  }
                  if(forbidenCellsId.indexOf(followerPath.end) != -1)
                  {
                     followerPath.end = followerPath.end.getNearestFreeCellInDirection(followerDirection,mapData,false,false,true,forbidenCellsId);
                  }
                  forbidenCellsId.push(followerPath.end.cellId);
                  followerPath.start = follower.entity.position;
                  if(firstDrawPath.length > 0)
                  {
                     followerPath.addPoint(new PathElement(follower.entity.position,follower.entity.position.orientationTo(firstDrawPath[0].step)));
                  }
                  else
                  {
                     followerPath.addPoint(new PathElement(follower.entity.position,follower.entity.position.orientationTo(path.start)));
                  }
                  for(i = 0; i < firstDrawPath.length - 1; i++)
                  {
                     pElem = new PathElement();
                     pElem.step.x = firstDrawPath[i].step.x;
                     pElem.step.y = firstDrawPath[i].step.y;
                     pElem.orientation = firstDrawPath[i].step.orientationTo(firstDrawPath[i + 1].step);
                     followerPath.addPoint(pElem);
                  }
                  storedMovementPath = new MovementPath();
                  storedMovementPath.path = followerPath.path.concat();
                  storedMovementPath.end = followerPath.end;
                  storedMovementPath.start = followerPath.start;
                  followersMovPath.push(storedMovementPath);
                  if(this._followers.indexOf(follower) == 0)
                  {
                     lastElement = followerPath.getPointAtIndex(followerPath.length - 1);
                     lastElement.orientation = followerPath.getPointAtIndex(followerPath.length - 1).step.orientationTo(followerPoint);
                  }
                  this.processMove(followerPath,follower.entity,followerPoint);
               }
               else
               {
                  if(forbidenCellsId.indexOf(followerPoint.cellId) == -1)
                  {
                     forbidenCellsId.push(followerPoint.cellId);
                  }
                  this.processMove(Pathfinding.findPath(mapData,follower.entity.position,followerPoint,avaibleDirectionCount >= 8,true),follower.entity,followerPoint);
               }
            }
            else
            {
               _log.warn("Unable to get a proper destination for the follower.");
            }
         }
         this._movementBehavior.move(this,path,callback);
      }
      
      private function processMove(followPath:MovementPath, follower:IMovable, followerPoint:MapPoint) : void
      {
         if(followPath && followPath.path.length > 0)
         {
            follower.movementBehavior = this._movementBehavior;
            follower.move(followPath,null,this._movementBehavior);
         }
         else
         {
            _log.warn("There was no path from " + follower.position + " to " + followerPoint + " for a follower. Jumping !");
            follower.jump(followerPoint);
         }
      }
      
      public function jump(newPosition:MapPoint) : void
      {
         var fol:Follower = null;
         var mdp:IDataMapProvider = null;
         var mp:MapPoint = null;
         this._movementBehavior.jump(this,newPosition);
         for each(fol in this._followers)
         {
            mdp = DataMapProvider.getInstance();
            mp = this.position.getNearestFreeCell(mdp,false);
            if(!mp)
            {
               mp = this.position.getNearestFreeCell(mdp,true);
               if(!mp)
               {
                  return;
               }
            }
            fol.entity.jump(mp);
         }
      }
      
      public function stop(forceStop:Boolean = false) : void
      {
         var fol:Follower = null;
         this._movementBehavior.stop(this,forceStop);
         for each(fol in this._followers)
         {
            fol.entity.stop(forceStop);
         }
      }
      
      public function display(strata:uint = 10) : void
      {
         var f:Follower = null;
         this._displayBehavior.display(this,strata);
         this._displayed = true;
         for each(f in this._followers)
         {
            if(f.entity is IDisplayable && !IDisplayable(f.entity).displayed)
            {
               IDisplayable(f.entity).display();
            }
         }
      }
      
      public function hide(redrawMovement:Boolean = true) : void
      {
         this.alpha = 0;
         this._displayed = false;
         this.hideAllFollowers();
         if(redrawMovement)
         {
            this._displayBehavior.remove(this);
            this._deleteBehavior.entityDeleted(this);
         }
      }
      
      public function show(redrawMovement:Boolean = true) : void
      {
         this.alpha = 1;
         this._displayed = true;
         this.showAllFollowers();
         if(redrawMovement)
         {
            this._displayBehavior.display(this);
         }
      }
      
      public function remove() : void
      {
         var fightTurnFrame:FightTurnFrame = null;
         var fef:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(fef && fef.justSwitchingCreaturesFightMode)
         {
            this.dispatchEvent(new TiphonEvent(TiphonEvent.ANIMATION_DESTROY,this));
         }
         this.removeAllFollowers();
         this._displayed = false;
         this._movementBehavior.stop(this,true);
         this._displayBehavior.remove(this);
         this._deleteBehavior.entityDeleted(this);
         this._auraEntity = null;
         clearAnimation();
         if(Kernel.getWorker().terminating)
         {
            return;
         }
         if(this._redrawMovementArea)
         {
            fightTurnFrame = Kernel.getWorker().getFrame(FightTurnFrame) as FightTurnFrame;
            if(fightTurnFrame && fightTurnFrame.myTurn)
            {
               fightTurnFrame.drawMovementArea();
            }
         }
      }
      
      override public function destroy() : void
      {
         this._followed = null;
         this.remove();
         super.destroy();
      }
      
      public function quickDestroy() : void
      {
         this._redrawMovementArea = false;
         this.destroy();
      }
      
      public function getRootEntity() : AnimatedCharacter
      {
         if(this._followed)
         {
            return this._followed.getRootEntity();
         }
         return this;
      }
      
      public function removeAllFollowers() : void
      {
         var iFollower:Follower = null;
         var dfollower:IDisplayable = null;
         var sprite:TiphonSprite = null;
         for each(iFollower in this._followers)
         {
            dfollower = iFollower.entity as IDisplayable;
            if(dfollower)
            {
               dfollower.remove();
            }
            sprite = iFollower.entity as TiphonSprite;
            if(sprite)
            {
               sprite.destroy();
            }
         }
         this._followers = new Vector.<Follower>();
      }
      
      public function hideAllFollowers() : void
      {
         var iFollower:Follower = null;
         var sprite:TiphonSprite = null;
         for each(iFollower in this._followers)
         {
            sprite = iFollower.entity as TiphonSprite;
            if(sprite)
            {
               sprite.alpha = 0;
            }
         }
      }
      
      public function showAllFollowers() : void
      {
         var iFollower:Follower = null;
         var sprite:TiphonSprite = null;
         for each(iFollower in this._followers)
         {
            sprite = iFollower.entity as TiphonSprite;
            if(sprite)
            {
               sprite.alpha = 1;
            }
         }
      }
      
      public function removeFollower(follower:Follower) : void
      {
         var dfollower:IDisplayable = null;
         var sprite:TiphonSprite = null;
         var index:int = this._followers.indexOf(follower);
         if(index != -1)
         {
            dfollower = follower.entity as IDisplayable;
            if(dfollower)
            {
               dfollower.remove();
            }
            sprite = follower.entity as TiphonSprite;
            if(sprite)
            {
               sprite.destroy();
            }
            this._followers.splice(index,1);
         }
      }
      
      public function addFollower(follower:Follower, instantSync:Boolean = false) : void
      {
         var followerIndex:int = 0;
         var f:Follower = null;
         var avaibleDirectionCount:uint = 0;
         var dfollower:IDisplayable = null;
         var found:Boolean = false;
         for each(f in this._followers)
         {
            if(f.entity.id == follower.entity.id)
            {
               found = true;
               break;
            }
         }
         if(!found)
         {
            if(follower.type == Follower.TYPE_PET)
            {
               this._followers.unshift(follower);
            }
            else
            {
               avaibleDirectionCount = getFollowerAvailiableDirectionNumber(follower);
               if(avaibleDirectionCount < 8 || follower.type == Follower.TYPE_MONSTER)
               {
                  this._followers.push(follower);
               }
               else
               {
                  if(this._followers.length == 0 || this._followers[0].type != Follower.TYPE_PET)
                  {
                     followerIndex = 0;
                  }
                  this._followers.splice(followerIndex,0,follower);
               }
            }
         }
         if(!this.position)
         {
            return;
         }
         var mdp:IDataMapProvider = DataMapProvider.getInstance();
         var mp:MapPoint = this.position.getNearestFreeCell(mdp,false);
         if(!mp)
         {
            mp = this.position.getNearestFreeCell(mdp,true);
            if(!mp)
            {
               return;
            }
         }
         if(follower.entity.position == null)
         {
            follower.entity.position = mp;
         }
         if(follower.entity is IDisplayable)
         {
            dfollower = follower.entity as IDisplayable;
            if(this._displayed && !dfollower.displayed)
            {
               dfollower.display();
            }
            else if(!this._displayed && dfollower.displayed)
            {
               dfollower.remove();
            }
         }
         if(mp.equals(follower.entity.position))
         {
            return;
         }
         if(instantSync)
         {
            follower.entity.jump(mp);
         }
         else
         {
            follower.entity.move(Pathfinding.findPath(mdp,follower.entity.position,mp,false,false));
         }
      }
      
      public function followersEqual(pEntityLooks:Vector.<EntityLook>) : Boolean
      {
         var i:int = 0;
         var ac:Follower = null;
         if(!pEntityLooks)
         {
            return false;
         }
         var nbLooks:int = pEntityLooks.length;
         var nbEqual:int = 0;
         if(this._followers.length != nbLooks)
         {
            return false;
         }
         for each(ac in this._followers)
         {
            for(i = 0; i < nbLooks; i++)
            {
               if((ac.entity as AnimatedCharacter).look.equals(EntityLookAdapter.fromNetwork(pEntityLooks[i])))
               {
                  nbEqual++;
                  break;
               }
            }
         }
         if(nbEqual != nbLooks)
         {
            return false;
         }
         return true;
      }
      
      public function isMounted() : Boolean
      {
         var subEntities:Dictionary = this.look.getSubEntities(true);
         if(!subEntities)
         {
            return false;
         }
         var mountedEntities:Array = subEntities[SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_MOUNT_DRIVER];
         return mountedEntities && mountedEntities.length > 0;
      }
      
      public function highLightCharacterAndFollower(value:Boolean) : void
      {
         var entity:AnimatedCharacter = null;
         var rootEntity:AnimatedCharacter = this.getRootEntity();
         var num:int = rootEntity._followers.length;
         var i:int = -1;
         while(++i < num)
         {
            entity = rootEntity._followers[i].entity as AnimatedCharacter;
            if(entity)
            {
               entity.highLight(value);
            }
         }
         this.highLight(value);
      }
      
      public function highLight(value:Boolean) : void
      {
         if(value)
         {
            transform.colorTransform = LUMINOSITY_TRANSFORM;
         }
         else if(Atouin.getInstance().options.getOption("transparentOverlayMode"))
         {
            transform.colorTransform = TRANSPARENCY_TRANSFORM;
         }
         else
         {
            transform.colorTransform = NORMAL_TRANSFORM;
         }
      }
      
      public function showBitmapAlpha(alphaValue:Number) : void
      {
         var bmpdt:BitmapData = null;
         var newCellSprite:Sprite = null;
         if(this._bmpAlpha == null)
         {
            bmpdt = new BitmapData(width,height,true,16711680);
            bmpdt.draw(this.bitmapData);
            this._bmpAlpha = new Bitmap(bmpdt);
            this._bmpAlpha.alpha = alphaValue;
            newCellSprite = InteractiveCellManager.getInstance().getCell(this.position.cellId);
            this._bmpAlpha.x = newCellSprite.x + newCellSprite.width / 2 - this.width / 2;
            this._bmpAlpha.y = newCellSprite.y + newCellSprite.height - this.height;
            this.parent.addChild(this._bmpAlpha);
            visible = false;
         }
      }
      
      public function hideBitmapAlpha() : void
      {
         visible = true;
         if(this._bmpAlpha != null && StageShareManager.stage.contains(this._bmpAlpha))
         {
            this.parent.removeChild(this._bmpAlpha);
            this._bmpAlpha = null;
         }
      }
      
      override public function addSubEntity(entity:DisplayObject, category:uint, slot:uint) : void
      {
         if(category == SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_BASE_FOREGROUND && slot == 0 && !this._visibleAura && !this.auraEntity)
         {
            this.auraEntity = entity as TiphonSprite;
         }
         else
         {
            super.addSubEntity(entity,category,slot);
         }
      }
      
      override public function removeSubEntity(entity:DisplayObject) : void
      {
         super.removeSubEntity(entity);
      }
      
      override public function setAnimationAndDirection(animation:String, direction:uint, pDisableAnimModifier:Boolean = false) : void
      {
         super.setAnimationAndDirection(animation,direction,pDisableAnimModifier);
         if(this._shadow)
         {
            this.processShadow();
         }
      }
      
      public function getCreatureBounds() : IRectangle
      {
         var minX:Number = NaN;
         var minY:Number = NaN;
         var maxX:Number = NaN;
         var maxY:Number = NaN;
         var index:uint = 0;
         var child:DisplayObject = null;
         var childName:String = null;
         var childBounds:Rectangle = null;
         var currentChildMaxX:Number = NaN;
         var currentChildMaxY:Number = NaN;
         var fightEntitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         if(fightEntitiesFrame === null || !fightEntitiesFrame.isInCreaturesFightMode())
         {
            return null;
         }
         var targetBounds:IRectangle = new Rectangle2();
         minX = minY = Infinity;
         maxX = maxY = -Infinity;
         if(_animMovieClip !== null && numChildren > 0)
         {
            for(index = 0; index < _animMovieClip.numChildren; index++)
            {
               child = _animMovieClip.getChildAt(index);
               childName = getQualifiedClassName(child);
               if(!(child === null || childName.indexOf("carried") !== -1))
               {
                  childBounds = child.getBounds(StageShareManager.stage);
                  if(!(childBounds.width <= 0 || childBounds.height <= 0))
                  {
                     currentChildMaxX = childBounds.x + childBounds.width;
                     currentChildMaxY = childBounds.y + childBounds.height;
                     if(minX > childBounds.x)
                     {
                        minX = childBounds.x;
                     }
                     if(minY > childBounds.y)
                     {
                        minY = childBounds.y;
                     }
                     if(maxX < currentChildMaxX)
                     {
                        maxX = currentChildMaxX;
                     }
                     if(maxY < currentChildMaxY)
                     {
                        maxY = currentChildMaxY;
                     }
                  }
               }
            }
            targetBounds.x = minX;
            targetBounds.y = minY;
            targetBounds.width = maxX - minX;
            targetBounds.height = maxY - minY;
            return targetBounds;
         }
         return null;
      }
      
      override public function forceVisibilityRefresh() : void
      {
         var fighterInfo:GameFightFighterInformations = FightEntitiesFrame.getCurrentInstance().getEntityInfos(this._id) as GameFightFighterInformations;
         if(fighterInfo !== null)
         {
            switch(fighterInfo.stats.invisibilityState)
            {
               case GameActionFightInvisibilityStateEnum.VISIBLE:
                  alpha = 1;
                  break;
               case GameActionFightInvisibilityStateEnum.DETECTED:
                  alpha = 0.5;
                  break;
               case GameActionFightInvisibilityStateEnum.INVISIBLE:
                  alpha = 0;
            }
         }
         super.forceVisibilityRefresh();
      }
      
      private function updateWalkDirections() : void
      {
         for(var i:int = 0; i <= 6; i += 2)
         {
            if(!hasAnimation(AnimationEnum.ANIM_MARCHE,i) || !hasAnimation(AnimationEnum.ANIM_COURSE,i))
            {
               this.cantWalk8Directions = true;
               return;
            }
         }
         this.cantWalk8Directions = false;
      }
      
      override protected function checkRessourceState(e:Event = null) : void
      {
         super.checkRessourceState(e);
         this.updateWalkDirections();
      }
   }
}
