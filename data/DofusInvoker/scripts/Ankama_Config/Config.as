package Ankama_Config
{
   import Ankama_Common.Common;
   import Ankama_Config.ui.ConfigAudio;
   import Ankama_Config.ui.ConfigCache;
   import Ankama_Config.ui.ConfigChat;
   import Ankama_Config.ui.ConfigGeneral;
   import Ankama_Config.ui.ConfigNotification;
   import Ankama_Config.ui.ConfigPerformance;
   import Ankama_Config.ui.ConfigShortcut;
   import Ankama_Config.ui.ConfigShortcutPopup;
   import Ankama_Config.ui.ConfigSupport;
   import Ankama_Config.ui.ConfigTheme;
   import Ankama_Config.ui.QualitySelection;
   import Ankama_Config.ui.ThemeInstaller;
   import Ankama_Config.ui.item.ChannelColorizedItem;
   import Ankama_Config.ui.item.ThemeItem;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.display.Sprite;
   
   public class Config extends Sprite
   {
       
      
      private var include_ConfigGeneral:ConfigGeneral = null;
      
      private var include_ConfigChat:ConfigChat = null;
      
      private var include_ConfigPerformance:ConfigPerformance = null;
      
      private var include_ConfigShortcut:ConfigShortcut = null;
      
      private var include_ConfigShortcutPopup:ConfigShortcutPopup = null;
      
      private var include_ChannelColorizedItem:ChannelColorizedItem = null;
      
      private var include_ConfigAudio:ConfigAudio = null;
      
      private var include_ConfigCache:ConfigCache;
      
      private var include_ConfigSupport:ConfigSupport;
      
      private var include_ConfigNotification:ConfigNotification;
      
      private var include_ConfigTheme:ConfigTheme;
      
      private var include_QualitySelection:QualitySelection;
      
      private var include_ThemeInstaller:ThemeInstaller;
      
      private var include_ThemeItem:ThemeItem;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Module(name="Ankama_Common")]
      public var commonMod:Common;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      public function Config()
      {
         super();
      }
      
      public function main() : void
      {
         ConfigItem.uiApi = this.uiApi;
         this.defineItems();
         this.sysApi.addHook(HookList.AuthentificationStart,this.onAuthentificationStart);
         this.sysApi.addHook(HookList.ServersList,this.onServersList);
         this.sysApi.addHook(HookList.CharacterSelectionStart,this.onCharacterSelectionStart);
         this.sysApi.addHook(HookList.GameStart,this.onGameStart);
         this.sysApi.addHook(HookList.QualitySelectionRequired,this.onQualitySelectionRequired);
         this.sysApi.addHook(HookList.SetDofusQuality,this.onSetDofusQuality);
         this.uiApi.addShortcutHook("muteSound",this.onShortcut);
         var quality:uint = this.sysApi.getOption("dofusQuality","dofus");
         if(quality == 0)
         {
            this.configApi.setConfigProperty("atouin","groundCacheMode",0);
         }
      }
      
      private function defineItems() : void
      {
         ConfigItem.register("performance","ui.option.performance","ui.option.performanceSubtitle","Ankama_Config::configPerformance");
         ConfigItem.register("sound","ui.option.audio","ui.option.audioSubtitle","Ankama_Config::configAudio");
         ConfigItem.register("notification","ui.option.notifications","ui.option.notificationsSubtitle","Ankama_Config::configNotification");
         ConfigItem.register("cache","ui.option.cache","ui.option.cacheSubtitle","Ankama_Config::configCache");
         ConfigItem.register("support","ui.option.assistance","ui.option.assistanceSubtitle","Ankama_Config::configSupport");
         ConfigItem.register("theme","ui.option.theme","ui.option.themeSubtitle","Ankama_Config::configTheme");
         ConfigItem.register("ui","ui.option.interface","ui.option.interfaceSubtitle","Ankama_Config::configChat");
         ConfigItem.register("general","ui.option.feature","ui.option.featureSubtitle","Ankama_Config::configGeneral");
         ConfigItem.register("shortcut","ui.option.shortcut","ui.option.shortcutSubtitle","Ankama_Config::configShortcut");
      }
      
      private function addItem(name:String, condition:Boolean = true) : void
      {
         var ci:ConfigItem = null;
         if(condition)
         {
            ci = ConfigItem.getItem(name);
            this.commonMod.addOptionItem(ci.id,ci.name,ci.description,ci.ui);
         }
      }
      
      private function onGameStart() : void
      {
         this.addItem("performance");
         this.addItem("ui");
         this.addItem("general");
         this.addItem("shortcut");
         this.addItem("sound");
         this.addItem("notification",true);
         this.addItem("cache");
         this.addItem("theme",true);
         this.addItem("support");
      }
      
      private function gameApproachInit() : void
      {
         this.addItem("performance");
         this.addItem("sound");
         this.addItem("cache");
         this.addItem("theme",true);
         this.addItem("support");
      }
      
      private function onAuthentificationStart() : void
      {
         this.gameApproachInit();
      }
      
      private function onServersList(serverList:*) : void
      {
         this.gameApproachInit();
      }
      
      private function onCharacterSelectionStart(characterList:*) : void
      {
         this.gameApproachInit();
      }
      
      private function onQualitySelectionRequired() : void
      {
         if(this.configApi.getConfigProperty("dofus","askForQualitySelection"))
         {
            this.uiApi.loadUi("qualitySelection",null,null,StrataEnum.STRATA_HIGH);
         }
      }
      
      private function onSetDofusQuality(qualityLevel:uint) : void
      {
         if(qualityLevel == 0)
         {
            this.configApi.setConfigProperty("dofus","showEveryMonsters",false);
            this.configApi.setConfigProperty("dofus","allowAnimsFun",false);
            this.configApi.setConfigProperty("dofus","forceRenderCPU",true);
            this.configApi.setConfigProperty("tiphon","alwaysShowAuraOnFront",false);
            this.configApi.setConfigProperty("berilia","uiShadows",false);
            this.configApi.setConfigProperty("berilia","uiAnimations",false);
            this.configApi.setConfigProperty("tubul","allowSoundEffects",false);
            this.configApi.setConfigProperty("dofus","turnPicture",false);
            this.configApi.setConfigProperty("dofus","allowSpellEffects",this.sysApi.setQualityIsEnable());
            this.configApi.setConfigProperty("dofus","allowHitAnim",this.sysApi.setQualityIsEnable());
            this.configApi.setConfigProperty("dofus","cacheMapEnabled",false);
            this.configApi.setConfigProperty("atouin","allowAnimatedGfx",false);
            this.configApi.setConfigProperty("atouin","allowParticlesFx",false);
            this.configApi.setConfigProperty("atouin","groundCacheMode",0);
         }
         else if(qualityLevel == 1)
         {
            this.configApi.setConfigProperty("dofus","showEveryMonsters",false);
            this.configApi.setConfigProperty("dofus","allowAnimsFun",true);
            this.configApi.setConfigProperty("dofus","forceRenderCPU",true);
            this.configApi.setConfigProperty("tiphon","alwaysShowAuraOnFront",false);
            this.configApi.setConfigProperty("berilia","uiShadows",false);
            this.configApi.setConfigProperty("berilia","uiAnimations",true);
            this.configApi.setConfigProperty("tubul","allowSoundEffects",true);
            this.configApi.setConfigProperty("dofus","turnPicture",true);
            this.configApi.setConfigProperty("dofus","allowSpellEffects",true);
            this.configApi.setConfigProperty("dofus","allowHitAnim",true);
            this.configApi.setConfigProperty("dofus","cacheMapEnabled",true);
            this.configApi.setConfigProperty("atouin","allowAnimatedGfx",false);
            this.configApi.setConfigProperty("atouin","allowParticlesFx",true);
            this.configApi.setConfigProperty("atouin","groundCacheMode",1);
         }
         else
         {
            if(qualityLevel != 2)
            {
               return;
            }
            this.configApi.setConfigProperty("dofus","showEveryMonsters",true);
            this.configApi.setConfigProperty("dofus","allowAnimsFun",true);
            this.configApi.setConfigProperty("dofus","forceRenderCPU",this.sysApi.getOs() == "Linux");
            this.configApi.setConfigProperty("tiphon","alwaysShowAuraOnFront",true);
            this.configApi.setConfigProperty("berilia","uiShadows",true);
            this.configApi.setConfigProperty("berilia","uiAnimations",true);
            this.configApi.setConfigProperty("tubul","allowSoundEffects",true);
            this.configApi.setConfigProperty("dofus","turnPicture",true);
            this.configApi.setConfigProperty("dofus","allowSpellEffects",true);
            this.configApi.setConfigProperty("dofus","allowHitAnim",true);
            this.configApi.setConfigProperty("dofus","cacheMapEnabled",true);
            this.configApi.setConfigProperty("atouin","allowAnimatedGfx",true);
            this.configApi.setConfigProperty("atouin","allowParticlesFx",true);
            this.configApi.setConfigProperty("atouin","groundCacheMode",1);
         }
         this.configApi.setConfigProperty("dofus","dofusQuality",qualityLevel);
      }
      
      public function onShortcut(s:String) : Boolean
      {
         var activate:Boolean = false;
         switch(s)
         {
            case "muteSound":
               activate = false;
               if(this.configApi.getConfigProperty("tubul","tubulIsDesactivated"))
               {
                  activate = true;
               }
               this.configApi.setConfigProperty("tubul","tubulIsDesactivated",!activate);
               this.sysApi.dispatchHook(CustomUiHookList.ActivateSound,!activate);
               return true;
            default:
               return false;
         }
      }
      
      public function unload() : void
      {
         ConfigItem.uiApi = null;
      }
   }
}

import com.ankamagames.berilia.api.UiApi;

class ConfigItem
{
   
   private static var _items:Array = [];
   
   public static var uiApi:UiApi;
    
   
   public var id:String;
   
   public var name:String;
   
   public var description:String;
   
   public var ui:String;
   
   function ConfigItem()
   {
      super();
   }
   
   public static function getItem(name:String) : ConfigItem
   {
      return _items[name];
   }
   
   public static function register(id:String, name:String, description:String, ui:String) : void
   {
      var o:ConfigItem = new ConfigItem();
      o.id = id;
      o.name = uiApi.getText(name);
      o.description = uiApi.getText(description);
      o.ui = ui;
      _items[id] = o;
   }
}
