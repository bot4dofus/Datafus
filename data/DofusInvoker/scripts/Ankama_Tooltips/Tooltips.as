package Ankama_Tooltips
{
   import Ankama_Tooltips.makers.AchievementModsterTooltipMaker;
   import Ankama_Tooltips.makers.AlterationTooltipMaker;
   import Ankama_Tooltips.makers.BreachMonstersGroupTooltipMaker;
   import Ankama_Tooltips.makers.BreachRewardTooltipMaker;
   import Ankama_Tooltips.makers.BreachRoomTooltipMaker;
   import Ankama_Tooltips.makers.CartographyTooltipMaker;
   import Ankama_Tooltips.makers.ChallengeTooltipMaker;
   import Ankama_Tooltips.makers.DelayedActionTooltipMaker;
   import Ankama_Tooltips.makers.EffectsListTooltipMaker;
   import Ankama_Tooltips.makers.EffectsTooltipMaker;
   import Ankama_Tooltips.makers.InterfaceTutoTooltipMaker;
   import Ankama_Tooltips.makers.ItemTooltipMaker;
   import Ankama_Tooltips.makers.MountTooltipMaker;
   import Ankama_Tooltips.makers.MysteryBoxTooltipMaker;
   import Ankama_Tooltips.makers.SellCriterionTooltipMaker;
   import Ankama_Tooltips.makers.SlotTextureTooltipMaker;
   import Ankama_Tooltips.makers.SmileyTooltipMaker;
   import Ankama_Tooltips.makers.SpellTooltipMaker;
   import Ankama_Tooltips.makers.StatFloorsTooltipMaker;
   import Ankama_Tooltips.makers.TchatTooltipMaker;
   import Ankama_Tooltips.makers.TextInfoTooltipMaker;
   import Ankama_Tooltips.makers.TextInfoWithHorizontalSeparatorTooltipMaker;
   import Ankama_Tooltips.makers.TextTooltipMaker;
   import Ankama_Tooltips.makers.TextWithShortcutTooltipMaker;
   import Ankama_Tooltips.makers.TextWithTextureTooltipMaker;
   import Ankama_Tooltips.makers.TextWithTitleTooltipMaker;
   import Ankama_Tooltips.makers.TexturesListTooltipMaker;
   import Ankama_Tooltips.makers.ThinkTooltipMaker;
   import Ankama_Tooltips.makers.world.WorldCompanionFighterTooltipMaker;
   import Ankama_Tooltips.makers.world.WorldMonsterFighterTooltipMaker;
   import Ankama_Tooltips.makers.world.WorldPlayerFighterTooltipMaker;
   import Ankama_Tooltips.makers.world.WorldRpCharacterTooltipMaker;
   import Ankama_Tooltips.makers.world.WorldRpFightTooltipMaker;
   import Ankama_Tooltips.makers.world.WorldRpGroundObjectTooltipMaker;
   import Ankama_Tooltips.makers.world.WorldRpHouseTooltipMaker;
   import Ankama_Tooltips.makers.world.WorldRpInteractiveElementTooltipMaker;
   import Ankama_Tooltips.makers.world.WorldRpMerchantCharacterTooltipMaker;
   import Ankama_Tooltips.makers.world.WorldRpMonstersGroupTooltipMaker;
   import Ankama_Tooltips.makers.world.WorldRpPaddockItemTooltipMaker;
   import Ankama_Tooltips.makers.world.WorldRpPaddockMountTooltipMaker;
   import Ankama_Tooltips.makers.world.WorldRpPaddockTooltipMaker;
   import Ankama_Tooltips.makers.world.WorldRpPrismTooltipMaker;
   import Ankama_Tooltips.makers.world.WorldRpSignTooltipMaker;
   import Ankama_Tooltips.makers.world.WorldRpTaxeCollectorTooltipMaker;
   import Ankama_Tooltips.makers.world.WorldTaxeCollectorFighterTooltipMaker;
   import Ankama_Tooltips.ui.AchievementModsterTooltipUi;
   import Ankama_Tooltips.ui.AlterationTooltipUi;
   import Ankama_Tooltips.ui.BreachMonstersGroupTooltipUi;
   import Ankama_Tooltips.ui.BreachRewardTooltipUi;
   import Ankama_Tooltips.ui.BreachRoomTooltipUi;
   import Ankama_Tooltips.ui.CartographyTooltipUi;
   import Ankama_Tooltips.ui.DelayedActionTooltipUi;
   import Ankama_Tooltips.ui.HouseTooltipUi;
   import Ankama_Tooltips.ui.InteractiveElementTooltipUi;
   import Ankama_Tooltips.ui.InterfaceTutoTooltipUi;
   import Ankama_Tooltips.ui.ItemNameTooltipUi;
   import Ankama_Tooltips.ui.ItemTooltipUi;
   import Ankama_Tooltips.ui.MountTooltipUi;
   import Ankama_Tooltips.ui.MysteryBoxTooltipUi;
   import Ankama_Tooltips.ui.SpellBannerTooltipUi;
   import Ankama_Tooltips.ui.SpellTooltipUi;
   import Ankama_Tooltips.ui.TchatTooltipUi;
   import Ankama_Tooltips.ui.TextInfoTooltipUi;
   import Ankama_Tooltips.ui.TextInfoWithHorizontalSeparatorTooltipUi;
   import Ankama_Tooltips.ui.TextWithShortcutTooltipUi;
   import Ankama_Tooltips.ui.TextWithTextureTooltipUi;
   import Ankama_Tooltips.ui.TextWithTitleTooltipUi;
   import Ankama_Tooltips.ui.TooltipUi;
   import Ankama_Tooltips.ui.WeaponBannerTooltipUi;
   import Ankama_Tooltips.ui.WorldCharacterFighterTooltipUi;
   import Ankama_Tooltips.ui.WorldCompanionFighterTooltipUi;
   import Ankama_Tooltips.ui.WorldMonsterFighterTooltipUi;
   import Ankama_Tooltips.ui.WorldRpCharacterTooltipUi;
   import Ankama_Tooltips.ui.WorldRpFightTooltipUi;
   import Ankama_Tooltips.ui.WorldRpMonstersGroupTooltipUi;
   import Ankama_Tooltips.ui.WorldRpPaddockItemTooltipUi;
   import Ankama_Tooltips.ui.WorldRpPaddockTooltipUi;
   import Ankama_Tooltips.ui.WorldRpPortalTooltipUi;
   import Ankama_Tooltips.ui.WorldRpPrismTooltipUi;
   import Ankama_Tooltips.ui.WorldRpSignTooltipUi;
   import Ankama_Tooltips.ui.WorldRpTaxeCollectorTooltipUi;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.dofus.uiApi.AlignmentApi;
   import com.ankamagames.dofus.uiApi.AveragePricesApi;
   import com.ankamagames.dofus.uiApi.BreachApi;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.FightApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.display.Sprite;
   
   public class Tooltips extends Sprite
   {
      
      public static var STATS_ICONS_PATH:String;
       
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="AlignmentApi")]
      public var alignApi:AlignmentApi;
      
      [Api(name="FightApi")]
      public var fightApi:FightApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      [Api(name="AveragePricesApi")]
      public var averagePricesApi:AveragePricesApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="BreachApi")]
      public var breachApi:BreachApi;
      
      private var include_TooltipUi:TooltipUi = null;
      
      private var include_WorldRpCharacterTooltipUi:WorldRpCharacterTooltipUi = null;
      
      private var include_TchatTooltipUi:TchatTooltipUi = null;
      
      private var include_TextInfoTooltipUi:TextInfoTooltipUi = null;
      
      public function Tooltips()
      {
         super();
      }
      
      public function main() : void
      {
         Api.system = this.sysApi;
         Api.ui = this.uiApi;
         Api.tooltip = this.tooltipApi;
         Api.data = this.dataApi;
         Api.alignment = this.alignApi;
         Api.fight = this.fightApi;
         Api.player = this.playerApi;
         Api.chat = this.chatApi;
         Api.averagePrices = this.averagePricesApi;
         Api.util = this.utilApi;
         Api.social = this.socialApi;
         Api.time = this.timeApi;
         Api.breach = this.breachApi;
         this.uiApi.preloadCss(this.sysApi.getConfigEntry("config.ui.skin") + "css/tooltip_npc.css");
         this.uiApi.preloadCss(this.sysApi.getConfigEntry("config.ui.skin") + "css/tooltip_item-smallScreen.css");
         this.uiApi.preloadCss(this.sysApi.getConfigEntry("config.ui.skin") + "css/tooltip_spell-smallScreen.css");
         this.tooltipApi.setDefaultTooltipUiScript("Ankama_Tooltips","tooltip");
         this.tooltipApi.registerTooltipMaker("text",TextTooltipMaker);
         this.tooltipApi.registerTooltipMaker("textInfo",TextInfoTooltipMaker,TextInfoTooltipUi);
         this.tooltipApi.registerTooltipMaker("textWithTitle",TextWithTitleTooltipMaker,TextWithTitleTooltipUi);
         this.tooltipApi.registerTooltipMaker("textWithShortcut",TextWithShortcutTooltipMaker,TextWithShortcutTooltipUi);
         this.tooltipApi.registerTooltipMaker("textWithTexture",TextWithTextureTooltipMaker,TextWithTextureTooltipUi);
         this.tooltipApi.registerTooltipMaker("breachRoom",BreachRoomTooltipMaker,BreachRoomTooltipUi);
         this.tooltipApi.registerTooltipMaker("spell",SpellTooltipMaker,SpellTooltipUi);
         this.tooltipApi.registerTooltipMaker("spellBanner",TextInfoTooltipMaker,SpellBannerTooltipUi);
         this.tooltipApi.registerTooltipMaker("weaponBanner",TextInfoTooltipMaker,WeaponBannerTooltipUi);
         this.tooltipApi.registerTooltipMaker("item",ItemTooltipMaker,ItemTooltipUi);
         this.tooltipApi.registerTooltipMaker("itemName",TextInfoTooltipMaker,ItemNameTooltipUi);
         this.tooltipApi.registerTooltipMaker("effects",EffectsTooltipMaker);
         this.tooltipApi.registerTooltipMaker("smiley",SmileyTooltipMaker);
         this.tooltipApi.registerTooltipMaker("chatBubble",TchatTooltipMaker,TchatTooltipUi);
         this.tooltipApi.registerTooltipMaker("thinkBubble",ThinkTooltipMaker,TchatTooltipUi);
         this.tooltipApi.registerTooltipMaker("player",WorldRpCharacterTooltipMaker,WorldRpCharacterTooltipUi);
         this.tooltipApi.registerTooltipMaker("mutant",WorldRpCharacterTooltipMaker,WorldRpCharacterTooltipUi);
         this.tooltipApi.registerTooltipMaker("merchant",WorldRpMerchantCharacterTooltipMaker,WorldRpCharacterTooltipUi);
         this.tooltipApi.registerTooltipMaker("delayedAction",DelayedActionTooltipMaker,DelayedActionTooltipUi);
         this.tooltipApi.registerTooltipMaker("monsterGroup",WorldRpMonstersGroupTooltipMaker,WorldRpMonstersGroupTooltipUi);
         this.tooltipApi.registerTooltipMaker("breachMonsterGroup",BreachMonstersGroupTooltipMaker,BreachMonstersGroupTooltipUi);
         this.tooltipApi.registerTooltipMaker("taxCollector",WorldRpTaxeCollectorTooltipMaker,WorldRpTaxeCollectorTooltipUi);
         this.tooltipApi.registerTooltipMaker("paddockMount",WorldRpPaddockMountTooltipMaker);
         this.tooltipApi.registerTooltipMaker("paddock",WorldRpPaddockTooltipMaker,WorldRpPaddockTooltipUi);
         this.tooltipApi.registerTooltipMaker("paddockItem",WorldRpPaddockItemTooltipMaker,WorldRpPaddockItemTooltipUi);
         this.tooltipApi.registerTooltipMaker("mount",MountTooltipMaker,MountTooltipUi);
         this.tooltipApi.registerTooltipMaker("fightTaxCollector",WorldTaxeCollectorFighterTooltipMaker);
         this.tooltipApi.registerTooltipMaker("challenge",ChallengeTooltipMaker);
         this.tooltipApi.registerTooltipMaker("playerFighter",WorldPlayerFighterTooltipMaker,WorldCharacterFighterTooltipUi);
         this.tooltipApi.registerTooltipMaker("monsterFighter",WorldMonsterFighterTooltipMaker,WorldMonsterFighterTooltipUi);
         this.tooltipApi.registerTooltipMaker("companionFighter",WorldCompanionFighterTooltipMaker,WorldCompanionFighterTooltipUi);
         this.tooltipApi.registerTooltipMaker("roleplayFight",WorldRpFightTooltipMaker,WorldRpFightTooltipUi);
         this.tooltipApi.registerTooltipMaker("groundObject",WorldRpGroundObjectTooltipMaker);
         this.tooltipApi.registerTooltipMaker("prism",WorldRpPrismTooltipMaker,WorldRpPrismTooltipUi);
         this.tooltipApi.registerTooltipMaker("portal",WorldRpPrismTooltipMaker,WorldRpPortalTooltipUi);
         this.tooltipApi.registerTooltipMaker("effectsList",EffectsListTooltipMaker);
         this.tooltipApi.registerTooltipMaker("texturesList",TexturesListTooltipMaker);
         this.tooltipApi.registerTooltipMaker("slotTexture",SlotTextureTooltipMaker);
         this.tooltipApi.registerTooltipMaker("house",WorldRpHouseTooltipMaker,HouseTooltipUi);
         this.tooltipApi.registerTooltipMaker("sellCriterion",SellCriterionTooltipMaker);
         this.tooltipApi.registerTooltipMaker("interactiveElement",WorldRpInteractiveElementTooltipMaker,InteractiveElementTooltipUi);
         this.tooltipApi.registerTooltipMaker("directionalSign",WorldRpSignTooltipMaker,WorldRpSignTooltipUi);
         this.tooltipApi.registerTooltipMaker("breachReward",BreachRewardTooltipMaker,BreachRewardTooltipUi);
         this.tooltipApi.registerTooltipMaker("mysteryBox",MysteryBoxTooltipMaker,MysteryBoxTooltipUi);
         this.tooltipApi.registerTooltipMaker("achievementModster",AchievementModsterTooltipMaker,AchievementModsterTooltipUi);
         this.tooltipApi.registerTooltipMaker("alteration",AlterationTooltipMaker,AlterationTooltipUi);
         this.tooltipApi.registerTooltipMaker("simpleInterfaceTuto",InterfaceTutoTooltipMaker,InterfaceTutoTooltipUi);
         this.tooltipApi.registerTooltipMaker("cartography",CartographyTooltipMaker,CartographyTooltipUi);
         this.tooltipApi.registerTooltipMaker("textInfoWithHorizontalSeparator",TextInfoWithHorizontalSeparatorTooltipMaker,TextInfoWithHorizontalSeparatorTooltipUi);
         this.tooltipApi.registerTooltipMaker("statFloors",StatFloorsTooltipMaker);
         STATS_ICONS_PATH = this.sysApi.getConfigEntry("config.ui.skin").concat("texture/icon_");
      }
      
      public function unload() : void
      {
         Api.system = null;
         Api.ui = null;
         Api.tooltip = null;
         Api.data = null;
         Api.alignment = null;
         Api.fight = null;
         Api.player = null;
         Api.chat = null;
         Api.averagePrices = null;
         Api.util = null;
      }
   }
}
