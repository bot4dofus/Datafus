package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   import com.ankamagames.dofus.internalDatacenter.fight.EnumChallengeResult;
   
   public class ChallengeResultBlock extends AbstractTooltipBlock
   {
      
      private static const CHUNCK_DATA_KEY:String = "challengeResult";
       
      
      private var _result:uint;
      
      public function ChallengeResultBlock(challenge:Object)
      {
         super();
         this._result = challenge.result;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData(CHUNCK_DATA_KEY,"chunks/challenge/result.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         var resultLabel:String = null;
         var cssClass:String = null;
         switch(this._result)
         {
            case EnumChallengeResult.IN_PROGRESS:
               resultLabel = Api.ui.getText("ui.fight.challenge.inProgress");
               cssClass = "p";
               break;
            case EnumChallengeResult.COMPLETED:
               resultLabel = Api.ui.getText("ui.fight.challenge.complete");
               cssClass = "bonus";
               break;
            case EnumChallengeResult.FAILED:
               resultLabel = Api.ui.getText("ui.fight.challenge.failed");
               cssClass = "malus";
         }
         _content = _block.getChunk(CHUNCK_DATA_KEY).processContent({
            "resultLabel":resultLabel,
            "cssClass":cssClass
         });
      }
   }
}
