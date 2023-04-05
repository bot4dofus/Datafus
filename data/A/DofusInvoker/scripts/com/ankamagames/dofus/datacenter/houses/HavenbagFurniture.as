package com.ankamagames.dofus.datacenter.houses
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class HavenbagFurniture implements IDataCenter
   {
      
      public static const MODULE:String = "HavenbagFurnitures";
      
      public static var idAccessors:IdAccessors = new IdAccessors(null,getAllFurnitures);
       
      
      public var typeId:int;
      
      public var themeId:int;
      
      public var elementId:int;
      
      public var color:int;
      
      public var skillId:int;
      
      public var layerId:int;
      
      public var blocksMovement:Boolean;
      
      public var isStackable:Boolean;
      
      public var cellsWidth:uint;
      
      public var cellsHeight:uint;
      
      public var order:uint;
      
      public function HavenbagFurniture()
      {
         super();
      }
      
      public static function getFurniture(id:int) : HavenbagFurniture
      {
         return GameData.getObject(MODULE,id) as HavenbagFurniture;
      }
      
      public static function getAllFurnitures() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
