package Ankama_Job.ui
{
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.jobs.Job;
   import com.ankamagames.dofus.datacenter.world.SubArea;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.jobs.JobCrafterDirectoryListRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.network.enums.AlignmentSideEnum;
   import com.ankamagames.dofus.network.enums.PlayerStatusEnum;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.JobsApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.utils.Dictionary;
   
   public class CrafterList
   {
       
      
      public var output:Object;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="JobsApi")]
      public var jobsApi:JobsApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      private var _bDescendingSort:Boolean = false;
      
      private var _sortCriteria:String;
      
      private var _crafters:Array;
      
      private var _jobs:Array;
      
      private var _actualJobLegendary:Boolean = false;
      
      private var _sCraftersText:String;
      
      private var _sChooseJobText:String;
      
      private var _iconsPath:String;
      
      private var _gridComponentsList:Dictionary;
      
      public var combo_job:ComboBox;
      
      public var gd_crafters:Grid;
      
      public var lbl_nbCrafter:Label;
      
      public var lbl_job:Label;
      
      public var tx_hasLegendaryCraft:Texture;
      
      public var btn_hasLegendaryCraft:ButtonContainer;
      
      public var btn_tabAli:ButtonContainer;
      
      public var btn_tabBreed:ButtonContainer;
      
      public var btn_tabName:ButtonContainer;
      
      public var btn_tabLevel:ButtonContainer;
      
      public var btn_tabCoord:ButtonContainer;
      
      public var btn_tabCost:ButtonContainer;
      
      public var btn_tabMinLevel:ButtonContainer;
      
      public var btn_search:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var bgcombo_job:TextureBitmap;
      
      public function CrafterList()
      {
         this._gridComponentsList = new Dictionary(true);
         super();
      }
      
      public function main(jobs:Array) : void
      {
         var job:uint = 0;
         this.soundApi.playSound(SoundTypeEnum.GRIMOIRE_OPEN);
         this.sysApi.addHook(CraftHookList.CrafterDirectoryListUpdate,this.onCrafterDirectoryListUpdate);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addComponentHook(this.btn_tabCoord,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_tabCoord,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_tabCost,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_tabCost,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_tabMinLevel,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_tabMinLevel,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_hasLegendaryCraft,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_hasLegendaryCraft,ComponentHookList.ON_ROLL_OUT);
         this._sChooseJobText = this.uiApi.getText("ui.craft.chooseJob");
         this._sCraftersText = this.uiApi.getText("ui.craft.crafters");
         this._iconsPath = this.uiApi.me().getConstant("icons_uri");
         this.gd_crafters.dataProvider = [];
         this._sortCriteria = "jobLevel";
         this._jobs = [];
         var labels:Array = [];
         if(jobs.length > 1)
         {
            labels.push(this._sChooseJobText);
            for each(job in jobs)
            {
               labels.push(this.jobsApi.getJobName(job));
               this._jobs.push(this.jobsApi.getJob(job) as Job);
            }
            this.combo_job.dataProvider = labels;
            this.combo_job.value = labels[0];
            this.lbl_job.visible = false;
            this.bgcombo_job.visible = true;
            this.tx_hasLegendaryCraft.visible = this.btn_hasLegendaryCraft.visible = false;
         }
         else
         {
            this.sysApi.sendAction(new JobCrafterDirectoryListRequestAction([jobs[0]]));
            this.lbl_job.text = this.jobsApi.getJobName(jobs[0]);
            this.combo_job.visible = this.bgcombo_job.visible = false;
            this._actualJobLegendary = this.jobsApi.getJob(jobs[0]).hasLegendaryCraft;
            this.tx_hasLegendaryCraft.visible = this.btn_hasLegendaryCraft.visible = this._actualJobLegendary;
         }
      }
      
      public function unload() : void
      {
         this.sysApi.sendAction(new LeaveDialogRequestAction([]));
         this.soundApi.playSound(SoundTypeEnum.GRIMOIRE_CLOSE);
      }
      
      public function updateCrafterLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         var sa:SubArea = null;
         var txt:String = null;
         if(data)
         {
            if(!this._gridComponentsList[componentsRef.tx_loc.name])
            {
               this.uiApi.addComponentHook(componentsRef.tx_loc,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.tx_loc,ComponentHookList.ON_ROLL_OUT);
               this.uiApi.addComponentHook(componentsRef.tx_loc,ComponentHookList.ON_RIGHT_CLICK);
            }
            this._gridComponentsList[componentsRef.tx_loc.name] = data;
            if(!this._gridComponentsList[componentsRef.tx_status.name])
            {
               this.uiApi.addComponentHook(componentsRef.tx_status,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.tx_status,ComponentHookList.ON_ROLL_OUT);
            }
            this._gridComponentsList[componentsRef.tx_status.name] = data;
            if(!this._gridComponentsList[componentsRef.btn_more.name])
            {
               this.uiApi.addComponentHook(componentsRef.btn_more,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.btn_more,ComponentHookList.ON_ROLL_OUT);
               this.uiApi.addComponentHook(componentsRef.btn_more,ComponentHookList.ON_RELEASE);
            }
            this._gridComponentsList[componentsRef.btn_more.name] = data;
            if(!this._gridComponentsList[componentsRef.tx_canCraftLegendary.name])
            {
               this.uiApi.addComponentHook(componentsRef.tx_canCraftLegendary,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.tx_canCraftLegendary,ComponentHookList.ON_ROLL_OUT);
            }
            this._gridComponentsList[componentsRef.tx_canCraftLegendary.name] = data;
            componentsRef.lbl_name.text = "{player," + data.playerName + "," + data.playerId + "::" + data.playerName + "}";
            componentsRef.lbl_job.text = this.jobsApi.getJobName(data.jobId);
            componentsRef.lbl_level.text = data.jobLevel;
            componentsRef.tx_status.visible = true;
            switch(data.statusId)
            {
               case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
                  componentsRef.tx_status.uri = this.uiApi.createUri(this._iconsPath + "green.png");
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_AFK:
               case PlayerStatusEnum.PLAYER_STATUS_IDLE:
                  componentsRef.tx_status.uri = this.uiApi.createUri(this._iconsPath + "yellow.png");
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
                  componentsRef.tx_status.uri = this.uiApi.createUri(this._iconsPath + "blue.png");
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_SOLO:
                  componentsRef.tx_status.uri = this.uiApi.createUri(this._iconsPath + "red.png");
            }
            componentsRef.tx_head.uri = this.uiApi.createUri(this.uiApi.me().getConstant("heads") + data.breed + "" + (!!data.sex ? "0" : "1") + ".png");
            switch(data.alignmentSide)
            {
               case AlignmentSideEnum.ALIGNMENT_ANGEL:
                  componentsRef.tx_alignment.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "tx_alignement_bonta.png");
                  break;
               case AlignmentSideEnum.ALIGNMENT_EVIL:
                  componentsRef.tx_alignment.uri = this.uiApi.createUri(this.uiApi.me().getConstant("texture") + "tx_alignement_brakmar.png");
                  break;
               default:
                  componentsRef.tx_alignment.uri = null;
            }
            componentsRef.btn_more.visible = true;
            if(!data.isInWorkshop)
            {
               componentsRef.lbl_loc.text = "-";
            }
            else
            {
               sa = this.dataApi.getSubArea(data.subAreaId);
               txt = this.dataApi.getArea(sa.areaId).name + " " + data.worldPos;
               componentsRef.lbl_loc.text = txt;
            }
            componentsRef.tx_notFree.visible = !data.freeCraft;
            componentsRef.lbl_lvlMin.text = data.minLevelCraft;
            componentsRef.tx_canCraftLegendary.visible = this._actualJobLegendary && data.canCraftlegendary && data.jobLevel >= 200;
         }
         else
         {
            componentsRef.lbl_name.text = "";
            componentsRef.lbl_level.text = "";
            componentsRef.lbl_loc.text = "";
            componentsRef.lbl_lvlMin.text = "";
            componentsRef.tx_notFree.visible = false;
            componentsRef.tx_canCraftLegendary.visible = false;
            componentsRef.tx_alignment.uri = null;
            componentsRef.tx_head.uri = null;
            componentsRef.btn_more.visible = false;
            componentsRef.tx_status.visible = false;
            componentsRef.lbl_job.text = "";
         }
      }
      
      private function sortCrafters() : void
      {
         if(!this._crafters || this._crafters.length < 1)
         {
            return;
         }
         if(this._crafters.length == 1)
         {
            this.gd_crafters.dataProvider = this._crafters;
            return;
         }
         switch(this._sortCriteria)
         {
            case "alignmentSide":
            case "breed":
            case "jobLevel":
            case "minLevelCraft":
               if(this._bDescendingSort)
               {
                  this._crafters.sortOn([this._sortCriteria,"playerName"],[Array.NUMERIC,Array.CASEINSENSITIVE]);
               }
               else
               {
                  this._crafters.sortOn([this._sortCriteria,"playerName"],[Array.NUMERIC | Array.DESCENDING,Array.CASEINSENSITIVE]);
               }
               break;
            case "playerName":
               if(this._bDescendingSort)
               {
                  this._crafters.sortOn("playerName",Array.CASEINSENSITIVE);
               }
               else
               {
                  this._crafters.sortOn("playerName",Array.CASEINSENSITIVE | Array.DESCENDING);
               }
               break;
            case "freeCraft":
            case "worldPos":
               if(this._bDescendingSort)
               {
                  this._crafters.sortOn([this._sortCriteria,"playerName"],[0,Array.CASEINSENSITIVE]);
               }
               else
               {
                  this._crafters.sortOn([this._sortCriteria,"playerName"],[Array.DESCENDING,Array.CASEINSENSITIVE]);
               }
         }
         this.gd_crafters.dataProvider = this._crafters;
      }
      
      public function onCrafterDirectoryListUpdate(list:Object) : void
      {
         var crafter:* = undefined;
         this._crafters = [];
         for each(crafter in list)
         {
            this._crafters.push(crafter);
         }
         if(this._crafters.length == 0)
         {
            this.gd_crafters.dataProvider = this._crafters;
         }
         else
         {
            this.sortCrafters();
         }
         this.lbl_nbCrafter.text = this._crafters.length + " " + this._sCraftersText;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var data:Object = null;
         switch(target)
         {
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.btn_search:
               break;
            case this.btn_tabAli:
               if(this._sortCriteria == "alignmentSide")
               {
                  this._bDescendingSort = !this._bDescendingSort;
               }
               this._sortCriteria = "alignmentSide";
               this.sortCrafters();
               break;
            case this.btn_tabBreed:
               if(this._sortCriteria == "breed")
               {
                  this._bDescendingSort = !this._bDescendingSort;
               }
               this._sortCriteria = "breed";
               this.sortCrafters();
               break;
            case this.btn_tabName:
               if(this._sortCriteria == "playerName")
               {
                  this._bDescendingSort = !this._bDescendingSort;
               }
               this._sortCriteria = "playerName";
               this.sortCrafters();
               break;
            case this.btn_tabLevel:
               if(this._sortCriteria == "jobLevel")
               {
                  this._bDescendingSort = !this._bDescendingSort;
               }
               this._sortCriteria = "jobLevel";
               this.sortCrafters();
               break;
            case this.btn_tabCost:
               if(this._sortCriteria == "freeCraft")
               {
                  this._bDescendingSort = !this._bDescendingSort;
               }
               this._sortCriteria = "freeCraft";
               this.sortCrafters();
               break;
            case this.btn_tabCoord:
               if(this._sortCriteria == "worldPos")
               {
                  this._bDescendingSort = !this._bDescendingSort;
               }
               this._sortCriteria = "worldPos";
               this.sortCrafters();
               break;
            case this.btn_tabMinLevel:
               if(this._sortCriteria == "minLevelCraft")
               {
                  this._bDescendingSort = !this._bDescendingSort;
               }
               this._sortCriteria = "minLevelCraft";
               this.sortCrafters();
         }
         if(target.name.indexOf("btn_more") == 0)
         {
            data = this._gridComponentsList[target.name];
            this.sysApi.dispatchHook(ChatHookList.ChatFocus,data.playerName);
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var data:Object = null;
         var sa:SubArea = null;
         var area:* = null;
         if(target == this.btn_tabCoord)
         {
            tooltipText = this.uiApi.getText("ui.craft.crafterWorkshopPosition");
         }
         else if(target == this.btn_tabMinLevel)
         {
            tooltipText = this.uiApi.getText("ui.craft.minLevelCraft");
         }
         else if(target == this.btn_tabCost)
         {
            tooltipText = this.uiApi.getText("ui.craft.notFree");
         }
         else if(target.name.indexOf("Legendary") !== -1)
         {
            tooltipText = this.uiApi.getText("ui.craft.canCraftLegendary");
         }
         if(target.name.indexOf("btn_more") == 0)
         {
            tooltipText = this.uiApi.getText("ui.common.wisperMessage");
         }
         else if(target.name.indexOf("tx_status") == 0)
         {
            data = this._gridComponentsList[target.name];
            switch(data.statusId)
            {
               case PlayerStatusEnum.PLAYER_STATUS_AVAILABLE:
                  tooltipText = this.uiApi.getText("ui.chat.status.availiable");
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_IDLE:
                  tooltipText = this.uiApi.getText("ui.chat.status.idle");
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_AFK:
                  tooltipText = this.uiApi.getText("ui.chat.status.away");
                  if(data.awayMessage != null)
                  {
                     tooltipText += this.uiApi.getText("ui.common.colon") + data.awayMessage;
                  }
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_PRIVATE:
                  tooltipText = this.uiApi.getText("ui.chat.status.private");
                  break;
               case PlayerStatusEnum.PLAYER_STATUS_SOLO:
                  tooltipText = this.uiApi.getText("ui.chat.status.solo");
            }
         }
         else if(target.name.indexOf("tx_loc") == 0)
         {
            data = this._gridComponentsList[target.name];
            if(data.isInWorkshop)
            {
               sa = this.dataApi.getSubArea(data.subAreaId);
               area = this.uiApi.getText("ui.craft.nearCraftTable") + " : " + this.dataApi.getArea(sa.areaId).name + " ( " + sa.name + " )";
               tooltipText = area;
            }
         }
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",7,1,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var job:Job = null;
         switch(target)
         {
            case this.combo_job:
               if(this.combo_job.selectedIndex > 0)
               {
                  job = this._jobs[this.combo_job.selectedIndex - 1];
                  this.sysApi.sendAction(new JobCrafterDirectoryListRequestAction([job.id]));
                  this._actualJobLegendary = job.hasLegendaryCraft;
                  this.tx_hasLegendaryCraft.visible = this._actualJobLegendary;
                  this.btn_hasLegendaryCraft.visible = this._actualJobLegendary;
               }
               else
               {
                  this.gd_crafters.dataProvider = [];
                  this.lbl_nbCrafter.text = "";
               }
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
      
      public function onShortcut(s:String) : Boolean
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
   }
}
