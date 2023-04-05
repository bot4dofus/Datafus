package com.ankamagames.dofus.datacenter.world
{
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class Waypoint implements IDataCenter
   {
      
      public static const MODULE:String = "Waypoints";
       
      
      public var id:uint;
      
      public var mapId:Number;
      
      public var subAreaId:uint;
      
      public var activated:Boolean;
      
      public function Waypoint()
      {
         super();
      }
      
      public static function getAllWaypoints() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
