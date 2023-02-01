package com.ankamagames.dofus.logic.game.fight.managers
{
   import com.ankamagames.atouin.Atouin;
   import com.ankamagames.atouin.AtouinConstants;
   import com.ankamagames.atouin.enums.PlacementStrataEnums;
   import com.ankamagames.atouin.managers.SelectionManager;
   import com.ankamagames.atouin.renderers.CellLinkRenderer;
   import com.ankamagames.atouin.types.Selection;
   import com.ankamagames.dofus.logic.game.fight.types.MarkInstance;
   import com.ankamagames.dofus.types.entities.Glyph;
   import com.ankamagames.dofus.types.enums.PortalAnimationEnum;
   import com.ankamagames.jerakine.interfaces.IDestroyable;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import com.ankamagames.jerakine.types.zones.Custom;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import tools.enumeration.GameActionMarkTypeEnum;
   
   public class LinkedCellsManager implements IDestroyable
   {
      
      private static var _log:Logger = Log.getLogger(getQualifiedClassName(LinkedCellsManager));
      
      private static var _self:LinkedCellsManager;
      
      private static const SAME:int = 0;
      
      private static const OPPOSITE:int = 1;
      
      private static const TRIGONOMETRIC:int = 2;
      
      private static const COUNTER_TRIGONOMETRIC:int = 3;
       
      
      private var _selections:Dictionary;
      
      private var _portalExitGlyph:Glyph;
      
      public function LinkedCellsManager()
      {
         super();
         if(_self != null)
         {
            throw new SingletonError("LinkedCellsManager is a singleton and should not be instanciated directly.");
         }
         this._selections = new Dictionary(true);
      }
      
      public static function getInstance() : LinkedCellsManager
      {
         if(_self == null)
         {
            _self = new LinkedCellsManager();
         }
         return _self;
      }
      
      public function getLinks(startPoint:MapPoint, checkPoints:Vector.<MapPoint>) : Vector.<uint>
      {
         var next:MapPoint = null;
         var index:int = 0;
         if(!checkPoints || !checkPoints.length || checkPoints.length == 1 && startPoint.cellId == checkPoints[0].cellId)
         {
            return new <uint>[startPoint.cellId];
         }
         var pointsList:Vector.<MapPoint> = new Vector.<MapPoint>();
         for(var i:int = 0; i < checkPoints.length; i++)
         {
            if(checkPoints[i].cellId != startPoint.cellId)
            {
               pointsList.push(checkPoints[i]);
            }
         }
         var res:Vector.<uint> = new Vector.<uint>();
         var current:MapPoint = startPoint;
         var maxTry:uint = pointsList.length + 1;
         while(pointsList.length || maxTry > 0)
         {
            maxTry--;
            res.push(current.cellId);
            index = pointsList.indexOf(current);
            if(index != -1)
            {
               pointsList.splice(index,1);
            }
            next = this.getClosestPortal(current,pointsList);
            if(next == null)
            {
               break;
            }
            current = next;
         }
         if(res.length < 2)
         {
            return new <uint>[startPoint.cellId];
         }
         return res;
      }
      
      public function drawLinks(selectionName:String, orderedCellIds:Vector.<uint>, thickness:Number, color:uint, alpha:Number) : void
      {
         var s:Selection = null;
         if(orderedCellIds && orderedCellIds.length > 1)
         {
            s = new Selection();
            s.cells = orderedCellIds;
            s.color = new Color(color);
            s.zone = new Custom(orderedCellIds);
            s.renderer = new CellLinkRenderer(thickness,alpha);
            SelectionManager.getInstance().addSelection(s,selectionName,orderedCellIds[0]);
            this._selections[selectionName] = s;
         }
         else
         {
            _log.error("Not enough cells to draw links between them...");
         }
      }
      
      public function drawPortalLinks(orderedCellIds:Vector.<uint>) : void
      {
         var exitCellId:int = 0;
         var s:Selection = null;
         var mark:MarkInstance = null;
         if(orderedCellIds && orderedCellIds.length)
         {
            if(this._selections["eliaPortals"])
            {
               this.clearLinks("eliaPortals");
            }
            exitCellId = orderedCellIds[orderedCellIds.length - 1];
            s = new Selection();
            s.cells = orderedCellIds;
            s.color = new Color(251623);
            s.zone = new Custom(orderedCellIds);
            s.renderer = new CellLinkRenderer(10,0.5,true,!!Atouin.getInstance().options.getOption("transparentOverlayMode") ? uint(PlacementStrataEnums.STRATA_NO_Z_ORDER) : uint(PlacementStrataEnums.STRATA_LINK));
            SelectionManager.getInstance().addSelection(s,"eliaPortals",orderedCellIds[0]);
            this._selections["eliaPortals"] = s;
            mark = MarkedCellsManager.getInstance().getMarkAtCellId(exitCellId,GameActionMarkTypeEnum.PORTAL);
            if(!mark)
            {
               return;
            }
            this._portalExitGlyph = MarkedCellsManager.getInstance().getGlyph(mark.markId);
            if(!this._portalExitGlyph)
            {
               return;
            }
            this._portalExitGlyph.setAnimation(PortalAnimationEnum.STATE_EXIT);
         }
         else
         {
            _log.error("Not enough cells to draw links between them...");
         }
      }
      
      public function clearLinks(selectionName:String = "") : void
      {
         var s:Selection = null;
         var hasClearedLinks:Boolean = false;
         if(!selectionName)
         {
            for(selectionName in this._selections)
            {
               hasClearedLinks = true;
               this._selections[selectionName].remove();
               delete this._selections[selectionName];
            }
         }
         else
         {
            s = SelectionManager.getInstance().getSelection(selectionName);
            if(s)
            {
               hasClearedLinks = true;
               s.remove();
            }
            if(this._selections[selectionName])
            {
               delete this._selections[selectionName];
            }
         }
         if(hasClearedLinks && this._portalExitGlyph)
         {
            if(this._portalExitGlyph.getAnimation() != PortalAnimationEnum.STATE_DISABLED)
            {
               this._portalExitGlyph.setAnimation(PortalAnimationEnum.STATE_NORMAL);
            }
         }
      }
      
      public function destroy() : void
      {
         if(_self)
         {
            this.clearLinks();
            this._selections = null;
            _self = null;
            this._portalExitGlyph = null;
         }
      }
      
      private function getClosestPortal(refMapPoint:MapPoint, portals:Vector.<MapPoint>) : MapPoint
      {
         var portal:MapPoint = null;
         var dist:int = 0;
         var closests:Vector.<MapPoint> = new Vector.<MapPoint>();
         var bestDist:int = AtouinConstants.PSEUDO_INFINITE;
         for each(portal in portals)
         {
            dist = refMapPoint.distanceToCell(portal);
            if(dist < bestDist)
            {
               closests.length = 0;
               closests.push(portal);
               bestDist = dist;
            }
            else if(dist == bestDist)
            {
               closests.push(portal);
            }
         }
         if(!closests.length)
         {
            return null;
         }
         if(closests.length == 1)
         {
            return closests[0];
         }
         return this.getBestNextPortal(refMapPoint,closests);
      }
      
      private function getBestNextPortal(refCell:MapPoint, closests:Vector.<MapPoint>) : MapPoint
      {
         var refCoord:Point = null;
         var nudge:Point = null;
         if(closests.length < 2)
         {
            throw new ArgumentError("closests should have a size of 2.");
         }
         refCoord = refCell.coordinates;
         nudge = new Point(refCoord.x,refCoord.y + 1);
         closests.sort(function(o1:MapPoint, o2:MapPoint):int
         {
            var res:Number = getPositiveOrientedAngle(refCoord,nudge,new Point(o1.x,o1.y)) - getPositiveOrientedAngle(refCoord,nudge,new Point(o2.x,o2.y));
            return res > 0 ? 1 : (res < 0 ? -1 : 0);
         });
         var res:MapPoint = this.getBestPortalWhenRefIsNotInsideClosests(refCell,closests);
         if(res != null)
         {
            return res;
         }
         return closests[0];
      }
      
      private function getBestPortalWhenRefIsNotInsideClosests(refCell:MapPoint, sortedClosests:Vector.<MapPoint>) : MapPoint
      {
         var portal:MapPoint = null;
         if(sortedClosests.length < 2)
         {
            return null;
         }
         var prev:MapPoint = sortedClosests[sortedClosests.length - 1];
         var _loc5_:int = 0;
         var _loc6_:* = sortedClosests;
         while(true)
         {
            loop0:
            for each(portal in _loc6_)
            {
               switch(this.compareAngles(refCell.coordinates,prev.coordinates,portal.coordinates))
               {
                  case OPPOSITE:
                     if(sortedClosests.length <= 2)
                     {
                        return null;
                     }
                     break loop0;
                  case COUNTER_TRIGONOMETRIC:
                     break loop0;
               }
               prev = portal;
            }
            return null;
         }
         return prev;
      }
      
      private function getPositiveOrientedAngle(refCell:Point, cellA:Point, cellB:Point) : Number
      {
         switch(this.compareAngles(refCell,cellA,cellB))
         {
            case SAME:
               return 0;
            case OPPOSITE:
               return Math.PI;
            case TRIGONOMETRIC:
               return this.getAngle(refCell,cellA,cellB);
            case COUNTER_TRIGONOMETRIC:
               return 2 * Math.PI - this.getAngle(refCell,cellA,cellB);
            default:
               return 0;
         }
      }
      
      private function compareAngles(ref:Point, start:Point, end:Point) : int
      {
         var aVec:Point = this.vector(ref,start);
         var bVec:Point = this.vector(ref,end);
         var det:int = this.getDeterminant(aVec,bVec);
         if(det != 0)
         {
            return det > 0 ? int(TRIGONOMETRIC) : int(COUNTER_TRIGONOMETRIC);
         }
         return aVec.x >= 0 == bVec.x >= 0 && aVec.y >= 0 == bVec.y >= 0 ? int(SAME) : int(OPPOSITE);
      }
      
      private function getAngle(coordRef:Point, coordA:Point, coordB:Point) : Number
      {
         var a:Number = this.getComplexDistance(coordA,coordB);
         var b:Number = this.getComplexDistance(coordRef,coordA);
         var c:Number = this.getComplexDistance(coordRef,coordB);
         return Math.acos((b * b + c * c - a * a) / (2 * b * c));
      }
      
      private function getComplexDistance(ref_start:Point, ref_end:Point) : Number
      {
         return Math.sqrt(Math.pow(ref_start.x - ref_end.x,2) + Math.pow(ref_start.y - ref_end.y,2));
      }
      
      private function getDeterminant(aVec:Point, bVec:Point) : int
      {
         return aVec.x * bVec.y - aVec.y * bVec.x;
      }
      
      private function vector(start:Point, end:Point) : Point
      {
         return new Point(end.x - start.x,end.y - start.y);
      }
   }
}
