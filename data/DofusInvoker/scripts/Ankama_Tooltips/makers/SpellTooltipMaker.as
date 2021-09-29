package Ankama_Tooltips.makers
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blockParams.EffectsTooltipBlockParameters;
   import Ankama_Tooltips.blocks.DescriptionTooltipBlock;
   import Ankama_Tooltips.blocks.HtmlEffectsTooltipBlock;
   import Ankama_Tooltips.blocks.SpellHeaderBlock;
   import Ankama_Tooltips.blocks.SpellPairHeaderBlock;
   import Ankama_Tooltips.blocks.TextTooltipBlock;
   import Ankama_Tooltips.blocks.TextWithTwoColumnsBlock;
   import com.ankamagames.berilia.interfaces.ITooltipMaker;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   import com.ankamagames.dofus.datacenter.spells.SpellPair;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.common.managers.FeatureManager;
   
   public class SpellTooltipMaker implements ITooltipMaker
   {
      
      private static const chunkType:String = "htmlChunks";
      
      public static var SPELL_TAB_MODE:Boolean;
       
      
      private var _param:paramClass;
      
      public function SpellTooltipMaker()
      {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Tooltip
      {
         var bg:* = null;
         var spellItem:Object = null;
         var effectsTooltipBlockParams:EffectsTooltipBlockParameters = null;
         var weapon:Object = null;
         this._param = new paramClass();
         SPELL_TAB_MODE = param && param.hasOwnProperty("spellTab") && param.spellTab;
         this._param.isTheoretical = Api.system.getOption("useTheoreticalValuesInSpellTooltips","dofus");
         if(param)
         {
            if(param.hasOwnProperty("isCharacterCreation"))
            {
               this._param.isCharacterCreation = param.isCharacterCreation;
               if(this._param.isCharacterCreation)
               {
                  this._param.isTheoretical = true;
               }
            }
            param.isTheoretical = this._param.isTheoretical;
            if(param.hasOwnProperty("noBg"))
            {
               this._param.noBg = param.noBg;
            }
            if(param.hasOwnProperty("description"))
            {
               this._param.description = param.description;
            }
            if(param.hasOwnProperty("smallSpell"))
            {
               this._param.smallSpell = param.smallSpell;
            }
            if(param.hasOwnProperty("name"))
            {
               this._param.name = param.name;
            }
            if(param.hasOwnProperty("header"))
            {
               this._param.header = param.header;
            }
            if(param.hasOwnProperty("contextual"))
            {
               this._param.contextual = param.contextual;
            }
            if(param.hasOwnProperty("shortcutKey"))
            {
               this._param.shortcutKey = param.shortcutKey;
            }
            if(param.hasOwnProperty("footer"))
            {
               this._param.footer = param.footer;
            }
            if(param.hasOwnProperty("subtitle"))
            {
               this._param.subtitle = param.subtitle;
            }
         }
         if(this._param.noBg)
         {
            bg = chunkType + "/spell/base";
         }
         else
         {
            bg = chunkType + "/spell/baseWithBackground";
         }
         if(this._param.name)
         {
            bg += ".txt";
         }
         else
         {
            bg += "NoIcon.txt";
         }
         var tooltip:Tooltip = Api.tooltip.createTooltip(bg,chunkType + "/base/container.txt",chunkType + "/base/separator.txt");
         tooltip.chunkType = chunkType;
         if(data is SpellWrapper)
         {
            spellItem = data.clone();
            spellItem.setSpellEffects(!this._param.isTheoretical);
         }
         else
         {
            spellItem = data;
         }
         if(spellItem is SpellWrapper && spellItem.isSpellWeapon)
         {
            weapon = Api.player.getWeapon();
            if(weapon)
            {
               return new ItemTooltipMaker().createTooltip(weapon,{
                  "noBg":this._param.noBg,
                  "header":this._param.name,
                  "conditions":true,
                  "description":this._param.description,
                  "shortcutKey":this._param.shortcutKey,
                  "isTheoretical":this._param.isTheoretical
               });
            }
         }
         if(this._param.header)
         {
            if(spellItem is SpellPair)
            {
               tooltip.addBlock(new SpellPairHeaderBlock(spellItem as SpellPair,this._param.subtitle).block);
            }
            else
            {
               tooltip.addBlock(new SpellHeaderBlock(spellItem,param,chunkType).block);
            }
         }
         if(this._param.description && spellItem.description)
         {
            tooltip.addBlock(new DescriptionTooltipBlock(spellItem.description,"description",chunkType).block);
         }
         if(spellItem is SpellPair)
         {
            return tooltip;
         }
         if(!spellItem.hideEffects && spellItem.effects.length)
         {
            effectsTooltipBlockParams = EffectsTooltipBlockParameters.create(spellItem.effects);
            effectsTooltipBlockParams.chunkType = chunkType;
            effectsTooltipBlockParams.splitDamageAndEffects = false;
            tooltip.addBlock(new HtmlEffectsTooltipBlock(effectsTooltipBlockParams).block);
         }
         if(!spellItem.hideEffects && spellItem.criticalEffect.length)
         {
            effectsTooltipBlockParams = EffectsTooltipBlockParameters.create(spellItem.criticalEffect);
            effectsTooltipBlockParams.isCriticalEffects = true;
            effectsTooltipBlockParams.splitDamageAndEffects = false;
            effectsTooltipBlockParams.chunkType = chunkType;
            tooltip.addBlock(new HtmlEffectsTooltipBlock(effectsTooltipBlockParams).block);
         }
         if(!SPELL_TAB_MODE && this._param.footer)
         {
            if(!this._param.isTheoretical || this._param.isCharacterCreation)
            {
               if(this._param.isCharacterCreation)
               {
                  if(param && (!param.hasOwnProperty("footerText") || param.footerText == null))
                  {
                     tooltip.addBlock(new TextTooltipBlock(Api.ui.getText("ui.tooltip.spell.tip"),{"classCss":"footerleft"},chunkType).block);
                  }
               }
               else
               {
                  tooltip.addBlock(new TextWithTwoColumnsBlock({
                     "leftCss":"footerleft",
                     "leftText":(param && param.footerText != null ? param.footerText : Api.ui.getText("ui.tooltip.spell.tip")),
                     "rightCss":"footerright",
                     "rightText":Api.ui.getText("ui.tooltip.spell.showTheoreticalValues")
                  },chunkType).block);
                  if(!FeatureManager.getInstance().isFeatureWithKeywordEnabled("character.spell.forgettable"))
                  {
                     tooltip.addBlock(new TextTooltipBlock(Api.ui.getText("ui.tooltip.spell.moveSpell"),{"classCss":"footerleft"},chunkType).block);
                  }
               }
            }
            else
            {
               tooltip.addBlock(new TextWithTwoColumnsBlock({
                  "leftCss":"footerleft",
                  "leftText":(param && param.footerText != null ? param.footerText : Api.ui.getText("ui.tooltip.spell.tip")),
                  "rightCss":"footerright",
                  "rightText":Api.ui.getText("ui.tooltip.spell.showEffectiveValues")
               },chunkType).block);
               if(!FeatureManager.getInstance().isFeatureWithKeywordEnabled("character.spell.forgettable"))
               {
                  tooltip.addBlock(new TextTooltipBlock(Api.ui.getText("ui.tooltip.spell.moveSpell"),{"classCss":"footerleft"},chunkType).block);
               }
            }
         }
         return tooltip;
      }
   }
}

class paramClass
{
    
   
   public var contextual:Boolean = false;
   
   public var name:Boolean = true;
   
   public var header:Boolean = true;
   
   public var footer:Boolean = true;
   
   public var description:Boolean = true;
   
   public var noBg:Boolean = false;
   
   public var smallSpell:Boolean = false;
   
   public var shortcutKey:String = "";
   
   public var subtitle:String = null;
   
   public var isTheoretical:Boolean = false;
   
   public var isCharacterCreation:Boolean = false;
   
   function paramClass()
   {
      super();
   }
}
