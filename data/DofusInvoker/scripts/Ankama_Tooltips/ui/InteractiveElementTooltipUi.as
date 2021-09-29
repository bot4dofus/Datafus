package Ankama_Tooltips.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.uiApi.JobsApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   
   public class InteractiveElementTooltipUi
   {
      
      private static const MARGIN:uint = 5;
      
      private static const PADDING:uint = 10;
      
      private static const BASE_JOB_ID:int = 1;
       
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="JobsApi")]
      public var jobsApi:JobsApi;
      
      public var ctr_elementName:GraphicContainer;
      
      public var lbl_elementName:Label;
      
      public var lbl_enabledSkills:Label;
      
      public var lbl_disabledSkills:Label;
      
      public var ctr_line:GraphicContainer;
      
      public var main_ctr:GraphicContainer;
      
      public var ctr_stars:GraphicContainer;
      
      public var star00:Texture;
      
      public var star01:Texture;
      
      public var star02:Texture;
      
      public var star03:Texture;
      
      public var star04:Texture;
      
      public var star10:Texture;
      
      public var star11:Texture;
      
      public var star12:Texture;
      
      public var star13:Texture;
      
      public var star14:Texture;
      
      public var star20:Texture;
      
      public var star21:Texture;
      
      public var star22:Texture;
      
      public var star23:Texture;
      
      public var star24:Texture;
      
      public function InteractiveElementTooltipUi()
      {
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         var jobXp:* = undefined;
         var ageBonus:int = 0;
         var starBonus:int = 0;
         var color:int = 0;
         var numStars:int = 0;
         var i:int = 0;
         var data:Object = oParam.data;
         this.main_ctr.width = 0;
         this.main_ctr.height = 0;
         this.ctr_line.width = 0;
         this.ctr_elementName.width = 1;
         this.ctr_line.removeFromParent();
         this.ctr_elementName.removeFromParent();
         this.lbl_disabledSkills.removeFromParent();
         this.lbl_enabledSkills.removeFromParent();
         this.ctr_stars.removeFromParent();
         this.ctr_stars.visible = false;
         this.lbl_elementName.text = data.interactive;
         this.lbl_elementName.y = 10;
         this.lbl_elementName.fullWidthAndHeight();
         this.main_ctr.addContent(this.ctr_line);
         this.ctr_line.y = this.lbl_elementName.y + this.lbl_elementName.contentHeight;
         if(data.enabledSkills != "")
         {
            this.lbl_enabledSkills.visible = true;
            this.lbl_enabledSkills.y = this.lbl_elementName.y + this.lbl_elementName.contentHeight + MARGIN;
            this.lbl_enabledSkills.text = data.enabledSkills.substr(0,data.enabledSkills.lastIndexOf("\n"));
            this.lbl_disabledSkills.y = this.lbl_enabledSkills.y + this.lbl_enabledSkills.contentHeight;
            this.lbl_disabledSkills.visible = false;
         }
         else
         {
            this.lbl_enabledSkills.visible = false;
            this.lbl_disabledSkills.visible = true;
            this.lbl_disabledSkills.y = this.lbl_elementName.y + this.lbl_elementName.contentHeight + MARGIN;
            if(data.collectSkill)
            {
               jobXp = this.jobsApi.getJobExperience(data.collectSkill.parentJob.id);
               if(data.collectSkill.parentJob.id != BASE_JOB_ID && (!jobXp || jobXp.currentLevel < data.collectSkill.levelMin))
               {
                  this.lbl_disabledSkills.text = data.collectSkill.parentJob.name + " " + this.uiApi.getText("ui.common.short.level") + data.collectSkill.levelMin;
                  this.lbl_disabledSkills.cssClass = "red";
               }
               else
               {
                  this.lbl_disabledSkills.text = this.uiApi.getText("ui.resources.exhausted");
                  this.lbl_disabledSkills.cssClass = "questtitle";
               }
            }
            else
            {
               this.lbl_disabledSkills.cssClass = "red";
               this.lbl_disabledSkills.text = data.disabledSkills.substr(0,data.disabledSkills.lastIndexOf("\n"));
            }
         }
         if(data.enabledSkills != "")
         {
            this.main_ctr.addContent(this.lbl_enabledSkills);
         }
         else
         {
            this.main_ctr.addContent(this.lbl_disabledSkills);
         }
         var maxWidth:Number = this.main_ctr.contentWidth;
         this.ctr_elementName.width = maxWidth;
         this.main_ctr.width = maxWidth;
         this.main_ctr.height = Number(PADDING * 2);
         if(data.isCollectable)
         {
            if(data.hasOwnProperty("ageBonus"))
            {
               starBonus = ageBonus = data.ageBonus;
               this.ctr_stars.y = this.ctr_line.y;
               this.star00.visible = false;
               this.star01.visible = false;
               this.star02.visible = false;
               this.star03.visible = false;
               this.star04.visible = false;
               this.star10.visible = false;
               this.star11.visible = false;
               this.star12.visible = false;
               this.star13.visible = false;
               this.star14.visible = false;
               this.star20.visible = false;
               this.star21.visible = false;
               this.star22.visible = false;
               this.star23.visible = false;
               this.star24.visible = false;
               color = 1;
               if(ageBonus > 100)
               {
                  color = 2;
                  starBonus -= 100;
               }
               numStars = Math.round(starBonus / 20);
               for(i = 0; i < numStars; i++)
               {
                  this["star" + color + "" + i].visible = true;
               }
               while(i < 5)
               {
                  this["star" + (color - 1) + "" + i].visible = true;
                  i++;
               }
               this.ctr_stars.visible = true;
               this.main_ctr.addContent(this.ctr_stars);
               this.ctr_line.y = this.ctr_stars.y + this.ctr_stars.contentHeight + MARGIN;
               this.ctr_stars.x = (this.getMaxWidth() - this.ctr_stars.width) / 2 + PADDING;
            }
         }
         maxWidth = this.getMaxWidth();
         var disabledSkillsY:Number = this.ctr_line.y + MARGIN;
         if(this.lbl_enabledSkills.visible)
         {
            this.lbl_enabledSkills.y = this.ctr_line.y + MARGIN;
            disabledSkillsY = this.lbl_enabledSkills.y + this.lbl_enabledSkills.contentHeight;
         }
         this.lbl_disabledSkills.y = disabledSkillsY;
         if(this.lbl_enabledSkills.visible)
         {
            this.lbl_enabledSkills.fullWidthAndHeight();
         }
         if(this.lbl_disabledSkills.visible)
         {
            this.lbl_disabledSkills.fullWidthAndHeight();
         }
         this.main_ctr.addContent(this.ctr_elementName);
         this.lbl_enabledSkills.x = (maxWidth - this.lbl_enabledSkills.width) / 2 + PADDING;
         this.lbl_disabledSkills.x = (maxWidth - this.lbl_disabledSkills.width) / 2 + PADDING;
         this.lbl_elementName.x = (maxWidth - this.lbl_elementName.width) / 2 + PADDING;
         this.ctr_line.width = maxWidth;
         this.ctr_line.x = (maxWidth - this.ctr_line.width) / 2 + PADDING;
         this.uiApi.me().render();
         this.tooltipApi.place(oParam.position,oParam.showDirectionalArrow,oParam.point,oParam.relativePoint,oParam.offset);
      }
      
      private function getMaxWidth() : Number
      {
         var maxWidth:Number = NaN;
         if(this.lbl_elementName.width >= this.ctr_stars.width || !this.ctr_stars.visible)
         {
            maxWidth = this.lbl_elementName.width;
         }
         else if(this.ctr_stars.visible && this.ctr_stars.width > this.lbl_elementName.width)
         {
            maxWidth = this.ctr_stars.width;
         }
         if(this.lbl_enabledSkills.visible && this.lbl_enabledSkills.width > maxWidth)
         {
            maxWidth = this.lbl_enabledSkills.width;
         }
         if(this.lbl_disabledSkills.visible && this.lbl_disabledSkills.width > maxWidth)
         {
            maxWidth = this.lbl_disabledSkills.width;
         }
         return maxWidth + PADDING * 2;
      }
      
      public function unload() : void
      {
      }
   }
}
