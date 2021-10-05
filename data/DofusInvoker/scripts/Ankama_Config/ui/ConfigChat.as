package Ankama_Config.ui
{
   import Ankama_Common.Common;
   import Ankama_Config.types.ConfigProperty;
   import com.ankamagames.berilia.components.ColorPicker;
   import com.ankamagames.berilia.components.ComboBox;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.kernel.sound.enum.SoundEnum;
   import com.ankamagames.dofus.logic.game.common.actions.NotificationResetAction;
   import com.ankamagames.dofus.misc.lists.CustomUiHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.dofus.uiApi.ChatApi;
   import com.ankamagames.dofus.uiApi.DataApi;
   import com.ankamagames.dofus.uiApi.UiTutoApi;
   import flash.geom.ColorTransform;
   import flash.ui.Mouse;
   import flash.ui.MouseCursor;
   
   public class ConfigChat extends ConfigUi
   {
       
      
      [Api(name="DataApi")]
      public var dataApi:DataApi;
      
      [Api(name="ChatApi")]
      public var chatApi:ChatApi;
      
      [Api(name="UiTutoApi")]
      public var hintsApi:UiTutoApi;
      
      [Module(name="Ankama_Common")]
      public var modCommon:Common;
      
      private var _colorTexture:Texture;
      
      private var _channels:Array;
      
      private var _spellTooltipDelays:Array;
      
      private var _itemTooltipDelays:Array;
      
      private var _hdvBuyPopupBlockType:Array;
      
      private const _tooltipMsDelay:Array = [0,500,2000,-1];
      
      private const _hdvBlockPopupType:Array = ["Always","Sometimes","Never"];
      
      public var cp_colorPk:ColorPicker;
      
      public var btn_resetColors:ButtonContainer;
      
      public var btn_lockUI:ButtonContainer;
      
      public var btn_smallScreenFont:ButtonContainer;
      
      public var btn_showNotifications:ButtonContainer;
      
      public var btn_resetNotifications:ButtonContainer;
      
      public var btn_resetUIPositions:ButtonContainer;
      
      public var btn_resetUIHints:ButtonContainer;
      
      public var btn_bigMenuButton:ButtonContainer;
      
      public var btn_showEsportNotifications:ButtonContainer;
      
      public var btn_showMiniMap:ButtonContainer;
      
      public var btn_showMapGrid:ButtonContainer;
      
      public var btn_showMiniMapGrid:ButtonContainer;
      
      public var lbl_sample:Label;
      
      public var cb_channel:ComboBox;
      
      public var cb_spellTooltipDelay:ComboBox;
      
      public var cb_itemTooltipDelay:ComboBox;
      
      public var cb_hdvBuyPopupBlockType:ComboBox;
      
      public var btn_alwaysDisplayTheoreticalEffects:ButtonContainer;
      
      public var btn_showOmegaUnderOrnament:ButtonContainer;
      
      public function ConfigChat()
      {
         super();
      }
      
      public function main(args:*) : void
      {
         sysApi.addHook(HookList.ConfigPropertyChange,this.onConfigPropertyChange);
         this.btn_resetColors.soundId = SoundEnum.CHECKBOX_CHECKED;
         var properties:Array = [];
         properties.push(new ConfigProperty("btn_lockUI","lockUI","dofus"));
         properties.push(new ConfigProperty("btn_smallScreenFont","smallScreenFont","dofus"));
         properties.push(new ConfigProperty("btn_confirmItemDrop","confirmItemDrop","dofus"));
         properties.push(new ConfigProperty("btn_showNotifications","showNotifications","dofus"));
         properties.push(new ConfigProperty("btn_showEsportNotifications","showEsportNotifications","dofus"));
         properties.push(new ConfigProperty("btn_showUIHints","showUIHints","dofus"));
         properties.push(new ConfigProperty("btn_bigMenuButton","bigMenuButton","dofus"));
         properties.push(new ConfigProperty("cb_hdvBuyPopupBlockType","hdvBlockPopupType","dofus"));
         properties.push(new ConfigProperty("btn_showMiniMap","showMiniMap","dofus"));
         properties.push(new ConfigProperty("btn_showMapGrid","showMapGrid","dofus"));
         properties.push(new ConfigProperty("btn_showMiniMapGrid","showMiniMapGrid","dofus"));
         properties.push(new ConfigProperty("btn_letLivingObjectTalk","letLivingObjectTalk","chat"));
         properties.push(new ConfigProperty("btn_filterInsult","filterInsult","chat"));
         properties.push(new ConfigProperty("btn_showTime","showTime","chat"));
         properties.push(new ConfigProperty("btn_channelLocked","channelLocked","chat"));
         properties.push(new ConfigProperty("btn_showShortcut","showShortcut","chat"));
         properties.push(new ConfigProperty("btn_showInfoPrefix","showInfoPrefix","chat"));
         properties.push(new ConfigProperty("btn_smileysAutoclosed","smileysAutoclosed","chat"));
         properties.push(new ConfigProperty("cb_spellTooltipDelay","spellTooltipDelay","dofus"));
         properties.push(new ConfigProperty("cb_itemTooltipDelay","itemTooltipDelay","dofus"));
         properties.push(new ConfigProperty("btn_alwaysDisplayTheoreticalEffects","alwaysDisplayTheoreticalEffectsInTooltip","dofus"));
         properties.push(new ConfigProperty("btn_showOmegaUnderOrnament","showOmegaUnderOrnament","dofus"));
         properties.push(new ConfigProperty("btn_useTheoreticalValuesInSpellTooltips","useTheoreticalValuesInSpellTooltips","dofus"));
         init(properties);
         this.initChatOptions();
         this.initTooltipOptions();
         this.initHdvOption();
         this.btn_resetUIPositions.softDisabled = !sysApi.getOption("resetUIPositions","dofus");
         this.btn_resetNotifications.softDisabled = !sysApi.getOption("resetNotifications","dofus");
         this.btn_resetUIHints.softDisabled = !sysApi.getOption("resetUIHints","dofus");
         this.btn_resetColors.softDisabled = !sysApi.getOption("resetColors","dofus");
         this.btn_resetUIPositions.buttonMode = sysApi.getOption("resetUIPositions","dofus");
         this.btn_resetUIPositions.useHandCursor = sysApi.getOption("resetUIPositions","dofus");
         this.btn_resetNotifications.buttonMode = sysApi.getOption("resetNotifications","dofus");
         this.btn_resetNotifications.useHandCursor = sysApi.getOption("resetNotifications","dofus");
         this.btn_resetUIHints.buttonMode = sysApi.getOption("resetUIHints","dofus");
         this.btn_resetUIHints.useHandCursor = sysApi.getOption("resetUIHints","dofus");
         this.btn_resetColors.buttonMode = sysApi.getOption("resetColors","dofus");
         this.btn_resetColors.useHandCursor = sysApi.getOption("resetColors","dofus");
      }
      
      override public function reset() : void
      {
         super.reset();
         init(_properties);
         this.initChatOptions();
      }
      
      public function unload() : void
      {
         sysApi.dispatchHook(HookList.UpdateChatOptions);
      }
      
      private function initChatOptions() : void
      {
         var chan:* = undefined;
         this._channels = [];
         var serverLangs:Vector.<int> = sysApi.getCurrentServer().community.supportedLangIds;
         for each(chan in this.dataApi.getAllChatChannels())
         {
            if(chan.id != ChatActivableChannelsEnum.PSEUDO_CHANNEL_FIGHT_LOG && (chan.id != ChatActivableChannelsEnum.CHANNEL_COMMUNITY || serverLangs.length > 1))
            {
               this._channels.push(chan);
            }
         }
         this.cb_channel.dataProvider = this._channels;
         this.cb_channel.value = this._channels[0];
         this.cb_channel.dataNameField = "name";
      }
      
      private function initTooltipOptions() : void
      {
         this._spellTooltipDelays = [uiApi.getText("ui.option.tooltip.displayDelayInstant"),uiApi.getText("ui.option.tooltip.displayDelayShort"),uiApi.getText("ui.option.tooltip.displayDelayLong"),uiApi.getText("ui.option.tooltip.displayDelayDisabled")];
         this.cb_spellTooltipDelay.dataProvider = this._spellTooltipDelays;
         var index:int = this._tooltipMsDelay.indexOf(sysApi.getOption("spellTooltipDelay","dofus"));
         if(index == -1)
         {
            index = 1;
         }
         this.cb_spellTooltipDelay.value = this._spellTooltipDelays[index];
         this.cb_spellTooltipDelay.dataNameField = "";
         this._itemTooltipDelays = [uiApi.getText("ui.option.tooltip.displayDelayInstant"),uiApi.getText("ui.option.tooltip.displayDelayShort"),uiApi.getText("ui.option.tooltip.displayDelayLong"),uiApi.getText("ui.option.tooltip.displayDelayDisabled")];
         this.cb_itemTooltipDelay.dataProvider = this._itemTooltipDelays;
         index = this._tooltipMsDelay.indexOf(sysApi.getOption("itemTooltipDelay","dofus"));
         if(index == -1)
         {
            index = 1;
         }
         this.cb_itemTooltipDelay.value = this._itemTooltipDelays[index];
         this.cb_itemTooltipDelay.dataNameField = "";
      }
      
      private function initHdvOption() : void
      {
         this._hdvBuyPopupBlockType = [uiApi.getText("ui.option.tooltip.always"),uiApi.getText("ui.option.tooltip.toFarPrice"),uiApi.getText("ui.option.tooltip.never")];
         this.cb_hdvBuyPopupBlockType.dataProvider = this._hdvBuyPopupBlockType;
         var index:int = this._hdvBlockPopupType.indexOf(sysApi.getOption("hdvBlockPopupType","dofus"));
         if(index == -1)
         {
            index = 1;
         }
         this.cb_hdvBuyPopupBlockType.value = this._hdvBuyPopupBlockType[index];
         this.cb_hdvBuyPopupBlockType.dataNameField = "";
      }
      
      private function undoOptions() : void
      {
         var color:* = undefined;
         var i:* = undefined;
         var colorId:uint = 0;
         var colors:Array = [];
         for each(color in this.chatApi.getChatColors())
         {
            colors.push(color);
         }
         for each(i in this._channels)
         {
            configApi.setConfigProperty("chat","channelColor" + i.id,colors[i.id]);
         }
         this.cb_channel.dataProvider = this._channels;
         this.cb_channel.selectedIndex = 0;
         colorId = configApi.getConfigProperty("chat","channelColor" + this.cb_channel.value.id);
         this.cp_colorPk.color = colorId;
         this.lbl_sample.colorText = colorId;
      }
      
      private function onConfigPropertyChange(target:String, name:String, value:*, oldValue:*) : void
      {
         var mapUi:UiRootContainer = null;
         switch(name)
         {
            case "showUIHints":
               if(!value)
               {
                  this.hintsApi.closeSubHints();
               }
               break;
            case "smallScreenFont":
               sysApi.changeActiveFontType(value == true ? "smallScreen" : "");
               break;
            case "showMiniMap":
               mapUi = uiApi.getUi("bannerMap");
               if(mapUi && !this.hintsApi.isInTutorialArea())
               {
                  mapUi.uiClass.activated = value;
               }
               break;
            case "showMapGrid":
               mapUi = uiApi.getUi("cartographyUi");
               if(mapUi)
               {
                  mapUi.uiClass.mapViewer.showGrid = value;
               }
               break;
            case "showMiniMapGrid":
               mapUi = uiApi.getUi("bannerMap");
               if(mapUi)
               {
                  mapUi.uiClass.mapViewer.showGrid = value;
               }
               break;
            case "resetUIPositions":
               this.btn_resetUIPositions.softDisabled = !value;
               this.btn_resetUIPositions.buttonMode = value;
               this.btn_resetUIPositions.useHandCursor = value;
               break;
            case "resetNotifications":
               this.btn_resetNotifications.softDisabled = !value;
               this.btn_resetNotifications.buttonMode = value;
               this.btn_resetNotifications.useHandCursor = value;
               break;
            case "resetUIHints":
               this.btn_resetUIHints.softDisabled = !value;
               this.btn_resetUIHints.buttonMode = value;
               this.btn_resetUIHints.useHandCursor = value;
               break;
            case "resetColors":
               this.btn_resetColors.softDisabled = !value;
               this.btn_resetColors.buttonMode = value;
               this.btn_resetColors.useHandCursor = value;
         }
      }
      
      override public function onRelease(target:Object) : void
      {
         super.onRelease(target);
         switch(target)
         {
            case this.btn_resetColors:
               this.undoOptions();
               configApi.setConfigProperty("dofus","resetColors",false);
               Mouse.cursor = MouseCursor.AUTO;
               Mouse.show();
               break;
            case this.btn_showNotifications:
               sysApi.dispatchHook(CustomUiHookList.RefreshTips);
               break;
            case this.btn_resetNotifications:
               sysApi.sendAction(new NotificationResetAction([]));
               configApi.setConfigProperty("dofus","resetNotifications",false);
               Mouse.cursor = MouseCursor.AUTO;
               Mouse.show();
               break;
            case this.btn_resetUIPositions:
               uiApi.resetUiSavedUserModification();
               configApi.setConfigProperty("dofus","resetUIPositions",false);
               Mouse.cursor = MouseCursor.AUTO;
               Mouse.show();
               break;
            case this.btn_resetUIHints:
               this.hintsApi.resetGuidedUiHints();
               configApi.setConfigProperty("dofus","resetUIHints",false);
               Mouse.cursor = MouseCursor.AUTO;
               Mouse.show();
         }
      }
      
      public function onSelectItem(target:GraphicContainer, selectMethod:uint, isNewSelection:Boolean) : void
      {
         var color:uint = 0;
         switch(target)
         {
            case this.cb_channel:
               color = configApi.getConfigProperty("chat","channelColor" + this.cb_channel.value.id);
               this.lbl_sample.colorText = color;
               this.cp_colorPk.color = color;
               break;
            case this.cb_spellTooltipDelay:
               setProperty("dofus","spellTooltipDelay",this._tooltipMsDelay[this.cb_spellTooltipDelay.selectedIndex]);
               break;
            case this.cb_itemTooltipDelay:
               setProperty("dofus","itemTooltipDelay",this._tooltipMsDelay[this.cb_itemTooltipDelay.selectedIndex]);
               break;
            case this.cb_hdvBuyPopupBlockType:
               setProperty("dofus","hdvBlockPopupType",this._hdvBlockPopupType[this.cb_hdvBuyPopupBlockType.selectedIndex]);
         }
      }
      
      public function onColorChange(target:Object) : void
      {
         var t:ColorTransform = null;
         var color:uint = this.cp_colorPk.color;
         if(color != configApi.getConfigProperty("chat","channelColor" + this.cb_channel.value.id))
         {
            if(!this._colorTexture)
            {
               this._colorTexture = this.cb_channel.container.uiClass.tx_color;
            }
            t = new ColorTransform();
            t.color = color;
            this._colorTexture.transform.colorTransform = t;
            configApi.setConfigProperty("chat","channelColor" + this.cb_channel.value.id,color);
            this.lbl_sample.colorText = color;
            configApi.setConfigProperty("dofus","resetColors",true);
         }
      }
      
      public function onRollOver(target:GraphicContainer) : void
      {
         var tooltipText:String = null;
         var point:uint = 7;
         var relPoint:uint = 1;
         switch(target)
         {
            case this.btn_resetNotifications:
               tooltipText = uiApi.getText("ui.option.resetHints");
         }
         uiApi.showTooltip(uiApi.textTooltipInfo(tooltipText),target,false,"standard",point,relPoint,3,null,null,null,"TextInfo");
      }
      
      public function onRollOut(target:GraphicContainer) : void
      {
         uiApi.hideTooltip();
      }
   }
}
