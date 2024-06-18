package com.ankamagames.dofus.types
{
   import com.ankamagames.berilia.managers.ThemeManager;
   import com.ankamagames.dofus.externalnotification.enums.ExternalNotificationPositionEnum;
   import com.ankamagames.dofus.logic.game.common.frames.ScreenCaptureFrame;
   import com.ankamagames.jerakine.managers.OptionManager;
   import flash.geom.Point;
   
   public class DofusOptions extends OptionManager
   {
       
      
      public function DofusOptions()
      {
         super("dofus");
         add("optimize",false);
         add("forceRenderCPU",false);
         add("cacheMapEnabled",true);
         add("optimizeMultiAccount",true);
         add("fullScreen",false);
         add("autoConnectType",1);
         add("connectionPort",5555);
         add("showEveryMonsters",false);
         add("allowAnimsFun",true);
         add("turnPicture",true);
         add("mapCoordinates",true);
         add("remindTurn",true);
         add("confirmItemDrop",true);
         add("currentUiSkin",ThemeManager.OFFICIAL_THEME_NAME);
         add("allowBannerShortcuts",true);
         add("dofusQuality",1);
         add("askForQualitySelection",true);
         add("showNotifications",true);
         add("showEsportNotifications",true);
         add("showUIHints",true);
         add("hdvBlockPopupType","Sometimes");
         add("showUsedPaPm",false);
         add("largeTooltipDelay",500);
         add("spellTooltipDelay",0);
         add("itemTooltipDelay",0);
         add("pinTooltipOnClick",false);
         add("alwaysDisplayTheoreticalEffectsInTooltip",false);
         add("showOmegaUnderOrnament",true);
         add("lockUI",false);
         add("smallScreenFont",false);
         add("bigMenuButton",false);
         add("allowSpellEffects",true);
         add("allowHitAnim",true);
         add("flashQuality",2);
         add("cellSelectionOnly",true);
         add("orderFighters",false);
         add("showAlignmentWings",false);
         add("showTacticMode",false);
         add("showMovementDistance",false);
         add("showMovementArea",true);
         add("showTurnsRemaining",true);
         add("toggleEntityIcons",true);
         add("hideDeadFighters",true);
         add("hideSummonedFighters",false);
         add("mapFilters",4094);
         add("mapFilters_miniMap",4094);
         add("mapFiltersConquest",288);
         add("mapFiltersAnomaly",1344);
         add("mapFiltersSearch",256);
         add("showMiniMap",true);
         add("showMapGrid",false);
         add("showMiniMapGrid",false);
         add("showLogPvDetails",true);
         add("notificationsAlphaWindows",false);
         add("notificationsMode",1);
         add("notificationsDisplayDuration",5);
         add("notificationsMaxNumber",5);
         add("notificationsPosition",ExternalNotificationPositionEnum.BOTTOM_RIGHT);
         add("creaturesFightMode",false);
         add("warnOnAllianceItemAgression",true);
         add("disableGuildMotd",false);
         add("disableAllianceMotd",false);
         add("zoomOnMouseWheel",true);
         add("showPermanentTargetsTooltips",false);
         add("showDamagesPreview",true);
         add("showMovePreview",true);
         add("showBreed",true);
         add("spectatorAutoShowCurrentFighterInfo",false);
         add("enableForceWalk",true);
         add("showMountsInFight",true);
         add("havenbagEditPosition",new Point(390,212));
         add("screenshotsDirectory",ScreenCaptureFrame.getDefaultDirectory());
         add("showFinishMoves",true);
         add("followQuestOnStarted",true);
         add("shadowCharacter",false);
         add("forceDefaultTacticalModeTemplate",false);
         add("useNewTacticalMode",true);
         add("useTheoreticalValuesInSpellTooltips",false);
         add("resetUIPositions",false);
         add("resetNotifications",false);
         add("resetUIHints",false);
         add("resetColors",false);
         add("delaySkipTurn",true);
      }
   }
}
