package Ankama_Tooltips.makers
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blockParams.EffectsTooltipBlockParameters;
   import Ankama_Tooltips.blocks.EffectsTooltipBlock;
   import Ankama_Tooltips.blocks.TextTooltipBlock;
   import com.ankamagames.berilia.interfaces.ITooltipMaker;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   
   public class EffectsListTooltipMaker implements ITooltipMaker
   {
       
      
      public function EffectsListTooltipMaker()
      {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Tooltip
      {
         var bg:String = null;
         var category:String = null;
         var text:String = null;
         var buffArray:Object = null;
         var eiArray:Array = null;
         var buff:Object = null;
         var effectsTooltipBlockParams:EffectsTooltipBlockParameters = null;
         if(param && param.noBg)
         {
            bg = "chunks/base/base.txt";
         }
         else
         {
            bg = "chunks/base/baseWithBackground.txt";
         }
         var tooltip:Tooltip = Api.tooltip.createTooltip(bg,"chunks/base/container.txt","chunks/base/separator.txt");
         var effects:Object = data;
         for each(category in effects.categories)
         {
            switch(int(category))
            {
               case 0:
                  text = Api.ui.getText("ui.fight.activeBonus");
                  break;
               case 1:
                  text = Api.ui.getText("ui.fight.activeMalus");
                  break;
               case 2:
                  text = Api.ui.getText("ui.fight.passiveBonus");
                  break;
               case 3:
                  text = Api.ui.getText("ui.fight.passiveMalus");
                  break;
               case 4:
                  text = Api.ui.getText("ui.fight.triggeredEffects");
                  break;
               case 5:
                  text = Api.ui.getText("ui.fight.states");
                  break;
               case 6:
                  text = Api.ui.getText("ui.fight.others");
                  break;
            }
            tooltip.addBlock(new TextTooltipBlock(text + Api.ui.getText("ui.common.colon"),{"css":"[local.css]tooltip_title.css"}).block);
            buffArray = effects.buffArray;
            eiArray = [];
            for each(buff in buffArray[category])
            {
               eiArray.push(buff.effect);
            }
            effectsTooltipBlockParams = EffectsTooltipBlockParameters.create(eiArray);
            effectsTooltipBlockParams.showLabel = false;
            effectsTooltipBlockParams.showDuration = false;
            tooltip.addBlock(new EffectsTooltipBlock(effectsTooltipBlockParams).block);
         }
         return tooltip;
      }
   }
}
