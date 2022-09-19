package Ankama_GameUiCore.ui
{
   import Ankama_Common.Common;
   import Ankama_ContextMenu.ContextMenu;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.quest.Achievement;
   import com.ankamagames.dofus.datacenter.quest.AchievementCategory;
   import com.ankamagames.dofus.internalDatacenter.FeatureEnum;
   import com.ankamagames.dofus.internalDatacenter.appearance.OrnamentWrapper;
   import com.ankamagames.dofus.internalDatacenter.appearance.TitleWrapper;
   import com.ankamagames.dofus.internalDatacenter.communication.EmoteWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.quest.AchievementRewardsWrapper;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.OpenBookAction;
   import com.ankamagames.dofus.logic.game.common.actions.quest.AchievementRewardRequestAction;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.SocialHookList;
   import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
   import com.ankamagames.dofus.network.types.game.achievement.AchievementAchievedRewardable;
   import com.ankamagames.dofus.network.types.game.guild.GuildMember;
   import com.ankamagames.dofus.uiApi.AveragePricesApi;
   import com.ankamagames.dofus.uiApi.ConfigApi;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.QuestApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import flash.utils.Dictionary;
   
   public class RewardsUi
   {
      
      private static const TEMPORIS_CATEGORY:uint = 107;
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="ConfigApi")]
      public var configApi:ConfigApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="QuestApi")]
      public var questApi:QuestApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="AveragePricesApi")]
      public var averagePricesApi:AveragePricesApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      private const TYPE_ACHIEVEMENT_REWARD:int = 0;
      
      private const TYPE_GIFT:int = 1;
      
      private var _componentDict:Dictionary;
      
      private var _achievementCategories:Array;
      
      private var _myGuildXp:int;
      
      public var ctr_mainWindow:GraphicContainer;
      
      public var ctr_rewards:GraphicContainer;
      
      public var ctr_grid:GraphicContainer;
      
      public var gd_rewards:Grid;
      
      public var ctr_bottom:GraphicContainer;
      
      public var btn_acceptAll:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var btn_help:ButtonContainer;
      
      public var btn_rewards:ButtonContainer;
      
      public function RewardsUi()
      {
         this._componentDict = new Dictionary(true);
         this._achievementCategories = [];
         super();
      }
      
      public function main(param:Object = null) : void
      {
         var cat:AchievementCategory = null;
         var meMember:GuildMember = null;
         var myId:Number = NaN;
         var mem:GuildMember = null;
         this.sysApi.addHook(SocialHookList.GuildInformationsMemberUpdate,this.onGuildInformationsMemberUpdate);
         this.sysApi.addHook(HookList.GameFightEnd,this.onGameFightEnd);
         this.sysApi.addHook(HookList.GameFightLeave,this.onGameFightLeave);
         this.sysApi.addHook(HookList.GameFightJoin,this.onGameFightJoin);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addComponentHook(this.btn_rewards,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_rewards,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_acceptAll,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_acceptAll,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_help,ComponentHookList.ON_RELEASE);
         if(this.socialApi.hasGuild())
         {
            myId = this.playerApi.id();
            for each(mem in this.socialApi.getGuildMembers())
            {
               if(mem.id == myId)
               {
                  meMember = mem;
                  break;
               }
            }
            this._myGuildXp = meMember.experienceGivenPercent;
         }
         for each(cat in this.dataApi.getAchievementCategories())
         {
            this._achievementCategories[cat.id] = cat;
         }
         this.ctr_mainWindow.visible = false;
         this.ctr_rewards.visible = !this.playerApi.isInFight();
         this.updateList(true);
      }
      
      public function unload() : void
      {
         this.uiApi.hideTooltip();
         EnterFrameDispatcher.worker.deleteTreatments(EnterFrameDispatcher.worker.findTreatments(this,this.addReward,[]));
      }
      
      public function updateAchievementLine(data:*, compRef:*, selected:Boolean) : void
      {
         var rewardsSlotContent:Array = null;
         var i:int = 0;
         var rewardId:uint = 0;
         var item:ItemWrapper = null;
         var emote:EmoteWrapper = null;
         var spell:SpellWrapper = null;
         var title:TitleWrapper = null;
         var ornament:OrnamentWrapper = null;
         if(data)
         {
            compRef.lbl_title.text = data.title;
            if(this.sysApi.getPlayerManager().hasRights)
            {
               compRef.lbl_title.text += " (" + data.id + ")";
            }
            compRef.lbl_category.text = data.subtitle;
            compRef.lbl_title.handCursor = data.type != this.TYPE_GIFT;
            if(data.kamas > 0)
            {
               compRef.lbl_rewardsKama.text = this.utilApi.formateIntToString(data.kamas);
            }
            else
            {
               compRef.lbl_rewardsKama.text = "0";
            }
            if(!this._componentDict[compRef.lbl_rewardsXp.name])
            {
               this.uiApi.addComponentHook(compRef.lbl_rewardsXp,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(compRef.lbl_rewardsXp,ComponentHookList.ON_ROLL_OUT);
            }
            if(data.xp > 0)
            {
               compRef.lbl_rewardsXp.text = this.utilApi.formateIntToString(data.xp);
            }
            else
            {
               compRef.lbl_rewardsXp.text = "0";
            }
            rewardsSlotContent = [];
            if(data.rewardData)
            {
               for(i = 0; i < data.rewardData.itemsReward.length; i++)
               {
                  if(data.rewardData.itemsReward[i] is int)
                  {
                     item = this.dataApi.getItemWrapper(data.rewardData.itemsReward[i],0,0,data.rewardData.itemsQuantityReward[i]);
                     rewardsSlotContent.push(item);
                  }
                  else
                  {
                     rewardsSlotContent.push(data.rewardData.itemsReward[i] as ItemWrapper);
                  }
               }
               for each(rewardId in data.rewardData.emotesReward)
               {
                  emote = this.dataApi.getEmoteWrapper(rewardId);
                  rewardsSlotContent.push(emote);
               }
               for each(rewardId in data.rewardData.spellsReward)
               {
                  spell = this.dataApi.getSpellWrapper(rewardId);
                  rewardsSlotContent.push(spell);
               }
               for each(rewardId in data.rewardData.titlesReward)
               {
                  title = this.dataApi.getTitleWrapper(rewardId);
                  rewardsSlotContent.push(title);
               }
               for each(rewardId in data.rewardData.ornamentsReward)
               {
                  ornament = this.dataApi.getOrnamentWrapper(rewardId);
                  rewardsSlotContent.push(ornament);
               }
            }
            compRef.gd_rewards.dataProvider = rewardsSlotContent;
            if(!this._componentDict[compRef.gd_rewards.name])
            {
               this.uiApi.addComponentHook(compRef.gd_rewards,ComponentHookList.ON_ITEM_ROLL_OVER);
               this.uiApi.addComponentHook(compRef.gd_rewards,ComponentHookList.ON_ITEM_ROLL_OUT);
            }
            this._componentDict[compRef.gd_rewards.name] = data;
            if(!this._componentDict[compRef.btn_acceptOne.name])
            {
               this.uiApi.addComponentHook(compRef.btn_acceptOne,ComponentHookList.ON_RELEASE);
               this.uiApi.addComponentHook(compRef.btn_acceptOne,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(compRef.btn_acceptOne,ComponentHookList.ON_ROLL_OUT);
            }
            this._componentDict[compRef.btn_acceptOne.name] = data;
            if(data.type != this.TYPE_GIFT)
            {
               if(!this._componentDict[compRef.lbl_title.name])
               {
                  this.uiApi.addComponentHook(compRef.lbl_title,ComponentHookList.ON_RELEASE);
               }
               this._componentDict[compRef.lbl_title.name] = [data.type,data.id];
            }
            compRef.ctr_achievement.visible = true;
         }
         else
         {
            compRef.ctr_achievement.visible = false;
         }
      }
      
      public function updateList(firstOpening:Boolean = false) : void
      {
         var dp:Array = [];
         var apiRewardablesList:Vector.<AchievementAchievedRewardable> = this.questApi.getRewardableAchievements();
         if(apiRewardablesList.length > 0)
         {
            EnterFrameDispatcher.worker.addForeachTreatment(this,this.addReward,[dp],apiRewardablesList);
         }
         EnterFrameDispatcher.worker.addSingleTreatment(this,this.endUiInit,[dp,firstOpening]);
      }
      
      private function addReward(rewardable:AchievementAchievedRewardable, dp:Array) : void
      {
         var reward:Object = null;
         var ach:Achievement = this.dataApi.getAchievement(rewardable.id);
         if(!ach)
         {
            return;
         }
         var cat:AchievementCategory = ach.category;
         if(cat === null || cat.id === TEMPORIS_CATEGORY)
         {
            return;
         }
         if(cat.parentId != 0)
         {
            cat = this._achievementCategories[cat.parentId];
         }
         reward = {
            "title":ach.name,
            "subtitle":cat.name,
            "rewardData":null,
            "kamas":0,
            "xp":0,
            "id":rewardable.id,
            "type":this.TYPE_ACHIEVEMENT_REWARD
         };
         var rewards:AchievementRewardsWrapper = this.questApi.getAchievementReward(ach,rewardable.finishedlevel);
         reward.rewardData = rewards;
         reward.kamas = this.questApi.getAchievementKamasReward(ach,rewardable.finishedlevel);
         if(this.configApi.isFeatureWithKeywordEnabled(FeatureEnum.CHARACTER_XP))
         {
            reward.xp = this.questApi.getAchievementExperienceReward(ach,rewardable.finishedlevel);
         }
         dp.push(reward);
      }
      
      private function endUiInit(dp:Array, firstOpening:Boolean = false) : void
      {
         var nbLineToRemove:int = 0;
         var lineHeight:int = 0;
         if(this.uiApi == null)
         {
            return;
         }
         if(dp.length == 0)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return;
         }
         if(dp.length <= 4 && (!this.ctr_mainWindow.visible || firstOpening))
         {
            nbLineToRemove = 4 - dp.length;
            lineHeight = int(this.uiApi.me().getConstant("height_line"));
            this.ctr_mainWindow.height = int(this.uiApi.me().getConstant("height_tx_generalBg")) - nbLineToRemove * lineHeight;
            this.ctr_grid.height = int(this.uiApi.me().getConstant("height_tx_gridBg")) - nbLineToRemove * lineHeight;
            this.gd_rewards.height = int(this.uiApi.me().getConstant("height_grid")) - nbLineToRemove * lineHeight;
         }
         else if(dp.length > 4 && !this.ctr_mainWindow.visible)
         {
            this.ctr_mainWindow.height = int(this.uiApi.me().getConstant("height_tx_generalBg"));
            this.ctr_grid.height = int(this.uiApi.me().getConstant("height_tx_gridBg"));
            this.gd_rewards.height = int(this.uiApi.me().getConstant("height_grid"));
         }
         this.gd_rewards.dataProvider = dp;
         if(firstOpening)
         {
            this.uiApi.me().render();
         }
      }
      
      private function getMountPercentXp() : int
      {
         var xpRatio:int = 0;
         if(this.playerApi.getMount() != null && this.playerApi.isRidding() && this.playerApi.getMount().xpRatio > 0)
         {
            xpRatio = this.playerApi.getMount().xpRatio;
         }
         return xpRatio;
      }
      
      public function onAchievementRewardSuccess() : void
      {
         this.updateList();
      }
      
      public function onGuildInformationsMemberUpdate(member:Object) : void
      {
         if(member.id == this.playerApi.id())
         {
            this._myGuildXp = member.experienceGivenPercent;
         }
      }
      
      public function onRewardableAchievementsVisible() : void
      {
         if(this.ctr_mainWindow.visible)
         {
            this.updateList();
         }
      }
      
      public function onGameFightEnd(... rest) : void
      {
         this.ctr_rewards.visible = this.updateVisibility();
      }
      
      public function onGameFightLeave(charId:Number) : void
      {
         this.ctr_rewards.visible = this.updateVisibility();
      }
      
      public function onGameFightJoin(... rest) : void
      {
         this.ctr_rewards.visible = false;
         this.ctr_mainWindow.visible = false;
      }
      
      private function updateVisibility() : Boolean
      {
         var rewards:* = this.questApi.getRewardableAchievements();
         return rewards && rewards.length > 0;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var data:Object = null;
         var achievementDescr:Object = null;
         switch(target)
         {
            case this.btn_close:
               this.ctr_rewards.visible = true;
               this.ctr_mainWindow.visible = false;
               this.sysApi.dispatchHook(HookList.RewardsOpenClose);
               break;
            case this.btn_acceptAll:
               if(this.sysApi.getCurrentServer().gameTypeId == GameServerTypeEnum.SERVER_TYPE_TEMPORIS)
               {
                  for each(achievementDescr in this.gd_rewards.dataProvider)
                  {
                     this.sysApi.sendAction(new AchievementRewardRequestAction([achievementDescr.id]));
                  }
               }
               else
               {
                  this.sysApi.sendAction(new AchievementRewardRequestAction([-1]));
               }
               break;
            case this.btn_help:
               this.hintsApi.showSubHints();
               break;
            case this.btn_rewards:
               if(!this.ctr_mainWindow.visible)
               {
                  this.updateList();
               }
               EnterFrameDispatcher.worker.addSingleTreatment(this,this.changeVisibility,[]);
               this.sysApi.dispatchHook(HookList.RewardsOpenClose);
               break;
            default:
               if(target.name.indexOf("btn_acceptOne") != -1)
               {
                  data = this._componentDict[target.name];
                  if(data.type == this.TYPE_ACHIEVEMENT_REWARD)
                  {
                     this.sysApi.sendAction(new AchievementRewardRequestAction([data.id]));
                  }
               }
               else if(target.name.indexOf("lbl_title") != -1)
               {
                  data = this._componentDict[target.name];
                  if(data[0] == this.TYPE_ACHIEVEMENT_REWARD)
                  {
                     data = {};
                     data.achievementId = this._componentDict[target.name][1];
                     data.forceOpen = true;
                     this.sysApi.sendAction(new OpenBookAction(["achievementTab",data]));
                  }
               }
         }
      }
      
      private function changeVisibility() : void
      {
         this.ctr_mainWindow.visible = !this.ctr_mainWindow.visible;
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         var myMountXp:int = 0;
         var pos:Object = {
            "point":LocationEnum.POINT_BOTTOM,
            "relativePoint":LocationEnum.POINT_TOP
         };
         if(this.configApi.isFeatureWithKeywordEnabled(FeatureEnum.CHARACTER_XP))
         {
            if(target.name.indexOf("btn_acceptOne") != -1)
            {
               text = this.uiApi.getText("ui.achievement.rewardsGet");
            }
            myMountXp = this.getMountPercentXp();
            if(target == this.btn_acceptAll && myMountXp || this._myGuildXp)
            {
               text = this.uiApi.getText("ui.popup.warning");
            }
            if(myMountXp)
            {
               text += "\n" + this.uiApi.getText("ui.achievement.mountXpPercent",myMountXp);
            }
            if(this._myGuildXp)
            {
               text += "\n" + this.uiApi.getText("ui.achievement.guildXpPercent",this._myGuildXp);
            }
         }
         else if(this.dataApi.getCurrentTemporisSeasonNumber() == 5 && target.name.indexOf("lbl_rewardsXp") != -1)
         {
            text = this.uiApi.getText("ui.temporis.xpInformation");
         }
         if(target == this.btn_rewards)
         {
            text = this.uiApi.getText("ui.achievement.rewardsWaiting");
         }
         if(text)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onItemRightClick(target:GraphicContainer, item:Object) : void
      {
         var data:Object = null;
         var contextMenu:Object = null;
         if(item.data && target.name.indexOf("gd_rewards") != -1)
         {
            data = item.data;
            if(data == null || !(data is ItemWrapper))
            {
               return;
            }
            contextMenu = this.menuApi.create(data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
      
      public function onItemRollOver(target:GraphicContainer, item:Object) : void
      {
         var text:String = null;
         var pos:Object = null;
         if(item.data && target.name.indexOf("gd_rewards") != -1)
         {
            pos = {
               "point":LocationEnum.POINT_BOTTOM,
               "relativePoint":LocationEnum.POINT_TOP
            };
            if(item.data is ItemWrapper)
            {
               text = item.data.name;
               text += this.averagePricesApi.getItemAveragePriceString(item.data,true);
            }
            else if(item.data is EmoteWrapper)
            {
               text = this.uiApi.getText("ui.common.emote",item.data.emote.name);
            }
            else if(item.data is SpellWrapper)
            {
               text = this.uiApi.getText("ui.common.spell",item.data.spell.name);
            }
            else if(item.data is TitleWrapper)
            {
               text = this.uiApi.getText("ui.common.title",item.data.title.name);
            }
            else if(item.data is OrnamentWrapper)
            {
               text = this.uiApi.getText("ui.common.ornament",item.data.name);
            }
            if(text)
            {
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",pos.point,pos.relativePoint,3,null,null,null,"TextInfo");
            }
         }
      }
      
      public function onItemRollOut(target:GraphicContainer, item:Object) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "closeUi":
               if(!this.ctr_mainWindow.visible)
               {
                  return false;
               }
               this.ctr_mainWindow.visible = false;
               return true;
               break;
            default:
               return false;
         }
      }
   }
}
