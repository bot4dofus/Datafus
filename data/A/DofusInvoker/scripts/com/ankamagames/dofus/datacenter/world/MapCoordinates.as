package com.ankamagames.dofus.datacenter.world
{
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class MapCoordinates implements IDataCenter
   {
      
      public static const MODULE:String = "MapCoordinates";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(MapCoordinates));
      
      private static const UNDEFINED_COORD:int = int.MIN_VALUE;
       
      
      public var compressedCoords:uint;
      
      public var mapIds:Vector.<Number>;
      
      private var _x:int = -2147483648;
      
      private var _y:int = -2147483648;
      
      private var _maps:Vector.<MapPosition>;
      
      public function MapCoordinates()
      {
         super();
      }
      
      public static function getMapCoordinatesByCompressedCoords(compressedCoords:int) : MapCoordinates
      {
         return GameData.getObject(MODULE,compressedCoords) as MapCoordinates;
      }
      
      public static function getMapCoordinatesByCoords(x:int, y:int) : MapCoordinates
      {
         var xCompressed:uint = getCompressedValue(x);
         var yCompressed:uint = getCompressedValue(y);
         return getMapCoordinatesByCompressedCoords((xCompressed << 16) + yCompressed);
      }
      
      private static function getSignedValue(v:int) : int
      {
         var isNegative:* = (v & 32768) > 0;
         var trueValue:* = v & 32767;
         return !!isNegative ? int(0 - trueValue) : int(trueValue);
      }
      
      private static function getCompressedValue(v:int) : uint
      {
         return v < 0 ? uint(32768 | v & 32767) : uint(v & 32767);
      }
      
      public function get x() : int
      {
         if(this._x == UNDEFINED_COORD)
         {
            this._x = getSignedValue((this.compressedCoords & 4294901760) >> 16);
         }
         return this._x;
      }
      
      public function get y() : int
      {
         if(this._y == UNDEFINED_COORD)
         {
            this._y = getSignedValue(this.compressedCoords & 65535);
         }
         return this._y;
      }
      
      public function get maps() : Vector.<MapPosition>
      {
         var i:int = 0;
         if(!this._maps)
         {
            this._maps = new Vector.<MapPosition>(this.mapIds.length,true);
            for(i = 0; i < this.mapIds.length; i++)
            {
               this._maps[i] = MapPosition.getMapPositionById(this.mapIds[i]);
            }
         }
         return this._maps;
      }
   }
}
