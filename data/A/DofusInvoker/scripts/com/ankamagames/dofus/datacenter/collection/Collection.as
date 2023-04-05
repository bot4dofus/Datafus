package com.ankamagames.dofus.datacenter.collection
{
   import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class Collection implements IDataCenter
   {
      
      public static const MODULE:String = "Collections";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getCollectionById,getCollections);
       
      
      public var typeId:int;
      
      public var name:int;
      
      public var criterion:String;
      
      public var collectables:Vector.<Collectable>;
      
      private var _isRespected:Boolean;
      
      public function Collection()
      {
         super();
      }
      
      public static function getCollectionById(id:int) : Collection
      {
         return GameData.getObject(MODULE,id) as Collection;
      }
      
      public static function getCollections() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get isRespected() : Boolean
      {
         if(!this.criterion || this.criterion && this._isRespected)
         {
            return true;
         }
         var gic:GroupItemCriterion = new GroupItemCriterion(this.criterion);
         this._isRespected = gic.isRespected;
         return this._isRespected;
      }
   }
}
