package com.ankamagames.dofus.logic.game.roleplay.managers
{
   import com.ankamagames.dofus.datacenter.interactives.SkillName;
   import com.ankamagames.dofus.datacenter.jobs.Skill;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.jobs.KnownJobWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.common.managers.NotificationManager;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElementNamedSkill;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElementSkill;
   import com.ankamagames.dofus.network.types.game.interactive.InteractiveElementWithAgeBonus;
   import com.ankamagames.dofus.types.enums.NotificationTypeEnum;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import flash.utils.Dictionary;
   
   public class SkillManager
   {
      
      private static var _self:SkillManager;
      
      private static const PADDOCK_ELEMENT:int = 120;
      
      private static const HOUSE_ELEMENT:int = 300;
      
      private static const ACTION_COLLECTABLE_RESOURCES:uint = 1;
      
      private static var _directionalPanelSkills:Array;
      
      private static var _skillsWithoutMenu:Array;
       
      
      public function SkillManager()
      {
         super();
         if(_self != null)
         {
            throw new SingletonError("SkillManager is a singleton and should not be instanciated directly.");
         }
      }
      
      public static function getInstance() : SkillManager
      {
         if(!_self)
         {
            _self = new SkillManager();
         }
         return _self;
      }
      
      public function isDoorCursorSkill(id:int) : Boolean
      {
         return id == DataEnum.SKILL_POINT_OUT_EXIT;
      }
      
      public function isDirectionalPanel(id:int) : Boolean
      {
         if(!_directionalPanelSkills)
         {
            _directionalPanelSkills = [DataEnum.SKILL_SIGN_FREE_TEXT,DataEnum.SKILL_SIGN_HINT,DataEnum.SKILL_SIGN_SUBAREA];
         }
         return _directionalPanelSkills.indexOf(id) != -1;
      }
      
      public function prepareTooltip(elem:Object, ie:InteractiveElement) : void
      {
         var skill:Skill = null;
         var skillNameStr:String = null;
         var interactiveSkill:InteractiveElementSkill = null;
         var disabledSkills:String = null;
         var collectSkill:Skill = null;
         var showBonus:Boolean = false;
         var iewab:InteractiveElementWithAgeBonus = null;
         elem.isCollectable = false;
         var enabledSkills:String = "";
         for each(interactiveSkill in ie.enabledSkills)
         {
            skill = Skill.getSkillById(interactiveSkill.skillId);
            if(skill.elementActionId == ACTION_COLLECTABLE_RESOURCES)
            {
               elem.isCollectable = true;
            }
            if(interactiveSkill is InteractiveElementNamedSkill)
            {
               skillNameStr = SkillName.getSkillNameById((interactiveSkill as InteractiveElementNamedSkill).nameId).name;
            }
            else
            {
               skillNameStr = skill.name;
            }
            enabledSkills += skillNameStr + "\n";
         }
         elem.enabledSkills = enabledSkills;
         disabledSkills = "";
         for each(interactiveSkill in ie.disabledSkills)
         {
            skill = Skill.getSkillById(interactiveSkill.skillId);
            if(skill.elementActionId == ACTION_COLLECTABLE_RESOURCES)
            {
               elem.isCollectable = true;
            }
            if(interactiveSkill is InteractiveElementNamedSkill)
            {
               skillNameStr = SkillName.getSkillNameById((interactiveSkill as InteractiveElementNamedSkill).nameId).name;
            }
            else
            {
               skillNameStr = skill.name;
            }
            disabledSkills += skillNameStr + "\n";
         }
         elem.disabledSkills = disabledSkills;
         if(elem.isCollectable)
         {
            showBonus = true;
            iewab = ie as InteractiveElementWithAgeBonus;
            if(ie.enabledSkills.length > 0)
            {
               collectSkill = Skill.getSkillById(ie.enabledSkills[0].skillId);
            }
            else
            {
               collectSkill = Skill.getSkillById(ie.disabledSkills[0].skillId);
            }
            if(collectSkill.parentJobId == 1)
            {
               showBonus = false;
            }
            else if(!iewab)
            {
               showBonus = false;
            }
            elem.collectSkill = collectSkill;
            if(showBonus)
            {
               elem.ageBonus = !!iewab ? iewab.ageBonus : 0;
            }
         }
      }
      
      public function prepareContextualMenu(skills:Array, ie:Object) : Object
      {
         var skillNameStr:String = null;
         var enabledSkill:InteractiveElementSkill = null;
         var skillDisabledData:Skill = null;
         var disabledSkill:InteractiveElementSkill = null;
         var nbSkillsAvailable:int = 0;
         var skillIndex:int = 0;
         var tpSkillIndex:int = 0;
         var skill:Object = null;
         var skillApplyOnSeveralInstances:Boolean = false;
         var knownJob:KnownJobWrapper = null;
         var currentJobLevel:int = 0;
         var entitiesFrame:RoleplayEntitiesFrame = null;
         var houses:Dictionary = null;
         var res:Object = new Object();
         if(!_skillsWithoutMenu)
         {
            _skillsWithoutMenu = [DataEnum.SKILL_SIGN_FREE_TEXT,DataEnum.SKILL_SIGN_HINT,DataEnum.SKILL_SIGN_SUBAREA];
         }
         for each(enabledSkill in ie.element.enabledSkills)
         {
            if(_skillsWithoutMenu.indexOf(enabledSkill.skillId) == -1)
            {
               if(enabledSkill is InteractiveElementNamedSkill)
               {
                  skillNameStr = SkillName.getSkillNameById((enabledSkill as InteractiveElementNamedSkill).nameId).name;
               }
               else
               {
                  skillNameStr = Skill.getSkillById(enabledSkill.skillId).name;
               }
               skills.push({
                  "id":enabledSkill.skillId,
                  "instanceId":enabledSkill.skillInstanceUid,
                  "name":skillNameStr,
                  "enabled":true
               });
            }
         }
         for each(disabledSkill in ie.element.disabledSkills)
         {
            if(_skillsWithoutMenu.indexOf(disabledSkill.skillId) == -1)
            {
               if(disabledSkill is InteractiveElementNamedSkill)
               {
                  skillNameStr = SkillName.getSkillNameById((disabledSkill as InteractiveElementNamedSkill).nameId).name;
               }
               skillDisabledData = Skill.getSkillById(disabledSkill.skillId);
               skillNameStr = skillDisabledData.name;
               if(skillDisabledData.parentJobId != 1)
               {
                  knownJob = PlayedCharacterManager.getInstance().jobs[skillDisabledData.parentJobId];
                  currentJobLevel = knownJob.jobLevel;
                  if(currentJobLevel < skillDisabledData.levelMin)
                  {
                     this.showInteractiveElementNotification(skillDisabledData.parentJob.name,skillDisabledData.levelMin,currentJobLevel);
                  }
                  else if(skillDisabledData.levelMin > ProtocolConstantsEnum.MAX_JOB_LEVEL_NONSUBSCRIBER && PlayerManager.getInstance().isBasicAccount())
                  {
                     this.showInteractiveElementNotification(skillDisabledData.parentJob.name,skillDisabledData.levelMin,ProtocolConstantsEnum.MAX_JOB_LEVEL_NONSUBSCRIBER);
                  }
                  skills.push({
                     "id":disabledSkill.skillId,
                     "instanceId":disabledSkill.skillInstanceUid,
                     "name":skillNameStr,
                     "enabled":false
                  });
               }
            }
         }
         nbSkillsAvailable = 0;
         tpSkillIndex = -1;
         for each(skill in skills)
         {
            if(skill.enabled)
            {
               skillIndex = skills.indexOf(skill);
               nbSkillsAvailable++;
               if(this.isDoorCursorSkill(skill.id))
               {
                  tpSkillIndex = skillIndex;
               }
            }
         }
         skillApplyOnSeveralInstances = false;
         if(ie.element.elementTypeId == HOUSE_ELEMENT || ie.element.elementTypeId == PADDOCK_ELEMENT)
         {
            entitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
            if(entitiesFrame)
            {
               houses = entitiesFrame.housesInformations;
               if(houses && houses[ie.element.elementId] && houses[ie.element.elementId].houseInstances && houses[ie.element.elementId].houseInstances.length > 1)
               {
                  skillApplyOnSeveralInstances = true;
               }
            }
         }
         if(nbSkillsAvailable > 1 && tpSkillIndex != -1)
         {
            skills.splice(tpSkillIndex,1);
            if(skillIndex >= tpSkillIndex)
            {
               skillIndex--;
            }
            nbSkillsAvailable--;
         }
         res.skillIndex = skillIndex;
         res.nbSkills = nbSkillsAvailable;
         res.severalInstances = skillApplyOnSeveralInstances;
         return res;
      }
      
      private function showInteractiveElementNotification(jobName:String, skillLevelMin:int, currentJobLevel:int) : void
      {
         var text:String = I18n.getUiText("ui.skill.levelLowJob",[jobName,skillLevelMin,currentJobLevel]);
         var nid:uint = NotificationManager.getInstance().prepareNotification(I18n.getUiText("ui.skill.impossibleGathering"),text,NotificationTypeEnum.INFORMATION,"interactiveElementDisabled");
         NotificationManager.getInstance().addTimerToNotification(nid,30,true);
         NotificationManager.getInstance().sendNotification(nid);
      }
   }
}
