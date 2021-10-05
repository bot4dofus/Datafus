package Ankama_GameUiCore.ui
{
   import Ankama_GameUiCore.ui.enums.ContextEnum;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.datacenter.communication.SmileyCategory;
   import com.ankamagames.dofus.internalDatacenter.communication.SmileyWrapper;
   import com.ankamagames.dofus.logic.game.common.actions.chat.ChatSmileyRequestAction;
   import com.ankamagames.dofus.logic.game.common.actions.chat.MoodSmileyRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.EmotePlayRequestAction;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.RoleplayHookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.misc.lists.TriggerHookList;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.RoleplayApi;
   import com.ankamagames.dofus.uiApi.TimeApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   
   public class Smileys extends ContextAwareUi
   {
       
      
      public var output:Object;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="RoleplayApi")]
      public var rpApi:RoleplayApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="TimeApi")]
      public var timeApi:TimeApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      private var _currentMood:int = 0;
      
      private var _currentSmileyCategory:int = 0;
      
      private var _selectedTxList:Array;
      
      private var _completeSmileyList:Array;
      
      private var _slotByEmoteId:Dictionary;
      
      private var _usableEmotes:Object;
      
      private var _playSmileAllowed:Boolean = true;
      
      private var _playSmileAllowedTimer:BenchmarkTimer;
      
      private var _shortcutColor:String;
      
      private var _gridComponentsList:Dictionary;
      
      private var _btnHappy:ButtonContainer;
      
      private var _bgLastWidth:Number;
      
      private var _bgLastHeight:Number;
      
      public var mainCtr:GraphicContainer;
      
      public var ctr_bg:GraphicContainer;
      
      public var ctr_category:GraphicContainer;
      
      public var ctr_grid:GraphicContainer;
      
      public var gd_smileys:Grid;
      
      public var gd_smileyCategories:Grid;
      
      public var gd_emotes:Grid;
      
      public var btn_close:ButtonContainer;
      
      public var tx_title:TextureBitmap;
      
      public var lbl_title:Label;
      
      public var tx_catbg:TextureBitmap;
      
      public function Smileys()
      {
         this._selectedTxList = [];
         this._completeSmileyList = [];
         this._slotByEmoteId = new Dictionary();
         this._usableEmotes = {};
         this._gridComponentsList = new Dictionary(true);
         super();
      }
      
      override public function main(args:Array) : void
      {
         var lastOpenedCategory:int = 0;
         var smileyCats:Object = null;
         var smileyCatsOrdered:Array = null;
         var smileyCat:SmileyCategory = null;
         super.main(args);
         sysApi.addHook(RoleplayHookList.EmoteListUpdated,this.onEmoteListUpdated);
         sysApi.addHook(ChatHookList.MoodResult,this.onMoodResult);
         sysApi.addHook(HookList.SmileysStart,this.onSmileysStart);
         sysApi.addHook(ChatHookList.SmileyListUpdated,this.onSmileyListUpdated);
         sysApi.addHook(RoleplayHookList.EmoteEnabledListUpdated,this.onEmoteEnabledListUpdated);
         this.uiApi.addComponentHook(this.gd_smileyCategories,ComponentHookList.ON_ITEM_ROLL_OVER);
         this.uiApi.addComponentHook(this.gd_smileyCategories,ComponentHookList.ON_ITEM_ROLL_OUT);
         this.uiApi.addComponentHook(this.btn_close,ComponentHookList.ON_ITEM_ROLL_OVER);
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortcut);
         this._playSmileAllowed = true;
         this._playSmileAllowedTimer = new BenchmarkTimer(1000,1,"Smileys._playSmileAllowedTimer");
         this._playSmileAllowedTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onPlaySmileAllowedTimer);
         if(!this.uiApi.getUi(UIEnum.STORAGE_UI))
         {
            sysApi.dispatchHook(CustomUiHookList.ShortcutsMovementAllowed,true);
         }
         if(args && args.length > 0 && args[0] >= 0)
         {
            this._currentSmileyCategory = args[0];
            lastOpenedCategory = sysApi.getData("smileyLastCategoryOpened");
            if(this._currentSmileyCategory != lastOpenedCategory)
            {
               sysApi.setData("smileyLastCategoryOpened",this._currentSmileyCategory);
            }
         }
         else
         {
            this._currentSmileyCategory = sysApi.getData("smileyLastCategoryOpened");
         }
         if(this.gd_smileyCategories.dataProvider.length == 0)
         {
            smileyCats = this.dataApi.getAllSmileyCategory();
            smileyCatsOrdered = [];
            for each(smileyCat in smileyCats)
            {
               smileyCatsOrdered.push(smileyCat);
            }
            smileyCatsOrdered.sortOn("order",Array.NUMERIC);
            this.gd_smileyCategories.dataProvider = smileyCatsOrdered;
         }
         for(var i:int = 0; i < this.gd_smileyCategories.dataProvider.length; i++)
         {
            if(this._currentSmileyCategory == this.gd_smileyCategories.dataProvider[i].id)
            {
               this.gd_smileyCategories.selectedIndex = i;
               break;
            }
         }
         this.createSmileyListWithPacks();
         this.displayCurrentType();
         var initialContext:String = !!this.playerApi.isInFight() ? ContextEnum.FIGHT : ContextEnum.ROLEPLAY;
         changeContext(initialContext);
         this._bgLastWidth = this.ctr_bg.width;
         this._bgLastHeight = this.ctr_bg.height;
         this.ctr_bg.getResizeController().topResize = false;
         this.tx_title.getResizeController().bottomResize = false;
      }
      
      public function unload() : void
      {
         if(!this.uiApi.getUi(UIEnum.STORAGE_UI) && !this.uiApi.isResetting())
         {
            sysApi.dispatchHook(CustomUiHookList.ShortcutsMovementAllowed,false);
         }
         this._playSmileAllowedTimer.stop();
         this._playSmileAllowedTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onPlaySmileAllowedTimer);
         this.uiApi.hideTooltip();
      }
      
      override protected function onContextChanged(context:String, previousContext:String = "", contextChanged:Boolean = false) : void
      {
         if(context != ContextEnum.ROLEPLAY)
         {
            if(this._currentSmileyCategory == 0)
            {
               if(this._btnHappy)
               {
                  this.onRelease(this._btnHappy);
               }
               this.gd_smileyCategories.selectedIndex = 1;
            }
         }
         this.gd_smileyCategories.updateItem(0);
      }
      
      public function updateSmiley(data:*, componentsRef:*, selected:Boolean) : void
      {
         componentsRef.slot_smiley.dropValidator = this.dropValidatorFunction;
         if(data)
         {
            this._selectedTxList[data.id] = componentsRef.tx_bgSmiley;
            componentsRef.slot_smiley.data = data;
            if(data.id == this._currentMood)
            {
               componentsRef.tx_bgSmiley.visible = true;
            }
            else
            {
               componentsRef.tx_bgSmiley.visible = false;
            }
            componentsRef.slot_smiley.allowDrag = true;
         }
         else
         {
            componentsRef.slot_smiley.data = null;
            componentsRef.tx_bgSmiley.visible = false;
         }
      }
      
      public function updateSmileyCategory(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(data)
         {
            this._gridComponentsList[componentsRef.btn_cat.name] = data;
            componentsRef.iconTexturebtn_cat.uri = this.uiApi.createUri(this.uiApi.me().getConstant("icon") + data.gfxId + ".png");
            componentsRef.btn_cat.selected = selected;
            if(data.order == 2)
            {
               this._btnHappy = componentsRef.btn_cat;
            }
            else if(data.order == 1)
            {
               componentsRef.btn_cat.softDisabled = currentContext != ContextEnum.ROLEPLAY;
            }
            componentsRef.btn_cat.visible = true;
         }
         else
         {
            componentsRef.btn_cat.visible = false;
         }
      }
      
      public function updateEmote(data:*, componentsRef:*, selected:Boolean) : void
      {
         componentsRef.slot_emote.dropValidator = this.dropValidatorFunction;
         if(data)
         {
            componentsRef.slot_emote.data = data;
            this._slotByEmoteId[data.id] = componentsRef.slot_emote;
            componentsRef.slot_emote.allowDrag = true;
            if(this._usableEmotes.indexOf(data.id) == -1)
            {
               componentsRef.btn_emote.softDisabled = true;
            }
            else
            {
               componentsRef.btn_emote.softDisabled = false;
            }
         }
         else
         {
            componentsRef.slot_emote.data = null;
         }
      }
      
      private function resizeText(lbl:Label, width:Number) : void
      {
         lbl.removeTooltipExtension();
         lbl.finalized = false;
         lbl.width = width;
         if(lbl.textfield.textWidth > lbl.width + 1)
         {
            lbl.addTooltipExtension();
         }
         lbl.finalized = true;
      }
      
      public function renderUpdate() : void
      {
         this.tx_title.x = this.ctr_bg.x;
         this.tx_title.y = this.ctr_bg.y - 29;
         this.tx_title.width = this.ctr_bg.width + 1;
         this.lbl_title.x = this.tx_title.x + 6;
         this.lbl_title.y = this.tx_title.y + 6;
         this.resizeText(this.lbl_title,this.ctr_bg.width - 28);
         this.btn_close.x = this.lbl_title.x + this.lbl_title.width;
         this.btn_close.y = this.tx_title.y + 7;
         this.ctr_category.x = this.tx_title.x;
         this.ctr_category.y = this.tx_title.y + 31;
         this.ctr_category.height = this.ctr_bg.height - 6;
         this.tx_catbg.height = this.ctr_category.height;
         this.ctr_grid.x = this.ctr_category.x + 39;
         this.ctr_grid.y = this.ctr_category.y;
      }
      
      public function restrictPosition() : void
      {
         var visibleBounds:Rectangle = this.uiApi.getVisibleStageBounds();
         var x:Number = this.mainCtr.x + this.ctr_bg.x;
         if(x + this.ctr_bg.width > visibleBounds.right)
         {
            this.mainCtr.x = visibleBounds.right - (this.ctr_bg.x + this.ctr_bg.width);
         }
         if(x < visibleBounds.left)
         {
            this.mainCtr.x = visibleBounds.left - this.ctr_bg.x;
         }
         var y:Number = this.mainCtr.y + this.ctr_bg.y - 29;
         if(y < visibleBounds.top)
         {
            this.mainCtr.y = -(this.ctr_bg.y - 29);
         }
         if(y + this.ctr_bg.height + 29 > visibleBounds.bottom)
         {
            this.mainCtr.y = visibleBounds.bottom - Math.min(this.ctr_bg.height + this.ctr_bg.y,visibleBounds.bottom);
         }
      }
      
      private function createSmileyListWithPacks() : void
      {
         var oldSw:SmileyWrapper = null;
         var sw:SmileyWrapper = null;
         var indexInTheLine:int = 0;
         var i:int = 0;
         this._completeSmileyList = [];
         var allSmileys:Array = this.dataApi.getSmileyWrappers();
         var cols:int = Math.floor((this.gd_smileys.width - 20) / this.gd_smileys.slotWidth);
         var counter:int = 0;
         var rest:int = 0;
         for each(sw in allSmileys)
         {
            counter++;
            if(oldSw && sw.packId != oldSw.packId)
            {
               indexInTheLine = (counter - 1) % cols;
               if(indexInTheLine > 0)
               {
                  rest = cols - indexInTheLine;
                  for(i = 0; i < rest; i++)
                  {
                     this._completeSmileyList.push(null);
                     counter++;
                  }
               }
            }
            this._completeSmileyList.push(sw);
            oldSw = sw;
         }
      }
      
      private function displayCurrentType() : void
      {
         var sw:SmileyWrapper = null;
         var favSmileyIds:* = undefined;
         var favSmileyWrappers:Array = null;
         var id:int = 0;
         var categorySmileyList:Array = null;
         sysApi.dispatchHook(TriggerHookList.OpenSmileys);
         if(this._currentSmileyCategory == 0)
         {
            this._usableEmotes = this.rpApi.getUsableEmotesList();
            this.gd_emotes.dataProvider = this.rpApi.getEmotesList();
            this.updateGridSize(this.gd_emotes);
            this.gd_emotes.visible = true;
            this.gd_smileys.visible = false;
         }
         else
         {
            this._selectedTxList = [];
            if(this._currentSmileyCategory == -1)
            {
               favSmileyIds = sysApi.getOption("favoriteSmileys","chat");
               favSmileyWrappers = [];
               for each(id in favSmileyIds)
               {
                  for each(sw in this._completeSmileyList)
                  {
                     if(sw && sw.id == id)
                     {
                        favSmileyWrappers.push(sw);
                     }
                  }
               }
               this.gd_smileys.dataProvider = favSmileyWrappers;
            }
            else
            {
               categorySmileyList = [];
               for each(sw in this._completeSmileyList)
               {
                  if(sw && sw.categoryId == this._currentSmileyCategory)
                  {
                     categorySmileyList.push(sw);
                  }
               }
               this.gd_smileys.dataProvider = categorySmileyList;
            }
            this.updateGridSize(this.gd_smileys);
            this.gd_smileys.visible = true;
            this.gd_emotes.visible = false;
            this._currentMood = this.chatApi.getSmileyMood();
            if(this._currentMood != 0 && this._selectedTxList[this._currentMood])
            {
               this._selectedTxList[this._currentMood].visible = true;
            }
         }
      }
      
      private function updateGridSize(pGrid:Grid) : void
      {
         var gridWidth:Number = this.ctr_bg.width - 47;
         var gridHeight:Number = this.ctr_bg.height - 11;
         pGrid.finalized = false;
         pGrid.width = gridWidth;
         pGrid.height = gridHeight;
         pGrid.dataProvider = pGrid.dataProvider;
      }
      
      public function onPress(target:GraphicContainer) : void
      {
         sysApi.addEventListener(this.onEnterFrame,"smileysOnEnterFrame");
      }
      
      private function onEnterFrame(e:Event) : void
      {
         var resized:Boolean = false;
         var currentGrid:Grid = this._currentSmileyCategory == 0 ? this.gd_emotes : this.gd_smileys;
         currentGrid.visible = this.ctr_bg.width == this._bgLastWidth && this.ctr_bg.height == this._bgLastHeight;
         if(!this.uiApi.getMouseDown())
         {
            resized = this.ctr_bg.width != this._bgLastWidth || this.ctr_bg.height != this._bgLastHeight;
            if(resized)
            {
               this.updateGridSize(currentGrid);
            }
            currentGrid.visible = true;
            this._bgLastWidth = this.ctr_bg.width;
            this._bgLastHeight = this.ctr_bg.height;
            sysApi.removeEventListener(this.onEnterFrame);
         }
      }
      
      public function onShortcut(shortcut:String) : Boolean
      {
         if(shortcut == ShortcutHookListEnum.CLOSE_UI)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
            return true;
         }
         return false;
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var smileyCat:SmileyCategory = null;
         if(target.name.indexOf("btn_cat") != -1)
         {
            smileyCat = this._gridComponentsList[target.name];
            this._currentSmileyCategory = smileyCat.id;
            sysApi.setData("smileyLastCategoryOpened",this._currentSmileyCategory);
            this.displayCurrentType();
         }
         else if(target == this.btn_close)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var smileyItem:Object = null;
         var emoteItem:Object = null;
         var slot:Slot = null;
         switch(target)
         {
            case this.gd_smileys:
               if(selectMethod != 7)
               {
                  smileyItem = (target as Grid).selectedItem;
                  if(smileyItem && this._playSmileAllowed)
                  {
                     sysApi.sendAction(new ChatSmileyRequestAction([smileyItem.id]));
                     this._playSmileAllowed = false;
                     this._playSmileAllowedTimer.start();
                  }
                  if(sysApi.getOption("smileysAutoclosed","chat"))
                  {
                     this.uiApi.unloadUi(this.uiApi.me().name);
                  }
               }
               break;
            case this.gd_emotes:
               if(selectMethod != 7)
               {
                  emoteItem = (target as Grid).selectedItem;
                  if(emoteItem && this._playSmileAllowed)
                  {
                     slot = this._slotByEmoteId[emoteItem.id] as Slot;
                     if(slot != null)
                     {
                        sysApi.sendAction(new EmotePlayRequestAction([emoteItem.id]));
                        this._playSmileAllowed = false;
                        this._playSmileAllowedTimer.start();
                     }
                  }
                  if(sysApi.getOption("smileysAutoclosed","chat"))
                  {
                     this.uiApi.unloadUi(this.uiApi.me().name);
                  }
               }
         }
      }
      
      public function onPlaySmileAllowedTimer(e:TimerEvent) : void
      {
         this._playSmileAllowed = true;
      }
      
      public function onItemRollOver(target:GraphicContainer, item:Object) : void
      {
         var data:Object = null;
         var ref:Object = null;
         var txt:* = null;
         if(target == this.gd_emotes)
         {
            ref = item.container;
            if(item.data)
            {
               if(!this._shortcutColor)
               {
                  this._shortcutColor = sysApi.getConfigEntry("colors.shortcut");
                  this._shortcutColor = this._shortcutColor.replace("0x","#");
               }
               txt = item.data.name + " <font color=\'" + this._shortcutColor + "\'>(/" + item.data.shortcut + ")</font>";
               if(this._usableEmotes.indexOf(item.data.id) == -1)
               {
                  txt += "\n" + (item.data.id == 102 ? this.uiApi.getText("ui.smiley.emoteGhostOnly") : this.uiApi.getText("ui.smiley.emoteDisabled"));
               }
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(txt),ref,false,"standard",7,1,3,null,null,null,"TextInfo");
            }
         }
         else if(target == this.gd_smileys)
         {
            ref = item.container;
            if(item.data && item.data.id == this._currentMood)
            {
               txt = this.uiApi.getText("ui.smiley.mood");
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(txt),ref,false,"standard",7,1,3,null,null,null,"TextInfo");
            }
         }
         else if(target == this.gd_smileyCategories)
         {
            ref = item.container;
            if(item.data && item.data.gfxId)
            {
               txt = this.uiApi.getText("ui.smiley.tooltip." + item.data.gfxId);
               this.uiApi.showTooltip(this.uiApi.textTooltipInfo(txt),ref,false,"standard",7,1,3,null,null,null,"TextInfo");
            }
         }
      }
      
      public function onItemRollOut(target:GraphicContainer, item:Object) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onItemRightClick(target:GraphicContainer, item:Object) : void
      {
         if(item.data == null)
         {
            return;
         }
         var data:Object = item.data;
         if(this._currentMood == data.id)
         {
            sysApi.sendAction(new MoodSmileyRequestAction([0]));
         }
         else
         {
            sysApi.sendAction(new MoodSmileyRequestAction([data.id]));
         }
      }
      
      public function onEmoteListUpdated() : void
      {
         this._usableEmotes = this.rpApi.getUsableEmotesList();
         this.gd_emotes.dataProvider = this.rpApi.getEmotesList();
      }
      
      public function onEmoteEnabledListUpdated(emotesOk:Object) : void
      {
         this._usableEmotes = this.rpApi.getUsableEmotesList();
         var vsv:int = this.gd_emotes.verticalScrollValue;
         this.gd_emotes.dataProvider = this.rpApi.getEmotesList();
         this.gd_emotes.verticalScrollValue = vsv;
      }
      
      public function onMoodResult(resultCode:uint, smileyId:int) : void
      {
         if(resultCode == 0)
         {
            if(this._currentMood != 0 && this._selectedTxList[this._currentMood])
            {
               this._selectedTxList[this._currentMood].visible = false;
            }
            this._currentMood = smileyId;
            if(this._currentMood != 0 && this._selectedTxList[this._currentMood])
            {
               this._selectedTxList[this._currentMood].visible = true;
            }
         }
         else if(resultCode == 1)
         {
            sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.smiley.errorMood"),666,this.timeApi.getTimestamp());
         }
         else if(resultCode == 2)
         {
            sysApi.dispatchHook(ChatHookList.TextInformation,this.uiApi.getText("ui.smiley.errorFloodMood"),666,this.timeApi.getTimestamp());
         }
      }
      
      private function onSmileysStart(type:int, forceOpen:String = "") : void
      {
         if(forceOpen == "true")
         {
            if(type == 1)
            {
               this._currentSmileyCategory = 0;
            }
            this.displayCurrentType();
         }
         else
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
      }
      
      private function onSmileyListUpdated() : void
      {
         this.createSmileyListWithPacks();
         this.displayCurrentType();
      }
      
      public function dropValidatorFunction(target:Object, iSlotData:Object, source:Object) : Boolean
      {
         return false;
      }
      
      public function removeDropSourceFunction(target:Object) : void
      {
      }
      
      public function processDropFunction(iSlotDataHolder:Object, data:Object, source:Object) : void
      {
         iSlotDataHolder.data = data;
      }
      
      public function onDoubleClick(target:Object) : void
      {
         if(target == this.tx_title)
         {
            this.updateGridSize(this._currentSmileyCategory == 0 ? this.gd_emotes : this.gd_smileys);
         }
      }
   }
}
