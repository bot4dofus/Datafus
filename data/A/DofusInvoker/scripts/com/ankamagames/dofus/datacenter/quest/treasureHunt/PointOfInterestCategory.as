package com.ankamagames.dofus.datacenter.quest.treasureHunt
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   
   public class PointOfInterestCategory implements IDataCenter
   {
      
      public static const MODULE:String = "PointOfInterestCategory";
      
      public static var idAccessors:IdAccessors = new IdAccessors(getPointOfInterestCategoryById,getPointOfInterestCategories);
       
      
      public var id:uint;
      
      public var actionLabelId:uint;
      
      private var _actionLabel:String;
      
      public function PointOfInterestCategory()
      {
         super();
      }
      
      public static function getPointOfInterestCategoryById(id:int) : PointOfInterestCategory
      {
         return GameData.getObject(MODULE,id) as PointOfInterestCategory;
      }
      
      public static function getPointOfInterestCategories() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function get actionLabel() : String
      {
         if(!this._actionLabel)
         {
            this._actionLabel = I18n.getText(this.actionLabelId);
         }
         return this._actionLabel;
      }
   }
}
