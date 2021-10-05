package Ankama_Tooltips.makers
{
   import Ankama_Tooltips.Api;
   import Ankama_Tooltips.blocks.EffectsTooltipBlock;
   import Ankama_Tooltips.blocks.TextTooltipBlock;
   import Ankama_Tooltips.blocks.mount.MountSeparatorTooltipBlock;
   import Ankama_Tooltips.blocks.mount.MountTooltipBlock;
   import com.ankamagames.berilia.interfaces.ITooltipMaker;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   
   public class MountTooltipMaker implements ITooltipMaker
   {
      
      public static var lastUiName:String;
       
      
      public function MountTooltipMaker()
      {
         super();
      }
      
      public function createTooltip(data:*, param:Object) : Tooltip
      {
         var bg:String = null;
         var i:int = 0;
         var uiApi:Object = Api.ui;
         if(param.noBg)
         {
            bg = "chunks/base/base.txt";
         }
         else
         {
            bg = "chunks/base/baseWithBackground.txt";
         }
         var tooltip:Tooltip = Api.tooltip.createTooltip(bg,"chunks/base/container.txt","chunks/base/empty.txt");
         var info:Object = {};
         var mount:Object = param.mount;
         info.mountName = mount.name;
         info.mountType = mount.description;
         info.mountLevel = mount.level;
         lastUiName = param.uiName;
         if(param.noBg)
         {
            info.mountCssName = "[local.css]titleSmall.css";
         }
         else
         {
            info.mountCssName = "[local..css]tooltip_title.css";
         }
         if(mount.sex)
         {
            info.mountSex = uiApi.getText("ui.common.animalFemale");
         }
         else
         {
            info.mountSex = uiApi.getText("ui.common.animalMale");
         }
         if(mount.isRideable)
         {
            info.mountRideable = uiApi.getText("ui.common.yes");
         }
         else
         {
            info.mountRideable = uiApi.getText("ui.common.no");
         }
         if(mount.isWild)
         {
            info.mountWild = uiApi.getText("ui.common.yes");
         }
         else
         {
            info.mountWild = uiApi.getText("ui.common.no");
         }
         info.mountES = mount.energy + "/" + mount.energyMax;
         info.mountEPBS = int(mount.energy / mount.energyMax * 112);
         info.mountXPS = mount.experience + "/" + mount.experienceForNextLevel;
         info.mountXPPBS = int((mount.experience - mount.experienceForLevel) / (mount.experienceForNextLevel - mount.experienceForLevel) * 112);
         info.mountTS = mount.boostLimiter + "/" + mount.boostMax;
         info.mountTPBS = int(mount.boostLimiter / mount.boostMax * 112);
         if(mount.reproductionCount == -1)
         {
            info.mountRS = uiApi.getText("ui.mount.castrated");
            info.mountRCSS = "[local.css]normal.css";
            info.mountReproductionVisible = "false";
         }
         else
         {
            info.mountRCSS = "[local.css]normal.css";
            info.mountReproductionVisible = "true";
            info.mountRPBS = int(mount.reproductionCount / mount.reproductionCountMax * 112);
            if(mount.fecondationTime > 0)
            {
               info.mountRS = uiApi.getText("ui.mount.fecondee");
            }
            else
            {
               info.mountRS = mount.reproductionCount + "/" + mount.reproductionCountMax;
            }
         }
         if(param.noBg)
         {
            info.mountSizeGXP = 81;
         }
         else
         {
            info.mountSizeGXP = 100;
         }
         info.mountGXP = mount.xpRatio + "%";
         info.mountAS = mount.love + "/" + mount.loveMax;
         info.mountAPBS = int(mount.love / mount.loveMax * 112);
         info.mountMS = mount.maturity + "/" + mount.maturityForAdult;
         info.mountMPBS = int(mount.maturity / mount.maturityForAdult * 112);
         info.mountSS = mount.stamina + "/" + mount.staminaMax;
         info.mountSPBS = int(mount.stamina / mount.staminaMax * 112);
         var agm:int = mount.aggressivityMax;
         info.mountSerenityPB = int((mount.serenity - agm) / (mount.serenityMax - agm) * 112);
         tooltip.addBlock(new MountTooltipBlock(info).block);
         tooltip.addBlock(new TextTooltipBlock(uiApi.processText(uiApi.getText("ui.common.capacity"),"n",false) + uiApi.getText("ui.common.colon"),{
            "css":"[local.css]normal.css",
            "nameless":true
         }).block);
         var nCapacity:int = mount.ability.length;
         if(nCapacity)
         {
            for(i = 0; i < nCapacity; i++)
            {
               tooltip.addBlock(new TextTooltipBlock("\t• " + mount.ability[i].name,{
                  "css":"[local.css]normal.css",
                  "nameless":true
               }).block);
            }
         }
         else
         {
            tooltip.addBlock(new TextTooltipBlock("\t• " + uiApi.processText(uiApi.getText("ui.common.lowerNone"),"f",true),{
               "css":"[local.css]normal.css",
               "nameless":true
            }).block);
         }
         tooltip.addBlock(new MountSeparatorTooltipBlock().block);
         var nEffect:int = mount.effectList.length;
         if(nEffect)
         {
            tooltip.addBlock(new EffectsTooltipBlock(mount.effectList).block);
         }
         else
         {
            tooltip.addBlock(new TextTooltipBlock(uiApi.processText(uiApi.getText("ui.common.effects"),"n",false) + uiApi.getText("ui.common.colon"),{
               "css":"[local.css]normal.css",
               "nameless":true
            }).block);
            tooltip.addBlock(new TextTooltipBlock("\t• " + uiApi.processText(uiApi.getText("ui.common.lowerNone"),"m",true),{
               "css":"[local.css]normal.css",
               "nameless":true
            }).block);
         }
         return tooltip;
      }
   }
}
