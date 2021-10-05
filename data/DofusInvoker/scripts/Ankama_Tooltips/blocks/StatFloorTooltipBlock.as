package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class StatFloorTooltipBlock extends AbstractTooltipBlock
   {
       
      
      private var _floor:uint;
      
      private var _statInterval:String;
      
      private var _statCost:String;
      
      public function StatFloorTooltipBlock(pFloor:uint, pStatInterval:String, pStatCost:String)
      {
         super();
         this._floor = pFloor;
         this._statInterval = pStatInterval;
         this._statCost = pStatCost;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("content","chunks/stats/statFloor.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("content").processContent({
            "floor":this._floor,
            "statInterval":this._statInterval,
            "statCost":this._statCost
         });
      }
   }
}
