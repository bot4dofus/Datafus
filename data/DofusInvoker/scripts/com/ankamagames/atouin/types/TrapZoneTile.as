package com.ankamagames.atouin.types
{
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.managers.EntitiesDisplayManager;
   import com.ankamagames.atouin.renderers.TrapZoneRenderer;
   import com.ankamagames.jerakine.entities.behaviours.IDisplayBehavior;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class TrapZoneTile extends Sprite implements IDisplayable
   {
      
      public static const BASE_ALPHA:Number = 0.3;
      
      private static const DEFAULT_COLOR:uint = 0;
      
      private static const REGULAR_LINE_WIDTH:Number = 3;
      
      private static const REGULAR_LINE_ALPHA:Number = 1;
      
      private static const THICK_LINE_WIDTH:Number = 5;
      
      private static const THICK_LINE_ALPHA:Number = 0.5;
      
      private static const CELL_OFFSET:Number = 0.1;
       
      
      public var strata:uint = 10;
      
      private var _displayBehaviors:IDisplayBehavior;
      
      private var _displayed:Boolean;
      
      private var _currentCell:Point;
      
      private var _cellId:uint;
      
      private var _tileAlpha:Number = 0.3;
      
      private var _trapZoneRenderers:Vector.<TrapZoneRenderer>;
      
      private var _topBorderRefs:Vector.<TrapZoneRenderer>;
      
      private var _rightBorderRefs:Vector.<TrapZoneRenderer>;
      
      private var _bottomBorderRefs:Vector.<TrapZoneRenderer>;
      
      private var _leftBorderRefs:Vector.<TrapZoneRenderer>;
      
      public function TrapZoneTile()
      {
         this._trapZoneRenderers = new Vector.<TrapZoneRenderer>(0);
         this._topBorderRefs = new Vector.<TrapZoneRenderer>(0);
         this._rightBorderRefs = new Vector.<TrapZoneRenderer>(0);
         this._bottomBorderRefs = new Vector.<TrapZoneRenderer>(0);
         this._leftBorderRefs = new Vector.<TrapZoneRenderer>(0);
         super();
         this.refreshTile();
      }
      
      public function get displayBehaviors() : IDisplayBehavior
      {
         return this._displayBehaviors;
      }
      
      public function set displayBehaviors(value:IDisplayBehavior) : void
      {
         this._displayBehaviors = value;
      }
      
      public function get currentCell() : Point
      {
         return this._currentCell;
      }
      
      public function set currentCell(value:Point) : void
      {
         this._currentCell = value;
      }
      
      public function get displayed() : Boolean
      {
         return this._displayed;
      }
      
      public function get absoluteBounds() : IRectangle
      {
         return this._displayBehaviors.getAbsoluteBounds(this);
      }
      
      public function get cellId() : uint
      {
         return this._cellId;
      }
      
      public function set cellId(value:uint) : void
      {
         this._cellId = value;
      }
      
      public function get areTopBorders() : Boolean
      {
         return this._topBorderRefs.length > 0;
      }
      
      public function get areRightBorders() : Boolean
      {
         return this._rightBorderRefs.length > 0;
      }
      
      public function get areBottomBorders() : Boolean
      {
         return this._bottomBorderRefs.length > 0;
      }
      
      public function get areLeftBorders() : Boolean
      {
         return this._leftBorderRefs.length > 0;
      }
      
      override public function get graphics() : Graphics
      {
         return super.graphics;
      }
      
      public function set tileAlpha(tileAlpha:Number) : void
      {
         this._tileAlpha = tileAlpha;
         this.refreshTile();
      }
      
      public function get tileAlpha() : Number
      {
         return this._tileAlpha;
      }
      
      public function get trapZoneRenderers() : Vector.<TrapZoneRenderer>
      {
         return this._trapZoneRenderers;
      }
      
      public function addTrapZoneRenderer(trapZoneRenderer:TrapZoneRenderer) : void
      {
         this._trapZoneRenderers.push(trapZoneRenderer);
      }
      
      public function removeTrapZoneRenderer(trapZoneRenderer:TrapZoneRenderer) : void
      {
         var index:Number = this._trapZoneRenderers.indexOf(trapZoneRenderer);
         if(index !== -1)
         {
            this._trapZoneRenderers.removeAt(index);
         }
      }
      
      public function addTopBorderRef(trapZoneRenderer:TrapZoneRenderer) : void
      {
         this._topBorderRefs.push(trapZoneRenderer);
      }
      
      public function addBottomBorderRef(trapZoneRenderer:TrapZoneRenderer) : void
      {
         this._bottomBorderRefs.push(trapZoneRenderer);
      }
      
      public function addLeftBorderRef(trapZoneRenderer:TrapZoneRenderer) : void
      {
         this._leftBorderRefs.push(trapZoneRenderer);
      }
      
      public function addRightBorderRef(trapZoneRenderer:TrapZoneRenderer) : void
      {
         this._rightBorderRefs.push(trapZoneRenderer);
      }
      
      public function removeTopBorderRef(trapZoneRenderer:TrapZoneRenderer) : void
      {
         var index:Number = this._topBorderRefs.indexOf(trapZoneRenderer);
         if(index !== -1)
         {
            this._topBorderRefs.removeAt(index);
         }
      }
      
      public function removeBottomBorderRef(trapZoneRenderer:TrapZoneRenderer) : void
      {
         var index:Number = this._bottomBorderRefs.indexOf(trapZoneRenderer);
         if(index !== -1)
         {
            this._bottomBorderRefs.removeAt(index);
         }
      }
      
      public function removeLeftBorderRef(trapZoneRenderer:TrapZoneRenderer) : void
      {
         var index:Number = this._leftBorderRefs.indexOf(trapZoneRenderer);
         if(index !== -1)
         {
            this._leftBorderRefs.removeAt(index);
         }
      }
      
      public function removeRightBorderRef(trapZoneRenderer:TrapZoneRenderer) : void
      {
         var index:Number = this._rightBorderRefs.indexOf(trapZoneRenderer);
         if(index !== -1)
         {
            this._rightBorderRefs.removeAt(index);
         }
      }
      
      public function refreshTile() : void
      {
         var firstChild:DisplayObject = null;
         var shape:Shape = null;
         var trapZoneGraphics:Graphics = null;
         if(numChildren > 0)
         {
            firstChild = getChildAt(0);
            if(firstChild is Shape)
            {
               trapZoneGraphics = (firstChild as Shape).graphics;
            }
         }
         if(trapZoneGraphics === null)
         {
            shape = new Shape();
            addChild(shape);
            trapZoneGraphics = shape.graphics;
         }
         trapZoneGraphics.clear();
         trapZoneGraphics.beginFill(DEFAULT_COLOR,this._tileAlpha);
         trapZoneGraphics.moveTo(CELL_OFFSET,-AtouinConstants.CELL_HALF_HEIGHT);
         trapZoneGraphics.lineTo(AtouinConstants.CELL_HALF_WIDTH - CELL_OFFSET,0);
         trapZoneGraphics.lineTo(CELL_OFFSET,AtouinConstants.CELL_HALF_HEIGHT);
         trapZoneGraphics.lineTo(-AtouinConstants.CELL_HALF_WIDTH - CELL_OFFSET,0);
         trapZoneGraphics.endFill();
      }
      
      public function display(strata:uint = 0) : void
      {
         EntitiesDisplayManager.getInstance().displayEntity(this,MapPoint.fromCellId(this._cellId),strata,false);
         this._displayed = true;
      }
      
      public function refreshBorders(isThickLine:Boolean = false) : void
      {
         this.graphics.clear();
         this.graphics.lineStyle(!!isThickLine ? Number(REGULAR_LINE_ALPHA) : Number(REGULAR_LINE_WIDTH),DEFAULT_COLOR,!!isThickLine ? Number(THICK_LINE_ALPHA) : Number(THICK_LINE_WIDTH));
         if(this.areTopBorders)
         {
            this.graphics.moveTo(-AtouinConstants.CELL_HALF_WIDTH,0);
            this.graphics.lineTo(0,AtouinConstants.CELL_HALF_HEIGHT);
         }
         if(this.areBottomBorders)
         {
            this.graphics.moveTo(0,-AtouinConstants.CELL_HALF_HEIGHT);
            this.graphics.lineTo(AtouinConstants.CELL_HALF_WIDTH,0);
         }
         if(this.areLeftBorders)
         {
            this.graphics.moveTo(AtouinConstants.CELL_HALF_WIDTH,0);
            this.graphics.lineTo(0,AtouinConstants.CELL_HALF_HEIGHT);
         }
         if(this.areRightBorders)
         {
            this.graphics.moveTo(-AtouinConstants.CELL_HALF_WIDTH,0);
            this.graphics.lineTo(0,-AtouinConstants.CELL_HALF_HEIGHT);
         }
      }
      
      public function remove() : void
      {
         this._displayed = false;
         EntitiesDisplayManager.getInstance().removeEntity(this);
      }
   }
}
