package Ankama_Roleplay.ui
{
   import Ankama_Roleplay.LevelUpAssets;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBase;
   import com.ankamagames.berilia.components.gridRenderer.InlineXmlGridRenderer;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.datacenter.appearance.Ornament;
   import com.ankamagames.dofus.datacenter.spells.SpellLevel;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.modules.utils.SpellTooltipSettings;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.display.Bitmap;
   import flash.geom.Point;
   
   public class LevelUpUi
   {
      
      private static const _omegaAuras:Array = [{
         "id":171,
         "level":100
      },{
         "id":172,
         "level":200
      },{
         "id":173,
         "level":300
      },{
         "id":174,
         "level":400
      },{
         "id":175,
         "level":500
      }];
      
      private static const _omegaOrnaments:Array = [{
         "id":111,
         "level":25
      },{
         "id":112,
         "level":50
      },{
         "id":113,
         "level":75
      },{
         "id":114,
         "level":125
      },{
         "id":115,
         "level":150
      },{
         "id":116,
         "level":175
      },{
         "id":117,
         "level":225
      },{
         "id":118,
         "level":250
      },{
         "id":119,
         "level":275
      },{
         "id":120,
         "level":325
      },{
         "id":121,
         "level":350
      },{
         "id":122,
         "level":375
      },{
         "id":123,
         "level":425
      },{
         "id":124,
         "level":450
      },{
         "id":125,
         "level":475
      }];
       
      
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
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="InventoryApi")]
      public var inventoryApi:InventoryApi;
      
      public var spellSlot:Slot;
      
      public var btn_close_main:ButtonContainer;
      
      public var lbl_spell:Label;
      
      public var lbl_newLevel:Label;
      
      public var lbl_title:Label;
      
      public var ed_player:EntityDisplayer;
      
      public var gd_rewards:Grid;
      
      public var tx_player_bg:Texture;
      
      public function LevelUpUi()
      {
         super();
      }
      
      public function main(pParam:Object) : void
      {
         var showGod:Boolean = false;
         var maxSlots:uint = 0;
         var oldOmegaLevel:uint = 0;
         var omegaLevel:uint = 0;
         var aura:Object = null;
         var ornamentData:Object = null;
         var ornament:Ornament = null;
         var ornamentTextureId:uint = 0;
         var spellWrapper:SpellWrapper = null;
         var maxSpellLevel:uint = 0;
         var i:int = 0;
         var spellName:* = null;
         var sw:SpellWrapper = null;
         var spellLevel:SpellLevel = null;
         var activeFightResultUi:* = !!this.uiApi.getUi("fightResult") ? this.uiApi.getUi("fightResult") : this.uiApi.getUi("fightResultSimple");
         if(activeFightResultUi)
         {
            activeFightResultUi.visible = false;
         }
         this.uiApi.addComponentHook(this.spellSlot,"onRollOver");
         this.uiApi.addComponentHook(this.spellSlot,"onRollOut");
         this.uiApi.addShortcutHook("validUi",this.onShortcut);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         var rewards:Array = [];
         if(pParam.newLevel > ProtocolConstantsEnum.MAX_LEVEL)
         {
            maxSlots = 3;
            oldOmegaLevel = Math.max(pParam.oldLevel - ProtocolConstantsEnum.MAX_LEVEL,0);
            omegaLevel = pParam.newLevel - ProtocolConstantsEnum.MAX_LEVEL;
            this.lbl_newLevel.text = omegaLevel.toString();
            rewards.push({
               "iconName":"bag_reward",
               "value":pParam.caracPointEarned
            });
            showGod = true;
            for each(aura in _omegaAuras)
            {
               if(oldOmegaLevel < aura.level && omegaLevel >= aura.level)
               {
                  rewards.push({
                     "iconName":"aura_reward",
                     "value":1,
                     "text":this.dataApi.getEmoticon(aura.id).name
                  });
               }
            }
            for each(ornamentData in _omegaOrnaments)
            {
               if(oldOmegaLevel < ornamentData.level && omegaLevel >= ornamentData.level)
               {
                  ornament = this.dataApi.getOrnament(ornamentData.id);
                  switch(ornament.iconId)
                  {
                     case 18:
                        ornamentTextureId = 4;
                        break;
                     case 10:
                        ornamentTextureId = 1;
                        break;
                     case 19:
                        ornamentTextureId = 5;
                        break;
                     case 9:
                        ornamentTextureId = 3;
                        break;
                     case 8:
                        ornamentTextureId = 2;
                  }
                  rewards.push({
                     "iconName":"ornament" + ornamentTextureId + "_reward",
                     "value":1,
                     "text":this.uiApi.getText("ui.common.ornament",[this.dataApi.getOrnament(ornament.id).name])
                  });
               }
            }
         }
         else
         {
            maxSlots = 5;
            this.lbl_title.text = this.uiApi.getText("ui.common.rewards");
            this.lbl_newLevel.text = this.uiApi.getText("ui.levelUp.titleLevel",pParam.newLevel);
            rewards.push({
               "iconName":"heart_reward",
               "value":pParam.caracPointEarned
            },{
               "iconName":"characteristic_reward",
               "value":pParam.caracPointEarned,
               "callback":this.openStats
            },{
               "iconName":"bag_reward",
               "value":pParam.caracPointEarned
            });
            if(pParam.oldLevel < 100 && pParam.newLevel >= 100)
            {
               rewards.push({
                  "iconName":"star_reward",
                  "value":1
               },{
                  "iconName":"aura_reward",
                  "value":1,
                  "text":this.dataApi.getEmoticon(22).name
               });
            }
            if(pParam.spellObtained && !this.configApi.isFeatureWithKeywordEnabled("character.spell.forgettable"))
            {
               spellWrapper = pParam.newSpellWrappers[0];
               maxSpellLevel = this.dataApi.getSpellLevel(pParam.newSpellWrappers[0].spell.spellLevels[pParam.newSpellWrappers[0].spellLevel - 1]).minPlayerLevel;
               for(i = 1; i < pParam.newSpellWrappers.length; i++)
               {
                  sw = pParam.newSpellWrappers[i];
                  spellLevel = this.dataApi.getSpellLevel(sw.spell.spellLevels[sw.spellLevel - 1]);
                  if(spellLevel.minPlayerLevel > maxSpellLevel)
                  {
                     maxSpellLevel = spellLevel.minPlayerLevel;
                     spellWrapper = sw;
                  }
               }
               this.spellSlot.allowDrag = false;
               this.spellSlot.data = spellWrapper;
               if(spellWrapper.spellLevel == 1 && pParam.oldLevel < maxSpellLevel)
               {
                  this.lbl_title.text = this.uiApi.getText("ui.levelUp.spellObtained");
                  spellName = spellWrapper.spell.name;
                  showGod = true;
                  this.ed_player.visible = this.tx_player_bg.visible = false;
               }
               else
               {
                  this.lbl_title.text = this.uiApi.getText("ui.levelUp.spellUpgraded");
                  spellName = spellWrapper.spell.name + " (" + this.uiApi.getText("ui.common.rank",[spellWrapper.spellLevel.toString()]) + ")";
               }
               this.lbl_spell.text = "{openBook,spellBase,," + StrataEnum.STRATA_MAX + ",true::" + spellName + "}";
            }
         }
         var numRewards:uint = rewards.length;
         if(numRewards > maxSlots)
         {
            numRewards = maxSlots;
            this.gd_rewards.ignoreConfigVar = true;
            this.gd_rewards.slotByRow = maxSlots;
            this.gd_rewards.totalSlotByRow = rewards.length;
            this.gd_rewards.avaibleSpaceY = this.gd_rewards.height - 10;
            this.gd_rewards.scrollBarHYOffset = 30;
            this.gd_rewards.scrollBarHXOffset = -4;
         }
         var gridWidth:Number = numRewards * this.gd_rewards.slotWidth + numRewards * this.gd_rewards.hPadding;
         this.gd_rewards.avaibleSpaceX = gridWidth;
         this.gd_rewards.width = gridWidth;
         this.uiApi.me().processLocation(this.uiApi.me().getElementById("gd_rewards"));
         this.gd_rewards.dataProvider = rewards;
         if(showGod)
         {
            this.uiApi.loadUi("levelUpGod","levelUpGod",{"breed":this.playerApi.getPlayedCharacterInfo().breed},StrataEnum.STRATA_MAX);
         }
      }
      
      public function updateReward(data:*, componentsRef:*, selected:Boolean) : void
      {
         var plus:Bitmap = null;
         var startX:Number = NaN;
         var s:String = null;
         var numChars:int = 0;
         var i:int = 0;
         var numberBitmap:Bitmap = null;
         if(data)
         {
            componentsRef.tx_icon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("levelUp") + data.iconName + ".png");
            while(componentsRef.tx_plus.numChildren)
            {
               componentsRef.tx_plus.removeChildAt(0);
            }
            plus = new LevelUpAssets.plus() as Bitmap;
            plus.smoothing = true;
            componentsRef.tx_plus.addChild(plus);
            startX = plus.width - 5;
            s = data.value.toString();
            numChars = s.length;
            for(i = 0; i < numChars; i++)
            {
               numberBitmap = new LevelUpAssets["number_" + s.charAt(i)]() as Bitmap;
               numberBitmap.smoothing = true;
               numberBitmap.x = startX;
               componentsRef.tx_plus.addChild(numberBitmap);
               startX += numberBitmap.width - 3;
            }
            componentsRef.btn_action.visible = data.hasOwnProperty("callback") && !this.playerApi.isInTutorialArea();
         }
      }
      
      public function unload() : void
      {
         if(this.uiApi.getUi("levelUpGod"))
         {
            this.uiApi.unloadUi("levelUpGod");
         }
         var activeFightResultUi:* = !!this.uiApi.getUi("fightResult") ? this.uiApi.getUi("fightResult") : this.uiApi.getUi("fightResultSimple");
         if(activeFightResultUi)
         {
            activeFightResultUi.visible = true;
         }
         if(this.uiApi.getUi("statBoost"))
         {
            this.uiApi.setUiStrata("statBoost",StrataEnum.STRATA_MEDIUM);
         }
         if(this.uiApi.getUi("characterSheetUi"))
         {
            this.uiApi.setUiStrata("characterSheetUi",StrataEnum.STRATA_MEDIUM);
            if(this.playerApi.isInTutorialArea())
            {
               this.sysApi.dispatchHook(BeriliaHookList.CloseLevelUpUiTutorial);
            }
         }
         if(this.configApi.isFeatureWithKeywordEnabled("character.spell.forgettable"))
         {
            if(this.uiApi.getUi(UIEnum.FORGETTABLE_SPELLS_UI))
            {
               this.uiApi.setUiStrata(UIEnum.FORGETTABLE_SPELLS_UI,StrataEnum.STRATA_MEDIUM);
            }
         }
         else if(this.uiApi.getUi("spellBase"))
         {
            this.uiApi.setUiStrata("spellBase",StrataEnum.STRATA_MEDIUM);
         }
         if(this.uiApi.getUi("characterBuildsUi"))
         {
            this.uiApi.setUiStrata("characterBuildsUi",StrataEnum.STRATA_MEDIUM);
         }
      }
      
      private function openStats() : void
      {
         if(this.uiApi.getUi("characterSheetUi"))
         {
            this.uiApi.setUiStrata("characterSheetUi",StrataEnum.STRATA_MAX);
         }
         else
         {
            this.sysApi.dispatchHook(HookList.OpenStats,this.inventoryApi.getEquipement(),StrataEnum.STRATA_MAX);
         }
         if(this.playerApi.isInTutorialArea())
         {
            this.sysApi.dispatchHook(BeriliaHookList.LevelUpStatsTutorial);
         }
      }
      
      public function onUiLoaded(name:String) : void
      {
         var playerInfos:Object = null;
         var playerLook:Object = null;
         if(this.uiApi.me().name == name)
         {
            playerInfos = this.playerApi.getPlayedCharacterInfo();
            if(this.ed_player)
            {
               playerLook = playerInfos.entityLook;
               this.ed_player.animation = "AnimEmoteLevelup_" + playerLook.firstSkin;
               this.ed_player.centerPos = this.tx_player_bg.parent.localToGlobal(new Point(this.tx_player_bg.x + this.tx_player_bg.width / 2 + 7,this.tx_player_bg.y + this.tx_player_bg.height - 75));
               this.ed_player.look = playerLook;
            }
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         if(target.name.indexOf("btn_action") != -1)
         {
            this.gd_rewards.dataProvider[(this.gd_rewards.renderer as InlineXmlGridRenderer).getItemIndex(target)].callback();
         }
         else
         {
            switch(target)
            {
               case this.btn_close_main:
                  this.uiApi.unloadUi(this.uiApi.me().name);
            }
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var txt:String = null;
         var spellTS:SpellTooltipSettings = null;
         var data:Object = null;
         if(target == this.spellSlot && this.spellSlot.data)
         {
            spellTS = this.sysApi.getData("spellTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as SpellTooltipSettings;
            if(spellTS == null)
            {
               spellTS = this.tooltipApi.createSpellSettings();
               this.sysApi.setData("spellTooltipSettings",spellTS,DataStoreEnum.BIND_ACCOUNT);
            }
            spellTS.footer = true;
            spellTS.footerText = "";
            this.uiApi.showTooltip(this.spellSlot.data,this.spellSlot,false,"standard",3,3,0,null,null,spellTS,null,false,StrataEnum.STRATA_SUPERMAX);
         }
         else if(target.name.indexOf("tx_icon") != -1)
         {
            data = this.gd_rewards.dataProvider[(this.gd_rewards.renderer as InlineXmlGridRenderer).getItemIndex(target)];
            if(data && data.text)
            {
               txt = data.text;
            }
            else if((target as TextureBase).uri.fileName.indexOf("heart_reward") != -1)
            {
               txt = this.uiApi.getText("ui.levelUp.tooltip.lifePoints");
            }
            else if((target as TextureBase).uri.fileName.indexOf("characteristic_reward") != -1)
            {
               txt = this.uiApi.getText("ui.levelUp.caracPoints");
            }
            else if((target as TextureBase).uri.fileName.indexOf("bag_reward") != -1)
            {
               txt = this.uiApi.getText("ui.common.weight");
            }
            else if((target as TextureBase).uri.fileName.indexOf("star_reward") != -1)
            {
               txt = this.uiApi.getText("ui.stats.actionPoints");
            }
         }
         else if(target.name.indexOf("btn_action") != -1)
         {
            txt = this.uiApi.getText("ui.levelUp.tooltip.caracPoints");
         }
         if(txt)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(txt),target,false,"standard",7,1,3,null,null,null,"TextInfo",false,StrataEnum.STRATA_SUPERMAX);
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "validUi":
            case "closeUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
   }
}
