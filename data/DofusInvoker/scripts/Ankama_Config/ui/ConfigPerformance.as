package Ankama_Config.ui
{
   import Ankama_Common.Common;
   import Ankama_Config.types.ConfigProperty;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.uiApi.BindsApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   
   public class ConfigPerformance extends ConfigUi
   {
      
      private static const LOW_CACHE_SIZE:uint = 50;
      
      private static const MEDIUM_CACHE_SIZE:uint = 100;
      
      private static const HIGH_CACHE_SIZE:uint = 150;
      
      private static const VERYHIGH_CACHE_SIZE:uint = 200;
       
      
      [Api(name="BindsApi")]
      public var bindsApi:BindsApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var LOW_TEXT:String;
      
      private var MEDIUM_TEXT:String;
      
      private var HIGH_TEXT:String;
      
      private var VERYHIGH_TEXT:String;
      
      private var _lastSelectedIndex:int;
      
      private var qualitiesName:Array;
      
      private var qualityBtns:Array;
      
      private var pointsDisplayType:Array;
      
      private var _creatureLimits:Array;
      
      private var _auraChoices:Array;
      
      private var _infinityText:String;
      
      private var _popupName:String;
      
      private var _animationsInCacheLimits:Array;
      
      public var btn_left:ButtonContainer;
      
      public var btn_right:ButtonContainer;
      
      public var btn_quality0:ButtonContainer;
      
      public var btn_quality1:ButtonContainer;
      
      public var btn_quality2:ButtonContainer;
      
      public var btn_quality3:ButtonContainer;
      
      public var btn_showAllMonsters:ButtonContainer;
      
      public var btn_allowAnimsFun:ButtonContainer;
      
      public var btn_allowUiShadows:ButtonContainer;
      
      public var btn_allowUiAnimations:ButtonContainer;
      
      public var btn_allowAnimatedGfx:ButtonContainer;
      
      public var btn_allowParticlesFx:ButtonContainer;
      
      public var btn_allowSpellEffects:ButtonContainer;
      
      public var btn_allowHitAnim:ButtonContainer;
      
      public var btn_showFinishMoves:ButtonContainer;
      
      public var btn_optimizeMultiAccount:ButtonContainer;
      
      public var btn_fullScreen:ButtonContainer;
      
      public var btn_useLDSkin:ButtonContainer;
      
      public var cb_creatures:ComboBox;
      
      public var cb_flashQuality:ComboBox;
      
      public var cb_auras:ComboBox;
      
      public var cb_pointsOverHead:ComboBox;
      
      public var btn_groundCacheEnabled:ButtonContainer;
      
      public var btn_groundCacheQuality1:ButtonContainer;
      
      public var btn_groundCacheQuality2:ButtonContainer;
      
      public var btn_groundCacheQuality3:ButtonContainer;
      
      public var lbl_diskUsed:Label;
      
      public var btn_clearGroundCache:ButtonContainer;
      
      public var lbl_showPointsOverhead:Label;
      
      public var btn_showTurnPicture:ButtonContainer;
      
      public var btn_showAuraOnFront:ButtonContainer;
      
      public var btn_forceRenderCPU:ButtonContainer;
      
      public var btn_useAnimationCache:ButtonContainer;
      
      public var cb_animationsInCache:ComboBox;
      
      public var btn_useWorldEntityPool:ButtonContainer;
      
      public function ConfigPerformance()
      {
         super();
      }
      
      public function main(args:*) : void
      {
         this.btn_left.soundId = SoundEnum.SCROLL_DOWN;
         this.btn_right.soundId = SoundEnum.SCROLL_UP;
         this.btn_quality0.soundId = SoundEnum.SPEC_BUTTON;
         this.btn_quality1.soundId = SoundEnum.SPEC_BUTTON;
         this.btn_quality2.soundId = SoundEnum.SPEC_BUTTON;
         this.btn_quality3.soundId = SoundEnum.SPEC_BUTTON;
         var properties:Array = [];
         properties.push(new ConfigProperty("cb_flashQuality","flashQuality","dofus"));
         properties.push(new ConfigProperty("cb_creatures","creaturesMode","tiphon"));
         properties.push(new ConfigProperty("btn_showAllMonsters","showEveryMonsters","dofus"));
         properties.push(new ConfigProperty("btn_allowAnimsFun","allowAnimsFun","dofus"));
         properties.push(new ConfigProperty("btn_allowUiShadows","uiShadows","berilia"));
         properties.push(new ConfigProperty("btn_allowUiAnimations","uiAnimations","berilia"));
         properties.push(new ConfigProperty("btn_allowAnimatedGfx","allowAnimatedGfx","atouin"));
         properties.push(new ConfigProperty("btn_allowParticlesFx","allowParticlesFx","atouin"));
         properties.push(new ConfigProperty("btn_allowSpellEffects","allowSpellEffects","dofus"));
         properties.push(new ConfigProperty("btn_allowHitAnim","allowHitAnim","dofus"));
         properties.push(new ConfigProperty("","dofusQuality","dofus"));
         properties.push(new ConfigProperty("btn_groundCacheEnabled","groundCacheMode","atouin"));
         properties.push(new ConfigProperty("btn_showPointsOverhead","pointsOverhead","tiphon"));
         properties.push(new ConfigProperty("btn_showTurnPicture","turnPicture","dofus"));
         properties.push(new ConfigProperty("cb_auras","auraMode","tiphon"));
         properties.push(new ConfigProperty("btn_forceRenderCPU","forceRenderCPU","dofus"));
         properties.push(new ConfigProperty("btn_showAuraOnFront","alwaysShowAuraOnFront","tiphon"));
         properties.push(new ConfigProperty("btn_optimizeMultiAccount","optimizeMultiAccount","dofus"));
         properties.push(new ConfigProperty("btn_fullScreen","fullScreen","dofus"));
         properties.push(new ConfigProperty("btn_useLDSkin","useLowDefSkin","atouin"));
         properties.push(new ConfigProperty("btn_showFinishMoves","showFinishMoves","dofus"));
         properties.push(new ConfigProperty("btn_useAnimationCache","useAnimationCache","tiphon"));
         properties.push(new ConfigProperty("cb_animationsInCache","animationsInCache","tiphon"));
         properties.push(new ConfigProperty("btn_useWorldEntityPool","useWorldEntityPool","atouin"));
         init(properties);
         uiApi.addComponentHook(this.btn_quality0,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_quality0,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btn_quality0,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btn_quality0,ComponentHookList.ON_MOUSE_UP);
         uiApi.addComponentHook(this.btn_quality1,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_quality1,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btn_quality1,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btn_quality1,ComponentHookList.ON_MOUSE_UP);
         uiApi.addComponentHook(this.btn_quality2,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_quality2,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btn_quality2,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btn_quality2,ComponentHookList.ON_MOUSE_UP);
         uiApi.addComponentHook(this.btn_quality3,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_quality3,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btn_quality3,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btn_quality3,ComponentHookList.ON_MOUSE_UP);
         uiApi.addComponentHook(this.btn_groundCacheEnabled,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btn_groundCacheEnabled,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btn_groundCacheQuality1,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btn_groundCacheQuality1,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btn_groundCacheQuality2,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btn_groundCacheQuality2,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btn_groundCacheQuality3,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btn_groundCacheQuality3,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btn_left,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_right,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_showAllMonsters,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_allowAnimsFun,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_allowUiShadows,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_allowUiAnimations,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_allowAnimatedGfx,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_allowParticlesFx,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_allowSpellEffects,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_allowHitAnim,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_showFinishMoves,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_groundCacheEnabled,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_groundCacheQuality1,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_groundCacheQuality2,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_groundCacheQuality3,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.lbl_showPointsOverhead,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.lbl_showPointsOverhead,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btn_showAllMonsters,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btn_showAllMonsters,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btn_forceRenderCPU,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btn_forceRenderCPU,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btn_showAuraOnFront,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btn_showAuraOnFront,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btn_showTurnPicture,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_showTurnPicture,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btn_showTurnPicture,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btn_optimizeMultiAccount,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_optimizeMultiAccount,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btn_optimizeMultiAccount,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btn_fullScreen,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_useLDSkin,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_useAnimationCache,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.btn_useAnimationCache,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.btn_useAnimationCache,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.btn_useWorldEntityPool,ComponentHookList.ON_RELEASE);
         sysApi.addHook(HookList.GameFightJoin,this.onGameFightJoin);
         sysApi.addHook(HookList.GameFightEnd,this.onGameFightEnd);
         if(sysApi.getOs() == "Linux" || this.playerApi.isInFight())
         {
            this.btn_forceRenderCPU.softDisabled = true;
         }
         this._infinityText = uiApi.getText("ui.common.infinit");
         this.qualityBtns = [this.btn_quality0,this.btn_quality1,this.btn_quality2,this.btn_quality3];
         this.qualitiesName = new Array(uiApi.getText("ui.common.none"),"2x","4x");
         this.cb_flashQuality.dataProvider = this.qualitiesName;
         this.cb_flashQuality.value = !!sysApi.setQualityIsEnable() ? this.qualitiesName[sysApi.getOption("flashQuality","dofus")] : this.qualitiesName[2];
         this.cb_flashQuality.disabled = !sysApi.setQualityIsEnable();
         this.cb_flashQuality.dataNameField = "";
         this._creatureLimits = ["0","10","20","40",this._infinityText];
         this.cb_creatures.dataProvider = this._creatureLimits;
         var index:int = this._creatureLimits.indexOf(sysApi.getOption("creaturesMode","tiphon").toString());
         if(index == -1)
         {
            index = 4;
         }
         this.cb_creatures.selectedIndex = index;
         this.cb_creatures.dataNameField = "";
         this._auraChoices = [uiApi.getText("ui.option.aura.none"),uiApi.getText("ui.option.aura.rollover"),uiApi.getText("ui.option.aura.cycle"),uiApi.getText("ui.option.aura.all")];
         this.cb_auras.dataProvider = this._auraChoices;
         index = sysApi.getOption("auraMode","tiphon");
         this.cb_auras.value = this._auraChoices[index];
         this.cb_auras.dataNameField = "";
         this.pointsDisplayType = [uiApi.getText("ui.option.pointsOverHead.none"),uiApi.getText("ui.option.pointsOverHead.normal"),uiApi.getText("ui.option.pointsOverHead.cartoon")];
         this.cb_pointsOverHead.dataProvider = this.pointsDisplayType;
         var indexp:uint = sysApi.getOption("pointsOverhead","tiphon");
         this.cb_pointsOverHead.value = this.pointsDisplayType[indexp];
         this.cb_pointsOverHead.dataNameField = "";
         this.LOW_TEXT = uiApi.getText("ui.option.quality.low");
         this.MEDIUM_TEXT = uiApi.getText("ui.option.quality.medium");
         this.HIGH_TEXT = uiApi.getText("ui.option.high");
         this.VERYHIGH_TEXT = uiApi.getText("ui.option.veryhigh");
         this._animationsInCacheLimits = [this.LOW_TEXT,this.MEDIUM_TEXT,this.HIGH_TEXT,this.VERYHIGH_TEXT];
         this.cb_animationsInCache.dataProvider = this._animationsInCacheLimits;
         var cacheValue:int = sysApi.getOption("animationsInCache","tiphon");
         if(cacheValue == LOW_CACHE_SIZE)
         {
            index = 0;
         }
         else if(cacheValue == MEDIUM_CACHE_SIZE)
         {
            index = 1;
         }
         else if(cacheValue == HIGH_CACHE_SIZE)
         {
            index = 2;
         }
         else
         {
            index = 3;
         }
         this.cb_animationsInCache.selectedIndex = index;
         this.cb_animationsInCache.dataNameField = this._animationsInCacheLimits[index];
         var quality:uint = sysApi.getOption("dofusQuality","dofus");
         this.qualityBtns[quality].selected = true;
         this.selectQualityMode(quality);
         var currentValue:int = sysApi.getOption("groundCacheMode","atouin");
         this.updateGroundCacheOption(currentValue);
         var value:Number = sysApi.getGroundCacheSize();
         value /= 1048576;
         this.lbl_diskUsed.text = uiApi.getText("ui.option.performance.groundCacheSize",int(value * 100) / 100);
      }
      
      override public function reset() : void
      {
         super.reset();
         this.selectQualityMode(1);
         this.btn_quality1.selected = true;
      }
      
      public function unload() : void
      {
         if(this._popupName != null && uiApi.getUi(this._popupName))
         {
            uiApi.unloadUi(this._popupName);
         }
      }
      
      private function updateGroundCacheOption(value:int) : void
      {
         this.btn_groundCacheQuality1.selected = false;
         this.btn_groundCacheQuality2.selected = false;
         this.btn_groundCacheQuality3.selected = false;
         if(value == 0)
         {
            this.btn_groundCacheEnabled.selected = false;
            this.btn_groundCacheQuality1.disabled = true;
            this.btn_groundCacheQuality2.disabled = true;
            this.btn_groundCacheQuality3.disabled = true;
         }
         else
         {
            this.btn_groundCacheEnabled.selected = true;
            this.btn_groundCacheQuality1.disabled = false;
            this.btn_groundCacheQuality2.disabled = false;
            this.btn_groundCacheQuality3.disabled = false;
            this["btn_groundCacheQuality" + value].selected = true;
         }
      }
      
      private function selectQualityMode(mode:uint) : void
      {
         setProperty("dofus","dofusQuality",mode);
         if(mode == 0)
         {
            if(sysApi.setQualityIsEnable())
            {
               this.cb_flashQuality.value = this.qualitiesName[0];
            }
            this.cb_creatures.selectedIndex = 1;
            setProperty("dofus","showEveryMonsters",false);
            setProperty("dofus","allowAnimsFun",false);
            setProperty("atouin","useLowDefSkin",true);
            this.cb_auras.value = this._auraChoices[0];
            setProperty("tiphon","alwaysShowAuraOnFront",false);
            setProperty("dofus","forceRenderCPU",true);
            setProperty("berilia","uiShadows",false);
            setProperty("berilia","uiAnimations",false);
            setProperty("tubul","allowSoundEffects",false);
            this.cb_pointsOverHead.value = this.pointsDisplayType[1];
            setProperty("dofus","turnPicture",false);
            setProperty("dofus","allowSpellEffects",sysApi.setQualityIsEnable());
            setProperty("dofus","allowHitAnim",sysApi.setQualityIsEnable());
            configApi.setConfigProperty("dofus","cacheMapEnabled",false);
            setProperty("atouin","allowAnimatedGfx",false);
            setProperty("atouin","allowParticlesFx",false);
            setProperty("atouin","groundCacheMode",3);
            this.updateGroundCacheOption(3);
         }
         else if(mode == 1)
         {
            if(sysApi.setQualityIsEnable())
            {
               this.cb_flashQuality.value = this.qualitiesName[1];
            }
            this.cb_creatures.selectedIndex = 2;
            setProperty("atouin","useLowDefSkin",true);
            setProperty("dofus","showEveryMonsters",false);
            setProperty("dofus","allowAnimsFun",true);
            this.cb_auras.value = this._auraChoices[2];
            setProperty("tiphon","alwaysShowAuraOnFront",false);
            setProperty("dofus","forceRenderCPU",true);
            setProperty("berilia","uiShadows",false);
            setProperty("berilia","uiAnimations",true);
            setProperty("tubul","allowSoundEffects",true);
            this.cb_pointsOverHead.value = this.pointsDisplayType[1];
            setProperty("dofus","turnPicture",true);
            setProperty("dofus","allowSpellEffects",true);
            setProperty("dofus","allowHitAnim",true);
            configApi.setConfigProperty("dofus","cacheMapEnabled",true);
            setProperty("atouin","allowAnimatedGfx",false);
            setProperty("atouin","allowParticlesFx",true);
            setProperty("atouin","groundCacheMode",1);
            this.updateGroundCacheOption(1);
         }
         else if(mode == 2)
         {
            if(sysApi.setQualityIsEnable())
            {
               this.cb_flashQuality.value = this.qualitiesName[2];
            }
            this.cb_creatures.selectedIndex = 4;
            setProperty("atouin","useLowDefSkin",false);
            setProperty("dofus","showEveryMonsters",true);
            setProperty("dofus","allowAnimsFun",true);
            this.cb_auras.value = this._auraChoices[3];
            setProperty("tiphon","alwaysShowAuraOnFront",true);
            setProperty("dofus","forceRenderCPU",sysApi.getOs() == "Linux");
            setProperty("berilia","uiShadows",true);
            setProperty("berilia","uiAnimations",true);
            setProperty("tubul","allowSoundEffects",true);
            this.cb_pointsOverHead.value = this.pointsDisplayType[1];
            setProperty("dofus","turnPicture",true);
            setProperty("dofus","allowSpellEffects",true);
            setProperty("dofus","allowHitAnim",true);
            configApi.setConfigProperty("dofus","cacheMapEnabled",true);
            setProperty("atouin","allowAnimatedGfx",true);
            setProperty("atouin","allowParticlesFx",true);
            setProperty("atouin","groundCacheMode",1);
            this.updateGroundCacheOption(1);
         }
      }
      
      private function onConfirmClearGroundCache() : void
      {
         this._popupName = null;
         sysApi.clearGroundCache();
         this.lbl_diskUsed.text = uiApi.getText("ui.option.performance.groundCacheSize","0");
      }
      
      private function onCancelClearGroundCache() : void
      {
         this._popupName = null;
      }
      
      override public function onRelease(target:Object) : void
      {
         sysApi.log(8,"onRelease sur " + target + " : " + target.name);
         switch(target)
         {
            case this.btn_groundCacheEnabled:
               if(this.btn_groundCacheEnabled.selected)
               {
                  setProperty("atouin","groundCacheMode",1);
                  this.updateGroundCacheOption(1);
               }
               else
               {
                  setProperty("atouin","groundCacheMode",0);
                  this.updateGroundCacheOption(0);
               }
               this.btn_quality3.selected = true;
               this.selectQualityMode(3);
               break;
            case this.btn_groundCacheQuality1:
               setProperty("atouin","groundCacheMode",1);
               this.updateGroundCacheOption(1);
               this.btn_quality3.selected = true;
               this.selectQualityMode(3);
               break;
            case this.btn_groundCacheQuality2:
               setProperty("atouin","groundCacheMode",2);
               this.updateGroundCacheOption(2);
               this.btn_quality3.selected = true;
               this.selectQualityMode(3);
               break;
            case this.btn_groundCacheQuality3:
               setProperty("atouin","groundCacheMode",3);
               this.updateGroundCacheOption(3);
               this.btn_quality3.selected = true;
               this.selectQualityMode(3);
               break;
            case this.btn_clearGroundCache:
               if(this._popupName == null)
               {
                  this._popupName = this.modCommon.openPopup(uiApi.getText("ui.popup.warning"),uiApi.getText("ui.option.performance.confirmClearGroundCache"),[uiApi.getText("ui.common.yes"),uiApi.getText("ui.common.no")],[this.onConfirmClearGroundCache,this.onCancelClearGroundCache],this.onConfirmClearGroundCache,this.onCancelClearGroundCache);
               }
               break;
            case this.btn_left:
               if(this.btn_quality1.selected)
               {
                  this.selectQualityMode(0);
                  this.btn_quality0.selected = true;
               }
               else if(this.btn_quality2.selected)
               {
                  this.selectQualityMode(1);
                  this.btn_quality1.selected = true;
               }
               else if(this.btn_quality3.selected)
               {
                  this.selectQualityMode(2);
                  this.btn_quality2.selected = true;
               }
               break;
            case this.btn_right:
               if(this.btn_quality2.selected)
               {
                  this.selectQualityMode(3);
                  this.btn_quality3.selected = true;
               }
               else if(this.btn_quality1.selected)
               {
                  this.selectQualityMode(2);
                  this.btn_quality2.selected = true;
               }
               else if(this.btn_quality0.selected)
               {
                  this.selectQualityMode(1);
                  this.btn_quality1.selected = true;
               }
               break;
            case this.btn_quality0:
               this.selectQualityMode(0);
               break;
            case this.btn_quality1:
               this.selectQualityMode(1);
               break;
            case this.btn_quality2:
               this.selectQualityMode(2);
               break;
            case this.btn_quality3:
               this.selectQualityMode(3);
               break;
            case this.btn_useLDSkin:
               setProperty("atouin","useLowDefSkin",this.btn_useLDSkin.selected);
               this.btn_quality3.selected = true;
               this.selectQualityMode(3);
               break;
            case this.btn_showAllMonsters:
               setProperty("dofus","showEveryMonsters",this.btn_showAllMonsters.selected);
               this.btn_quality3.selected = true;
               this.selectQualityMode(3);
               break;
            case this.btn_allowAnimsFun:
               setProperty("dofus","allowAnimsFun",this.btn_allowAnimsFun.selected);
               this.btn_quality3.selected = true;
               this.selectQualityMode(3);
               break;
            case this.btn_allowAnimatedGfx:
               setProperty("atouin","allowAnimatedGfx",this.btn_allowAnimatedGfx.selected);
               this.btn_quality3.selected = true;
               this.selectQualityMode(3);
               break;
            case this.btn_allowParticlesFx:
               setProperty("atouin","allowParticlesFx",this.btn_allowParticlesFx.selected);
               this.btn_quality3.selected = true;
               this.selectQualityMode(3);
               break;
            case this.btn_allowSpellEffects:
               setProperty("dofus","allowSpellEffects",this.btn_allowSpellEffects.selected);
               this.btn_quality3.selected = true;
               this.selectQualityMode(3);
               break;
            case this.btn_allowHitAnim:
               setProperty("dofus","allowHitAnim",this.btn_allowHitAnim.selected);
               this.btn_quality3.selected = true;
               this.selectQualityMode(3);
               break;
            case this.btn_showFinishMoves:
               setProperty("dofus","showFinishMoves",this.btn_showFinishMoves.selected);
               this.btn_quality3.selected = true;
               this.selectQualityMode(3);
               break;
            case this.btn_allowUiShadows:
               setProperty("berilia","uiShadows",this.btn_allowUiShadows.selected);
               this.btn_quality3.selected = true;
               this.selectQualityMode(3);
               break;
            case this.btn_allowUiAnimations:
               setProperty("berilia","uiAnimations",this.btn_allowUiAnimations.selected);
               this.btn_quality3.selected = true;
               this.selectQualityMode(3);
               break;
            case this.btn_showTurnPicture:
               setProperty("dofus","turnPicture",this.btn_showTurnPicture.selected);
               this.btn_quality3.selected = true;
               this.selectQualityMode(3);
               break;
            case this.btn_showAuraOnFront:
               setProperty("tiphon","alwaysShowAuraOnFront",this.btn_showAuraOnFront.selected);
               this.btn_quality3.selected = true;
               this.selectQualityMode(3);
               break;
            case this.btn_forceRenderCPU:
               if(this._popupName == null)
               {
                  this._popupName = this.modCommon.openPopup(uiApi.getText("ui.popup.warning"),uiApi.getText("ui.popup.restartToApply"),[uiApi.getText("ui.common.ok"),uiApi.getText("ui.common.cancel")],[this.onForceRenderCPU,this.onPopupClose],this.onForceRenderCPU,this.onPopupClose);
               }
               break;
            case this.btn_optimizeMultiAccount:
               setProperty("dofus","optimizeMultiAccount",this.btn_optimizeMultiAccount.selected);
               break;
            case this.btn_fullScreen:
               setProperty("dofus","fullScreen",this.btn_fullScreen.selected);
               break;
            case this.btn_useAnimationCache:
               setProperty("tiphon","useAnimationCache",this.btn_useAnimationCache.selected);
               break;
            case this.btn_useWorldEntityPool:
               setProperty("atouin","useWorldEntityPool",this.btn_useWorldEntityPool.selected);
         }
      }
      
      private function onForceRenderCPU() : void
      {
         this._popupName = null;
         this.selectQualityMode(3);
         setProperty("dofus","forceRenderCPU",this.btn_forceRenderCPU.selected);
         this.btn_quality3.selected = true;
      }
      
      private function onPopupClose() : void
      {
         this._popupName = null;
         this.btn_forceRenderCPU.selected = !this.btn_forceRenderCPU.selected;
      }
      
      public function onMouseUp(target:GraphicContainer) : void
      {
         sysApi.log(8,"onMouseUp sur " + target + " : " + target.name);
         switch(target)
         {
            case this.btn_quality0:
               this.selectQualityMode(0);
               this.btn_quality0.selected = true;
               break;
            case this.btn_quality1:
               this.selectQualityMode(1);
               this.btn_quality1.selected = true;
               break;
            case this.btn_quality2:
               this.selectQualityMode(2);
               this.btn_quality2.selected = true;
               break;
            case this.btn_quality3:
               this.selectQualityMode(3);
               this.btn_quality3.selected = true;
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var currentValueInCache:int = 0;
         var limit:int = 0;
         var animationLimitText:String = null;
         var animationLimit:uint = 0;
         var propertyHadBeenChanged:Boolean = false;
         switch(target)
         {
            case this.cb_creatures:
               if(this._creatureLimits[this.cb_creatures.selectedIndex] == this._infinityText)
               {
                  limit = 100;
               }
               else
               {
                  limit = int(this._creatureLimits[this.cb_creatures.selectedIndex]);
               }
               currentValueInCache = configApi.getConfigProperty("tiphon","creaturesMode");
               if(currentValueInCache != limit)
               {
                  propertyHadBeenChanged = true;
               }
               setProperty("tiphon","creaturesMode",limit);
               break;
            case this.cb_pointsOverHead:
               currentValueInCache = configApi.getConfigProperty("tiphon","pointsOverhead");
               if(currentValueInCache != this.cb_pointsOverHead.selectedIndex)
               {
                  propertyHadBeenChanged = true;
               }
               setProperty("tiphon","pointsOverhead",this.cb_pointsOverHead.selectedIndex);
               break;
            case this.cb_flashQuality:
               currentValueInCache = configApi.getConfigProperty("dofus","flashQuality");
               if(currentValueInCache != this.cb_flashQuality.selectedIndex)
               {
                  propertyHadBeenChanged = true;
               }
               setProperty("dofus","flashQuality",this.cb_flashQuality.selectedIndex);
               break;
            case this.cb_auras:
               currentValueInCache = configApi.getConfigProperty("tiphon","auraMode");
               if(currentValueInCache != this.cb_auras.selectedIndex)
               {
                  propertyHadBeenChanged = true;
               }
               setProperty("tiphon","auraMode",this.cb_auras.selectedIndex);
               break;
            case this.cb_animationsInCache:
               animationLimitText = this._animationsInCacheLimits[this.cb_animationsInCache.selectedIndex];
               if(animationLimitText == this.LOW_TEXT)
               {
                  animationLimit = LOW_CACHE_SIZE;
               }
               else if(animationLimitText == this.MEDIUM_TEXT)
               {
                  animationLimit = MEDIUM_CACHE_SIZE;
               }
               else if(animationLimitText == this.HIGH_TEXT)
               {
                  animationLimit = HIGH_CACHE_SIZE;
               }
               else
               {
                  animationLimit = VERYHIGH_CACHE_SIZE;
               }
               currentValueInCache = configApi.getConfigProperty("tiphon","animationsInCache");
               if(currentValueInCache != animationLimit)
               {
                  propertyHadBeenChanged = true;
               }
               setProperty("tiphon","animationsInCache",animationLimit);
         }
         if(selectMethod != 2 && selectMethod != 7 && propertyHadBeenChanged)
         {
            this.btn_quality3.selected = true;
            this.selectQualityMode(3);
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var point:uint = 7;
         var relPoint:uint = 1;
         switch(target)
         {
            case this.btn_quality0:
               tooltipText = uiApi.getText("ui.option.quality.lowText");
               break;
            case this.btn_quality1:
               tooltipText = uiApi.getText("ui.option.quality.mediumText");
               break;
            case this.btn_quality2:
               tooltipText = uiApi.getText("ui.option.quality.highText");
               break;
            case this.btn_quality3:
               tooltipText = uiApi.getText("ui.option.quality.customText");
               break;
            case this.btn_groundCacheEnabled:
               point = 5;
               relPoint = 3;
               tooltipText = uiApi.getText("ui.option.performance.groundCacheTooltip");
               break;
            case this.btn_groundCacheQuality1:
               point = 5;
               relPoint = 3;
               tooltipText = uiApi.getText("ui.option.performance.groundCacheTooltipHigh");
               break;
            case this.btn_groundCacheQuality2:
               point = 5;
               relPoint = 3;
               tooltipText = uiApi.getText("ui.option.performance.groundCacheTooltipMedium");
               break;
            case this.btn_groundCacheQuality3:
               point = 5;
               relPoint = 3;
               tooltipText = uiApi.getText("ui.option.performance.groundCacheTooltipLow");
               break;
            case this.lbl_showPointsOverhead:
               point = 5;
               relPoint = 3;
               tooltipText = uiApi.getText("ui.option.overHeadInfoTooltip");
               break;
            case this.btn_showTurnPicture:
               point = 5;
               relPoint = 3;
               tooltipText = uiApi.getText("ui.option.showTurnPictureTooltip");
               break;
            case this.btn_showAuraOnFront:
               point = 5;
               relPoint = 3;
               tooltipText = uiApi.getText("ui.option.showAuraOnFrontTooltip");
               break;
            case this.btn_forceRenderCPU:
               point = 5;
               relPoint = 3;
               tooltipText = uiApi.getText("ui.option.forceRenderCPUTooltip");
               break;
            case this.btn_optimizeMultiAccount:
               point = 5;
               relPoint = 3;
               tooltipText = uiApi.getText("ui.config.optimizeMultiAccountInfo");
               break;
            case this.btn_showAllMonsters:
               tooltipText = uiApi.getText("ui.option.creaturesTooltip");
               break;
            case this.btn_useAnimationCache:
               tooltipText = uiApi.getText("ui.option.warningUseAnimationCache");
         }
         uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         uiApi.hideTooltip();
      }
      
      public function onGameFightJoin(... args) : void
      {
         this.btn_forceRenderCPU.softDisabled = true;
      }
      
      public function onGameFightEnd(... args) : void
      {
         if(sysApi.getOs() != "Linux")
         {
            this.btn_forceRenderCPU.softDisabled = false;
         }
      }
   }
}
