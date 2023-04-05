package com.ankamagames.dofus.datacenter.guild
{
   import com.ankamagames.dofus.datacenter.social.SocialRight;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class GuildRight extends SocialRight implements IDataCenter
   {
      
      public static const MODULE:String = "GuildRights";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GuildRight));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getGuildRightById,getGuildRights);
       
      
      public function GuildRight()
      {
         super();
      }
      
      public static function getGuildRightById(id:int) : SocialRight
      {
         return GameData.getObject(MODULE,id) as SocialRight;
      }
      
      public static function getGuildRights() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
