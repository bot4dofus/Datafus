package Ankama_Tooltips.makers
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blocks.ChallengeBoundAchievementsTooltipBlock;
   import Ankama_Tooltips.blocks.ChallengeResultBlock;
   import Ankama_Tooltips.blocks.ChallengeTooltipBlock;
   import Ankama_Tooltips.blocks.DescriptionTooltipBlock;
   import Ankama_Tooltips.blocks.TextTooltipBlock;
   import com.ankamagames.berilia.interfaces.ITooltipMaker;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.datacenter.quest.Achievement;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   
   public class ChallengeTooltipMaker implements ITooltipMaker
   {
       
      
      private var _param:paramClass;
      
      public function ChallengeTooltipMaker()
      {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Tooltip
      {
         var boundAchievements:Vector.<Achievement> = null;
         var description:String = null;
         var boss:Monster = null;
         var bossName:String = null;
         var target:* = null;
         var uiApi:Object = Api.ui;
         this._param = new paramClass();
         if(param)
         {
            if(param.hasOwnProperty("name"))
            {
               this._param.name = param.name;
            }
            if(param.hasOwnProperty("description"))
            {
               this._param.description = param.description;
            }
            if(param.hasOwnProperty("effects"))
            {
               this._param.effects = param.effects;
            }
            else
            {
               this._param.effects = false;
            }
            boundAchievements = null;
            if(param.hasOwnProperty("boundAchievements") && param.boundAchievements is Vector.<Achievement>)
            {
               boundAchievements = param.boundAchievements;
               if(boundAchievements.length > 0)
               {
                  this._param.boundAchievements = true;
               }
            }
            if(param.hasOwnProperty("results"))
            {
               this._param.results = param.results;
            }
            else
            {
               this._param.results = false;
            }
         }
         var tooltip:Tooltip = Api.tooltip.createTooltip("chunks/base/baseWithBackground.txt","chunks/base/container.txt","chunks/base/separator.txt");
         if(this._param.name)
         {
            tooltip.addBlock(new TextTooltipBlock(data.name,{
               "content":data.name,
               "css":"[local.css]tooltip_title.css",
               "cssClass":"spell"
            }).block);
         }
         if(this._param.description)
         {
            description = data.description;
            if(param !== null && param.hasOwnProperty("bossId"))
            {
               boss = Monster.getMonsterById(param.bossId);
               if(boss !== null)
               {
                  bossName = boss.name;
               }
               else
               {
                  bossName = "???";
               }
               description = description.replace("%1",bossName);
               if(param.hasOwnProperty("turnsRequired"))
               {
                  description = description.replace("%2",param.turnsRequired.toString());
               }
            }
            else if(param !== null && param.hasOwnProperty("turnsRequired"))
            {
               description = description.replace("%2",param.turnsRequired.toString());
            }
            else
            {
               target = data.targetName + " (";
               if(data.targetId > 0 && data.targetLevel > ProtocolConstantsEnum.MAX_LEVEL)
               {
                  target += uiApi.getText("ui.common.short.prestige") + (data.targetLevel - ProtocolConstantsEnum.MAX_LEVEL) + ")";
               }
               else
               {
                  target += uiApi.getText("ui.common.short.level") + data.targetLevel + ")";
               }
               description = description.replace("%1",target);
            }
            tooltip.addBlock(new DescriptionTooltipBlock(description).block);
         }
         if(this._param.effects)
         {
            tooltip.addBlock(new ChallengeTooltipBlock(data).block);
         }
         if(this._param.boundAchievements && boundAchievements.length > 0)
         {
            tooltip.addBlock(new ChallengeBoundAchievementsTooltipBlock(boundAchievements).block);
         }
         if(this._param.results)
         {
            tooltip.addBlock(new ChallengeResultBlock(data).block);
         }
         return tooltip;
      }
   }
}

class paramClass
{
    
   
   public var name:Boolean = true;
   
   public var description:Boolean = true;
   
   public var effects:Boolean = true;
   
   public var boundAchievements:Boolean = false;
   
   public var results:Boolean = true;
   
   function paramClass()
   {
      super();
   }
}
