package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.frames.UiStatsFrame;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.BuildInfos;
   import com.ankamagames.dofus.datacenter.quest.AchievementCategory;
   import com.ankamagames.dofus.misc.BuildTypeParser;
   import com.ankamagames.dofus.network.enums.BuildTypeEnum;
   import com.ankamagames.dofus.network.messages.game.achievement.AchievementListMessage;
   import com.ankamagames.dofus.network.types.game.achievement.AchievementAchieved;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.managers.FontManager;
   import com.ankamagames.jerakine.resources.IResourceObserver;
   import com.ankamagames.jerakine.resources.adapters.impl.BitmapAdapter;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   import flash.system.Capabilities;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   
   public class LoadingScreen extends UiRootContainer implements FinalizableUIComponent, IResourceObserver
   {
      
      public static const INFO:uint = 0;
      
      public static const IMPORTANT:uint = 1;
      
      public static const ERROR:uint = 2;
      
      public static const WARNING:uint = 3;
      
      public static const USE_FORGROUND:Boolean = false;
       
      
      private var _loader:IResourceLoader;
      
      private var _value:Number = 0;
      
      private var _levelColor:Array;
      
      private var _background:Class;
      
      private var _bandeau_bas:Class;
      
      private var _foreground:Class;
      
      private var _logoFr:Class;
      
      private var _progessAnim:Class;
      
      private var _tipsBackground:Class;
      
      private var _logBackgroundTx:Class;
      
      private var _btnLogTx:Class;
      
      private var _btnContinue:Class;
      
      private var _txProgressBar:Class;
      
      private var _txProgressBarBackground:Class;
      
      private var _fontProgress:Class;
      
      private var _fontVersion:Class;
      
      private var _tipsBackgroundTexture:TextureBitmap;
      
      private var _progressTf:TextField;
      
      private var _backgroundBitmap:Bitmap;
      
      private var _foregroundBitmap:Bitmap;
      
      private var _backgroundContainer:Sprite;
      
      private var _foregroundContainer:Sprite;
      
      private var _tipsTextField:TextField;
      
      private var _achievementLabel:TextField;
      
      private var _achievementNumbersLabel:TextField;
      
      private var _btnContinueClip:DisplayObject;
      
      private var _continueCallBack:Function;
      
      private var _progressBar:DisplayObject;
      
      private var _progressBarBackground:DisplayObject;
      
      private var _enableTipsScrollBar:Boolean;
      
      private var _lsl:LoadingScreenLight;
      
      private var _bottom:Sprite;
      
      private var _buildsInfo:TextField;
      
      private var _buildsInfoBig:TextField;
      
      private var _btnLog:DisplayObject;
      
      private var _logTf:TextField;
      
      private var _showDetailledVersion:Boolean;
      
      private var _beforeLogin:Boolean;
      
      private var _customLoadingScreen:CustomLoadingScreen;
      
      private var _startLoadingTime:Number;
      
      private var _workerbufferSize:int = -1;
      
      private var _connectionBufferSize:int = -1;
      
      public var logCallbackHandler:Function;
      
      private var _logBg:TextureBitmap;
      
      private var _bandeauBas:Bitmap;
      
      public function LoadingScreen(showDetailledVersion:Boolean = false, beforeLogin:Boolean = false, displayMiniUi:Boolean = false)
      {
         var adapter:BitmapAdapter = null;
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.SERIAL_LOADER);
         this._levelColor = new Array(8158332,9216860,11556943,16737792);
         this._background = LoadingScreen__background;
         this._bandeau_bas = LoadingScreen__bandeau_bas;
         this._foreground = LoadingScreen__foreground;
         this._logoFr = LoadingScreen__logoFr;
         this._progessAnim = LoadingScreen__progessAnim;
         this._tipsBackground = LoadingScreen__tipsBackground;
         this._logBackgroundTx = LoadingScreen__logBackgroundTx;
         this._btnLogTx = LoadingScreen__btnLogTx;
         this._btnContinue = LoadingScreen__btnContinue;
         this._txProgressBar = LoadingScreen__txProgressBar;
         this._txProgressBarBackground = LoadingScreen__txProgressBarBackground;
         this._fontProgress = LoadingScreen__fontProgress;
         this._fontVersion = LoadingScreen__fontVersion;
         super(null,null);
         this._startLoadingTime = new Date().getTime();
         listenResize(true);
         this._showDetailledVersion = showDetailledVersion;
         this._beforeLogin = beforeLogin;
         if(displayMiniUi)
         {
            this._lsl = new LoadingScreenLight();
         }
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
         this._customLoadingScreen = CustomLoadingScreenManager.getInstance().currentLoadingScreen;
         if(this._customLoadingScreen && this._customLoadingScreen.canBeReadOnScreen(beforeLogin))
         {
            try
            {
               adapter = new BitmapAdapter();
               if(this._customLoadingScreen.backgroundImg)
               {
                  adapter.loadFromData(new Uri(this._customLoadingScreen.backgroundUrl),this._customLoadingScreen.backgroundImg,this,false);
               }
               adapter = new BitmapAdapter();
               if(this._customLoadingScreen.foregroundImg)
               {
                  adapter.loadFromData(new Uri(this._customLoadingScreen.foregroundUrl),this._customLoadingScreen.foregroundImg,this,false);
               }
               this._customLoadingScreen.isViewing();
            }
            catch(e:Error)
            {
               _log.error("Failed to initialize custom loading screen : " + e);
               _customLoadingScreen = null;
               finalizeInitialization();
            }
         }
         else
         {
            this._customLoadingScreen = null;
         }
         this.finalizeInitialization();
      }
      
      override public function get finalized() : Boolean
      {
         return true;
      }
      
      override public function set finalized(b:Boolean) : void
      {
      }
      
      public function get closeMiniUiRequestHandler() : Function
      {
         if(this._lsl)
         {
            return this._lsl.closeRequestHandler;
         }
         return null;
      }
      
      public function set closeMiniUiRequestHandler(value:Function) : void
      {
         if(this._lsl)
         {
            this._lsl.closeRequestHandler = value;
         }
      }
      
      public function set value(v:Number) : void
      {
         if(v < 0)
         {
            v = 0;
         }
         if(v > 100)
         {
            v = 100;
         }
         if(this._lsl)
         {
            this._lsl.progression = v / 100;
         }
         this._value = v;
         this._progressTf.text = Math.round(v) + "%";
      }
      
      public function get value() : Number
      {
         return this._value;
      }
      
      override public function finalize() : void
      {
      }
      
      private function finalizeInitialization() : void
      {
         this._backgroundContainer = new Sprite();
         if(this._customLoadingScreen && this._customLoadingScreen.linkUrl)
         {
            this._backgroundContainer.buttonMode = true;
            this._backgroundContainer.useHandCursor = true;
            this._backgroundContainer.addEventListener(MouseEvent.CLICK,this.onClick);
         }
         if(!this._backgroundBitmap && !this._customLoadingScreen)
         {
            this._backgroundBitmap = this._backgroundContainer.addChild(new this._background()) as Bitmap;
            this._backgroundBitmap.smoothing = true;
            this._backgroundBitmap.x = (StageShareManager.startWidth - this._backgroundBitmap.width) / 2;
            this._backgroundBitmap.y = (StageShareManager.startHeight - this._backgroundBitmap.height) / 2;
         }
         addChild(this._backgroundContainer);
         this._foregroundContainer = new Sprite();
         this._foregroundContainer.mouseEnabled = false;
         this._foregroundContainer.mouseChildren = false;
         if(USE_FORGROUND)
         {
            if(!this._foregroundBitmap && !this._customLoadingScreen)
            {
               this._foregroundBitmap = this._foregroundContainer.addChild(new this._foreground()) as Bitmap;
               this._foregroundBitmap.smoothing = true;
            }
         }
         this._logBg = new TextureBitmap();
         this._logBg.width = 2000;
         this._logBg.x = (StageShareManager.startWidth - this._logBg.width) / 2;
         this._logBg.loadBitmapData(Bitmap(new this._logBackgroundTx()).bitmapData);
         this._logBg.visible = false;
         addChild(this._logBg);
         this._bottom = new Sprite();
         addChild(this._bottom);
         this._logTf = new TextField();
         this._logTf.width = StageShareManager.startWidth;
         this._logTf.x = 10;
         var font:String = FontManager.initialized && FontManager.getInstance().getFontInfo("Tahoma") ? FontManager.getInstance().getFontInfo("Tahoma").className : "Tahoma";
         this._logTf.defaultTextFormat = new TextFormat(font);
         this._logTf.multiline = true;
         this._bottom.addChild(this._logTf);
         this._logTf.visible = false;
         this._bandeauBas = new this._bandeau_bas();
         this._bandeauBas.y = StageShareManager.startHeight - this._bandeauBas.height;
         this._bandeauBas.x = (StageShareManager.startWidth - this._bandeauBas.width) / 2;
         this._bandeauBas.smoothing = true;
         this._bottom.addChild(this._bandeauBas);
         this._tipsBackgroundTexture = new TextureBitmap();
         this._tipsBackgroundTexture.scale9Grid = new Rectangle();
         this._tipsBackgroundTexture.loadBitmapData(Bitmap(new this._tipsBackground()).bitmapData);
         this._tipsBackgroundTexture.x = 89;
         this._tipsBackgroundTexture.y = 922;
         this._tipsBackgroundTexture.height = 89;
         this._bottom.addChild(this._tipsBackgroundTexture);
         this._tipsBackgroundTexture.visible = false;
         this._tipsTextField = new TextField();
         this._tipsTextField.defaultTextFormat = new TextFormat("LoadingScreenFont",16,13092805,null,null,null,null,null,"center");
         this._tipsTextField.embedFonts = true;
         this._tipsTextField.selectable = false;
         this._tipsTextField.visible = false;
         this._tipsTextField.multiline = true;
         this._tipsTextField.wordWrap = true;
         this._tipsTextField.width = 1000;
         this._tipsTextField.x = (StageShareManager.startWidth - this._tipsTextField.width) / 2;
         this._tipsTextField.height = this._tipsBackgroundTexture.height;
         this._bottom.addChild(this._tipsTextField);
         addChild(this._foregroundContainer);
         this._tipsBackgroundTexture.visible = false;
         var logo:Bitmap = new this._logoFr();
         logo.x = 435;
         logo.y = 653;
         logo.smoothing = true;
         this._bottom.addChild(logo);
         var tfFormat:TextFormat = new TextFormat("LoadingScreenFont",26,6908264,null,null,null,null,null);
         this._progressTf = new TextField();
         this._progressTf.x = 610;
         this._progressTf.y = 871;
         this._progressTf.embedFonts = true;
         this._progressTf.defaultTextFormat = tfFormat;
         this._progressTf.filters = [new DropShadowFilter(1,122,0,1,3,3)];
         this._bottom.addChild(this._progressTf);
         var progessAnim:MovieClip = new this._progessAnim() as MovieClip;
         progessAnim.x = this._progressTf.x - 3 - progessAnim.width;
         progessAnim.y = this._progressTf.y + 9;
         this._bottom.addChild(progessAnim);
         this._buildsInfo = new TextField();
         this._buildsInfo.appendText("Dofus " + BuildInfos.VERSION + "\n");
         this._buildsInfo.appendText("Mode " + BuildInfos.buildTypeName + "\n");
         this._buildsInfo.appendText(BuildInfos.BUILD_DATE + "\n");
         this._buildsInfo.appendText("Player " + Capabilities.version);
         this._buildsInfo.height = 200;
         this._buildsInfo.width = 300;
         this._buildsInfo.setTextFormat(new TextFormat("LoadingScreenFont2",14,6908264,null,true));
         this._buildsInfo.embedFonts = true;
         this._buildsInfo.y = 832;
         this._bottom.addChild(this._buildsInfo);
         this._btnLog = new this._btnLogTx();
         this._btnLog.y = 832;
         this._btnLog.addEventListener(MouseEvent.CLICK,this.onLogClick);
         this._bottom.addChild(this._btnLog);
         this._btnContinueClip = new this._btnContinue() as SimpleButton;
         this._btnContinueClip.x = this._progressTf.x + (this._progressTf.width - this._btnContinueClip.width) / 2;
         this._btnContinueClip.y = this._progressTf.y + this._progressTf.height + 30;
         this._btnContinueClip.addEventListener(MouseEvent.CLICK,this.onContinueClick);
         this._btnContinueClip.visible = false;
         this._bottom.addChild(this._btnContinueClip);
         graphics.beginFill(0);
         graphics.drawRect(0,0,width,height);
         graphics.endFill();
         if(BuildInfos.BUILD_TYPE > BuildTypeEnum.RELEASE)
         {
            this._buildsInfoBig = new TextField();
            this._buildsInfoBig.appendText(BuildInfos.buildTypeName.toUpperCase() + " version");
            this._buildsInfoBig.y = 832;
            this._buildsInfoBig.width = 400;
            this._buildsInfoBig.selectable = false;
            this._buildsInfoBig.embedFonts = true;
            this._buildsInfoBig.setTextFormat(new TextFormat("LoadingScreenFont2",40,BuildTypeParser.getTypeColor(BuildInfos.BUILD_TYPE),true));
            this._bottom.addChild(this._buildsInfoBig);
         }
         this.hideTips();
         this.onResize();
         iAmFinalized(this);
      }
      
      public function hideMiniUi() : void
      {
         if(this._lsl)
         {
            this._lsl.destroy();
            this._lsl = null;
         }
      }
      
      private function displayAchievmentProgressBar(achievmentsInfo:AchievementListMessage) : void
      {
         var randomIndex:Number = NaN;
         var category:AchievementCategory = null;
         var tempCat:AchievementCategory = null;
         var tempId:uint = 0;
         var finishedAChievement:AchievementAchieved = null;
         var font:String = null;
         var achievementsCategories:Array = AchievementCategory.getAchievementCategories();
         var isAParent:Boolean = false;
         while(!isAParent)
         {
            randomIndex = Math.round(Math.random() * (achievementsCategories.length - 1));
            category = achievementsCategories[randomIndex];
            if(category.parentId > 0)
            {
               achievementsCategories.splice(randomIndex,1);
            }
            else
            {
               isAParent = true;
            }
         }
         achievementsCategories = AchievementCategory.getAchievementCategories();
         var finishedAchievementCount:int = 0;
         var totalAchievementCount:int = 0;
         for each(tempCat in achievementsCategories)
         {
            if(tempCat.parentId == category.id || tempCat.id == category.id)
            {
               for each(tempId in tempCat.achievementIds)
               {
                  for each(finishedAChievement in achievmentsInfo.finishedAchievements)
                  {
                     if(finishedAChievement.id == tempId)
                     {
                        finishedAchievementCount++;
                     }
                  }
                  totalAchievementCount++;
               }
            }
         }
         this._progressBar = new this._txProgressBar();
         this._progressBarBackground = new this._txProgressBarBackground();
         this._achievementLabel = new TextField();
         this._achievementNumbersLabel = new TextField();
         this._tipsBackgroundTexture.y -= 18;
         this._tipsBackgroundTexture.height -= 200;
         this._tipsTextField.y = this._tipsBackgroundTexture.y + 10;
         font = FontManager.initialized && FontManager.getInstance().getFontInfo("Tahoma") ? FontManager.getInstance().getFontInfo("Tahoma").className : "Tahoma";
         this._achievementLabel.x = this._tipsBackgroundTexture.x;
         this._achievementLabel.defaultTextFormat = new TextFormat(font,19,16777215,null,null,null,null,null,"center");
         this._achievementLabel.embedFonts = true;
         this._achievementLabel.selectable = false;
         this._achievementLabel.visible = true;
         this._achievementLabel.multiline = false;
         this._achievementLabel.text = I18n.getUiText("ui.achievement.achievement") + I18n.getUiText("ui.common.colon") + category.name;
         this._achievementLabel.autoSize = TextFieldAutoSize.LEFT;
         this._achievementNumbersLabel.defaultTextFormat = new TextFormat(font,19,16777215,null,null,null,null,null,"center");
         this._achievementNumbersLabel.embedFonts = true;
         this._achievementNumbersLabel.selectable = false;
         this._achievementNumbersLabel.visible = true;
         this._achievementNumbersLabel.multiline = false;
         this._achievementNumbersLabel.text = finishedAchievementCount + " / " + totalAchievementCount;
         this._achievementNumbersLabel.autoSize = TextFieldAutoSize.LEFT;
         this._achievementNumbersLabel.x = this._tipsBackgroundTexture.x + this._tipsBackgroundTexture.width - this._achievementNumbersLabel.width;
         this._progressBarBackground.height = -3;
         this._progressBarBackground.x = this._achievementLabel.x + this._achievementLabel.width + 5;
         this._progressBarBackground.y = this._tipsBackgroundTexture.y + this._tipsBackgroundTexture.height + 5;
         this._achievementLabel.y = this._progressBarBackground.y - this._achievementLabel.height / 4;
         this._achievementLabel.height = this._progressBarBackground.height;
         this._achievementNumbersLabel.height = this._progressBarBackground.height;
         this._achievementNumbersLabel.y = this._progressBarBackground.y - this._achievementNumbersLabel.height / 4;
         this._progressBar.x = this._progressBarBackground.x;
         this._progressBar.y = this._progressBarBackground.y;
         this._progressBarBackground.width = this._tipsBackgroundTexture.x + this._tipsBackgroundTexture.width - this._achievementNumbersLabel.width - this._progressBarBackground.x - 5;
         var colorTransfom:ColorTransform = new ColorTransform();
         colorTransfom.color = uint(category.color);
         this._progressBar.transform.colorTransform = colorTransfom;
         var achievementPercent:Number = finishedAchievementCount / totalAchievementCount;
         this._progressBar.width = achievementPercent * this._progressBarBackground.width;
         this._progressBar.visible = true;
         this._progressBarBackground.visible = true;
         addChild(this._progressBarBackground);
         addChild(this._progressBar);
         addChild(this._achievementLabel);
         addChild(this._achievementNumbersLabel);
      }
      
      public function log(text:String, level:uint) : void
      {
         var tc:ColorTransform = null;
         if(level == ERROR || level == WARNING)
         {
            tc = new ColorTransform();
            tc.color = this._levelColor[level];
            this._progressTf.transform.colorTransform = tc;
            this.showLog(true);
         }
         this._logTf.htmlText += "<p><font color=\"#" + uint(this._levelColor[level]).toString(16) + "\">" + text + "</font></p>";
         this._logTf.scrollV = this._logTf.maxScrollV;
         if(this.logCallbackHandler != null)
         {
            this.logCallbackHandler(text,level);
         }
      }
      
      public function showLog(b:Boolean) : void
      {
         this._logBg.visible = b;
         this._logTf.visible = b;
      }
      
      public function hideTips() : void
      {
         this._bottom.y = 102;
         this._tipsTextField.visible = false;
         this._tipsBackgroundTexture.visible = false;
      }
      
      public function set tip(txt:String) : void
      {
         var sb:Scrollbar = null;
         this._bottom.y = 0;
         this._tipsTextField.visible = true;
         this._tipsBackgroundTexture.visible = true;
         this._tipsTextField.htmlText = txt;
         this._tipsTextField.y = this._tipsBackgroundTexture.y + (this._tipsBackgroundTexture.height - this._tipsTextField.textHeight) / 2;
         if(this._tipsTextField.numLines > 3 && this._enableTipsScrollBar)
         {
            sb = new Scrollbar(this._tipsTextField);
            sb.y = this._tipsBackgroundTexture.y;
            sb.x = 1170;
            addChild(sb);
         }
      }
      
      public function set tipSelectable(value:Boolean) : void
      {
         this._tipsTextField.selectable = value;
      }
      
      public function set enableTipsScrollBar(value:Boolean) : void
      {
         this._enableTipsScrollBar = value;
      }
      
      public function set continueCallbak(cb:Function) : void
      {
         this._btnContinueClip.visible = true;
         this.showLog(true);
         this.hideTips();
         this._continueCallBack = cb;
      }
      
      private function onLogClick(e:Event) : void
      {
         this.showLog(!this._logTf.visible);
      }
      
      private function onContinueClick(e:Event) : void
      {
         this._continueCallBack();
      }
      
      public function onLoaded(uri:Uri, resourceType:uint, resource:*) : void
      {
         if(this._customLoadingScreen)
         {
            switch(uri.toString())
            {
               case new Uri(this._customLoadingScreen.backgroundUrl).toString():
                  if(this._backgroundBitmap)
                  {
                     this._backgroundContainer.removeChild(this._backgroundBitmap);
                  }
                  this._backgroundBitmap = new Bitmap(resource as BitmapData);
                  this._backgroundBitmap.smoothing = true;
                  this._backgroundBitmap.x = (StageShareManager.startWidth - this._backgroundBitmap.width) / 2;
                  this._backgroundBitmap.y = (StageShareManager.startHeight - this._backgroundBitmap.height) / 2;
                  this._backgroundContainer.addChild(this._backgroundBitmap);
                  break;
               case new Uri(this._customLoadingScreen.foregroundUrl).toString():
                  if(this._foregroundBitmap)
                  {
                     this._foregroundContainer.removeChild(this._foregroundBitmap);
                  }
                  this._foregroundBitmap = new Bitmap(resource as BitmapData);
                  this._foregroundBitmap.smoothing = true;
                  if(this._backgroundBitmap)
                  {
                     this._backgroundBitmap.x = (StageShareManager.startWidth - this._backgroundBitmap.width) / 2;
                     this._backgroundBitmap.y = (StageShareManager.startHeight - this._backgroundBitmap.height) / 2;
                  }
                  this._foregroundContainer.addChild(this._foregroundBitmap);
            }
         }
      }
      
      public function onClick(e:MouseEvent) : void
      {
         if(this._customLoadingScreen && this._customLoadingScreen.canBeReadOnScreen(this._beforeLogin) && this._customLoadingScreen.linkUrl)
         {
            navigateToURL(new URLRequest(this._customLoadingScreen.linkUrl));
         }
      }
      
      public function onFailed(uri:Uri, errorMsg:String, errorCode:uint) : void
      {
         _log.error("Failed to load custom loading screen picture (" + uri.toString() + ")");
      }
      
      public function onProgress(uri:Uri, bytesLoaded:uint, bytesTotal:uint) : void
      {
      }
      
      public function refreshSize() : void
      {
         this.onResize();
      }
      
      override protected function onResize(event:Event = null) : void
      {
         var stageVisibleBounds:Rectangle = null;
         if(this._logTf)
         {
            stageVisibleBounds = StageShareManager.stageVisibleBounds;
            this._logTf.x = stageVisibleBounds.left + 10;
            this._buildsInfo.x = stageVisibleBounds.left + 50;
            if(this._buildsInfoBig)
            {
               this._buildsInfoBig.x = stageVisibleBounds.right - this._buildsInfoBig.textWidth - 10;
            }
            this._btnLog.x = stageVisibleBounds.left + 10;
            this._tipsBackgroundTexture.width = stageVisibleBounds.width - 100;
            this._tipsBackgroundTexture.x = stageVisibleBounds.left + (stageVisibleBounds.width - this._tipsBackgroundTexture.width) / 2;
            this._logTf.y = -this._bottom.y;
            this._logTf.height = this._bottom.y + this._bandeauBas.y - 5;
         }
      }
      
      private function onRemoveFromStage(e:Event) : void
      {
         this.removeEventListeners();
         var stats:Object = UiStatsFrame.getStatsData();
         var id:String = !!this._beforeLogin ? "first_loading_duration" : "loading_duration";
         var value:uint = (new Date().getTime() - this._startLoadingTime) / 1000;
         if(!stats.hasOwnProperty(id) || stats[id] < value)
         {
            UiStatsFrame.setStat(id,value);
         }
         KernelEventsManager.getInstance().processCallback(BeriliaHookList.LoadingFinished);
         if(this._lsl)
         {
            this._lsl.destroy();
         }
      }
      
      private function removeEventListeners() : void
      {
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStage);
         if(this._backgroundContainer != null)
         {
            this._backgroundContainer.removeEventListener(MouseEvent.CLICK,this.onClick);
         }
         if(this._btnLog != null)
         {
            this._btnLog.removeEventListener(MouseEvent.CLICK,this.onLogClick);
         }
         if(this._btnContinueClip != null)
         {
            this._btnContinueClip.removeEventListener(MouseEvent.CLICK,this.onContinueClick);
         }
      }
   }
}

