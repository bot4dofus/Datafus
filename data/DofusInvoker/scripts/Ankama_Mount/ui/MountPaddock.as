package Ankama_Mount.ui
{
   import Ankama_Mount.enums.MountFilterEnum;
   import Ankama_Mount.enums.MountFilterGroupEnum;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.enums.SelectMethodEnum;
   import com.ankamagames.berilia.enums.UIEnum;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.mount.MountData;
   import com.ankamagames.dofus.logic.game.common.actions.mount.ExchangeHandleMountStableAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.LeaveExchangeMountAction;
   import com.ankamagames.dofus.logic.game.common.actions.mount.MountInfoRequestAction;
   import com.ankamagames.dofus.misc.lists.MountHookList;
   import com.ankamagames.dofus.misc.lists.ShortcutHookListEnum;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   import com.ankamagames.dofus.network.ProtocolConstantsEnum;
   import com.ankamagames.dofus.network.enums.ExchangeHandleMountStableTypeEnum;
   import com.ankamagames.dofus.uiApi.BindsApi;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.MapApi;
   import com.ankamagames.dofus.uiApi.MountApi;
   import com.ankamagames.dofus.uiApi.PlayedCharacterApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.dofus.uiApi.TooltipApi;
   import com.ankamagames.dofus.uiApi.UtilApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.display.DisplayObject;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   
   public class MountPaddock
   {
      
      public static const SOURCE_EQUIP:int = 0;
      
      public static const SOURCE_INVENTORY:int = 1;
      
      public static const SOURCE_BARN:int = 2;
      
      public static const SOURCE_PADDOCK:int = 3;
      
      public static const SORT_TYPE_TYPE:int = 0;
      
      public static const SORT_TYPE_GENDER:int = 1;
      
      public static const SORT_TYPE_NAME:int = 2;
      
      public static const SORT_TYPE_LEVEL:int = 3;
      
      public static const SHORTCUT_STOCK:String = "s1";
      
      public static const SHORTCUT_PARK:String = "s2";
      
      public static const SHORTCUT_EXCHANGE:String = "s4";
      
      public static const SHORTCUT_EQUIP:String = "s3";
      
      public static var _currentSource:int = -2;
       
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="PlayedCharacterApi")]
      public var playerApi:PlayedCharacterApi;
      
      [Api(name="MountApi")]
      public var mountApi:MountApi;
      
      [Api(name="BindsApi")]
      public var bindsApi:BindsApi;
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="UtilApi")]
      public var utilApi:UtilApi;
      
      [Api(name="TooltipApi")]
      public var tooltipApi:TooltipApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="MapApi")]
      public var mapApi:MapApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Object;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:Object;
      
      private var _mountInfoUi:Object;
      
      private var _mountInfoUiLoaded:Boolean = false;
      
      private var _mount:Object;
      
      private var _nameless:String;
      
      private var _lastSource:int = -2;
      
      private var _maxOutdoorMount:int;
      
      private var _barnList:Array;
      
      private var _paddockList:Array;
      
      private var _inventoryList:Object;
      
      private var _isPublic:Boolean;
      
      private var _hookedComponents:Dictionary;
      
      private var _assetsUri:String;
      
      private var _mountsUri:String;
      
      private var _fullDataProvider:Array;
      
      private var _stableFilters:Array;
      
      private var _stableFilter2:Array;
      
      private var _stableFilter3:Array;
      
      private var _paddockFilters:Array;
      
      private var _barnSortOrder:Array;
      
      private var _paddockSortOrder:Array;
      
      private var _lastSortOptions:Array;
      
      private var _infoRequestTimer:BenchmarkTimer;
      
      private var _infoRequestSelectedItem;
      
      public var mainCtr:GraphicContainer;
      
      public var btn_mountEquiped:ButtonContainer;
      
      public var ed_mount:EntityDisplayer;
      
      public var lbl_mountEquiped:Label;
      
      public var lbl_mountName:Label;
      
      public var lbl_mountDescription:Label;
      
      public var lbl_mountLevel:Label;
      
      public var lbl_park:Label;
      
      public var lbl_certificates:Label;
      
      public var lbl_stock:Label;
      
      public var lbl_noMountEquipped:Label;
      
      public var btn_exchange:ButtonContainer;
      
      public var btn_stock:ButtonContainer;
      
      public var btn_park:ButtonContainer;
      
      public var btn_equip:ButtonContainer;
      
      public var btn_barnCloseSearch:ButtonContainer;
      
      public var btn_paddockCloseSearch:ButtonContainer;
      
      public var btn_inventoryCloseSearch:ButtonContainer;
      
      public var ctr_btnExchange:GraphicContainer;
      
      public var ctr_btnStock:GraphicContainer;
      
      public var ctr_btnPark:GraphicContainer;
      
      public var ctr_btnEquip:GraphicContainer;
      
      public var btn_lbl_btn_exchange:Label;
      
      public var btn_lbl_btn_stock:Label;
      
      public var btn_lbl_btn_park:Label;
      
      public var btn_lbl_btn_equip:Label;
      
      public var btn_close:ButtonContainer;
      
      public var ctr_bgbtntop:GraphicContainer;
      
      public var ctr_bgbtnbottom:GraphicContainer;
      
      public var ctr_mountInfo:GraphicContainer;
      
      public var cb_barn:ComboBox;
      
      public var cb_barn2:ComboBox;
      
      public var cb_barn3:ComboBox;
      
      public var cb_paddock:ComboBox;
      
      public var cb_inventory:ComboBox;
      
      public var bgcb_barn2:TextureBitmap;
      
      public var bgcb_barn3:TextureBitmap;
      
      public var tx_equipedMountSeparator:TextureBitmap;
      
      public var gd_barn:Grid;
      
      public var gd_paddock:Grid;
      
      public var gd_inventory:Grid;
      
      public var ctr_barn:GraphicContainer;
      
      public var ctr_searchBarn:GraphicContainer;
      
      public var ctr_searchPaddock:GraphicContainer;
      
      public var ctr_searchInventory:GraphicContainer;
      
      public var btn_searchBarn:ButtonContainer;
      
      public var btn_searchPaddock:ButtonContainer;
      
      public var btn_searchInventory:ButtonContainer;
      
      public var lbl_searchBarn:Input;
      
      public var lbl_searchPaddock:Input;
      
      public var lbl_searchInventory:Input;
      
      public var btn_barnType:ButtonContainer;
      
      public var btn_barnGender:ButtonContainer;
      
      public var btn_barnName:ButtonContainer;
      
      public var btn_barnLevel:ButtonContainer;
      
      public var btn_paddockType:ButtonContainer;
      
      public var btn_paddockGender:ButtonContainer;
      
      public var btn_paddockName:ButtonContainer;
      
      public var btn_paddockLevel:ButtonContainer;
      
      public var btn_addFilter:ButtonContainer;
      
      public var btn_removeFilter1:ButtonContainer;
      
      public var btn_removeFilter2:ButtonContainer;
      
      public var btn_removeFilter3:ButtonContainer;
      
      public var btn_moveAllFromBarn:ButtonContainer;
      
      public var btn_moveAllFromPark:ButtonContainer;
      
      public var btn_moveAllFromInventory:ButtonContainer;
      
      public function MountPaddock()
      {
         this._hookedComponents = new Dictionary(true);
         this._barnSortOrder = [{
            "type":SORT_TYPE_TYPE,
            "asc":true
         },{
            "type":SORT_TYPE_GENDER,
            "asc":true
         },{
            "type":SORT_TYPE_NAME,
            "asc":true
         },{
            "type":SORT_TYPE_LEVEL,
            "asc":true
         }];
         this._paddockSortOrder = [{
            "type":SORT_TYPE_TYPE,
            "asc":true
         },{
            "type":SORT_TYPE_GENDER,
            "asc":true
         },{
            "type":SORT_TYPE_NAME,
            "asc":true
         },{
            "type":SORT_TYPE_LEVEL,
            "asc":true
         }];
         super();
      }
      
      private static function switchSort(sortOptions:Array, sortType:int) : void
      {
         var i:int = 0;
         var se:Object = null;
         if(sortOptions[0].type == sortType)
         {
            sortOptions[0].asc = !sortOptions[0].asc;
         }
         else
         {
            for(i = 0; i < sortOptions.length; i++)
            {
               se = sortOptions[i];
               if(se.type == sortType)
               {
                  sortOptions.splice(i,1);
                  break;
               }
            }
            se = {
               "type":sortType,
               "asc":true
            };
            sortOptions.unshift(se);
         }
      }
      
      public function main(params:Object) : void
      {
         var shortcut:String = null;
         this._stableFilters = [{
            "label":this.uiApi.getText("ui.common.allTypes"),
            "type":MountFilterEnum.MOUNT_ALL,
            "filterGroup":MountFilterGroupEnum.NO_GROUP
         },{
            "label":this.uiApi.getText("ui.mount.filterCapacity"),
            "type":MountFilterEnum.MOUNT_SPECIAL,
            "filterGroup":MountFilterGroupEnum.NO_GROUP
         },{
            "label":this.uiApi.getText("ui.mount.filterNoName"),
            "type":MountFilterEnum.MOUNT_NAMELESS,
            "filterGroup":MountFilterGroupEnum.NO_GROUP
         },{
            "label":this.uiApi.getText("ui.mount.filterMustXP"),
            "type":MountFilterEnum.MOUNT_TRAINABLE,
            "filterGroup":MountFilterGroupEnum.NO_GROUP
         },{
            "label":this.uiApi.getText("ui.mount.filterMan"),
            "type":MountFilterEnum.MOUNT_MALE,
            "filterGroup":MountFilterGroupEnum.GENDER
         },{
            "label":this.uiApi.getText("ui.mount.filterWoman"),
            "type":MountFilterEnum.MOUNT_FEMALE,
            "filterGroup":MountFilterGroupEnum.GENDER
         },{
            "label":this.uiApi.getText("ui.mount.filterFecondable"),
            "type":MountFilterEnum.MOUNT_FRUITFUL,
            "filterGroup":MountFilterGroupEnum.FERTILITY
         },{
            "label":this.uiApi.getText("ui.mount.filterNoFecondable"),
            "type":MountFilterEnum.MOUNT_NOFRUITFUL,
            "filterGroup":MountFilterGroupEnum.FERTILITY
         },{
            "label":this.uiApi.getText("ui.mount.filterSterilized"),
            "type":MountFilterEnum.MOUNT_STERILIZED,
            "filterGroup":MountFilterGroupEnum.FERTILITY
         },{
            "label":this.uiApi.getText("ui.mount.filterFecondee"),
            "type":MountFilterEnum.MOUNT_FERTILIZED,
            "filterGroup":MountFilterGroupEnum.FERTILITY
         },{
            "label":this.uiApi.getText("ui.mount.filterPositiveSerenity"),
            "type":MountFilterEnum.MOUNT_POSITIVE_SERENITY,
            "filterGroup":MountFilterGroupEnum.SERENITY
         },{
            "label":this.uiApi.getText("ui.mount.filterNegativeSerenity"),
            "type":MountFilterEnum.MOUNT_NEGATIVE_SERENITY,
            "filterGroup":MountFilterGroupEnum.SERENITY
         },{
            "label":this.uiApi.getText("ui.mount.filterAverageSerenity"),
            "type":MountFilterEnum.MOUNT_AVERAGE_SERENITY,
            "filterGroup":MountFilterGroupEnum.SERENITY
         },{
            "label":this.uiApi.getText("ui.mount.filterNeedLove"),
            "type":MountFilterEnum.MOUNT_NEED_LOVE,
            "filterGroup":MountFilterGroupEnum.LOVE
         },{
            "label":this.uiApi.getText("ui.mount.filterFullLove"),
            "type":MountFilterEnum.MOUNT_FULL_LOVE,
            "filterGroup":MountFilterGroupEnum.LOVE
         },{
            "label":this.uiApi.getText("ui.mount.filterNeedStamina"),
            "type":MountFilterEnum.MOUNT_NEED_STAMINA,
            "filterGroup":MountFilterGroupEnum.STAMINA
         },{
            "label":this.uiApi.getText("ui.mount.filterFullStamina"),
            "type":MountFilterEnum.MOUNT_FULL_STAMINA,
            "filterGroup":MountFilterGroupEnum.STAMINA
         },{
            "label":this.uiApi.getText("ui.mount.filterNeedEnergy"),
            "type":MountFilterEnum.MOUNT_NEED_ENERGY,
            "filterGroup":MountFilterGroupEnum.ENERGY
         },{
            "label":this.uiApi.getText("ui.mount.filterFullEnergy"),
            "type":MountFilterEnum.MOUNT_FULL_ENERGY,
            "filterGroup":MountFilterGroupEnum.ENERGY
         },{
            "label":this.uiApi.getText("ui.mount.filterImmature"),
            "type":MountFilterEnum.MOUNT_IMMATURE,
            "filterGroup":MountFilterGroupEnum.AGE
         },{
            "label":this.uiApi.getText("ui.mount.filterBorn"),
            "type":MountFilterEnum.MOUNT_BABY,
            "filterGroup":MountFilterGroupEnum.AGE
         },{
            "label":this.uiApi.getText("ui.mount.filterMountable"),
            "type":MountFilterEnum.MOUNT_MOUNTABLE,
            "filterGroup":MountFilterGroupEnum.AGE
         },{
            "label":this.uiApi.getText("ui.mount.filterNoTired"),
            "type":MountFilterEnum.MOUNT_NOTIRED,
            "filterGroup":MountFilterGroupEnum.TIREDNESS
         },{
            "label":this.uiApi.getText("ui.mount.filterTired","100%"),
            "type":MountFilterEnum.MOUNT_100_TIRED,
            "filterGroup":MountFilterGroupEnum.TIREDNESS
         },{
            "label":this.uiApi.getText("ui.mount.filterTired","&lt;50%"),
            "type":MountFilterEnum.MOUNT_LESS50_TIRED,
            "filterGroup":MountFilterGroupEnum.TIREDNESS
         },{
            "label":this.uiApi.getText("ui.mount.filterTired",">50%"),
            "type":MountFilterEnum.MOUNT_MORE50_TIRED,
            "filterGroup":MountFilterGroupEnum.TIREDNESS
         }];
         this._paddockFilters = [{
            "label":this.uiApi.getText("ui.common.allTypes"),
            "type":MountFilterEnum.MOUNT_ALL,
            "filterGroup":MountFilterGroupEnum.NO_GROUP
         },{
            "label":this.uiApi.getText("ui.mount.filterNoName"),
            "type":MountFilterEnum.MOUNT_NAMELESS,
            "filterGroup":MountFilterGroupEnum.NO_GROUP
         },{
            "label":this.uiApi.getText("ui.mount.filterMustXP"),
            "type":MountFilterEnum.MOUNT_TRAINABLE,
            "filterGroup":MountFilterGroupEnum.NO_GROUP
         },{
            "label":this.uiApi.getText("ui.mount.filterCapacity"),
            "type":MountFilterEnum.MOUNT_SPECIAL,
            "filterGroup":MountFilterGroupEnum.NO_GROUP
         },{
            "label":this.uiApi.getText("ui.mount.filterOwner"),
            "type":MountFilterEnum.MOUNT_OWNER,
            "filterGroup":MountFilterGroupEnum.NO_GROUP
         },{
            "label":this.uiApi.getText("ui.mount.filterMan"),
            "type":MountFilterEnum.MOUNT_MALE,
            "filterGroup":MountFilterGroupEnum.GENDER
         },{
            "label":this.uiApi.getText("ui.mount.filterWoman"),
            "type":MountFilterEnum.MOUNT_FEMALE,
            "filterGroup":MountFilterGroupEnum.GENDER
         },{
            "label":this.uiApi.getText("ui.mount.filterFecondable"),
            "type":MountFilterEnum.MOUNT_FRUITFUL,
            "filterGroup":MountFilterGroupEnum.FERTILITY
         },{
            "label":this.uiApi.getText("ui.mount.filterNoFecondable"),
            "type":MountFilterEnum.MOUNT_NOFRUITFUL,
            "filterGroup":MountFilterGroupEnum.FERTILITY
         },{
            "label":this.uiApi.getText("ui.mount.filterSterilized"),
            "type":MountFilterEnum.MOUNT_STERILIZED,
            "filterGroup":MountFilterGroupEnum.FERTILITY
         },{
            "label":this.uiApi.getText("ui.mount.filterImmature"),
            "type":MountFilterEnum.MOUNT_IMMATURE,
            "filterGroup":MountFilterGroupEnum.FERTILITY
         },{
            "label":this.uiApi.getText("ui.mount.filterFecondee"),
            "type":MountFilterEnum.MOUNT_FERTILIZED,
            "filterGroup":MountFilterGroupEnum.FERTILITY
         },{
            "label":this.uiApi.getText("ui.mount.filterPositiveSerenity"),
            "type":MountFilterEnum.MOUNT_POSITIVE_SERENITY,
            "filterGroup":MountFilterGroupEnum.SERENITY
         },{
            "label":this.uiApi.getText("ui.mount.filterNegativeSerenity"),
            "type":MountFilterEnum.MOUNT_NEGATIVE_SERENITY,
            "filterGroup":MountFilterGroupEnum.SERENITY
         },{
            "label":this.uiApi.getText("ui.mount.filterAverageSerenity"),
            "type":MountFilterEnum.MOUNT_AVERAGE_SERENITY,
            "filterGroup":MountFilterGroupEnum.SERENITY
         },{
            "label":this.uiApi.getText("ui.mount.filterNeedLove"),
            "type":MountFilterEnum.MOUNT_NEED_LOVE,
            "filterGroup":MountFilterGroupEnum.LOVE
         },{
            "label":this.uiApi.getText("ui.mount.filterFullLove"),
            "type":MountFilterEnum.MOUNT_FULL_LOVE,
            "filterGroup":MountFilterGroupEnum.LOVE
         },{
            "label":this.uiApi.getText("ui.mount.filterNeedStamina"),
            "type":MountFilterEnum.MOUNT_NEED_STAMINA,
            "filterGroup":MountFilterGroupEnum.STAMINA
         },{
            "label":this.uiApi.getText("ui.mount.filterFullStamina"),
            "type":MountFilterEnum.MOUNT_FULL_STAMINA,
            "filterGroup":MountFilterGroupEnum.STAMINA
         },{
            "label":this.uiApi.getText("ui.mount.filterNeedEnergy"),
            "type":MountFilterEnum.MOUNT_NEED_ENERGY,
            "filterGroup":MountFilterGroupEnum.ENERGY
         },{
            "label":this.uiApi.getText("ui.mount.filterFullEnergy"),
            "type":MountFilterEnum.MOUNT_FULL_ENERGY,
            "filterGroup":MountFilterGroupEnum.ENERGY
         },{
            "label":this.uiApi.getText("ui.mount.filterBorn"),
            "type":MountFilterEnum.MOUNT_BABY,
            "filterGroup":MountFilterGroupEnum.AGE
         },{
            "label":this.uiApi.getText("ui.mount.filterMountable"),
            "type":MountFilterEnum.MOUNT_MOUNTABLE,
            "filterGroup":MountFilterGroupEnum.AGE
         },{
            "label":this.uiApi.getText("ui.mount.filterNoTired"),
            "type":MountFilterEnum.MOUNT_NOTIRED,
            "filterGroup":MountFilterGroupEnum.TIREDNESS
         },{
            "label":this.uiApi.getText("ui.mount.filterTired","100%"),
            "type":MountFilterEnum.MOUNT_100_TIRED,
            "filterGroup":MountFilterGroupEnum.TIREDNESS
         },{
            "label":this.uiApi.getText("ui.mount.filterTired","&lt;50%"),
            "type":MountFilterEnum.MOUNT_LESS50_TIRED,
            "filterGroup":MountFilterGroupEnum.TIREDNESS
         },{
            "label":this.uiApi.getText("ui.mount.filterTired",">50%"),
            "type":MountFilterEnum.MOUNT_MORE50_TIRED,
            "filterGroup":MountFilterGroupEnum.TIREDNESS
         }];
         this.sysApi.addHook(MountHookList.MountStableUpdate,this.onMountStableUpdate);
         this.sysApi.addHook(BeriliaHookList.KeyUp,this.onKeyUp);
         this.sysApi.addHook(MountHookList.MountSet,this.showPlayerMountInfo);
         this.sysApi.addHook(MountHookList.MountUnSet,this.showPlayerMountInfo);
         this.sysApi.addHook(MountHookList.CertificateMountData,this.onCertificateMountData);
         this.sysApi.addHook(MountHookList.MountRenamed,this.onMountRenamed);
         this.sysApi.addHook(MountHookList.MountReleased,this.onMountReleased);
         this.uiApi.addComponentHook(this.btn_exchange,"onRelease");
         this.uiApi.addComponentHook(this.btn_close,"onRelease");
         this.uiApi.addComponentHook(this.btn_stock,"onRelease");
         this.uiApi.addComponentHook(this.btn_park,"onRelease");
         this.uiApi.addComponentHook(this.btn_equip,"onRelease");
         this.uiApi.addComponentHook(this.gd_barn,"onSelectItem");
         this.uiApi.addComponentHook(this.gd_paddock,"onSelectItem");
         this.uiApi.addComponentHook(this.gd_inventory,"onSelectItem");
         this.uiApi.addComponentHook(this.cb_barn,"onSelectItem");
         this.uiApi.addComponentHook(this.cb_barn2,"onSelectItem");
         this.uiApi.addComponentHook(this.cb_barn3,"onSelectItem");
         this.uiApi.addComponentHook(this.cb_paddock,"onSelectItem");
         this.uiApi.addComponentHook(this.cb_inventory,"onSelectItem");
         this.uiApi.addComponentHook(this.btn_searchBarn,"onRelease");
         this.uiApi.addComponentHook(this.btn_searchPaddock,"onRelease");
         this.uiApi.addComponentHook(this.btn_searchInventory,"onRelease");
         this.uiApi.addComponentHook(this.btn_mountEquiped,"onRelease");
         this.uiApi.addShortcutHook(ShortcutHookListEnum.CLOSE_UI,this.onShortCut);
         this.uiApi.addShortcutHook(SHORTCUT_EQUIP,this.onShortCut);
         this.uiApi.addShortcutHook(SHORTCUT_EXCHANGE,this.onShortCut);
         this.uiApi.addShortcutHook(SHORTCUT_PARK,this.onShortCut);
         this.uiApi.addShortcutHook(SHORTCUT_STOCK,this.onShortCut);
         this.uiApi.hideTooltip();
         this._assetsUri = this.uiApi.me().getConstant("assets");
         this._mountsUri = this.uiApi.me().getConstant("mounts");
         shortcut = this.bindsApi.getShortcutBindStr(SHORTCUT_EQUIP);
         if(shortcut)
         {
            this.btn_lbl_btn_equip.text += " (" + shortcut + ")";
         }
         shortcut = this.bindsApi.getShortcutBindStr(SHORTCUT_EXCHANGE);
         if(shortcut)
         {
            this.btn_lbl_btn_exchange.text += " (" + shortcut + ")";
         }
         shortcut = this.bindsApi.getShortcutBindStr(SHORTCUT_PARK);
         if(shortcut)
         {
            this.btn_lbl_btn_park.text += " (" + shortcut + ")";
         }
         shortcut = this.bindsApi.getShortcutBindStr(SHORTCUT_STOCK);
         if(shortcut)
         {
            this.btn_lbl_btn_stock.text += " (" + shortcut + ")";
         }
         this._nameless = this.uiApi.getText("ui.common.noName");
         this.cb_barn.visible = true;
         this.cb_barn2.visible = false;
         this.bgcb_barn2.visible = false;
         this.cb_barn3.visible = false;
         this.btn_removeFilter1.visible = false;
         this.btn_removeFilter2.visible = false;
         this.btn_removeFilter3.visible = false;
         this.ctr_searchBarn.visible = false;
         this.ctr_searchInventory.visible = false;
         this.ctr_searchPaddock.visible = false;
         this._infoRequestTimer = new BenchmarkTimer(100,1,"MountPaddock._infoRequestTimer");
         this._infoRequestTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onInfoTimerComplete);
         this._isPublic = this.mapApi.hasPublicPaddock(this.playerApi.currentMap().mapId);
         this.showUi(params.stabledList,params.paddockedList);
      }
      
      public function get visible() : Boolean
      {
         return this.mainCtr.visible;
      }
      
      public function hideUi() : void
      {
         this.sysApi.enableWorldInteraction();
         this.mainCtr.visible = false;
         this._mountInfoUi.visible = false;
         this.uiApi.unloadUi(UIEnum.MOUNT_INFO);
         this._mountInfoUiLoaded = false;
         this.sysApi.sendAction(new LeaveExchangeMountAction([]));
      }
      
      public function showUi(stabledList:Object, paddockedList:Object) : void
      {
         var ele:MountData = null;
         var cb1:int = 0;
         var cb2:int = 0;
         var cb3:int = 0;
         this.sysApi.disableWorldInteraction();
         this.mainCtr.visible = true;
         this.sysApi.addHook(BeriliaHookList.UiLoaded,this.onUiLoaded);
         this._mountInfoUi = this.uiApi.loadUiInside(UIEnum.MOUNT_INFO,this.ctr_mountInfo,UIEnum.MOUNT_INFO,{
            "mount":null,
            "paddockMode":true,
            "posX":0,
            "posY":0
         });
         this._mountInfoUi.visible = false;
         this.showPlayerMountInfo();
         this.sourceSelected(-1);
         this.lbl_searchBarn.text = "";
         this.lbl_searchPaddock.text = "";
         this.lbl_searchInventory.text = "";
         this._barnList = [];
         for each(ele in stabledList)
         {
            this._barnList.push(ele);
         }
         this._paddockList = [];
         for each(ele in paddockedList)
         {
            this._paddockList.push(ele);
         }
         this._inventoryList = this.mountApi.getInventoryList();
         this.updateBarnFilter();
         cb1 = MountFilterEnum.MOUNT_ALL;
         cb2 = MountFilterEnum.MOUNT_ALL;
         cb3 = MountFilterEnum.MOUNT_ALL;
         if(this.cb_barn.value)
         {
            cb1 = this.cb_barn.value.type;
         }
         if(this.cb_barn.value)
         {
            cb2 = this.cb_barn2.value.type;
         }
         if(this.cb_barn.value)
         {
            cb3 = this.cb_barn3.value.type;
         }
         this.updateBarn(cb1,cb2,cb3);
         this.updatePaddockFilter();
         var padFilter:int = MountFilterEnum.MOUNT_ALL;
         if(this.cb_paddock.value)
         {
            padFilter = this.cb_paddock.value.type;
         }
         this.updatePaddock(padFilter);
         this.updateInventoryFilter();
         var invFilter:String = "";
         if(this.cb_inventory.value)
         {
            invFilter = this.cb_inventory.value;
         }
         this.updateInventory(invFilter);
         this._maxOutdoorMount = this.mountApi.getCurrentPaddock().maxOutdoorMount;
      }
      
      public function showMountInfo(mount:Object, source:int) : void
      {
         if(mount)
         {
            this._mount = mount;
            _currentSource = source;
            if(this._mount && this._mountInfoUiLoaded && this._mountInfoUi)
            {
               this._mountInfoUi.getElement("ctr_window").x = 0;
               this._mountInfoUi.getElement("ctr_window").y = 0;
               this._mountInfoUi.visible = true;
               this._mountInfoUi.uiClass.showMountInformation(mount,source);
            }
         }
      }
      
      public function showPlayerMountInfo() : void
      {
         var playerMount:MountData = this.playerApi.getMount();
         if(playerMount)
         {
            this.tx_equipedMountSeparator.visible = true;
            this.lbl_mountEquiped.text = this.uiApi.getText("ui.mount.playerMount");
            this.lbl_mountName.text = playerMount.name;
            this.lbl_mountDescription.text = playerMount.description;
            this.lbl_mountLevel.text = this.uiApi.getText("ui.common.level") + this.uiApi.getText("ui.common.colon") + playerMount.level;
            this.ed_mount.look = playerMount.entityLook;
            this.lbl_noMountEquipped.visible = false;
         }
         else
         {
            this.tx_equipedMountSeparator.visible = false;
            this.lbl_noMountEquipped.visible = true;
            this.lbl_mountEquiped.text = this.uiApi.getText("ui.mount.noPlayerMount");
            this.lbl_mountName.text = "";
            this.lbl_mountDescription.text = "";
            this.lbl_mountLevel.text = "";
            this.ed_mount.look = null;
         }
      }
      
      public function showCurrentMountInfo() : void
      {
         if(this.playerApi.getMount())
         {
            this.gd_paddock.selectedIndex = -1;
            this.gd_barn.selectedIndex = -1;
            this.gd_inventory.selectedIndex = -1;
            this.showMountInfo(this.playerApi.getMount(),0);
            this.sourceSelected(SOURCE_EQUIP);
         }
      }
      
      public function unload() : void
      {
         if(this._infoRequestTimer)
         {
            this._infoRequestTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onInfoTimerComplete);
            this._infoRequestTimer.stop();
            this._infoRequestTimer = null;
         }
         if(this.uiApi.getUi(UIEnum.MOUNT_INFO))
         {
            this.uiApi.unloadUi(UIEnum.MOUNT_INFO);
         }
      }
      
      private function getAllMountIdsInGrid(grid:*) : Array
      {
         var mount:* = undefined;
         var mountsId:Array = [];
         for each(mount in grid)
         {
            mountsId.push(mount.id);
         }
         return mountsId;
      }
      
      public function updateMountLine(data:*, components:*, selected:Boolean) : void
      {
         if(!this._hookedComponents[components.btn_mountItem.name])
         {
            this.uiApi.addComponentHook(components.btn_mountItem,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.btn_mountItem,ComponentHookList.ON_ROLL_OUT);
         }
         this._hookedComponents[components.btn_mountItem.name] = data;
         if(data)
         {
            components.btn_mountItem.selected = selected;
            components.btn_mountItem.mouseEnabled = true;
            if(data.modelId == 88 || data.modelId == 89)
            {
               components.tx_icon.visible = false;
               components.tx_icon_back.visible = false;
               components.tx_icon_up.visible = false;
               components.tx_iconSpecialMount.visible = true;
               components.tx_iconSpecialMount.uri = this.uiApi.createUri(this._mountsUri + "head_" + data.modelId + ".swf",true);
            }
            else if(data.colors)
            {
               components.tx_icon.uri = this.uiApi.createUri(this._assetsUri + data.familyHeadUri + "_trait");
               components.tx_icon_back.uri = this.uiApi.createUri(this._assetsUri + data.familyHeadUri + "_color1");
               components.tx_icon_up.uri = this.uiApi.createUri(this._assetsUri + data.familyHeadUri + "_color2");
               this.utilApi.changeColor(components.tx_icon_back,data.colors[1],1);
               this.utilApi.changeColor(components.tx_icon_up,data.colors[2],0);
               components.tx_icon.visible = true;
               components.tx_icon_back.visible = true;
               components.tx_icon_up.visible = true;
               components.tx_iconSpecialMount.visible = false;
            }
            if(data.sex)
            {
               components.tx_sex.themeDataId = "tx_mount_female";
            }
            else
            {
               components.tx_sex.themeDataId = "tx_mount_male";
            }
            components.lbl_name.text = data.name;
            components.lbl_level.text = data.level;
         }
         else
         {
            components.btn_mountItem.mouseEnabled = false;
            components.btn_mountItem.selected = false;
            components.tx_icon.visible = false;
            components.tx_icon_back.visible = false;
            components.tx_icon_up.visible = false;
            components.tx_iconSpecialMount.visible = false;
            components.tx_sex.uri = null;
            components.lbl_name.text = "";
            components.lbl_level.text = "";
         }
      }
      
      public function updateInventoryMountLine(data:*, components:*, selected:Boolean) : void
      {
         if(!this._hookedComponents[components.btn_certificateMountItem.name])
         {
            this.uiApi.addComponentHook(components.btn_certificateMountItem,ComponentHookList.ON_ROLL_OVER);
            this.uiApi.addComponentHook(components.btn_certificateMountItem,ComponentHookList.ON_ROLL_OUT);
            this.uiApi.addComponentHook(components.btn_certificateMountItem,ComponentHookList.ON_RIGHT_CLICK);
         }
         this._hookedComponents[components.btn_certificateMountItem.name] = data;
         if(data)
         {
            components.btn_certificateMountItem.selected = selected;
            components.btn_certificateMountItem.mouseEnabled = true;
            components.slot_icon.data = data;
            components.slot_icon.visible = true;
            if(this.mountApi.isCertificateValid(data))
            {
               components.lbl_name.cssClass = "p";
            }
            else
            {
               components.lbl_name.cssClass = "malus";
            }
            components.lbl_name.text = data.name;
         }
         else
         {
            components.btn_certificateMountItem.mouseEnabled = false;
            components.btn_certificateMountItem.selected = false;
            components.lbl_name.text = "";
            components.slot_icon.visible = false;
         }
      }
      
      private function sourceSelected(source:int) : void
      {
         if(this._lastSource != source)
         {
            this._lastSource = source;
            _currentSource = source;
            if(source == SOURCE_BARN)
            {
               this.gd_barn.autoSelectMode = 1;
               this.gd_inventory.autoSelectMode = 0;
               this.gd_paddock.autoSelectMode = 0;
            }
            else if(source == SOURCE_INVENTORY)
            {
               this.gd_barn.autoSelectMode = 0;
               this.gd_inventory.autoSelectMode = 1;
               this.gd_paddock.autoSelectMode = 0;
            }
            else if(source == SOURCE_PADDOCK)
            {
               this.gd_barn.autoSelectMode = 0;
               this.gd_inventory.autoSelectMode = 0;
               this.gd_paddock.autoSelectMode = 1;
            }
            if(source == -1)
            {
               this._mount = null;
               this.ctr_btnExchange.visible = false;
               this.ctr_btnStock.visible = false;
               this.ctr_btnPark.visible = false;
               this.ctr_btnEquip.visible = false;
               this.ctr_bgbtntop.visible = false;
               this.ctr_bgbtnbottom.visible = false;
               this._mountInfoUi.visible = false;
            }
            else
            {
               if(!this._mountInfoUi)
               {
                  if(!this.uiApi.getUi(UIEnum.MOUNT_INFO))
                  {
                     this._mountInfoUi = this.uiApi.loadUiInside(UIEnum.MOUNT_INFO,this.ctr_mountInfo,UIEnum.MOUNT_INFO,{
                        "mountData":this._mount,
                        "paddockMode":true,
                        "posX":0,
                        "posY":0
                     });
                  }
                  else
                  {
                     this._mountInfoUi = this.uiApi.getUi(UIEnum.MOUNT_INFO);
                     this._mountInfoUi.getElement("ctr_window").x = 0;
                     this._mountInfoUi.getElement("ctr_window").y = 0;
                     this._mountInfoUi.visible = true;
                  }
               }
               this.ctr_btnExchange.visible = true;
               this.ctr_btnStock.visible = true;
               this.ctr_btnPark.visible = true;
               this.ctr_btnEquip.visible = true;
               this.ctr_bgbtntop.visible = true;
               this.ctr_bgbtnbottom.visible = true;
               if(source == 0)
               {
                  this.btn_exchange.disabled = false;
                  this.btn_stock.disabled = false;
                  this.btn_park.disabled = this.playerApi.hasDebt() && !this._isPublic;
                  this.btn_equip.disabled = true;
               }
               else if(source == 1)
               {
                  this.btn_exchange.disabled = true;
                  this.btn_stock.disabled = false;
                  this.btn_park.disabled = this.playerApi.hasDebt() && !this._isPublic;
                  this.btn_equip.disabled = false;
               }
               else if(source == 2)
               {
                  this.btn_exchange.disabled = false;
                  this.btn_stock.disabled = true;
                  this.btn_park.disabled = this.playerApi.hasDebt() && !this._isPublic;
                  this.btn_equip.disabled = false;
               }
               else if(source == 3)
               {
                  this.btn_exchange.disabled = false;
                  this.btn_stock.disabled = false;
                  this.btn_park.disabled = true;
                  this.btn_equip.disabled = false;
               }
            }
         }
      }
      
      private function updateBarnFilter() : void
      {
         var i:int = 0;
         var currentSelection:* = undefined;
         var barnCB:Array = this._stableFilters.slice();
         var nb:int = this._barnList.length;
         barnCB = this.getPertinentFilter(barnCB);
         var capacityAndModel:Array = this.getCapacityAndModelFilterInBarn(this._barnList);
         barnCB = barnCB.concat(capacityAndModel);
         if(this.cb_barn.value)
         {
            currentSelection = this.cb_barn.value;
            this.cb_barn.dataProvider = barnCB;
            nb = barnCB.length;
            for(i = 0; i < nb; i++)
            {
               if(barnCB[i].label == currentSelection.label)
               {
                  this.cb_barn.selectedIndex = i;
                  break;
               }
            }
         }
         else
         {
            this.cb_barn.dataProvider = barnCB;
         }
         if(this.cb_barn2.value)
         {
            currentSelection = this.cb_barn2.value;
            this._stableFilter2 = this.createBarnCb(this.cb_barn.value.filterGroup,this._fullDataProvider,this.cb_barn2);
            this.cb_barn2.dataProvider = this._stableFilter2;
            if(currentSelection.filterGroup != -1 && (currentSelection == this.cb_barn.value || currentSelection.filterGroup == this.cb_barn.value.filterGroup))
            {
               this.cb_barn2.selectedIndex = 0;
            }
            else
            {
               nb = this._stableFilter2.length;
               for(i = 0; i < nb; i++)
               {
                  if(this._stableFilter2[i].label == currentSelection.label)
                  {
                     this.cb_barn2.selectedIndex = i;
                     break;
                  }
               }
            }
         }
         else
         {
            this.cb_barn2.dataProvider = barnCB;
            this.cb_barn2.selectedIndex = 0;
         }
         if(this.cb_barn3.value)
         {
            currentSelection = this.cb_barn3.value;
            this._stableFilter3 = this.createBarnCb(this.cb_barn2.value.filterGroup,this._stableFilter2,this.cb_barn3);
            this.cb_barn3.dataProvider = this._stableFilter3;
            if(currentSelection.filterGroup != -1 && (currentSelection == this.cb_barn.value || currentSelection.filterGroup == this.cb_barn.value.filterGroup || currentSelection == this.cb_barn2.value || currentSelection.filterGroup == this.cb_barn2.value.filterGroup))
            {
               this.cb_barn3.selectedIndex = 0;
            }
            else
            {
               nb = this._stableFilter3.length;
               for(i = 0; i < nb; i++)
               {
                  if(this._stableFilter3[i].label == currentSelection.label)
                  {
                     this.cb_barn3.selectedIndex = i;
                     break;
                  }
               }
            }
         }
         else
         {
            this.cb_barn3.dataProvider = barnCB;
            this.cb_barn3.selectedIndex = 0;
         }
         this._fullDataProvider = barnCB;
      }
      
      private function getPertinentFilter(dataProvider:Array, mountList:* = null, comboBoxRequester:ComboBox = null) : Array
      {
         var mount:Object = null;
         var filter:Object = null;
         var pertinentFilter:Array = [];
         if(!comboBoxRequester)
         {
            mountList = this._barnList.concat();
         }
         if(mountList <= 0)
         {
            pertinentFilter.push(this._stableFilters[0]);
            return pertinentFilter;
         }
         for each(filter in dataProvider)
         {
            if(comboBoxRequester && filter.type == comboBoxRequester.value.type)
            {
               pertinentFilter.push(filter);
            }
            else
            {
               for each(mount in mountList)
               {
                  if(this.mountFilteredBy(mount,filter.type))
                  {
                     pertinentFilter.push(filter);
                     break;
                  }
               }
            }
         }
         return pertinentFilter;
      }
      
      private function createBarnCb(groupType:int, barnCB:Array, cbRequester:ComboBox) : Array
      {
         var mount:* = undefined;
         var value:* = undefined;
         var updateSubFilter:* = false;
         var mountList:* = this.gd_barn.dataProvider;
         var capacityAndModel:Array = [];
         mountList = [];
         if(cbRequester == this.cb_barn2)
         {
            for each(mount in this._barnList)
            {
               if(this.mountFilteredBy(mount,this.cb_barn.value.type))
               {
                  mountList.push(mount);
               }
            }
         }
         else if(cbRequester == this.cb_barn3)
         {
            for each(mount in this._barnList)
            {
               if(this.mountFilter(mount,this.cb_barn.value.type,this.cb_barn2.value.type,MountFilterEnum.MOUNT_ALL,null))
               {
                  mountList.push(mount);
               }
            }
         }
         var newCB:Array = [];
         for each(value in barnCB)
         {
            if(value.filterGroup == -1 || value.filterGroup as int != groupType && value.filterGroup as int != MountFilterGroupEnum.MODEL && value.filterGroup as int != MountFilterGroupEnum.CAPACITY && value.filterGroup as int != MountFilterGroupEnum.FAMILY)
            {
               newCB.push(value);
            }
         }
         barnCB = newCB;
         if(cbRequester)
         {
            updateSubFilter = cbRequester != this.cb_barn;
            capacityAndModel = this.getCapacityAndModelFilterInBarn(mountList,updateSubFilter,cbRequester);
         }
         barnCB = this.getPertinentFilter(barnCB,mountList,cbRequester);
         return barnCB.concat(capacityAndModel);
      }
      
      private function getCapacityAndModelFilterInBarn(dataProvider:*, checkSubFilter:Boolean = false, comboBoxRequester:ComboBox = null) : Array
      {
         var i:int = 0;
         var mount:Object = null;
         var nCapacity:int = 0;
         var familyId:int = 0;
         var j:int = 0;
         var nb:int = dataProvider.length;
         var modeleAdded:Array = [];
         var capacityAdded:Array = [];
         var familiyAdded:Array = [];
         if(checkSubFilter)
         {
            if(this.cb_barn.value.filterGroup == MountFilterGroupEnum.CAPACITY)
            {
               capacityAdded.push(this.cb_barn.value.type);
            }
            else if(this.cb_barn.value.filterGroup == MountFilterGroupEnum.MODEL)
            {
               modeleAdded.push(this.cb_barn.value.type);
            }
            else if(this.cb_barn.value.filterGroup == MountFilterGroupEnum.FAMILY)
            {
               familiyAdded.push(this.cb_barn.value.type);
            }
            if(this.cb_barn2)
            {
               if(this.cb_barn2.value.filterGroup == MountFilterGroupEnum.CAPACITY)
               {
                  capacityAdded.push(this.cb_barn2.value.type);
               }
               else if(this.cb_barn2.value.filterGroup == MountFilterGroupEnum.MODEL)
               {
                  modeleAdded.push(this.cb_barn2.value.type);
               }
               else if(this.cb_barn2.value.filterGroup == MountFilterGroupEnum.FAMILY)
               {
                  familiyAdded.push(this.cb_barn2.value.type);
               }
            }
         }
         var modelToAdd:Array = [];
         var capacityToAdd:Array = [];
         var familyToAdd:Array = [];
         if(comboBoxRequester)
         {
            if(comboBoxRequester.value.filterGroup == MountFilterGroupEnum.CAPACITY)
            {
               capacityAdded.push(comboBoxRequester.value.type);
               capacityToAdd.push(comboBoxRequester.value);
            }
            else if(comboBoxRequester.value.filterGroup == MountFilterGroupEnum.MODEL)
            {
               modeleAdded.push(comboBoxRequester.value.type);
               modelToAdd.push(comboBoxRequester.value);
            }
            else if(comboBoxRequester.value.filterGroup == MountFilterGroupEnum.FAMILY)
            {
               familiyAdded.push(comboBoxRequester.value.type);
               familyToAdd.push(comboBoxRequester.value);
            }
         }
         for(i = 0; i < nb; i++)
         {
            mount = dataProvider[i];
            if(modeleAdded.indexOf(-mount.modelId) == -1)
            {
               modeleAdded.push(-mount.modelId);
               modelToAdd.push({
                  "label":mount.description,
                  "type":-mount.modelId,
                  "filterGroup":MountFilterGroupEnum.MODEL
               });
            }
            if(familiyAdded.indexOf(9000 + mount.model.familyId) == -1)
            {
               familyId = mount.model.familyId;
               familiyAdded.push(9000 + familyId);
               familyToAdd.push({
                  "label":this.dataApi.getMountFamilyNameById(familyId),
                  "type":9000 + mount.model.familyId,
                  "filterGroup":MountFilterGroupEnum.FAMILY
               });
            }
            nCapacity = mount.ability.length;
            if(nCapacity)
            {
               for(j = 0; j < nCapacity; j++)
               {
                  if(capacityAdded.indexOf(100 + mount.ability[j].id) == -1)
                  {
                     capacityAdded.push(100 + mount.ability[j].id);
                     capacityToAdd.push({
                        "label":mount.ability[j].name,
                        "type":100 + mount.ability[j].id,
                        "filterGroup":MountFilterGroupEnum.CAPACITY
                     });
                  }
               }
            }
         }
         if(!checkSubFilter || familyToAdd.length > 1)
         {
            familyToAdd.sort(this.sortLabelAlphabetically);
         }
         else
         {
            familyToAdd = [];
         }
         if(!checkSubFilter || capacityToAdd.length > 1)
         {
            capacityToAdd.sort(this.sortLabelAlphabetically);
         }
         else
         {
            capacityToAdd = [];
         }
         if(!checkSubFilter || modelToAdd.length > 1)
         {
            modelToAdd.sort(this.sortLabelAlphabetically);
         }
         else
         {
            modelToAdd = [];
         }
         return familyToAdd.concat(capacityToAdd.concat(modelToAdd));
      }
      
      private function sortLabelAlphabetically(a:Object, b:Object) : int
      {
         if(a.label < b.label)
         {
            return -1;
         }
         if(a.label > b.label)
         {
            return 1;
         }
         return 0;
      }
      
      private function updateBarn(filterType:int, filterType2:int, filterType3:int) : void
      {
         var mount:MountData = null;
         var textFilter:String = this.lbl_searchBarn.text;
         var gridProvider:Array = [];
         if(this._barnList.length == 0 && _currentSource == SOURCE_BARN)
         {
            this.sourceSelected(-1);
         }
         var nb:int = this._barnList.length;
         for(var i:int = 0; i < nb; i++)
         {
            mount = this._barnList[i];
            if(this.mountFilter(mount,filterType,filterType2,filterType3,textFilter))
            {
               gridProvider.push(mount);
            }
         }
         this.applySort(gridProvider,this._barnSortOrder);
         this.gd_barn.dataProvider = gridProvider;
         this.updateBarnFilter();
         this.lbl_stock.text = this.uiApi.getText("ui.mount.numMountBarn",gridProvider.length + "/" + ProtocolConstantsEnum.MAX_STABLED_RIDES);
      }
      
      private function updatePaddockFilter() : void
      {
         var mount:MountData = null;
         var nCapacity:int = 0;
         var familyId:int = 0;
         var j:int = 0;
         var currentSelection:String = null;
         var k:int = 0;
         var modeleAdded:Array = [];
         var capacityAdded:Array = [];
         var familyAdded:Array = [];
         var modelToAdd:Array = [];
         var capacityToAdd:Array = [];
         var familyToAdd:Array = [];
         var paddockCB:Array = this._paddockFilters.slice();
         var nb:int = this._paddockList.length;
         for(var i:int = 0; i < nb; i++)
         {
            mount = this._paddockList[i];
            if(modeleAdded.indexOf(mount.modelId) == -1)
            {
               modeleAdded.push(mount.modelId);
               modelToAdd.push({
                  "label":mount.description,
                  "type":-mount.modelId,
                  "filterGroup":MountFilterGroupEnum.MODEL
               });
            }
            if(familyAdded.indexOf(9000 + mount.model.familyId) == -1)
            {
               familyId = mount.model.familyId;
               familyAdded.push(9000 + familyId);
               familyToAdd.push({
                  "label":this.dataApi.getMountFamilyNameById(familyId),
                  "type":9000 + mount.model.familyId,
                  "filterGroup":MountFilterGroupEnum.FAMILY
               });
            }
            nCapacity = mount.ability.length;
            if(nCapacity)
            {
               for(j = 0; j < nCapacity; j++)
               {
                  if(capacityAdded.indexOf(mount.ability[j].id) == -1)
                  {
                     capacityAdded.push(mount.ability[j].id);
                     capacityToAdd.push({
                        "label":mount.ability[j].name,
                        "type":100 + mount.ability[j].id,
                        "filterGroup":MountFilterGroupEnum.CAPACITY
                     });
                  }
               }
            }
         }
         familyToAdd.sort(this.sortLabelAlphabetically);
         capacityToAdd.sort(this.sortLabelAlphabetically);
         modelToAdd.sort(this.sortLabelAlphabetically);
         paddockCB = paddockCB.concat(familyToAdd.concat(capacityToAdd.concat(modelToAdd)));
         if(this.cb_paddock.value)
         {
            currentSelection = this.cb_paddock.value.label;
            nb = paddockCB.length;
            for(k = 0; k < nb; k++)
            {
               if(paddockCB[k].label == currentSelection)
               {
                  break;
               }
            }
            this.cb_paddock.dataProvider = paddockCB;
         }
         else
         {
            this.cb_paddock.dataProvider = paddockCB;
         }
      }
      
      private function updatePaddock(filterType:int) : void
      {
         var mount:MountData = null;
         var textFilter:String = this.lbl_searchPaddock.text;
         var gridProvider:Array = [];
         if(this._paddockList.length == 0 && _currentSource == SOURCE_PADDOCK)
         {
            this.sourceSelected(-1);
         }
         var nb:int = this._paddockList.length;
         for(var i:int = 0; i < nb; i++)
         {
            mount = this._paddockList[i];
            if(this.mountFilter(mount,filterType,MountFilterEnum.MOUNT_ALL,MountFilterEnum.MOUNT_ALL,textFilter))
            {
               gridProvider.push(mount);
            }
         }
         this.applySort(gridProvider,this._paddockSortOrder);
         this.gd_paddock.dataProvider = gridProvider;
         this.lbl_park.text = this.uiApi.getText("ui.mount.numMountPaddock",gridProvider.length + "/" + this._maxOutdoorMount);
      }
      
      private function updateInventoryFilter() : void
      {
         var item:Object = null;
         var currentSelection:String = null;
         var k:int = 0;
         var modelAdded:Array = [];
         var inventoryCB:Array = new Array({
            "label":this.uiApi.getText("ui.common.allTypes"),
            "type":""
         });
         var nb:int = this._inventoryList.length;
         for(var i:int = 0; i < nb; i++)
         {
            item = this._inventoryList[i];
            if(modelAdded.indexOf(item.name) == -1)
            {
               modelAdded.push(item.name);
               inventoryCB.push({
                  "label":item.name,
                  "type":item.name
               });
            }
         }
         if(this.cb_inventory.value)
         {
            currentSelection = this.cb_inventory.value.label;
            nb = inventoryCB.length;
            for(k = 0; k < nb; k++)
            {
               if(inventoryCB[k].label == currentSelection)
               {
                  this.cb_inventory.dataProvider = inventoryCB;
                  this.cb_inventory.selectedIndex = k;
                  break;
               }
            }
         }
         else
         {
            this.cb_inventory.dataProvider = inventoryCB;
         }
      }
      
      private function updateInventory(filterType:String) : void
      {
         var item:Object = null;
         var textFilter:String = this.lbl_searchInventory.text;
         var gridProvider:Array = [];
         if(this._inventoryList.length == 0 && _currentSource == SOURCE_INVENTORY)
         {
            this.sourceSelected(-1);
         }
         var nbMount:int = 0;
         var nb:int = this._inventoryList.length;
         for(var i:int = 0; i < nb; i++)
         {
            item = this._inventoryList[i];
            if(filterType == "" || item.name == filterType)
            {
               if(textFilter == "" || item.name.toLowerCase().indexOf(textFilter.toLowerCase()) != -1)
               {
                  gridProvider.push(item);
                  nbMount++;
               }
            }
         }
         this.gd_inventory.dataProvider = gridProvider;
         this.lbl_certificates.text = this.uiApi.getText("ui.mount.numCertificates",nbMount);
      }
      
      private function mountFilter(mount:Object, filter:int, filter2:int, filter3:int, textFilter:String) : Boolean
      {
         if(!this.mountFilteredBy(mount,filter))
         {
            return false;
         }
         if(!this.mountFilteredBy(mount,filter2))
         {
            return false;
         }
         if(!this.mountFilteredBy(mount,filter3))
         {
            return false;
         }
         if(textFilter)
         {
            return mount.name.toLowerCase().indexOf(textFilter.toLowerCase()) != -1;
         }
         return true;
      }
      
      private function mountFilteredBy(mount:Object, filter:int) : Boolean
      {
         var nCapacity:int = 0;
         var i:int = 0;
         switch(filter)
         {
            case MountFilterEnum.MOUNT_ALL:
               return true;
            case MountFilterEnum.MOUNT_MALE:
               return !mount.sex;
            case MountFilterEnum.MOUNT_FEMALE:
               return mount.sex;
            case MountFilterEnum.MOUNT_FRUITFUL:
               return mount.isFecondationReady;
            case MountFilterEnum.MOUNT_NOFRUITFUL:
               return !mount.isFecondationReady && mount.reproductionCount != -1 && mount.reproductionCount < mount.reproductionCountMax && mount.level >= 5;
            case MountFilterEnum.MOUNT_FERTILIZED:
               return mount.fecondationTime > 0;
            case MountFilterEnum.MOUNT_BABY:
               return mount.borning;
            case MountFilterEnum.MOUNT_MOUNTABLE:
               return mount.isRideable;
            case MountFilterEnum.MOUNT_NAMELESS:
               return mount.name == this._nameless;
            case MountFilterEnum.MOUNT_SPECIAL:
               return mount.ability.length;
            case MountFilterEnum.MOUNT_TRAINABLE:
               return mount.maturityForAdult && mount.level < 5;
            case MountFilterEnum.MOUNT_100_TIRED:
               return mount.boostLimiter == mount.boostMax;
            case MountFilterEnum.MOUNT_MORE50_TIRED:
               return mount.boostLimiter >= mount.boostMax / 2 && mount.boostLimiter != mount.boostMax;
            case MountFilterEnum.MOUNT_LESS50_TIRED:
               return mount.boostLimiter < mount.boostMax / 2 && mount.boostLimiter != 0;
            case MountFilterEnum.MOUNT_NOTIRED:
               return mount.boostLimiter == 0;
            case MountFilterEnum.MOUNT_STERILIZED:
               return mount.reproductionCount == -1 || mount.reproductionCount == mount.reproductionCountMax;
            case MountFilterEnum.MOUNT_POSITIVE_SERENITY:
               return mount.serenity >= 0;
            case MountFilterEnum.MOUNT_NEGATIVE_SERENITY:
               return mount.serenity < 0;
            case MountFilterEnum.MOUNT_AVERAGE_SERENITY:
               return mount.serenity > -2000 && mount.serenity < 2000;
            case MountFilterEnum.MOUNT_NEED_LOVE:
               return mount.love < 7500;
            case MountFilterEnum.MOUNT_FULL_LOVE:
               return mount.love >= 7500;
            case MountFilterEnum.MOUNT_NEED_STAMINA:
               return mount.stamina < 7500;
            case MountFilterEnum.MOUNT_FULL_STAMINA:
               return mount.stamina >= 7500;
            case MountFilterEnum.MOUNT_IMMATURE:
               return mount.maturity < mount.maturityForAdult;
            case MountFilterEnum.MOUNT_OWNER:
               return mount.ownerId == this.playerApi.id();
            case MountFilterEnum.MOUNT_NEED_ENERGY:
               return mount.energyMax > 0 && mount.energy < mount.energyMax;
            case MountFilterEnum.MOUNT_FULL_ENERGY:
               return mount.energyMax > 0 && mount.energy >= mount.energyMax;
            default:
               if(filter < 0)
               {
                  return mount.modelId == -filter;
               }
               if(filter > 9000)
               {
                  return mount.model.familyId == filter - 9000;
               }
               if(filter > 100)
               {
                  nCapacity = mount.ability.length;
                  if(nCapacity)
                  {
                     for(i = 0; i < nCapacity; i++)
                     {
                        if(mount.ability[i].id == filter - 100)
                        {
                           return true;
                        }
                     }
                  }
               }
               return false;
         }
      }
      
      private function searchSource(mountId:int) : uint
      {
         var barnMount:Object = null;
         var paddockMount:Object = null;
         if(this.playerApi.getMount() && this.playerApi.getMount().id == mountId)
         {
            return SOURCE_EQUIP;
         }
         for each(barnMount in this.gd_barn.dataProvider)
         {
            if(barnMount.id == mountId)
            {
               return SOURCE_BARN;
            }
         }
         for each(paddockMount in this.gd_paddock.dataProvider)
         {
            if(paddockMount.id == mountId)
            {
               return SOURCE_PADDOCK;
            }
         }
         return SOURCE_INVENTORY;
      }
      
      private function moveMount(source:int, target:int) : void
      {
         switch(target)
         {
            case SOURCE_PADDOCK:
               switch(source)
               {
                  case SOURCE_EQUIP:
                     this.sysApi.sendAction(new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_EQUIPED_MOUNTPADDOCK_PUT,[this._mount.id]]));
                     this.sourceSelected(-1);
                     break;
                  case SOURCE_INVENTORY:
                     this.sysApi.sendAction(new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_UNCERTIF_TO_PADDOCK,[this.gd_inventory.selectedItem.objectUID]]));
                     this.sourceSelected(-1);
                     break;
                  case SOURCE_BARN:
                     this.sysApi.sendAction(new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTPADDOCK_PUT,[this._mount.id]]));
                     this.sourceSelected(-1);
               }
               break;
            case SOURCE_BARN:
               switch(source)
               {
                  case SOURCE_PADDOCK:
                     this.sysApi.sendAction(new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTPADDOCK_GET,[this._mount.id]]));
                     this.sourceSelected(-1);
                     break;
                  case SOURCE_EQUIP:
                     this.sysApi.sendAction(new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTSTABLES_PUT,[this._mount.id]]));
                     this.sourceSelected(-1);
                     break;
                  case SOURCE_INVENTORY:
                     if(this.gd_inventory.selectedItem)
                     {
                        this.sysApi.sendAction(new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTSTABLES_UNCERTIF,[this.gd_inventory.selectedItem.objectUID]]));
                        this.sourceSelected(-1);
                     }
               }
               break;
            case SOURCE_INVENTORY:
               switch(source)
               {
                  case SOURCE_PADDOCK:
                     this.sysApi.sendAction(new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTPADDOCK_CERTIF,[this._mount.id]]));
                     this.sourceSelected(-1);
                     break;
                  case SOURCE_BARN:
                     this.sysApi.sendAction(new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTSTABLES_CERTIF,[this._mount.id]]));
                     this.sourceSelected(-1);
                     break;
                  case SOURCE_EQUIP:
                     if(this._mount)
                     {
                        this.sysApi.sendAction(new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_EQUIPED_CERTIF,[this._mount.id]]));
                        this.sourceSelected(-1);
                     }
               }
               break;
            case SOURCE_EQUIP:
               switch(source)
               {
                  case SOURCE_PADDOCK:
                     this.sysApi.sendAction(new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_EQUIPED_MOUNTPADDOCK_GET,[this._mount.id]]));
                     this.sourceSelected(-1);
                     break;
                  case SOURCE_BARN:
                     this.sysApi.sendAction(new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTSTABLES_GET,[this._mount.id]]));
                     this.sourceSelected(-1);
                     break;
                  case SOURCE_INVENTORY:
                     this.sysApi.sendAction(new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_UNCERTIF_TO_EQUIPED,[this.gd_inventory.selectedItem.objectUID]]));
                     this.sourceSelected(-1);
               }
         }
      }
      
      private function addAndRemoveFilter(visible:Boolean, target:String) : void
      {
         if(visible)
         {
            if(!this.cb_barn2.visible)
            {
               this.cb_barn2.visible = true;
               this.bgcb_barn2.visible = true;
               this.gd_barn.height = 270;
               this.gd_barn.dataProvider = this.gd_barn.dataProvider;
               this.ctr_barn.y = this.uiApi.me().getConstant("ctr_barn2FilterY");
               this.btn_addFilter.visible = true;
               this.btn_removeFilter2.visible = true;
               this.btn_removeFilter1.visible = true;
            }
            else if(!this.cb_barn3.visible)
            {
               this.cb_barn3.visible = true;
               this.bgcb_barn3.visible = true;
               this.gd_barn.height = 240;
               this.gd_barn.dataProvider = this.gd_barn.dataProvider;
               this.btn_addFilter.visible = false;
               this.btn_removeFilter3.visible = true;
               this.btn_removeFilter1.visible = true;
               this.ctr_barn.y = this.uiApi.me().getConstant("ctr_barn3FilterY");
            }
         }
         else if(target == "btn_removeFilter1")
         {
            if(this.cb_barn3.visible && this.cb_barn2.visible)
            {
               this.cb_barn.selectedIndex = this.findFilterIndex(this.cb_barn,this.cb_barn2.selectedItem.label);
               this.cb_barn2.selectedIndex = this.findFilterIndex(this.cb_barn2,this.cb_barn3.selectedItem.label);
               this.cb_barn3.visible = false;
               this.bgcb_barn3.visible = false;
               this.cb_barn3.selectedIndex = 0;
               this.gd_barn.height = 270;
               this.ctr_barn.y = this.uiApi.me().getConstant("ctr_barn2FilterY");
               this.gd_barn.dataProvider = this.gd_barn.dataProvider;
               this.btn_addFilter.visible = true;
               this.btn_removeFilter3.visible = false;
            }
            else if(this.cb_barn2.visible)
            {
               this.cb_barn2.visible = false;
               this.bgcb_barn2.visible = false;
               this.cb_barn.selectedIndex = this.findFilterIndex(this.cb_barn,this.cb_barn2.selectedItem.label);
               this.cb_barn2.selectedIndex = 0;
               this.gd_barn.height = 300;
               this.gd_barn.dataProvider = this.gd_barn.dataProvider;
               this.ctr_barn.y = this.uiApi.me().getConstant("ctr_barn1FilterY");
               this.btn_addFilter.visible = true;
               this.btn_removeFilter2.visible = false;
               this.btn_removeFilter1.visible = false;
            }
         }
         else if(target == "btn_removeFilter2")
         {
            if(this.cb_barn3.visible)
            {
               this.cb_barn2.selectedIndex = this.findFilterIndex(this.cb_barn2,this.cb_barn3.selectedItem.label);
               this.cb_barn3.visible = false;
               this.bgcb_barn3.visible = false;
               this.cb_barn3.selectedIndex = 0;
               this.gd_barn.height = 270;
               this.gd_barn.dataProvider = this.gd_barn.dataProvider;
               this.ctr_barn.y = this.uiApi.me().getConstant("ctr_barn2FilterY");
               this.btn_addFilter.visible = true;
               this.btn_removeFilter3.visible = false;
            }
            else
            {
               this.cb_barn2.visible = false;
               this.bgcb_barn2.visible = false;
               this.cb_barn2.selectedIndex = 0;
               this.gd_barn.height = 300;
               this.gd_barn.dataProvider = this.gd_barn.dataProvider;
               this.ctr_barn.y = this.uiApi.me().getConstant("ctr_barn1FilterY");
               this.btn_addFilter.visible = true;
               this.btn_removeFilter2.visible = false;
               this.btn_removeFilter1.visible = false;
            }
         }
         else if(target == "btn_removeFilter3")
         {
            this.cb_barn3.visible = false;
            this.bgcb_barn3.visible = false;
            this.cb_barn3.selectedIndex = 0;
            this.gd_barn.height = 270;
            this.gd_barn.dataProvider = this.gd_barn.dataProvider;
            this.ctr_barn.y = this.uiApi.me().getConstant("ctr_barn2FilterY");
            this.btn_addFilter.visible = true;
            this.btn_removeFilter3.visible = false;
         }
         if(this.cb_barn3.visible)
         {
            this.ctr_barn.height = this.uiApi.me().getConstant("ctr_barn3FilterHeight");
         }
         else if(this.cb_barn2.visible)
         {
            this.ctr_barn.height = this.uiApi.me().getConstant("ctr_barn2FilterHeight");
         }
         else
         {
            this.ctr_barn.height = this.uiApi.me().getConstant("ctr_barn1FilterHeight");
         }
         this.uiApi.me().render();
      }
      
      private function findFilterIndex(comboBox:ComboBox, searchedLabel:String) : int
      {
         var i:int = 0;
         for(i = 0; i < comboBox.dataProvider.length; i++)
         {
            if(comboBox.dataProvider[i].label == searchedLabel)
            {
               break;
            }
         }
         return i;
      }
      
      private function onCertificateMountData(mountInfo:Object) : void
      {
         var source:int = this.searchSource(mountInfo.id);
         this.showMountInfo(mountInfo,source);
         this.sourceSelected(source);
      }
      
      private function onMountStableUpdate(stableList:Object, paddockList:Object, inventoryList:Object) : void
      {
         var filterType:int = 0;
         var filterType2:int = 0;
         var filterType3:int = 0;
         var ele:MountData = null;
         var sFilterType:String = null;
         var source:int = 0;
         if(stableList)
         {
            this._barnList = [];
            for each(ele in stableList)
            {
               this._barnList.push(ele);
            }
            filterType = this.cb_barn.value.type;
            filterType2 = this.cb_barn2.value.type;
            filterType3 = this.cb_barn3.value.type;
            this.updateBarnFilter();
            this.updateBarn(filterType,filterType2,filterType3);
         }
         if(paddockList)
         {
            this._paddockList = [];
            for each(ele in paddockList)
            {
               this._paddockList.push(ele);
            }
            filterType = this.cb_paddock.value.type;
            this.updatePaddockFilter();
            this.updatePaddock(filterType);
         }
         if(inventoryList)
         {
            this._inventoryList = inventoryList;
            sFilterType = this.cb_inventory.value.type;
            this.updateInventoryFilter();
            this.updateInventory(sFilterType);
         }
         if(this._mount)
         {
            source = this.searchSource(this._mount.id);
            if(source == SOURCE_PADDOCK)
            {
               this.gd_paddock.selectedItem = this._mount;
            }
            else if(source == SOURCE_BARN)
            {
               this.gd_barn.selectedItem = this._mount;
            }
            this.showMountInfo(this._mount,source);
         }
      }
      
      public function onUiLoaded(name:String) : void
      {
         if(name == UIEnum.MOUNT_INFO)
         {
            this._mountInfoUiLoaded = true;
            this.sysApi.removeHook(BeriliaHookList.UiLoaded);
            this._mountInfoUi = this.uiApi.getUi(UIEnum.MOUNT_INFO);
            this.showMountInfo(this._mount,_currentSource);
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         switch(target)
         {
            case this.gd_barn:
               if(this.gd_barn.selectedIndex != -1)
               {
                  if(this.gd_paddock.selectedIndex != -1)
                  {
                     this.gd_paddock.selectedIndex = -1;
                  }
                  if(this.gd_inventory.selectedIndex != -1)
                  {
                     this.gd_inventory.selectedIndex = -1;
                  }
                  if(selectMethod == 1)
                  {
                     this.sysApi.sendAction(new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTPADDOCK_PUT,[this.gd_barn.selectedItem.id]]));
                     this.sourceSelected(-1);
                  }
                  else if(this.gd_barn.selectedItem)
                  {
                     this.showMountInfo(this.gd_barn.selectedItem,2);
                     this.sourceSelected(2);
                  }
                  else
                  {
                     this.sourceSelected(-1);
                  }
               }
               break;
            case this.gd_paddock:
               if(this.gd_paddock.selectedIndex != -1)
               {
                  if(this.gd_barn.selectedIndex != -1)
                  {
                     this.gd_barn.selectedIndex = -1;
                  }
                  if(this.gd_inventory.selectedIndex != -1)
                  {
                     this.gd_inventory.selectedIndex = -1;
                  }
                  if(selectMethod == 1)
                  {
                     this.sysApi.sendAction(new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTPADDOCK_GET,[this.gd_paddock.selectedItem.id]]));
                  }
                  else if(this.gd_paddock.selectedItem)
                  {
                     this.showMountInfo(this.gd_paddock.selectedItem,3);
                     this.sourceSelected(3);
                  }
                  else
                  {
                     this.sourceSelected(-1);
                  }
               }
               break;
            case this.gd_inventory:
               if(this.gd_inventory.selectedIndex != -1)
               {
                  if(this.gd_barn.selectedIndex != -1)
                  {
                     this.gd_barn.selectedIndex = -1;
                  }
                  if(this.gd_paddock.selectedIndex != -1)
                  {
                     this.gd_paddock.selectedIndex = -1;
                  }
                  if(selectMethod == 1)
                  {
                     this.sysApi.sendAction(new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTSTABLES_UNCERTIF,[this.gd_inventory.selectedItem.objectUID]]));
                  }
                  else if(this.mountApi.isCertificateValid(this.gd_inventory.selectedItem))
                  {
                     this._infoRequestSelectedItem = this.gd_inventory.selectedItem;
                     this._infoRequestTimer.stop();
                     this._infoRequestTimer.reset();
                     this._infoRequestTimer.start();
                  }
                  else if(selectMethod != SelectMethodEnum.AUTO)
                  {
                     this.sourceSelected(-1);
                     this.modCommon.openPopup(this.uiApi.getText("ui.popup.warning"),this.uiApi.getText("ui.mount.invalidCertificate"),[this.uiApi.getText("ui.common.ok")]);
                  }
               }
               break;
            case this.cb_barn:
               if(!isNewSelection)
               {
                  break;
               }
               this.updateBarn(this.cb_barn.value.type,this.cb_barn2.value.type,this.cb_barn3.value.type);
               break;
            case this.cb_barn2:
               if(!isNewSelection)
               {
                  break;
               }
               this.updateBarn(this.cb_barn.value.type,this.cb_barn2.value.type,this.cb_barn3.value.type);
               break;
            case this.cb_barn3:
               if(!isNewSelection)
               {
                  break;
               }
               this.updateBarn(this.cb_barn.value.type,this.cb_barn2.value.type,this.cb_barn3.value.type);
               break;
            case this.cb_paddock:
               this.updatePaddock((target as ComboBox).value.type);
               break;
            case this.cb_inventory:
               this.updateInventory((target as ComboBox).value.type);
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:* = null;
         var data:Object = null;
         var tooltipInfo:TextTooltipInfo = null;
         var itemTooltipSettings:ItemTooltipSettings = null;
         var settings:Object = null;
         var setting:* = null;
         var classCss:String = "p";
         if(target == this.btn_moveAllFromBarn || target == this.btn_moveAllFromInventory || target == this.btn_moveAllFromPark)
         {
            tooltipText = this.uiApi.getText("ui.storage.advancedTransferts");
         }
         else
         {
            if(target.name.indexOf("btn_mountItem") != -1)
            {
               data = this._hookedComponents[target.name];
               if(!data)
               {
                  return;
               }
               if(data.reproductionCount == -1)
               {
                  classCss = "red";
                  tooltipText = this.uiApi.getText("ui.mount.castrated");
               }
               else if(data.reproductionCount == 20)
               {
                  classCss = "red";
                  tooltipText = this.uiApi.getText("ui.mount.sterilized");
               }
               else if(data.fecondationTime > 0)
               {
                  classCss = "exotic";
                  tooltipText = this.uiApi.getText("ui.mount.fecondee") + " (" + data.fecondationTime + " " + this.uiApi.processText(this.uiApi.getText("ui.time.hours"),"m",data.fecondationTime == 1,data.fecondationTime == 0) + ")";
               }
               else if(data.isFecondationReady)
               {
                  classCss = "bonus";
                  tooltipText = this.uiApi.getText("ui.mount.fecondable");
               }
               if(tooltipText)
               {
                  tooltipInfo = this.uiApi.textTooltipInfo(tooltipText,this.uiApi.me().getConstant("css") + "normal2.css",classCss);
                  tooltipInfo.bgCornerRadius = 10;
                  this.uiApi.showTooltip(tooltipInfo,target,false,"standard",6,0,3,null,null,null,"TextInfo");
               }
               return;
            }
            if(target.name.indexOf("btn_certificateMountItem") != -1)
            {
               data = this._hookedComponents[target.name];
               if(!data)
               {
                  return;
               }
               itemTooltipSettings = this.sysApi.getData("itemTooltipSettings",DataStoreEnum.BIND_ACCOUNT) as ItemTooltipSettings;
               if(!itemTooltipSettings)
               {
                  itemTooltipSettings = this.tooltipApi.createItemSettings();
                  this.sysApi.setData("itemTooltipSettings",itemTooltipSettings,DataStoreEnum.BIND_ACCOUNT);
               }
               settings = {};
               for(setting in itemTooltipSettings)
               {
                  if(!settings.hasOwnProperty(setting))
                  {
                     settings[setting] = itemTooltipSettings[setting];
                  }
               }
               this.uiApi.showTooltip(data,target,false,"standard",6,0,0,"itemName",null,settings,"ItemInfo");
               return;
            }
         }
         if(tooltipText)
         {
            this.uiApi.showTooltip(this.uiApi.textTooltipInfo(tooltipText),target,false,"standard",LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,3,null,null,null,"TextInfo");
         }
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         this.uiApi.hideTooltip();
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var contextMenu:Array = null;
         var barnMountsId:Array = null;
         var paddockMountsId:Array = null;
         var certificat:* = undefined;
         var inventoryMountsId:Array = null;
         var deActivateContextMenuChoices:* = false;
         switch(target)
         {
            case this.btn_mountEquiped:
               this.showCurrentMountInfo();
               break;
            case this.btn_stock:
               this.moveMount(_currentSource,SOURCE_BARN);
               break;
            case this.btn_park:
               this.moveMount(_currentSource,SOURCE_PADDOCK);
               break;
            case this.btn_equip:
               this.moveMount(_currentSource,SOURCE_EQUIP);
               break;
            case this.btn_exchange:
               this.moveMount(_currentSource,SOURCE_INVENTORY);
               break;
            case this.btn_close:
               this.hideUi();
               break;
            case this.btn_searchBarn:
               if(this.ctr_searchBarn.visible)
               {
                  this.ctr_searchBarn.visible = false;
                  this.cb_barn.visible = true;
                  this.lbl_searchBarn.text = "";
               }
               else
               {
                  this.ctr_searchBarn.visible = true;
                  this.cb_barn.visible = false;
                  this.lbl_searchBarn.text = "";
                  this.lbl_searchBarn.focus();
               }
               this.updateBarn(this.cb_barn.value.type,this.cb_barn2.value.type,this.cb_barn3.value.type);
               break;
            case this.btn_searchPaddock:
               if(this.ctr_searchPaddock.visible)
               {
                  this.ctr_searchPaddock.visible = false;
                  this.cb_paddock.visible = true;
                  this.lbl_searchPaddock.text = "";
               }
               else
               {
                  this.ctr_searchPaddock.visible = true;
                  this.cb_paddock.visible = false;
                  this.lbl_searchPaddock.text = "";
                  this.lbl_searchPaddock.focus();
               }
               this.updatePaddock(this.cb_paddock.value.type);
               break;
            case this.btn_searchInventory:
               if(this.ctr_searchInventory.visible)
               {
                  this.ctr_searchInventory.visible = false;
                  this.cb_inventory.visible = true;
                  this.lbl_searchInventory.text = "";
               }
               else
               {
                  this.ctr_searchInventory.visible = true;
                  this.cb_inventory.visible = false;
                  this.lbl_searchInventory.text = "";
                  this.lbl_searchInventory.focus();
               }
               this.updateInventory(this.cb_inventory.value.type);
               break;
            case this.btn_barnType:
               switchSort(this._barnSortOrder,SORT_TYPE_TYPE);
               this.updateBarn(this.cb_barn.value.type,this.cb_barn2.value.type,this.cb_barn3.value.type);
               break;
            case this.btn_barnGender:
               switchSort(this._barnSortOrder,SORT_TYPE_GENDER);
               this.updateBarn(this.cb_barn.value.type,this.cb_barn2.value.type,this.cb_barn3.value.type);
               break;
            case this.btn_barnName:
               switchSort(this._barnSortOrder,SORT_TYPE_NAME);
               this.updateBarn(this.cb_barn.value.type,this.cb_barn2.value.type,this.cb_barn3.value.type);
               break;
            case this.btn_barnLevel:
               switchSort(this._barnSortOrder,SORT_TYPE_LEVEL);
               this.updateBarn(this.cb_barn.value.type,this.cb_barn2.value.type,this.cb_barn3.value.type);
               break;
            case this.btn_paddockType:
               switchSort(this._paddockSortOrder,SORT_TYPE_TYPE);
               this.updatePaddock(this.cb_paddock.value.type);
               break;
            case this.btn_paddockGender:
               switchSort(this._paddockSortOrder,SORT_TYPE_GENDER);
               this.updatePaddock(this.cb_paddock.value.type);
               break;
            case this.btn_paddockName:
               switchSort(this._paddockSortOrder,SORT_TYPE_NAME);
               this.updatePaddock(this.cb_paddock.value.type);
               break;
            case this.btn_paddockLevel:
               switchSort(this._paddockSortOrder,SORT_TYPE_LEVEL);
               this.updatePaddock(this.cb_paddock.value.type);
               break;
            case this.btn_addFilter:
               this.addAndRemoveFilter(true,target.name);
               break;
            case this.btn_removeFilter1:
            case this.btn_removeFilter2:
            case this.btn_removeFilter3:
               this.addAndRemoveFilter(false,target.name);
               break;
            case this.btn_moveAllFromBarn:
               contextMenu = [];
               barnMountsId = this.getAllMountIdsInGrid(this.gd_barn.dataProvider);
               deActivateContextMenuChoices = barnMountsId.length <= 0;
               contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.mount.transfertAllToPaddock"),this.sysApi.sendAction,[new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTPADDOCK_PUT,barnMountsId])],deActivateContextMenuChoices,null,false,true));
               contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.mount.transfertAllToInventory"),this.sysApi.sendAction,[new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTSTABLES_CERTIF,barnMountsId])],deActivateContextMenuChoices,null,false,true));
               this.modContextMenu.createContextMenu(contextMenu);
               break;
            case this.btn_moveAllFromPark:
               contextMenu = [];
               paddockMountsId = this.getAllMountIdsInGrid(this.gd_paddock.dataProvider);
               deActivateContextMenuChoices = paddockMountsId.length <= 0;
               contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.mount.transfertAllToBarn"),this.sysApi.sendAction,[new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTPADDOCK_GET,paddockMountsId])],deActivateContextMenuChoices,null,false,true));
               contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.mount.transfertAllToInventory"),this.sysApi.sendAction,[new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTPADDOCK_CERTIF,paddockMountsId])],deActivateContextMenuChoices,null,false,true));
               this.modContextMenu.createContextMenu(contextMenu);
               break;
            case this.btn_moveAllFromInventory:
               contextMenu = [];
               inventoryMountsId = [];
               for each(certificat in this.gd_inventory.dataProvider)
               {
                  if(this.mountApi.isCertificateValid(certificat))
                  {
                     inventoryMountsId.push(certificat.objectUID);
                  }
               }
               deActivateContextMenuChoices = inventoryMountsId.length <= 0;
               contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.mount.transfertAllToBarn"),this.sysApi.sendAction,[new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_MOUNTSTABLES_UNCERTIF,inventoryMountsId])],deActivateContextMenuChoices,null,false,true));
               contextMenu.push(this.modContextMenu.createContextMenuItemObject(this.uiApi.getText("ui.mount.transfertAllToPaddock"),this.sysApi.sendAction,[new ExchangeHandleMountStableAction([ExchangeHandleMountStableTypeEnum.EXCHANGE_UNCERTIF_TO_PADDOCK,inventoryMountsId])],deActivateContextMenuChoices,null,false,true));
               this.modContextMenu.createContextMenu(contextMenu);
               break;
            case this.btn_barnCloseSearch:
               this.lbl_searchBarn.text = "";
               this.updateBarn(this.cb_barn.value.type,this.cb_barn2.value.type,this.cb_barn3.value.type);
               break;
            case this.btn_paddockCloseSearch:
               this.lbl_searchPaddock.text = "";
               this.updatePaddock(this.cb_paddock.value.type);
               break;
            case this.btn_inventoryCloseSearch:
               this.lbl_searchInventory.text = "";
               this.updateInventory(this.cb_inventory.value.type);
         }
      }
      
      public function onRightClick(target:GraphicContainer) : void
      {
         var data:Object = null;
         var contextMenu:ContextMenuData = null;
         if(target.name.indexOf("btn_certificateMountItem") != -1)
         {
            data = this._hookedComponents[target.name];
            contextMenu = this.menuApi.create(data);
            if(contextMenu.content.length > 0)
            {
               this.modContextMenu.createContextMenu(contextMenu);
            }
         }
      }
      
      public function onKeyUp(target:DisplayObject, keyCode:uint) : void
      {
         if(this.lbl_searchBarn.haveFocus)
         {
            this.updateBarn(this.cb_barn.value.type,this.cb_barn2.value.type,this.cb_barn3.value.type);
         }
         else if(this.lbl_searchPaddock.haveFocus)
         {
            this.updatePaddock(this.cb_paddock.value.type);
         }
         else if(this.lbl_searchInventory.haveFocus)
         {
            this.updateInventory(this.cb_inventory.value.type);
         }
      }
      
      public function updateFilterLine(data:*, componentsRef:*, selected:Boolean) : void
      {
         if(data)
         {
            componentsRef.lbl_filterName.text = data.label;
            switch(data.filterGroup)
            {
               case MountFilterGroupEnum.MODEL:
                  componentsRef.lbl_filterName.cssClass = "exotic";
                  break;
               case MountFilterGroupEnum.CAPACITY:
                  componentsRef.lbl_filterName.cssClass = "bonus";
                  break;
               case MountFilterGroupEnum.FAMILY:
                  componentsRef.lbl_filterName.cssClass = "orange";
                  break;
               default:
                  componentsRef.lbl_filterName.cssClass = "p";
            }
         }
      }
      
      private function onShortCut(s:String) : Boolean
      {
         if(!this.mainCtr.visible)
         {
            return false;
         }
         switch(s)
         {
            case ShortcutHookListEnum.CLOSE_UI:
               this.hideUi();
               return true;
            case SHORTCUT_STOCK:
               this.moveMount(_currentSource,SOURCE_BARN);
               return true;
            case SHORTCUT_PARK:
               if(this.playerApi.hasDebt())
               {
                  return true;
               }
               this.moveMount(_currentSource,SOURCE_PADDOCK);
               return true;
               break;
            case SHORTCUT_EQUIP:
               this.moveMount(_currentSource,SOURCE_EQUIP);
               return true;
            case SHORTCUT_EXCHANGE:
               this.moveMount(_currentSource,SOURCE_INVENTORY);
               return true;
            default:
               return false;
         }
      }
      
      private function onMountRenamed(mountId:int, mountName:String) : void
      {
         if(this.playerApi.getMount() && this.playerApi.getMount().id == mountId)
         {
            this.showPlayerMountInfo();
         }
      }
      
      private function onMountReleased(mountId:Number) : void
      {
         if(this._mount && this._mount.id == mountId)
         {
            this.sourceSelected(-1);
         }
      }
      
      private function applySort(list:Array, sortOptions:Array) : void
      {
         this._lastSortOptions = sortOptions;
         list.sort(this.sortFunction);
      }
      
      public function sortFunction(a:Object, b:Object) : int
      {
         var se:Object = null;
         for each(se in this._lastSortOptions)
         {
            switch(se.type)
            {
               case SORT_TYPE_TYPE:
                  if(a.description < b.description)
                  {
                     return !!se.asc ? -1 : 1;
                  }
                  if(a.description > b.description)
                  {
                     return !!se.asc ? 1 : -1;
                  }
                  break;
               case SORT_TYPE_GENDER:
                  if(a.sex < b.sex)
                  {
                     return !!se.asc ? -1 : 1;
                  }
                  if(a.sex > b.sex)
                  {
                     return !!se.asc ? 1 : -1;
                  }
                  break;
               case SORT_TYPE_NAME:
                  if(a.name < b.name)
                  {
                     return !!se.asc ? -1 : 1;
                  }
                  if(a.name > b.name)
                  {
                     return !!se.asc ? 1 : -1;
                  }
                  break;
               case SORT_TYPE_LEVEL:
                  if(a.level < b.level)
                  {
                     return !!se.asc ? -1 : 1;
                  }
                  if(a.level > b.level)
                  {
                     return !!se.asc ? 1 : -1;
                  }
                  break;
            }
         }
         return 0;
      }
      
      public function onInfoTimerComplete(e:TimerEvent) : void
      {
         this._infoRequestTimer.stop();
         this.sysApi.sendAction(new MountInfoRequestAction([this._infoRequestSelectedItem]));
      }
   }
}
