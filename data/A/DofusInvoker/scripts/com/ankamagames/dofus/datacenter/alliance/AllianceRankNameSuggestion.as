package com.ankamagames.dofus.datacenter.alliance
{
   import com.ankamagames.dofus.datacenter.guild.GuildRank;
   import com.ankamagames.dofus.types.IdAccessors;
   import com.ankamagames.jerakine.data.GameData;
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import flash.utils.getQualifiedClassName;
   
   public class AllianceRankNameSuggestion implements IDataCenter
   {
      
      public static const MODULE:String = "AllianceRankNameSuggestions";
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(GuildRank));
      
      public static var idAccessors:IdAccessors = new IdAccessors(getAllianceRankNameSuggestionsById,getAllianceRankNameSuggestions);
       
      
      public var uiKey:String;
      
      public function AllianceRankNameSuggestion()
      {
         super();
      }
      
      public static function getAllianceRankNameSuggestionsById(id:int) : AllianceRankNameSuggestion
      {
         return GameData.getObject(MODULE,id) as AllianceRankNameSuggestion;
      }
      
      public static function getAllianceRankNameSuggestions() : Array
      {
         return GameData.getObjects(MODULE);
      }
   }
}
