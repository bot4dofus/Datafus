package Ankama_Job.ui
{
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeCraftPaymentModificationAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeReadyAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.DisplayContextualMenuAction;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.types.game.context.roleplay.job.JobExperience;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.events.TimerEvent;
   
   public class CraftCoop extends Craft
   {
      
      public static const EXCHANGE_COLOR_NORMAL:int = 0;
      
      public static const EXCHANGE_COLOR_GREEN:int = 1;
      
      public static const BUTTON_STATE_CANCEL:int = 3;
      
      public static const READY_STEP_NOT_READY:int = 0;
      
      public static const READY_STEP_I_AM_READY:int = 1;
      
      public static const READY_STEP_HE_IS_READY:int = 2;
      
      private static const MAX_SLOT_NUMBER:int = 8;
       
      
      public var slot_ingredient_1_other:Slot;
      
      public var slot_ingredient_2_other:Slot;
      
      public var slot_ingredient_3_other:Slot;
      
      public var slot_ingredient_4_other:Slot;
      
      public var slot_ingredient_5_other:Slot;
      
      public var slot_ingredient_6_other:Slot;
      
      public var slot_ingredient_7_other:Slot;
      
      public var slot_ingredient_8_other:Slot;
      
      public var ed_player_other:EntityDisplayer;
      
      public var lbl_name_other:Label;
      
      public var lbl_job_other:Label;
      
      public var tx_ingredients_selected:Texture;
      
      public var tx_ingredients_selected_other:Texture;
      
      public var tx_bgPayment:TextureBitmap;
      
      public var lbl_payment:Label;
      
      protected var _isPlayerCrafter:Boolean;
      
      protected var _playerInfos:Object;
      
      protected var _crafterInfos:Object;
      
      protected var _customerInfos:Object;
      
      protected var _cancelText:String;
      
      private var _exchangeValidated:Boolean = false;
      
      private var _slotsIngredients_other:Array;
      
      protected var _waitingGrid:Object;
      
      private var _nbSlotsOtherOccupied:int = 0;
      
      private var _nbSlotsOccupied:int = 0;
      
      private var _nbItemOther:int = 0;
      
      private var _nbItem:int = 0;
      
      private var _prevItems:Array;
      
      private var _prevItemsOther:Array;
      
      private var _timeDelay:Number = 2000;
      
      protected var _timerDelay:BenchmarkTimer;
      
      public function CraftCoop()
      {
         this._prevItems = [];
         this._prevItemsOther = [];
         super();
      }
      
      override public function main(args:Object) : void
      {
         var slot:Slot = null;
         var jobXp:JobExperience = null;
         var percentLvl:Number = NaN;
         this._slotsIngredients_other = [this.slot_ingredient_1_other,this.slot_ingredient_2_other,this.slot_ingredient_3_other,this.slot_ingredient_4_other,this.slot_ingredient_5_other,this.slot_ingredient_6_other,this.slot_ingredient_7_other,this.slot_ingredient_8_other];
         this._playerInfos = playerApi.getPlayedCharacterInfo();
         this._crafterInfos = args.crafterInfos;
         this._customerInfos = args.customerInfos;
         this._isPlayerCrafter = this._playerInfos.id == this._crafterInfos.id;
         this._cancelText = uiApi.getText("ui.common.cancel");
         this._nbSlotsOtherOccupied = 0;
         this._nbSlotsOccupied = 0;
         this._nbItem = 0;
         this._nbItemOther = 0;
         this._prevItems = [];
         this._prevItemsOther = [];
         sysApi.addHook(CraftHookList.PlayerListUpdate,this.onPlayerListUpdate);
         sysApi.addHook(CraftHookList.JobsExpOtherPlayerUpdated,this.onJobsExpOtherPlayerUpdated);
         if(!this._isPlayerCrafter)
         {
            _jobLevel = this._crafterInfos.skillLevel;
            args.jobLevel = _jobLevel;
         }
         super.main(args);
         if(!this._isPlayerCrafter && args.jobExperience)
         {
            jobXp = args.jobExperience as JobExperience;
            if(jobXp.jobId == _jobId)
            {
               _jobLevel = jobXp.jobLevel;
               _jobXP = jobXp.jobXP;
               _jobXpLevelFloor = jobXp.jobXpLevelFloor;
               _jobXpNextLevelFloor = jobXp.jobXpNextLevelFloor;
               percentLvl = (_jobXP - _jobXpLevelFloor) / (_jobXpNextLevelFloor - _jobXpLevelFloor);
               if(percentLvl > 1 || _jobXpNextLevelFloor == 0)
               {
                  percentLvl = 1;
               }
               sysApi.log(2,"jauge : " + percentLvl + " = (" + _jobXP + " - " + _jobXpLevelFloor + ") / (" + _jobXpNextLevelFloor + " - " + _jobXpLevelFloor + ")");
               pb_progressBar_other.value = percentLvl;
            }
         }
         sysApi.addHook(ExchangeHookList.ExchangeIsReady,this.onExchangeIsReady);
         sysApi.addHook(CraftHookList.OtherPlayerListUpdate,this.onOtherPlayerListUpdate);
         sysApi.addHook(CraftHookList.PaymentCraftList,this.onPaymentCraftList);
         uiApi.addComponentHook(this.ed_player_other,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(this.ed_player_other,ComponentHookList.ON_RIGHT_CLICK);
         uiApi.addComponentHook(this.ed_player_other,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(this.ed_player_other,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(ed_player,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(ed_player,ComponentHookList.ON_ROLL_OUT);
         uiApi.addComponentHook(this.lbl_payment,ComponentHookList.ON_RELEASE);
         uiApi.addComponentHook(pb_progressBar_other,ComponentHookList.ON_ROLL_OVER);
         uiApi.addComponentHook(pb_progressBar_other,ComponentHookList.ON_ROLL_OUT);
         for each(slot in this._slotsIngredients_other)
         {
            slot.dropValidator = this.dropValidatorFunction as Function;
            slot.processDrop = processDropFunction as Function;
            uiApi.addComponentHook(slot,ComponentHookList.ON_ROLL_OVER);
            uiApi.addComponentHook(slot,ComponentHookList.ON_ROLL_OUT);
            uiApi.addComponentHook(slot,ComponentHookList.ON_DOUBLE_CLICK);
            uiApi.addComponentHook(slot,ComponentHookList.ON_RIGHT_CLICK);
            uiApi.addComponentHook(slot,ComponentHookList.ON_RELEASE);
            slot.emptyTexture = uiApi.createUri(uiApi.me().getConstant("emptySlot"));
            slot.refresh();
         }
         this.tx_ingredients_selected.gotoAndStop = "green";
         this.tx_ingredients_selected.visible = false;
         this.tx_ingredients_selected_other.gotoAndStop = "green";
         this.tx_ingredients_selected_other.visible = false;
         ed_player.yOffset = 30;
         ed_player.entityScale = 1.5;
         ed_player.direction = 3;
         this.ed_player_other.yOffset = 30;
         this.ed_player_other.entityScale = 1.5;
         this.ed_player_other.direction = 1;
         ed_player.mouseEnabled = true;
         ed_player.handCursor = true;
         this.ed_player_other.mouseEnabled = true;
         this.ed_player_other.handCursor = true;
         if(this._isPlayerCrafter)
         {
            sysApi.log(2,"le joueur est l\'artisan");
            this.tx_bgPayment.disabled = true;
            this.lbl_payment.disabled = true;
            ed_player.look = this._crafterInfos.look;
            this.ed_player_other.look = this._customerInfos.look;
            this.lbl_name_other.text = this._customerInfos.name;
            this.lbl_job_other.text = uiApi.getText("ui.craft.client");
            if(_skill.parentJobId == DataEnum.JOB_ID_BASE)
            {
               lbl_job.text = uiApi.getText("ui.craft.crafter");
            }
            else
            {
               lbl_job.text = _updatedJob.name + _lvlText + _jobLevel;
            }
            pb_progressBar_other.visible = false;
         }
         else
         {
            sysApi.log(2,"l\'autre est l\'artisan");
            slot_signature.disabled = true;
            ed_player.look = this._customerInfos.look;
            this.ed_player_other.look = this._crafterInfos.look;
            this.lbl_name_other.text = this._crafterInfos.name;
            if(_skill.parentJobId == DataEnum.JOB_ID_BASE)
            {
               this.lbl_job_other.text = uiApi.getText("ui.craft.crafter");
            }
            else
            {
               this.lbl_job_other.text = _updatedJob.name + _lvlText + _jobLevel;
            }
            lbl_job.text = uiApi.getText("ui.craft.client");
            pb_progressBar.visible = false;
         }
         this._timerDelay = new BenchmarkTimer(this._timeDelay,1,"CraftCoop._timerDelay");
         this._timerDelay.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerDelayValidateButton);
         this.switchReadyStep(READY_STEP_NOT_READY);
         if(playerApi.hasDebt())
         {
            this.debtRestrictions();
         }
      }
      
      override protected function dropValidatorFunction(target:Object, data:Object, source:Object) : Boolean
      {
         if(target.name.indexOf("other") != -1)
         {
            return false;
         }
         return super.dropValidatorFunction(target,data,source);
      }
      
      override public function fillAutoSlot(item:Object, quantity:int, force:Boolean = false) : void
      {
         var nb:int = this.getRealNumberItemForPlayer(this._prevItems.concat(this._prevItemsOther));
         if(item.id == DataEnum.ITEM_GID_SIGNATURE_RUNE || nb < MAX_SLOT_NUMBER || nb == MAX_SLOT_NUMBER && this.isInOneOfTheGrid(item.objectGID))
         {
            super.fillAutoSlot(item,quantity,true);
         }
      }
      
      private function getRealNumberItemForPlayer(data:Array) : int
      {
         var item:int = 0;
         var tmpTab:Vector.<uint> = new Vector.<uint>();
         for each(item in data)
         {
            if(item != DataEnum.ITEM_GID_SIGNATURE_RUNE && tmpTab.indexOf(item) == -1)
            {
               tmpTab.push(item);
            }
         }
         return tmpTab.length;
      }
      
      override public function containAtLeastOneIngredient() : Boolean
      {
         return slot_ingredient_1.data || this.slot_ingredient_1_other.data;
      }
      
      override public function unload() : void
      {
         super.unload();
         _slotsIngredients = [];
         this._slotsIngredients_other = [];
         this._timerDelay.stop();
         this._timerDelay.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerDelayValidateButton);
         storageApi.removeAllItemMasks("smithMagicBag");
         storageApi.removeAllItemMasks("paymentAlways");
         storageApi.removeAllItemMasks("paymentSuccess");
         storageApi.releaseHooks();
      }
      
      private function onExchangeIsReady(playerName:String, isReady:Boolean) : void
      {
         if(isReady)
         {
            if(this._playerInfos.name == playerName)
            {
               this.switchReadyStep(READY_STEP_I_AM_READY);
            }
            else
            {
               this.switchReadyStep(READY_STEP_HE_IS_READY);
            }
         }
         else
         {
            this.switchReadyStep(READY_STEP_NOT_READY);
         }
      }
      
      private function onPlayerListUpdate(playerList:Object) : void
      {
         var slots:Array = null;
         var datas:Object = this.updatePlayer(playerList.componentList,1);
         if(datas.index && datas.index >= 0)
         {
            slots = datas.player == 1 ? _slotsIngredients : this._slotsIngredients_other;
            if(datas.type)
            {
               if(datas.type == "block" && datas.player == 2)
               {
                  ++this._nbSlotsOtherOccupied;
               }
               else if(datas.type == "normal" && datas.player == 1)
               {
                  --this._nbSlotsOccupied;
               }
               else if(datas.type == "block" && datas.player == 1)
               {
                  ++this._nbSlotsOccupied;
               }
               else if(datas.type == "normal" && datas.player == 2)
               {
                  --this._nbSlotsOtherOccupied;
               }
               slots[datas.index].emptyTexture = datas.type == "block" ? uiApi.createUri(uiApi.me().getConstant("lockedSlot")) : uiApi.createUri(uiApi.me().getConstant("emptySlot"));
            }
            if(datas.updateItemsNumber)
            {
               this._nbItem += datas.updateItemsNumber;
            }
            if(datas.index < slots.length)
            {
               slots[datas.index].refresh();
            }
         }
         this._prevItems = this.updateTabWithGid(playerList.componentList);
      }
      
      public function updatePlayer(componentList:Object, player:uint) : Object
      {
         var val:ItemWrapper = null;
         var ingredients:Array = [];
         for each(val in componentList)
         {
            ingredients.push(val);
         }
         if(player == 1)
         {
            return this.updateLogic(ingredients,this._nbItem,this._nbSlotsOccupied,this._nbSlotsOtherOccupied,_slotsIngredients,this._slotsIngredients_other,this._prevItems);
         }
         if(player == 2)
         {
            return this.updateLogic(ingredients,this._nbItemOther,this._nbSlotsOtherOccupied,this._nbSlotsOccupied,this._slotsIngredients_other,_slotsIngredients,this._prevItemsOther);
         }
         throw "You have to specify a player !!";
      }
      
      private function updateLogic(componentList:Array, nbItem:int, nbOccupied1:int, nbOccupied2:int, slots1:Array, slots2:Array, previousItems:Array) : Object
      {
         var itemgid:int = 0;
         var missingItemGid:int = 0;
         var datas:Object = {};
         if(componentList[componentList.length - 1] && componentList[componentList.length - 1].objectGID != DataEnum.ITEM_GID_SIGNATURE_RUNE || componentList.length == 0)
         {
            if(componentList.length > nbItem)
            {
               itemgid = componentList[componentList.length - 1].objectGID;
               if(!this.hasItemInGrid(itemgid,slots1))
               {
                  datas.updateItemsNumber = 1;
                  if(!this.hasItemInGrid(itemgid,slots2))
                  {
                     datas.index = MAX_SLOT_NUMBER - (nbOccupied2 + 1);
                     datas.player = 2;
                     datas.type = "block";
                  }
                  else if(nbOccupied1 > 0)
                  {
                     datas.index = MAX_SLOT_NUMBER - nbOccupied1;
                     datas.player = 1;
                     datas.type = "normal";
                  }
               }
            }
            else if(componentList.length < nbItem)
            {
               missingItemGid = this.getMissingItemGid(componentList,previousItems);
               if(missingItemGid == DataEnum.ITEM_GID_SIGNATURE_RUNE)
               {
                  return datas;
               }
               datas.updateItemsNumber = -1;
               if(this.hasItemInGrid(missingItemGid,slots2))
               {
                  datas.index = MAX_SLOT_NUMBER - (nbOccupied1 + 1);
                  datas.type = "block";
                  datas.player = 1;
               }
               else if(nbOccupied2 > 0)
               {
                  datas.index = MAX_SLOT_NUMBER - nbOccupied2;
                  datas.type = "normal";
                  datas.player = 2;
               }
            }
            else
            {
               datas.index = nbItem - 1;
               datas.player = 1;
            }
         }
         return datas;
      }
      
      private function onOtherPlayerListUpdate(playerList:Object) : void
      {
         var slots:Array = null;
         var datas:Object = this.updatePlayer(playerList.componentList,2);
         if(datas.index && datas.index >= 0)
         {
            slots = datas.player == 2 ? _slotsIngredients : this._slotsIngredients_other;
            if(datas.type)
            {
               if(datas.type == "block" && datas.player == 2)
               {
                  ++this._nbSlotsOccupied;
               }
               else if(datas.type == "normal" && datas.player == 1)
               {
                  --this._nbSlotsOtherOccupied;
               }
               else if(datas.type == "block" && datas.player == 1)
               {
                  ++this._nbSlotsOtherOccupied;
               }
               else if(datas.type == "normal" && datas.player == 2)
               {
                  --this._nbSlotsOccupied;
               }
               slots[datas.index].emptyTexture = uiApi.createUri(uiApi.me().getConstant(datas.type == "block" ? "lockedSlot" : "emptySlot"));
            }
            if(datas.updateItemsNumber)
            {
               this._nbItemOther += datas.updateItemsNumber;
            }
            if(datas.index < slots.length)
            {
               slots[datas.index].refresh();
            }
         }
         this._prevItemsOther = this.updateTabWithGid(playerList.componentList);
         fillComponents(playerList.componentList,this._slotsIngredients_other,slot_signature);
         this.setOkButtonTemporaryDisabled();
      }
      
      public function hasItemInGrid(gid:int, data:Array) : Boolean
      {
         var slot:Object = null;
         for each(slot in data)
         {
            if(slot.data && slot.data.objectGID == gid)
            {
               return true;
            }
         }
         return false;
      }
      
      private function updateTabWithGid(datas:Object) : Array
      {
         var data:Object = null;
         var tab:Array = [];
         for each(data in datas)
         {
            if(tab.indexOf(data.objectGID) == -1)
            {
               tab.push(data.objectGID);
            }
         }
         return tab;
      }
      
      public function getMissingItemGid(list:Object, previousData:Array) : int
      {
         var found:Boolean = false;
         var item:ItemWrapper = null;
         var id:int = 0;
         for each(id in previousData)
         {
            found = false;
            for each(item in list)
            {
               if(id == item.objectGID)
               {
                  found = true;
               }
            }
            if(!found)
            {
               return id;
            }
         }
         return -1;
      }
      
      private function isInOneOfTheGrid(gid:int) : Boolean
      {
         return this.hasItemInGrid(gid,_slotsIngredients.concat(this._slotsIngredients_other));
      }
      
      private function onPaymentCraftList(paymentData:Object, highlight:Boolean) : void
      {
         this.lbl_payment.text = utilApi.kamasToString(paymentData.kamaPayment,"");
      }
      
      private function onTimerDelayValidateButton(e:TimerEvent) : void
      {
         btn_ok.disabled = !this.containAtLeastOneIngredient();
      }
      
      override protected function onJobsExpUpdated(jobId:uint) : void
      {
         if(this._isPlayerCrafter)
         {
            super.onJobsExpUpdated(jobId);
         }
      }
      
      protected function onJobsExpOtherPlayerUpdated(playerId:Number, jobExperience:Object) : void
      {
         var jobXp:JobExperience = null;
         var percentLvl:Number = NaN;
         if(!this._isPlayerCrafter && playerId == this._crafterInfos.id)
         {
            jobXp = jobExperience as JobExperience;
            if(jobXp.jobId == _jobId)
            {
               if(_jobLevel != jobXp.jobLevel)
               {
                  _jobLevel = jobXp.jobLevel;
                  this.lbl_job_other.text = _updatedJob.name + _lvlText + _jobLevel;
                  if(jobXp.jobLevel == ProtocolConstantsEnum.MAX_JOB_LEVEL)
                  {
                     ctr_signature.visible = true;
                  }
               }
               _jobXP = jobXp.jobXP;
               _jobXpLevelFloor = jobXp.jobXpLevelFloor;
               _jobXpNextLevelFloor = jobXp.jobXpNextLevelFloor;
               percentLvl = (_jobXP - _jobXpLevelFloor) / (_jobXpNextLevelFloor - _jobXpLevelFloor);
               if(percentLvl > 1 || _jobXpNextLevelFloor == 0)
               {
                  percentLvl = 1;
               }
               pb_progressBar_other.value = percentLvl;
            }
         }
      }
      
      override protected function disableQuantity(disabled:Boolean) : void
      {
         if(this._nbSlotsOtherOccupied > 0 && this._nbSlotsOccupied == 0)
         {
            super.disableQuantity(disabled);
         }
         else
         {
            super.disableQuantity(true);
         }
      }
      
      override protected function isValidContent(slot:Object, item:Object) : Boolean
      {
         switch(slot)
         {
            case this.slot_ingredient_1_other:
            case this.slot_ingredient_2_other:
            case this.slot_ingredient_3_other:
            case this.slot_ingredient_4_other:
            case this.slot_ingredient_5_other:
            case this.slot_ingredient_6_other:
            case this.slot_ingredient_7_other:
            case this.slot_ingredient_8_other:
               if(item.id == DataEnum.ITEM_GID_SIGNATURE_RUNE)
               {
                  return false;
               }
               return true;
               break;
            default:
               return super.isValidContent(slot,item);
         }
      }
      
      override protected function getSlotsContent() : Array
      {
         var slot1:Slot = null;
         var exist:Boolean = false;
         var i:int = 0;
         var item:Object = null;
         var filledSlots:Array = super.getSlotsContent();
         var length:int = filledSlots.length;
         for each(slot1 in this._slotsIngredients_other)
         {
            if(slot1.data)
            {
               exist = false;
               for(i = 0; i < length; i++)
               {
                  item = filledSlots[i];
                  if(item.objectGID == slot1.data.objectGID)
                  {
                     item.quantity += slot1.data.quantity;
                     exist = true;
                  }
               }
               if(!exist)
               {
                  filledSlots.push({
                     "objectUID":slot1.data.objectUID,
                     "objectGID":slot1.data.objectGID,
                     "quantity":slot1.data.quantity
                  });
               }
            }
         }
         return filledSlots;
      }
      
      override protected function onConfirmCraftRecipe() : void
      {
         sysApi.sendAction(new ExchangeReadyAction([true]));
      }
      
      protected function switchReadyStep(step:uint) : void
      {
         switch(step)
         {
            case READY_STEP_I_AM_READY:
               tx_quantity_selected.gotoAndStop = "green";
               tx_quantity_selected.visible = true;
               this.tx_ingredients_selected.visible = true;
               this._exchangeValidated = true;
               btn_lbl_btn_ok.text = uiApi.getText("ui.common.cancel");
               btn_ok.disabled = !this.containAtLeastOneIngredient();
               break;
            case READY_STEP_HE_IS_READY:
               tx_quantity_selected.gotoAndStop = "green";
               tx_quantity_selected.visible = true;
               this.tx_ingredients_selected_other.visible = true;
               btn_lbl_btn_ok.text = uiApi.getText("ui.common.merge");
               break;
            case READY_STEP_NOT_READY:
            default:
               if(slot_item_crafting.data)
               {
                  tx_quantity_selected.gotoAndStop = "orange";
                  tx_quantity_selected.visible = true;
               }
               else
               {
                  tx_quantity_selected.visible = false;
               }
               this.tx_ingredients_selected.visible = false;
               this.tx_ingredients_selected_other.visible = false;
               this._exchangeValidated = false;
               btn_lbl_btn_ok.text = uiApi.getText("ui.common.merge");
         }
      }
      
      override protected function cleanAllItems() : void
      {
         var slot:Object = null;
         super.cleanAllItems();
         for each(slot in this._slotsIngredients_other)
         {
            slot.data = null;
         }
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case btn_ok:
               if(this._exchangeValidated)
               {
                  sysApi.sendAction(new ExchangeReadyAction([false]));
               }
               else
               {
                  super.onRelease(target);
               }
               break;
            case this.lbl_payment:
               modCommon.openQuantityPopup(0,playerApi.characteristics().kamas,0,this.onPaymentModifiedCallback);
               break;
            case this.ed_player_other:
               if(this._isPlayerCrafter)
               {
                  sysApi.sendAction(new DisplayContextualMenuAction([this._customerInfos.id]));
               }
               else
               {
                  sysApi.sendAction(new DisplayContextualMenuAction([this._crafterInfos.id]));
               }
               break;
            default:
               super.onRelease(target);
         }
      }
      
      override public function onRightClick(target:GraphicContainer) : void
      {
         if(target == this.ed_player_other)
         {
            if(this._isPlayerCrafter)
            {
               sysApi.sendAction(new DisplayContextualMenuAction([this._customerInfos.id]));
            }
            else
            {
               sysApi.sendAction(new DisplayContextualMenuAction([this._crafterInfos.id]));
            }
         }
         else
         {
            super.onRightClick(target);
         }
      }
      
      override public function onRollOver(target:GraphicContainer) : void
      {
         var text:String = null;
         if(target == this.ed_player_other)
         {
            if(this._isPlayerCrafter)
            {
               text = this._customerInfos.name;
            }
            else
            {
               text = this._crafterInfos.name;
            }
         }
         else if(target == ed_player)
         {
            if(this._isPlayerCrafter)
            {
               text = this._crafterInfos.name;
            }
            else
            {
               text = this._customerInfos.name;
            }
         }
         if(text)
         {
            uiApi.showTooltip(uiApi.textTooltipInfo(text),target,false,"standard",1,7,3,null,null,null,"TextInfo");
         }
         else
         {
            super.onRollOver(target);
         }
      }
      
      override public function onRollOut(target:GraphicContainer) : void
      {
         uiApi.hideTooltip();
      }
      
      override protected function isRecipeFull(recipe:Object, recipesComponents:Array) : Boolean
      {
         var component:Object = null;
         var storageItems:Object = null;
         var recipeFull:Boolean = true;
         var missingIngrediend:Boolean = false;
         for each(component in recipe.ingredients)
         {
            storageItems = inventoryApi.getStorageObjectGID(component.objectGID,component.quantity);
            if(storageItems == null)
            {
               if(!this.isInOneOfTheGrid(component.objectGID))
               {
                  missingIngrediend = true;
               }
               recipeFull = false;
            }
            else
            {
               recipesComponents.push(storageItems);
            }
         }
         if(missingIngrediend)
         {
            modCommon.openPopup(uiApi.getText("ui.popup.warning"),uiApi.getText("ui.craft.dontHaveAllIngredient"),[uiApi.getText("ui.common.ok")]);
         }
         return recipeFull;
      }
      
      public function onPaymentModifiedCallback(value:Number) : void
      {
         sysApi.sendAction(new ExchangeCraftPaymentModificationAction([value]));
      }
      
      override protected function onExchangeReplayCountModified(pCount:int) : void
      {
         super.onExchangeReplayCountModified(pCount);
         this.setOkButtonTemporaryDisabled();
      }
      
      override protected function onExchangeCraftResult(result:uint, item:Object) : void
      {
         this.switchReadyStep(READY_STEP_NOT_READY);
         super.onExchangeCraftResult(result,item);
      }
      
      override protected function onExchangeItemAutoCraftStoped(reason:uint) : void
      {
         this.switchReadyStep(READY_STEP_NOT_READY);
      }
      
      private function setOkButtonTemporaryDisabled() : void
      {
         btn_ok.disabled = true;
         this._timerDelay.reset();
         this._timerDelay.start();
      }
      
      private function debtRestrictions() : void
      {
         var slot:Slot = null;
         if(this._isPlayerCrafter)
         {
            for each(slot in _slotsIngredients)
            {
               slot.emptyTexture = uiApi.createUri(uiApi.me().getConstant("lockedSlot"));
               slot.handCursor = false;
            }
         }
         else
         {
            uiApi.removeComponentHook(this.lbl_payment,ComponentHookList.ON_RELEASE);
            this.lbl_payment.disabled = true;
            this.lbl_payment.cssClass = "disabledright";
         }
      }
      
      public function set nbItem(value:int) : void
      {
         this._nbItem = value;
      }
      
      public function set nbItemOther(value:int) : void
      {
         this._nbItemOther = value;
      }
      
      public function set nbSlotsOtherOccupied(value:int) : void
      {
         this._nbSlotsOtherOccupied = value;
      }
      
      public function set nbSlotsOccupied(value:int) : void
      {
         this._nbSlotsOccupied = value;
      }
      
      public function set slotsIngredientsOther(value:Array) : void
      {
         this._slotsIngredients_other = value;
      }
      
      public function set prevItems(val:Array) : void
      {
         this._prevItems = val;
      }
      
      public function set prevItemsOther(val:Array) : void
      {
         this._prevItemsOther = val;
      }
   }
}
