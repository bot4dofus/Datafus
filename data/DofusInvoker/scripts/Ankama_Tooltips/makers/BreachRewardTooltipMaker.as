package Ankama_Tooltips.makers
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blockParams.EffectsTooltipBlockParameters;
   import Ankama_Tooltips.blocks.BreachRewardBlock;
   import Ankama_Tooltips.blocks.BreachTitleTooltipBlock;
   import Ankama_Tooltips.blocks.ConditionTooltipBlock;
   import Ankama_Tooltips.blocks.DescriptionTooltipBlock;
   import Ankama_Tooltips.blocks.HtmlEffectsTooltipBlock;
   import Ankama_Tooltips.blocks.SeparatorTooltipBlock;
   import com.ankamagames.berilia.interfaces.ITooltipMaker;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   
   public class BreachRewardTooltipMaker implements ITooltipMaker
   {
      
      private static const chunkType:String = "htmlChunks";
      
      private static const NAME_EFFECTS_IDS:Array = [985,988];
       
      
      private var _effects:Array;
      
      public function BreachRewardTooltipMaker()
      {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Tooltip
      {
         var conditionBlock:ConditionTooltipBlock = null;
         var effect:EffectInstance = null;
         var effectsTooltipBlockParams:EffectsTooltipBlockParameters = null;
         var tooltip:Tooltip = Api.tooltip.createTooltip(chunkType + "/breach/baseWithBackground.txt",chunkType + "/base/container.txt");
         tooltip.chunkType = chunkType;
         tooltip.addBlock(new BreachTitleTooltipBlock(data.name).block);
         var hasDescription:Boolean = false;
         var hasCondition:Boolean = false;
         var hasEffects:Boolean = false;
         if(data.description != "")
         {
            hasDescription = true;
            tooltip.addBlock(new DescriptionTooltipBlock(data.description,"description",chunkType).block);
         }
         if(data.criterion && data.criterion.text != "")
         {
            conditionBlock = new ConditionTooltipBlock({"criteria":[data.criterion]},null,false,chunkType,"customli","theoretical");
            hasCondition = true;
         }
         var breachRewardBlock:BreachRewardBlock = new BreachRewardBlock(data.locks,param.isBudget,hasCondition);
         if(data.item && data.item.possibleEffects && data.item.possibleEffects.length > 0)
         {
            this._effects = [];
            for each(effect in data.item.possibleEffects)
            {
               this._effects.push(effect);
            }
            if(this._effects.length)
            {
               this._effects.sort(this.compareEffectsOrder);
               effectsTooltipBlockParams = EffectsTooltipBlockParameters.create(this._effects,chunkType);
               effectsTooltipBlockParams.showTheoreticalEffects = false;
               effectsTooltipBlockParams.customli = "customli";
               if(hasDescription)
               {
                  tooltip.addBlock(new SeparatorTooltipBlock(chunkType).block);
               }
               tooltip.addBlock(new HtmlEffectsTooltipBlock(effectsTooltipBlockParams).block);
               hasEffects = true;
            }
         }
         if((hasDescription || hasEffects) && (hasCondition || breachRewardBlock.checkForSubtitle()))
         {
            tooltip.addBlock(new SeparatorTooltipBlock(chunkType).block);
         }
         if(hasCondition)
         {
            tooltip.addBlock(conditionBlock.block);
         }
         tooltip.addBlock(breachRewardBlock.block);
         return tooltip;
      }
      
      private function compareEffectsOrder(effectA:EffectInstance, effectB:EffectInstance) : Number
      {
         var effectAIsNameEffect:* = NAME_EFFECTS_IDS.indexOf(effectA.effectId) != -1;
         var effectBIsNameEffect:* = NAME_EFFECTS_IDS.indexOf(effectB.effectId) != -1;
         if(!effectAIsNameEffect && effectBIsNameEffect)
         {
            return -1;
         }
         if(effectAIsNameEffect && !effectBIsNameEffect)
         {
            return 1;
         }
         return this._effects.indexOf(effectA) < this._effects.indexOf(effectB) ? Number(-1) : Number(1);
      }
   }
}
