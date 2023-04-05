package com.ankamagames.dofus.datacenter.communication
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class SmileyCategory implements IDataCenter
   {
      
      public static const MODULE:String = "SmileyCategories";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(SmileyCategory));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getSmileyCategoryById,getSmileyCategories);
       
      
      public var id:int;
      
      public var order:uint;
      
      public var gfxId:String;
      
      public var isFake:Boolean;
      
      public function SmileyCategory()
      {
         super();
      }
      
      public static function getSmileyCategoryById(id:int) : SmileyCategory
      {
         return GameData.getObject(MODULE,id) as SmileyCategory;
      }
      
      public static function getSmileyCategories() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
