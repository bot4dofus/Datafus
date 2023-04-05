package com.ankamagames.dofus.datacenter.appearance
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class TitleCategory implements IDataCenter
   {
      
      public static const MODULE:String = "TitleCategories";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getTitleCategoryById,getTitleCategories);
       
      
      public var id:int;
      
      public var nameId:uint;
      
      private var _name:String;
      
      public function TitleCategory()
      {
         super();
      }
      
      public static function getTitleCategoryById(id:int) : TitleCategory
      {
         return GameData.getObject(MODULE,id) as TitleCategory;
      }
      
      public static function getTitleCategories() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get name() : String
      {
         if(!this._name)
         {
            this._name = I18n.getText(this.nameId);
         }
         return this._name;
      }
   }
}
