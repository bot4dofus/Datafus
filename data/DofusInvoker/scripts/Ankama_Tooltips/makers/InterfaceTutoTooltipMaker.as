package Ankama_Tooltips.makers
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blocks.InterfaceTutoTooltipBlock;
   import com.ankamagames.berilia.interfaces.ITooltipMaker;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   
   public class InterfaceTutoTooltipMaker implements ITooltipMaker
   {
       
      
      public function InterfaceTutoTooltipMaker()
      {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Tooltip
      {
         var tooltip:Tooltip = Api.tooltip.createTooltip("chunks/base/baseWithButton.txt","chunks/base/container.txt","chunks/base/empty.txt");
         tooltip.addBlock(new InterfaceTutoTooltipBlock(data).block);
         return tooltip;
      }
   }
}
