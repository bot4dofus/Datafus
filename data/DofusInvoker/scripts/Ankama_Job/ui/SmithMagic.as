package Ankama_Job.ui
{
   import Ankama_Common.Common;
   import Ankama_ContextMenu.ContextMenu;
   import Ankama_Job.Job;
   import Ankama_Job.ui.items.SmithMagicLogLine;
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceDice;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceInteger;
   import com.ankamagames.dofus.datacenter.effects.instances.EffectInstanceMinMax;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.datacenter.jobs.Skill;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.game.common.actions.CloseInventoryAction;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeReplayAction;
   import com.ankamagames.dofus.logic.game.common.actions.craft.ExchangeReplayStopAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeObjectMoveAction;
   import com.ankamagames.dofus.logic.game.common.actions.exchange.ExchangeReadyAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.DisplayContextualMenuAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.LeaveDialogRequestAction;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.misc.lists.ExchangeHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.JobsApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SocialApi;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.StorageApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.events.TimerEvent;
   import flash.geom.ColorTransform;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class SmithMagic
   {
      
      public static const TOOLTIP_SMITH_MAGIC:String = "tooltipSmithMagic";
      
      public static const ADVANCED_MODE_CACHE_TAG:String = "FM_ADVANCED_MODE";
      
      public static const CRAFT_IMPOSSIBLE:int = 0;
      
      public static const CRAFT_FAILED:int = 1;
      
      public static const CRAFT_SUCCESS:int = 2;
      
      public static const CRAFT_NEARLY_SUCCESS:int = 3;
      
      protected static const ICON_CT:ColorTransform = new ColorTransform(1,1,1,0.3,179,179,177);
      
      protected static const DEFAULT_CT:ColorTransform = new ColorTransform();
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SocialApi")]
      public var socialApi:SocialApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="JobsApi")]
      public var jobsApi:JobsApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      [Api(name="StorageApi")]
      public var storageApi:StorageApi;
      
      [Api(name="InventoryApi")]
      public var inventoryApi:InventoryApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      protected var _skill:Skill;
      
      protected var _job;
      
      protected var _skillLevel:int;
      
      protected var _itemToMage:ItemWrapper;
      
      protected var _lastItemMaged:ItemWrapper;
      
      protected var _runeUsedForLastMage:ItemWrapper;
      
      protected var _itemEffects:Array;
      
      protected var _newItem:Boolean;
      
      protected var _effectsDeltas:Array;
      
      protected var _smithForbidden:Boolean = false;
      
      protected var _buttonEyeList:Dictionary;
      
      protected var _componentList:Dictionary;
      
      protected var _currentRollOver:Object = null;
      
      protected var _refill_item:Object = null;
      
      protected var _refill_qty:int;
      
      protected var _lastScrollbarValue:int;
      
      protected var _corruptionOrTranscendanceRuneUsed:Boolean = false;
      
      protected var _waitingObject:Object;
      
      protected var _waitingSlot:Slot;
      
      protected var _altClickedSlot:Slot;
      
      protected var _bagSlotTexture:Uri;
      
      protected var _multiCraft:Boolean = false;
      
      protected var isAdvancedInProgress:Boolean = false;
      
      protected var _runesItemTypes:Array;
      
      protected var _runesFromInventoryByEffectId:Array;
      
      private var _mergeButtonTimer:BenchmarkTimer;
      
      private var _mergeButtonTimerOut:Boolean;
      
      private var _mergeResultGot:Boolean;
      
      protected var _doubleClick:Boolean = false;
      
      protected var _moveRequestedItemUid:int;
      
      protected var _popupName:String;
      
      protected var _errorItem:ItemWrapper = null;
      
      public var ed_rightCharacter:EntityDisplayer;
      
      public var lbl_job:Label;
      
      public var gd_itemEffects:Grid;
      
      public var lbl_title:Label;
      
      public var btn_emptyHistory:ButtonContainer;
      
      public var gd_history:Grid;
      
      public var slot_item:Slot;
      
      public var slot_rune:Slot;
      
      public var slot_sign:Slot;
      
      public var tx_slot_sign:Texture;
      
      public var btn_mergeAll:ButtonContainer;
      
      public var btn_lbl_btn_mergeAll:Label;
      
      public var btn_mergeOnce:ButtonContainer;
      
      public var btn_close:ButtonContainer;
      
      public var chk_advancedMode:ButtonContainer;
      
      protected var timer:int;
      
      public function SmithMagic()
      {
         this._itemEffects = [];
         this._buttonEyeList = new Dictionary();
         this._componentList = new Dictionary();
         this._runesItemTypes = [DataEnum.ITEM_TYPE_SMITHMAGIC_RUNE,DataEnum.ITEM_TYPE_SMITHMAGIC_TRANSCENDANCE_RUNE,DataEnum.ITEM_TYPE_SMITHMAGIC_CORRUPTION_RUNE];
         this._runesFromInventoryByEffectId = [];
         this.timer = getTimer();
         super();
      }
      
      public function main(args:Object) : void
      {
         var slot:Slot = null;
         var advancedModeOn:* = undefined;
         var jobExperience:Object = null;
         var color:Color = null;
         this.btn_mergeAll.soundId = SoundEnum.OK_BUTTON;
         this.btn_mergeOnce.soundId = SoundEnum.OK_BUTTON;
         this.sysApi.disableWorldInteraction();
         this.sysApi.startStats("smithMagicAdvanced");
         this.sysApi.addHook(CraftHookList.JobLevelUp,this.onJobLevelUp);
         this.sysApi.addHook(ExchangeHookList.ExchangeObjectModified,this.onExchangeObjectModified);
         this.sysApi.addHook(ExchangeHookList.ExchangeObjectAdded,this.onExchangeObjectAdded);
         this.sysApi.addHook(ExchangeHookList.ExchangeObjectRemoved,this.onExchangeObjectRemoved);
         this.sysApi.addHook(ExchangeHookList.ExchangeLeave,this.onExchangeLeave);
         this.sysApi.addHook(ExchangeHookList.ExchangeLeave,this.onExchangeLeave);
         this.sysApi.addHook(BeriliaHookList.DropStart,this.onDropStart);
         this.sysApi.addHook(BeriliaHookList.DropEnd,this.onDropEnd);
         this.sysApi.addHook(CraftHookList.ExchangeCraftResult,this.onExchangeCraftResult);
         this.sysApi.addHook(CraftHookList.ExchangeItemAutoCraftStoped,this.onExchangeItemAutoCraftStoped);
         this.sysApi.addHook(CraftHookList.ItemMagedResult,this.onItemMagedResult);
         this.sysApi.addHook(HookList.DoubleClickItemInventory,this.onDoubleClickItemInventory);
         this.sysApi.addHook(BeriliaHookList.MouseCtrlDoubleClick,this.onMouseCtrlDoubleClick);
         this.sysApi.addHook(BeriliaHookList.MouseAltDoubleClick,this.onMouseAltDoubleClick);
         this.sysApi.addHook(InventoryHookList.ObjectDeleted,this.onObjectDeleted);
         this.sysApi.addHook(InventoryHookList.ObjectQuantity,this.onObjectQuantity);
         this.uiApi.addComponentHook(this.btn_emptyHistory,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.btn_emptyHistory,ComponentHookList.ON_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_emptyHistory,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.ed_rightCharacter,ComponentHookList.ON_RELEASE);
         this.uiApi.addComponentHook(this.ed_rightCharacter,ComponentHookList.ON_RIGHT_CLICK);
         this.uiApi.addComponentHook(this.chk_advancedMode,ComponentHookList.ON_ROLL_OVER);
         this.uiApi.addComponentHook(this.chk_advancedMode,ComponentHookList.ON_ROLL_OUT);
         this.gd_history.dataProvider = Job.getInstance().mageLog;
         this.gd_history.verticalScrollSpeed = 4;
         this.gd_history.moveTo(this.gd_history.dataProvider.length - 1);
         this._bagSlotTexture = this.uiApi.createUri(this.uiApi.me().getConstant("bagSlot_uri"));
         this._skill = this.jobsApi.getSkillFromId(args.skillId);
         this._job = this._skill.parentJob;
         if(args.crafterInfos && args.crafterInfos.id != this.playerApi.id())
         {
            this._skillLevel = args.crafterInfos.skillLevel;
         }
         else
         {
            jobExperience = this.jobsApi.getJobExperience(this._job.id);
            this._skillLevel = jobExperience.currentLevel;
         }
         this.lbl_title.text = this._skill.name;
         this.setMergeButtonDisabled(true);
         this.slot_item.emptyTexture = this.uiApi.createUri(this.uiApi.me().getConstant(this.pictoNameFromSkillId(this._skill.id)));
         this.slot_item.iconColorTransform = ICON_CT;
         this.slot_rune.emptyTexture = this.uiApi.createUri(this.uiApi.me().getConstant("rune_slot_uri"));
         this.slot_rune.iconColorTransform = ICON_CT;
         if(this._skillLevel < ProtocolConstantsEnum.MAX_JOB_LEVEL)
         {
            color = this.uiApi.getColor(this.sysApi.getConfigEntry("colors.smithmagic.fail"));
            this.tx_slot_sign.colorTransform = new ColorTransform(1,1,1,1,color.red,color.green,color.blue);
            this.slot_sign.highlightTexture = null;
         }
         this.slot_sign.emptyTexture = this.uiApi.createUri(this.uiApi.me().getConstant("signature_slot_uri"));
         this.slot_sign.iconColorTransform = ICON_CT;
         this.slot_item.refresh();
         this.slot_rune.refresh();
         this.slot_sign.refresh();
         for each(slot in [this.slot_item,this.slot_rune,this.slot_sign])
         {
            slot.dropValidator = this.dropValidatorFunction as Function;
            slot.processDrop = this.processDropFunction as Function;
            this.uiApi.addComponentHook(slot,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(slot,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(slot,ComponentHookList.ON_DOUBLE_CLICK);
            this.uiApi.addComponentHook(slot,ComponentHookList.ON_RIGHT_CLICK);
            this.uiApi.addComponentHook(slot,ComponentHookList.ON_RELEASE);
         }
         this.ed_rightCharacter.direction = 3;
         this.ed_rightCharacter.look = this.playerApi.getPlayedCharacterInfo().entityLook;
         this.lbl_job.text = this._job.name + " " + this.uiApi.getText("ui.common.short.level") + " " + this._skillLevel;
         this._mergeButtonTimer = new BenchmarkTimer(400,1,"SmithMagic._mergeButtonTimer");
         this._mergeButtonTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onMergeButtonTimer);
         this._mergeButtonTimerOut = false;
         this._mergeResultGot = false;
         advancedModeOn = this.sysApi.getData(ADVANCED_MODE_CACHE_TAG,DataStoreEnum.BIND_ACCOUNT);
         if(advancedModeOn is Boolean)
         {
            this.chk_advancedMode.selected = advancedModeOn as Boolean;
         }
         this.gd_itemEffects.dataProvider = [];
         this.getRunesFromInventory();
      }
      
      public function unload() : void
      {
         this._popupName = null;
         this.sysApi.enableWorldInteraction();
         this._mergeButtonTimer.stop();
         this._mergeButtonTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onMergeButtonTimer);
         this.sysApi.setData(ADVANCED_MODE_CACHE_TAG,this.chk_advancedMode.selected,DataStoreEnum.BIND_ACCOUNT);
         this.uiApi.unloadUi("itemBoxSmith");
         this.storageApi.removeAllItemMasks("smithMagic");
         this.storageApi.releaseHooks();
         this.sysApi.sendAction(new LeaveDialogRequestAction([]));
         this.sysApi.sendAction(new CloseInventoryAction([]));
      }
      
      public function get skill() : Skill
      {
         return this._skill;
      }
      
      public function updateEffectLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         var runes:Object = null;
         var i:int = 0;
         var slotRune:Slot = null;
         if(data)
         {
            if(!data.effect)
            {
               componentsRef.lbl_effect.cssClass = "losteffect";
            }
            else if(data.descZero == "")
            {
               componentsRef.lbl_effect.cssClass = "exoeffect";
            }
            else if(data.effect.bonusType == -1)
            {
               componentsRef.lbl_effect.cssClass = "faileffect";
            }
            else if(data.effect.bonusType == 1)
            {
               if(data.effect.hasOwnProperty("value") && data.effect.value > data.max)
               {
                  componentsRef.lbl_effect.cssClass = "overeffect";
               }
               else
               {
                  componentsRef.lbl_effect.cssClass = "successeffect";
               }
            }
            else
            {
               componentsRef.lbl_effect.cssClass = "normaleffect";
            }
            if(data.min == int.MIN_VALUE)
            {
               componentsRef.lbl_min.text = "-";
            }
            else
            {
               componentsRef.lbl_min.text = data.min;
            }
            if(data.max == int.MAX_VALUE)
            {
               componentsRef.lbl_max.text = "-";
            }
            else
            {
               componentsRef.lbl_max.text = data.max;
            }
            if(data.effect)
            {
               componentsRef.lbl_effect.text = data.effect.description;
            }
            else
            {
               componentsRef.lbl_effect.text = data.descZero;
            }
            if(data.delta > 0)
            {
               componentsRef.lbl_change.text = "+" + data.delta;
               componentsRef.ctr_effectLine.bgColor = this.sysApi.getConfigEntry("colors.smithmagic.success");
               componentsRef.ctr_effectLine.bgAlpha = 0.8;
            }
            else if(data.delta < 0)
            {
               componentsRef.lbl_change.text = "" + data.delta;
               componentsRef.ctr_effectLine.bgColor = this.sysApi.getConfigEntry("colors.smithmagic.fail");
               componentsRef.ctr_effectLine.bgAlpha = 0.8;
            }
            else
            {
               componentsRef.lbl_change.text = "";
               componentsRef.ctr_effectLine.bgAlpha = 0;
            }
            this.uiApi.addComponentHook(componentsRef.ctr_EffectLineRollOver,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.removeComponentHook(componentsRef.btn_eye,ComponentHookList.ON_ROLL_OVER);
            this._buttonEyeList[componentsRef.ctr_EffectLineRollOver] = componentsRef.btn_eye;
            this._componentList[componentsRef.btn_eye] = data;
            componentsRef.ctr_lineFade.visible = data.isHidden;
            componentsRef.btn_eye.selected = data.isHidden;
            runes = this.getRunesByEffectId(data.id);
            if(runes)
            {
               for(i = 0; i < 3; i++)
               {
                  slotRune = componentsRef["slot_rune" + i];
                  slotRune.data = runes[i].rune;
                  if(runes[i].rune && runes[i].fromBag)
                  {
                     slotRune.customTexture = this._bagSlotTexture;
                  }
                  else
                  {
                     slotRune.customTexture = null;
                  }
                  slotRune.dropValidator = this.dropValidatorFunction as Function;
                  slotRune.processDrop = this.processDropFunction as Function;
                  if(slotRune.data && !data.isHidden)
                  {
                     this.uiApi.addComponentHook(slotRune,ComponentHookList.ON_ROLL_OVER);
                     this.uiApi.addComponentHook(slotRune,ComponentHookList.ON_ROLL_OUT);
                     this.uiApi.addComponentHook(slotRune,ComponentHookList.ON_DOUBLE_CLICK);
                     this.uiApi.addComponentHook(slotRune,ComponentHookList.ON_RIGHT_CLICK);
                     this.uiApi.addComponentHook(slotRune,ComponentHookList.ON_RELEASE);
                  }
                  if(data.isHidden)
                  {
                     this.uiApi.removeComponentHook(slotRune,ComponentHookList.ON_ROLL_OVER);
                     this.uiApi.removeComponentHook(slotRune,ComponentHookList.ON_ROLL_OUT);
                     this.uiApi.removeComponentHook(slotRune,ComponentHookList.ON_DOUBLE_CLICK);
                     this.uiApi.removeComponentHook(slotRune,ComponentHookList.ON_RIGHT_CLICK);
                     this.uiApi.removeComponentHook(slotRune,ComponentHookList.ON_RELEASE);
                  }
               }
            }
            else
            {
               if(componentsRef.slot_rune0.data)
               {
                  componentsRef.slot_rune0.data = null;
               }
               if(componentsRef.slot_rune1.data)
               {
                  componentsRef.slot_rune1.data = null;
               }
               if(componentsRef.slot_rune2.data)
               {
                  componentsRef.slot_rune2.data = null;
               }
            }
         }
         else
         {
            componentsRef.lbl_min.text = "";
            componentsRef.lbl_max.text = "";
            componentsRef.lbl_effect.text = "";
            componentsRef.lbl_change.text = "";
            componentsRef.slot_rune0.data = null;
            componentsRef.slot_rune1.data = null;
            componentsRef.slot_rune2.data = null;
            componentsRef.slot_rune0.customTexture = null;
            componentsRef.slot_rune1.customTexture = null;
            componentsRef.slot_rune2.customTexture = null;
            componentsRef.lbl_cheat.text = "";
            componentsRef.ctr_effectLine.bgAlpha = 0;
            this.uiApi.removeComponentHook(componentsRef.ctr_EffectLineRollOver,ComponentHookList.ON_ROLL_OVER);
            componentsRef.ctr_lineFade.visible = false;
            componentsRef.btn_eye.selected = false;
            componentsRef.btn_eye.visible = false;
            if(this._currentRollOver == componentsRef.ctr_EffectLineRollOver)
            {
               this._currentRollOver = null;
            }
         }
      }
      
      public function unfillSelectedSlot(qty:int) : void
      {
         this.unfillSlot(this._waitingSlot,qty);
      }
      
      public function fillDefaultSlot(item:Object, qty:int = -1) : void
      {
         var slot:Slot = null;
         for each(slot in [this.slot_item,this.slot_rune,this.slot_sign])
         {
            if(this.dropValidatorFunction(slot,item,null))
            {
               if(qty == -1)
               {
                  switch(slot)
                  {
                     case this.slot_item:
                     case this.slot_sign:
                        qty = 1;
                        break;
                     case this.slot_rune:
                        qty = item.quantity;
                  }
               }
               this.fillSlot(slot,item,qty);
               return;
            }
         }
      }
      
      public function getMatchingSlot(item:Object) : Slot
      {
         var slot:Slot = null;
         for each(slot in [this.slot_item,this.slot_rune,this.slot_sign])
         {
            if(this.isValidSlot(slot,item))
            {
               return slot;
            }
         }
         return null;
      }
      
      public function getMatchingSlotFromUID(itemUID:int) : Slot
      {
         var slot:Slot = null;
         for each(slot in [this.slot_item,this.slot_rune,this.slot_sign])
         {
            if(slot.data && slot.data.objectUID == itemUID)
            {
               return slot;
            }
         }
         return null;
      }
      
      protected function getRunesFromInventory() : void
      {
         var value:int = 0;
         var resource:Object = null;
         var ei:EffectInstance = null;
         var valueBa:int = 0;
         var valuePa:int = 0;
         var valueRa:int = 0;
         var inventory:Vector.<ItemWrapper> = this.storageApi.getViewContent("storageResources");
         for each(resource in inventory)
         {
            if(resource && resource.typeId == DataEnum.ITEM_TYPE_SMITHMAGIC_RUNE)
            {
               var _loc10_:int = 0;
               var _loc11_:* = resource.effects;
               for each(ei in _loc11_)
               {
                  if(!this._runesFromInventoryByEffectId[ei.effectId])
                  {
                     this._runesFromInventoryByEffectId[ei.effectId] = [{
                        "rune":null,
                        "fromBag":false
                     },{
                        "rune":null,
                        "fromBag":false
                     },{
                        "rune":null,
                        "fromBag":false
                     }];
                  }
                  valueBa = 1;
                  valuePa = 3;
                  valueRa = 10;
                  if(ei.effectId == ActionIds.ACTION_CHARACTER_BOOST_INITIATIVE || ei.effectId == ActionIds.ACTION_CHARACTER_BOOST_MAXIMUM_WEIGHT)
                  {
                     valueBa = 10;
                     valuePa = 30;
                     valueRa = 100;
                  }
                  else if(ei.effectId == ActionIds.ACTION_CHARACTER_BOOST_VITALITY)
                  {
                     valueBa = 5;
                     valuePa = 15;
                     valueRa = 50;
                  }
                  value = int(ei.parameter0);
                  if(value == valueBa)
                  {
                     this._runesFromInventoryByEffectId[ei.effectId][0].rune = resource;
                  }
                  else if(value == valuePa)
                  {
                     this._runesFromInventoryByEffectId[ei.effectId][1].rune = resource;
                  }
                  else if(value == valueRa)
                  {
                     this._runesFromInventoryByEffectId[ei.effectId][2].rune = resource;
                  }
               }
            }
         }
      }
      
      protected function getRunesByEffectId(id:int, index:int = -1) : Object
      {
         if(index == -1)
         {
            return this._runesFromInventoryByEffectId[id];
         }
         return this._runesFromInventoryByEffectId[id][index];
      }
      
      protected function getKnownRunes() : Array
      {
         return this._runesFromInventoryByEffectId;
      }
      
      protected function displayItem(itemW:ItemWrapper) : void
      {
         var o:Object = null;
         var delta:Object = null;
         var thEi:EffectInstance = null;
         var effectActionId:int = 0;
         var ei:EffectInstance = null;
         var e:Object = null;
         var i:int = 0;
         var item:Item = null;
         var eiZero:EffectInstance = null;
         var tempMin:int = 0;
         var j:int = 0;
         if(!itemW)
         {
            this.gd_itemEffects.dataProvider = [];
            this._itemToMage = itemW;
            this._smithForbidden = false;
            if(this._currentRollOver)
            {
               this._buttonEyeList[this._currentRollOver].visible = false;
               this._currentRollOver = null;
            }
            return;
         }
         if(!this._itemToMage || this._itemToMage.objectUID != itemW.objectUID && this.inventoryApi.getItem(itemW.objectUID).quantity - 1 == 0)
         {
            this._newItem = true;
            this._effectsDeltas = null;
         }
         for each(thEi in itemW.effects)
         {
            if(thEi && thEi.effectId == ActionIds.PREVENT_FUTURE_SMITHMAGIC)
            {
               this._smithForbidden = true;
            }
         }
         if(this.slot_item.data != null && this.slot_rune.data != null)
         {
            this.btn_mergeAll.disabled = this.btn_mergeOnce.disabled = this._smithForbidden;
         }
         if(!this._itemToMage || this._itemToMage.objectGID != itemW.objectGID)
         {
            item = this.dataApi.getItem(itemW.objectGID);
            this._itemEffects = [];
            for each(thEi in item.possibleEffects)
            {
               if(thEi)
               {
                  if(!(thEi.bonusType == 0 && thEi.category != 2))
                  {
                     if(thEi.bonusType == -1 && thEi.oppositeId != -1)
                     {
                        effectActionId = thEi.oppositeId;
                     }
                     else
                     {
                        effectActionId = thEi.effectId;
                     }
                     eiZero = this.dataApi.getNullEffectInstance(thEi);
                     o = {
                        "id":effectActionId,
                        "min":int.MIN_VALUE,
                        "max":int.MAX_VALUE,
                        "descZero":eiZero.description,
                        "effect":null,
                        "delta":0
                     };
                     if(thEi is EffectInstanceDice)
                     {
                        o.min = (thEi as EffectInstanceDice).diceNum;
                        if((thEi as EffectInstanceDice).diceSide == 0)
                        {
                           o.max = (thEi as EffectInstanceDice).diceNum;
                        }
                        else
                        {
                           o.max = (thEi as EffectInstanceDice).diceSide;
                        }
                     }
                     else if(thEi is EffectInstanceInteger)
                     {
                        o.min = (thEi as EffectInstanceInteger).value;
                        o.max = (thEi as EffectInstanceInteger).value;
                     }
                     else if(thEi is EffectInstanceMinMax)
                     {
                        o.min = (thEi as EffectInstanceMinMax).min;
                        o.max = (thEi as EffectInstanceMinMax).max;
                     }
                     if(thEi.bonusType < 0)
                     {
                        tempMin = o.min;
                        o.min = -1 * o.max;
                        o.max = -1 * tempMin;
                     }
                     this._itemEffects.push(o);
                  }
               }
            }
         }
         var updatedEffectsId:Array = [];
         var existingEffectsId:Array = [];
         for each(ei in itemW.effects)
         {
            if(ei.bonusType == -1 && ei.oppositeId != -1)
            {
               effectActionId = ei.oppositeId;
            }
            else
            {
               effectActionId = ei.effectId;
            }
         }
         for each(e in this._itemEffects)
         {
            e.delta = 0;
            for each(ei in itemW.effects)
            {
               if(ei.bonusType == -1 && ei.oppositeId != -1)
               {
                  effectActionId = ei.oppositeId;
               }
               else
               {
                  effectActionId = ei.effectId;
               }
               if(ei && e.id == effectActionId)
               {
                  updatedEffectsId.push(e.id);
                  e.effect = ei;
                  if(this._effectsDeltas)
                  {
                     e.delta = 0;
                     for each(delta in this._effectsDeltas)
                     {
                        if(e.id == delta.id)
                        {
                           e.delta = delta.value;
                        }
                     }
                  }
               }
            }
         }
         for each(ei in itemW.effects)
         {
            if(ei.bonusType == -1 && ei.oppositeId != -1)
            {
               effectActionId = ei.oppositeId;
            }
            else
            {
               effectActionId = ei.effectId;
            }
            if(ei && updatedEffectsId.indexOf(effectActionId) == -1)
            {
               if(ei.bonusType == 0 && ei.category != 2)
               {
                  continue;
               }
               o = {
                  "id":effectActionId,
                  "min":int.MIN_VALUE,
                  "max":int.MAX_VALUE,
                  "descZero":"",
                  "effect":ei,
                  "delta":0
               };
               if(this._effectsDeltas)
               {
                  for each(delta in this._effectsDeltas)
                  {
                     if(o.id == delta.id)
                     {
                        o.delta = delta.value;
                     }
                  }
               }
               else
               {
                  o.delta = 0;
               }
               for(j = 0; j < this._itemEffects.length; j++)
               {
                  if(this._itemEffects[j].isHidden != null && this._itemEffects[j].isHidden)
                  {
                     this._itemEffects.splice(j,0,o);
                     break;
                  }
                  if(j == this._itemEffects.length - 1)
                  {
                     this._itemEffects.push(o);
                     break;
                  }
               }
            }
            existingEffectsId.push(effectActionId);
         }
         for(i = this._itemEffects.length - 1; i >= 0; i--)
         {
            if(this._itemEffects[i] && existingEffectsId.indexOf(this._itemEffects[i].id) == -1)
            {
               if(this._itemEffects[i].descZero == "")
               {
                  this._itemEffects.splice(i,1);
               }
               else
               {
                  this._itemEffects[i].effect = null;
                  if(this._effectsDeltas)
                  {
                     for each(delta in this._effectsDeltas)
                     {
                        if(this._itemEffects[i].id == delta.id)
                        {
                           this._itemEffects[i].delta = delta.value;
                        }
                     }
                  }
                  else
                  {
                     this._itemEffects[i].delta = 0;
                  }
               }
            }
         }
         this._itemEffects.map(function(elem:Object, index:int, arr:Array):void
         {
            if(elem.initialIndex == null)
            {
               if(elem.descZero == "")
               {
                  elem.initialIndex = _itemEffects.length - 1;
               }
               else
               {
                  elem.initialIndex = index;
               }
            }
            if(elem.isHidden == null)
            {
               elem.isHidden = false;
            }
         });
         this.gd_itemEffects.dataProvider = this._itemEffects;
         this._itemToMage = itemW;
      }
      
      protected function dropValidatorFunction(target:Object, data:Object, source:Object) : Boolean
      {
         return this.isValidSlot(target as Slot,data);
      }
      
      protected function isValidSlot(target:Slot, d:Object) : Boolean
      {
         var isUsed:* = false;
         if(!this._skill)
         {
            return false;
         }
         switch(target)
         {
            case this.slot_item:
               this._errorItem = null;
               isUsed = false;
               if(d is ItemWrapper)
               {
                  isUsed = (d as ItemWrapper).position != 63;
                  if(isUsed)
                  {
                     this._errorItem = d as ItemWrapper;
                  }
               }
               else if(d.hasOwnProperty("realItem") && d.realItem is ItemWrapper)
               {
                  isUsed = (d.realItem as ItemWrapper).position != 63;
                  if(isUsed)
                  {
                     this._errorItem = d.realItem;
                  }
               }
               return !isUsed && -1 != this._skill.modifiableItemTypeIds.indexOf(d.typeId);
            case this.slot_rune:
               if((!this._skill.isForgemagus || this._runesItemTypes.indexOf(d.typeId) == -1) && d.typeId != DataEnum.ITEM_TYPE_SMITHMAGIC_POTION && d.typeId != DataEnum.ITEM_TYPE_SMITHMAGIC_ORB || d.objectGID == DataEnum.ITEM_GID_SIGNATURE_RUNE)
               {
                  return false;
               }
               return true;
               break;
            case this.slot_sign:
               return d.objectGID == DataEnum.ITEM_GID_SIGNATURE_RUNE;
            default:
               return false;
         }
      }
      
      protected function processDropFunction(target:Object, d:Object, source:Object) : void
      {
         if(this.dropValidatorFunction(target,d,source))
         {
            switch(target)
            {
               case this.slot_item:
               case this.slot_sign:
                  this.fillSlot(target as Slot,d,1);
                  break;
               case this.slot_rune:
                  if(d.info1 > 1)
                  {
                     this._waitingObject = d;
                     this.modCommon.openQuantityPopup(1,d.quantity,d.quantity,this.onValidQtyDropToSlot);
                  }
                  else
                  {
                     this.fillSlot(this.slot_rune,d,1);
                  }
            }
         }
      }
      
      protected function fillSlot(slot:Slot, item:Object, qty:int) : void
      {
         if(slot.data != null && (slot == this.slot_item || slot == this.slot_sign || slot == this.slot_rune && slot.data.objectGID != item.objectGID))
         {
            this.unfillSlot(slot,-1);
            if(slot == this.slot_rune)
            {
               this._corruptionOrTranscendanceRuneUsed = false;
            }
            this._refill_item = item;
            this._refill_qty = qty;
         }
         else
         {
            if(slot && slot == this.slot_rune)
            {
               this._corruptionOrTranscendanceRuneUsed = item.typeId == DataEnum.ITEM_TYPE_SMITHMAGIC_CORRUPTION_RUNE || item.typeId == DataEnum.ITEM_TYPE_SMITHMAGIC_TRANSCENDANCE_RUNE;
            }
            this._moveRequestedItemUid = item.objectUID;
            this.sysApi.sendAction(new ExchangeObjectMoveAction([item.objectUID,qty]));
         }
      }
      
      protected function unfillSlot(slot:Slot, qty:int = -1) : void
      {
         if(qty == -1)
         {
            qty = slot.data.quantity;
         }
         if(slot == this.slot_rune)
         {
            this._corruptionOrTranscendanceRuneUsed = false;
         }
         this._moveRequestedItemUid = slot.data.objectUID;
         this.sysApi.sendAction(new ExchangeObjectMoveAction([slot.data.objectUID,-qty]));
      }
      
      protected function setMergeButtonDisabled(disabled:Boolean) : void
      {
         if(this._mergeButtonTimer)
         {
            this._mergeButtonTimer.stop();
         }
         if(!disabled && (!this.slot_rune.data || !this.slot_item.data || this.slot_item.data.level > this._skillLevel) && !this._smithForbidden)
         {
            disabled = true;
         }
         this.btn_mergeOnce.disabled = disabled;
         if(this._multiCraft)
         {
            this.btn_lbl_btn_mergeAll.text = this.uiApi.getText("ui.common.stop");
            this.btn_mergeAll.disabled = false;
         }
         else
         {
            this.btn_lbl_btn_mergeAll.text = this.uiApi.getText("ui.common.mergeAll");
            this.btn_mergeAll.disabled = disabled;
         }
      }
      
      protected function addLogLine(text:String, rune:ItemWrapper, cssClass:String) : void
      {
         var logLine:SmithMagicLogLine = new SmithMagicLogLine(text,rune,cssClass);
         Job.getInstance().addToMageLog(logLine);
         this.addEmptyLinesToLog(3);
         var lbl:Label = new Label();
         lbl.width = 275;
         lbl.height = 28;
         lbl.wordWrap = true;
         lbl.multiline = true;
         lbl.css = this.uiApi.createUri(this.uiApi.me().getConstant("css") + "smithMagic.css");
         lbl.cssClass = "normalhistory";
         lbl.text = logLine.text;
         if(lbl.textfield.numLines > 1)
         {
            this.addEmptyLinesToLog(2 * (lbl.textfield.numLines - 1));
         }
         if(Job.getInstance().realMageLogLength() > 192)
         {
            Job.getInstance().removeMageLogFirstLine();
         }
         this.gd_history.dataProvider = Job.getInstance().mageLog;
      }
      
      private function addEmptyLinesToLog(linesToAdd:int = 1) : void
      {
         for(var i:int = 0; i < linesToAdd; i++)
         {
            Job.getInstance().addToMageLog(null);
         }
      }
      
      public function updateHistoryLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(data)
         {
            if(data.rune)
            {
               componentsRef.tx_historyRune.uri = this.uiApi.createUri(data.rune.getIconUri());
               componentsRef.lbl_historyResult.x = 34;
               componentsRef.tx_historyRune.visible = true;
               this.uiApi.addComponentHook(componentsRef.tx_historyRune,ComponentHookList.ON_ROLL_OVER);
               this.uiApi.addComponentHook(componentsRef.tx_historyRune,ComponentHookList.ON_ROLL_OUT);
            }
            else
            {
               componentsRef.lbl_historyResult.x = 4;
               componentsRef.tx_historyRune.visible = false;
            }
            componentsRef.lbl_historyResult.cssClass = data.cssClass;
            componentsRef.lbl_historyResult.text = data.text;
            componentsRef.lbl_historyResult.visible = true;
         }
         else
         {
            componentsRef.tx_historyRune.uri = null;
            componentsRef.lbl_historyResult.text = "";
            componentsRef.tx_historyRune.visible = false;
            componentsRef.lbl_historyResult.visible = false;
         }
      }
      
      protected function pictoNameFromSkillId(skillId:int) : String
      {
         switch(skillId)
         {
            case DataEnum.SKILL_MAGE_JEWEL:
               return "amulet_slot_uri";
            case DataEnum.SKILL_MAGE_SHOES:
               return "boots_slot_uri";
            case DataEnum.SKILL_MAGE_TAILOR:
               return "helmet_slot_uri";
            default:
               return "weapon_slot_uri";
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         switch(target)
         {
            case this.btn_mergeAll:
               if(!this._corruptionOrTranscendanceRuneUsed)
               {
                  this._multiCraft = !this._multiCraft;
                  if(this._multiCraft)
                  {
                     this.setMergeButtonDisabled(true);
                     this.sysApi.sendAction(new ExchangeReplayAction([-1]));
                     this.sysApi.sendAction(new ExchangeReadyAction([true]));
                  }
                  else
                  {
                     this.sysApi.sendAction(new ExchangeReplayStopAction([]));
                  }
               }
               else if(this._popupName == null)
               {
                  this.setMergeButtonDisabled(true);
                  this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.smithmagic.futureUpgradesImpossible"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.cancel")],[this.sendSmithRequest,this.cancelSmithRequest],this.sendSmithRequest,this.cancelSmithRequest);
               }
               break;
            case this.btn_mergeOnce:
               this._multiCraft = false;
               this.setMergeButtonDisabled(true);
               if(!this._corruptionOrTranscendanceRuneUsed)
               {
                  this._mergeButtonTimer.start();
                  this._mergeButtonTimerOut = false;
                  this._mergeResultGot = false;
                  this.sysApi.sendAction(new ExchangeReadyAction([true]));
               }
               else if(this._popupName == null)
               {
                  this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.smithmagic.futureUpgradesImpossible"),[this.uiApi.getText("ui.common.yes"),this.uiApi.getText("ui.common.cancel")],[this.sendSmithRequest,this.cancelSmithRequest],this.sendSmithRequest,this.cancelSmithRequest);
               }
               break;
            case this.btn_close:
               this.uiApi.unloadUi(this.uiApi.me().name);
               break;
            case this.ed_rightCharacter:
               this.sysApi.sendAction(new DisplayContextualMenuAction([this.playerApi.id()]));
               break;
            case this.btn_emptyHistory:
               this._popupName = this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.smithmagic.askConfirmationDeleteHistory"),[this.uiApi.getText("ui.popup.delete"),this.uiApi.getText("ui.common.cancel")],[this.deleteHistory,this.cancelDeleteRequest],this.deleteHistory,this.cancelDeleteRequest);
               break;
            default:
               if(target.name != "slot_rune" && target.name.indexOf("slot_rune") == 0 && this.chk_advancedMode.selected && !this.isAdvancedInProgress && !this.uiApi.keyIsDown(Keyboard.CONTROL))
               {
                  if(this.slot_rune.data != null)
                  {
                     this.unfillSlot(this.slot_rune,-1);
                  }
                  this._multiCraft = false;
                  this._runeUsedForLastMage = (target as Slot).data;
                  this.setMergeButtonDisabled(true);
                  this.sysApi.dispatchHook(HookList.DoubleClickItemInventory,(target as Slot).data,1);
                  if(this.slot_item.data && this.slot_item.data.level <= this._skillLevel)
                  {
                     this.isAdvancedInProgress = true;
                  }
               }
               if(target.name.indexOf("btn_eye") != -1)
               {
                  this.hideLine(target);
               }
         }
      }
      
      private function hideLine(target:Object) : void
      {
         var tmpDataProvider:Array = null;
         var i:int = 0;
         var hide:* = !(target as ButtonContainer).selected;
         var componentData:Object = this._componentList[target];
         if(componentData)
         {
            componentData.isHidden = hide;
            tmpDataProvider = this.gd_itemEffects.dataProvider;
            tmpDataProvider.splice(tmpDataProvider.indexOf(componentData),1);
            if(!hide && tmpDataProvider.length > 0)
            {
               for(i = 0; i < tmpDataProvider.length; i++)
               {
                  if(tmpDataProvider[i].initialIndex > componentData.initialIndex || tmpDataProvider[i].isHidden)
                  {
                     tmpDataProvider.splice(i,0,componentData);
                     break;
                  }
                  if(i == tmpDataProvider.length - 1)
                  {
                     tmpDataProvider.push(componentData);
                     break;
                  }
               }
            }
            else
            {
               tmpDataProvider.push(componentData);
            }
            this.gd_itemEffects.dataProvider = tmpDataProvider;
         }
      }
      
      public function sendSmithRequest() : void
      {
         this._popupName = null;
         this.sysApi.sendAction(new ExchangeReadyAction([true]));
      }
      
      public function cancelSmithRequest() : void
      {
         this._popupName = null;
         this.setMergeButtonDisabled(false);
      }
      
      public function deleteHistory() : void
      {
         Job.getInstance().emptyMageLog();
         this.gd_history.dataProvider = [];
      }
      
      public function cancelDeleteRequest() : void
      {
         this._popupName = null;
      }
      
      public function onDoubleClick(target:GraphicContainer) : void
      {
         if(target is Slot && (target as Slot).data && !this.uiApi.keyIsDown(Keyboard.CONTROL) && !this.uiApi.keyIsDown(15))
         {
            if(target == this.slot_item || target == this.slot_rune || target == this.slot_sign)
            {
               this.unfillSlot(target as Slot,1);
            }
            else
            {
               if(this.chk_advancedMode.selected)
               {
                  this.onRelease(target);
                  return;
               }
               this.sysApi.dispatchHook(HookList.DoubleClickItemInventory,(target as Slot).data,1);
            }
         }
      }
      
      public function onMouseCtrlDoubleClick(target:GraphicContainer) : void
      {
         var iw:ItemWrapper = null;
         if(this.chk_advancedMode.selected && target.name.indexOf("slot_rune") == 0 && target.name.indexOf("gd_itemEffects") != -1)
         {
            return;
         }
         if(target is Slot && (target as Slot).data && (this.uiApi.keyIsDown(Keyboard.CONTROL) || this.uiApi.keyIsDown(15)))
         {
            if(target == this.slot_item || target == this.slot_rune || target == this.slot_sign)
            {
               this.unfillSlot(target as Slot,-1);
            }
            else
            {
               this._doubleClick = true;
               iw = this.inventoryApi.getItem((target as Slot).data.objectUID);
               if(iw)
               {
                  this.sysApi.dispatchHook(HookList.DoubleClickItemInventory,(target as Slot).data,iw.quantity - this.getAlreadyInSlot(iw));
               }
               else
               {
                  this.sysApi.dispatchHook(HookList.DoubleClickItemInventory,(target as Slot).data,(target as Slot).data.quantity);
               }
            }
         }
      }
      
      protected function getAlreadyInSlot(iw:ItemWrapper) : uint
      {
         if(this.slot_rune.data && this.isValidSlot(this.slot_rune,iw) && this.slot_rune.data.objectGID == iw.objectGID)
         {
            return this.slot_rune.data.quantity;
         }
         return 0;
      }
      
      public function onMouseAltDoubleClick(target:GraphicContainer) : void
      {
         var slotClicked:Boolean = false;
         if(target is Slot && (target as Slot).data)
         {
            slotClicked = false;
            if(target == this.slot_item || target == this.slot_rune || target == this.slot_sign)
            {
               slotClicked = true;
            }
            if(!slotClicked)
            {
               return;
            }
            this._altClickedSlot = target as Slot;
            this.modCommon.openQuantityPopup(1,(target as Slot).data.quantity,(target as Slot).data.quantity,this.onValidQty);
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var itemTypeId:int = 0;
         var itemsText:String = "";
         if(target is Slot && (target as Slot).data)
         {
            this.uiApi.showTooltip((target as Slot).data,target,false,"standard",LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_TOPLEFT,0,"itemName",null,{
               "showEffects":true,
               "header":true
            },"ItemInfo");
            return;
         }
         if(target == this.slot_item)
         {
            for each(itemTypeId in this._skill.modifiableItemTypeIds)
            {
               itemsText += this.dataApi.getItemType(itemTypeId).name + "/";
            }
            itemsText = itemsText.substr(0,itemsText.length - 1);
         }
         else if(target == this.slot_rune)
         {
            itemsText = this.dataApi.getItemType(78).name;
         }
         else if(target == this.slot_sign)
         {
            itemsText = this._skillLevel < ProtocolConstantsEnum.MAX_JOB_LEVEL ? this.uiApi.getText("ui.craft.jobLevelLowForSignatureClient") : this.dataApi.getItem(7508).name;
         }
         else
         {
            if(target == this.btn_emptyHistory)
            {
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this.uiApi.getText("ui.smithmagic.emptyHistory")),target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
               return;
            }
            if(this._buttonEyeList[target] && this._itemToMage)
            {
               if(this._currentRollOver)
               {
                  this._buttonEyeList[this._currentRollOver].visible = false;
               }
               this._currentRollOver = target;
               this._buttonEyeList[target].visible = true;
            }
         }
         if(target == this.chk_advancedMode)
         {
            itemsText = this.uiApi.getText("ui.craft.FMcraftAdvancedModeDesc");
         }
         if(itemsText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(itemsText),target,false,"standard",LocationEnum.POINT_TOP,LocationEnum.POINT_BOTTOM,3,null,null,null,"TextInfo");
         }
      }
      
      public function onItemRollOver(target:GraphicContainer, item:Object) : void
      {
         if(item.data && item.data.hasOwnProperty("rune") && item.data.rune)
         {
            this.uiApi.showTooltip(item.data.rune,target,false,"standard",LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_TOPLEFT,0,"itemName",null,{
               "showEffects":true,
               "header":true
            },"ItemInfo");
         }
      }
      
      public function onItemRollOut(target:GraphicContainer, item:Object) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onRightClick(target:GraphicContainer) : void
      {
         var data:Object = null;
         var contextMenu:ContextMenuData = null;
         if(target == this.ed_rightCharacter)
         {
            this.sysApi.sendAction(new DisplayContextualMenuAction([this.playerApi.id()]));
         }
         else if((target as Slot).data)
         {
            data = (target as Slot).data;
            contextMenu = this.menuApi.create(data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
      
      private function onDropStart(src:Slot) : void
      {
         var slot:Slot = null;
         this._waitingSlot = src;
         for each(slot in [this.slot_item,this.slot_rune,this.slot_sign])
         {
            if(this.dropValidatorFunction(slot,src.data,null))
            {
               slot.selected = true;
            }
         }
      }
      
      private function onDropEnd(src:Slot, target:Object) : void
      {
         var slot:Slot = null;
         if(!(target is GraphicContainer))
         {
            return;
         }
         for each(slot in [this.slot_item,this.slot_rune,this.slot_sign])
         {
            slot.selected = false;
         }
         if(target.getUi() == this.uiApi.me() && this._errorItem)
         {
            this.chatApi.sendErrorOnChat(this.uiApi.getText("ui.exchange.cantExchangeEquippedItem",this._errorItem.objectGID,this._errorItem.objectUID));
            this._errorItem = null;
         }
      }
      
      protected function onExchangeObjectModified(item:ItemWrapper, remote:Boolean) : void
      {
         var slot:Slot = this.getMatchingSlot(item);
         this.storageApi.addItemMask(item.objectUID,"smithMagic",item.quantity);
         this.storageApi.releaseHooks();
         slot.data = item;
         switch(slot)
         {
            case this.slot_item:
               this.displayItem(item);
               break;
            case this.slot_rune:
               this._runeUsedForLastMage = slot.data;
         }
         this.setMergeButtonDisabled(!(this.slot_item.data && this.slot_rune.data && !this._smithForbidden && !this.isAdvancedInProgress));
         this._moveRequestedItemUid = 0;
      }
      
      protected function onExchangeObjectAdded(item:ItemWrapper, remote:Boolean) : void
      {
         var slot:Slot = this.getMatchingSlot(item);
         if(slot.data && slot.data.objectUID != item.objectUID)
         {
            this.storageApi.removeItemMask(slot.data.objectUID,"smithMagic");
         }
         slot.colorTransform = DEFAULT_CT;
         slot.iconColorTransform = DEFAULT_CT;
         slot.data = item;
         this.storageApi.addItemMask(item.objectUID,"smithMagic",item.quantity);
         this.storageApi.releaseHooks();
         this.soundApi.playSound(SoundTypeEnum.SWITCH_RIGHT_TO_LEFT);
         switch(slot)
         {
            case this.slot_item:
               this.displayItem(item);
               break;
            case this.slot_rune:
               this._runeUsedForLastMage = slot.data;
               if(this.chk_advancedMode.selected && this.isAdvancedInProgress)
               {
                  this.onRelease(this.btn_mergeOnce);
                  this.setMergeButtonDisabled(true);
               }
         }
         this.setMergeButtonDisabled(!(this.slot_item.data && this.slot_rune.data && !this._smithForbidden && !this.isAdvancedInProgress));
         this._moveRequestedItemUid = 0;
      }
      
      protected function onExchangeObjectRemoved(itemUID:int, remote:Boolean) : void
      {
         this.storageApi.removeItemMask(itemUID,"smithMagic");
         this.storageApi.releaseHooks();
         var slot:Slot = this.getMatchingSlotFromUID(itemUID);
         if(slot)
         {
            slot.iconColorTransform = ICON_CT;
            slot.data = null;
            if(slot == this.slot_item)
            {
               this.displayItem(null);
            }
            this.soundApi.playSound(SoundTypeEnum.SWITCH_LEFT_TO_RIGHT);
            if(this._refill_item != null)
            {
               this.fillSlot(slot,this._refill_item,this._refill_qty);
               this._refill_item = null;
            }
            if(this.slot_item.data == null || this.slot_rune.data == null)
            {
               this.setMergeButtonDisabled(true);
            }
         }
         this._moveRequestedItemUid = 0;
      }
      
      protected function onObjectDeleted(item:ItemWrapper) : void
      {
         var knownRunes:Array = null;
         var effectStr:* = null;
         var effectId:int = 0;
         if(item && this._runesItemTypes.indexOf(item.typeId) != -1 && item.objectUID != this._moveRequestedItemUid)
         {
            knownRunes = this.getKnownRunes();
            for(effectStr in knownRunes)
            {
               effectId = int(effectStr);
               if(this.getRunesByEffectId(effectId,0) && this.getRunesByEffectId(effectId,0).rune && this.getRunesByEffectId(effectId,0).rune.objectUID == item.objectUID)
               {
                  this.getRunesByEffectId(effectId,0).rune = null;
                  break;
               }
               if(this.getRunesByEffectId(effectId,1) && this.getRunesByEffectId(effectId,1).rune && this.getRunesByEffectId(effectId,1).rune.objectUID == item.objectUID)
               {
                  this.getRunesByEffectId(effectId,1).rune = null;
                  break;
               }
               if(this.getRunesByEffectId(effectId,2) && this.getRunesByEffectId(effectId,2).rune && this.getRunesByEffectId(effectId,2).rune.objectUID == item.objectUID)
               {
                  this.getRunesByEffectId(effectId,2).rune = null;
                  break;
               }
            }
         }
      }
      
      protected function onObjectQuantity(item:ItemWrapper, quantity:int, oldQuantity:int) : void
      {
         var ei:EffectInstance = null;
         if(item && this._runesItemTypes.indexOf(item.typeId) != -1 && item.objectUID != this._moveRequestedItemUid)
         {
            for each(ei in item.effects)
            {
               if(this.getRunesByEffectId(ei.effectId))
               {
                  if(this.getRunesByEffectId(ei.effectId,0) && this.getRunesByEffectId(ei.effectId,0).rune != null && this.getRunesByEffectId(ei.effectId,0).rune.objectUID == item.objectUID)
                  {
                     this.getRunesByEffectId(ei.effectId,0).rune = item;
                     return;
                  }
                  if(this.getRunesByEffectId(ei.effectId,1) && this.getRunesByEffectId(ei.effectId,1).rune != null && this.getRunesByEffectId(ei.effectId,1).rune.objectUID == item.objectUID)
                  {
                     this.getRunesByEffectId(ei.effectId,1).rune = item;
                     return;
                  }
                  if(this.getRunesByEffectId(ei.effectId,2) && this.getRunesByEffectId(ei.effectId,2).rune != null && this.getRunesByEffectId(ei.effectId,2).rune.objectUID == item.objectUID)
                  {
                     this.getRunesByEffectId(ei.effectId,2).rune = item;
                     return;
                  }
               }
            }
         }
      }
      
      public function onExchangeCraftResult(result:int, item:ItemWrapper) : void
      {
         switch(result)
         {
            case CRAFT_IMPOSSIBLE:
               this.modCommon.openPopup(this.uiApi.getText("ui.common.error"),this.uiApi.getText("ui.craft.noResult"),[this.uiApi.getText("ui.common.ok")]);
               if(this.chk_advancedMode.selected && this._runeUsedForLastMage)
               {
                  this.sysApi.sendAction(new ExchangeObjectMoveAction([this._runeUsedForLastMage.objectUID,-1]));
               }
               else
               {
                  this.unfillSlot(this.slot_rune);
               }
               this.sysApi.sendAction(new ExchangeReadyAction([false]));
            case CRAFT_FAILED:
            case CRAFT_SUCCESS:
            case CRAFT_NEARLY_SUCCESS:
               if(item)
               {
                  if(this.slot_item.data)
                  {
                     this.slot_item.data = this.dataApi.getItemWrapper(item.objectGID,item.position,this.slot_item.data.objectUID,item.quantity,item.effectsList);
                  }
                  this.displayItem(item);
               }
         }
         if(!this._multiCraft)
         {
            this._mergeResultGot = true;
            if(this._mergeButtonTimerOut)
            {
               this.setMergeButtonDisabled(false);
            }
         }
         if(this.isAdvancedInProgress)
         {
            this.setMergeButtonDisabled(false);
            this.isAdvancedInProgress = false;
         }
      }
      
      public function onMergeButtonTimer(e:TimerEvent) : void
      {
         this._mergeButtonTimerOut = true;
         if(this._mergeResultGot)
         {
            this.setMergeButtonDisabled(false);
         }
      }
      
      public function processDropToInventory(target:Object, d:Object, source:Object) : void
      {
         if(d.info1 > 1)
         {
            this._waitingObject = d;
            this.modCommon.openQuantityPopup(1,d.quantity,d.quantity,this.onValidQtyDropToInventory);
         }
         else
         {
            this.unfillSelectedSlot(1);
         }
      }
      
      public function onDoubleClickItemInventory(item:Object, qty:int = 1) : void
      {
         if(this.uiApi.keyIsDown(Keyboard.CONTROL))
         {
            if(!this._doubleClick)
            {
               return;
            }
            this._doubleClick = false;
         }
         if(item)
         {
            if(item.id == DataEnum.ITEM_GID_SIGNATURE_RUNE || this._runesItemTypes.indexOf(item.id) != -1)
            {
               qty = 1;
            }
            this.fillDefaultSlot(item,qty);
         }
      }
      
      private function onJobLevelUp(jobId:uint, jobName:String, newLevel:uint, podsBonus:uint) : void
      {
         if(jobId == this._job.id)
         {
            this.lbl_job.text = this._job.name + " " + this.uiApi.getText("ui.common.short.level") + " " + newLevel;
            this._skillLevel = newLevel;
         }
      }
      
      public function onExchangeItemAutoCraftStoped(reason:int) : void
      {
         this.btn_mergeAll.soundId = SoundEnum.OK_BUTTON;
         this._multiCraft = false;
         this.setMergeButtonDisabled(false);
      }
      
      public function onItemMagedResult(resultType:String, result:String, itemToMage:ItemWrapper, deltas:Array) : void
      {
         if(!this._itemToMage || this._itemToMage.objectUID != itemToMage.objectUID)
         {
            this._itemToMage = itemToMage;
         }
         var style:* = "normalhistory";
         if(this._newItem && this._itemToMage && this._lastItemMaged != this._itemToMage)
         {
            if(Job.getInstance().mageLog.length > 0)
            {
               this.addEmptyLinesToLog(3);
            }
            this.addLogLine(this._itemToMage.name,null,style);
            this._lastItemMaged = this._itemToMage;
            this._newItem = false;
         }
         style = resultType + "history";
         this.addLogLine(result,this._runeUsedForLastMage,style);
         this.gd_history.moveTo(this.gd_history.dataProvider.length - 1);
         this._effectsDeltas = deltas;
      }
      
      public function onExchangeLeave(success:Boolean) : void
      {
         this.uiApi.unloadUi(this.uiApi.me().name);
      }
      
      public function getIsAvailableItem(item:Object) : Boolean
      {
         if(!this.dataApi)
         {
            return true;
         }
         return this.getMatchingSlot(item) != null;
      }
      
      private function onValidQty(qty:Number) : void
      {
         this.unfillSlot(this._altClickedSlot,qty);
      }
      
      private function onValidQtyDropToSlot(qty:Number) : void
      {
         this.fillDefaultSlot(this._waitingObject,qty);
      }
      
      protected function onValidQtyDropToInventory(qty:Number) : void
      {
         this.unfillSelectedSlot(qty);
      }
   }
}
