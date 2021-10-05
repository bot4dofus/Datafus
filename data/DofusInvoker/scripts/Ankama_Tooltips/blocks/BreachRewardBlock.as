package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   import com.ankamagames.dofus.network.enums.BreachRewardLockEnum;
   
   public class BreachRewardBlock extends AbstractTooltipBlock
   {
       
      
      private var _data:Vector.<uint>;
      
      private var _isBudget:Boolean;
      
      private var _withConditionBlock:Boolean;
      
      public function BreachRewardBlock(data:Vector.<uint>, isBudget:Boolean, withConditionBlock:Boolean)
      {
         super();
         _content = "";
         this._data = data;
         this._isBudget = isBudget;
         this._withConditionBlock = withConditionBlock;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         var chunkData:Array = [Api.tooltip.createChunkData("content","htmlChunks/breach/conditions.txt")];
         if(!this._withConditionBlock)
         {
            chunkData.push(Api.tooltip.createChunkData("subtitle","htmlChunks/base/subTitle.txt"));
         }
         _block.initChunk(chunkData);
      }
      
      public function onAllChunkLoaded() : void
      {
         var finalStr:String = null;
         if(this.checkForSubtitle())
         {
            _content = _block.getChunk("subtitle").processContent({"text":Api.ui.getText("ui.common.conditions")});
         }
         if(this._isBudget)
         {
            _content += _block.getChunk("content").processContent({"content":Api.ui.getText("ui.breach.isBreachOwner")});
         }
         for(var i:int = 0; i < this._data.length; i++)
         {
            finalStr = "";
            switch(this._data[i])
            {
               case BreachRewardLockEnum.BREACH_REWARD_LOCK_FIGHTER:
                  finalStr += Api.ui.getText("ui.breach.notInLastFight");
                  break;
               case BreachRewardLockEnum.BREACH_REWARD_LOCK_RESOURCES:
                  finalStr += Api.ui.getText("ui.breach.notEnoughMoney",!!this._isBudget ? Api.ui.getText("ui.breach.dreamPoints") : Api.ui.getText("ui.breach.fragments").toLowerCase());
                  break;
               case BreachRewardLockEnum.BREACH_REWARD_LOCK_USELESS:
                  finalStr += Api.ui.getText("ui.breach.purchaseDeactivated");
                  break;
            }
            if(finalStr != "")
            {
               _content += _block.getChunk("content").processContent({"content":finalStr});
            }
         }
      }
      
      public function checkForSubtitle() : Boolean
      {
         return !this._withConditionBlock && (this._isBudget || this._data.length > 0);
      }
   }
}