import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
import com.ankamagames.jerakine.utils.display.StageShareManager;
import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.geom.Rectangle;
import flash.text.TextField;

class Scrollbar extends Sprite
{
    
   
   private var _sbDownArrow:Class;
   
   private var _sbUpArrow:Class;
   
   private var _sbCursor:Class;
   
   private var _textfield:TextField;
   
   private var _cursor:MovieClip;
   
   private var _cursorY:Number;
   
   private var _lastCursorY:Number;
   
   private var _scrollStep:Number;
   
   private var _scrollHeight:Number;
   
   function Scrollbar(pTextfield:TextField)
   {
      var dragBounds:Rectangle = null;
      this._sbDownArrow = Scrollbar__sbDownArrow;
      this._sbUpArrow = Scrollbar__sbUpArrow;
      this._sbCursor = Scrollbar__sbCursor;
      super();
      this._textfield = pTextfield;
      var upArrow:MovieClip = new this._sbUpArrow();
      var downArrow:MovieClip = new this._sbDownArrow();
      this._cursor = new this._sbCursor();
      upArrow.gotoAndStop(0);
      upArrow.buttonMode = true;
      downArrow.gotoAndStop(0);
      downArrow.buttonMode = true;
      this._cursor.gotoAndStop(0);
      this._cursor.buttonMode = true;
      this._cursorY = upArrow.height;
      addChild(upArrow);
      downArrow.y = this._textfield.height - downArrow.height;
      addChild(downArrow);
      addChild(this._cursor);
      this._scrollHeight = downArrow.y - this._cursor.height - this._cursorY;
      this._scrollStep = this._scrollHeight / (this._textfield.maxScrollV - 1);
      this.updateCursorPos();
      upArrow.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
      {
         if(_textfield.scrollV > 1)
         {
            --_textfield.scrollV;
         }
         updateCursorPos();
      });
      downArrow.addEventListener(MouseEvent.CLICK,function(e:MouseEvent):void
      {
         if(_textfield.scrollV < _textfield.maxScrollV)
         {
            ++_textfield.scrollV;
         }
         updateCursorPos();
      });
      this._textfield.addEventListener(Event.SCROLL,function(e:Event):void
      {
         updateCursorPos();
      });
      dragBounds = new Rectangle(0,this._cursorY,0,this._scrollHeight);
      this._cursor.addEventListener(MouseEvent.MOUSE_DOWN,function(e:MouseEvent):void
      {
         _cursor.startDrag(false,dragBounds);
      });
      StageShareManager.stage.addEventListener(MouseEvent.MOUSE_UP,function(e:MouseEvent):void
      {
         _cursor.stopDrag();
      });
      EnterFrameDispatcher.addEventListener(this.updateScroll,EnterFrameConst.LOADING_SCREEN_SCROLLBAR);
   }
   
   private function updateCursorPos() : void
   {
      this._cursor.y = this._cursorY + (this._textfield.scrollV - 1) * this._scrollStep;
   }
   
   private function updateScroll(e:Event) : void
   {
      var currentPos:Number = this._cursorY + (this._textfield.scrollV - 1) * this._scrollStep;
      if(this._cursor.y <= currentPos - this._scrollStep && this._textfield.scrollV > 1)
      {
         --this._textfield.scrollV;
      }
      else if(this._cursor.y >= currentPos + this._scrollStep && this._textfield.scrollV < this._textfield.maxScrollV)
      {
         ++this._textfield.scrollV;
      }
   }
}
