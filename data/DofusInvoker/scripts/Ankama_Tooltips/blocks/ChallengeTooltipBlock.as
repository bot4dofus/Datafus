package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   
   public class ChallengeTooltipBlock extends AbstractTooltipBlock
   {
       
      
      private var _challenge:Object;
      
      public function ChallengeTooltipBlock(challenge:Object)
      {
         super();
         this._challenge = challenge;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData("header","chunks/challenge/header.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         var uiApi:Object = Api.ui;
         _content = _block.getChunk("header").processContent({
            "loot":uiApi.getText("ui.common.loot") + " +" + this._challenge.dropBonus + "%",
            "experience":uiApi.getText("ui.common.xp") + " +" + this._challenge.xpBonus + "%"
         });
      }
   }
}
