package Ankama_Roleplay
{
   import Ankama_Roleplay.ui.KingOfTheHill;
   import Ankama_Roleplay.ui.LegendaryHunts;
   import Ankama_Roleplay.ui.LevelUpGod;
   import Ankama_Roleplay.ui.LevelUpUi;
   import Ankama_Roleplay.ui.NpcDialog;
   import Ankama_Roleplay.ui.SpectatorUi;
   import Ankama_Roleplay.ui.TreasureHunt;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.dofus.internalDatacenter.connection.BasicCharacterWrapper;
   import com.ankamagames.dofus.internalDatacenter.conquest.PrismSubAreaWrapper;
   import com.ankamagames.dofus.internalDatacenter.world.WorldPointWrapper;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.misc.lists.FightHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.PrismHookList;
   import com.ankamagames.dofus.misc.lists.QuestHookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.AggressableStatusEnum;
   import com.ankamagames.dofus.network.enums.PrismStateEnum;
   import com.ankamagames.dofus.network.types.game.context.fight.FightExternalInformations;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.display.Sprite;
   
   public class Roleplay extends Sprite
   {
      
      public static var questions:Array;
      
      private static var _compt:uint = 0;
       
      
      protected var npcDialog:NpcDialog;
      
      protected var spectatorUi:SpectatorUi;
      
      protected var levelUpUi:LevelUpUi;
      
      protected var levelUpGod:LevelUpGod;
      
      protected var kingOfTheHill:KingOfTheHill;
      
      protected var treasureHunt:TreasureHunt;
      
      protected var legendaryHunts:LegendaryHunts;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      private var _avaEnable:Boolean;
      
      private var _probationTime:uint;
      
      private var _fightContext:Boolean = false;
      
      public function Roleplay()
      {
         super();
      }
      
      public function main() : void
      {
         this.sysApi.addHook(RoleplayHookList.NpcDialogCreationFailure,this.onNpcDialogCreationFailure);
         this.sysApi.addHook(RoleplayHookList.NpcDialogCreation,this.onNpcDialogCreation);
         this.sysApi.addHook(RoleplayHookList.PonyDialogCreation,this.onPonyDialogCreation);
         this.sysApi.addHook(RoleplayHookList.PrismDialogCreation,this.onPrismDialogCreation);
         this.sysApi.addHook(RoleplayHookList.PortalDialogCreation,this.onPortalDialogCreation);
         this.sysApi.addHook(RoleplayHookList.NpcDialogQuestion,this.onNpcDialogQuestion);
         this.sysApi.addHook(HookList.MapRunningFightList,this.onMapRunningFightList);
         this.sysApi.addHook(HookList.GameFightStarting,this.onGameFightStarting);
         this.sysApi.addHook(HookList.CurrentMap,this.onMapChange);
         this.sysApi.addHook(HookList.MapComplementaryInformationsData,this.onMapLoaded);
         this.sysApi.addHook(HookList.CharacterLevelUp,this.onLevelUp);
         this.sysApi.addHook(HookList.GameFightJoin,this.onGameFightJoin);
         this.sysApi.addHook(HookList.GameFightEnd,this.onGameFightEnd);
         this.sysApi.addHook(FightHookList.SpectatorWantLeave,this.onSpectatorWantLeave);
         this.sysApi.addHook(PrismHookList.KohState,this.onKohStateChange);
         this.sysApi.addHook(PrismHookList.PvpAvaStateChange,this.onPvpAvaStateChange);
         this.sysApi.addHook(SocialHookList.AllianceMembershipUpdated,this.onAllianceMembershipUpdated);
         this.sysApi.addHook(QuestHookList.TreasureHuntUpdate,this.onTreasureHunt);
         this.sysApi.addHook(QuestHookList.TreasureHuntLegendaryUiUpdate,this.onTreasureHuntLegendaryUiUpdate);
      }
      
      private function onNpcDialogCreationFailure() : void
      {
         this.sysApi.log(16,"Impossible de parler à ce pnj :o");
      }
      
      private function onNpcDialogCreation(mapId:Number, npcId:int, look:Object) : void
      {
         questions = [];
         var map:Number = this.playerApi.currentMap().mapId;
         if(mapId == map)
         {
            if(this.uiApi.getUi("npcDialog"))
            {
               this.uiApi.unloadUi("npcDialog");
            }
            this.uiApi.loadUi("npcDialog","npcDialog",[npcId,look]);
         }
         else
         {
            this.sysApi.log(16,"Required npc (" + npcId + ") cannot be found on map " + map + ".");
            this.sysApi.sendAction(new LeaveDialogRequestAction([]));
         }
      }
      
      private function onPonyDialogCreation(mapId:Number, firstnameId:int, lastNameId:int, look:Object) : void
      {
         questions = [];
         var map:Number = this.playerApi.currentMap().mapId;
         if(mapId == map)
         {
            this.uiApi.loadUi("npcDialog","npcDialog",[1,look,firstnameId,lastNameId]);
         }
         else
         {
            this.sysApi.log(16,"Required tax collector cannot be found on map " + map + ".");
            this.sysApi.sendAction(new LeaveDialogRequestAction([]));
         }
      }
      
      private function onPrismDialogCreation(mapId:Number, allianceName:String, look:Object) : void
      {
         questions = [];
         var map:Number = this.playerApi.currentMap().mapId;
         if(mapId == map)
         {
            this.uiApi.loadUi("npcDialog","npcDialog",[2141,look,allianceName]);
         }
         else
         {
            this.sysApi.log(16,"Required prism cannot be found on map " + map + ".");
            this.sysApi.sendAction(new LeaveDialogRequestAction([]));
         }
      }
      
      private function onPortalDialogCreation(mapId:Number, portalNpcId:int, areaName:String, look:Object) : void
      {
         questions = [];
         var map:Number = this.playerApi.currentMap().mapId;
         if(mapId == map)
         {
            this.uiApi.loadUi("npcDialog","npcDialog",[portalNpcId,look,areaName]);
         }
         else
         {
            this.sysApi.log(16,"Required portal cannot be found on map " + map + ".");
            this.sysApi.sendAction(new LeaveDialogRequestAction([]));
         }
      }
      
      public function onNpcDialogQuestion(messageId:uint = 0, dialogParams:Vector.<String> = null, visibleReplies:Vector.<uint> = null) : void
      {
      }
      
      private function onKohStateChange(prism:PrismSubAreaWrapper) : void
      {
         if(!prism)
         {
            this.uiApi.unloadUi("kingOfTheHill");
            return;
         }
         if(!this._avaEnable || !prism.alliance || KingOfTheHill.instance && KingOfTheHill.instance.currentSubArea != prism.subAreaId)
         {
            this.uiApi.unloadUi("kingOfTheHill");
         }
         if(this._avaEnable && prism.state == PrismStateEnum.PRISM_STATE_VULNERABLE && !this.uiApi.getUi("kingOfTheHill"))
         {
            this.uiApi.loadUi("kingOfTheHill","kingOfTheHill",{
               "prism":prism,
               "probationTime":this._probationTime
            });
         }
      }
      
      private function onPvpAvaStateChange(status:uint, probationTime:uint) : void
      {
         this._avaEnable = status == AggressableStatusEnum.AvA_DISQUALIFIED || status == AggressableStatusEnum.AvA_ENABLED_AGGRESSABLE || status == AggressableStatusEnum.AvA_ENABLED_NON_AGGRESSABLE || status == AggressableStatusEnum.AvA_PREQUALIFIED_AGGRESSABLE;
         this._probationTime = probationTime;
         if(!this._avaEnable)
         {
            this.uiApi.unloadUi("kingOfTheHill");
         }
      }
      
      private function onAllianceMembershipUpdated(hasAlliance:Boolean) : void
      {
         if(!hasAlliance && this._avaEnable)
         {
            this.uiApi.unloadUi("kingOfTheHill");
            this._avaEnable = false;
         }
      }
      
      private function onTreasureHunt(treasureHuntType:uint) : void
      {
         if(!this.uiApi.getUi("treasureHunt"))
         {
            this.uiApi.loadUi("treasureHunt","treasureHunt",treasureHuntType);
         }
      }
      
      private function onTreasureHuntLegendaryUiUpdate(huntsList:Object) : void
      {
         if(!this.uiApi.getUi("legendaryHunts"))
         {
            this.uiApi.loadUi("legendaryHunts","legendaryHunts",huntsList);
         }
      }
      
      private function onMapRunningFightList(pFights:Vector.<FightExternalInformations>) : void
      {
         if(!this.uiApi.getUi(UIEnum.SPECTATOR_UI))
         {
            this.uiApi.loadUi(UIEnum.SPECTATOR_UI,UIEnum.SPECTATOR_UI,pFights);
         }
      }
      
      private function onGameFightStarting(pFightType:uint) : void
      {
         if(this.uiApi.getUi(UIEnum.SPECTATOR_UI))
         {
            this.uiApi.unloadUi(UIEnum.SPECTATOR_UI);
         }
      }
      
      private function onMapChange(pMapId:Object) : void
      {
         if(this.uiApi.getUi(UIEnum.SPECTATOR_UI))
         {
            this.uiApi.unloadUi(UIEnum.SPECTATOR_UI);
         }
      }
      
      private function onMapLoaded(wp:WorldPointWrapper, subareaId:uint, foo:Boolean) : void
      {
         if(KingOfTheHill.instance && this.dataApi.getSubAreaFromMap(this.playerApi.currentMap().mapId).id != KingOfTheHill.instance.currentSubArea)
         {
            this.uiApi.unloadUi("kingOfTheHill");
         }
      }
      
      private function onLevelUp(pOldLevel:uint, pNewLevel:uint, pCaracPointEarned:uint, pHealPointEarned:uint, newSpellWrappers:Array) : void
      {
         var uiName:String = null;
         var exactName:String = null;
         var character:BasicCharacterWrapper = null;
         var nameText:* = null;
         var spellObtained:* = newSpellWrappers.length > 0;
         if(spellObtained && pNewLevel <= ProtocolConstantsEnum.MAX_LEVEL && !this.configApi.isFeatureWithKeywordEnabled("character.spell.forgettable"))
         {
            uiName = "levelUpWithSpell";
         }
         else if(pNewLevel > ProtocolConstantsEnum.MAX_LEVEL)
         {
            uiName = "levelUpOmega";
         }
         else
         {
            uiName = "levelUp";
         }
         var params:Object = {};
         params.oldLevel = pOldLevel;
         params.newLevel = pNewLevel;
         params.caracPointEarned = pCaracPointEarned;
         params.healPointEarned = pHealPointEarned;
         params.newSpellWrappers = newSpellWrappers;
         params.spellObtained = newSpellWrappers.length > 0;
         var currentPlayer:Object = this.playerApi.getPlayedCharacterInfo();
         for each(character in this.sysApi.getPlayerManager().charactersList)
         {
            exactName = character.name.split(" ")[0];
            if(exactName == currentPlayer.name)
            {
               nameText = currentPlayer.name + character.name.split(" ")[1] + " ";
               if(pNewLevel > ProtocolConstantsEnum.MAX_LEVEL)
               {
                  nameText += this.uiApi.getText("ui.common.short.prestige") + (pNewLevel - ProtocolConstantsEnum.MAX_LEVEL) + ")";
               }
               else
               {
                  nameText += this.uiApi.getText("ui.common.short.level") + pNewLevel + ")";
               }
               this.sysApi.getPlayerManager().charactersList[this.sysApi.getPlayerManager().charactersList.indexOf(character)].level = pNewLevel;
            }
         }
         this.uiApi.loadUi(uiName,"levelUp",params,StrataEnum.STRATA_MAX,null,true);
      }
      
      public function onGameFightJoin(canBeCancelled:Boolean, canSayReady:Boolean, isSpectator:Boolean, timeMaxBeforeFightStart:uint, fightType:int, alliesPreparation:Boolean) : void
      {
         this._fightContext = true;
         if(this.uiApi.getUi(UIEnum.TREASURE_HUNT))
         {
            this.uiApi.getUi(UIEnum.TREASURE_HUNT).visible = false;
         }
      }
      
      public function onGameFightEnd(resultsKey:String) : void
      {
         this._fightContext = false;
         if(this.uiApi.getUi(UIEnum.TREASURE_HUNT))
         {
            this.uiApi.getUi(UIEnum.TREASURE_HUNT).visible = true;
         }
      }
      
      public function onSpectatorWantLeave() : void
      {
         this._fightContext = false;
         if(this.uiApi.getUi(UIEnum.TREASURE_HUNT))
         {
            this.uiApi.getUi(UIEnum.TREASURE_HUNT).visible = true;
         }
      }
   }
}
