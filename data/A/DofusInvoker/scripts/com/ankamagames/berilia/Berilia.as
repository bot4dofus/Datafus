package com.ankamagames.berilia
{
   import com.ankamagames.berilia.api.ApiBinder;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.managers.AutoReloadUiManager;
   import com.ankamagames.berilia.managers.BindsManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
   import com.ankamagames.berilia.managers.SecureCenter;
   import com.ankamagames.berilia.managers.UIEventManager;
   import com.ankamagames.berilia.managers.UiGroupManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.managers.UiRenderManager;
   import com.ankamagames.berilia.types.BeriliaOptions;
   import com.ankamagames.berilia.types.data.LinkedCursorData;
   import com.ankamagames.berilia.types.data.UiData;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.event.UiRenderAskEvent;
   import com.ankamagames.berilia.types.event.UiRenderEvent;
   import com.ankamagames.berilia.types.event.UiUnloadEvent;
   import com.ankamagames.berilia.types.graphic.ChatTextContainer;
   import com.ankamagames.berilia.types.graphic.ExternalUi;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.TimeoutHTMLLoader;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.EmbedIcons;
   import com.ankamagames.berilia.utils.errors.BeriliaError;
   import com.ankamagames.jerakine.enum.OperatingSystem;
   import com.ankamagames.jerakine.handlers.HumanInputHandler;
   import com.ankamagames.jerakine.interfaces.IInterfaceListener;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.ErrorManager;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.messages.MessageHandler;
   import com.ankamagames.jerakine.types.DynamicSecureObject;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManager;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.errors.SingletonError;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import com.ankamagames.jerakine.utils.system.SystemManager;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.text.TextField;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class Berilia extends EventDispatcher
   {
      
      private static var _self:Berilia;
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(Berilia));
      
      public static var _uiCache:Dictionary = new Dictionary();
      
      public static var embedIcons:Class = EmbedIcons;
       
      
      private var _UISoundListeners:Array;
      
      private var _bOptions:BeriliaOptions;
      
      private var _uiSavedModificationPresetName:String = "default";
      
      private var _docMain:Sprite;
      
      private var _aUiList:Dictionary;
      
      private var _highestModalDepth:int;
      
      private var _aContainerList:Array;
      
      private var _autoReloadUiOnChange:Boolean;
      
      private var _docStrataWorld:Sprite;
      
      private var _docStrataLow:Sprite;
      
      private var _docStrataMedium:Sprite;
      
      private var _docStrataHigh:Sprite;
      
      private var _docStrataTop:Sprite;
      
      private var _docStrataTooltip:Sprite;
      
      private var _docStrataSuperTooltip:Sprite;
      
      private var _docStrataMax:Sprite;
      
      private var _docStrataSuperMax:Sprite;
      
      private var _handler:MessageHandler;
      
      private var _aLoadingUi:Array;
      
      private var _globalScale:Number = 1;
      
      private var _verboseException:Boolean = false;
      
      public var hidenActiveUIs:Vector.<String>;
      
      private var _autoReloadUiManagers:Dictionary;
      
      public function Berilia()
      {
         this._UISoundListeners = new Array();
         this._autoReloadUiManagers = new Dictionary();
         super();
         if(_self != null)
         {
            throw new SingletonError("Berilia is a singleton and should not be instanciated directly.");
         }
      }
      
      public static function getInstance() : Berilia
      {
         if(_self == null)
         {
            _self = new Berilia();
         }
         return _self;
      }
      
      public function get uiSavedModificationPresetName() : String
      {
         return !!this._uiSavedModificationPresetName ? this._uiSavedModificationPresetName : "default";
      }
      
      public function set uiSavedModificationPresetName(value:String) : void
      {
         if(this._uiSavedModificationPresetName != value)
         {
            this.resetUiSavedUserModification(null,false,!!value ? value : "default");
         }
      }
      
      public function get autoReloadUiOnChange() : Boolean
      {
         return this._autoReloadUiOnChange;
      }
      
      public function set autoReloadUiOnChange(value:Boolean) : void
      {
         var urc:UiRootContainer = null;
         var arm:AutoReloadUiManager = null;
         var hasChanged:* = value != this._autoReloadUiOnChange;
         this._autoReloadUiOnChange = value;
         if(hasChanged)
         {
            if(this._autoReloadUiOnChange)
            {
               for each(urc in this._aUiList)
               {
                  if(!this._autoReloadUiManagers[urc.uiData])
                  {
                     this._autoReloadUiManagers[urc.uiData] = new AutoReloadUiManager(urc.uiData);
                  }
               }
            }
            else
            {
               for each(arm in this._autoReloadUiManagers)
               {
                  AutoReloadUiManager(arm).destroy();
               }
               this._autoReloadUiManagers = new Dictionary();
            }
         }
      }
      
      public function get handler() : MessageHandler
      {
         return this._handler;
      }
      
      public function set handler(value:MessageHandler) : void
      {
         this._handler = value;
      }
      
      public function get docMain() : Sprite
      {
         return this._docMain;
      }
      
      public function get uiList() : Dictionary
      {
         return this._aUiList;
      }
      
      public function get highestModalDepth() : int
      {
         return this._highestModalDepth;
      }
      
      public function get containerList() : Array
      {
         return this._aContainerList;
      }
      
      public function get strataLow() : DisplayObjectContainer
      {
         return this._docStrataLow;
      }
      
      public function get strataMedium() : DisplayObjectContainer
      {
         return this._docStrataMedium;
      }
      
      public function get strataHigh() : DisplayObjectContainer
      {
         return this._docStrataHigh;
      }
      
      public function get strataTop() : DisplayObjectContainer
      {
         return this._docStrataTop;
      }
      
      public function get strataTooltip() : DisplayObjectContainer
      {
         return this._docStrataTooltip;
      }
      
      public function get strataSuperTooltip() : DisplayObjectContainer
      {
         return this._docStrataSuperTooltip;
      }
      
      public function get strataMax() : DisplayObjectContainer
      {
         return this._docStrataMax;
      }
      
      public function get strataSuperMax() : DisplayObjectContainer
      {
         return this._docStrataSuperMax;
      }
      
      public function get loadingUi() : Array
      {
         return this._aLoadingUi;
      }
      
      public function get scale() : Number
      {
         return this._globalScale;
      }
      
      public function set scale(nScale:Number) : void
      {
         this._globalScale = nScale;
         this.updateUiScale();
      }
      
      public function get verboseException() : Boolean
      {
         return this._verboseException;
      }
      
      public function set verboseException(v:Boolean) : void
      {
         this._verboseException = v;
      }
      
      public function get UISoundListeners() : Array
      {
         return this._UISoundListeners;
      }
      
      public function get options() : BeriliaOptions
      {
         return this._bOptions;
      }
      
      public function setDisplayOptions(bopt:BeriliaOptions) : void
      {
         this._bOptions = bopt;
      }
      
      public function addUIListener(pListener:IInterfaceListener) : void
      {
         FpsManager.getInstance().startTracking("ui",16525567);
         var index:int = this._UISoundListeners.indexOf(pListener);
         if(index == -1)
         {
            this._UISoundListeners.push(pListener);
         }
         FpsManager.getInstance().stopTracking("ui");
      }
      
      public function removeUIListener(pListener:IInterfaceListener) : void
      {
         FpsManager.getInstance().startTracking("ui",16525567);
         var index:int = this._UISoundListeners.indexOf(pListener);
         if(index >= 0)
         {
            this._UISoundListeners.splice(index,1);
         }
         FpsManager.getInstance().stopTracking("ui");
      }
      
      public function init(docContainer:Sprite) : void
      {
         this._docMain = docContainer;
         this._docMain.removeChildren();
         this._docMain.mouseEnabled = false;
         this._docStrataWorld = new Sprite();
         this._docStrataWorld.name = "strataWorld";
         this._docStrataLow = new Sprite();
         this._docStrataLow.name = "strataLow";
         this._docStrataMedium = new Sprite();
         this._docStrataMedium.name = "strataMedium";
         this._docStrataHigh = new Sprite();
         this._docStrataHigh.name = "strataHigh";
         this._docStrataTop = new Sprite();
         this._docStrataTop.name = "strataTop";
         this._docStrataTooltip = new Sprite();
         this._docStrataTooltip.name = "strataTooltip";
         this._docStrataSuperTooltip = new Sprite();
         this._docStrataSuperTooltip.name = "strataSuperTooltip";
         this._docStrataMax = new Sprite();
         this._docStrataMax.name = "strataMax";
         this._docStrataSuperMax = new Sprite();
         this._docStrataSuperMax.name = "strataSuperMax";
         this._docStrataWorld.mouseEnabled = false;
         this._docStrataLow.mouseEnabled = false;
         this._docStrataMedium.mouseEnabled = false;
         this._docStrataHigh.mouseEnabled = false;
         this._docStrataTop.mouseEnabled = false;
         this._docStrataTooltip.mouseChildren = false;
         this._docStrataTooltip.mouseEnabled = false;
         this._docStrataSuperTooltip.mouseChildren = false;
         this._docStrataSuperTooltip.mouseEnabled = false;
         this._docStrataMax.mouseEnabled = false;
         this._docStrataSuperMax.mouseChildren = false;
         this._docStrataSuperMax.mouseEnabled = false;
         this._docMain.addChild(this._docStrataWorld);
         this._docMain.addChild(this._docStrataLow);
         this._docMain.addChild(this._docStrataMedium);
         this._docMain.addChild(this._docStrataHigh);
         this._docMain.addChild(this._docStrataTop);
         this._docMain.addChild(this._docStrataTooltip);
         this._docMain.addChild(this._docStrataSuperTooltip);
         this._docMain.addChild(this._docStrataMax);
         this._docMain.addChild(this._docStrataSuperMax);
         this._aUiList = new Dictionary();
         this._aContainerList = new Array();
         this._aLoadingUi = new Array();
         this.hidenActiveUIs = new Vector.<String>();
         if(SystemManager.getSingleton().os == OperatingSystem.LINUX)
         {
            Label.HEIGHT_OFFSET = 1;
         }
      }
      
      public function reset() : void
      {
         var uiName:* = null;
         var tmpUiNameList:Vector.<String> = null;
         var n:* = null;
         var m:UiModule = null;
         var ui:UiRootContainer = null;
         TimeoutHTMLLoader.resetCache();
         FpsManager.getInstance().startTracking("ui",16525567);
         for(uiName in _uiCache)
         {
            ui = _uiCache[uiName];
            this._aUiList[uiName] = ui;
            ui.cached = false;
         }
         _uiCache = new Dictionary();
         tmpUiNameList = new Vector.<String>();
         for(n in this._aUiList)
         {
            tmpUiNameList.push(n);
         }
         for each(n in tmpUiNameList)
         {
            this.unloadUi(n);
         }
         for each(m in UiModuleManager.getInstance().getModules())
         {
            KernelEventsManager.getInstance().removeAllEventListeners("__module_" + m.id);
            BindsManager.getInstance().removeAllEventListeners("__module_" + m.id);
         }
         UiGroupManager.getInstance().destroy();
         FpsManager.getInstance().stopTracking("ui");
      }
      
      public function loadUi(uiModule:UiModule, uiData:UiData, sName:String, properties:* = null, bReplace:Boolean = false, nStrata:int = 1, hide:Boolean = false, cacheName:String = null, externalUi:Boolean = false, restoreSnapshot:Boolean = true, useCache:Boolean = true) : UiRootContainer
      {
         var container:UiRootContainer = null;
         var highestDepth:int = 0;
         var uiContainer:Sprite = null;
         var i:uint = 0;
         var t:int = 0;
         var eui:ExternalUi = null;
         FpsManager.getInstance().startTracking("ui",16525567);
         KernelEventsManager.getInstance().processCallback(BeriliaHookList.UiLoading,sName,uiData.name,properties);
         if(cacheName)
         {
            container = _uiCache[cacheName];
            if(container)
            {
               container.name = sName;
               container.strata = nStrata;
               container.restoreSnapshotAfterLoading = restoreSnapshot;
               highestDepth = int.MIN_VALUE;
               uiContainer = Sprite(this._docMain.getChildAt(nStrata + 1));
               for(i = 0; i < uiContainer.numChildren; i++)
               {
                  if(uiContainer.getChildAt(i) is UiRootContainer && UiRootContainer(uiContainer.getChildAt(i)).depth > highestDepth)
                  {
                     highestDepth = UiRootContainer(uiContainer.getChildAt(i)).depth;
                  }
               }
               if(highestDepth < 0)
               {
                  highestDepth = 0;
               }
               container.depth = nStrata * 10000 + highestDepth + 1;
               container.uiModule = uiModule;
               if(externalUi)
               {
                  new ExternalUi().uiRootContainer = container;
               }
               else
               {
                  DisplayObjectContainer(this._docMain.getChildAt(nStrata + 1)).addChild(container);
               }
               this._aUiList[sName] = container;
               try
               {
                  t = getTimer();
                  container.uiClass.main(properties);
                  if(container.uiClass.hasOwnProperty("hintsApi") && container.name.indexOf("tooltip_") == -1)
                  {
                     container.uiClass.hintsApi.showSubhintOnUiLoaded(container);
                  }
                  KernelEventsManager.getInstance().processCallback(BeriliaHookList.UiLoaded,sName);
               }
               catch(e:Error)
               {
                  ErrorManager.addError("Impossible d\'utiliser le cache d\'interface pour " + container.name + " du module " + (!!container.uiModule ? container.uiModule.id : "???"),e);
                  delete _uiCache[cacheName];
                  container.cached = false;
                  unloadUi(sName);
               }
               return null;
            }
         }
         container = new UiRootContainer(this._docMain.stage,uiData,Sprite(this._docMain.getChildAt(nStrata + 1)));
         container.name = sName;
         container.strata = nStrata;
         container.restoreSnapshotAfterLoading = restoreSnapshot;
         highestDepth = int.MIN_VALUE;
         uiContainer = Sprite(this._docMain.getChildAt(nStrata + 1));
         for(i = 0; i < uiContainer.numChildren; i++)
         {
            if(uiContainer.getChildAt(i) is UiRootContainer && UiRootContainer(uiContainer.getChildAt(i)).depth > highestDepth)
            {
               highestDepth = UiRootContainer(uiContainer.getChildAt(i)).depth;
            }
         }
         if(highestDepth < 0)
         {
            highestDepth = 0;
         }
         container.depth = nStrata * 10000 + highestDepth % 10000 + 1;
         container.uiModule = uiModule;
         if(cacheName)
         {
            container.cached = true;
            _uiCache[cacheName] = container;
         }
         if(!container.parent && !hide)
         {
            if(externalUi)
            {
               eui = new ExternalUi();
               eui.uiRootContainer = container;
            }
            else
            {
               DisplayObjectContainer(this._docMain.getChildAt(nStrata + 1)).addChild(container);
            }
         }
         this.loadUiInside(uiData,sName,container,null,properties,bReplace,useCache,false);
         FpsManager.getInstance().stopTracking("ui");
         return container;
      }
      
      public function giveFocus(container:UiRootContainer) : void
      {
         var onTop:Boolean = false;
         var ui:Object = null;
         if(container.strata == 1)
         {
            onTop = true;
            for each(ui in this._aUiList)
            {
               if(ui.visible && ui.depth > container.depth && ui.strata == 1)
               {
                  onTop = false;
               }
            }
            if(container.visible && onTop)
            {
               StageShareManager.stage.focus = container;
            }
         }
      }
      
      public function loadUiInside(uiData:UiData, sName:String, suiContainer:UiRootContainer, parent:GraphicContainer, properties:* = null, bReplace:Boolean = false, useCache:Boolean = true, loadingCallback:Boolean = true) : UiRootContainer
      {
         if(this._aLoadingUi[sName] && !bReplace)
         {
            return this._aUiList[sName];
         }
         if(!uiData)
         {
            return suiContainer;
         }
         if(loadingCallback)
         {
            KernelEventsManager.getInstance().processCallback(BeriliaHookList.UiLoading,sName,uiData.name,properties);
         }
         if(bReplace)
         {
            this.unloadUi(sName);
         }
         if(this.isRegisteredUiName(sName))
         {
            throw new BeriliaError(sName + " is already used by an other UI");
         }
         if(this._autoReloadUiOnChange && !this._autoReloadUiManagers[uiData])
         {
            this._autoReloadUiManagers[uiData] = new AutoReloadUiManager(uiData);
         }
         dispatchEvent(new UiRenderAskEvent(sName,uiData));
         suiContainer.name = sName;
         if(parent)
         {
            parent.getUi().childUiRoot = suiContainer;
            suiContainer.parentUiRoot = parent.getUi();
         }
         this._aLoadingUi[sName] = true;
         this._aUiList[sName] = suiContainer;
         suiContainer.addEventListener(UiRenderEvent.UIRenderComplete,this.onUiLoaded);
         UiRenderManager.getInstance().loadUi(uiData,suiContainer,properties,useCache);
         return suiContainer;
      }
      
      public function unloadUi(sName:String, forceUnload:Boolean = false) : Boolean
      {
         var ui:UiRootContainer = null;
         var j:Object = null;
         var linkCursor:LinkedCursorData = null;
         var currObj:Object = null;
         var i:Object = null;
         var topUi:Object = null;
         var varName:String = null;
         var holder:Object = null;
         var rootContainer:UiRootContainer = null;
         var u:Object = null;
         var startTimer:int = getTimer();
         FpsManager.getInstance().startTracking("ui",16525567);
         dispatchEvent(new UiUnloadEvent(UiUnloadEvent.UNLOAD_UI_STARTED,sName));
         ui = this._aUiList[sName];
         if(ui == null)
         {
            return false;
         }
         if(this._autoReloadUiManagers[ui.uiData])
         {
            AutoReloadUiManager(this._autoReloadUiManagers[ui.uiData]).destroy();
            delete this._autoReloadUiManagers[ui.uiData];
         }
         var obj:DynamicSecureObject = new DynamicSecureObject();
         obj.cancel = false;
         KernelEventsManager.getInstance().processCallback(BeriliaHookList.UiUnloading,sName,obj);
         if(!forceUnload && obj.cancel)
         {
            return false;
         }
         if(ui.ready)
         {
            ui.makeSnapshot();
         }
         if(ui.cached)
         {
            if(ui.parent)
            {
               ui.parent.removeChild(ui);
            }
            this.unloadUiEvents(sName,true);
            ui.hideAfterLoading = true;
            delete this._aUiList[sName];
            if(ui.uiClass && ui.uiClass.hasOwnProperty("hintsApi") && UiRootContainer(ui).name.indexOf("tooltip_") == -1)
            {
               ui.uiClass.hintsApi.closeSubHints();
            }
            if(ui.uiClass && ui.uiClass.hasOwnProperty("unload") && ui.uiClass.unload)
            {
               try
               {
                  ui.uiClass.unload();
               }
               catch(e:Error)
               {
                  ErrorManager.addError("Une erreur est survenu dans la fonction unload() de l\'interface " + ui.name + " du module " + (!!ui.uiModule ? ui.uiModule.id : "???"));
               }
            }
            if(ui.transmitFocus && (!StageShareManager.stage.focus || !(StageShareManager.stage.focus is TextField || StageShareManager.stage.focus is ChatTextContainer)))
            {
               StageShareManager.stage.focus = topUi == null ? StageShareManager.stage : InteractiveObject(topUi);
            }
            KernelEventsManager.getInstance().processCallback(BeriliaHookList.UiUnloaded,sName);
            return true;
         }
         ui.disableRender = true;
         this.deleteUiLoading(sName,ui);
         var doIt:DisplayObject = StageShareManager.stage.focus;
         while(doIt)
         {
            if(doIt is UiRootContainer && doIt == ui)
            {
               StageShareManager.stage.focus = null;
               break;
            }
            doIt = doIt.parent;
         }
         if(UiRootContainer(ui).uiClass)
         {
            if(Object(UiRootContainer(ui).uiClass).hasOwnProperty("hintsApi") && UiRootContainer(ui).name.indexOf("tooltip_") == -1)
            {
               Object(UiRootContainer(ui).uiClass).hintsApi.closeSubHints();
            }
            if(Object(UiRootContainer(ui).uiClass).hasOwnProperty("unload"))
            {
               UiRootContainer(ui).uiClass.unload();
            }
            for each(varName in DescribeTypeCache.getVariables(UiRootContainer(ui).uiClass,true,false))
            {
               if(UiRootContainer(ui).uiClass[varName] is Object)
               {
                  if(getQualifiedClassName(UiRootContainer(ui).uiClass[varName]).indexOf("Api") && UiRootContainer(ui).uiClass[varName] is Object && Object(UiRootContainer(ui).uiClass[varName]).hasOwnProperty("destroy"))
                  {
                     UiRootContainer(ui).uiClass[varName].destroy();
                  }
                  UiRootContainer(ui).uiClass[varName] = null;
               }
            }
            UiRootContainer(ui).uiClass = null;
         }
         for(j in UIEventManager.getInstance().instances)
         {
            if(j != "null" && UIEventManager.getInstance().instances[j].instance.getUi() == ui)
            {
               UIEventManager.getInstance().instances[j] = null;
               delete UIEventManager.getInstance().instances[j];
            }
         }
         linkCursor = LinkedCursorSpriteManager.getInstance().getItem("DragAndDrop");
         if(linkCursor && linkCursor.data.hasOwnProperty("currentHolder"))
         {
            holder = linkCursor.data.currentHolder;
            rootContainer = holder.getUi();
            if(rootContainer == ui)
            {
               LinkedCursorSpriteManager.getInstance().removeItem("DragAndDrop");
               HumanInputHandler.getInstance().resetClick();
            }
         }
         UiRootContainer(ui).remove();
         for(i in ui.getElements())
         {
            currObj = ui.getElements()[i];
            if(currObj is GraphicContainer)
            {
               this._aContainerList[currObj["name"]] = null;
               delete this._aContainerList[currObj["name"]];
            }
            delete ui.getElements()[i];
         }
         KernelEventsManager.getInstance().removeAllEventListeners(sName);
         BindsManager.getInstance().removeAllEventListeners(sName);
         UiRenderManager.getInstance().cancelRender(ui.uiData);
         SecureCenter.destroy(ui);
         ui.destroyUi();
         if(ApiBinder.getApiData("currentUi") == ui)
         {
            ApiBinder.removeApiData("currentUi");
         }
         UiRootContainer(ui).free();
         delete this._aUiList[sName];
         this.updateHighestModalDepth();
         topUi = null;
         if(ui.strata > 0 && ui.strata < 4)
         {
            for each(u in this._aUiList)
            {
               if(topUi == null)
               {
                  if(u.strata == 1 && u.visible)
                  {
                     topUi = u;
                  }
               }
               else if(u.depth > topUi.depth && u.strata == 1 && u.visible)
               {
                  topUi = u;
               }
            }
            if(!StageShareManager.stage.focus || ui.transmitFocus && !(StageShareManager.stage.focus is TextField || StageShareManager.stage.focus is ChatTextContainer))
            {
               StageShareManager.stage.focus = topUi == null ? StageShareManager.stage : InteractiveObject(topUi);
            }
         }
         FpsManager.getInstance().stopTracking("ui");
         KernelEventsManager.getInstance().processCallback(BeriliaHookList.UiUnloaded,sName);
         dispatchEvent(new UiUnloadEvent(UiUnloadEvent.UNLOAD_UI_COMPLETE,sName));
         var stopTimer:int = getTimer();
         if(sName.indexOf("tooltip_") == -1)
         {
            _log.info(sName + " correctly unloaded in " + (stopTimer - startTimer) + "ms");
         }
         return true;
      }
      
      public function unloadUiEvents(sName:String, useCache:Boolean = false) : void
      {
         var currObj:Object = null;
         var i:* = null;
         var j:* = null;
         FpsManager.getInstance().startTracking("ui",16525567);
         if(this._aUiList[sName] == null)
         {
            return;
         }
         for(i in this._aUiList[sName].getElements())
         {
            currObj = this._aUiList[sName].getElements()[i];
            if(currObj is GraphicContainer)
            {
               this._aContainerList[currObj["name"]] = null;
               delete this._aContainerList[currObj["name"]];
            }
            if(!useCache)
            {
               this._aUiList[sName].getElements()[i] = null;
               delete this._aUiList[sName].getElements()[i];
            }
         }
         KernelEventsManager.getInstance().removeAllEventListeners(sName);
         BindsManager.getInstance().removeAllEventListeners(sName);
         for(j in UIEventManager.getInstance().instances)
         {
            if((j != null || j != "null") && UIEventManager.getInstance().instances[j] && UIEventManager.getInstance().instances[j].instance && UIEventManager.getInstance().instances[j].instance.topParent && UIEventManager.getInstance().instances[j].instance.topParent.name == sName)
            {
               if(UIEventManager.getInstance().instances[j].instance.topParent.name == sName)
               {
                  UIEventManager.getInstance().instances[j] = null;
                  delete UIEventManager.getInstance().instances[j];
               }
            }
         }
         FpsManager.getInstance().stopTracking("ui");
      }
      
      public function getUi(sName:String) : UiRootContainer
      {
         return this._aUiList[sName];
      }
      
      public function setUiOnTop(target:UiRootContainer) : void
      {
         var i:uint = 0;
         var highestDepth:int = target.depth;
         if(target.parent)
         {
            for(i = 0; i < target.parent.numChildren; i++)
            {
               if(target.parent.getChildAt(i) is UiRootContainer && UiRootContainer(target.parent.getChildAt(i)).depth > highestDepth)
               {
                  highestDepth = UiRootContainer(target.parent.getChildAt(i)).depth;
               }
            }
            target.depth = target.strata * 10000 + highestDepth % 10000 + 1;
            target.setOnTop();
         }
      }
      
      public function setUiStrata(uiName:String, strata:int) : void
      {
         var highestDepth:int = 0;
         var uiContainer:Sprite = null;
         var i:uint = 0;
         var container:UiRootContainer = this._aUiList[uiName];
         if(container && container.strata != strata)
         {
            container.strata = strata;
            highestDepth = int.MIN_VALUE;
            uiContainer = Sprite(this._docMain.getChildAt(strata + 1));
            for(i = 0; i < uiContainer.numChildren; i++)
            {
               if(uiContainer.getChildAt(i) is UiRootContainer && UiRootContainer(uiContainer.getChildAt(i)).depth > highestDepth)
               {
                  highestDepth = UiRootContainer(uiContainer.getChildAt(i)).depth;
               }
            }
            if(highestDepth < 0)
            {
               highestDepth = 0;
            }
            container.depth = strata * 10000 + highestDepth + 1;
            if(!container.windowOwner)
            {
               DisplayObjectContainer(this._docMain.getChildAt(strata + 1)).addChild(container);
            }
            KernelEventsManager.getInstance().processCallback(BeriliaHookList.StrataUpdate,uiName,strata);
         }
      }
      
      public function isUiDisplayed(sName:String) : Boolean
      {
         return this._aUiList[sName] != null;
      }
      
      public function getHud() : Array
      {
         var res:Array = [];
         res.push(this.getUi("banner"));
         res.push(this.getUi("bannerMenu"));
         res.push(this.getUi("bannerMap"));
         res.push(this.getUi("chat"));
         res.push(this.getUi("mapInfo"));
         res.push(this.getUi("questList"));
         res.push(this.getUi("questListMinimized"));
         return res;
      }
      
      public function updateUiRender() : void
      {
         var i:* = null;
         for(i in this.uiList)
         {
            UiRootContainer(this.uiList[i]).render();
         }
      }
      
      public function updateUiScale() : void
      {
         var ui:UiRootContainer = null;
         var i:* = null;
         for(i in this.uiList)
         {
            ui = UiRootContainer(this.uiList[i]);
            if(ui.scalable)
            {
               ui.scale = this.scale;
               ui.render();
            }
         }
      }
      
      public function isRegisteredContainerId(sName:String) : Boolean
      {
         return this._aContainerList[sName] != null;
      }
      
      public function registerContainerId(sName:String, doc:DisplayObjectContainer) : Boolean
      {
         if(this.isRegisteredContainerId(sName))
         {
            return false;
         }
         this._aContainerList[sName] = doc;
         return true;
      }
      
      public function resetUiSavedUserModification(specifiedUiName:String = null, deleteInfo:Boolean = true, newPresetName:String = null) : void
      {
         var context:String = null;
         var uiName:* = null;
         var cptName:String = null;
         var componentRef:String = null;
         var tmp:Array = null;
         var ui:UiRootContainer = null;
         var cptKey:String = null;
         var gcKey:* = null;
         var dim:Point = null;
         var pos:Point = null;
         var uiRef:Dictionary = new Dictionary();
         var cptDone:Dictionary = new Dictionary();
         var cptToUpdate:Dictionary = new Dictionary();
         var componentRefList:Array = StoreDataManager.getInstance().getKeys(BeriliaConstants.DATASTORE_UI_POSITIONS);
         for each(componentRef in componentRefList)
         {
            if(!specifiedUiName || componentRef.indexOf(specifiedUiName + "##") == 0)
            {
               tmp = componentRef.split("##");
               uiName = tmp[0];
               cptName = tmp[2];
               context = tmp[3];
               ui = this.getUi(uiName);
               cptKey = uiName + "_" + cptName;
               if(ui && context != this.uiSavedModificationPresetName)
               {
                  if(context == newPresetName && uiName.length)
                  {
                     cptToUpdate[cptKey] = ui.getElement(cptName);
                     uiRef[uiName] = true;
                  }
               }
               else
               {
                  if(!cptDone[cptKey] && ui && ui.getElement(cptName))
                  {
                     cptDone[cptKey] = true;
                     cptToUpdate[cptKey] = ui.getElement(cptName);
                     ui.getElement(cptName).resetSavedInformations(deleteInfo);
                  }
                  uiRef[uiName] = true;
                  if(deleteInfo)
                  {
                     StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_POSITIONS,componentRef,null);
                  }
               }
            }
         }
         if(!specifiedUiName && deleteInfo)
         {
            StoreDataManager.getInstance().clear(BeriliaConstants.DATASTORE_UI_POSITIONS);
         }
         if(newPresetName)
         {
            this._uiSavedModificationPresetName = newPresetName;
            for(gcKey in cptToUpdate)
            {
               if(cptToUpdate[gcKey])
               {
                  dim = cptToUpdate[gcKey].getSavedDimension();
                  if(dim)
                  {
                     cptToUpdate[gcKey].widthNoCache = dim.x;
                     cptToUpdate[gcKey].heightNoCache = dim.y;
                  }
                  pos = cptToUpdate[gcKey].getSavedPosition();
                  if(pos)
                  {
                     cptToUpdate[gcKey].xNoCache = pos.x;
                     cptToUpdate[gcKey].yNoCache = pos.y;
                  }
               }
            }
         }
         for(uiName in uiRef)
         {
            if(this.getUi(uiName))
            {
               this.getUi(uiName).resetSizeAndPosition();
               this.getUi(uiName).render();
               this.getUi(uiName).render();
            }
         }
      }
      
      private function onUiLoaded(ure:UiRenderEvent) : void
      {
         this.deleteUiLoading(ure.uiTarget.name,ure.uiTarget);
         this.updateHighestModalDepth();
         dispatchEvent(ure);
         if(ure.uiTarget.uiClass && ure.uiTarget.uiClass.hasOwnProperty("hintsApi") && ure.uiTarget.name.indexOf("tooltip_") == -1)
         {
            ure.uiTarget.uiClass.hintsApi.showSubhintOnUiLoaded(ure.uiTarget);
         }
         KernelEventsManager.getInstance().processCallback(BeriliaHookList.UiLoaded,ure.uiTarget.name);
      }
      
      private function updateHighestModalDepth() : void
      {
         var uiContainer:UiRootContainer = null;
         this._highestModalDepth = -1;
         for each(uiContainer in this._aUiList)
         {
            if(uiContainer.modal && this._highestModalDepth < uiContainer.depth)
            {
               this._highestModalDepth = uiContainer.depth;
            }
         }
      }
      
      private function deleteUiLoading(name:String, ui:UiRootContainer) : void
      {
         delete this._aLoadingUi[name];
         if(this._aLoadingUi.length == 0)
         {
            ui.removeEventListener(UiRenderEvent.UIRenderComplete,this.onUiLoaded);
         }
      }
      
      private function isRegisteredUiName(sName:String) : Boolean
      {
         return this._aUiList[sName] != null;
      }
   }
}
