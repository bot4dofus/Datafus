package com.ankamagames.dofus.datacenter.guild
{
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class GuildRankNameSuggestion implements IDataCenter
   {
      
      public static const MODULE:String = "GuildRankNameSuggestions";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GuildRank));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getGuildRankNameSuggestionsById,getGuildRankNameSuggestions);
       
      
      public var uiKey:String;
      
      public function GuildRankNameSuggestion()
      {
         super();
      }
      
      public static function getGuildRankNameSuggestionsById(id:int) : GuildRankNameSuggestion
      {
         return GameData.getObject(MODULE,id) as GuildRankNameSuggestion;
      }
      
      public static function getGuildRankNameSuggestions() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
