package com.ankamagames.dofus.console.moduleLogger
{
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.TextFieldScrollBar;
   import com.ankamagames.berilia.managers.CssManager;
   import com.ankamagames.berilia.types.data.ExtendedStyleSheet;
   import com.ankamagames.dofus.datacenter.communication.ChatChannel;
   import com.ankamagames.dofus.kernel.Kernel;
   import com.ankamagames.dofus.logic.game.common.frames.ChatFrame;
   import com.ankamagames.dofus.logic.game.common.frames.PartyManagementFrame;
   import com.ankamagames.dofus.logic.game.common.frames.SocialFrame;
   import com.ankamagames.dofus.logic.game.common.managers.PlayedCharacterManager;
   import com.ankamagames.dofus.logic.game.common.managers.TimeManager;
   import com.ankamagames.dofus.misc.options.ChatOptions;
   import com.ankamagames.dofus.network.enums.ChatActivableChannelsEnum;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.logger.ModuleLogger;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.types.events.PropertyChangeEvent;
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   import flash.display.NativeMenu;
   import flash.display.NativeMenuItem;
   import flash.display.NativeWindow;
   import flash.display.NativeWindowInitOptions;
   import flash.display.Sprite;
   import flash.display.StageAlign;
   import flash.display.StageScaleMode;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.NativeWindowBoundsEvent;
   import flash.events.NativeWindowDisplayStateEvent;
   import flash.events.TimerEvent;
   import flash.filesystem.File;
   import flash.filesystem.FileMode;
   import flash.filesystem.FileStream;
   import flash.geom.Point;
   import flash.text.StyleSheet;
   import flash.utils.getQualifiedClassName;
   
   public final class Console
   {
      
      private static const OPTIONS_HEIGHT:uint = 30;
      
      private static const OPTIONS_BACKGROUND_COLOR:uint = 4473941;
      
      public static const ICON_SIZE:int = 22;
      
      public static const ICON_INTERVAL:int = 15;
      
      private static const SCROLLBAR_SIZE:uint = 10;
      
      private static const SCROLL_BG_COLOR:uint = 4473941;
      
      private static const SCROLL_COLOR:uint = 6710920;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Console));
      
      public static var logChatMessagesOnly:Boolean;
      
      private static var _self:Console;
      
      private static var _displayed:Boolean = false;
       
      
      private var _consoleStyle:StyleSheet;
      
      private var _bgColor:uint;
      
      private var _chatChannelsMenu:NativeMenu;
      
      private var _window:NativeWindow;
      
      private var _lines:Vector.<String>;
      
      private var _active:Boolean = false;
      
      private var _iconList:ConsoleIconList;
      
      private var _textContainer:Label;
      
      private var _scrollBar:TextFieldScrollBar;
      
      private var _backGround:Sprite;
      
      private var _updateWordWrapTimer:BenchmarkTimer;
      
      private var regExp:RegExp;
      
      private var regExp2:RegExp;
      
      public function Console()
      {
         this._lines = new Vector.<String>();
         this._updateWordWrapTimer = new BenchmarkTimer(50,0,"Console._updateWordWrapTimer");
         this.regExp = /<[^>]*>/g;
         this.regExp2 = /•/g;
         super();
         if(_self)
         {
            throw new Error();
         }
         this._textContainer = new Label();
         this._textContainer.wordWrap = true;
         this._textContainer.setStyleSheet(this.consoleStyle);
         this._textContainer.multiline = true;
         this._textContainer.textfield.mouseWheelEnabled = false;
         this._textContainer.textfield.embedFonts = false;
         this._scrollBar = new TextFieldScrollBar();
         this._scrollBar.initProperties(this._textContainer,this._lines,10,SCROLL_BG_COLOR,SCROLL_COLOR);
         ModuleLogger.addCallback(this.log);
      }
      
      public static function getInstance() : Console
      {
         var chatOptions:OptionManager = null;
         if(!_self)
         {
            _self = new Console();
            chatOptions = OptionManager.getOptionManager("chat");
            if(chatOptions)
            {
               chatOptions.addEventListener(PropertyChangeEvent.PROPERTY_CHANGED,_self.onPropertyChanged);
            }
         }
         return _self;
      }
      
      public static function isVisible() : Boolean
      {
         return _displayed;
      }
      
      public function get consoleStyle() : StyleSheet
      {
         if(!this._consoleStyle)
         {
            this.initConsoleStyle();
         }
         return this._consoleStyle;
      }
      
      public function get opened() : Boolean
      {
         return this._window != null;
      }
      
      private function output(message:TypeMessage) : void
      {
         var newLines:Array = null;
         var line:String = null;
         if(this._active)
         {
            newLines = message.textInfo.split("\n");
            for each(line in newLines)
            {
               this._scrollBar.addTextLength(line);
            }
            this._lines.push(newLines);
            if(!_displayed)
            {
               return;
            }
            this._updateWordWrapTimer.reset();
            this._updateWordWrapTimer.start();
         }
      }
      
      public function close() : void
      {
         _displayed = false;
         if(this._window)
         {
            this._window.close();
            this._window = null;
         }
      }
      
      public function activate() : void
      {
         this._active = ModuleLogger.active = true;
      }
      
      public function display(quietMode:Boolean = false) : void
      {
         ModuleLogger.active = true;
         this._active = true;
         if(quietMode)
         {
            return;
         }
         if(!this._window)
         {
            this.createWindow();
         }
         _displayed = true;
         this._window.activate();
      }
      
      public function toggleDisplay() : void
      {
         if(_displayed)
         {
            this.close();
         }
         else
         {
            this.display();
         }
      }
      
      private function log(... args) : void
      {
         var message:TypeMessage = null;
         if(this._active && args.length)
         {
            message = CallWithParameters.callConstructor(TypeMessage,args);
            if(!logChatMessagesOnly || logChatMessagesOnly && message.type == TypeMessage.LOG_CHAT)
            {
               this.output(message);
            }
         }
      }
      
      private function onPropertyChanged(pEvent:PropertyChangeEvent) : void
      {
         var styleId:String = null;
         var style:Object = null;
         if(pEvent.currentTarget is ChatOptions && pEvent.propertyName.indexOf("channelColor") != -1)
         {
            styleId = ".p" + parseInt(pEvent.propertyName.split("channelColor")[1]);
            style = this._consoleStyle.getStyle(styleId);
            style.color = "#" + pEvent.propertyValue.toString(16);
            this._consoleStyle.setStyle(styleId,style);
            if(_displayed)
            {
               this._updateWordWrapTimer.reset();
               this._updateWordWrapTimer.start();
            }
         }
      }
      
      public function clearConsole(e:Event = null) : void
      {
         this._scrollBar.clear();
         this._scrollBar.updateScrolling();
         this._textContainer.text = "";
         this.onUpdateWordWrap(null);
      }
      
      private function initConsoleStyle() : void
      {
         var styleName:String = null;
         var option:String = null;
         var styleId:String = null;
         var style:Object = null;
         this._consoleStyle = new StyleSheet();
         var ss:ExtendedStyleSheet = CssManager.getInstance().getCss("theme://css/chat.css");
         if(ss)
         {
            for each(styleName in ss.styleNames)
            {
               this._consoleStyle.setStyle("." + styleName,ss.getStyle(styleName));
            }
         }
         var chatOptions:ChatOptions = OptionManager.getOptionManager("chat") as ChatOptions;
         if(chatOptions)
         {
            for each(option in chatOptions.allOptions())
            {
               if(option.indexOf("channelColor") != -1)
               {
                  styleId = ".p" + parseInt(option.split("channelColor")[1]);
                  style = this._consoleStyle.getStyle(styleId);
                  style.color = "#" + chatOptions.getOption(option).toString(16);
                  this._consoleStyle.setStyle(styleId,style);
               }
            }
         }
      }
      
      private function createIcons() : void
      {
         this._iconList = new ConsoleIconList();
         var erase:ConsoleIcon = new ConsoleIcon("cancel",ICON_SIZE,I18n.getUiText("ui.chat.external.eraseConversation"),this._iconList);
         erase.addEventListener(MouseEvent.MOUSE_DOWN,this.clearConsole,false,0,true);
         var disk:ConsoleIcon = new ConsoleIcon("disk",ICON_SIZE,I18n.getUiText("ui.chat.external.saveConversation"),this._iconList);
         disk.addEventListener(MouseEvent.MOUSE_DOWN,this.saveText,false,0,true);
      }
      
      private function initUI() : void
      {
         this._window.addEventListener(NativeWindowDisplayStateEvent.DISPLAY_STATE_CHANGE,this.onResize);
         var uiContainer:Sprite = new Sprite();
         this._window.stage.addChild(uiContainer);
         uiContainer.addChild(this._backGround);
         uiContainer.addChild(this._textContainer);
         this._backGround.addChild(this._scrollBar);
         uiContainer.addChild(this._iconList);
         this.displayInfos();
      }
      
      private function displayInfos() : void
      {
         this.onResize();
         this.onUpdateWordWrap(null);
      }
      
      private function createChatUI() : void
      {
         this._backGround = new Sprite();
         this.createIcons();
         this._chatChannelsMenu = null;
         var channelsFilter:ConsoleIcon = new ConsoleIcon("list",ICON_SIZE,I18n.getUiText("ui.chat.external.showChannelsList"),this._iconList);
         channelsFilter.addEventListener(MouseEvent.MOUSE_DOWN,this.openChatChannelsMenu,false,0,true);
         this._bgColor = XmlConfig.getInstance().getEntry("colors.chat.bgColor");
         this._updateWordWrapTimer.addEventListener(TimerEvent.TIMER,this.onUpdateWordWrap);
         this.initUI();
      }
      
      private function isChanAvailable(pChanId:uint) : Boolean
      {
         var partyManagementFrame:PartyManagementFrame = null;
         switch(pChanId)
         {
            case ChatActivableChannelsEnum.CHANNEL_GUILD:
               return SocialFrame.getInstance().hasGuild;
            case ChatActivableChannelsEnum.CHANNEL_PARTY:
               return PlayedCharacterManager.getInstance().isInParty;
            case ChatActivableChannelsEnum.CHANNEL_ARENA:
               partyManagementFrame = Kernel.getWorker().getFrame(PartyManagementFrame) as PartyManagementFrame;
               return partyManagementFrame.arenaPartyMembers.length > 0;
            case ChatActivableChannelsEnum.CHANNEL_ALLIANCE:
               return SocialFrame.getInstance().hasAlliance;
            case ChatActivableChannelsEnum.CHANNEL_TEAM:
               return PlayedCharacterManager.getInstance().isSpectator || PlayedCharacterManager.getInstance().isFighting;
            default:
               return true;
         }
      }
      
      private function openChatChannelsMenu(pEvent:MouseEvent) : void
      {
         var chan:ChatChannel = null;
         var item:NativeMenuItem = null;
         if(!this._chatChannelsMenu)
         {
            this._chatChannelsMenu = new NativeMenu();
            this._chatChannelsMenu.addEventListener(Event.SELECT,this.filterChatChannel);
         }
         while(this._chatChannelsMenu.items.length)
         {
            this._chatChannelsMenu.getItemAt(0).removeEventListener(Event.SELECT,this.filterChatChannel);
            this._chatChannelsMenu.removeItemAt(0);
         }
         var chatFrame:ChatFrame = Kernel.getWorker().getFrame(ChatFrame) as ChatFrame;
         var channels:Array = ChatChannel.getChannels();
         var externalChatChannels:Array = OptionManager.getOptionManager("chat").getOption("externalChatEnabledChannels");
         for each(chan in channels)
         {
            if(chatFrame.disallowedChannels.indexOf(chan.id) == -1 && this.isChanAvailable(chan.id))
            {
               item = new NativeMenuItem(chan.name);
               item.data = chan;
               if(externalChatChannels.indexOf(chan.id) != -1)
               {
                  item.checked = true;
               }
               item.addEventListener(Event.SELECT,this.filterChatChannel,false,0,true);
               this._chatChannelsMenu.addItem(item);
            }
         }
         this._chatChannelsMenu.display(this._window.stage,this._window.stage.mouseX,this._window.stage.mouseY);
      }
      
      private function filterChatChannel(pEvent:Event) : void
      {
         var chan:ChatChannel = null;
         var externalChatChannels:Array = null;
         var item:NativeMenuItem = pEvent.currentTarget as NativeMenuItem;
         if(item)
         {
            chan = item.data as ChatChannel;
            item.checked = !item.checked;
            externalChatChannels = OptionManager.getOptionManager("chat").getOption("externalChatEnabledChannels");
            if(item.checked)
            {
               externalChatChannels.push(chan.id);
            }
            else
            {
               externalChatChannels.splice(externalChatChannels.indexOf(chan.id),1);
            }
         }
      }
      
      public function updateEnabledChatChannels() : void
      {
         var item:NativeMenuItem = null;
         if(!this._chatChannelsMenu)
         {
            return;
         }
         var externalChatChannels:Array = OptionManager.getOptionManager("chat").getOption("externalChatEnabledChannels");
         for each(item in this._chatChannelsMenu.items)
         {
            item.checked = externalChatChannels.indexOf(item.data.id) != -1;
         }
      }
      
      private function createWindow() : void
      {
         var options:NativeWindowInitOptions = null;
         if(!this._window)
         {
            options = new NativeWindowInitOptions();
            options.resizable = true;
            this._window = new NativeWindow(options);
            this._window.width = 600;
            this._window.height = 400;
            this._window.minSize = new Point(300,300);
            this._window.title = "Dofus Chat - " + PlayedCharacterManager.getInstance().infos.name;
            this._window.addEventListener(Event.CLOSE,this.onClose);
            this._window.addEventListener(NativeWindowBoundsEvent.RESIZE,this.onResize);
            this._window.stage.align = StageAlign.TOP_LEFT;
            this._window.stage.scaleMode = StageScaleMode.NO_SCALE;
            this._window.stage.tabChildren = false;
            this.createChatUI();
         }
      }
      
      private function onUpdateWordWrap(pEvent:TimerEvent) : void
      {
         this._updateWordWrapTimer.stop();
         this._scrollBar.resize(this._window.stage.stageWidth,this._window.stage.stageHeight - OPTIONS_HEIGHT - SCROLLBAR_SIZE);
         this._scrollBar.updateScrolling();
      }
      
      private function onResize(event:Event = null) : void
      {
         this._backGround.graphics.clear();
         this._backGround.graphics.beginFill(this._bgColor);
         this._backGround.graphics.drawRect(0,0,this._window.stage.stageWidth,this._window.stage.stageHeight);
         this._backGround.graphics.endFill();
         this._backGround.graphics.beginFill(OPTIONS_BACKGROUND_COLOR);
         this._backGround.graphics.drawRect(0,0,this._window.stage.stageWidth,OPTIONS_HEIGHT);
         this._backGround.graphics.endFill();
         if(this._iconList)
         {
            this._iconList.x = 10;
            this._iconList.y = 3;
         }
         this._textContainer.y = OPTIONS_HEIGHT;
         this._scrollBar.resize(this._window.stage.stageWidth,this._window.stage.stageHeight - OPTIONS_HEIGHT - SCROLLBAR_SIZE);
         this._scrollBar.updateScrolling();
      }
      
      private function saveText(e:Event) : void
      {
         var fileName:* = File.desktopDirectory.nativePath + File.separator + "dofus_chat-";
         var d:Date = new Date();
         fileName += TimeManager.getInstance().formatDateIRL(d.time).split("/").join("-");
         fileName += "." + TimeManager.getInstance().formatClock(d.time).replace(":","");
         fileName += ".txt";
         var file:File = new File(fileName);
         file.browseForSave(I18n.getUiText("ui.common.save"));
         file.addEventListener(Event.SELECT,this.onFileSelect,false,0,true);
      }
      
      private function onClose(e:Event) : void
      {
         _displayed = false;
         this._window.removeEventListener(Event.CLOSE,this.onClose);
         this._window.removeEventListener(NativeWindowBoundsEvent.RESIZE,this.onResize);
         this._window = null;
         var chatFrame:ChatFrame = Kernel.getWorker().getFrame(ChatFrame) as ChatFrame;
         if(chatFrame)
         {
            chatFrame.getHistoryMessages().length = 0;
         }
         if(this._updateWordWrapTimer)
         {
            this._updateWordWrapTimer.removeEventListener(TimerEvent.TIMER,this.onUpdateWordWrap);
         }
         if(this._chatChannelsMenu)
         {
            this._chatChannelsMenu.removeEventListener(Event.SELECT,this.filterChatChannel);
         }
      }
      
      private function onFileSelect(e:Event) : void
      {
         var fileStream:FileStream = null;
         var text:String = null;
         try
         {
            text = this._lines.join(File.lineEnding);
            text = text.replace(this.regExp,"");
            text = text.replace(this.regExp2," ");
            fileStream = new FileStream();
            fileStream.open(e.target as File,FileMode.WRITE);
            fileStream.writeUTFBytes(text);
            fileStream.close();
         }
         catch(e:Error)
         {
         }
         finally
         {
            if(fileStream)
            {
               fileStream.close();
            }
         }
      }
   }
}
