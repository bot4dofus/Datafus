package com.ankamagames.dofus.datacenter.alliance
{
   import com.ankamagames.dofus.datacenter.social.SocialTagsType;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class AllianceTagsType extends SocialTagsType implements IDataCenter
   {
      
      protected static const MODULE:String = "AllianceTagsTypes";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AllianceTag));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getAllianceTagsTypeById,getAllianceTagsTypes);
       
      
      public function AllianceTagsType()
      {
         super();
      }
      
      public static function getAllianceTagsTypeById(id:int) : AllianceTagsType
      {
         return GameData.getObject(MODULE,id) as AllianceTagsType;
      }
      
      public static function getAllianceTagsTypes() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
