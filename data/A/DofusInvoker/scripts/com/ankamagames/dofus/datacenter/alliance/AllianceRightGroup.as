package com.ankamagames.dofus.datacenter.alliance
{
   import com.ankamagames.dofus.datacenter.social.SocialRightGroup;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class AllianceRightGroup extends SocialRightGroup implements IDataCenter
   {
      
      public static const MODULE:String = "AllianceRightGroups";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AllianceRightGroup));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getAllianceRightGroupById,getAllianceRightGroups);
       
      
      public function AllianceRightGroup()
      {
         super();
      }
      
      public static function getAllianceRightGroupById(id:int) : AllianceRightGroup
      {
         return GameData.getObject(MODULE,id) as AllianceRightGroup;
      }
      
      public static function getAllianceRightGroups() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
