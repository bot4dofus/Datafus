package com.ankamagames.dofus.datacenter.guild
{
   import com.ankamagames.dofus.datacenter.social.SocialRightGroup;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class GuildRightGroup extends SocialRightGroup implements IDataCenter
   {
      
      public static const MODULE:String = "GuildRightGroups";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GuildRightGroup));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getGuildRightGroupById,getGuildRightGroups);
       
      
      public function GuildRightGroup()
      {
         super();
      }
      
      public static function getGuildRightGroupById(id:int) : SocialRightGroup
      {
         return GameData.getObject(MODULE,id) as SocialRightGroup;
      }
      
      public static function getGuildRightGroups() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
