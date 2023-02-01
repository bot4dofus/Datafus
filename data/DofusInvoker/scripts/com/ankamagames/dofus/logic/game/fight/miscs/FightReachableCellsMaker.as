package com.ankamagames.dofus.logic.game.fight.miscs
{
   import com.ankamagames.atouin.managers.EntitiesManager;
   import com.ankamagames.dofus.internalDatacenter.stats.EntityStats;
   import com.ankamagames.dofus.internalDatacenter.stats.Stat;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.managers.StatsManager;
   import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
   import com.ankamagames.dofus.network.types.game.context.FightEntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.context.fight.GameFightFighterInformations;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.positions.MapPoint;
   import damageCalculation.tools.StatIds;
   
   public class FightReachableCellsMaker
   {
      
      protected static const _log:Logger = Log.getLogger("FightReachableCellsMaker");
       
      
      private var _cellGrid:Vector.<Vector.<_ReachableCellData>>;
      
      private var _reachableCells:Vector.<uint>;
      
      private var _unreachableCells:Vector.<uint>;
      
      private var _mapPoint:MapPoint;
      
      private var _mp:int;
      
      private var _waitingCells:Vector.<_ReachableCellData>;
      
      private var _watchedCells:Vector.<_ReachableCellData>;
      
      public function FightReachableCellsMaker(infos:GameFightFighterInformations, fromCellId:int = -1, movementPoint:int = -1)
      {
         var i:* = null;
         var x:int = 0;
         var y:int = 0;
         var entities:Array = null;
         var entity:IEntity = null;
         var entityInfos:GameFightFighterInformations = null;
         var node:_ReachableCellData = null;
         var evade:Number = NaN;
         super();
         var entitiesFrame:FightEntitiesFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
         var stats:EntityStats = StatsManager.getInstance().getStats(infos.contextualId);
         var movementPoints:Stat = stats.getStat(StatIds.MOVEMENT_POINTS);
         var movementPointsValue:Number = movementPoints !== null ? Number(movementPoints.totalValue) : Number(0);
         this._reachableCells = new Vector.<uint>();
         this._unreachableCells = new Vector.<uint>();
         if(movementPoint > -1)
         {
            this._mp = movementPoint;
         }
         else
         {
            this._mp = movementPointsValue > 0 ? int(movementPointsValue) : 0;
         }
         if(fromCellId != -1)
         {
            this._mapPoint = MapPoint.fromCellId(fromCellId);
         }
         else
         {
            if(infos.disposition.cellId == -1)
            {
               _log.warn("Failed to initialize FightReachableCellsMaker for entity " + infos.contextualId + " because its cellId is -1");
               return;
            }
            this._mapPoint = MapPoint.fromCellId(infos.disposition.cellId);
         }
         this._cellGrid = new Vector.<Vector.<_ReachableCellData>>(this._mp * 2 + 1);
         for(i in this._cellGrid)
         {
            this._cellGrid[i] = new Vector.<_ReachableCellData>(this._mp * 2 + 1);
         }
         entities = EntitiesManager.getInstance().entities;
         for each(entity in entities)
         {
            if(entity.id != infos.contextualId && entity.position)
            {
               x = entity.position.x - this._mapPoint.x + this._mp;
               y = entity.position.y - this._mapPoint.y + this._mp;
               if(x >= 0 && x < this._mp * 2 + 1 && y >= 0 && y < this._mp * 2 + 1)
               {
                  entityInfos = entitiesFrame.getEntityInfos(entity.id) as GameFightFighterInformations;
                  if(entityInfos)
                  {
                     if(!(entityInfos.disposition is FightEntityDispositionInformations && FightEntityDispositionInformations(entityInfos.disposition).carryingCharacterId == infos.contextualId))
                     {
                        node = new _ReachableCellData(entity.position,x,y,this._cellGrid);
                        node.state = _ReachableCellData.STATE_UNREACHABLE;
                        evade = TackleUtil.getTackleForFighter(entityInfos,infos);
                        if(!node.evadePercent || evade < node.evadePercent)
                        {
                           node.evadePercent = evade;
                        }
                        this._cellGrid[x][y] = node;
                     }
                  }
               }
            }
         }
         this.compute();
      }
      
      public function get reachableCells() : Vector.<uint>
      {
         return this._reachableCells;
      }
      
      public function get unreachableCells() : Vector.<uint>
      {
         return this._unreachableCells;
      }
      
      private function compute() : void
      {
         var tmpCells:Vector.<_ReachableCellData> = null;
         var node:_ReachableCellData = null;
         var mp:int = this._mp;
         var untacledMp:int = this._mp;
         this._waitingCells = new Vector.<_ReachableCellData>();
         this._watchedCells = new Vector.<_ReachableCellData>();
         this.markNode(this._mapPoint.x,this._mapPoint.y,mp,untacledMp);
         while(this._waitingCells.length || this._watchedCells.length)
         {
            if(this._waitingCells.length)
            {
               tmpCells = this._waitingCells;
               this._waitingCells = new Vector.<_ReachableCellData>();
            }
            else
            {
               tmpCells = this._watchedCells;
               this._watchedCells = new Vector.<_ReachableCellData>();
            }
            for each(node in tmpCells)
            {
               mp = int(node.bestRemainingMp * node.evadePercent + 0.49) - 1;
               untacledMp = node.bestRemainingMpNoTackle - 1;
               if(MapPoint.isInMap(node.mapPoint.x - 1,node.mapPoint.y))
               {
                  this.markNode(node.mapPoint.x - 1,node.mapPoint.y,mp,untacledMp);
               }
               if(MapPoint.isInMap(node.mapPoint.x + 1,node.mapPoint.y))
               {
                  this.markNode(node.mapPoint.x + 1,node.mapPoint.y,mp,untacledMp);
               }
               if(MapPoint.isInMap(node.mapPoint.x,node.mapPoint.y - 1))
               {
                  this.markNode(node.mapPoint.x,node.mapPoint.y - 1,mp,untacledMp);
               }
               if(MapPoint.isInMap(node.mapPoint.x,node.mapPoint.y + 1))
               {
                  this.markNode(node.mapPoint.x,node.mapPoint.y + 1,mp,untacledMp);
               }
            }
         }
      }
      
      private function markNode(x:int, y:int, mp:int, untackledMp:int) : void
      {
         var index:int = 0;
         var xTab:int = x - this._mapPoint.x + this._mp;
         var yTab:int = y - this._mapPoint.y + this._mp;
         var node:_ReachableCellData = this._cellGrid[xTab][yTab];
         if(!node)
         {
            node = new _ReachableCellData(MapPoint.fromCoords(x,y),xTab,yTab,this._cellGrid);
            this._cellGrid[xTab][yTab] = node;
            node.findState();
            if(node.state != _ReachableCellData.STATE_UNREACHABLE)
            {
               if(mp >= 0)
               {
                  this._reachableCells.push(node.mapPoint.cellId);
               }
               else
               {
                  this._unreachableCells.push(node.mapPoint.cellId);
               }
            }
         }
         if(node.state == _ReachableCellData.STATE_UNREACHABLE && (this._mapPoint.x != x || this._mapPoint.y != y))
         {
            return;
         }
         if(!node.mpUpdated || mp > node.bestRemainingMp || untackledMp > node.bestRemainingMpNoTackle)
         {
            index = this._unreachableCells.indexOf(node.mapPoint.cellId);
            if(mp >= 0 && index != -1)
            {
               this._reachableCells.push(node.mapPoint.cellId);
               if(index == -1)
               {
                  throw new Error("INTERNAL ERROR : " + node.mapPoint.cellId + " : Can\'t delete cell because it don\'t exist");
               }
               this._unreachableCells.splice(index,1);
            }
            node.updateMp(mp,untackledMp);
            if(untackledMp > 0)
            {
               if(node.state == _ReachableCellData.STATE_REACHABLE || node.mapPoint.cellId == this._mapPoint.cellId && node.state == _ReachableCellData.STATE_UNREACHABLE)
               {
                  this._waitingCells.push(node);
               }
               else if(node.state == _ReachableCellData.STATE_WATCHED)
               {
                  this._watchedCells.push(node);
               }
            }
         }
      }
   }
}

