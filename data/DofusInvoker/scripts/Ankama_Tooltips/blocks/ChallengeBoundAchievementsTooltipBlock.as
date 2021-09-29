package Ankama_Tooltips.blocks
{
   import Ankama_Tooltips.Api;
   import com.ankamagames.dofus.datacenter.quest.Achievement;
   import com.ankamagames.jerakine.data.I18n;
   
   public class ChallengeBoundAchievementsTooltipBlock extends AbstractTooltipBlock
   {
      
      private static const CHUNCK_DATA_KEY:String = "boundAchievements";
       
      
      private var _achievements:Vector.<Achievement>;
      
      public function ChallengeBoundAchievementsTooltipBlock(achievements:Vector.<Achievement>)
      {
         super();
         this._achievements = achievements;
         _block = Api.tooltip.createTooltipBlock(this.onAllChunkLoaded,getContent);
         _block.initChunk([Api.tooltip.createChunkData(CHUNCK_DATA_KEY,"chunks/challenge/boundAchievements.txt")]);
      }
      
      public function onAllChunkLoaded() : void
      {
         var index:uint = 0;
         var boundAchievementsLabel:String = null;
         if(this._achievements === null || this._achievements.length <= 0)
         {
            boundAchievementsLabel = "???";
         }
         else
         {
            boundAchievementsLabel = I18n.getUiText("ui.achievement.achievementName",[this._achievements[0].name]);
            for(index = 1; index < this._achievements.length; index++)
            {
               boundAchievementsLabel += "\n" + I18n.getUiText("ui.achievement.achievementName",[this._achievements[index].name]);
            }
         }
         _content = _block.getChunk(CHUNCK_DATA_KEY).processContent({"boundAchievementsLabel":boundAchievementsLabel});
      }
   }
}
