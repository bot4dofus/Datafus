package com.ankamagames.atouin.managers
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.data.map.CellData;
   import com.ankamagames.atouin.data.map.Layer;
   import com.ankamagames.atouin.messages.CellClickMessage;
   import com.ankamagames.atouin.messages.CellOutMessage;
   import com.ankamagames.atouin.messages.CellOverMessage;
   import com.ankamagames.atouin.renderers.TrapZoneRenderer;
   import com.ankamagames.atouin.renderers.ZoneDARenderer;
   import com.ankamagames.atouin.types.CellContainer;
   import com.ankamagames.atouin.types.CellReference;
   import com.ankamagames.atouin.types.DataMapContainer;
   import com.ankamagames.atouin.types.DebugToolTip;
   import com.ankamagames.atouin.types.GraphicCell;
   import com.ankamagames.atouin.types.LayerContainer;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.atouin.utils.CellIdConverter;
   import com.ankamagames.atouin.utils.CellUtil;
   import com.ankamagames.atouin.utils.DataMapProvider;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.zones.Lozenge;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.display.spellZone.SpellShapeEnum;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.getQualifiedClassName;
   
   public class InteractiveCellManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(InteractiveCellManager));
      
      private static var _self:InteractiveCellManager;
       
      
      private var _cellOverEnabled:Boolean = false;
      
      private var _aCells:Array;
      
      private var _aCellPool:Array;
      
      private var _bShowGrid:Boolean;
      
      private var _showEveryCellId:Boolean;
      
      private var _isInFight:Boolean = false;
      
      private var _interaction_click:Boolean;
      
      private var _interaction_out:Boolean;
      
      private var _trapZoneRenderer:TrapZoneRenderer;
      
      public function InteractiveCellManager()
      {
         this._aCellPool = new Array();
         this._bShowGrid = Atouin.getInstance().options.getOption("alwaysShowGrid");
         this._showEveryCellId = Atouin.getInstance().options.getOption("showEveryCellId");
         super();
         if(_self)
         {
            throw new SingletonError();
         }
         this.init();
      }
      
      public static function getInstance() : InteractiveCellManager
      {
         if(!_self)
         {
            _self = new InteractiveCellManager();
         }
         return _self;
      }
      
      public function get cellOverEnabled() : Boolean
      {
         return this._cellOverEnabled;
      }
      
      public function set cellOverEnabled(value:Boolean) : void
      {
         this.overStateChanged(this._cellOverEnabled,value);
         this._cellOverEnabled = value;
      }
      
      public function get cellOutEnabled() : Boolean
      {
         return this._interaction_out;
      }
      
      public function get cellClickEnabled() : Boolean
      {
         return this._interaction_click;
      }
      
      public function initManager() : void
      {
         this._aCells = new Array();
         Atouin.getInstance().options.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,this.onPropertyChanged);
      }
      
      public function setInteraction(click:Boolean = true, over:Boolean = false, out:Boolean = false, updateHavenbagCellVisibility:Boolean = false, visible:Boolean = true) : void
      {
         var cell:GraphicCell = null;
         this._interaction_click = click;
         this._cellOverEnabled = over;
         this._interaction_out = out;
         for each(cell in this._aCells)
         {
            if(click)
            {
               cell.addEventListener(MouseEvent.CLICK,this.mouseClick);
            }
            else
            {
               cell.removeEventListener(MouseEvent.CLICK,this.mouseClick);
            }
            if(over)
            {
               cell.addEventListener(MouseEvent.MOUSE_OVER,this.mouseOver);
            }
            else
            {
               cell.removeEventListener(MouseEvent.MOUSE_OVER,this.mouseOver);
            }
            if(out)
            {
               cell.addEventListener(MouseEvent.MOUSE_OUT,this.mouseOut);
            }
            else
            {
               cell.removeEventListener(MouseEvent.MOUSE_OUT,this.mouseOut);
            }
            cell.mouseEnabled = click || over || out;
            if(updateHavenbagCellVisibility && CellData(MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[cell.cellId]).havenbagCell)
            {
               cell.visible = visible;
            }
         }
      }
      
      public function getCell(cellId:uint) : GraphicCell
      {
         if(cellId > CellUtil.MAX_CELL_ID || cellId < CellUtil.MIN_CELL_ID)
         {
            return null;
         }
         this._aCells[cellId] = this._aCellPool[cellId];
         return this._aCells[cellId];
      }
      
      public function updateInteractiveCell(container:DataMapContainer) : void
      {
         var cellRef:CellReference = null;
         var gCell:GraphicCell = null;
         var lastZCell:DisplayObject = null;
         var cellCtr:CellContainer = null;
         if(!container)
         {
            _log.error("Can\'t update interactive cell of a NULL container");
            return;
         }
         this.setInteraction(true,Atouin.getInstance().options.getOption("showCellIdOnOver"),Atouin.getInstance().options.getOption("showCellIdOnOver"));
         this.showEveryCellId(Atouin.getInstance().options.getOption("showEveryCellId"));
         var aCell:Array = container.getCell();
         var showTransitions:Boolean = Atouin.getInstance().options.getOption("showTransitions");
         var alpha:Number = this._bShowGrid || Atouin.getInstance().options.getOption("alwaysShowGrid") ? Number(1) : Number(0);
         if(this._showEveryCellId && alpha == 0)
         {
            alpha = 0.8;
         }
         var layer:LayerContainer = container.getLayer(Layer.LAYER_DECOR);
         var cellIndex:uint = 0;
         var cellIndexMax:uint = this._aCells.length;
         var ind:uint = 0;
         var currentCell:GraphicCell = this._aCells[0];
         if(!currentCell)
         {
            while(!currentCell && cellIndex < cellIndexMax)
            {
               currentCell = this._aCells[cellIndex++];
            }
            cellIndex--;
         }
         while(ind < layer.numChildren && cellIndex < cellIndexMax)
         {
            cellCtr = layer.getChildAt(ind) as CellContainer;
            if(currentCell != null && (cellCtr && currentCell.cellId <= cellCtr.cellId))
            {
               cellRef = aCell[cellIndex];
               gCell = this._aCells[cellIndex];
               gCell.y = cellRef.elevation;
               gCell.visible = cellRef.mov && !cellRef.isDisabled;
               gCell.alpha = alpha;
               layer.addChildAt(gCell,ind);
               currentCell = this._aCells[++cellIndex];
            }
            ind++;
         }
      }
      
      public function updateCell(cellId:uint, enabled:Boolean) : Boolean
      {
         DataMapProvider.getInstance().updateCellMovLov(cellId,enabled);
         if(this._aCells[cellId] != null)
         {
            this._aCells[cellId].visible = enabled;
            return true;
         }
         return false;
      }
      
      public function updateCellElevation(cellId:uint, elevation:int) : void
      {
         if(!this._aCells[cellId].initialElevation)
         {
            this._aCells[cellId].initialElevation = this._aCells[cellId].y;
         }
         this._aCells[cellId].y = this._aCells[cellId].initialElevation - elevation;
      }
      
      public function resetHavenbagCellsVisibility() : void
      {
         var cell:GraphicCell = null;
         for each(cell in this._aCells)
         {
            if(cell && MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[cell.cellId].havenbagCell)
            {
               cell.visible = true;
            }
         }
      }
      
      public function show(b:Boolean, pIsInFight:Boolean = false) : void
      {
         var cell:GraphicCell = null;
         this._bShowGrid = b;
         this._isInFight = pIsInFight;
         var alpha:Number = this._bShowGrid || Atouin.getInstance().options.getOption("alwaysShowGrid") ? Number(1) : Number(0);
         var cellsData:Vector.<CellData> = MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells;
         for(var i:uint = 0; i < this._aCells.length; i++)
         {
            cell = GraphicCell(this._aCells[i]);
            if(cell)
            {
               if(pIsInFight)
               {
                  cell.buttonMode = !cellsData[i].nonWalkableDuringFight;
               }
               else
               {
                  cell.buttonMode = !cellsData[i].nonWalkableDuringRP;
               }
               if(pIsInFight && alpha == 1 && cellsData[i].nonWalkableDuringFight)
               {
                  cell.alpha = 0;
               }
               else
               {
                  cell.alpha = alpha;
               }
               if(cell.numChildren > 1 && cell.alpha == 0)
               {
                  cell.alpha = 0.8;
               }
            }
         }
      }
      
      public function showEveryCellId(b:Boolean) : void
      {
         var cell:GraphicCell = null;
         var tf_id:TextField = null;
         var glow:GlowFilter = null;
         this._showEveryCellId = b;
         for(var i:uint = 0; i < this._aCells.length; i++)
         {
            cell = GraphicCell(this._aCells[i]);
            if(cell)
            {
               if(this._showEveryCellId)
               {
                  if(cell.alpha == 0)
                  {
                     cell.alpha = 0.8;
                  }
                  while(cell.numChildren > 1)
                  {
                     cell.removeChildAt(1);
                  }
                  tf_id = new TextField();
                  tf_id.text = "" + i;
                  tf_id.autoSize = TextFieldAutoSize.CENTER;
                  tf_id.width = 30;
                  tf_id.height = 20;
                  tf_id.x = cell.width / 2 - tf_id.width / 2;
                  tf_id.y = tf_id.height / 2;
                  glow = new GlowFilter(16777215,0.8,8,8,6,2);
                  tf_id.filters = [glow];
                  cell.addChild(tf_id);
               }
               else
               {
                  while(cell.numChildren > 1)
                  {
                     cell.removeChildAt(1);
                  }
                  if(cell.alpha != 0 && cell.alpha != 1)
                  {
                     cell.alpha = 0;
                  }
               }
            }
         }
      }
      
      public function clean() : void
      {
         var i:uint = 0;
         if(this._aCells)
         {
            for(i = 0; i < this._aCells.length; i++)
            {
               if(this._aCells[i])
               {
                  while(this._aCells[i].numChildren > 1)
                  {
                     this._aCells[i].removeChildAt(1);
                  }
                  if(this._aCells[i].parent)
                  {
                     this._aCells[i].parent.removeChild(this._aCells[i]);
                  }
               }
            }
         }
      }
      
      private function init() : void
      {
         var c:GraphicCell = null;
         for(var i:uint = 0; i < AtouinConstants.MAP_CELLS_COUNT; i++)
         {
            c = new GraphicCell(i);
            c.mouseEnabled = false;
            c.mouseChildren = false;
            this._aCellPool[i] = c;
         }
      }
      
      private function overStateChanged(oldValue:Boolean, newValue:Boolean) : void
      {
         if(oldValue == newValue)
         {
            return;
         }
         if(!oldValue && newValue)
         {
            this.registerOver(true);
         }
         else if(oldValue && !newValue)
         {
            this.registerOver(false);
         }
      }
      
      private function registerOver(enabled:Boolean) : void
      {
         for(var i:uint = 0; i < AtouinConstants.MAP_CELLS_COUNT; i++)
         {
            if(this._aCells[i])
            {
               if(enabled)
               {
                  this._aCells[i].addEventListener(MouseEvent.ROLL_OVER,this.mouseOver);
                  this._aCells[i].addEventListener(MouseEvent.ROLL_OUT,this.mouseOut);
               }
               else
               {
                  this._aCells[i].removeEventListener(MouseEvent.ROLL_OVER,this.mouseOver);
                  this._aCells[i].removeEventListener(MouseEvent.ROLL_OUT,this.mouseOut);
               }
            }
         }
      }
      
      private function mouseClick(e:MouseEvent) : void
      {
         var a:Array = null;
         var entity:IEntity = null;
         var msg:CellClickMessage = null;
         var target:Sprite = Sprite(e.target);
         if(!target.parent)
         {
            return;
         }
         var index:int = target.parent.getChildIndex(target);
         var cellId:int = parseInt(target.name);
         var cellCoordinates:Point = CellIdConverter.cellIdToCoord(cellId);
         if(!DataMapProvider.getInstance().pointCanStop(cellCoordinates.x,cellCoordinates.y))
         {
            _log.info("Cannot move to this cell in RP");
            return;
         }
         if(Atouin.getInstance().options.getOption("virtualPlayerJump"))
         {
            a = EntitiesManager.getInstance().entities;
            for each(entity in a)
            {
               if(entity is IMovable)
               {
                  IMovable(entity).jump(MapPoint.fromCellId(cellId));
                  break;
               }
            }
         }
         else
         {
            msg = new CellClickMessage();
            msg.cellContainer = target;
            msg.cellDepth = index;
            msg.cell = MapPoint.fromCoords(cellCoordinates.x,cellCoordinates.y);
            msg.cellId = cellId;
            Atouin.getInstance().handler.process(msg);
         }
      }
      
      private function mouseOver(e:MouseEvent) : void
      {
         var _cellColor:uint = 0;
         var textInfo:* = null;
         var mp:MapPoint = null;
         var cellData:CellData = null;
         var sel:Selection = null;
         var target:Sprite = Sprite(e.target);
         if(!target.parent)
         {
            return;
         }
         var index:int = target.parent.getChildIndex(target);
         var cellId:int = parseInt(target.name);
         var cellCoordinates:Point = CellIdConverter.cellIdToCoord(cellId);
         if(Atouin.getInstance().options.getOption("showCellIdOnOver"))
         {
            _cellColor = 0;
            textInfo = target.name + " (" + cellCoordinates.x + "/" + cellCoordinates.y + ")";
            mp = MapPoint.fromCoords(cellCoordinates.x,cellCoordinates.y);
            textInfo += "\nLigne de vue : " + !DataMapProvider.getInstance().pointLos(mp.x,mp.y);
            textInfo += "\nBlocage éditeur : " + !DataMapProvider.getInstance().pointMov(mp.x,mp.y);
            textInfo += "\nBlocage entitée : " + !DataMapProvider.getInstance().pointMov(mp.x,mp.y,false);
            textInfo += "\nfarmCell : " + DataMapProvider.getInstance().farmCell(mp.x,mp.y);
            textInfo += "\nhavenbagCell : " + DataMapProvider.getInstance().cellByCoordsIsHavenbagCell(mp.x,mp.y);
            cellData = CellData(MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[cellId]);
            textInfo += "\nForcage fleche bas : " + cellData.useBottomArrow;
            textInfo += "\nForcage fleche haut : " + cellData.useTopArrow;
            textInfo += "\nForcage fleche droite : " + cellData.useRightArrow;
            textInfo += "\nForcage fleche gauche : " + cellData.useLeftArrow;
            textInfo += "\nID de zone : " + cellData.moveZone;
            textInfo += "\nHauteur : " + cellData.floor + " px";
            textInfo += "\nSpeed : " + cellData.speed;
            DebugToolTip.getInstance().text = textInfo;
            sel = SelectionManager.getInstance().getSelection("infoOverCell");
            if(!sel)
            {
               sel = new Selection();
               sel.color = new Color(_cellColor);
               sel.renderer = new ZoneDARenderer();
               sel.zone = new Lozenge(SpellShapeEnum.UNKNOWN,0,0,DataMapProvider.getInstance());
               SelectionManager.getInstance().addSelection(sel,"infoOverCell",cellId);
            }
            else
            {
               SelectionManager.getInstance().update("infoOverCell",cellId);
            }
            StageShareManager.stage.addChild(DebugToolTip.getInstance());
         }
         var msg:CellOverMessage = new CellOverMessage();
         msg.cellContainer = target;
         msg.cellDepth = index;
         msg.cell = MapPoint.fromCoords(cellCoordinates.x,cellCoordinates.y);
         msg.cellId = cellId;
         Atouin.getInstance().handler.process(msg);
      }
      
      private function mouseOut(e:MouseEvent) : void
      {
         var target:Sprite = Sprite(e.target);
         if(!target.parent)
         {
            return;
         }
         var index:int = target.parent.getChildIndex(target);
         var cellId:int = parseInt(target.name);
         var cellCoordinates:Point = CellIdConverter.cellIdToCoord(cellId);
         if(Atouin.getInstance().worldContainer.contains(DebugToolTip.getInstance()))
         {
            Atouin.getInstance().worldContainer.removeChild(DebugToolTip.getInstance());
         }
         var msg:CellOutMessage = new CellOutMessage();
         msg.cellContainer = target;
         msg.cellDepth = index;
         msg.cell = MapPoint.fromCoords(cellCoordinates.x,cellCoordinates.y);
         msg.cellId = cellId;
         Atouin.getInstance().handler.process(msg);
      }
      
      private function onPropertyChanged(e:PropertyChangeEvent) : void
      {
         if(e.propertyName == "alwaysShowGrid")
         {
            this.show(e.propertyValue,this._isInFight);
         }
      }
   }
}
