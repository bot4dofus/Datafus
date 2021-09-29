package Ankama_Social.utils
{
   import Ankama_Social.Api;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFightJoinRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFightLeaveRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.guild.GuildFightTakePlaceRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismFightJoinLeaveRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.prism.PrismFightSwapRequestAction;
   import com.ankamagames.dofus.network.types.game.character.CharacterMinimalPlusLookInformations;
   
   public class JoinFightUtil
   {
      
      private static const TYPE_TAX_COLLECTOR:int = 0;
      
      private static const TYPE_PRISM:int = 1;
       
      
      public function JoinFightUtil()
      {
         super();
      }
      
      public static function join(pFightType:int, pFightId:Number) : void
      {
         if(Api.social.isPlayerDefender(pFightType,Api.player.id(),pFightId))
         {
            leave(pFightType,pFightId);
         }
         else if(pFightType == TYPE_TAX_COLLECTOR)
         {
            Api.system.sendAction(new GuildFightJoinRequestAction([pFightId]));
         }
         else if(pFightType == TYPE_PRISM)
         {
            Api.system.sendAction(new PrismFightJoinLeaveRequestAction([pFightId,true]));
         }
      }
      
      public static function leave(pFightType:int, pFightId:Number) : void
      {
         if(pFightType == TYPE_TAX_COLLECTOR)
         {
            Api.system.sendAction(new GuildFightLeaveRequestAction([pFightId,Api.player.id()]));
         }
         else if(pFightType == TYPE_PRISM)
         {
            Api.system.sendAction(new PrismFightJoinLeaveRequestAction([pFightId,false]));
         }
      }
      
      public static function swapPlaces(pFightType:int, pFightId:Number, pTarget:CharacterMinimalPlusLookInformations) : void
      {
         if(pFightType == TYPE_TAX_COLLECTOR)
         {
            Api.system.sendAction(new GuildFightTakePlaceRequestAction([pFightId,pTarget.id]));
         }
         else if(pFightType == TYPE_PRISM)
         {
            Api.system.sendAction(new PrismFightSwapRequestAction([pFightId,pTarget.id]));
         }
      }
   }
}
