package Ankama_Tooltips.makers
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blocks.StatFloorTooltipBlock;
   import com.ankamagames.berilia.interfaces.ITooltipMaker;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   import com.ankamagames.berilia.types.tooltip.TooltipBlock;
   
   public class StatFloorsTooltipMaker implements ITooltipMaker
   {
       
      
      public function StatFloorsTooltipMaker()
      {
         super();
      }
      
      public function createTooltip(pData:*, param:Object) : Tooltip
      {
         var titleBlock:TooltipBlock = null;
         var titleContent:String = null;
         var floor:* = undefined;
         var tooltip:Tooltip = Api.tooltip.createTooltip("chunks/stats/baseWithBackground.txt","chunks/base/container.txt","chunks/base/separator.txt");
         titleBlock = Api.tooltip.createTooltipBlock(function():void
         {
            titleContent = titleBlock.getChunk("content").processContent({"statName":pData.statName});
         },function():String
         {
            return titleContent;
         });
         titleBlock.initChunk([Api.tooltip.createChunkData("content","chunks/stats/statFloorsTitle.txt")]);
         tooltip.addBlock(titleBlock);
         var numFloors:uint = pData.floors.length;
         for(var i:int = 0; i < numFloors; i++)
         {
            floor = pData.floors[i];
            tooltip.addBlock(new StatFloorTooltipBlock(i + 1,i + 1 == numFloors ? Api.ui.getText("ui.stats.floorStatMore",floor[0]) : Api.ui.getText("ui.stats.floorStatInterval",floor[0],pData.floors[i + 1][0]),Api.ui.processText(Api.ui.getText("ui.common.pointsWithValue",floor[1]),"",floor[1] == 1,floor[1] == 0)).block);
         }
         return tooltip;
      }
   }
}
