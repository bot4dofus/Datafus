package com.ankamagames.dofus.logic.common.managers
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.types.game.rank.RankMinimalInformation;
   import com.ankamagames.jerakine.utils.misc.StringUtils;
   
   public class HyperlinkShowGuildRanks
   {
       
      
      public function HyperlinkShowGuildRanks()
      {
         super();
      }
      
      public static function getLink(rank:RankMinimalInformation, pText:String = null) : String
      {
         var text:String = !!pText ? "::" + pText : "";
         return "{rank," + rank.id + "," + rank.name + text + "}";
      }
      
      public static function showRanks(rankId:uint, rankName:String) : void
      {
         KernelEventsManager.getInstance().processCallback(SocialHookList.OpenGuildRanksAndRights,rankId);
      }
      
      public static function getRankName(rankId:uint, rankName:String) : String
      {
         return StringUtils.unescapeAllowedChar(rankName);
      }
   }
}
