package com.ankamagames.dofus.datacenter.guild
{
   import com.ankamagames.dofus.datacenter.social.SocialTagsType;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class GuildTagsType extends SocialTagsType implements IDataCenter
   {
      
      protected static const MODULE:String = "GuildTagsTypes";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GuildTag));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getGuildTagsTypeById,getGuildTagsTypes);
       
      
      public function GuildTagsType()
      {
         super();
      }
      
      public static function getGuildTagsTypeById(id:int) : GuildTagsType
      {
         return GameData.getObject(MODULE,id) as GuildTagsType;
      }
      
      public static function getGuildTagsTypes() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
