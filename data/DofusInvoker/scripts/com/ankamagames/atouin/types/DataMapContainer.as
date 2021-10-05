package com.ankamagames.atouin.types
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.data.elements.subtypes.EntityGraphicalElementData;
   import com.ankamagames.atouin.data.map.Map;
   import com.ankamagames.atouin.managers.AlwaysAnimatedElementManager;
   import com.ankamagames.atouin.managers.AnimatedElementManager;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.pools.WorldEntityPool;
   import com.ankamagames.atouin.utils.VisibleCellDetection;
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.jerakine.types.positions.WorldPoint;
   import com.ankamagames.tiphon.events.TiphonEvent;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class DataMapContainer
   {
      
      private static var _aInteractiveCell:Array;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(DataMapContainer));
       
      
      private var _spMap:Sprite;
      
      private var _aLayers:Array;
      
      private var _aCell:Array;
      
      private var _map:Map;
      
      private var _animatedElement:Array;
      
      private var _allowAnimatedGfx:Boolean;
      
      private var _temporaryEnable:Boolean = true;
      
      private var _alwaysAnimatedElement:Dictionary;
      
      private var _useWorldEntityPool:Boolean;
      
      public var layerDepth:Array;
      
      public var id:Number;
      
      public var rendered:Boolean = false;
      
      public function DataMapContainer(mapData:Map)
      {
         super();
         if(!this._spMap)
         {
            this._spMap = new Sprite();
            this._aLayers = new Array();
            _aInteractiveCell = new Array();
         }
         Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onOptionChange);
         this.id = mapData.id;
         this.layerDepth = new Array();
         this._aCell = new Array();
         this._map = mapData;
         this._animatedElement = new Array();
         this._alwaysAnimatedElement = new Dictionary(true);
         this._allowAnimatedGfx = Atouin.getInstance().options.getOption("allowAnimatedGfx");
         this._useWorldEntityPool = Atouin.getInstance().options.getOption("useWorldEntityPool");
      }
      
      public static function get interactiveCell() : Array
      {
         return _aInteractiveCell;
      }
      
      public function removeContainer() : void
      {
         var sprite:Sprite = null;
         var parentSprite:Sprite = null;
         var cellReference:CellReference = null;
         var i:uint = 0;
         var animatedElement:Object = null;
         var k:uint = 0;
         for each(animatedElement in this._animatedElement)
         {
            if(animatedElement.element is IDestroyable)
            {
               if(this._useWorldEntityPool)
               {
                  WorldEntityPool.checkIn(animatedElement.element);
               }
               else
               {
                  (animatedElement.element as IDestroyable).destroy();
               }
            }
         }
         for(k = 0; k < this._aCell.length; k++)
         {
            cellReference = this._aCell[k];
            if(cellReference)
            {
               for(i = 0; i < cellReference.listSprites.length; i++)
               {
                  if(cellReference.listSprites[i] is Sprite)
                  {
                     sprite = cellReference.listSprites[i];
                     if(sprite)
                     {
                        sprite.cacheAsBitmap = false;
                        parentSprite = Sprite(sprite.parent);
                        if(parentSprite)
                        {
                           parentSprite.removeChild(sprite);
                           delete cellReference.listSprites[i];
                           if(!parentSprite.numChildren)
                           {
                              parentSprite.parent.removeChild(parentSprite);
                           }
                        }
                     }
                  }
               }
               delete this._aCell[k];
            }
         }
         Atouin.getInstance().options.removeEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onOptionChange);
      }
      
      public function getCellReference(nId:uint) : CellReference
      {
         if(!this._aCell[nId])
         {
            this._aCell[nId] = new CellReference(nId);
         }
         return this._aCell[nId];
      }
      
      public function isRegisteredCell(nId:uint) : Boolean
      {
         return this._aCell[nId] != null;
      }
      
      public function getCell() : Array
      {
         return this._aCell;
      }
      
      public function getLayer(nId:int) : LayerContainer
      {
         if(!this._aLayers[nId])
         {
            this._aLayers[nId] = new LayerContainer(nId);
         }
         return this._aLayers[nId];
      }
      
      public function clean(bForceCleaning:Boolean = false) : Boolean
      {
         var sprite:Sprite = null;
         var parentSprite:Sprite = null;
         var cellReference:CellReference = null;
         var i:uint = 0;
         var provider:Array = null;
         var k:* = null;
         var p:WorldPoint = null;
         if(!bForceCleaning)
         {
            provider = VisibleCellDetection.detectCell(false,this._map,WorldPoint.fromMapId(this.id),Atouin.getInstance().options.getOption("frustum"),MapDisplayManager.getInstance().currentMapPoint).cell;
         }
         else
         {
            provider = new Array();
            for(i = 0; i < this._aCell.length; i++)
            {
               provider[i] = i;
            }
         }
         for(k in provider)
         {
            cellReference = this._aCell[k];
            if(cellReference)
            {
               for(i = 0; i < cellReference.listSprites.length; i++)
               {
                  sprite = cellReference.listSprites[i];
                  if(sprite)
                  {
                     sprite.cacheAsBitmap = false;
                     parentSprite = Sprite(sprite.parent);
                     parentSprite.removeChild(sprite);
                     delete cellReference.listSprites[i];
                     if(!parentSprite.numChildren)
                     {
                        parentSprite.parent.removeChild(parentSprite);
                     }
                  }
               }
               delete this._aCell[k];
            }
         }
         p = WorldPoint.fromMapId(this._map.id);
         p.x -= MapDisplayManager.getInstance().currentMapPoint.x;
         p.y -= MapDisplayManager.getInstance().currentMapPoint.y;
         return Math.abs(p.x) > 1 || Math.abs(p.y) > 1;
      }
      
      public function get mapContainer() : Sprite
      {
         return this._spMap;
      }
      
      public function get dataMap() : Map
      {
         return this._map;
      }
      
      public function addAnimatedElement(element:WorldEntitySprite, data:EntityGraphicalElementData) : void
      {
         var d:Object = {
            "element":element,
            "data":data
         };
         this._animatedElement.push(d);
         this.updateAnimatedElement(d);
      }
      
      public function setTemporaryAnimatedElementState(active:Boolean) : void
      {
         var d:Object = null;
         this._temporaryEnable = active;
         for each(d in this._animatedElement)
         {
            this.updateAnimatedElement(d);
         }
      }
      
      public function get x() : Number
      {
         return this._spMap.x;
      }
      
      public function get y() : Number
      {
         return this._spMap.y;
      }
      
      public function set x(nValue:Number) : void
      {
         this._spMap.x = nValue;
      }
      
      public function set y(nValue:Number) : void
      {
         this._spMap.y = nValue;
      }
      
      public function get scaleX() : Number
      {
         return this._spMap.scaleX;
      }
      
      public function get scaleY() : Number
      {
         return this._spMap.scaleY;
      }
      
      public function set scaleX(nValue:Number) : void
      {
         this._spMap.scaleX = nValue;
      }
      
      public function set scaleY(nValue:Number) : void
      {
         this._spMap.scaleX = nValue;
      }
      
      public function addChild(item:DisplayObject) : DisplayObject
      {
         return this._spMap.addChild(item);
      }
      
      public function addChildAt(item:DisplayObject, index:int) : DisplayObject
      {
         return this._spMap.addChildAt(item,index);
      }
      
      public function getChildIndex(item:DisplayObject) : int
      {
         return this._spMap.getChildIndex(item);
      }
      
      public function contains(item:DisplayObject) : Boolean
      {
         return this._spMap.contains(item);
      }
      
      public function getChildByName(name:String) : DisplayObject
      {
         return this._spMap.getChildByName(name);
      }
      
      public function removeChild(item:DisplayObject) : DisplayObject
      {
         if(item.parent && item.parent == this._spMap)
         {
            return this._spMap.removeChild(item);
         }
         return null;
      }
      
      public function addAlwayAnimatedElement(id:int) : void
      {
         var o:Object = null;
         for each(o in this._animatedElement)
         {
            if(o.element.identifier == id)
            {
               this._alwaysAnimatedElement[o] = true;
               this.updateAnimatedElement(o);
            }
         }
      }
      
      public function removeAlwayAnimatedElement(id:int) : void
      {
         var o:Object = null;
         for each(o in this._animatedElement)
         {
            if(o.element.identifier == id)
            {
               delete this._alwaysAnimatedElement[o];
               this.updateAnimatedElement(o);
            }
         }
      }
      
      private function updateAnimatedElement(target:Object) : void
      {
         var ts:WorldEntitySprite = target.element;
         var eed:EntityGraphicalElementData = target.data;
         var allowAnimatedGfx:Boolean = this._temporaryEnable && (this._allowAnimatedGfx || this._alwaysAnimatedElement[target]);
         if(allowAnimatedGfx && eed.playAnimation)
         {
            if(eed.maxDelay > 0)
            {
               AnimatedElementManager.removeAnimatedElement(ts);
               AnimatedElementManager.addAnimatedElement(ts,eed.minDelay * 1000,eed.maxDelay * 1000);
               if(eed.playAnimStatic)
               {
                  ts.setAnimation("AnimStatique");
               }
            }
            else if(this._alwaysAnimatedElement[target])
            {
               AlwaysAnimatedElementManager.removeAnimatedElement(ts);
               AlwaysAnimatedElementManager.addAnimatedElement(ts);
            }
            else if(eed.entityLook == "{5247}" || eed.entityLook == "{5249}" || eed.entityLook == "{5250}" || eed.entityLook == "{5251}")
            {
               if(ts.getAnimation() != "AnimState" + ts.getDirection())
               {
                  ts.setAnimationAndDirection("AnimState" + ts.getDirection(),0);
               }
               else
               {
                  ts.restartAnimation();
               }
            }
            else if(ts.getAnimation() != "AnimStart")
            {
               ts.setAnimation("AnimStart");
            }
            else
            {
               ts.restartAnimation();
            }
         }
         else
         {
            AnimatedElementManager.removeAnimatedElement(ts);
            AlwaysAnimatedElementManager.removeAnimatedElement(ts);
            if(eed.playAnimation)
            {
               if(eed.entityLook == "{5247}" || eed.entityLook == "{5249}" || eed.entityLook == "{5250}" || eed.entityLook == "{5251}")
               {
                  if(ts.getAnimation() == "AnimState0" && ts.hasAnimation("AnimStatique"))
                  {
                     ts.setAnimationAndDirection("AnimStatique",0);
                  }
                  else if(ts.getAnimation() == "AnimState1" && ts.hasAnimation("AnimStatique"))
                  {
                     ts.setAnimationAndDirection("AnimStatique",1);
                  }
                  else if(ts.hasAnimation("AnimStatique"))
                  {
                     ts.setAnimation("AnimStatique");
                  }
               }
               else if(ts.hasAnimation("AnimStatique"))
               {
                  ts.setAnimation("AnimStatique");
               }
               else
               {
                  ts.setAnimation("AnimStatique");
                  ts.stopAnimation();
               }
            }
            else
            {
               ts.stopAnimation();
            }
         }
      }
      
      private function onEntityRendered(e:TiphonEvent) : void
      {
         var d:Object = null;
         for each(d in this._animatedElement)
         {
            if(d.element == e.sprite)
            {
               e.sprite.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityRendered);
               this.updateAnimatedElement(d);
               break;
            }
         }
         e.sprite.removeEventListener(TiphonEvent.RENDER_SUCCEED,this.onEntityRendered);
      }
      
      private function onOptionChange(e:PropertyChangeEvent) : void
      {
         var d:Object = null;
         if(e.propertyName == "allowAnimatedGfx")
         {
            this._allowAnimatedGfx = e.propertyValue;
            for each(d in this._animatedElement)
            {
               this.updateAnimatedElement(d);
            }
         }
      }
   }
}
