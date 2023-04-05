package com.ankamagames.dofus.internalDatacenter.world
{
   import com.ankamagames.atouin.managers.MapDisplayManager;
   import com.ankamagames.atouin.types.DataMapContainer;
   import com.ankamagames.dofus.datacenter.world.MapPosition;
   import com.ankamagames.dofus.datacenter.world.MapScrollAction;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.positions.WorldPoint;
   import flash.utils.getQualifiedClassName;
   
   public class WorldPointWrapper extends WorldPoint implements IDataCenter
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(WorldPointWrapper));
       
      
      public var outdoorMapId:Number;
      
      private var _outdoorX:int;
      
      private var _outdoorY:int;
      
      private var _topNeighbourId:Number = -1;
      
      private var _bottomNeighbourId:Number = -1;
      
      private var _leftNeighbourId:Number = -1;
      
      private var _rightNeighbourId:Number = -1;
      
      public function WorldPointWrapper(mapid:Number, fixedOutdoor:Boolean = false, outdoorX:int = 0, outdoorY:int = 0)
      {
         var mapInfo:MapPosition = null;
         super();
         mapId = mapid;
         setFromMapId();
         if(fixedOutdoor)
         {
            this._outdoorX = outdoorX;
            this._outdoorY = outdoorY;
         }
         else
         {
            mapInfo = MapPosition.getMapPositionById(mapid);
            if(mapInfo)
            {
               this._outdoorX = mapInfo.posX;
               this._outdoorY = mapInfo.posY;
            }
            else
            {
               this._outdoorX = x;
               this._outdoorY = y;
            }
         }
         var dmc:DataMapContainer = MapDisplayManager.getInstance().getDataMapContainer();
         if(dmc && dmc.dataMap && dmc.dataMap.id == mapid)
         {
            this._topNeighbourId = dmc.dataMap.topNeighbourId;
            this._bottomNeighbourId = dmc.dataMap.bottomNeighbourId;
            this._leftNeighbourId = dmc.dataMap.leftNeighbourId;
            this._rightNeighbourId = dmc.dataMap.rightNeighbourId;
         }
         var mapScrollaction:MapScrollAction = MapScrollAction.getMapScrollActionById(mapid);
         if(mapScrollaction)
         {
            if(mapScrollaction.topExists)
            {
               this._topNeighbourId = mapScrollaction.topMapId;
            }
            if(mapScrollaction.bottomExists)
            {
               this._bottomNeighbourId = mapScrollaction.bottomMapId;
            }
            if(mapScrollaction.leftExists)
            {
               this._leftNeighbourId = mapScrollaction.leftMapId;
            }
            if(mapScrollaction.rightExists)
            {
               this._rightNeighbourId = mapScrollaction.rightMapId;
            }
         }
      }
      
      public function get outdoorX() : int
      {
         return this._outdoorX;
      }
      
      public function get outdoorY() : int
      {
         return this._outdoorY;
      }
      
      public function get topNeighbourId() : Number
      {
         return this._topNeighbourId;
      }
      
      public function get bottomNeighbourId() : Number
      {
         return this._bottomNeighbourId;
      }
      
      public function get leftNeighbourId() : Number
      {
         return this._leftNeighbourId;
      }
      
      public function get rightNeighbourId() : Number
      {
         return this._rightNeighbourId;
      }
      
      public function setOutdoorCoords(x:int, y:int) : void
      {
         this._outdoorX = x;
         this._outdoorY = y;
      }
   }
}