import com.ankamagames.atouin.data.map.CellData;
import com.ankamagames.atouin.managers.MapDisplayManager;
import com.ankamagames.jerakine.types.positions.MapPoint;

class _ReachableCellData
{
   
   public static const STATE_UNDEFINED:int = 0;
   
   public static const STATE_REACHABLE:int = 1;
   
   public static const STATE_UNREACHABLE:int = 2;
   
   public static const STATE_WATCHED:int = 3;
    
   
   public var mapPoint:MapPoint;
   
   public var state:int;
   
   public var evadePercent:Number = 1;
   
   public var bestRemainingMp:int;
   
   public var bestRemainingMpNoTackle:int;
   
   public var mpUpdated:Boolean;
   
   public var gridX:int;
   
   public var gridY:int;
   
   public var cellGrid:Vector.<Vector.<_ReachableCellData>>;
   
   function _ReachableCellData(mapPoint:MapPoint, gridX:int, gridY:int, cellGrid:Vector.<Vector.<_ReachableCellData>>)
   {
      super();
      this.mapPoint = mapPoint;
      this.gridX = gridX;
      this.gridY = gridY;
      this.cellGrid = cellGrid;
   }
   
   public function findState() : void
   {
      var neighbour:_ReachableCellData = null;
      var cellData:CellData = CellData(MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[this.mapPoint.cellId]);
      if(!cellData.mov || cellData.nonWalkableDuringFight)
      {
         this.state = STATE_UNREACHABLE;
      }
      else
      {
         this.evadePercent = 1;
         if(this.gridX > 0)
         {
            neighbour = this.cellGrid[this.gridX - 1][this.gridY];
            if(neighbour && neighbour.state == STATE_UNREACHABLE)
            {
               this.evadePercent *= neighbour.evadePercent;
            }
         }
         if(this.gridX < this.cellGrid.length - 1)
         {
            neighbour = this.cellGrid[this.gridX + 1][this.gridY];
            if(neighbour && neighbour.state == STATE_UNREACHABLE)
            {
               this.evadePercent *= neighbour.evadePercent;
            }
         }
         if(this.gridY > 0)
         {
            neighbour = this.cellGrid[this.gridX][this.gridY - 1];
            if(neighbour && neighbour.state == STATE_UNREACHABLE)
            {
               this.evadePercent *= neighbour.evadePercent;
            }
         }
         if(this.gridY < this.cellGrid[0].length - 1)
         {
            neighbour = this.cellGrid[this.gridX][this.gridY + 1];
            if(neighbour && neighbour.state == STATE_UNREACHABLE)
            {
               this.evadePercent *= neighbour.evadePercent;
            }
         }
         this.state = this.evadePercent == 1 ? int(STATE_REACHABLE) : int(STATE_WATCHED);
      }
   }
   
   public function updateMp(bestMp:int, bestUntackledMp:int) : void
   {
      this.mpUpdated = true;
      if(bestMp > this.bestRemainingMp)
      {
         this.bestRemainingMp = bestMp;
      }
      if(bestUntackledMp > this.bestRemainingMpNoTackle)
      {
         this.bestRemainingMpNoTackle = bestUntackledMp;
      }
   }
   
   public function toString() : String
   {
      return "Node " + this.mapPoint.cellId;
   }
}
