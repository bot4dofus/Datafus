package com.ankamagames.dofus.misc.lists
{
   import com.ankamagames.berilia.types.data.Hook;
   
   public class TriggerHookList
   {
      
      public static const NotificationList:String = "NotificationList";
      
      public static const PlayerMove:String = "PlayerMove";
      
      public static const PlayerFightMove:String = "PlayerFightMove";
      
      public static const FightSpellCast:String = "FightSpellCast";
      
      public static const FightResultVictory:String = "FightResultVictory";
      
      public static const MapWithMonsters:String = "MapWithMonsters";
      
      public static const PlayerNewSpell:String = "PlayerNewSpell";
      
      public static const CreaturesMode:String = "CreaturesMode";
      
      public static const PlayerIsDead:String = "PlayerIsDead";
      
      public static const OpenSmileys:String = "OpenSmileys";
      
      public static const OpenTeamSearch:String = "OpenTeamSearch";
      
      public static const OpenArena:String = "OpenArena";
      
      public static const OpenGrimoireProgressTab:String = "OpenGrimoireProgressTab";
       
      
      public function TriggerHookList()
      {
         super();
      }
      
      public static function initHooks() : void
      {
         Hook.createHook(NotificationList);
         Hook.createHook(PlayerMove);
         Hook.createHook(PlayerFightMove);
         Hook.createHook(FightSpellCast);
         Hook.createHook(FightResultVictory);
         Hook.createHook(MapWithMonsters);
         Hook.createHook(PlayerNewSpell);
         Hook.createHook(CreaturesMode);
         Hook.createHook(PlayerIsDead);
         Hook.createHook(OpenSmileys);
         Hook.createHook(OpenTeamSearch);
         Hook.createHook(OpenArena);
         Hook.createHook(OpenGrimoireProgressTab);
      }
   }
}
