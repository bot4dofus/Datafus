package Ankama_Grimoire.ui
{
   import Ankama_Common.Common;
   import Ankama_ContextMenu.ContextMenu;
   import Ankama_Grimoire.Grimoire;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.jobs.Skill;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.jobs.KnownJobWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.craft.JobBookSubscribeRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterDirectoryDefineSettingsAction;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.JobsApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.StorageApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.utils.Dictionary;
   
   public class JobTab
   {
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="JobsApi")]
      public var jobsApi:JobsApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="StorageApi")]
      public var storageApi:StorageApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _jobs:Array;
      
      private var _currentJob:KnownJobWrapper;
      
      private var _bDescendingSort:Boolean = false;
      
      private var _gridComponentsList:Dictionary;
      
      private var _optionsTimer:BenchmarkTimer;
      
      private var _allJobsSubscribed:Boolean = false;
      
      private var _currentTabName:String;
      
      private var _recipesUiRoot:UiRootContainer;
      
      private var _meats:Array;
      
      public var gd_jobs:Grid;
      
      public var btn_tabName:ButtonContainer;
      
      public var btn_tabLevel:ButtonContainer;
      
      public var chk_subscribeAll:ButtonContainer;
      
      public var btn_recipes:ButtonContainer;
      
      public var btn_resources:ButtonContainer;
      
      public var btn_options:ButtonContainer;
      
      public var ctr_recipes:GraphicContainer;
      
      public var ctr_resources:GraphicContainer;
      
      public var lbl_collectablesTitle:Label;
      
      public var gd_skills:Grid;
      
      public var ctr_options:GraphicContainer;
      
      public var chk_optionSubscribe:ButtonContainer;
      
      public var btn_label_chk_optionSubscribe:Label;
      
      public var chk_freeOption:ButtonContainer;
      
      public var lbl_minLevelOption:Label;
      
      public var cbx_minLevelOption:ComboBox;
      
      public var tx_optionsHelp:Texture;
      
      public var btn_close:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public function JobTab()
      {
         this._jobs = [];
         this._gridComponentsList = new Dictionary(true);
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         var kj:KnownJobWrapper = null;
         var itemId:int = 0;
         var index:int = 0;
         var i:int = 0;
         var itemWrapper:ItemWrapper = null;
         var meatDisplayedAsSkill:Object = null;
         this.soundApi.playSound(SoundTypeEnum.OPEN_WINDOW);
         this.sysApi.addHook(CraftHookList.JobBookSubscription,this.onJobBookSubscription);
         this.sysApi.addHook(CraftHookList.CrafterDirectorySettings,this.onCrafterDirectorySettings);
         this.sysApi.addHook(CraftHookList.JobsExpUpdated,this.onJobsExpUpdated);
         this.sysApi.addHook(CraftHookList.JobLevelUp,this.onJobLevelUp);
         this.uiApi.addComponentHook(this.gd_jobs,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.chk_optionSubscribe,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.chk_optionSubscribe,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.chk_optionSubscribe,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.chk_freeOption,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.chk_freeOption,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.chk_freeOption,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_minLevelOption,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_minLevelOption,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.cbx_minLevelOption,ComponentHookList.ON_SELECT_ITEM);
         this.uiApi.addComponentHook(this.tx_optionsHelp,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_optionsHelp,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.chk_subscribeAll,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.chk_subscribeAll,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_close,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.btn_help,ComponentHookList.ON_RELEASE);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         var jobs:Array = this.jobsApi.getKnownJobs();
         var lastJobOpenedId:int = Grimoire.getInstance().lastJobOpenedId;
         this._allJobsSubscribed = true;
         for each(kj in jobs)
         {
            this._jobs.push(kj);
            if(!kj.jobBookSubscriber)
            {
               this._allJobsSubscribed = false;
            }
         }
         this._jobs.sortOn(["jobXP","name"],[Array.NUMERIC | Array.DESCENDING,Array.CASEINSENSITIVE]);
         this.gd_jobs.dataProvider = this._jobs;
         if(this._allJobsSubscribed)
         {
            this.chk_subscribeAll.selected = true;
         }
         this._meats = [];
         var meatItemIds:Vector.<uint> = this.dataApi.queryEquals(Item,"typeId",DataEnum.ITEM_TYPE_MEAT);
         for each(itemId in meatItemIds)
         {
            itemWrapper = this.dataApi.getItemWrapper(itemId,0,0,1);
            meatDisplayedAsSkill = {
               "gatheredRessource":itemWrapper,
               "level":itemWrapper.level
            };
            this._meats.push(meatDisplayedAsSkill);
         }
         this._meats.sortOn("level",Array.NUMERIC);
         index = 0;
         for(i = 0; i < this._jobs.length; i++)
         {
            if(this._jobs[i].id == lastJobOpenedId)
            {
               index = i;
            }
         }
         this.gd_jobs.selectedIndex = index;
         this.onSelectItem(this.gd_jobs,SelectMethodEnum.AUTO,true);
         this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_recipes,this.uiApi.me());
         this.btn_recipes.selected = true;
         this._recipesUiRoot = this.modCommon.createRecipesObject("recipesGrimoire",this.ctr_recipes,this.ctr_recipes,this.gd_jobs.selectedItem.id);
         this.onRelease(this.btn_recipes);
      }
      
      public function get currentTabName() : String
      {
         return this._currentTabName;
      }
      
      public function set currentTabName(value:String) : void
      {
         this._currentTabName = value;
      }
      
      public function uiTutoTabLaunch(tab:String = "btn_resources") : void
      {
         this.hintsApi.closeSubHints();
         if(this.hintsApi.canDisplayHelp() && this.hintsApi.guidedActivated())
         {
            if(tab == this.btn_recipes.name)
            {
               this._recipesUiRoot.uiClass.selectWhichTabHintsToDisplay();
            }
            else if(!this.hintsApi.getGuidedAlreadyDone(tab))
            {
               this.hintsApi.showSubHints(tab);
            }
         }
      }
      
      public function unload() : void
      {
         this.uiApi.unloadUi("recipesGrimoire");
         if(this._currentJob)
         {
            Grimoire.getInstance().lastJobOpenedId = this._currentJob.id;
         }
      }
      
      public function get currentJob() : KnownJobWrapper
      {
         return this._currentJob;
      }
      
      public function updateJobLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         var xpPos:int = 0;
         if(data)
         {
            if(!this._gridComponentsList[componentsRef.tx_progressBar.name])
            {
               this.uiApi.addComponentHook(componentsRef.tx_progressBar,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.tx_progressBar,ComponentHookList.ON_ROLL_OUT);
            }
            this._gridComponentsList[componentsRef.tx_progressBar.name] = data;
            if(!this._gridComponentsList[componentsRef.chk_subscribe.name])
            {
               this.uiApi.addComponentHook(componentsRef.chk_subscribe,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.chk_subscribe,ComponentHookList.ON_ROLL_OUT);
               this.uiApi.addComponentHook(componentsRef.chk_subscribe,ComponentHookList.ON_RELEASE);
            }
            this._gridComponentsList[componentsRef.chk_subscribe.name] = data;
            if(!this._gridComponentsList[componentsRef.tx_jobLevelHelp.name])
            {
               this.uiApi.addComponentHook(componentsRef.tx_jobLevelHelp,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.tx_jobLevelHelp,ComponentHookList.ON_ROLL_OUT);
            }
            this._gridComponentsList[componentsRef.tx_jobLevelHelp.name] = data;
            if(data.jobXP == 0)
            {
               componentsRef.lbl_name.cssClass = "p4";
            }
            else
            {
               componentsRef.lbl_name.cssClass = "p";
            }
            componentsRef.lbl_name.text = data.name;
            if(this.sysApi.getPlayerManager().hasRights)
            {
               componentsRef.lbl_name.text += " (" + data.id + ")";
            }
            componentsRef.lbl_level.text = this.uiApi.getText("ui.common.short.level") + " " + data.jobLevel;
            componentsRef.tx_icon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("jobIconPath") + data.iconId + ".swf");
            componentsRef.tx_progressBar.visible = true;
            xpPos = 1;
            if(data.jobLevel == ProtocolConstantsEnum.MAX_JOB_LEVEL)
            {
               xpPos = 100;
            }
            else
            {
               xpPos = int((data.jobXP - data.jobXpLevelFloor) / (data.jobXpNextLevelFloor - data.jobXpLevelFloor) * 100);
               if(xpPos == 0)
               {
                  xpPos = 1;
               }
            }
            componentsRef.tx_progressBar.value = xpPos / 100;
            componentsRef.chk_subscribe.visible = true;
            componentsRef.chk_subscribe.selected = data.jobBookSubscriber;
            if(!this.sysApi.getPlayerManager().isBasicAccount() || this.sysApi.getPlayerManager().isBasicAccount() && data.jobLevel < ProtocolConstantsEnum.MAX_JOB_LEVEL_NONSUBSCRIBER)
            {
               componentsRef.tx_jobLevelHelp.visible = false;
            }
            componentsRef.btn_job.selected = selected;
         }
         else
         {
            componentsRef.lbl_name.text = "";
            componentsRef.lbl_level.text = "";
            componentsRef.tx_icon.uri = null;
            componentsRef.tx_progressBar.visible = false;
            componentsRef.chk_subscribe.visible = false;
            componentsRef.btn_job.selected = false;
            componentsRef.btn_job.softDisabled = false;
            componentsRef.tx_progressBar.value = 0;
         }
      }
      
      public function gotoands(obj:Object) : void
      {
         obj[1].value = obj[0];
      }
      
      public function updateSkillLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         var collectInfo:Object = null;
         if(data)
         {
            if(!this._gridComponentsList[componentsRef.slot_resource.name])
            {
               this.uiApi.addComponentHook(componentsRef.slot_resource,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.slot_resource,ComponentHookList.ON_ROLL_OUT);
               this.uiApi.addComponentHook(componentsRef.slot_resource,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(componentsRef.slot_resource,ComponentHookList.ON_RIGHT_CLICK);
            }
            this._gridComponentsList[componentsRef.slot_resource.name] = data.gatheredRessource;
            if(data is Skill)
            {
               if(this._gridComponentsList[componentsRef.lbl_info.name])
               {
                  this.uiApi.removeComponentHook(componentsRef.lbl_info,ComponentHookList.ON_RELEASE);
                  componentsRef.lbl_info.handCursor = false;
               }
               this._gridComponentsList[componentsRef.lbl_info.name] = null;
               componentsRef.lbl_interactive.text = data.interactive.name;
               componentsRef.lbl_xp.text = this.uiApi.getText("ui.tooltip.monsterXpAlone",Math.floor(5 + data.levelMin / 10) * 2);
               collectInfo = this.jobsApi.getJobCollectSkillInfos(this._currentJob.id,data);
               if(collectInfo)
               {
                  componentsRef.lbl_info.text = this.uiApi.getText("ui.jobs.collectSkillInfos",collectInfo.minResources,collectInfo.maxResources);
               }
            }
            else
            {
               if(!this._gridComponentsList[componentsRef.lbl_info.name])
               {
                  this.uiApi.addComponentHook(componentsRef.lbl_info,ComponentHookList.ON_RELEASE);
                  componentsRef.lbl_info.handCursor = true;
               }
               this._gridComponentsList[componentsRef.lbl_info.name] = data.gatheredRessource;
               componentsRef.lbl_interactive.text = data.gatheredRessource.name;
               componentsRef.lbl_xp.text = "";
               componentsRef.lbl_info.text = this.uiApi.getText("ui.jobs.obtention");
            }
            componentsRef.slot_resource.data = data.gatheredRessource;
            componentsRef.slot_resource.visible = true;
         }
         else
         {
            componentsRef.slot_resource.visible = false;
            componentsRef.lbl_info.text = "";
            componentsRef.lbl_interactive.text = "";
            componentsRef.lbl_xp.text = "";
         }
      }
      
      private function switchJob() : void
      {
         var skill:Skill = null;
         var meatsHuntableAtCurrentLevel:Array = null;
         var meat:Object = null;
         if(this._currentJob && this.gd_jobs.selectedItem.id == this._currentJob.id)
         {
            return;
         }
         this._currentJob = this.gd_jobs.selectedItem;
         var levelData:Array = [];
         for(var i:int = 1; i <= this._currentJob.jobLevel; i++)
         {
            levelData[i - 1] = {
               "label":i.toString(),
               "value":i
            };
         }
         this.cbx_minLevelOption.dataProvider = levelData;
         this.btn_label_chk_optionSubscribe.text = this.uiApi.getText("ui.jobs.subscribe",this._currentJob.name);
         var settings:Object = this.jobsApi.getJobCrafterDirectorySettingsById(this._currentJob.id);
         this.chk_freeOption.selected = settings.free;
         if(settings.minLevel > 0)
         {
            this.cbx_minLevelOption.selectedIndex = settings.minLevel - 1;
         }
         else
         {
            this.cbx_minLevelOption.selectedIndex = 0;
         }
         this.enableOptions(this._currentJob.jobBookSubscriber);
         this.sysApi.dispatchHook(CraftHookList.JobSelected,this._currentJob.id,0,"recipesGrimoire");
         var skills:Array = this.jobsApi.getJobSkills(this._currentJob.id);
         var collectSkills:Array = [];
         for each(skill in skills)
         {
            if(skill.gatheredRessourceItem > -1 && skill.clientDisplay && skill.gatheredRessource.visible)
            {
               collectSkills.push(skill);
            }
         }
         if(this._currentJob.id == DataEnum.JOB_ID_HUNTER)
         {
            this.btn_resources.disabled = false;
            this.lbl_collectablesTitle.text = this.uiApi.getText("ui.jobs.huntableAtJobLevel");
            meatsHuntableAtCurrentLevel = [];
            for each(meat in this._meats)
            {
               if(meat.level <= this._currentJob.jobLevel && meat.gatheredRessource.visible)
               {
                  meatsHuntableAtCurrentLevel.push(meat);
               }
            }
            this.gd_skills.dataProvider = meatsHuntableAtCurrentLevel;
         }
         if(collectSkills.length == 0)
         {
            this.btn_resources.disabled = true;
            if(this.btn_resources.selected)
            {
               this.uiApi.setRadioGroupSelectedItem("tabHGroup",this.btn_recipes,this.uiApi.me());
               this.onRelease(this.btn_recipes);
            }
         }
         else
         {
            this.lbl_collectablesTitle.text = this.uiApi.getText("ui.jobs.collectableAtJobLevel");
            collectSkills.sortOn("levelMin",Array.NUMERIC);
            this.btn_resources.disabled = false;
            this.gd_skills.dataProvider = collectSkills;
         }
      }
      
      private function enableOptions(subscriber:Boolean) : void
      {
         this.chk_optionSubscribe.selected = subscriber;
         if(!subscriber)
         {
            this.chk_freeOption.softDisabled = true;
            this.cbx_minLevelOption.disabled = true;
            this.lbl_minLevelOption.cssClass = "disabled";
         }
         else
         {
            this.chk_freeOption.softDisabled = false;
            this.cbx_minLevelOption.disabled = false;
            this.lbl_minLevelOption.cssClass = "left";
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var data:Object = null;
         var job:KnownJobWrapper = null;
         var bestiaryData:Object = null;
         var jobIds:Vector.<uint> = new Vector.<uint>();
         switch(target)
         {
            case this.btn_tabName:
               if(this._bDescendingSort)
               {
                  this._jobs.sortOn(["name","jobXP"],[Array.CASEINSENSITIVE | Array.DESCENDING,Array.NUMERIC | Array.DESCENDING]);
                  this.gd_jobs.dataProvider = this._jobs;
               }
               else
               {
                  this._jobs.sortOn(["name","jobXP"],[Array.CASEINSENSITIVE,Array.NUMERIC | Array.DESCENDING]);
                  this.gd_jobs.dataProvider = this._jobs;
               }
               this._bDescendingSort = !this._bDescendingSort;
               break;
            case this.btn_tabLevel:
               if(this._bDescendingSort)
               {
                  this._jobs.sortOn(["jobXP","name"],[Array.NUMERIC | Array.DESCENDING,Array.CASEINSENSITIVE]);
                  this.gd_jobs.dataProvider = this._jobs;
               }
               else
               {
                  this._jobs.sortOn(["jobXP","name"],[Array.NUMERIC,Array.CASEINSENSITIVE]);
                  this.gd_jobs.dataProvider = this._jobs;
               }
               this._bDescendingSort = !this._bDescendingSort;
               break;
            case this.btn_recipes:
               this.currentTabName = this.btn_recipes.name;
               this.ctr_recipes.visible = true;
               this.ctr_resources.visible = false;
               this.ctr_options.visible = false;
               this.uiTutoTabLaunch(this.currentTabName);
               break;
            case this.btn_resources:
               this.currentTabName = this.btn_resources.name;
               this.ctr_resources.visible = true;
               this.ctr_recipes.visible = false;
               this.ctr_options.visible = false;
               this.uiTutoTabLaunch(this.currentTabName);
               break;
            case this.btn_options:
               this.currentTabName = this.btn_resources.name;
               this.ctr_resources.visible = false;
               this.ctr_recipes.visible = false;
               this.ctr_options.visible = true;
               this.uiTutoTabLaunch(this.currentTabName);
               break;
            case this.chk_freeOption:
               this.sysApi.sendAction(new JobCrafterDirectoryDefineSettingsAction([this._currentJob.id,this.cbx_minLevelOption.selectedItem.value,this.chk_freeOption.selected]));
               break;
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               return;
            case this.chk_subscribeAll:
               jobIds = new Vector.<uint>();
               if(!this._allJobsSubscribed)
               {
                  for each(job in this._jobs)
                  {
                     if(!job.jobBookSubscriber)
                     {
                        jobIds.push(job.id);
                     }
                  }
               }
               else
               {
                  for each(job in this._jobs)
                  {
                     jobIds.push(job.id);
                  }
               }
               this.sysApi.sendAction(new JobBookSubscribeRequestAction([jobIds]));
               break;
            case this.chk_optionSubscribe:
               if(this._currentJob)
               {
                  jobIds = new Vector.<uint>();
                  jobIds.push(this._currentJob.id);
                  this.sysApi.sendAction(new JobBookSubscribeRequestAction([jobIds]));
               }
               break;
            case this.btn_help:
               if(this.currentTabName == this.btn_recipes.name)
               {
                  this._recipesUiRoot.uiClass.selectWhichTabHintsToDisplay();
               }
               else
               {
                  this.hintsApi.showSubHints(this.currentTabName);
               }
         }
         if(target.name.indexOf("slot") == 0)
         {
            data = this._gridComponentsList[target.name];
            if(data && !this.sysApi.getOption("displayTooltips","dofus"))
            {
               this.sysApi.dispatchHook(ChatHookList.ShowObjectLinked,data);
            }
         }
         else if(target.name.indexOf("chk_subscribe") == 0)
         {
            data = this._gridComponentsList[target.name];
            if(data)
            {
               jobIds = new Vector.<uint>();
               jobIds.push(data.id);
               this.sysApi.sendAction(new JobBookSubscribeRequestAction([jobIds]));
            }
         }
         else if(target.name.indexOf("lbl_info") == 0)
         {
            data = this._gridComponentsList[target.name];
            bestiaryData = {};
            bestiaryData.monsterId = 0;
            bestiaryData.monsterSearch = data.name;
            bestiaryData.monsterIdsList = data.dropMonsterIds;
            bestiaryData.forceOpen = true;
            this.sysApi.dispatchHook(HookList.OpenEncyclopedia,"bestiaryTab",bestiaryData);
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var ttData:* = undefined;
         var data:Object = null;
         var xp:String = null;
         if(target.name.indexOf("tx_progressBar") == 0)
         {
            data = this._gridComponentsList[target.name];
            if(data)
            {
               xp = this.utilApi.formateIntToString(data.jobXP);
               if(data.jobLevel == ProtocolConstantsEnum.MAX_JOB_LEVEL)
               {
                  ttData = "100 % (" + xp + ")";
               }
               else
               {
                  ttData = xp + " / " + this.utilApi.formateIntToString(data.jobXpNextLevelFloor);
               }
            }
         }
         else if(target.name.indexOf("tx_jobLevelHelp") == 0)
         {
            ttData = this.uiApi.getText("ui.craft.jobLevelHelp");
         }
         else if(target == this.chk_subscribeAll)
         {
            if(this.chk_subscribeAll.selected)
            {
               ttData = this.uiApi.getText("ui.craft.removeAllFromCrafterLists");
            }
            else
            {
               ttData = this.uiApi.getText("ui.craft.addAllToCrafterLists");
            }
         }
         else if(target.name.indexOf("chk_subscribe") == 0)
         {
            data = this._gridComponentsList[target.name];
            if(data)
            {
               if(data.jobBookSubscriber)
               {
                  ttData = this.uiApi.getText("ui.craft.removeFromCrafterList");
               }
               else
               {
                  ttData = this.uiApi.getText("ui.craft.addToCrafterList");
               }
            }
         }
         else if(target == this.chk_optionSubscribe)
         {
            if(this._currentJob)
            {
               if(this._currentJob.jobBookSubscriber)
               {
                  ttData = this.uiApi.getText("ui.craft.removeFromCrafterList");
               }
               else
               {
                  ttData = this.uiApi.getText("ui.craft.addToCrafterList");
               }
            }
         }
         else if(target == this.lbl_minLevelOption)
         {
            ttData = this.uiApi.getText("ui.jobs.minLevelOptionInfo");
         }
         else if(target == this.chk_freeOption)
         {
            ttData = this.uiApi.getText("ui.jobs.freeOptionInfo");
         }
         else if(target == this.tx_optionsHelp)
         {
            ttData = this.uiApi.getText("ui.craft.optionHelp");
         }
         else
         {
            if(target.name.indexOf("slot_craftedItem") == 0 || target.name.indexOf("slot_resource") == 0)
            {
               data = this._gridComponentsList[target.name];
               if(data)
               {
                  this.uiApi.showTooltip(data,target,false,"standard",8,0,0,"itemName",null,{
                     "showEffects":true,
                     "header":true
                  },"ItemInfo");
               }
               return;
            }
            if(target.name.indexOf("slot") == 0)
            {
               data = this._gridComponentsList[target.name];
               if(data)
               {
                  this.uiApi.showTooltip(data,target,false,"standard",6,2,3,"itemName",null,{
                     "showEffects":true,
                     "header":true
                  },"ItemInfo");
               }
               return;
            }
         }
         if(ttData)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(ttData),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         if(!isNewSelection)
         {
            return;
         }
         switch(target)
         {
            case this.gd_jobs:
               this.switchJob();
               break;
            case this.cbx_minLevelOption:
               this.sysApi.sendAction(new JobCrafterDirectoryDefineSettingsAction([this._currentJob.id,this.cbx_minLevelOption.selectedItem.value,this.chk_freeOption.selected]));
         }
      }
      
      public function onRightClick(target:GraphicContainer) : void
      {
         var contextMenu:ContextMenuData = null;
         var data:Object = this._gridComponentsList[target.name];
         if(data)
         {
            contextMenu = this.menuApi.create(data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
      
      private function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "closeUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
               return true;
            default:
               return false;
         }
      }
      
      private function onJobBookSubscription(jobId:uint, subscriber:Boolean) : void
      {
         var kj:KnownJobWrapper = null;
         var index:int = -1;
         var i:int = -1;
         var allOtherJobsSubscribed:Boolean = true;
         if(jobId == this._currentJob.id)
         {
            this.enableOptions(subscriber);
         }
         for each(kj in this.gd_jobs.dataProvider)
         {
            i++;
            if(kj.id == jobId)
            {
               index = i;
            }
            else if(!kj.jobBookSubscriber)
            {
               allOtherJobsSubscribed = false;
            }
         }
         this.gd_jobs.updateItem(index);
         if(this._allJobsSubscribed && !subscriber)
         {
            this.chk_subscribeAll.selected = false;
            this._allJobsSubscribed = false;
         }
         else if(!this._allJobsSubscribed && subscriber && allOtherJobsSubscribed)
         {
            this.chk_subscribeAll.selected = true;
            this._allJobsSubscribed = true;
         }
      }
      
      private function onJobLevelUp(jobId:uint, jobName:String, newLevel:uint, podsBonus:uint) : void
      {
         var index:int = -1;
         var jobsLength:int = this._jobs.length;
         var jobLeveledUp:KnownJobWrapper = this.jobsApi.getKnownJob(jobId);
         for(var i:int = 0; i < jobsLength; i++)
         {
            if(this._jobs[i].id == jobId)
            {
               this._jobs[i] = jobLeveledUp;
            }
            if(this.gd_jobs.dataProvider[i].id == jobId)
            {
               this.gd_jobs.dataProvider[i] = jobLeveledUp;
               index = i;
            }
         }
         if(index > -1)
         {
            this.gd_jobs.updateItem(index);
         }
         if(this._currentJob.id == jobId)
         {
            if(this.storageApi.getIsCraftFilterEnabled())
            {
               this.storageApi.enableCraftFilter(jobLeveledUp.jobDescription.skills,newLevel);
            }
         }
      }
      
      protected function onJobsExpUpdated(jobId:uint) : void
      {
         var index:int = -1;
         var jobsLength:int = this._jobs.length;
         var jobLeveledUp:KnownJobWrapper = this.jobsApi.getKnownJob(jobId);
         for(var i:int = 0; i < jobsLength; i++)
         {
            if(this._jobs[i].id == jobId)
            {
               this._jobs[i] = jobLeveledUp;
            }
            if(this.gd_jobs.dataProvider[i].id == jobId)
            {
               this.gd_jobs.dataProvider[i] = jobLeveledUp;
               index = i;
            }
         }
         if(index > -1)
         {
            this.gd_jobs.updateItem(index);
         }
      }
      
      private function onCrafterDirectorySettings(settings:Object) : void
      {
         var s:Object = null;
         for each(s in settings)
         {
            if(this._currentJob && s.jobId == this._currentJob.id)
            {
               this.chk_freeOption.selected = s.free;
               if(s.minLevel > 0)
               {
                  this.cbx_minLevelOption.selectedIndex = s.minLevel - 1;
               }
               else
               {
                  this.cbx_minLevelOption.selectedIndex = 0;
               }
            }
         }
      }
   }
}
