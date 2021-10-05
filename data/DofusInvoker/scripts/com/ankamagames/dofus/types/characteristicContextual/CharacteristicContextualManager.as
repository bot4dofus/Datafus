package com.ankamagames.dofus.types.characteristicContextual
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayContextFrame;
   import com.ankamagames.dofus.network.enums.GameContextEnum;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class CharacteristicContextualManager extends EventDispatcher
   {
      
      private static const MAX_ENTITY_HEIGHT:uint = 250;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(CharacteristicContextualManager));
      
      private static var _self:CharacteristicContextualManager;
      
      private static var _aEntitiesTweening:Array;
       
      
      private var _bEnterFrameNeeded:Boolean;
      
      private var _tweeningCount:uint;
      
      private var _tweenByEntities:Dictionary;
      
      private var _type:uint = 1;
      
      private var _statsIcons:Dictionary;
      
      public function CharacteristicContextualManager()
      {
         super();
         if(_self)
         {
            throw new SingletonError("Warning : CharacteristicContextualManager is a singleton class and shoulnd\'t be instancied directly!");
         }
         _aEntitiesTweening = new Array();
         this._bEnterFrameNeeded = true;
         this._tweeningCount = 0;
         this._tweenByEntities = new Dictionary(true);
         this._statsIcons = new Dictionary(true);
      }
      
      public static function getInstance() : CharacteristicContextualManager
      {
         if(_self == null)
         {
            _self = new CharacteristicContextualManager();
         }
         return _self;
      }
      
      public function addStatContextual(sText:String, oEntity:IEntity, format:TextFormat, type:uint, pGameContext:uint, pScrollSpeed:Number = 1, pScrollDuration:uint = 2500) : CharacteristicContextual
      {
         var txtCxt:TextContextual = null;
         var txtSCxt:StyledTextContextual = null;
         var data:TweenData = null;
         if(!oEntity || oEntity.position.cellId == -1)
         {
            return null;
         }
         this._type = type;
         var dist:Array = [Math.abs(16711680 - (format.color as uint)),Math.abs(255 - (format.color as uint)),Math.abs(26112 - (format.color as uint)),Math.abs(10053324 - (format.color as uint))];
         var style:uint = dist.indexOf(Math.min(dist[0],dist[1],dist[2],dist[3]));
         switch(this._type)
         {
            case 1:
               txtCxt = new TextContextual();
               txtCxt.referedEntity = oEntity;
               txtCxt.text = sText;
               txtCxt.textFormat = format;
               txtCxt.gameContext = pGameContext;
               txtCxt.finalize();
               if(!this._tweenByEntities[oEntity])
               {
                  this._tweenByEntities[oEntity] = new Array();
               }
               data = new TweenData(txtCxt,oEntity,pScrollSpeed,pScrollDuration);
               (this._tweenByEntities[oEntity] as Array).unshift(data);
               if((this._tweenByEntities[oEntity] as Array).length == 1)
               {
                  _aEntitiesTweening.push(data);
               }
               ++this._tweeningCount;
               this.beginTween(txtCxt);
               break;
            case 2:
               txtSCxt = new StyledTextContextual(sText,style);
               txtSCxt.referedEntity = oEntity;
               txtSCxt.gameContext = pGameContext;
               if(!this._tweenByEntities[oEntity])
               {
                  this._tweenByEntities[oEntity] = new Array();
               }
               data = new TweenData(txtSCxt,oEntity,pScrollSpeed,pScrollDuration);
               (this._tweenByEntities[oEntity] as Array).unshift(data);
               if((this._tweenByEntities[oEntity] as Array).length == 1)
               {
                  _aEntitiesTweening.push(data);
               }
               ++this._tweeningCount;
               this.beginTween(txtSCxt);
         }
         return !!txtCxt ? txtCxt : txtSCxt;
      }
      
      public function addStatContextualWithIcon(pIcon:Texture, pText:String, pEntity:IEntity, pTextFormat:TextFormat, pType:uint, pGameContext:uint, pScrollSpeed:Number = 1, pScrollDuration:Number = 2500) : void
      {
         var enterFrameNeeded:Boolean = this._bEnterFrameNeeded;
         var statTxt:CharacteristicContextual = this.addStatContextual(pText,pEntity,pTextFormat,pType,pGameContext,pScrollSpeed,pScrollDuration);
         if(statTxt)
         {
            this._statsIcons[statTxt] = pIcon;
            pIcon.height = pIcon.width = statTxt.height;
            pIcon.alpha = 0;
            Berilia.getInstance().strataLow.addChild(pIcon);
            if(enterFrameNeeded)
            {
               EnterFrameDispatcher.addEventListener(this.onIconScroll,EnterFrameConst.CHARACTERISTIC_CONTEXT_MANAGER_ICON);
            }
         }
      }
      
      private function isIconDisplayed(pIcon:Texture, pCurrentContext:CharacteristicContextual) : Boolean
      {
         var statTxt:* = undefined;
         var iconDisplayed:Boolean = false;
         for(statTxt in this._statsIcons)
         {
            if(this._statsIcons[statTxt] == pIcon && statTxt != pCurrentContext)
            {
               iconDisplayed = true;
               break;
            }
         }
         return iconDisplayed;
      }
      
      private function removeStatContextual(nIndex:Number) : void
      {
         var entity:CharacteristicContextual = null;
         var container:DisplayObjectContainer = null;
         if(_aEntitiesTweening[nIndex] != null)
         {
            entity = _aEntitiesTweening[nIndex].context;
            entity.remove();
            container = Berilia.getInstance().strataLow;
            if(container.contains(entity))
            {
               container.removeChild(entity);
            }
            _aEntitiesTweening[nIndex] = null;
            delete _aEntitiesTweening[nIndex];
            if(this._statsIcons[entity])
            {
               if(!this.isIconDisplayed(this._statsIcons[entity],entity) && container.contains(this._statsIcons[entity]))
               {
                  container.removeChild(this._statsIcons[entity]);
               }
               delete this._statsIcons[entity];
            }
         }
      }
      
      private function removeTween(pStatContextualId:int) : void
      {
         this.removeStatContextual(pStatContextualId);
         --this._tweeningCount;
         if(this._tweeningCount == 0)
         {
            this._bEnterFrameNeeded = true;
            EnterFrameDispatcher.removeEventListener(this.onScroll);
            EnterFrameDispatcher.removeEventListener(this.onIconScroll);
         }
      }
      
      private function beginTween(oEntity:CharacteristicContextual) : void
      {
         Berilia.getInstance().strataLow.addChild(oEntity);
         var display:IRectangle = IDisplayable(oEntity.referedEntity).absoluteBounds;
         oEntity.x = (display.x + display.width / 2 - oEntity.width / 2 - StageShareManager.stageOffsetX) / StageShareManager.stageScaleX;
         oEntity.y = (display.y - oEntity.height - StageShareManager.stageOffsetY) / StageShareManager.stageScaleY;
         oEntity.alpha = 0;
         if(this._bEnterFrameNeeded)
         {
            EnterFrameDispatcher.addEventListener(this.onScroll,EnterFrameConst.CHARACTERISTIC_CONTEXT_MANAGER);
            this._bEnterFrameNeeded = false;
         }
      }
      
      private function onScroll(e:Event) : void
      {
         var index:* = null;
         var tweenData:TweenData = null;
         var entity:CharacteristicContextual = null;
         var entityTweenList:Array = null;
         var display:IRectangle = null;
         var addToNextTween:Array = [];
         var gameContext:uint = !!Kernel.getWorker().getFrame(RoleplayContextFrame) ? uint(GameContextEnum.ROLE_PLAY) : uint(GameContextEnum.FIGHT);
         for(index in _aEntitiesTweening)
         {
            tweenData = _aEntitiesTweening[index];
            if(tweenData)
            {
               entity = tweenData.context;
               entity.y -= tweenData.scrollSpeed;
               tweenData._tweeningCurrentDistance = (getTimer() - tweenData.startTime) / tweenData.scrollDuration;
               entityTweenList = this._tweenByEntities[tweenData.entity];
               if(entityTweenList && entityTweenList[entityTweenList.length - 1] == tweenData && tweenData._tweeningCurrentDistance > 0.5)
               {
                  entityTweenList.pop();
                  if(entityTweenList.length)
                  {
                     entityTweenList[entityTweenList.length - 1].startTime = getTimer();
                     addToNextTween.push(entityTweenList[entityTweenList.length - 1]);
                  }
                  else
                  {
                     delete this._tweenByEntities[tweenData.entity];
                  }
               }
               if(entity.gameContext != gameContext)
               {
                  this.removeTween(int(index));
               }
               else if(tweenData._tweeningCurrentDistance < 1 / 8)
               {
                  entity.alpha = tweenData._tweeningCurrentDistance * 4;
                  if(this._type == 2)
                  {
                     entity.scaleX = tweenData._tweeningCurrentDistance * 24;
                     entity.scaleY = tweenData._tweeningCurrentDistance * 24;
                     display = IDisplayable(entity.referedEntity).absoluteBounds;
                     if(!(entity.referedEntity is DisplayObject) || DisplayObject(entity.referedEntity).parent)
                     {
                        entity.x = (display.x + display.width / 2 - entity.width / 2 - StageShareManager.stageOffsetX) / StageShareManager.stageScaleX;
                     }
                  }
               }
               else if(tweenData._tweeningCurrentDistance < 1 / 4)
               {
                  entity.alpha = tweenData._tweeningCurrentDistance * 4;
                  if(this._type == 2)
                  {
                     entity.scaleX = 3 - tweenData._tweeningCurrentDistance * 8;
                     entity.scaleY = 3 - tweenData._tweeningCurrentDistance * 8;
                     display = IDisplayable(entity.referedEntity).absoluteBounds;
                     if(!(entity.referedEntity is DisplayObject) || DisplayObject(entity.referedEntity).parent)
                     {
                        entity.x = (display.x + display.width / 2 - entity.width / 2 - StageShareManager.stageOffsetX) / StageShareManager.stageScaleX;
                     }
                  }
               }
               else if(tweenData._tweeningCurrentDistance >= 3 / 4 && tweenData._tweeningCurrentDistance < 1)
               {
                  entity.alpha = 1 - tweenData._tweeningCurrentDistance;
               }
               else if(tweenData._tweeningCurrentDistance >= 1)
               {
                  this.removeTween(int(index));
               }
               else
               {
                  entity.alpha = 1;
               }
            }
         }
         _aEntitiesTweening = _aEntitiesTweening.concat(addToNextTween);
      }
      
      private function onIconScroll(pEvent:Event) : void
      {
         var icon:Texture = null;
         var statTxt:CharacteristicContextual = null;
         var index:* = null;
         var tweenData:TweenData = null;
         for(index in _aEntitiesTweening)
         {
            tweenData = _aEntitiesTweening[index];
            if(tweenData)
            {
               statTxt = tweenData.context;
               icon = this._statsIcons[statTxt];
               if(icon)
               {
                  icon.alpha = statTxt.alpha;
                  icon.y = statTxt.y;
                  icon.x = statTxt.x - icon.width;
               }
            }
         }
      }
   }
}

import com.ankamagames.dofus.types.characteristicContextual.CharacteristicContextual;
import com.ankamagames.jerakine.entities.interfaces.IEntity;
import flash.utils.getTimer;

class TweenData
{
    
   
   public var entity:IEntity;
   
   public var context:CharacteristicContextual;
   
   public var scrollSpeed:Number;
   
   public var scrollDuration:uint;
   
   public var _tweeningTotalDistance:uint = 40;
   
   public var _tweeningCurrentDistance:Number = 0;
   
   public var alpha:Number = 0;
   
   public var startTime:int;
   
   function TweenData(oEntity:CharacteristicContextual, entity:IEntity, pScrollSpeed:Number, pScrollDuration:uint)
   {
      this.startTime = getTimer();
      super();
      this.context = oEntity;
      this.entity = entity;
      this.scrollSpeed = pScrollSpeed;
      this.scrollDuration = pScrollDuration;
   }
}
