package com.ankamagames.dofus
{
   import Ankama_Admin.Admin;
   import Ankama_Cartography.Cartography;
   import Ankama_CharacterSheet.CharacterSheet;
   import Ankama_Common.Common;
   import Ankama_Config.Config;
   import Ankama_Connection.Connection;
   import Ankama_Console.Console;
   import Ankama_ContextMenu.ContextMenu;
   import Ankama_Document.Document;
   import Ankama_Dungeon.Dungeon;
   import Ankama_Exchange.Exchange;
   import Ankama_Fight.Fight;
   import Ankama_GameUiCore.GameUiCore;
   import Ankama_Grimoire.Grimoire;
   import Ankama_House.House;
   import Ankama_Job.Job;
   import Ankama_Mount.Mount;
   import Ankama_Party.Party;
   import Ankama_Roleplay.Roleplay;
   import Ankama_Social.Social;
   import Ankama_Storage.Storage;
   import Ankama_Taxi.Taxi;
   import Ankama_Tooltips.Tooltips;
   import Ankama_TradeCenter.TradeCenter;
   import Ankama_Tutorial.Tutorial;
   import Ankama_Web.Web;
   import flash.utils.Dictionary;
   
   public class Modules
   {
      
      private static var _scripts:Dictionary;
       
      
      public function Modules()
      {
         super();
      }
      
      public static function get scripts() : Dictionary
      {
         if(!_scripts)
         {
            _scripts = new Dictionary();
            _scripts["Ankama_Admin"] = Admin;
            _scripts["Ankama_Cartography"] = Cartography;
            _scripts["Ankama_CharacterSheet"] = CharacterSheet;
            _scripts["Ankama_Common"] = Common;
            _scripts["Ankama_Config"] = Config;
            _scripts["Ankama_Connection"] = Connection;
            _scripts["Ankama_Console"] = Console;
            _scripts["Ankama_ContextMenu"] = ContextMenu;
            _scripts["Ankama_Document"] = Document;
            _scripts["Ankama_Dungeon"] = Dungeon;
            _scripts["Ankama_Exchange"] = Exchange;
            _scripts["Ankama_Fight"] = Fight;
            _scripts["Ankama_GameUiCore"] = GameUiCore;
            _scripts["Ankama_Grimoire"] = Grimoire;
            _scripts["Ankama_House"] = House;
            _scripts["Ankama_Job"] = Job;
            _scripts["Ankama_Mount"] = Mount;
            _scripts["Ankama_Party"] = Party;
            _scripts["Ankama_Roleplay"] = Roleplay;
            _scripts["Ankama_Social"] = Social;
            _scripts["Ankama_Storage"] = Storage;
            _scripts["Ankama_Taxi"] = Taxi;
            _scripts["Ankama_Tooltips"] = Tooltips;
            _scripts["Ankama_TradeCenter"] = TradeCenter;
            _scripts["Ankama_Tutorial"] = Tutorial;
            _scripts["Ankama_Web"] = Web;
         }
         return _scripts;
      }
   }
}
