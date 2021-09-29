package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class BreachRoomTooltipBlock extends AbstractTooltipBlock
   {
       
      
      private var _data:Object;
      
      public function BreachRoomTooltipBlock(data:*)
      {
         super();
         this._data = data;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("breachRoom","chunks/breach/breachRoom.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         _content = _block.getChunk("breachRoom").processContent(this._data);
      }
   }
}
