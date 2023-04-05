package com.ankamagames.dofus.modules.utils.pathfinding.world
{
   public class Vertex
   {
       
      
      private var _mapId:Number;
      
      private var _zoneId:int;
      
      private var _uid:Number;
      
      public function Vertex(mapId:Number, zoneId:int, vertexUid:Number)
      {
         super();
         this._mapId = mapId;
         this._zoneId = zoneId;
         this._uid = vertexUid;
      }
      
      public function get mapId() : Number
      {
         return this._mapId;
      }
      
      public function get zoneId() : int
      {
         return this._zoneId;
      }
      
      public function get UID() : Number
      {
         return this._uid;
      }
      
      public function toString() : String
      {
         return "Vertex{_mapId=" + String(this._mapId) + ",_zoneId=" + String(this._zoneId) + "}";
      }
   }
}
