package com.ankamagames.dofus.datacenter.alterations
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class AlterationCategory implements IDataCenter
   {
      
      public static const MODULE:String = "AlterationCategories";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getAlterationCategoryById,getAlterationCategories);
       
      
      public var id:uint;
      
      public var nameId:uint;
      
      public var parentId:uint;
      
      private var _name:String = null;
      
      public function AlterationCategory()
      {
         super();
      }
      
      public static function getAlterationCategoryById(id:int) : AlterationCategory
      {
         return GameData.getObject(MODULE,id) as AlterationCategory;
      }
      
      public static function getAlterationCategories() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get name() : String
      {
         if(this._name === null)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
   }
}
