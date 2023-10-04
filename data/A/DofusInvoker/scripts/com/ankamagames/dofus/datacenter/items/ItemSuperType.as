package com.ankamagames.dofus.datacenter.items
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class ItemSuperType implements IDataCenter
   {
      
      public static const MODULE:String = "ItemSuperTypes";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ItemSuperType));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getItemSuperTypeById,getItemSuperTypes);
       
      
      public var id:int;
      
      public var possiblePositions:Vector.<int>;
      
      public function ItemSuperType()
      {
         super();
      }
      
      public static function getItemSuperTypeById(id:uint) : ItemSuperType
      {
         return GameData.getObject(MODULE,id) as ItemSuperType;
      }
      
      public static function getItemSuperTypes() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
