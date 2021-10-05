package Ankama_Tooltips.ui
{
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
   import com.ankamagames.dofus.logic.game.common.spell.SpellModifier;
   import com.ankamagames.dofus.logic.game.common.spell.SpellModifiers;
   import com.ankamagames.dofus.logic.game.fight.managers.SpellModifiersManager;
   import com.ankamagames.dofus.modules.utils.SpellTooltipSettings;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   
   public class SpellBannerTooltipUi extends TooltipPinableBaseUi
   {
      
      private static var _shortcutColor:String;
       
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      public var lbl_content:Label;
      
      private var _spellWrapper:Object;
      
      private var _shortcutKey:String;
      
      protected var _timerShowSpellTooltip:BenchmarkTimer;
      
      public function SpellBannerTooltipUi()
      {
         super();
      }
      
      override public function main(oParam:Object = null) : void
      {
         if(!_shortcutColor)
         {
            _shortcutColor = sysApi.getConfigEntry("colors.shortcut");
            _shortcutColor = _shortcutColor.replace("0x","#");
         }
         this._spellWrapper = oParam.data.spellWrapper;
         this._shortcutKey = oParam.data.shortcutKey;
         this.lbl_content.text = this._spellWrapper.name;
         if(this._shortcutKey && this._shortcutKey != "")
         {
            this.lbl_content.text += " <font color=\'" + _shortcutColor + "\'>(" + this._shortcutKey + ")</font>";
         }
         this.lbl_content.multiline = false;
         this.lbl_content.wordWrap = false;
         this.lbl_content.fullWidthAndHeight();
         backgroundCtr.width = this.lbl_content.textfield.width + 12;
         backgroundCtr.height = this.lbl_content.textfield.height + 12;
         this.tooltipApi.place(oParam.position,oParam.showDirectionalArrow,oParam.point,oParam.relativePoint,oParam.offset);
         var delay:int = sysApi.getOption("largeTooltipDelay","dofus");
         this._timerShowSpellTooltip = new BenchmarkTimer(delay,1,"SpellBannerTooltipUi._timerShowSpellTooltip");
         this._timerShowSpellTooltip.addEventListener(TimerEvent.TIMER,this.onTimer);
         this._timerShowSpellTooltip.start();
         super.main(oParam);
      }
      
      public function unload() : void
      {
         this.removeTimer();
      }
      
      protected function onTimer(e:TimerEvent) : void
      {
         var cacheCode:String = null;
         var setting:String = null;
         var ref:GraphicContainer = null;
         var weapon:WeaponWrapper = null;
         var spellModifiersDict:Dictionary = null;
         this.removeTimer();
         var criticalMiss:int = this._spellWrapper.playerCriticalFailureRate;
         if(this._spellWrapper.isSpellWeapon)
         {
            weapon = this.playerApi.getWeapon();
            if(weapon)
            {
               cacheCode = "SpellBanner-" + this._spellWrapper.id + "#" + this.tooltipApi.getSpellTooltipCache() + "," + this._shortcutKey + "," + this._spellWrapper.playerCriticalRate + "," + criticalMiss + "," + weapon.objectUID + "," + weapon.setCount + "," + this._spellWrapper.versionNum;
            }
            else
            {
               cacheCode = "SpellBanner-" + this._spellWrapper.id + "#-" + this._shortcutKey + "," + this._shortcutKey + "," + this._spellWrapper.playerCriticalRate + "," + criticalMiss + "," + this._spellWrapper.versionNum;
            }
         }
         else
         {
            cacheCode = "SpellBanner-" + this._spellWrapper.id + "," + this._spellWrapper.spellLevel + "#" + this.tooltipApi.getSpellTooltipCache() + "," + this._spellWrapper.playerCriticalRate + "," + this._spellWrapper.maximalRangeWithBoosts + "," + this._shortcutKey + "," + criticalMiss + "," + this._spellWrapper.versionNum;
         }
         var spellModifiersList:Vector.<SpellModifier> = null;
         var spellModifier:SpellModifier = null;
         var spellModifiers:SpellModifiers = SpellModifiersManager.getInstance().getSpellModifiers(this.playerApi.id(),this._spellWrapper.id);
         if(spellModifiersDict !== null)
         {
            spellModifiersDict = spellModifiers.modifiers;
            if(spellModifiersDict !== null)
            {
               spellModifiersList = new Vector.<SpellModifier>();
               for each(spellModifier in spellModifiersDict)
               {
                  spellModifiersList.push(spellModifier);
               }
            }
         }
         if(spellModifiersList !== null)
         {
            spellModifiersList.sort(function(spellModifierA:SpellModifier, spellModifierB:SpellModifier):Number
            {
               if(spellModifierA.id < spellModifierB.id)
               {
                  return -1;
               }
               if(spellModifierA.id > spellModifierB.id)
               {
                  return 1;
               }
               return 0;
            });
            for each(spellModifier in spellModifiersList)
            {
               cacheCode += "," + spellModifier.totalValue;
            }
         }
         if(sysApi.getOption("useTheoreticalValuesInSpellTooltips","dofus"))
         {
            cacheCode += ",useTheoreticalValuesInSpellTooltips";
         }
         var spellTS:SpellTooltipSettings = sysApi.getData("spellTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as SpellTooltipSettings;
         if(!spellTS)
         {
            spellTS = this.tooltipApi.createSpellSettings();
            sysApi.setData("spellTooltipSettings",spellTS,DataStoreEnum.BIND_ACCOUNT);
         }
         var settings:Object = {};
         for each(setting in sysApi.getObjectVariables(spellTS))
         {
            if(setting == "header")
            {
               settings["name"] = spellTS[setting];
            }
            else
            {
               settings[setting] = spellTS[setting];
            }
         }
         settings.smallSpell = true;
         settings.contextual = true;
         settings.noBg = false;
         settings.shortcutKey = this._shortcutKey;
         settings.isTheoretical = sysApi.getOption("useTheoreticalValuesInSpellTooltips","dofus");
         ref = uiApi.getUi(UIEnum.BANNER).getElement(!!sysApi.isFightContext() ? "tooltipFightPlacer" : "tooltipRoleplayPlacer");
         uiApi.showTooltip(this._spellWrapper,ref,false,"spellBanner",8,2,3,null,null,settings,cacheCode);
         uiApi.hideTooltip(uiApi.me().name);
      }
      
      private function removeTimer() : void
      {
         if(this._timerShowSpellTooltip)
         {
            this._timerShowSpellTooltip.removeEventListener(TimerEvent.TIMER,this.onTimer);
            this._timerShowSpellTooltip.stop();
            this._timerShowSpellTooltip = null;
         }
      }
   }
}
