package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.dofus.logic.game.common.actions.party.ArenaFightAnswerAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.ArenaRegisterAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.ArenaUnregisterAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.DungeonPartyFinderAvailableDungeonsAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.DungeonPartyFinderListenAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.DungeonPartyFinderRegisterAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.TeleportBuddiesAnswerAction;
   import com.ankamagames.dofus.logic.game.common.actions.party.TeleportToBuddyAnswerAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.DisplayContextualMenuAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.EmotePlayRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.NpcGenericActionRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.PlayerFightFriendlyAnswerAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.PlayerFightRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.estate.HouseToSellFilterAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.estate.HouseToSellListRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.estate.PaddockToSellFilterAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.estate.PaddockToSellListRequestAction;
   import com.ankamagames.dofus.misc.utils.DofusApiAction;
   
   public class ApiRolePlayActionList
   {
      
      public static const PlayerFightRequest:DofusApiAction = new DofusApiAction("PlayerFightRequestAction",PlayerFightRequestAction);
      
      public static const PlayerFightFriendlyAnswer:DofusApiAction = new DofusApiAction("PlayerFightFriendlyAnswerAction",PlayerFightFriendlyAnswerAction);
      
      public static const EmotePlayRequest:DofusApiAction = new DofusApiAction("EmotePlayRequestAction",EmotePlayRequestAction);
      
      public static const DisplayContextualMenu:DofusApiAction = new DofusApiAction("DisplayContextualMenuAction",DisplayContextualMenuAction);
      
      public static const NpcGenericActionRequest:DofusApiAction = new DofusApiAction("NpcGenericActionRequestAction",NpcGenericActionRequestAction);
      
      public static const HouseToSellFilter:DofusApiAction = new DofusApiAction("HouseToSellFilterAction",HouseToSellFilterAction);
      
      public static const PaddockToSellFilter:DofusApiAction = new DofusApiAction("PaddockToSellFilterAction",PaddockToSellFilterAction);
      
      public static const HouseToSellListRequest:DofusApiAction = new DofusApiAction("HouseToSellListRequestAction",HouseToSellListRequestAction);
      
      public static const PaddockToSellListRequest:DofusApiAction = new DofusApiAction("PaddockToSellListRequestAction",PaddockToSellListRequestAction);
      
      public static const DungeonPartyFinderAvailableDungeons:DofusApiAction = new DofusApiAction("DungeonPartyFinderAvailableDungeonsAction",DungeonPartyFinderAvailableDungeonsAction);
      
      public static const DungeonPartyFinderListen:DofusApiAction = new DofusApiAction("DungeonPartyFinderListenAction",DungeonPartyFinderListenAction);
      
      public static const DungeonPartyFinderRegister:DofusApiAction = new DofusApiAction("DungeonPartyFinderRegisterAction",DungeonPartyFinderRegisterAction);
      
      public static const ArenaRegister:DofusApiAction = new DofusApiAction("ArenaRegisterAction",ArenaRegisterAction);
      
      public static const ArenaUnregister:DofusApiAction = new DofusApiAction("ArenaUnregisterAction",ArenaUnregisterAction);
      
      public static const ArenaFightAnswer:DofusApiAction = new DofusApiAction("ArenaFightAnswerAction",ArenaFightAnswerAction);
      
      public static const TeleportBuddiesAnswer:DofusApiAction = new DofusApiAction("TeleportBuddiesAnswerAction",TeleportBuddiesAnswerAction);
      
      public static const TeleportToBuddyAnswer:DofusApiAction = new DofusApiAction("TeleportToBuddyAnswerAction",TeleportToBuddyAnswerAction);
       
      
      public function ApiRolePlayActionList()
      {
         super();
      }
   }
}
