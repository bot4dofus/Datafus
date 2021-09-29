package com.ankamagames.atouin.utils
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.data.elements.Elements;
   import com.ankamagames.atouin.data.elements.GraphicalElementData;
   import com.ankamagames.atouin.data.elements.subtypes.NormalGraphicalElementData;
   import com.ankamagames.atouin.data.map.Cell;
   import com.ankamagames.atouin.data.map.Layer;
   import com.ankamagames.atouin.data.map.Map;
   import com.ankamagames.atouin.data.map.elements.BasicElement;
   import com.ankamagames.atouin.data.map.elements.GraphicalElement;
   import com.ankamagames.atouin.enums.ElementTypesEnum;
   import com.ankamagames.atouin.types.Frustum;
   import com.ankamagames.atouin.types.miscs.PartialDataMap;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.positions.WorldPoint;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   
   public class VisibleCellDetection
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(VisibleCellDetection));
       
      
      public function VisibleCellDetection()
      {
         super();
      }
      
      public static function detectCell(visible:Boolean, map:Map, pMap:WorldPoint, frustum:Frustum, currentMapPoint:WorldPoint) : PartialDataMap
      {
         var p:Point = null;
         var alt:int = 0;
         var width:int = 0;
         var i:uint = 0;
         var left:int = 0;
         var elementData:GraphicalElementData = null;
         var bottom:int = 0;
         var bottomTmp:int = 0;
         var layer:Layer = null;
         var s:* = null;
         var cell:Cell = null;
         var element:BasicElement = null;
         var ged:NormalGraphicalElementData = null;
         var j:uint = 0;
         if(currentMapPoint == null)
         {
            _log.error("Cannot detect visible cells with no current map point.");
            return null;
         }
         var pdm:PartialDataMap = new PartialDataMap();
         var ox:int = (pMap.x - currentMapPoint.x) * AtouinConstants.CELL_WIDTH * AtouinConstants.MAP_WIDTH;
         var oy:int = (pMap.y - currentMapPoint.y) * AtouinConstants.CELL_HEIGHT * AtouinConstants.MAP_HEIGHT;
         var rv:Rectangle = new Rectangle(-frustum.x / frustum.scale,-frustum.y / frustum.scale,StageShareManager.startHeight / frustum.scale,StageShareManager.stage.stageHeight / frustum.scale);
         var rcv:Rectangle = new Rectangle();
         var aCell:Array = new Array();
         var aGfx:Array = new Array();
         var spDebug:Sprite = Sprite(Atouin.getInstance().worldContainer.parent).addChild(new Sprite()) as Sprite;
         spDebug.graphics.beginFill(0,0);
         spDebug.graphics.lineStyle(1,16711680);
         var ele:Elements = Elements.getInstance();
         for each(layer in map.layers)
         {
            for each(cell in layer.cells)
            {
               alt = 0;
               width = 0;
               left = 100000;
               bottom = 0;
               aGfx = new Array();
               for each(element in cell.elements)
               {
                  if(element.elementType == ElementTypesEnum.GRAPHICAL)
                  {
                     elementData = ele.getElementData(GraphicalElement(element).elementId);
                     bottomTmp = GraphicalElement(element).altitude * AtouinConstants.ALTITUDE_PIXEL_UNIT;
                     bottom = bottomTmp < bottom ? int(bottomTmp) : int(bottom);
                     if(elementData && elementData is NormalGraphicalElementData)
                     {
                        ged = elementData as NormalGraphicalElementData;
                        if(-ged.origin.x + AtouinConstants.CELL_WIDTH < left)
                        {
                           left = -ged.origin.x + AtouinConstants.CELL_WIDTH;
                        }
                        if(ged.size.x > width)
                        {
                           width = ged.size.x;
                        }
                        alt += ged.origin.y + ged.size.y;
                        aGfx.push(ged.gfxId);
                     }
                     else
                     {
                        alt += Math.abs(bottomTmp);
                     }
                  }
               }
               if(!alt)
               {
                  alt = AtouinConstants.CELL_HEIGHT;
               }
               if(left == 100000)
               {
                  left = 0;
               }
               if(width < AtouinConstants.CELL_WIDTH)
               {
                  width = AtouinConstants.CELL_WIDTH;
               }
               p = Cell.cellPixelCoords(cell.cellId);
               rcv.left = p.x + ox + left - AtouinConstants.CELL_HALF_WIDTH;
               rcv.top = p.y + oy - bottom - alt;
               rcv.width = width;
               rcv.height = alt + AtouinConstants.CELL_HEIGHT * 2;
               if(!aCell[cell.cellId])
               {
                  aCell[cell.cellId] = {
                     "r":rcv.clone(),
                     "gfx":aGfx
                  };
               }
               else
               {
                  aCell[cell.cellId].r = aCell[cell.cellId].r.union(rcv);
                  aCell[cell.cellId].gfx = aCell[cell.cellId].gfx.concat(aGfx);
               }
            }
         }
         aGfx = new Array();
         for(i = 0; i < aCell.length; i++)
         {
            if(aCell[i])
            {
               rcv = aCell[i].r;
               if(rcv && rcv.intersects(rv) == visible)
               {
                  pdm.cell[i] = true;
                  for(j = 0; j < aCell[i].gfx.length; j++)
                  {
                     aGfx[aCell[i].gfx[j]] = true;
                  }
               }
            }
         }
         for(s in aGfx)
         {
            pdm.gfx.push(s);
         }
         return pdm;
      }
   }
}
