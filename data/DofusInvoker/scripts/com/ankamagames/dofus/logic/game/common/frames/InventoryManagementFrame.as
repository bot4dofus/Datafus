package com.ankamagames.dofus.logic.game.common.frames
{
   import com.ankama.dofus.enums.ActionIds;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.params.TooltipProperties;
   import com.ankamagames.berilia.factories.TooltipsFactory;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.datacenter.effects.EffectInstance;
   import com.ankamagames.dofus.datacenter.idols.Idol;
   import com.ankamagames.dofus.datacenter.items.Item;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.dofus.internalDatacenter.items.BuildWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.IdolsPresetWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.ShortcutWrapper;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.kernel.net.ConnectionsHandler;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.logic.common.managers.FeatureManager;
   import com.ankamagames.dofus.logic.common.managers.PlayerManager;
   import com.ankamagames.dofus.logic.common.managers.PopupManager;
   import com.ankamagames.dofus.logic.game.common.actions.AccessoryPreviewRequestAction;
   import com.ankamagames.dofus.logic.game.common.managers.InventoryManager;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.logic.game.common.misc.DofusEntities;
   import com.ankamagames.dofus.logic.game.common.misc.IInventoryView;
   import com.ankamagames.dofus.logic.game.fight.frames.FightBattleFrame;
   import com.ankamagames.dofus.logic.game.fight.frames.FightContextFrame;
   import com.ankamagames.dofus.logic.game.roleplay.actions.DeleteObjectAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectDropAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectSetPositionAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectUseAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ObjectUseOnCellAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.PresetSetPositionAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShortcutBarAddRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShortcutBarRemoveRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.ShortcutBarSwapRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.CharacterPresetSaveRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.IdolsPresetSaveRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.PresetDeleteRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.actions.preset.PresetUseRequestAction;
   import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayMovementFrame;
   import com.ankamagames.dofus.misc.enum.CharacterBuildType;
   import com.ankamagames.dofus.misc.lists.ChatHookList;
   import com.ankamagames.dofus.misc.lists.CraftHookList;
   import com.ankamagames.dofus.misc.lists.ExternalGameHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.misc.lists.InventoryHookList;
   import com.ankamagames.dofus.network.enums.AccessoryPreviewErrorEnum;
   import com.ankamagames.dofus.network.enums.CharacterInventoryPositionEnum;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.network.enums.GameContextEnum;
   import com.ankamagames.dofus.network.enums.GameServerTypeEnum;
   import com.ankamagames.dofus.network.enums.ObjectErrorEnum;
   import com.ankamagames.dofus.network.enums.PresetDeleteResultEnum;
   import com.ankamagames.dofus.network.enums.PresetSaveResultEnum;
   import com.ankamagames.dofus.network.enums.PresetUseResultEnum;
   import com.ankamagames.dofus.network.enums.ShortcutBarEnum;
   import com.ankamagames.dofus.network.enums.SubEntityBindingPointCategoryEnum;
   import com.ankamagames.dofus.network.messages.game.inventory.KamasUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.exchanges.DecraftResultMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.InventoryContentMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.InventoryWeightMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectAddedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectDeleteMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectDeletedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectDropMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectErrorMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectModifiedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectMovementMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectQuantityMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectSetPositionMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectUseMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectUseMultipleMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectUseOnCellMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectUseOnCharacterMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectsAddedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectsDeletedMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.ObjectsQuantityMessage;
   import com.ankamagames.dofus.network.messages.game.inventory.items.WatchInventoryContentMessage;
   import com.ankamagames.dofus.network.messages.game.look.AccessoryPreviewErrorMessage;
   import com.ankamagames.dofus.network.messages.game.look.AccessoryPreviewMessage;
   import com.ankamagames.dofus.network.messages.game.look.AccessoryPreviewRequestMessage;
   import com.ankamagames.dofus.network.messages.game.presets.IconNamedPresetSaveRequestMessage;
   import com.ankamagames.dofus.network.messages.game.presets.IdolsPresetSaveRequestMessage;
   import com.ankamagames.dofus.network.messages.game.presets.InvalidPresetsMessage;
   import com.ankamagames.dofus.network.messages.game.presets.ItemForPresetUpdateMessage;
   import com.ankamagames.dofus.network.messages.game.presets.PresetDeleteRequestMessage;
   import com.ankamagames.dofus.network.messages.game.presets.PresetDeleteResultMessage;
   import com.ankamagames.dofus.network.messages.game.presets.PresetSaveErrorMessage;
   import com.ankamagames.dofus.network.messages.game.presets.PresetSavedMessage;
   import com.ankamagames.dofus.network.messages.game.presets.PresetUseRequestMessage;
   import com.ankamagames.dofus.network.messages.game.presets.PresetUseResultMessage;
   import com.ankamagames.dofus.network.messages.game.presets.PresetUseResultWithMissingIdsMessage;
   import com.ankamagames.dofus.network.messages.game.presets.PresetsMessage;
   import com.ankamagames.dofus.network.messages.game.shortcut.ShortcutBarAddRequestMessage;
   import com.ankamagames.dofus.network.messages.game.shortcut.ShortcutBarContentMessage;
   import com.ankamagames.dofus.network.messages.game.shortcut.ShortcutBarRefreshMessage;
   import com.ankamagames.dofus.network.messages.game.shortcut.ShortcutBarRemoveRequestMessage;
   import com.ankamagames.dofus.network.messages.game.shortcut.ShortcutBarRemovedMessage;
   import com.ankamagames.dofus.network.messages.game.shortcut.ShortcutBarReplacedMessage;
   import com.ankamagames.dofus.network.messages.game.shortcut.ShortcutBarSwapRequestMessage;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItem;
   import com.ankamagames.dofus.network.types.game.data.items.ObjectItemQuantity;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.dofus.network.types.game.look.SubEntity;
   import com.ankamagames.dofus.network.types.game.presets.ForgettableSpellsPreset;
   import com.ankamagames.dofus.network.types.game.presets.FullStatsPreset;
   import com.ankamagames.dofus.network.types.game.presets.IconNamedPreset;
   import com.ankamagames.dofus.network.types.game.presets.IdolsPreset;
   import com.ankamagames.dofus.network.types.game.presets.ItemsPreset;
   import com.ankamagames.dofus.network.types.game.presets.Preset;
   import com.ankamagames.dofus.network.types.game.presets.PresetsContainerPreset;
   import com.ankamagames.dofus.network.types.game.presets.SpellsPreset;
   import com.ankamagames.dofus.network.types.game.shortcut.Shortcut;
   import com.ankamagames.dofus.network.types.game.shortcut.ShortcutEmote;
   import com.ankamagames.dofus.network.types.game.shortcut.ShortcutObjectIdolsPreset;
   import com.ankamagames.dofus.network.types.game.shortcut.ShortcutObjectItem;
   import com.ankamagames.dofus.network.types.game.shortcut.ShortcutObjectPreset;
   import com.ankamagames.dofus.network.types.game.shortcut.ShortcutSmiley;
   import com.ankamagames.dofus.network.types.game.shortcut.ShortcutSpell;
   import com.ankamagames.dofus.types.characteristicContextual.CharacteristicContextualManager;
   import com.ankamagames.dofus.types.enums.ItemCategoryEnum;
   import com.ankamagames.dofus.types.enums.LanguageEnum;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.entities.interfaces.IEntity;
   import com.ankamagames.jerakine.entities.interfaces.IMovable;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.messages.Frame;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.DataStoreType;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import com.ankamagames.jerakine.types.enums.Priority;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   import flash.events.TimerEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class InventoryManagementFrame implements Frame
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(InventoryManagementFrame));
      
      private static const CHARACTER_BUILD_PRESET_TYPE:int = 1;
      
      private static const IDOLS_PRESET_TYPE:int = 2;
      
      private static const FORGETTABLE_PRESET_TYPE:int = 3;
      
      private static const POPUP_WARNING_TIPS_ID:uint = 15;
      
      private static var _dataStoreType:DataStoreType;
      
      private static const popupSaveKeyClassic:String = "prevention-phishing";
       
      
      private var _objectUIDToDrop:int;
      
      private var _objectGIDToDrop:uint;
      
      private var _quantityToDrop:uint;
      
      private var _dropPopup:String;
      
      private var _currentPointUseUIDObject:uint;
      
      private var _movingObjectUID:int;
      
      private var _movingObjectPreviousPosition:int;
      
      private var _objectPositionModification:Boolean;
      
      private var _soundApi:SoundApi;
      
      private var _presetTypeIdByPresetId:Dictionary;
      
      private var _invalidPresets:Vector.<BuildWrapper>;
      
      private var _waitTimer:BenchmarkTimer;
      
      private var _chatText:String;
      
      public function InventoryManagementFrame()
      {
         this._soundApi = new SoundApi();
         this._presetTypeIdByPresetId = new Dictionary();
         this._invalidPresets = new Vector.<BuildWrapper>();
         super();
      }
      
      public static function displayNewsPopupClassic() : void
      {
         var linkUrl:* = null;
         _dataStoreType = new DataStoreType("Module_Ankama_Storage",true,DataStoreEnum.LOCATION_LOCAL,DataStoreEnum.BIND_CHARACTER);
         if(!StoreDataManager.getInstance().getData(_dataStoreType,popupSaveKeyClassic))
         {
            linkUrl = "https://support.ankama.com/hc/";
            switch(XmlConfig.getInstance().getEntry("config.lang.current"))
            {
               case LanguageEnum.LANG_FR:
                  linkUrl += "fr/articles/201376953-Reconna%C3%AEtre-le-phishing-et-s-en-prot%C3%A9ger-";
                  break;
               case LanguageEnum.LANG_ES:
                  linkUrl += "es/articles/201376953-Reconocer-el-phishing-y-protegerse-";
                  break;
               case LanguageEnum.LANG_PT:
                  linkUrl += "pt-br/articles/201376953-Reconhecendo-e-protegendo-se-contra-o-phishing";
                  break;
               default:
                  linkUrl += "en-us/articles/201376953-Recognizing-and-Protecting-Yourself-from-Phishing-";
            }
            PopupManager.getInstance().showPopup(POPUP_WARNING_TIPS_ID);
         }
      }
      
      public function get priority() : int
      {
         return Priority.NORMAL;
      }
      
      public function get mountFrame() : MountFrame
      {
         return Kernel.getWorker().getFrame(MountFrame) as MountFrame;
      }
      
      public function getWrappersFromShortcuts(shortcuts:Vector.<Shortcut>) : Array
      {
         var shortcutProperties:Object = null;
         var shortcut:Shortcut = null;
         var wrappers:Array = new Array();
         for each(shortcut in shortcuts)
         {
            shortcutProperties = this.getShortcutWrapperPropFromShortcut(shortcut);
            wrappers[shortcut.slot] = ShortcutWrapper.create(shortcut.slot,shortcutProperties.id,shortcutProperties.type,shortcutProperties.gid);
         }
         return wrappers;
      }
      
      public function pushed() : Boolean
      {
         InventoryManager.getInstance().init();
         return true;
      }
      
      public function process(msg:Message) : Boolean
      {
         var preset:Preset = null;
         var idolsPresets:Vector.<IdolsPresetWrapper> = null;
         var build:BuildWrapper = null;
         var builds:Array = null;
         var idolsPreset:IdolsPreset = null;
         var idolsPresetWrapper:IdolsPresetWrapper = null;
         var forgettableSpellsActivated:Boolean = false;
         var wicmsg:WatchInventoryContentMessage = null;
         var mod:UiModule = null;
         var icmsg:InventoryContentMessage = null;
         var equipmentView:IInventoryView = null;
         var playerCharacterManager:PlayedCharacterManager = null;
         var oam:ObjectAddedMessage = null;
         var osam:ObjectsAddedMessage = null;
         var oqm:ObjectQuantityMessage = null;
         var osqm:ObjectsQuantityMessage = null;
         var kumsg:KamasUpdateMessage = null;
         var iwmsg:InventoryWeightMessage = null;
         var ommsg:ObjectMovementMessage = null;
         var sbcmsg:ShortcutBarContentMessage = null;
         var sbrmsg:ShortcutBarRefreshMessage = null;
         var inventoryMgr:InventoryManager = null;
         var sRProperties:Object = null;
         var sbrmmsg:ShortcutBarRemovedMessage = null;
         var sbrpmsg:ShortcutBarReplacedMessage = null;
         var replacingShortcutProperties:Object = null;
         var sbara:ShortcutBarAddRequestAction = null;
         var sbarmsg:ShortcutBarAddRequestMessage = null;
         var sbrra:ShortcutBarRemoveRequestAction = null;
         var sbrrmsg:ShortcutBarRemoveRequestMessage = null;
         var sbsra:ShortcutBarSwapRequestAction = null;
         var sbsrmsg:ShortcutBarSwapRequestMessage = null;
         var pspa:PresetSetPositionAction = null;
         var hiddenObjects:Vector.<ItemWrapper> = null;
         var presetItem:ItemWrapper = null;
         var ospa:ObjectSetPositionAction = null;
         var itw:ItemWrapper = null;
         var omdmsg:ObjectModifiedMessage = null;
         var effectInst:EffectInstance = null;
         var petsMountWasAutopilotable:Boolean = false;
         var previousItemWrapper:ItemWrapper = null;
         var modifiedItemWrapper:ItemWrapper = null;
         var updateTooltip:Function = null;
         var odmsg:ObjectDeletedMessage = null;
         var osdmsg:ObjectsDeletedMessage = null;
         var doa:DeleteObjectAction = null;
         var odmsg2:ObjectDeleteMessage = null;
         var oua:ObjectUseAction = null;
         var iw:ItemWrapper = null;
         var fncUseItem:Function = null;
         var nbFood:int = 0;
         var nbBonus:int = 0;
         var view:IInventoryView = null;
         var oda:ObjectDropAction = null;
         var itemItem:Item = null;
         var objectName:String = null;
         var ouocmsg:ObjectUseOnCellMessage = null;
         var ouoca:ObjectUseOnCellAction = null;
         var oemsg:ObjectErrorMessage = null;
         var pmsg:PresetsMessage = null;
         var presetWrappers:Array = null;
         var presetsCount:int = 0;
         var iPreset:int = 0;
         var ipmsg:InvalidPresetsMessage = null;
         var buildLink:Array = null;
         var ipiumsg:ItemForPresetUpdateMessage = null;
         var pdra:PresetDeleteRequestAction = null;
         var pdmsg:PresetDeleteRequestMessage = null;
         var pdrmsg:PresetDeleteResultMessage = null;
         var cpsra:CharacterPresetSaveRequestAction = null;
         var npsrmsg:IconNamedPresetSaveRequestMessage = null;
         var ipsra:IdolsPresetSaveRequestAction = null;
         var ipsrmsg:IdolsPresetSaveRequestMessage = null;
         var psemsg:PresetSaveErrorMessage = null;
         var presetSaveErrorReasonText:String = null;
         var psmsg:PresetSavedMessage = null;
         var pura:PresetUseRequestAction = null;
         var pumsg:PresetUseRequestMessage = null;
         var purmsg:PresetUseResultMessage = null;
         var presetTypeId:int = 0;
         var presetUseErrorText:String = null;
         var apra:AccessoryPreviewRequestAction = null;
         var aprmsg:AccessoryPreviewRequestMessage = null;
         var apemsg:AccessoryPreviewErrorMessage = null;
         var apErrorMsg:String = null;
         var apmsg:AccessoryPreviewMessage = null;
         var previewLook:EntityLook = null;
         var drmsg:DecraftResultMessage = null;
         var message:String = null;
         var itwa:ItemWrapper = null;
         var osait:ObjectItem = null;
         var item:ItemWrapper = null;
         var quantity:int = 0;
         var content:String = null;
         var shortcutQty:ShortcutWrapper = null;
         var objoqm:ObjectItemQuantity = null;
         var shortcutsQty:ShortcutWrapper = null;
         var itwm:ItemWrapper = null;
         var shortcuti:ShortcutObjectItem = null;
         var shortcutp:ShortcutObjectPreset = null;
         var shortcuts:ShortcutSpell = null;
         var shortcutsm:ShortcutSmiley = null;
         var shortcute:ShortcutEmote = null;
         var shortcutd:ShortcutObjectIdolsPreset = null;
         var realitem:ItemWrapper = null;
         var effect:EffectInstance = null;
         var ospmsg:ObjectSetPositionMessage = null;
         var ospmsg2:ObjectSetPositionMessage = null;
         var shortcutItem:ShortcutWrapper = null;
         var uiName:String = null;
         var ttProperties:TooltipProperties = null;
         var autopilotMessage:String = null;
         var osdit:uint = 0;
         var t:ItemWrapper = null;
         var odropmsg:ObjectDropMessage = null;
         var buildPreset:IconNamedPreset = null;
         var fullStatsPreset:FullStatsPreset = null;
         var itemsPreset:ItemsPreset = null;
         var spellsPreset:SpellsPreset = null;
         var forgettableSpellsPreset:ForgettableSpellsPreset = null;
         var subPreset:Preset = null;
         var characterBuildType:uint = 0;
         var subSubPreset:Preset = null;
         var id:uint = 0;
         var buildWrapper:BuildWrapper = null;
         var presetIndex:int = 0;
         var deletePresetTypeId:int = 0;
         var reason1:String = null;
         var idolWrapper:IdolsPresetWrapper = null;
         var newBuild:IconNamedPreset = null;
         var fullStatsPresetSaved:FullStatsPreset = null;
         var itemsPresetSaved:ItemsPreset = null;
         var spellsPresetSaved:SpellsPreset = null;
         var forgettableSpellsPresetSaved:ForgettableSpellsPreset = null;
         var subPresetSaved:Preset = null;
         var characterBuildTypeSaved:uint = 0;
         var subSubPresetSaved:Preset = null;
         var chatUseText:String = null;
         var missingIds:Vector.<uint> = null;
         var missingId:uint = 0;
         var missingName:String = null;
         var missingText:String = null;
         var currentSpellWrapper:SpellWrapper = null;
         var spellsString:String = null;
         var chatFrame:ChatFrame = null;
         var followerPet:SubEntity = null;
         var sube:SubEntity = null;
         var commonMod:Object = UiModuleManager.getInstance().getModule("Ankama_Common").mainClass;
         switch(true)
         {
            case msg is WatchInventoryContentMessage:
               InventoryManager.getWatchInstance().init();
               wicmsg = msg as WatchInventoryContentMessage;
               InventoryManager.getWatchInstance().inventory.initializeFromObjectItems(wicmsg.objects);
               InventoryManager.getWatchInstance().inventory.kamas = wicmsg.kamas;
               mod = UiModuleManager.getInstance().getModule("Ankama_Storage");
               Berilia.getInstance().loadUi(mod,mod.getUi("watchEquipment"),"watchEquipment",{"storageMod":"watch"},true);
               return true;
            case msg is InventoryContentMessage:
               if(getQualifiedClassName(msg) != getQualifiedClassName(InventoryContentMessage))
               {
                  return false;
               }
               icmsg = msg as InventoryContentMessage;
               InventoryManager.getInstance().inventory.initializeFromObjectItems(icmsg.objects);
               InventoryManager.getInstance().inventory.kamas = icmsg.kamas;
               equipmentView = InventoryManager.getInstance().inventory.getView("equipment");
               if(equipmentView && equipmentView.content)
               {
                  if(equipmentView.content[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS] && equipmentView.content[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS].typeId == DataEnum.ITEM_TYPE_PETSMOUNT)
                  {
                     PlayedCharacterManager.getInstance().isPetsMounting = true;
                     PlayedCharacterManager.getInstance().petsMount = equipmentView.content[CharacterInventoryPositionEnum.ACCESSORY_POSITION_PETS];
                  }
                  if(equipmentView.content[CharacterInventoryPositionEnum.INVENTORY_POSITION_ENTITY])
                  {
                     PlayedCharacterManager.getInstance().hasCompanion = true;
                  }
               }
               playerCharacterManager = PlayedCharacterManager.getInstance();
               playerCharacterManager.inventory = InventoryManager.getInstance().realInventory;
               if(playerCharacterManager.characteristics)
               {
                  playerCharacterManager.characteristics.kamas = icmsg.kamas;
               }
               if(PlayerManager.getInstance().server.gameTypeId != GameServerTypeEnum.SERVER_TYPE_TEMPORIS && playerCharacterManager.infos.level >= 10)
               {
                  displayNewsPopupClassic();
               }
               return true;
               break;
            case msg is ObjectAddedMessage:
               oam = msg as ObjectAddedMessage;
               InventoryManager.getInstance().inventory.addObjectItem(oam.object);
               if(oam.origin == 1)
               {
                  this.displayAddedItem(oam.object.objectGID,oam.object.quantity);
                  message = PatternDecoder.combine(I18n.getUiText("ui.quest.itemObtained",[oam.object.quantity,"{item," + oam.object.objectGID + "," + oam.object.objectUID + "}"]),"n",oam.object.quantity <= 1,oam.object.quantity == 0);
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,message,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               if((oam.object.position <= CharacterInventoryPositionEnum.INVENTORY_POSITION_MOUNT || oam.object.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_ENTITY || oam.object.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_COSTUME) && oam.object.position >= 0 && !Berilia.getInstance().getUi("storage"))
               {
                  itwa = InventoryManager.getInstance().inventory.getItem(oam.object.objectUID);
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.item.inUse",[itwa.name]),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is ObjectsAddedMessage:
               osam = msg as ObjectsAddedMessage;
               for each(osait in osam.object)
               {
                  InventoryManager.getInstance().inventory.addObjectItem(osait);
               }
               return true;
            case msg is ObjectQuantityMessage:
               oqm = msg as ObjectQuantityMessage;
               if(this._objectUIDToDrop == oqm.objectUID)
               {
                  this._soundApi.playSound(SoundTypeEnum.DROP_ITEM);
                  this._objectUIDToDrop = -1;
               }
               if(oqm.origin == 1)
               {
                  item = InventoryManager.getInstance().inventory.getItem(oqm.objectUID);
                  quantity = oqm.quantity - item.quantity;
                  if(quantity > 0)
                  {
                     this.displayAddedItem(item.objectGID,quantity);
                     content = PatternDecoder.combine(I18n.getUiText("ui.quest.itemObtained",[quantity,"{item," + item.objectGID + "," + oqm.objectUID + "}"]),"n",quantity <= 1,quantity == 0);
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,content,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  }
               }
               InventoryManager.getInstance().inventory.modifyItemQuantity(oqm.objectUID,oqm.quantity);
               for each(shortcutQty in InventoryManager.getInstance().shortcutBarItems)
               {
                  if(shortcutQty && shortcutQty.id == oqm.objectUID)
                  {
                     shortcutQty.quantity = oqm.quantity;
                     KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,0);
                  }
               }
               return true;
            case msg is ObjectsQuantityMessage:
               osqm = msg as ObjectsQuantityMessage;
               for each(objoqm in osqm.objectsUIDAndQty)
               {
                  InventoryManager.getInstance().inventory.modifyItemQuantity(objoqm.objectUID,objoqm.quantity);
                  for each(shortcutsQty in InventoryManager.getInstance().shortcutBarItems)
                  {
                     if(shortcutsQty && shortcutsQty.id == objoqm.objectUID)
                     {
                        shortcutsQty.quantity = objoqm.quantity;
                     }
                  }
               }
               KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,0);
               return true;
            case msg is KamasUpdateMessage:
               kumsg = msg as KamasUpdateMessage;
               InventoryManager.getInstance().inventory.kamas = kumsg.kamasTotal;
               KernelEventsManager.getInstance().processCallback(InventoryHookList.KamasUpdate,kumsg.kamasTotal);
               KernelEventsManager.getInstance().processCallback(ExternalGameHookList.DofusBakKamasAmount,kumsg.kamasTotal + InventoryManager.getInstance().bankInventory.kamas);
               InventoryManager.getInstance().inventory.releaseHooks();
               return true;
            case msg is InventoryWeightMessage:
               iwmsg = msg as InventoryWeightMessage;
               PlayedCharacterManager.getInstance().inventoryWeight = iwmsg.inventoryWeight;
               PlayedCharacterManager.getInstance().shopWeight = iwmsg.shopWeight;
               PlayedCharacterManager.getInstance().inventoryWeightMax = iwmsg.weightMax;
               KernelEventsManager.getInstance().processCallback(InventoryHookList.InventoryWeight,iwmsg.inventoryWeight,iwmsg.shopWeight,iwmsg.weightMax);
               InventoryManager.getInstance().inventory.releaseHooks();
               return true;
            case msg is ObjectMovementMessage:
               ommsg = msg as ObjectMovementMessage;
               InventoryManager.getInstance().inventory.modifyItemPosition(ommsg.objectUID,ommsg.position);
               if(this._objectPositionModification && (ommsg.position <= CharacterInventoryPositionEnum.INVENTORY_POSITION_MOUNT || ommsg.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_ENTITY || ommsg.position == CharacterInventoryPositionEnum.INVENTORY_POSITION_COSTUME) && ommsg.position >= 0 && !Berilia.getInstance().getUi("storage"))
               {
                  itwm = InventoryManager.getInstance().inventory.getItem(ommsg.objectUID);
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,I18n.getUiText("ui.item.inUse",[itwm.name]),ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  this._objectPositionModification = false;
               }
               return true;
            case msg is ShortcutBarContentMessage:
               sbcmsg = msg as ShortcutBarContentMessage;
               if(sbcmsg.barType == ShortcutBarEnum.GENERAL_SHORTCUT_BAR)
               {
                  InventoryManager.getInstance().shortcutBarItems = this.getWrappersFromShortcuts(sbcmsg.shortcuts);
               }
               else if(sbcmsg.barType == ShortcutBarEnum.SPELL_SHORTCUT_BAR)
               {
                  InventoryManager.getInstance().shortcutBarSpells = this.getWrappersFromShortcuts(sbcmsg.shortcuts);
                  PlayedCharacterManager.getInstance().playerShortcutList = InventoryManager.getInstance().shortcutBarSpells;
               }
               KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,sbcmsg.barType);
               return true;
            case msg is ShortcutBarRefreshMessage:
               sbrmsg = msg as ShortcutBarRefreshMessage;
               inventoryMgr = InventoryManager.getInstance();
               sRProperties = this.getShortcutWrapperPropFromShortcut(sbrmsg.shortcut);
               if(sbrmsg.barType == ShortcutBarEnum.GENERAL_SHORTCUT_BAR)
               {
                  if(inventoryMgr.shortcutBarItems[sbrmsg.shortcut.slot])
                  {
                     inventoryMgr.shortcutBarItems[sbrmsg.shortcut.slot].update(sbrmsg.shortcut.slot,sRProperties.id,sRProperties.type,sRProperties.gid);
                  }
                  else
                  {
                     inventoryMgr.shortcutBarItems[sbrmsg.shortcut.slot] = ShortcutWrapper.create(sbrmsg.shortcut.slot,sRProperties.id,sRProperties.type,sRProperties.gid);
                  }
               }
               else if(sbrmsg.barType == ShortcutBarEnum.SPELL_SHORTCUT_BAR)
               {
                  if(inventoryMgr.shortcutBarSpells[sbrmsg.shortcut.slot])
                  {
                     inventoryMgr.shortcutBarSpells[sbrmsg.shortcut.slot].update(sbrmsg.shortcut.slot,sRProperties.id,sRProperties.type,sRProperties.gid);
                  }
                  else
                  {
                     inventoryMgr.shortcutBarSpells[sbrmsg.shortcut.slot] = ShortcutWrapper.create(sbrmsg.shortcut.slot,sRProperties.id,sRProperties.type,sRProperties.gid);
                  }
                  if(PlayedCharacterManager.getInstance().spellsInventory == PlayedCharacterManager.getInstance().playerSpellList)
                  {
                     PlayedCharacterManager.getInstance().playerShortcutList = InventoryManager.getInstance().shortcutBarSpells;
                  }
               }
               KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,sbrmsg.barType);
               return true;
            case msg is ShortcutBarRemovedMessage:
               sbrmmsg = msg as ShortcutBarRemovedMessage;
               if(sbrmmsg.barType == ShortcutBarEnum.GENERAL_SHORTCUT_BAR)
               {
                  InventoryManager.getInstance().shortcutBarItems[sbrmmsg.slot] = null;
               }
               else if(sbrmmsg.barType == ShortcutBarEnum.SPELL_SHORTCUT_BAR)
               {
                  InventoryManager.getInstance().shortcutBarSpells[sbrmmsg.slot] = null;
               }
               KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,sbrmmsg.barType);
               return true;
            case msg is ShortcutBarReplacedMessage:
               sbrpmsg = msg as ShortcutBarReplacedMessage;
               replacingShortcutProperties = this.getShortcutWrapperPropFromShortcut(sbrpmsg.shortcut);
               if(sbrpmsg.barType == ShortcutBarEnum.GENERAL_SHORTCUT_BAR)
               {
                  InventoryManager.getInstance().shortcutBarItems[sbrpmsg.shortcut.slot] = ShortcutWrapper.create(sbrpmsg.shortcut.slot,replacingShortcutProperties.id,replacingShortcutProperties.type,replacingShortcutProperties.gid);
               }
               else if(sbrpmsg.barType == ShortcutBarEnum.SPELL_SHORTCUT_BAR)
               {
                  InventoryManager.getInstance().shortcutBarSpells[sbrpmsg.shortcut.slot] = ShortcutWrapper.create(sbrpmsg.shortcut.slot,replacingShortcutProperties.id,replacingShortcutProperties.type,replacingShortcutProperties.gid);
               }
               KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,sbrpmsg.barType);
               return true;
            case msg is ShortcutBarAddRequestAction:
               sbara = msg as ShortcutBarAddRequestAction;
               sbarmsg = new ShortcutBarAddRequestMessage();
               if(sbara.barType == DataEnum.SHORTCUT_TYPE_ITEM)
               {
                  shortcuti = new ShortcutObjectItem();
                  shortcuti.itemUID = sbara.id;
                  shortcuti.slot = sbara.slot;
                  sbarmsg.initShortcutBarAddRequestMessage(sbara.barType,shortcuti);
               }
               else if(sbara.barType == DataEnum.SHORTCUT_TYPE_PRESET)
               {
                  shortcutp = new ShortcutObjectPreset();
                  shortcutp.presetId = sbara.id;
                  shortcutp.slot = sbara.slot;
                  sbarmsg.initShortcutBarAddRequestMessage(0,shortcutp);
               }
               else if(sbara.barType == DataEnum.SHORTCUT_TYPE_SPELL)
               {
                  shortcuts = new ShortcutSpell();
                  shortcuts.spellId = sbara.id;
                  shortcuts.slot = sbara.slot;
                  sbarmsg.initShortcutBarAddRequestMessage(1,shortcuts);
               }
               else if(sbara.barType == DataEnum.SHORTCUT_TYPE_SMILEY)
               {
                  shortcutsm = new ShortcutSmiley();
                  shortcutsm.smileyId = sbara.id;
                  shortcutsm.slot = sbara.slot;
                  sbarmsg.initShortcutBarAddRequestMessage(0,shortcutsm);
               }
               else if(sbara.barType == DataEnum.SHORTCUT_TYPE_EMOTE)
               {
                  shortcute = new ShortcutEmote();
                  shortcute.emoteId = sbara.id;
                  shortcute.slot = sbara.slot;
                  sbarmsg.initShortcutBarAddRequestMessage(0,shortcute);
               }
               else if(sbara.barType == DataEnum.SHORTCUT_TYPE_IDOLS_PRESET)
               {
                  shortcutd = new ShortcutObjectIdolsPreset();
                  shortcutd.presetId = sbara.id;
                  shortcutd.slot = sbara.slot;
                  sbarmsg.initShortcutBarAddRequestMessage(0,shortcutd);
               }
               ConnectionsHandler.getConnection().send(sbarmsg);
               return true;
            case msg is ShortcutBarRemoveRequestAction:
               sbrra = msg as ShortcutBarRemoveRequestAction;
               sbrrmsg = new ShortcutBarRemoveRequestMessage();
               sbrrmsg.initShortcutBarRemoveRequestMessage(sbrra.barType,sbrra.slot);
               ConnectionsHandler.getConnection().send(sbrrmsg);
               return true;
            case msg is ShortcutBarSwapRequestAction:
               sbsra = msg as ShortcutBarSwapRequestAction;
               sbsrmsg = new ShortcutBarSwapRequestMessage();
               sbsrmsg.initShortcutBarSwapRequestMessage(sbsra.barType,sbsra.firstSlot,sbsra.secondSlot);
               ConnectionsHandler.getConnection().send(sbsrmsg);
               return true;
            case msg is PresetSetPositionAction:
               pspa = msg as PresetSetPositionAction;
               hiddenObjects = new Vector.<ItemWrapper>();
               loop4:
               for each(realitem in InventoryManager.getInstance().inventory.getView("real").content)
               {
                  if(Item.getItemById(realitem.objectGID).typeId == DataEnum.ITEM_TYPE_HIDDEN)
                  {
                     hiddenObjects.push(realitem);
                     if(realitem.effects && realitem.effects.length)
                     {
                        for each(effect in realitem.effects)
                        {
                           if(effect.effectId == ActionIds.ACTION_ITEM_EQUIP_PRESET)
                           {
                              if(int(effect.parameter2) - 1 == pspa.presetId)
                              {
                                 presetItem = realitem;
                                 break loop4;
                              }
                           }
                        }
                     }
                  }
               }
               if(presetItem)
               {
                  this._movingObjectUID = presetItem.objectUID;
                  this._movingObjectPreviousPosition = 0;
                  ospmsg = new ObjectSetPositionMessage();
                  ospmsg.initObjectSetPositionMessage(presetItem.objectUID,pspa.position,1);
                  ConnectionsHandler.getConnection().send(ospmsg);
               }
               return true;
            case msg is ObjectSetPositionAction:
               ospa = msg as ObjectSetPositionAction;
               itw = InventoryManager.getInstance().inventory.getItem(ospa.objectUID);
               if(itw && itw.position != ospa.position)
               {
                  this._movingObjectUID = ospa.objectUID;
                  if(!itw)
                  {
                     this._movingObjectPreviousPosition = 8;
                  }
                  else
                  {
                     this._movingObjectPreviousPosition = itw.position;
                  }
                  this._objectPositionModification = true;
                  ospmsg2 = new ObjectSetPositionMessage();
                  ospmsg2.initObjectSetPositionMessage(ospa.objectUID,ospa.position,ospa.quantity);
                  ConnectionsHandler.getConnection().send(ospmsg2);
               }
               return true;
            case msg is ObjectModifiedMessage:
               omdmsg = msg as ObjectModifiedMessage;
               petsMountWasAutopilotable = false;
               inventoryMgr = InventoryManager.getInstance();
               previousItemWrapper = inventoryMgr.inventory.getItem(omdmsg.object.objectUID);
               if(previousItemWrapper && previousItemWrapper.type.id == DataEnum.ITEM_TYPE_PETSMOUNT)
               {
                  for each(effectInst in previousItemWrapper.effects)
                  {
                     if(effectInst.effectId == ActionIds.ACTION_SELF_PILOTING)
                     {
                        petsMountWasAutopilotable = true;
                        break;
                     }
                  }
               }
               modifiedItemWrapper = inventoryMgr.inventory.modifyObjectItem(omdmsg.object);
               for each(shortcutItem in inventoryMgr.shortcutBarItems)
               {
                  if(!(!shortcutItem || shortcutItem.type != 0 || shortcutItem.id != omdmsg.object.objectUID))
                  {
                     shortcutItem.update(shortcutItem.slot,shortcutItem.id,shortcutItem.type,shortcutItem.gid);
                     KernelEventsManager.getInstance().processCallback(InventoryHookList.ShortcutBarViewContent,ShortcutBarEnum.GENERAL_SHORTCUT_BAR);
                  }
               }
               updateTooltip = function(pUiName:String, pProperties:TooltipProperties):void
               {
                  var ttUi:UiRootContainer = Berilia.getInstance().getUi(pUiName);
                  if(ttUi && ttUi.uiClass)
                  {
                     ttUi.uiClass.updateContent(pProperties);
                  }
               };
               for(uiName in Berilia.getInstance().uiList)
               {
                  if(uiName.indexOf("_pin@") != -1)
                  {
                     ttProperties = Berilia.getInstance().getUi(uiName).properties;
                     if(ttProperties.data.objectUID == modifiedItemWrapper.objectUID)
                     {
                        ttProperties.tooltip = TooltipsFactory.getMakerInstance("item").createTooltip(modifiedItemWrapper,ttProperties.makerParam);
                        ttProperties.data = modifiedItemWrapper;
                        ttProperties.tooltip.askTooltip(new Callback(updateTooltip,uiName,ttProperties));
                        break;
                     }
                  }
               }
               if(modifiedItemWrapper.type.id == DataEnum.ITEM_TYPE_PETSMOUNT && !petsMountWasAutopilotable)
               {
                  for each(effectInst in modifiedItemWrapper.effects)
                  {
                     if(effectInst.effectId == ActionIds.ACTION_SELF_PILOTING)
                     {
                        autopilotMessage = I18n.getUiText("ui.mountTrip.autopilotActivatedForPetsMount",[modifiedItemWrapper.name]);
                        commonMod.openPopup(I18n.getUiText("ui.common.congratulation"),autopilotMessage,[I18n.getUiText("ui.common.ok")]);
                     }
                  }
               }
               return false;
            case msg is ObjectDeletedMessage:
               odmsg = msg as ObjectDeletedMessage;
               if(this._objectUIDToDrop == odmsg.objectUID)
               {
                  this._soundApi.playSound(SoundTypeEnum.DROP_ITEM);
                  this._objectUIDToDrop = -1;
               }
               InventoryManager.getInstance().inventory.removeItem(odmsg.objectUID,-1);
               return true;
            case msg is ObjectsDeletedMessage:
               osdmsg = msg as ObjectsDeletedMessage;
               for each(osdit in osdmsg.objectUID)
               {
                  InventoryManager.getInstance().inventory.removeItem(osdit,-1);
               }
               return true;
            case msg is DeleteObjectAction:
               doa = msg as DeleteObjectAction;
               odmsg2 = new ObjectDeleteMessage();
               odmsg2.initObjectDeleteMessage(doa.objectUID,doa.quantity);
               ConnectionsHandler.getConnection().send(odmsg2);
               return true;
            case msg is ObjectUseAction:
               oua = msg as ObjectUseAction;
               iw = InventoryManager.getInstance().inventory.getItem(oua.objectUID);
               if(!iw)
               {
                  _log.error("Impossible de retrouver l\'objet d\'UID " + oua.objectUID);
                  return true;
               }
               if(!iw.usable && !iw.targetable)
               {
                  _log.error("L\'objet " + iw.name + " n\'est pas utilisable.");
                  return true;
               }
               fncUseItem = function():void
               {
                  useItem(oua,iw);
               };
               nbFood = 0;
               nbBonus = 0;
               view = InventoryManager.getInstance().inventory.getView("roleplayBuff");
               for each(t in view.content)
               {
                  switch(t.position)
                  {
                     case CharacterInventoryPositionEnum.INVENTORY_POSITION_BOOST_FOOD:
                        if(t.objectGID != iw.objectGID)
                        {
                           nbFood++;
                        }
                        break;
                     case CharacterInventoryPositionEnum.INVENTORY_POSITION_FIRST_BONUS:
                     case CharacterInventoryPositionEnum.INVENTORY_POSITION_SECOND_BONUS:
                        nbBonus++;
                        break;
                  }
               }
               if(iw.needUseConfirm)
               {
                  commonMod.openPopup(I18n.getUiText("ui.common.confirm"),I18n.getUiText("ui.common.confirmationUseItem",[iw.name]),[I18n.getUiText("ui.common.yes"),I18n.getUiText("ui.common.no")],[fncUseItem,null],fncUseItem,function():void
                  {
                  });
               }
               else
               {
                  this.useItem(oua,iw);
               }
               return true;
               break;
            case msg is ObjectDropAction:
               oda = msg as ObjectDropAction;
               if(Kernel.getWorker().contains(FightContextFrame))
               {
                  return true;
               }
               itemItem = Item.getItemById(oda.objectGID);
               if(itemItem.category == ItemCategoryEnum.QUEST_CATEGORY || oda.objectUID == 0 || oda.quantity == 0)
               {
                  return true;
               }
               this._objectUIDToDrop = oda.objectUID;
               this._objectGIDToDrop = oda.objectGID;
               this._quantityToDrop = oda.quantity;
               objectName = itemItem.name;
               if(Dofus.getInstance().options.getOption("confirmItemDrop"))
               {
                  if(this._dropPopup != null && Berilia.getInstance().getUi(this._dropPopup))
                  {
                     Berilia.getInstance().unloadUi(this._dropPopup);
                  }
                  this._dropPopup = commonMod.openPopup(I18n.getUiText("ui.common.confirm"),I18n.getUiText("ui.common.confirmationDropItem",[oda.quantity,objectName]),[I18n.getUiText("ui.common.yes"),I18n.getUiText("ui.common.no")],[this.onAcceptDrop,this.onRefuseDrop],this.onAcceptDrop,this.onRefuseDrop);
               }
               else
               {
                  odropmsg = new ObjectDropMessage();
                  odropmsg.initObjectDropMessage(this._objectUIDToDrop,this._quantityToDrop);
                  ConnectionsHandler.getConnection().send(odropmsg);
               }
               return true;
               break;
            case msg is ObjectUseOnCellAction:
               ouocmsg = new ObjectUseOnCellMessage();
               ouoca = msg as ObjectUseOnCellAction;
               ouocmsg.initObjectUseOnCellMessage(ouoca.objectUID,ouoca.targetedCell);
               ConnectionsHandler.getConnection().send(ouocmsg);
               break;
            case msg is ObjectErrorMessage:
               oemsg = msg as ObjectErrorMessage;
               if(oemsg.reason == ObjectErrorEnum.SYMBIOTIC_OBJECT_ERROR)
               {
                  return false;
               }
               this._objectPositionModification = false;
               return false;
               break;
            case msg is PresetsMessage:
               pmsg = msg as PresetsMessage;
               presetWrappers = new Array();
               idolsPresets = new Vector.<IdolsPresetWrapper>(0);
               presetsCount = pmsg.presets.length;
               for(iPreset = 0; iPreset < presetsCount; )
               {
                  preset = pmsg.presets[iPreset];
                  if(preset is IdolsPreset)
                  {
                     idolsPreset = preset as IdolsPreset;
                     _log.debug(" - " + preset.id + "  idoles");
                     idolsPresets.push(IdolsPresetWrapper.create(idolsPreset.id,idolsPreset.iconId,idolsPreset.idolIds));
                     this._presetTypeIdByPresetId[preset.id] = IDOLS_PRESET_TYPE;
                  }
                  else if(preset is IconNamedPreset)
                  {
                     forgettableSpellsActivated = FeatureManager.getInstance().isFeatureWithKeywordEnabled("character.spell.forgettable");
                     buildPreset = preset as IconNamedPreset;
                     _log.debug(" - " + buildPreset.id + "  build   " + buildPreset.name);
                     fullStatsPreset = null;
                     itemsPreset = null;
                     spellsPreset = null;
                     forgettableSpellsPreset = null;
                     subPreset = null;
                     for each(subPreset in buildPreset.presets)
                     {
                        if(subPreset is PresetsContainerPreset)
                        {
                           for each(subSubPreset in (subPreset as PresetsContainerPreset).presets)
                           {
                              if(subSubPreset is FullStatsPreset)
                              {
                                 fullStatsPreset = subSubPreset as FullStatsPreset;
                              }
                              else if(subSubPreset is ItemsPreset)
                              {
                                 itemsPreset = subSubPreset as ItemsPreset;
                              }
                           }
                        }
                        else if(subPreset is FullStatsPreset)
                        {
                           fullStatsPreset = subPreset as FullStatsPreset;
                        }
                        else if(subPreset is ItemsPreset)
                        {
                           itemsPreset = subPreset as ItemsPreset;
                        }
                        else if(subPreset is SpellsPreset)
                        {
                           spellsPreset = subPreset as SpellsPreset;
                        }
                        else if(subPreset is ForgettableSpellsPreset && forgettableSpellsActivated)
                        {
                           forgettableSpellsPreset = subPreset as ForgettableSpellsPreset;
                        }
                     }
                     if(forgettableSpellsActivated && fullStatsPreset === null && itemsPreset === null && spellsPreset === null && forgettableSpellsPreset !== null)
                     {
                        characterBuildType = CharacterBuildType.FORGETTABLE_SPELL_TYPE;
                        this._presetTypeIdByPresetId[buildPreset.id] = FORGETTABLE_PRESET_TYPE;
                     }
                     else
                     {
                        characterBuildType = CharacterBuildType.CHARACTER_TYPE;
                        this._presetTypeIdByPresetId[buildPreset.id] = CHARACTER_BUILD_PRESET_TYPE;
                     }
                     presetWrappers.push(BuildWrapper.create(buildPreset.id,characterBuildType,-1,buildPreset.name,buildPreset.iconId,fullStatsPreset,itemsPreset,spellsPreset,forgettableSpellsPreset,true));
                  }
                  iPreset++;
               }
               InventoryManager.getInstance().builds = presetWrappers;
               PlayedCharacterManager.getInstance().idolsPresets = idolsPresets;
               return true;
            case msg is InvalidPresetsMessage:
               ipmsg = msg as InvalidPresetsMessage;
               this._invalidPresets = new Vector.<BuildWrapper>();
               this._chatText = I18n.getUiText("ui.preset.warningUpdatePresets");
               buildLink = [];
               for each(id in ipmsg.presetIds)
               {
                  for each(buildWrapper in InventoryManager.getInstance().builds)
                  {
                     if(id == buildWrapper.id)
                     {
                        this._invalidPresets.push(buildWrapper);
                        buildLink.push("{openPresets, " + buildWrapper.id + ":: [" + buildWrapper.buildName + "]}");
                     }
                  }
               }
               this._chatText += buildLink + ".\n" + I18n.getUiText("ui.preset.EquipPresets");
               this._waitTimer = new BenchmarkTimer(5000,1,"InventoryManagementFrame._waitTimer");
               this._waitTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerEnd);
               this._waitTimer.start();
               return true;
            case msg is ItemForPresetUpdateMessage:
               ipiumsg = msg as ItemForPresetUpdateMessage;
               builds = InventoryManager.getInstance().builds;
               for each(build in builds)
               {
                  if(build.id == ipiumsg.presetId)
                  {
                     break;
                  }
               }
               if(!build)
               {
                  return true;
               }
               build.updateObject(ipiumsg.presetItem);
               builds = InventoryManager.getInstance().builds;
               KernelEventsManager.getInstance().processCallback(InventoryHookList.PresetsUpdate,build.id);
               return true;
               break;
            case msg is PresetDeleteRequestAction:
               pdra = msg as PresetDeleteRequestAction;
               pdmsg = new PresetDeleteRequestMessage();
               pdmsg.initPresetDeleteRequestMessage(pdra.presetId);
               ConnectionsHandler.getConnection().send(pdmsg);
               return true;
            case msg is PresetDeleteResultMessage:
               pdrmsg = msg as PresetDeleteResultMessage;
               if(pdrmsg.code == PresetDeleteResultEnum.PRESET_DEL_OK)
               {
                  deletePresetTypeId = this._presetTypeIdByPresetId[pdrmsg.presetId];
                  this._presetTypeIdByPresetId[pdrmsg.presetId] = null;
                  if(deletePresetTypeId == CHARACTER_BUILD_PRESET_TYPE || deletePresetTypeId == FORGETTABLE_PRESET_TYPE)
                  {
                     builds = InventoryManager.getInstance().builds;
                     for each(build in builds)
                     {
                        if(build && build.id == pdrmsg.presetId)
                        {
                           presetIndex = builds.indexOf(build);
                           break;
                        }
                     }
                     builds.splice(presetIndex,1);
                     KernelEventsManager.getInstance().processCallback(InventoryHookList.PresetsUpdate);
                  }
                  else if(deletePresetTypeId == IDOLS_PRESET_TYPE)
                  {
                     idolsPresets = PlayedCharacterManager.getInstance().idolsPresets;
                     for each(idolsPresetWrapper in idolsPresets)
                     {
                        if(idolsPresetWrapper.id == pdrmsg.presetId)
                        {
                           presetIndex = idolsPresets.indexOf(idolsPresetWrapper);
                           break;
                        }
                     }
                     idolsPresets.splice(presetIndex,1);
                     KernelEventsManager.getInstance().processCallback(HookList.IdolsPresetDelete,pdrmsg.presetId);
                  }
               }
               else
               {
                  switch(pdrmsg.code)
                  {
                     case PresetDeleteResultEnum.PRESET_DEL_ERR_UNKNOWN:
                        reason1 = "unknownDelete";
                        break;
                     case PresetDeleteResultEnum.PRESET_DEL_ERR_BAD_PRESET_ID:
                        reason1 = "badId";
                        break;
                     case PresetDeleteResultEnum.PRESET_DEL_ERR_SYSTEM_INACTIVE:
                        reason1 = "inactive";
                  }
                  KernelEventsManager.getInstance().processCallback(InventoryHookList.PresetError,reason1);
               }
               return true;
            case msg is CharacterPresetSaveRequestAction:
               cpsra = msg as CharacterPresetSaveRequestAction;
               npsrmsg = new IconNamedPresetSaveRequestMessage();
               npsrmsg.initIconNamedPresetSaveRequestMessage(cpsra.presetId,cpsra.symbolId,cpsra.fullSave,cpsra.name,cpsra.presetType);
               ConnectionsHandler.getConnection().send(npsrmsg);
               return true;
            case msg is IdolsPresetSaveRequestAction:
               ipsra = msg as IdolsPresetSaveRequestAction;
               ipsrmsg = new IdolsPresetSaveRequestMessage();
               ipsrmsg.initIdolsPresetSaveRequestMessage(ipsra.presetId,ipsra.symbolId,true);
               ConnectionsHandler.getConnection().send(ipsrmsg);
               return true;
            case msg is PresetSaveErrorMessage:
               psemsg = msg as PresetSaveErrorMessage;
               switch(psemsg.code)
               {
                  case PresetSaveResultEnum.PRESET_SAVE_ERR_UNKNOWN:
                     presetSaveErrorReasonText = "unknownSave";
                     break;
                  case PresetSaveResultEnum.PRESET_SAVE_ERR_TOO_MANY:
                     presetSaveErrorReasonText = "tooMany";
                     break;
                  case PresetSaveResultEnum.PRESET_SAVE_ERR_INVALID_PLAYER_STATE:
                     presetSaveErrorReasonText = "invalidPlayerState";
                     break;
                  case PresetSaveResultEnum.PRESET_SAVE_ERR_SYSTEM_INACTIVE:
                     presetSaveErrorReasonText = "inactive";
                     break;
                  case PresetSaveResultEnum.PRESET_SAVE_ERR_INVALID_ID:
                     presetSaveErrorReasonText = "badId";
               }
               KernelEventsManager.getInstance().processCallback(InventoryHookList.PresetError,presetSaveErrorReasonText);
               return true;
            case msg is PresetSavedMessage:
               psmsg = msg as PresetSavedMessage;
               if(psmsg.preset is IdolsPreset)
               {
                  idolsPreset = psmsg.preset as IdolsPreset;
                  _log.debug("Saved " + psmsg.preset.id + "  idoles");
                  idolWrapper = IdolsPresetWrapper.create(idolsPreset.id,idolsPreset.iconId,idolsPreset.idolIds);
                  PlayedCharacterManager.getInstance().idolsPresets.push(idolWrapper);
                  this._presetTypeIdByPresetId[psmsg.preset.id] = IDOLS_PRESET_TYPE;
                  KernelEventsManager.getInstance().processCallback(HookList.IdolsPresetSaved,idolWrapper);
               }
               else if(psmsg.preset is IconNamedPreset)
               {
                  forgettableSpellsActivated = FeatureManager.getInstance().isFeatureWithKeywordEnabled("character.spell.forgettable");
                  newBuild = psmsg.preset as IconNamedPreset;
                  _log.debug("Saved " + newBuild.id + "  build   " + newBuild.name);
                  fullStatsPresetSaved = null;
                  itemsPresetSaved = null;
                  spellsPresetSaved = null;
                  forgettableSpellsPresetSaved = null;
                  subPresetSaved = null;
                  for each(subPresetSaved in newBuild.presets)
                  {
                     if(subPresetSaved is PresetsContainerPreset)
                     {
                        for each(subSubPresetSaved in (subPresetSaved as PresetsContainerPreset).presets)
                        {
                           if(subSubPresetSaved is FullStatsPreset)
                           {
                              fullStatsPresetSaved = subSubPresetSaved as FullStatsPreset;
                           }
                           else if(subSubPresetSaved is ItemsPreset)
                           {
                              itemsPresetSaved = subSubPresetSaved as ItemsPreset;
                           }
                        }
                     }
                     else if(subPresetSaved is FullStatsPreset)
                     {
                        fullStatsPresetSaved = subPresetSaved as FullStatsPreset;
                     }
                     else if(subPresetSaved is ItemsPreset)
                     {
                        itemsPresetSaved = subPresetSaved as ItemsPreset;
                     }
                     else if(subPresetSaved is SpellsPreset)
                     {
                        spellsPresetSaved = subPresetSaved as SpellsPreset;
                     }
                     else if(subPresetSaved is ForgettableSpellsPreset && forgettableSpellsActivated)
                     {
                        forgettableSpellsPresetSaved = subPresetSaved as ForgettableSpellsPreset;
                     }
                  }
                  if(forgettableSpellsActivated && fullStatsPresetSaved === null && itemsPresetSaved === null && spellsPresetSaved === null && forgettableSpellsPresetSaved !== null)
                  {
                     characterBuildTypeSaved = CharacterBuildType.FORGETTABLE_SPELL_TYPE;
                  }
                  else
                  {
                     characterBuildTypeSaved = CharacterBuildType.CHARACTER_TYPE;
                  }
                  if(this._presetTypeIdByPresetId[newBuild.id])
                  {
                     builds = InventoryManager.getInstance().builds;
                     for each(build in builds)
                     {
                        if(build.id == newBuild.id)
                        {
                           build.updateBuild(newBuild.name,newBuild.iconId,fullStatsPresetSaved,itemsPresetSaved,spellsPresetSaved,forgettableSpellsPresetSaved,characterBuildTypeSaved);
                        }
                     }
                  }
                  else
                  {
                     InventoryManager.getInstance().builds.push(BuildWrapper.create(newBuild.id,characterBuildTypeSaved,-1,newBuild.name,newBuild.iconId,fullStatsPresetSaved,itemsPresetSaved,spellsPresetSaved,forgettableSpellsPresetSaved,true));
                     if(characterBuildTypeSaved === CharacterBuildType.FORGETTABLE_SPELL_TYPE)
                     {
                        this._presetTypeIdByPresetId[newBuild.id] = FORGETTABLE_PRESET_TYPE;
                     }
                     else
                     {
                        this._presetTypeIdByPresetId[newBuild.id] = CHARACTER_BUILD_PRESET_TYPE;
                     }
                  }
                  KernelEventsManager.getInstance().processCallback(InventoryHookList.PresetsUpdate);
                  KernelEventsManager.getInstance().processCallback(InventoryHookList.PresetSelected,psmsg.preset.id);
                  if(forgettableSpellsActivated)
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.ForgettableSpellPresetSaved,psmsg.preset.id);
                  }
               }
               return true;
            case msg is PresetUseRequestAction:
               pura = msg as PresetUseRequestAction;
               pumsg = new PresetUseRequestMessage();
               pumsg.initPresetUseRequestMessage(pura.presetId);
               ConnectionsHandler.getConnection().send(pumsg);
               return true;
            case msg is PresetUseResultMessage:
               purmsg = msg as PresetUseResultMessage;
               presetTypeId = this._presetTypeIdByPresetId[purmsg.presetId];
               if(presetTypeId == 0)
               {
                  _log.debug("Unknown preset id ! Aborting the use result");
                  return true;
               }
               if(purmsg.code != PresetUseResultEnum.PRESET_USE_OK && purmsg.code != PresetUseResultEnum.PRESET_USE_OK_PARTIAL && purmsg.code != PresetUseResultEnum.PRESET_USE_ERR_STATS_FIGHT_PREPARATION)
               {
                  presetUseErrorText = I18n.getUiText("ui.common.unknownFail");
                  if(presetTypeId == CHARACTER_BUILD_PRESET_TYPE)
                  {
                     if(purmsg.code != PresetUseResultEnum.PRESET_USE_ERR_UNKNOWN)
                     {
                        presetUseErrorText = I18n.getUiText("ui.preset.error." + purmsg.code);
                     }
                  }
                  else if(presetTypeId == FORGETTABLE_PRESET_TYPE)
                  {
                     if(purmsg.code == PresetUseResultEnum.PRESET_USE_ERR_COOLDOWN)
                     {
                        presetUseErrorText = I18n.getUiText("ui.temporis.spellPreset.error." + purmsg.code);
                     }
                  }
                  else if(purmsg.code == PresetUseResultEnum.PRESET_USE_ERR_CRITERION || purmsg.code == PresetUseResultEnum.PRESET_USE_ERR_BAD_PRESET_ID || purmsg.code == PresetUseResultEnum.PRESET_USE_ERR_COOLDOWN || purmsg.code == PresetUseResultEnum.PRESET_USE_ERR_INVALID_STATE)
                  {
                     presetUseErrorText = I18n.getUiText("ui.idol.preset.error." + purmsg.code);
                  }
                  KernelEventsManager.getInstance().processCallback(HookList.ErrorPopup,presetUseErrorText);
               }
               else
               {
                  chatUseText = null;
                  if(presetTypeId == CHARACTER_BUILD_PRESET_TYPE || presetTypeId == FORGETTABLE_PRESET_TYPE)
                  {
                     build = BuildWrapper.getBuildWrapperById(purmsg.presetId);
                     chatUseText = I18n.getUiText("ui.preset.inUse",[build.buildName]);
                     KernelEventsManager.getInstance().processCallback(InventoryHookList.PresetUsed,purmsg.presetId);
                  }
                  else if(presetTypeId == IDOLS_PRESET_TYPE)
                  {
                     KernelEventsManager.getInstance().processCallback(HookList.IdolsPresetEquipped,purmsg.presetId);
                     chatUseText = I18n.getUiText("ui.idol.preset.inUse",[purmsg.presetId + 1]);
                  }
                  if(chatUseText !== null)
                  {
                     KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,chatUseText,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                  }
                  if(purmsg.code == PresetUseResultEnum.PRESET_USE_OK_PARTIAL && purmsg is PresetUseResultWithMissingIdsMessage)
                  {
                     missingIds = (purmsg as PresetUseResultWithMissingIdsMessage).missingIds;
                     if(presetTypeId == CHARACTER_BUILD_PRESET_TYPE)
                     {
                        presetUseErrorText = I18n.getUiText("ui.preset.error." + purmsg.code);
                        KernelEventsManager.getInstance().processCallback(HookList.ErrorPopup,presetUseErrorText);
                     }
                     if(presetTypeId == FORGETTABLE_PRESET_TYPE)
                     {
                        currentSpellWrapper = null;
                        spellsString = "";
                        for each(missingId in missingIds)
                        {
                           currentSpellWrapper = SpellWrapper.create(missingId,1,false,0,false);
                           if(currentSpellWrapper !== null)
                           {
                              spellsString += "{spell," + currentSpellWrapper.id + "," + currentSpellWrapper.spellLevel + "}, ";
                           }
                        }
                        if(spellsString !== null && spellsString.length > 2)
                        {
                           spellsString = spellsString.substring(0,spellsString.length - 2);
                           missingText = I18n.getUiText("ui.temporis.missingTemporisSpells",[spellsString]);
                           chatFrame = Kernel.getWorker().getFrame(ChatFrame) as ChatFrame;
                           if(chatFrame !== null)
                           {
                              KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,missingText,chatFrame.getRedId(),TimeManager.getInstance().getTimestamp());
                           }
                        }
                     }
                     else
                     {
                        for each(missingId in missingIds)
                        {
                           if(presetTypeId == CHARACTER_BUILD_PRESET_TYPE)
                           {
                              if(missingId == 0)
                              {
                                 missingText = I18n.getUiText("ui.mount.noPlayerMount");
                              }
                              else
                              {
                                 missingName = Item.getItemById(missingId).name;
                                 missingText = I18n.getUiText("ui.preset.missingItem",[missingName]);
                              }
                           }
                           else
                           {
                              missingName = Idol.getIdolById(missingId).item.name;
                              missingText = I18n.getUiText("ui.idol.preset.missingIdol",[missingName]);
                           }
                           KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,missingText,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
                        }
                     }
                  }
                  else if(purmsg.code == PresetUseResultEnum.PRESET_USE_ERR_STATS_FIGHT_PREPARATION)
                  {
                     presetUseErrorText = I18n.getUiText("ui.preset.error." + purmsg.code);
                     KernelEventsManager.getInstance().processCallback(HookList.ErrorPopup,presetUseErrorText);
                  }
               }
               return true;
               break;
            case msg is AccessoryPreviewRequestAction:
               apra = msg as AccessoryPreviewRequestAction;
               aprmsg = new AccessoryPreviewRequestMessage();
               aprmsg.initAccessoryPreviewRequestMessage(apra.itemGIDs);
               ConnectionsHandler.getConnection().send(aprmsg);
               return true;
            case msg is AccessoryPreviewErrorMessage:
               apemsg = msg as AccessoryPreviewErrorMessage;
               switch(apemsg.error)
               {
                  case AccessoryPreviewErrorEnum.PREVIEW_BAD_ITEM:
                     apErrorMsg = I18n.getUiText("ui.shop.preview.badItem");
                     break;
                  case AccessoryPreviewErrorEnum.PREVIEW_COOLDOWN:
                     apErrorMsg = I18n.getUiText("ui.shop.preview.cooldown");
                     break;
                  case AccessoryPreviewErrorEnum.PREVIEW_ERROR:
                     apErrorMsg = I18n.getUiText("ui.shop.preview.error");
               }
               KernelEventsManager.getInstance().processCallback(InventoryHookList.AccessoryPreview,null);
               if(apErrorMsg)
               {
                  KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,apErrorMsg,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
               }
               return true;
            case msg is AccessoryPreviewMessage:
               apmsg = msg as AccessoryPreviewMessage;
               previewLook = apmsg.look;
               if(apmsg.look.subentities)
               {
                  for each(sube in apmsg.look.subentities)
                  {
                     if(sube.bindingPointCategory == SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET_FOLLOWER)
                     {
                        followerPet = sube;
                     }
                  }
                  if(followerPet)
                  {
                     followerPet.bindingPointCategory = SubEntityBindingPointCategoryEnum.HOOK_POINT_CATEGORY_PET;
                     previewLook.subentities.push(followerPet);
                  }
               }
               KernelEventsManager.getInstance().processCallback(InventoryHookList.AccessoryPreview,previewLook);
               return true;
            case msg is DecraftResultMessage:
               drmsg = msg as DecraftResultMessage;
               KernelEventsManager.getInstance().processCallback(CraftHookList.DecraftResult,drmsg.results);
               return true;
         }
         return false;
      }
      
      private function onTimerEnd(e:TimerEvent) : void
      {
         this._waitTimer.stop();
         this._waitTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.onTimerEnd);
         KernelEventsManager.getInstance().processCallback(ChatHookList.TextInformation,this._chatText,ChatActivableChannelsEnum.PSEUDO_CHANNEL_INFO,TimeManager.getInstance().getTimestamp());
      }
      
      private function openDevBlog() : void
      {
         navigateToURL(new URLRequest(I18n.getUiText("ui.link.newSocialDevBlog")));
      }
      
      public function pulled() : Boolean
      {
         return true;
      }
      
      public function onAcceptDrop() : void
      {
         this._dropPopup = null;
         var odropmsg:ObjectDropMessage = new ObjectDropMessage();
         odropmsg.initObjectDropMessage(this._objectUIDToDrop,this._quantityToDrop);
         if(!PlayedCharacterManager.getInstance().isFighting)
         {
            ConnectionsHandler.getConnection().send(odropmsg);
         }
      }
      
      public function onRefuseDrop() : void
      {
         this._dropPopup = null;
      }
      
      private function onCellPointed(success:Boolean, cellId:uint, entityId:Number) : void
      {
         var oucmsg:ObjectUseOnCellMessage = null;
         var ouCharmsg:ObjectUseOnCharacterMessage = null;
         if(success)
         {
            if(entityId < 0)
            {
               oucmsg = new ObjectUseOnCellMessage();
               oucmsg.initObjectUseOnCellMessage(this._currentPointUseUIDObject,cellId);
               ConnectionsHandler.getConnection().send(oucmsg);
            }
            else
            {
               ouCharmsg = new ObjectUseOnCharacterMessage();
               ouCharmsg.initObjectUseOnCharacterMessage(this._currentPointUseUIDObject,entityId);
               ConnectionsHandler.getConnection().send(ouCharmsg);
            }
         }
         this._currentPointUseUIDObject = 0;
      }
      
      private function useItem(oua:ObjectUseAction, iw:ItemWrapper) : void
      {
         var cursorIcon:Texture = null;
         var oumsg:NetworkMessage = null;
         var playerEntity:IEntity = null;
         var roleplayMovementFrame:RoleplayMovementFrame = null;
         if(oua.objectUID == this._currentPointUseUIDObject)
         {
            Kernel.getWorker().removeFrame(PointCellFrame.getInstance());
         }
         if(oua.useOnCell && iw.targetable)
         {
            if(Kernel.getWorker().getFrame(FightBattleFrame))
            {
               return;
            }
            this._currentPointUseUIDObject = oua.objectUID;
            cursorIcon = new Texture();
            cursorIcon.uri = iw.iconUri;
            cursorIcon.finalize();
            PointCellFrame.getInstance().setPointCellParameters(this.onCellPointed,cursorIcon);
            Kernel.getWorker().addFrame(PointCellFrame.getInstance() as Frame);
         }
         else
         {
            if(oua.quantity > 1)
            {
               oumsg = new ObjectUseMultipleMessage();
               (oumsg as ObjectUseMultipleMessage).initObjectUseMultipleMessage(oua.objectUID,oua.quantity);
            }
            else
            {
               oumsg = new ObjectUseMessage();
               (oumsg as ObjectUseMessage).initObjectUseMessage(oua.objectUID);
            }
            playerEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
            if(playerEntity && (playerEntity as IMovable).isMoving)
            {
               roleplayMovementFrame = Kernel.getWorker().getFrame(RoleplayMovementFrame) as RoleplayMovementFrame;
               roleplayMovementFrame.setFollowingMessage(oumsg);
               (playerEntity as IMovable).stop();
            }
            else
            {
               ConnectionsHandler.getConnection().send(oumsg);
            }
         }
      }
      
      private function displayAddedItem(pItemGID:uint, pItemQuantity:uint) : void
      {
         var entity:IEntity = DofusEntities.getEntity(PlayedCharacterManager.getInstance().id);
         var itemW:ItemWrapper = ItemWrapper.create(0,0,pItemGID,1,null);
         var icon:Texture = new Texture();
         icon.uri = itemW.getIconUri();
         icon.finalize();
         var textFormat:TextFormat = new TextFormat("Verdana",24,7615756,true);
         CharacteristicContextualManager.getInstance().addStatContextualWithIcon(icon,pItemQuantity.toString(),entity,textFormat,1,GameContextEnum.ROLE_PLAY,1,2000);
      }
      
      private function getShortcutWrapperPropFromShortcut(shortcut:Shortcut) : Object
      {
         var id:uint = 0;
         var shortcutType:uint = 0;
         var gid:uint = 0;
         if(shortcut is ShortcutObjectItem)
         {
            id = (shortcut as ShortcutObjectItem).itemUID;
            gid = (shortcut as ShortcutObjectItem).itemGID;
            shortcutType = DataEnum.SHORTCUT_TYPE_ITEM;
         }
         else if(shortcut is ShortcutObjectPreset)
         {
            id = (shortcut as ShortcutObjectPreset).presetId;
            shortcutType = DataEnum.SHORTCUT_TYPE_PRESET;
         }
         else if(shortcut is ShortcutSpell)
         {
            id = (shortcut as ShortcutSpell).spellId;
            shortcutType = DataEnum.SHORTCUT_TYPE_SPELL;
         }
         else if(shortcut is ShortcutSmiley)
         {
            id = (shortcut as ShortcutSmiley).smileyId;
            shortcutType = DataEnum.SHORTCUT_TYPE_SMILEY;
         }
         else if(shortcut is ShortcutEmote)
         {
            id = (shortcut as ShortcutEmote).emoteId;
            shortcutType = DataEnum.SHORTCUT_TYPE_EMOTE;
         }
         else if(shortcut is ShortcutObjectIdolsPreset)
         {
            id = (shortcut as ShortcutObjectIdolsPreset).presetId;
            shortcutType = DataEnum.SHORTCUT_TYPE_IDOLS_PRESET;
         }
         return {
            "id":id,
            "gid":gid,
            "type":shortcutType
         };
      }
   }
}
