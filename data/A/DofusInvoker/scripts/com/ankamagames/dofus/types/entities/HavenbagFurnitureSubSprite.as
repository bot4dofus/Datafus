package com.ankamagames.dofus.types.entities
{
   import com.ankamagames.atouin.data.elements.subtypes.NormalGraphicalElementData;
   import com.ankamagames.atouin.enums.HavenbagLayersEnum;
   import com.ankamagames.atouin.managers.EntitiesDisplayManager;
   import com.ankamagames.atouin.managers.HavenbagFurnituresManager;
   import com.ankamagames.atouin.types.IFurniture;
   import com.ankamagames.jerakine.entities.behaviours.IDisplayBehavior;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.errors.IllegalOperationError;
   import flash.geom.Point;
   import flash.utils.getQualifiedClassName;
   
   public class HavenbagFurnitureSubSprite extends Sprite implements IFurniture
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HavenbagFurnitureSubSprite));
       
      
      public var source:HavenbagFurnitureSprite;
      
      public var order:uint;
      
      private var _position:MapPoint;
      
      private var _bitmapPosition:Point;
      
      private var _displayed:Boolean;
      
      public function HavenbagFurnitureSubSprite(bmp:Bitmap, source:HavenbagFurnitureSprite, position:MapPoint, order:uint)
      {
         super();
         this.source = source;
         this.order = order;
         this._position = position;
         this._displayed = false;
         mouseEnabled = source.mouseEnabled;
         mouseChildren = source.mouseChildren;
         buttonMode = source.buttonMode;
         addChild(bmp);
         this._bitmapPosition = new Point(bmp.x,bmp.y);
      }
      
      public function get cells() : Vector.<MapPoint>
      {
         return this.source.cells;
      }
      
      public function get displayBehaviors() : IDisplayBehavior
      {
         return null;
      }
      
      public function set displayBehaviors(oValue:IDisplayBehavior) : void
      {
      }
      
      public function get displayed() : Boolean
      {
         return this._displayed;
      }
      
      public function get absoluteBounds() : IRectangle
      {
         return null;
      }
      
      public function display(strata:uint = 0) : void
      {
         this._displayed = true;
         getChildAt(0).x = this._bitmapPosition.x;
         getChildAt(0).y = this._bitmapPosition.y;
         if(this.source.layerId != HavenbagLayersEnum.FLOOR)
         {
            EntitiesDisplayManager.getInstance().displayEntity(this,this.position,this.source.strata,false);
         }
         else
         {
            EntitiesDisplayManager.getInstance().displayEntity(this,this.position,this.source.strata,false,HavenbagFurnituresManager.getInstance().sortFloorFurnitures);
         }
      }
      
      public function remove() : void
      {
         this._displayed = false;
         EntitiesDisplayManager.getInstance().removeEntity(this);
      }
      
      public function get cellsHeight() : uint
      {
         return this.source.cellsHeight;
      }
      
      public function get cellsWidth() : uint
      {
         return this.source.width;
      }
      
      public function destroy() : void
      {
         this._position = null;
         this._bitmapPosition = null;
         while(numChildren)
         {
            removeChildAt(0);
         }
         this.remove();
         this.source = null;
      }
      
      public function set id(value:Number) : void
      {
         throw new IllegalOperationError("Furniture id are automatically generated with EntitiesManager.getInstance().getFreeEntityId()");
      }
      
      public function get id() : Number
      {
         return this.source.id;
      }
      
      public function get position() : MapPoint
      {
         return this._position;
      }
      
      public function set position(oValue:MapPoint) : void
      {
         this._position = oValue;
      }
      
      public function addEventListeners() : void
      {
      }
      
      public function get element() : NormalGraphicalElementData
      {
         return this.source.element;
      }
      
      public function get isStackable() : Boolean
      {
         return this.source.isStackable;
      }
      
      public function get orientation() : uint
      {
         return this.source.orientation;
      }
      
      public function removeEventListeners() : void
      {
      }
      
      public function get strata() : uint
      {
         return this.source.strata;
      }
      
      public function get typeId() : int
      {
         return this.source.typeId;
      }
      
      public function get uri() : Uri
      {
         return this.source.uri;
      }
      
      public function canSeeThrough() : Boolean
      {
         return this.source.canSeeThrough();
      }
      
      public function canWalkThrough() : Boolean
      {
         return this.source.canWalkThrough();
      }
      
      public function canWalkTo() : Boolean
      {
         return this.source.canWalkTo();
      }
      
      public function get elementHeight() : uint
      {
         return this.source.elementHeight;
      }
      
      public function get layerId() : int
      {
         return this.source.layerId;
      }
      
      public function updateContentY(offset:Number = 0, cellId:int = -1) : void
      {
      }
      
      public function displayHighlight(display:Boolean) : void
      {
         if(this.source)
         {
            this.source.displayHighlight(display);
         }
      }
      
      public function set offsetPosition(mp:MapPoint) : void
      {
      }
      
      public function get offsetPosition() : MapPoint
      {
         return null;
      }
   }
}
