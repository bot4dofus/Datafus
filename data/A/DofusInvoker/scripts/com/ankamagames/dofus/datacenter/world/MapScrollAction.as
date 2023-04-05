package com.ankamagames.dofus.datacenter.world
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class MapScrollAction implements IDataCenter
   {
      
      public static const MODULE:String = "MapScrollActions";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getMapScrollActionById,getMapScrollActions);
       
      
      public var id:Number;
      
      public var rightExists:Boolean;
      
      public var bottomExists:Boolean;
      
      public var leftExists:Boolean;
      
      public var topExists:Boolean;
      
      public var rightMapId:Number;
      
      public var bottomMapId:Number;
      
      public var leftMapId:Number;
      
      public var topMapId:Number;
      
      public function MapScrollAction()
      {
         super();
      }
      
      public static function getMapScrollActionById(id:Number) : MapScrollAction
      {
         return GameData.getObject(MODULE,id) as MapScrollAction;
      }
      
      public static function getMapScrollActions() : Array
      {
         return GameData.getObjects(MODULE) as Array;
      }
   }
}
