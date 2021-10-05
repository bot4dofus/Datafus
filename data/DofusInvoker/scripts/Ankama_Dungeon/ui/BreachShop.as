package Ankama_Dungeon.ui
{
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.misc.BreachBoss;
   import com.ankamagames.dofus.datacenter.misc.BreachPrize;
   import com.ankamagames.dofus.datacenter.monsters.Monster;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.logic.game.common.actions.breach.BreachRewardBuyAction;
   import com.ankamagames.dofus.logic.game.common.actions.breach.BreachSaveBuyAction;
   import com.ankamagames.dofus.misc.lists.BreachHookList;
   import com.ankamagames.dofus.network.enums.BreachRewardLockEnum;
   import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupLightInformations;
   import com.ankamagames.dofus.uiApi.BreachApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import flash.utils.Dictionary;
   
   public class BreachShop
   {
       
      
      [Api(name="BreachApi")]
      public var breachApi:BreachApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="InventoryApi")]
      public var inventoryApi:InventoryApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      private var _componentsList:Dictionary;
      
      private var _rewards:Array;
      
      public var lbl_budget:Label;
      
      public var tx_budget:TextureBitmap;
      
      public var gd_rewards:Grid;
      
      public function BreachShop()
      {
         this._componentsList = new Dictionary(true);
         this._rewards = [];
         super();
      }
      
      public function main(oParam:Object = null) : void
      {
         this.sysApi.addHook(BreachHookList.OpenBreachShop,this.onOpenBreachShop);
         this.sysApi.addHook(BreachHookList.BreachRewardBought,this.onRewardBought);
         this.sysApi.addHook(BreachHookList.BreachSaveBought,this.onSaveBought);
         this.sysApi.addHook(BreachHookList.BreachSaved,this.onSaveBought);
         this.sysApi.addHook(BreachHookList.BreachBudget,this.onUpdateBudget);
         this.uiApi.addComponentHook(this.tx_budget,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.tx_budget,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.lbl_budget,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.lbl_budget,ComponentHookList.ON_ROLL_OUT);
         if(oParam)
         {
            this._rewards = oParam.rewards;
            this.updateUi();
         }
         else
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      public function unload() : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function updateUi() : void
      {
         this.updateBudget();
         this.updateRewardsArray();
      }
      
      public function updateBudget() : void
      {
         this.lbl_budget.text = this.utilApi.kamasToString(this.breachApi.getBudget(),"");
         this.lbl_budget.fullWidth();
      }
      
      public function updateRewardsArray() : void
      {
         var currency:int = 0;
         var reward:Object = null;
         var prize:BreachPrize = null;
         var budget:int = this.breachApi.getBudget();
         var fragments:int = this.inventoryApi.getItemQty(DataEnum.ITEM_GID_BREACH_FRAGMENTS);
         for each(reward in this._rewards)
         {
            if(reward.buyLocks.indexOf(BreachRewardLockEnum.BREACH_REWARD_LOCK_RESOURCES) == -1)
            {
               prize = this.dataApi.getBreachPrizeById(reward.id);
               if(prize)
               {
                  currency = prize.currency;
                  if(currency == 0 && reward.price > budget || currency == 1 && reward.price > fragments)
                  {
                     reward["buyLocks"].push(BreachRewardLockEnum.BREACH_REWARD_LOCK_RESOURCES);
                     reward["buyLocks"] = reward.buyLocks.sort(Array.NUMERIC);
                  }
               }
            }
         }
         this.gd_rewards.dataProvider = this._rewards.sort(this.breachApi.rewardSpecificSort);
         this.gd_rewards.updateItems();
      }
      
      public function updateRewards(data:*, componentsRef:*, selected:Boolean) : void
      {
         var reward:BreachPrize = null;
         var changeBoss:* = false;
         if(!this._componentsList[componentsRef.tx_rewardBought.name])
         {
            this.uiApi.addComponentHook(componentsRef.tx_rewardBought,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.tx_rewardBought,ComponentHookList.ON_ROLL_OUT);
         }
         this._componentsList[componentsRef.tx_rewardBought.name] = data;
         if(!this._componentsList[componentsRef.btn_buyReward.name])
         {
            this.uiApi.addComponentHook(componentsRef.btn_buyReward,ComponentHookList.ON_RELEASE);
            this.uiApi.addComponentHook(componentsRef.btn_buyReward,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.btn_buyReward,ComponentHookList.ON_ROLL_OUT);
         }
         this._componentsList[componentsRef.btn_buyReward.name] = data;
         if(!this._componentsList[componentsRef.lbl_rewardName.name])
         {
            this.uiApi.addComponentHook(componentsRef.lbl_rewardName,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.lbl_rewardName,ComponentHookList.ON_ROLL_OUT);
         }
         this._componentsList[componentsRef.lbl_rewardName.name] = data;
         if(!this._componentsList[componentsRef.tx_warning.name])
         {
            this.uiApi.addComponentHook(componentsRef.tx_warning,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(componentsRef.tx_warning,ComponentHookList.ON_ROLL_OUT);
         }
         if(data)
         {
            reward = this.dataApi.getBreachPrizeById(data.id);
            if(!reward)
            {
               return;
            }
            componentsRef.lbl_rewardQuantity.y = 10;
            componentsRef.lbl_rewardName.text = reward.name;
            if(data.remainingQty == 0)
            {
               componentsRef.btn_buyReward.visible = false;
               componentsRef.lbl_rewardPrice.visible = false;
               componentsRef.tx_rewardCurrency.visible = false;
               componentsRef.tx_rewardBought.visible = true;
               componentsRef.tx_warning.visible = false;
               componentsRef.lbl_rewardQuantity.visible = false;
               componentsRef.tx_rewardInfinite.visible = false;
            }
            else
            {
               componentsRef.btn_buyReward.visible = true;
               componentsRef.lbl_rewardPrice.visible = true;
               componentsRef.tx_rewardCurrency.visible = true;
               componentsRef.tx_rewardBought.visible = false;
               componentsRef.lbl_rewardPrice.text = this.utilApi.kamasToString(data.price,"");
               componentsRef.lbl_rewardPrice.x = parseInt(this.uiApi.me().getConstant("btnBuyRewardCenterX")) - componentsRef.lbl_rewardPrice.width - 3;
               componentsRef.lbl_rewardPrice.y = parseInt(this.uiApi.me().getConstant("rewardLabelPricePosTopY"));
               componentsRef.tx_rewardCurrency.uri = !!reward.currency ? this.uiApi.createUri(this.uiApi.me().getConstant("fragments_uri")) : this.uiApi.createUri(this.uiApi.me().getConstant("budget_uri"));
               componentsRef.tx_rewardCurrency.x = parseInt(this.uiApi.me().getConstant("btnBuyRewardCenterX"));
               componentsRef.tx_rewardCurrency.y = parseInt(this.uiApi.me().getConstant("rewardCurrencyPosTopY"));
               componentsRef.btn_buyReward.softDisabled = data.buyLocks.length > 0;
               if(reward.categoryId == DataEnum.BREACH_REWARD_ADD_BOSS)
               {
                  changeBoss = this.checkAddBossReward(this.dataApi.getBreachBossByRewardId(reward.id)).length > 0;
                  componentsRef.tx_warning.visible = changeBoss;
                  this._componentsList[componentsRef.tx_warning.name] = this.checkAddBossReward(this.dataApi.getBreachBossByRewardId(reward.id));
                  componentsRef.lbl_rewardQuantity.x = !!changeBoss ? 243 : 218;
                  componentsRef.tx_rewardInfinite.x = !!changeBoss ? 243 : 218;
               }
               else
               {
                  componentsRef.tx_warning.visible = false;
                  componentsRef.lbl_rewardQuantity.x = 243;
                  componentsRef.tx_rewardInfinite.x = 243;
               }
               componentsRef.lbl_rewardQuantity.text = "x" + data.remainingQty;
               componentsRef.lbl_rewardQuantity.visible = data.remainingQty > 1;
               componentsRef.tx_rewardInfinite.visible = data.remainingQty < 0;
            }
            componentsRef.ctr_reward.visible = true;
         }
         else
         {
            componentsRef.ctr_reward.visible = false;
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         if(target.name.indexOf("btn_buySave") != -1)
         {
            this.sysApi.sendAction(new BreachSaveBuyAction([]));
         }
         else if(target.name.indexOf("btn_buyReward") != -1)
         {
            this.sysApi.sendAction(new BreachRewardBuyAction([this._componentsList[target.name].id]));
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var locks:Vector.<uint> = null;
         var prizeCurrency:* = false;
         var ttData:Object = null;
         var reward:BreachPrize = null;
         var bossToRemove:Array = null;
         var text:* = null;
         var bossData:Object = null;
         var bossInfo:MonsterInGroupLightInformations = null;
         var boss:Monster = null;
         switch(target)
         {
            case this.lbl_budget:
               ttData = {
                  "title":this.uiApi.getText("ui.breach.groupBudget"),
                  "text":this.uiApi.getText("ui.breach.groupBudgetDescription")
               };
               this.uiApi.showTooltip(ttData,target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,"textWithTitle",null,null);
               break;
            default:
               if(target.name.indexOf("btn_buyReward") != -1 || target.name.indexOf("lbl_rewardName") != -1)
               {
                  locks = this._componentsList[target.name].buyLocks.concat();
                  reward = this.dataApi.getBreachPrizeById(this._componentsList[target.name].id);
                  if(!reward)
                  {
                     return;
                  }
                  prizeCurrency = !reward.currency;
                  ttData = {
                     "locks":locks,
                     "criterion":this._componentsList[target.name].buyCriterion,
                     "description":reward.description,
                     "item":reward.item,
                     "name":reward.name
                  };
                  this.uiApi.showTooltip(ttData,target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,"breachReward",null,{
                     "isBudget":prizeCurrency,
                     "criterion":this._componentsList[target.name].buyCriterion
                  });
               }
               else if(target.name.indexOf("tx_warning") != -1)
               {
                  bossToRemove = this._componentsList[target.name];
                  text = this.uiApi.getText("ui.breachReward.addBossWarning") + "\n";
                  for each(bossData in bossToRemove)
                  {
                     text += "\n" + this.uiApi.getText("ui.breach.roomNumber",bossData.room) + " - ";
                     for each(bossInfo in bossData.bosses)
                     {
                        boss = this.dataApi.getMonsterFromId(bossInfo.genericId);
                        text += boss.name;
                     }
                  }
                  this.uiApi.showTooltip(this.uiApi.textTooltipInfo(text),target,false,"standard",LocationEnum.POINT_TOP,LocationEnum.POINT_BOTTOM,3,null,null,null);
               }
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      private function onOpenBreachShop(rewards:Array) : void
      {
         this._rewards = rewards;
         this.updateUi();
      }
      
      private function onSaveBought(bought:Boolean) : void
      {
         this.updateBudget();
         this.updateRewardsArray();
      }
      
      private function onRewardBought(id:uint, bought:Boolean) : void
      {
         var reward:Object = null;
         this.updateBudget();
         for each(reward in this._rewards)
         {
            if(reward["id"] == id)
            {
               if(reward["remainingQty"] > 0)
               {
                  --reward["remainingQty"];
               }
            }
         }
         this.updateRewardsArray();
      }
      
      private function onUpdateBudget() : void
      {
         this.updateBudget();
      }
      
      private function checkAddBossReward(boss:BreachBoss) : Array
      {
         var element:* = null;
         var branch:Object = null;
         var bossInfo:MonsterInGroupLightInformations = null;
         var tempBoss:BreachBoss = null;
         if(!boss)
         {
            return [];
         }
         var bossToReroll:Array = [];
         var branches:Dictionary = this.breachApi.getBranches();
         for(element in branches)
         {
            branch = branches[element];
            for each(bossInfo in branch.bosses)
            {
               if(branch.bosses.length <= 1)
               {
                  tempBoss = this.dataApi.getBreachBossByMonsterId(bossInfo.genericId);
                  if(tempBoss.incompatibleBosses.indexOf(boss.id) != -1 || boss.incompatibleBosses.indexOf(tempBoss.id) != -1)
                  {
                     bossToReroll.push(branch);
                  }
               }
            }
         }
         bossToReroll.sortOn("room",Array.NUMERIC);
         return bossToReroll;
      }
   }
}
