package com.ankamagames.atouin.types
{
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.managers.EntitiesDisplayManager;
   import com.ankamagames.jerakine.entities.behaviours.IDisplayBehavior;
   import com.ankamagames.jerakine.entities.interfaces.IDisplayable;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.display.Shape;
   import flash.geom.Point;
   
   public class FurnitureZoneTile extends Shape implements IDisplayable
   {
       
      
      private var _displayBehaviors:IDisplayBehavior;
      
      private var _displayed:Boolean;
      
      private var _currentCell:Point;
      
      private var _cellId:uint;
      
      public var strata:uint = 10;
      
      public var needFill:Boolean = false;
      
      public var offset:Point;
      
      public function FurnitureZoneTile()
      {
         super();
      }
      
      public function display(strata:uint = 0) : void
      {
         EntitiesDisplayManager.getInstance().displayEntity(this,MapPoint.fromCellId(this._cellId),strata,false);
         this._displayed = true;
         if(this.offset)
         {
            this.x -= this.offset.x;
            this.y -= this.offset.y;
         }
      }
      
      public function draw(bottomLeft:Boolean, topLeft:Boolean, topRight:Boolean, bottomRight:Boolean, cellHeight:int) : void
      {
         cellHeight *= -1;
         graphics.clear();
         if(cellHeight)
         {
            graphics.lineStyle(2,16777215,0.8);
            graphics.moveTo(AtouinConstants.CELL_HALF_WIDTH,0);
            graphics.lineTo(AtouinConstants.CELL_HALF_WIDTH,cellHeight);
            graphics.moveTo(0,AtouinConstants.CELL_HALF_HEIGHT);
            graphics.lineTo(0,cellHeight + AtouinConstants.CELL_HALF_HEIGHT);
            graphics.moveTo(-AtouinConstants.CELL_HALF_WIDTH,0);
            graphics.lineTo(-AtouinConstants.CELL_HALF_WIDTH,cellHeight);
            graphics.moveTo(AtouinConstants.CELL_HALF_WIDTH,0);
            graphics.lineTo(0,AtouinConstants.CELL_HALF_HEIGHT);
            graphics.lineTo(-AtouinConstants.CELL_HALF_WIDTH,0);
         }
         if(this.needFill)
         {
            graphics.beginFill(16777215,0.8);
         }
         graphics.moveTo(0,cellHeight - AtouinConstants.CELL_HALF_HEIGHT);
         graphics.lineStyle(2,16777215,!topRight || this.needFill ? Number(0.8) : Number(0));
         graphics.lineTo(AtouinConstants.CELL_HALF_WIDTH,cellHeight);
         graphics.lineStyle(2,16777215,!bottomRight || this.needFill ? Number(0.8) : Number(0));
         graphics.lineTo(0,cellHeight + AtouinConstants.CELL_HALF_HEIGHT);
         graphics.lineStyle(2,16777215,!bottomLeft || this.needFill ? Number(0.8) : Number(0));
         graphics.lineTo(-AtouinConstants.CELL_HALF_WIDTH,cellHeight);
         graphics.lineStyle(2,16777215,!topLeft || this.needFill ? Number(0.8) : Number(0));
         graphics.lineTo(0,cellHeight - AtouinConstants.CELL_HALF_HEIGHT);
         graphics.endFill();
      }
      
      public function remove() : void
      {
         this.offset = null;
         this.needFill = false;
         this._displayed = false;
         EntitiesDisplayManager.getInstance().removeEntity(this);
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
   }
}
