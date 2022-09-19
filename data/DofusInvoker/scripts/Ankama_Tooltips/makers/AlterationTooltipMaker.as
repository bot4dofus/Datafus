package Ankama_Tooltips.makers
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blockParams.EffectsTooltipBlockParameters;
   import Ankama_Tooltips.blocks.AlterationHeaderBlock;
   import Ankama_Tooltips.blocks.ConditionTooltipBlock;
   import Ankama_Tooltips.blocks.DescriptionTooltipBlock;
   import Ankama_Tooltips.blocks.HtmlEffectsTooltipBlock;
   import com.ankamagames.berilia.interfaces.ITooltipMaker;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.items.criterion.GroupItemCriterion;
   import com.ankamagames.dofus.internalDatacenter.alterations.AlterationWrapper;
   
   public class AlterationTooltipMaker implements ITooltipMaker
   {
      
      private static const chunkType:String = "htmlChunks";
      
      private static const NAME_EFFECTS_IDS:Array = [985,988];
       
      
      private var _alteration:AlterationWrapper;
      
      public function AlterationTooltipMaker()
      {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Tooltip
      {
         var effectsTooltipBlockParams:EffectsTooltipBlockParameters = null;
         this._alteration = data as AlterationWrapper;
         var _param:paramClass = new paramClass();
         var baseChunkFile:* = chunkType + "/alteration/baseWithBackground.txt";
         if(param)
         {
            if(param.hasOwnProperty("description"))
            {
               _param.description = param.description;
            }
            if(param.hasOwnProperty("effects"))
            {
               _param.effects = param.effects;
            }
            if(param.hasOwnProperty("conditions"))
            {
               _param.conditions = param.conditions;
            }
         }
         var tooltip:Tooltip = Api.tooltip.createTooltip(baseChunkFile,chunkType + "/base/container.txt",chunkType + "/base/separator.txt");
         tooltip.chunkType = chunkType;
         tooltip.addBlock(new AlterationHeaderBlock(this._alteration,_param,chunkType).block);
         if(this._alteration.effects.length && _param.effects)
         {
            this._alteration.effects.sort(this.compareEffectsOrder);
            effectsTooltipBlockParams = EffectsTooltipBlockParameters.create(this._alteration.effects,chunkType);
            effectsTooltipBlockParams.length = _param.length;
            effectsTooltipBlockParams.showTheoreticalEffects = false;
            effectsTooltipBlockParams.addTheoreticalEffects = false;
            effectsTooltipBlockParams.itemTheoreticalEffects = null;
            effectsTooltipBlockParams.showTimeLeftFormat = true;
            tooltip.addBlock(new HtmlEffectsTooltipBlock(effectsTooltipBlockParams).block);
         }
         var condition:GroupItemCriterion = this._alteration.data !== null ? this._alteration.data.conditions : null;
         if(condition !== null && condition.text && _param.conditions)
         {
            tooltip.addBlock(new ConditionTooltipBlock(condition,null,false,chunkType).block);
         }
         if(_param.description)
         {
            tooltip.addBlock(new DescriptionTooltipBlock(this._alteration.description,"quote",chunkType).block);
         }
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
         return this._alteration.effects.indexOf(effectA) < this._alteration.effects.indexOf(effectB) ? Number(-1) : Number(1);
      }
   }
}

class paramClass
{
    
   
   public var effects:Boolean = true;
   
   public var description:Boolean = true;
   
   public var conditions:Boolean = true;
   
   public var length:int = 409;
   
   function paramClass()
   {
      super();
   }
}
