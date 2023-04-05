package com.ankamagames.dofus.misc.utils
{
   import flash.utils.Dictionary;
   
   public class GameID
   {
      
      public static const DOFUS:int = 1;
      
      public static const DOFUS_ARENA:int = 2;
      
      public static const WAKFU:int = 3;
      
      public static const DOFUS_POCKET:int = 4;
      
      public static const WAKFU_THE_GUARDIANS:int = 5;
      
      public static const DIAKFU:int = 6;
      
      public static const WAKFU_THE_GUARDIANS_2:int = 7;
      
      public static const BOUFBOWL:int = 8;
      
      public static const KROSMASTER:int = 9;
      
      public static const KROSMASTER_ARENA:int = 10;
      
      public static const TACTILE_WARS:int = 11;
      
      public static const FLYN:int = 12;
      
      public static const KROSMASTER_3D:int = 13;
      
      public static const KWAAN:int = 14;
      
      public static const ABRACA:int = 15;
      
      public static const KING_TONGUE:int = 16;
      
      public static const KROSMAGA:int = 17;
      
      public static const DOFUS_TOUCH:int = 18;
      
      public static const DRAKERZ:int = 19;
      
      public static const DOFUS_PETS:int = 20;
      
      public static const DOFUS_3:int = 21;
      
      public static const WAVEN:int = 22;
      
      public static const CHAT:int = 99;
      
      public static const UPDATER:int = 100;
      
      public static const DOFUS_FRIGOST_BETA:int = 101;
      
      public static const ZAAP:int = 102;
      
      public static const ANKAMA_WEBSITE:int = 103;
      
      public static const FORUM:int = 999;
      
      public static const DOFUS_2_BETA:int = 1001;
      
      public static const DOFUS_ARENA_BETA:int = 1002;
      
      public static const DOFUS_ARENA_BETA_2:int = 1004;
      
      public static const DOFUS_2_FRIGOST_BETA:int = 1005;
      
      public static const DOFUS_2_FRIGOST_EP2_BETA:int = 1006;
      
      public static const WAKFU_TEST:int = 3001;
      
      public static const WAKFU_HEROES:int = 3002;
      
      public static const KROSMASTER_ARENA_BETA:int = 10001;
      
      public static const TACTILE_WARS_TEST:int = 11001;
      
      public static const KROSMASTER_3D_BETA:int = 13001;
      
      private static var _names:Dictionary = new Dictionary();
      
      {
         _names[DOFUS] = "Dofus";
         _names[DOFUS_ARENA] = "Dofus Arena";
         _names[WAKFU] = "Wakfu";
         _names[DOFUS_POCKET] = "Dofus Pocket";
         _names[WAKFU_THE_GUARDIANS] = "Wakfu - The Guardians";
         _names[DIAKFU] = "Diakfu";
         _names[WAKFU_THE_GUARDIANS_2] = "Wakfu - The Guardians 2";
         _names[BOUFBOWL] = "Boufbowl";
         _names[KROSMASTER] = "Krosmaster";
         _names[KROSMASTER_ARENA] = "Krosmaster Arena";
         _names[TACTILE_WARS] = "Tactile Wars";
         _names[FLYN] = "Fly\'N";
         _names[KROSMASTER_3D] = "Krosmaster 3D";
         _names[KWAAN] = "Kwaan";
         _names[ABRACA] = "Abraca";
         _names[KING_TONGUE] = "King Tongue";
         _names[KROSMAGA] = "Krosmaga";
         _names[DOFUS_TOUCH] = "Dofus Touch";
         _names[DRAKERZ] = "Drakerz";
         _names[DOFUS_PETS] = "Dofus Pets";
         _names[DOFUS_3] = "Dofus 3";
         _names[CHAT] = "Chat";
         _names[UPDATER] = "Updater";
         _names[DOFUS_FRIGOST_BETA] = "Dofus Frigost - Beta";
         _names[ZAAP] = "Ankama Launcher";
         _names[ANKAMA_WEBSITE] = "Website Ankama";
         _names[FORUM] = "Forum";
         _names[DOFUS_2_BETA] = "Dofus 2 - Beta";
         _names[DOFUS_ARENA_BETA] = "Dofus Arena - Beta";
         _names[DOFUS_ARENA_BETA_2] = "Dofus Arena - Beta 2";
         _names[DOFUS_2_FRIGOST_BETA] = "Dofus 2 Frigost - Beta";
         _names[DOFUS_2_FRIGOST_EP2_BETA] = "Dofus 2 Frigost Ep.2 - Beta";
         _names[WAKFU_TEST] = "Wakfu - Test";
         _names[WAKFU_HEROES] = "Wakfu Heroes";
         _names[KROSMASTER_ARENA_BETA] = "Krosmaster Arena - Beta";
         _names[TACTILE_WARS_TEST] = "Tactile Wars - Test";
         _names[KROSMASTER_3D_BETA] = "Krosmaster 3D - Beta";
      }
      
      public function GameID()
      {
         super();
      }
      
      public static function get current() : int
      {
         return DOFUS;
      }
      
      public static function getName(value:int) : String
      {
         return _names[value];
      }
   }
}
