package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   import com.ankamagames.dofus.datacenter.spells.SpellPair;
   
   public class SpellPairHeaderBlock extends AbstractTooltipBlock
   {
       
      
      private var _spellPair:SpellPair;
      
      private var _subtitle:String = null;
      
      public function SpellPairHeaderBlock(spellPair:SpellPair, subtitle:String = null)
      {
         super();
         this._spellPair = spellPair;
         this._subtitle = subtitle;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         if(!this._subtitle)
         {
            _block.initChunk([Api.tooltip.createChunkData("header","htmlChunks/text/content.txt")]);
         }
         else
         {
            _block.initChunk([Api.tooltip.createChunkData("header","htmlChunks/text/titleWithSubtitle.txt")]);
         }
      }
      
      public function onAllChunkLoaded() : void
      {
         var content:String = this._spellPair.name;
         if(Api.system.getPlayerManager().hasRights)
         {
            content += " (" + this._spellPair.id + ")";
         }
         if(!this._subtitle)
         {
            _content += _block.getChunk("header").processContent({
               "classCss":"spellpair",
               "content":content
            });
         }
         else
         {
            _content += _block.getChunk("header").processContent({
               "classCss1":"spellpair",
               "content1":content,
               "classCss2":"subtitleheader",
               "content2":this._subtitle
            });
         }
      }
   }
}
