package com.ankamagames.dofus.datacenter.alliance
{
   import com.ankamagames.dofus.datacenter.social.SocialRight;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class AllianceRight extends SocialRight implements IDataCenter
   {
      
      public static const MODULE:String = "AllianceRights";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(AllianceRight));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getAllianceRightById,getAllianceRights);
       
      
      public function AllianceRight()
      {
         super();
      }
      
      public static function getAllianceRightById(id:int) : SocialRight
      {
         return GameData.getObject(MODULE,id) as SocialRight;
      }
      
      public static function getAllianceRights() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
