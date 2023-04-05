package com.ankamagames.dofus.datacenter.alignments
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class AlignmentTitle implements IDataCenter
   {
      
      public static const MODULE:String = "AlignmentTitles";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AlignmentTitle));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getAlignmentTitlesById,getAlignmentTitles);
       
      
      public var sideId:int;
      
      public var namesId:Vector.<int>;
      
      public var shortsId:Vector.<int>;
      
      public function AlignmentTitle()
      {
         super();
      }
      
      public static function getAlignmentTitlesById(id:int) : AlignmentTitle
      {
         return GameData.getObject(MODULE,id) as AlignmentTitle;
      }
      
      public static function getAlignmentTitles() : Array
      {
         return GameData.getObjects(MODULE);
      }
      
      public function getNameFromGrade(grade:int) : String
      {
         return I18n.getText(this.namesId[grade]);
      }
   }
}
