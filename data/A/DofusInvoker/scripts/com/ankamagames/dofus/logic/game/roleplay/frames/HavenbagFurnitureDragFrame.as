package com.ankamagames.dofus.logic.game.roleplay.frames
{
   import com.ankamagames.atouin.data.map.CellData;
   import com.ankamagames.atouin.managers.HavenbagFurnituresManager;
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.atouin.messages.CellOutMessage;
   import com.ankamagames.atouin.messages.CellOverMessage;
   import com.ankamagames.atouin.messages.MapContainerRollOutMessage;
   import com.ankamagames.atouin.messages.MapContainerRollOverMessage;
   import com.ankamagames.atouin.types.GraphicCell;
   import com.ankamagames.atouin.types.IFurniture;
   import com.ankamagames.atouin.utils.CellUtil;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
   import com.ankamagames.berilia.types.data.LinkedCursorData;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementMouseOutMessage;
   import com.ankamagames.dofus.logic.game.roleplay.messages.InteractiveElementMouseOverMessage;
   import com.ankamagames.dofus.types.entities.HavenbagFurnitureSprite;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.handlers.messages.keyboard.KeyboardKeyUpMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseClickMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseDownMessage;
   import com.ankamagames.jerakine.handlers.messages.mouse.MouseUpMessage;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import flash.geom.Point;
   import flash.ui.Keyboard;
   import flash.utils.getQualifiedClassName;
   
   public class HavenbagFurnitureDragFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(HavenbagFurnitureDragFrame));
      
      private static const FORBIDDEN_CURSOR:Class = HavenbagFurnitureDragFrame_FORBIDDEN_CURSOR;
       
      
      private var _havenbagFrame:HavenbagFrame;
      
      private var _furniture:HavenbagFurnitureSprite;
      
      private var _mouseIsDown:Boolean;
      
      private var _InteractiveCellManager_click:Boolean;
      
      private var _InteractiveCellManager_over:Boolean;
      
      private var _InteractiveCellManager_out:Boolean;
      
      private var _cursorData:LinkedCursorData;
      
      private var _draggedFurnitureCursorData:LinkedCursorData;
      
      private var _moveOnly:Boolean;
      
      public function HavenbagFurnitureDragFrame(furnitureTypeId:uint, furnitureOrientation:uint, havenbagFrame:HavenbagFrame, moveOnly:Boolean = false)
      {
         super();
         this._havenbagFrame = havenbagFrame;
         this._furniture = new HavenbagFurnitureSprite(furnitureTypeId);
         this._furniture.orientation = furnitureOrientation;
         this._moveOnly = moveOnly;
         this._cursorData = new LinkedCursorData();
         this._cursorData.sprite = new FORBIDDEN_CURSOR();
         this._cursorData.offset = new Point(-20,-20);
      }
      
      public function get furniture() : HavenbagFurnitureSprite
      {
         return this._furniture;
      }
      
      public function pushed() : Boolean
      {
         this._mouseIsDown = false;
         LinkedCursorSpriteManager.getInstance().addItem("furnitureNotAllowedCursor",this._cursorData);
         this._cursorData.sprite.visible = false;
         this._InteractiveCellManager_click = InteractiveCellManager.getInstance().cellClickEnabled;
         this._InteractiveCellManager_over = InteractiveCellManager.getInstance().cellOverEnabled;
         this._InteractiveCellManager_out = InteractiveCellManager.getInstance().cellOutEnabled;
         InteractiveCellManager.getInstance().setInteraction(true,true,true,true,true);
         this._draggedFurnitureCursorData = LinkedCursorSpriteManager.getInstance().getItem(Slot.DRAG_AND_DROP_CURSOR_NAME);
         HavenbagFurnituresManager.getInstance().disableMouseEvents();
         return true;
      }
      
      public function pulled() : Boolean
      {
         LinkedCursorSpriteManager.getInstance().removeItem("furnitureNotAllowedCursor");
         InteractiveCellManager.getInstance().setInteraction(this._InteractiveCellManager_click,this._InteractiveCellManager_over,this._InteractiveCellManager_out);
         this._draggedFurnitureCursorData = null;
         this._furniture.remove();
         if(this._havenbagFrame.isInEditMode)
         {
            HavenbagFurnituresManager.getInstance().enableMouseEvents();
         }
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var cell:GraphicCell = null;
         var conmsg:CellOverMessage = null;
         var mcmsg:MouseClickMessage = null;
         var kkupmsg:KeyboardKeyUpMessage = null;
         switch(true)
         {
            case msg is CellOverMessage:
               conmsg = msg as CellOverMessage;
               if(this._mouseIsDown)
               {
                  this.onCellPointed(this.havenbagCellValidator(conmsg.cellId) && this.furnitureCellValidator(conmsg.cellId),conmsg.cellId,false);
               }
               else
               {
                  this.refreshTarget(conmsg.cellId);
               }
               return true;
            case msg is CellOutMessage:
               this.refreshTarget(-1);
               return true;
            case msg is CellClickMessage:
               return true;
            case msg is MouseClickMessage:
               mcmsg = msg as MouseClickMessage;
               if(mcmsg.target is GraphicCell || mcmsg.target is IEntity)
               {
                  return false;
               }
               this.onCellPointed(false,-1);
               return false;
               break;
            case msg is MouseDownMessage:
               cell = MouseDownMessage(msg).target as GraphicCell;
               if(cell)
               {
                  this._mouseIsDown = true;
                  this.onCellPointed(this.havenbagCellValidator(cell.cellId) && this.furnitureCellValidator(cell.cellId),cell.cellId,false);
               }
               return false;
            case msg is MouseUpMessage:
               this._mouseIsDown = false;
               cell = MouseUpMessage(msg).target as GraphicCell;
               if(cell)
               {
                  this.onCellPointed(this.havenbagCellValidator(cell.cellId) && this.furnitureCellValidator(cell.cellId),cell.cellId,false);
               }
               else if(this._draggedFurnitureCursorData)
               {
                  this.clear();
               }
               return false;
            case msg is MapContainerRollOutMessage:
               this._cursorData.sprite.visible = false;
               if(this._draggedFurnitureCursorData)
               {
                  this._draggedFurnitureCursorData.sprite.visible = true;
               }
               this._furniture.remove();
               return false;
            case msg is MapContainerRollOverMessage:
               this._cursorData.sprite.visible = true;
               if(this._draggedFurnitureCursorData)
               {
                  this._draggedFurnitureCursorData.sprite.visible = false;
               }
               return false;
            case msg is KeyboardKeyUpMessage:
               kkupmsg = msg as KeyboardKeyUpMessage;
               if(kkupmsg.keyboardEvent.keyCode == Keyboard.SHIFT)
               {
                  ++this._furniture.orientation;
                  if(this._furniture.cellsWidth != this._furniture.cellsHeight)
                  {
                     HavenbagFurnituresManager.getInstance().cancelPreviewFurniture(this._furniture);
                     this.refreshTarget(this._furniture.position.cellId,false);
                  }
               }
               return false;
            case msg is InteractiveElementMouseOverMessage:
            case msg is InteractiveElementMouseOutMessage:
               return true;
            default:
               return false;
         }
      }
      
      public function get priority() : int
      {
         return Priority.ULTIMATE_HIGHEST_DEPTH_OF_DOOM;
      }
      
      public function clear() : void
      {
         this._havenbagFrame.clearFurnitureDragFrame();
         HavenbagFurnituresManager.getInstance().cancelPreviewFurniture(this._furniture);
         Kernel.getWorker().removeFrame(this);
      }
      
      private function onCellPointed(success:Boolean, cellId:int, removeFrame:Boolean = true) : void
      {
         var furniture:HavenbagFurnitureSprite = null;
         if(success)
         {
            furniture = new HavenbagFurnitureSprite(this._furniture.typeId);
            furniture.position.cellId = cellId;
            furniture.orientation = this._furniture.orientation;
            HavenbagFurnituresManager.getInstance().cancelPreviewFurniture(this._furniture);
            HavenbagFurnituresManager.getInstance().addFurniture(furniture);
         }
         if(removeFrame || this._moveOnly)
         {
            this._havenbagFrame.clearFurnitureDragFrame();
            Kernel.getWorker().removeFrame(this);
         }
      }
      
      private function refreshTarget(target:int, cancel:Boolean = true) : void
      {
         if(target != -1 && this.havenbagCellValidator(target))
         {
            if(this.furnitureCellValidator(target))
            {
               HavenbagFurnituresManager.getInstance().previewFurniture(this._furniture);
            }
         }
         else if(cancel)
         {
            HavenbagFurnituresManager.getInstance().cancelPreviewFurniture(this._furniture);
         }
      }
      
      private function havenbagCellValidator(cellId:int) : Boolean
      {
         var j:int = 0;
         this._furniture.position = MapPoint.fromCellId(cellId);
         var cellData:CellData = MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[cellId];
         var cellIsValid:Boolean = DataMapProvider.getInstance().cellByIdIsHavenbagCell(cellId);
         var cells:Vector.<MapPoint> = this._furniture.cells;
         var cellFloor:int = cellData.floor;
         if(cellIsValid && cells.length > 1)
         {
            for(j = 0; j < cells.length; j++)
            {
               if(cells[j].cellId != cellId)
               {
                  if(!CellUtil.isValidCellIndex(cells[j].cellId))
                  {
                     cellIsValid = false;
                     this._furniture.displayAsError();
                     break;
                  }
                  cellData = MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[cells[j].cellId];
                  if(!cellData || cellData.floor != cellFloor)
                  {
                     cellIsValid = false;
                     this._furniture.displayAsError();
                     break;
                  }
                  cellIsValid = DataMapProvider.getInstance().cellByIdIsHavenbagCell(cells[j].cellId);
                  if(!cellIsValid)
                  {
                     this._furniture.displayAsError();
                     break;
                  }
               }
            }
         }
         this._cursorData.sprite.visible = !cellIsValid;
         return cellIsValid;
      }
      
      private function furnitureCellValidator(cellId:int) : Boolean
      {
         var cell:MapPoint = null;
         var furnituresOnCell:Vector.<IFurniture> = null;
         var i:int = 0;
         this._furniture.position = MapPoint.fromCellId(cellId);
         var skipErrorDisplay:Boolean = false;
         var cellIsValid:Boolean = true;
         var cells:Vector.<MapPoint> = this._furniture.cells;
         for each(cell in cells)
         {
            furnituresOnCell = HavenbagFurnituresManager.getInstance().getFurnituresOnCellId(cell.cellId);
            if(furnituresOnCell)
            {
               if(furnituresOnCell[this._furniture.layerId])
               {
                  if(furnituresOnCell[this._furniture.layerId].position.cellId != cellId)
                  {
                     cellIsValid = false;
                  }
                  if(this._furniture.typeId == furnituresOnCell[this._furniture.layerId].typeId && this._furniture.orientation == furnituresOnCell[this._furniture.layerId].orientation)
                  {
                     this._furniture.remove();
                     skipErrorDisplay = true;
                     cellIsValid = false;
                     break;
                  }
                  if(this._furniture.cellsWidth <= furnituresOnCell[this._furniture.layerId].cellsWidth && this._furniture.cellsHeight <= furnituresOnCell[this._furniture.layerId].cellsHeight)
                  {
                     break;
                  }
                  continue;
                  break;
               }
               for(i = 0; i < this._furniture.layerId; i++)
               {
                  if(furnituresOnCell[i] && !furnituresOnCell[i].isStackable)
                  {
                     cellIsValid = false;
                     skipErrorDisplay = true;
                     break;
                  }
               }
               if(!cellIsValid)
               {
                  break;
               }
            }
         }
         if(!cellIsValid && !skipErrorDisplay)
         {
            this._furniture.displayAsError();
         }
         if(this._draggedFurnitureCursorData)
         {
            this._draggedFurnitureCursorData.sprite.visible = false;
         }
         return cellIsValid;
      }
   }
}
