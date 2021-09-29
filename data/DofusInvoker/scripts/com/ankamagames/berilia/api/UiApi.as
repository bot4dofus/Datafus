package com.ankamagames.berilia.api
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.BeriliaConstants;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.EventEnums;
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.interfaces.IRadioItem;
   import com.ankamagames.berilia.managers.BindsManager;
   import com.ankamagames.berilia.managers.CssManager;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UIEventManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.LinkedCursorData;
   import com.ankamagames.berilia.types.data.RadioGroup;
   import com.ankamagames.berilia.types.data.SlotDragAndDropData;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.berilia.types.data.TreeData;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.event.InstanceEvent;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.GraphicSize;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.types.listener.GenericListener;
   import com.ankamagames.berilia.types.shortcut.Shortcut;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   import com.ankamagames.berilia.types.tooltip.TooltipPlacer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.errors.ApiError;
   import com.ankamagames.berilia.utils.errors.BeriliaError;
   import com.ankamagames.jerakine.data.I18n;
   import com.ankamagames.jerakine.handlers.FocusHandler;
   import com.ankamagames.jerakine.handlers.HumanInputHandler;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.managers.StoreDataManager;
   import com.ankamagames.jerakine.types.ARGBColor;
   import com.ankamagames.jerakine.types.Color;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.display.KeyPoll;
   import com.ankamagames.jerakine.utils.display.Rectangle2;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.memory.WeakReference;
   import com.ankamagames.jerakine.utils.misc.CallWithParameters;
   import com.ankamagames.jerakine.utils.pattern.PatternDecoder;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Stage;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.StyleSheet;
   import flash.utils.Dictionary;
   import flash.utils.getDefinitionByName;
   import flash.utils.getQualifiedClassName;
   
   [InstanciedApi]
   public class UiApi implements IApi
   {
      
      public static const _log:Logger = Log.getLogger(getQualifiedClassName(UiApi));
      
      private static var _label:Label;
      
      private static var _assetsDictionariesCount:int = 0;
      
      private static var _styleForTagName:StyleSheet;
       
      
      private var _module:UiModule;
      
      private var _currentUi:UiRootContainer;
      
      private var _assetUris:Dictionary;
      
      private var _assetUrisCount:int = 0;
      
      private var oldTextureUri:String;
      
      private var oldTextureBounds:Rectangle;
      
      public function UiApi()
      {
         this._assetUris = new Dictionary();
         this.oldTextureBounds = new Rectangle();
         super();
      }
      
      public static function get styleForTagName() : StyleSheet
      {
         if(!_styleForTagName)
         {
            _styleForTagName = new StyleSheet();
            _styleForTagName.setStyle(".nameStyle",{
               "fontFamily":"Roboto",
               "fontWeight":"regular",
               "color":"#ffffff"
            });
            _styleForTagName.setStyle(".tagStyle",{
               "fontFamily":"Roboto",
               "fontWeight":"lighter",
               "color":"#C7C7C5"
            });
            _styleForTagName.setStyle(".other",{
               "fontFamily":"Roboto",
               "fontWeight":"regular",
               "color":"#deff00"
            });
         }
         return _styleForTagName;
      }
      
      [ApiData(name="module")]
      public function set module(value:UiModule) : void
      {
         this._module = value;
      }
      
      [ApiData(name="currentUi")]
      public function set currentUi(value:UiRootContainer) : void
      {
         this._currentUi = value;
      }
      
      public function destroy() : void
      {
         this._currentUi = null;
         this._module = null;
      }
      
      public function loadUi(name:String, instanceName:String = null, params:* = null, strata:uint = 1, cacheName:String = null, replace:Boolean = false, externalUi:Boolean = false, restoreSnapshot:Boolean = true) : UiRootContainer
      {
         var tmp:Array = null;
         var rootCtr:UiRootContainer = null;
         var mod:UiModule = this._module;
         var uiName:String = name;
         if(!this._module.uis[name])
         {
            if(name.indexOf("::") == -1)
            {
               throw new BeriliaError(name + " not found in module " + this._module.name);
            }
            tmp = name.split("::");
            mod = UiModuleManager.getInstance().getModule(tmp[0]);
            if(!mod)
            {
               throw new BeriliaError("Module [" + tmp[0] + "] does not exist");
            }
            uiName = tmp[1];
         }
         if(!instanceName)
         {
            instanceName = uiName;
         }
         if(mod.uis[uiName])
         {
            rootCtr = Berilia.getInstance().loadUi(mod,mod.uis[uiName],instanceName,params,replace,strata,false,cacheName,externalUi,restoreSnapshot);
            if(uiName != "tips" && uiName != "buffUi")
            {
               FocusHandler.getInstance().setFocus(rootCtr);
            }
            return rootCtr;
         }
         return null;
      }
      
      public function loadUiInside(name:String, container:GraphicContainer, instanceName:String = null, params:* = null) : UiRootContainer
      {
         var tmp:Array = null;
         var newContainer:UiRootContainer = null;
         var mod:UiModule = this._module;
         var uiName:String = name;
         if(!this._module.uis[name])
         {
            if(name.indexOf("::") == -1)
            {
               throw new BeriliaError(name + " not found in module " + this._module.name);
            }
            tmp = name.split("::");
            mod = UiModuleManager.getInstance().getModule(tmp[0]);
            if(!mod)
            {
               throw new BeriliaError("Module [" + tmp[0] + "] does not exist");
            }
            uiName = tmp[1];
         }
         if(!instanceName)
         {
            instanceName = uiName;
         }
         if(mod.uis[uiName])
         {
            newContainer = new UiRootContainer(StageShareManager.stage,mod.uis[uiName]);
            newContainer.uiModule = mod;
            newContainer.strata = container.getUi().strata;
            newContainer.restoreSnapshotAfterLoading = container.getUi().restoreSnapshotAfterLoading;
            newContainer.depth = container.getUi().depth + 1;
            Berilia.getInstance().loadUiInside(mod.uis[uiName],instanceName,newContainer,container.getUi(),params,false);
            container.addChild(newContainer);
            return newContainer;
         }
         return null;
      }
      
      public function unloadUi(instanceName:String = null) : void
      {
         if(this._assetUrisCount > 0)
         {
            this._assetUris = new Dictionary();
            this._assetUrisCount = 0;
            --_assetsDictionariesCount;
         }
         Berilia.getInstance().unloadUi(instanceName);
      }
      
      public function getUi(instanceName:String) : UiRootContainer
      {
         var sui:UiRootContainer = Berilia.getInstance().getUi(instanceName);
         if(!sui)
         {
            return null;
         }
         return sui;
      }
      
      public function UiIsHiden(uiName:String) : Boolean
      {
         if(Berilia.getInstance().hidenActiveUIs.indexOf(uiName) != -1)
         {
            return true;
         }
         return false;
      }
      
      public function getUiByName(uiName:String) : *
      {
         var key:* = undefined;
         for(key in Berilia.getInstance().uiList)
         {
            if((Berilia.getInstance().uiList[key] as UiRootContainer).uiData.name == uiName)
            {
               return Berilia.getInstance().uiList[key];
            }
         }
         return null;
      }
      
      public function setUiStrata(uiName:String, strata:int) : void
      {
         Berilia.getInstance().setUiStrata(uiName,strata);
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
      
      public function getModule(moduleName:String) : UiModule
      {
         return UiModuleManager.getInstance().getModule(moduleName);
      }
      
      public function addChild(target:DisplayObjectContainer, child:DisplayObject) : void
      {
         target.addChild(child);
      }
      
      public function removeChild(target:DisplayObjectContainer, child:DisplayObject) : void
      {
         if(target.getChildByName(child.name))
         {
            target.removeChild(child);
         }
      }
      
      public function addChildAt(target:DisplayObjectContainer, child:DisplayObject, index:int) : void
      {
         target.addChildAt(child,index);
      }
      
      public function me() : UiRootContainer
      {
         return this._currentUi;
      }
      
      public function initDefaultBinds() : void
      {
         BindsManager.getInstance();
      }
      
      public function addShortcutHook(shortcutName:String, hook:Function, pPriority:* = false) : void
      {
         var priority:int = 0;
         var targetedShortcut:Shortcut = Shortcut.getShortcutByName(shortcutName);
         if(!targetedShortcut && shortcutName != "ALL")
         {
            throw new ApiError("Shortcut [" + shortcutName + "] does not exist");
         }
         if(pPriority is Boolean)
         {
            priority = !!pPriority ? 1 : (!!this._currentUi ? int(this._currentUi.depth) : 0);
         }
         else if(pPriority is int)
         {
            priority = pPriority;
         }
         var listener:GenericListener = new GenericListener(shortcutName,!!this._currentUi ? this._currentUi.name : "__module_" + this._module.id,hook,priority,!!this._currentUi ? uint(GenericListener.LISTENER_TYPE_UI) : uint(GenericListener.LISTENER_TYPE_MODULE),!!this._currentUi ? new WeakReference(this._currentUi) : null);
         BindsManager.getInstance().registerEvent(listener);
      }
      
      public function addComponentHook(target:GraphicContainer, hookName:String) : void
      {
         var ie:InstanceEvent = null;
         var eventMsg:String = this.getEventClassName(hookName);
         if(!eventMsg)
         {
            throw new ApiError("Hook [" + hookName + "] does not exist");
         }
         if(!UIEventManager.getInstance().instances[target])
         {
            ie = new InstanceEvent(target,this._currentUi.uiClass);
            UIEventManager.getInstance().registerInstance(ie);
         }
         else
         {
            ie = UIEventManager.getInstance().instances[target];
         }
         ie.events[eventMsg] = eventMsg;
      }
      
      public function removeComponentHook(target:GraphicContainer, hookName:String) : void
      {
         var eventMsg:String = this.getEventClassName(hookName);
         if(!eventMsg)
         {
            throw new ApiError("Hook [" + hookName + "] does not exist");
         }
         var ie:InstanceEvent = UIEventManager.getInstance().instances[target];
         if(ie && ie.events && ie.events[eventMsg])
         {
            delete ie.events[eventMsg];
         }
      }
      
      public function resetUiSavedUserModification(name:String = null) : void
      {
         Berilia.getInstance().resetUiSavedUserModification(name);
      }
      
      public function createComponent(type:String, ... params) : GraphicContainer
      {
         return CallWithParameters.callConstructor(getDefinitionByName("com.ankamagames.berilia.components::" + type) as Class,params);
      }
      
      public function createContainer(type:String, ... params) : *
      {
         return CallWithParameters.callConstructor(getDefinitionByName("com.ankamagames.berilia.types.graphic::" + type) as Class,params);
      }
      
      public function getEventClassName(event:String) : String
      {
         switch(event)
         {
            case EventEnums.EVENT_ONPRESS:
               return EventEnums.EVENT_ONPRESS_MSG;
            case EventEnums.EVENT_ONRELEASE:
               return EventEnums.EVENT_ONRELEASE_MSG;
            case EventEnums.EVENT_ONROLLOUT:
               return EventEnums.EVENT_ONROLLOUT_MSG;
            case EventEnums.EVENT_ONROLLOVER:
               return EventEnums.EVENT_ONROLLOVER_MSG;
            case EventEnums.EVENT_ONRELEASEOUTSIDE:
               return EventEnums.EVENT_ONRELEASEOUTSIDE_MSG;
            case EventEnums.EVENT_ONDOUBLECLICK:
               return EventEnums.EVENT_ONDOUBLECLICK_MSG;
            case EventEnums.EVENT_ONRIGHTCLICK:
               return EventEnums.EVENT_ONRIGHTCLICK_MSG;
            case EventEnums.EVENT_ONTEXTCLICK:
               return EventEnums.EVENT_ONTEXTCLICK_MSG;
            case EventEnums.EVENT_ONCOLORCHANGE:
               return EventEnums.EVENT_ONCOLORCHANGE_MSG;
            case EventEnums.EVENT_ONENTITYREADY:
               return EventEnums.EVENT_ONENTITYREADY_MSG;
            case EventEnums.EVENT_ONSELECTITEM:
               return EventEnums.EVENT_ONSELECTITEM_MSG;
            case EventEnums.EVENT_ONSELECTEMPTYITEM:
               return EventEnums.EVENT_ONSELECTEMPTYITEM_MSG;
            case EventEnums.EVENT_ONCREATETAB:
               return EventEnums.EVENT_ONCREATETAB_MSG;
            case EventEnums.EVENT_ONDELETETAB:
               return EventEnums.EVENT_ONDELETETAB_MSG;
            case EventEnums.EVENT_ONRENAMETAB:
               return EventEnums.EVENT_ONRENAMETAB_MSG;
            case EventEnums.EVENT_ONITEMROLLOUT:
               return EventEnums.EVENT_ONITEMROLLOUT_MSG;
            case EventEnums.EVENT_ONITEMROLLOVER:
               return EventEnums.EVENT_ONITEMROLLOVER_MSG;
            case EventEnums.EVENT_ONITEMRIGHTCLICK:
               return EventEnums.EVENT_ONITEMRIGHTCLICK_MSG;
            case EventEnums.EVENT_ONDROP:
               return EventEnums.EVENT_ONDROP_MSG;
            case EventEnums.EVENT_ONTEXTUREREADY:
               return EventEnums.EVENT_ONTEXTUREREADY_MSG;
            case EventEnums.EVENT_ONTEXTURELOADFAIL:
               return EventEnums.EVENT_ONTEXTURELOADFAIL_MSG;
            case EventEnums.EVENT_ONMAPELEMENTROLLOUT:
               return EventEnums.EVENT_ONMAPELEMENTROLLOUT_MSG;
            case EventEnums.EVENT_ONMAPELEMENTROLLOVER:
               return EventEnums.EVENT_ONMAPELEMENTROLLOVER_MSG;
            case EventEnums.EVENT_ONMAPELEMENTRIGHTCLICK:
               return EventEnums.EVENT_ONMAPELEMENTRIGHTCLICK_MSG;
            case EventEnums.EVENT_ONMAPMOVE:
               return EventEnums.EVENT_ONMAPMOVE_MSG;
            case EventEnums.EVENT_ONMAPROLLOVER:
               return EventEnums.EVENT_ONMAPROLLOVER_MSG;
            case EventEnums.EVENT_ONMAPROLLOUT:
               return EventEnums.EVENT_ONMAPROLLOUT_MSG;
            case EventEnums.EVENT_ONVIDEOCONNECTFAILED:
               return EventEnums.EVENT_ONVIDEOCONNECTFAILED_MSG;
            case EventEnums.EVENT_ONVIDEOCONNECTSUCCESS:
               return EventEnums.EVENT_ONVIDEOCONNECTSUCCESS_MSG;
            case EventEnums.EVENT_ONVIDEOBUFFERCHANGE:
               return EventEnums.EVENT_ONVIDEOBUFFERCHANGE_MSG;
            case EventEnums.EVENT_ONCOMPONENTREADY:
               return EventEnums.EVENT_ONCOMPONENTREADY_MSG;
            case EventEnums.EVENT_ONWHEEL:
               return EventEnums.EVENT_ONWHEEL_MSG;
            case EventEnums.EVENT_ONMOUSEUP:
               return EventEnums.EVENT_ONMOUSEUP_MSG;
            case EventEnums.EVENT_ONCHANGE:
               return EventEnums.EVENT_ONCHANGE_MSG;
            case EventEnums.EVENT_ONBROWSER_SESSION_TIMEOUT:
               return EventEnums.EVENT_ONBROWSER_SESSION_TIMEOUT_MSG;
            case EventEnums.EVENT_ONBROWSER_DOM_READY:
               return EventEnums.EVENT_ONBROWSER_DOM_READY_MSG;
            case EventEnums.EVENT_ONBROWSER_DOM_CHANGE:
               return EventEnums.EVENT_ONBROWSER_DOM_CHANGE_MSG;
            case EventEnums.EVENT_MIDDLECLICK:
               return EventEnums.EVENT_MIDDLECLICK_MSG;
            default:
               return null;
         }
      }
      
      public function clearPositionCache(instanceName:String = null) : void
      {
         if(instanceName == null)
         {
            StoreDataManager.getInstance().clear(BeriliaConstants.DATASTORE_UI_POSITIONS);
         }
         else
         {
            StoreDataManager.getInstance().setData(BeriliaConstants.DATASTORE_UI_POSITIONS,instanceName,null);
         }
      }
      
      [NoBoxing]
      public function createUri(uri:String, force:Boolean = false) : Uri
      {
         if(!this._assetUris[uri] || force)
         {
            if(uri && uri.indexOf(":") == -1 && uri.indexOf("./") != 0 && uri.indexOf("\\\\") != 0 && uri.indexOf("//") != 0)
            {
               uri = "mod://" + this._module.id + "/" + uri;
            }
            this._assetUris[uri] = new Uri(uri);
            ++this._assetUrisCount;
            if(this._assetUrisCount == 1)
            {
               ++_assetsDictionariesCount;
            }
         }
         return this._assetUris[uri];
      }
      
      public function showTooltip(data:*, target:*, autoHide:Boolean = false, name:String = "standard", point:uint = 0, relativePoint:uint = 2, offset:* = 3, tooltipMaker:String = null, script:Class = null, makerParam:Object = null, cacheName:String = null, mouseEnabled:Boolean = false, strata:int = 4, zoom:Number = 1, uiModuleName:String = "", showDirectionalArrow:Boolean = false, container:UiRootContainer = null) : void
      {
         var tt:Tooltip = null;
         if((!makerParam || !makerParam.hasOwnProperty("pinnable") || !makerParam.pinnable) && (!makerParam || !makerParam.hasOwnProperty("displayWhenMouseDown") || !makerParam.displayWhenMouseDown) && HumanInputHandler.getInstance().isMouseDown)
         {
            return;
         }
         if(uiModuleName || this._currentUi)
         {
            tt = TooltipManager.show(data,target,this._module,autoHide,name,point,relativePoint,offset,true,tooltipMaker,script,makerParam,cacheName,mouseEnabled,strata,zoom,true,showDirectionalArrow,container);
            if(tt)
            {
               if(uiModuleName)
               {
                  tt.uiModuleName = uiModuleName;
               }
               else if(this._currentUi)
               {
                  tt.uiModuleName = this._currentUi.name;
               }
            }
         }
      }
      
      public function hideTooltip(name:String = null) : void
      {
         TooltipManager.hide(name);
      }
      
      public function textTooltipInfo(content:String, css:String = null, cssClass:String = null, maxWidth:int = 400) : TextTooltipInfo
      {
         return new TextTooltipInfo(content,css,cssClass,maxWidth);
      }
      
      public function getRadioGroupSelectedItem(rgName:String, me:UiRootContainer) : IRadioItem
      {
         var rg:RadioGroup = me.getRadioGroup(rgName);
         return rg.selectedItem;
      }
      
      public function setRadioGroupSelectedItem(rgName:String, item:IRadioItem, me:UiRootContainer) : void
      {
         var rg:RadioGroup = me.getRadioGroup(rgName);
         rg.selectedItem = item;
      }
      
      public function keyIsDown(keyCode:uint) : Boolean
      {
         return KeyPoll.getInstance().isDown(keyCode);
      }
      
      public function keyIsUp(keyCode:uint) : Boolean
      {
         return KeyPoll.getInstance().isUp(keyCode);
      }
      
      [NoBoxing]
      public function convertToTreeData(array:*) : Vector.<TreeData>
      {
         return TreeData.fromArray(array);
      }
      
      public function setFollowCursorUri(uri:*, lockX:Boolean = false, lockY:Boolean = false, xOffset:int = 0, yOffset:int = 0, scale:Number = 1) : void
      {
         var cd:LinkedCursorData = null;
         if(uri)
         {
            cd = new LinkedCursorData();
            cd.sprite = new Texture();
            Texture(cd.sprite).uri = uri is String ? new Uri(uri) : uri;
            cd.sprite.scaleX = scale;
            cd.sprite.scaleY = scale;
            Texture(cd.sprite).finalize();
            cd.lockX = lockX;
            cd.lockY = lockY;
            cd.offset = new Point(xOffset,yOffset);
            LinkedCursorSpriteManager.getInstance().addItem("customUserCursor",cd);
         }
         else
         {
            LinkedCursorSpriteManager.getInstance().removeItem("customUserCursor");
         }
      }
      
      public function getFollowCursorUri() : LinkedCursorData
      {
         return LinkedCursorSpriteManager.getInstance().getItem("customUserCursor");
      }
      
      public function endDrag() : void
      {
         var linkCursor:LinkedCursorData = LinkedCursorSpriteManager.getInstance().getItem("DragAndDrop");
         if(linkCursor && linkCursor.data is SlotDragAndDropData)
         {
            LinkedCursorSpriteManager.getInstance().removeItem("DragAndDrop");
            KernelEventsManager.getInstance().processCallback(BeriliaHookList.DropEnd,SlotDragAndDropData(linkCursor.data).currentHolder,null);
         }
      }
      
      public function preloadCss(url:String) : void
      {
         CssManager.getInstance().preloadCss(url);
      }
      
      public function setLabelStyleSheet(label:Label, cssUrl:String) : void
      {
         var styleSheet:StyleSheet = CssManager.getInstance().getCss(cssUrl);
         if(styleSheet)
         {
            label.setStyleSheet(styleSheet);
         }
         else
         {
            _log.error(cssUrl + " is not loaded yet!");
         }
      }
      
      public function getMouseX() : int
      {
         return StageShareManager.mouseX;
      }
      
      public function getMouseY() : int
      {
         return StageShareManager.mouseY;
      }
      
      public function getMouseDown() : Boolean
      {
         return HumanInputHandler.getInstance().isMouseDown;
      }
      
      public function getStartWidth() : int
      {
         return StageShareManager.startWidth;
      }
      
      public function getStartHeight() : int
      {
         return StageShareManager.startHeight;
      }
      
      public function getStageWidth() : int
      {
         return StageShareManager.stageVisibleBounds.width;
      }
      
      public function getStageHeight() : int
      {
         return StageShareManager.stageVisibleBounds.height;
      }
      
      public function getVisibleStageBounds() : Rectangle
      {
         return StageShareManager.stageVisibleBounds;
      }
      
      public function getWindowWidth() : int
      {
         return StageShareManager.stage.stageWidth;
      }
      
      public function getWindowHeight() : int
      {
         return StageShareManager.stage.stageHeight;
      }
      
      public function getStage() : Stage
      {
         return StageShareManager.stage;
      }
      
      public function getWindowScale() : Number
      {
         return StageShareManager.windowScale;
      }
      
      public function setFullScreen(enabled:Boolean, onlyMaximize:Boolean = false) : void
      {
         StageShareManager.setFullScreen(enabled,onlyMaximize);
      }
      
      public function isResetting() : Boolean
      {
         return UiModuleManager.getInstance().resetting;
      }
      
      private function getInitBounds(pTx:Texture) : Rectangle
      {
         var bg:MovieClip = null;
         if(this.oldTextureUri == null || pTx && pTx.uri && this.oldTextureUri != pTx.uri.toString())
         {
            if(!(pTx.child is DisplayObjectContainer))
            {
               return null;
            }
            bg = (pTx.child as DisplayObjectContainer).getChildByName("bg") as MovieClip;
            if(bg)
            {
               this.oldTextureBounds.width = bg.width;
               this.oldTextureBounds.height = bg.height;
               this.oldTextureUri = pTx.uri.toString();
            }
         }
         return this.oldTextureBounds;
      }
      
      public function place(relativeTo:IRectangle, relativePoint:uint, point:uint, pOffset:int, showDirectionalArrow:Boolean = false, placedComponent:GraphicContainer = null) : void
      {
         if(!relativeTo)
         {
            relativeTo = new Rectangle2(StageShareManager.mouseX,StageShareManager.mouseY,0,0);
         }
         if(!placedComponent)
         {
            placedComponent = this._currentUi;
         }
         TooltipPlacer.place(placedComponent,relativeTo,showDirectionalArrow,point,relativePoint,pOffset);
      }
      
      public function buildOrnamentTooltipFrom(pTexture:Texture, pTarget:Rectangle) : void
      {
         var omegaBottom:MovieClip = null;
         var bgBounds:Rectangle = null;
         var scaleX:Number = NaN;
         var scaleY:Number = NaN;
         var tmpPos:Rectangle = this.getInitBounds(pTexture);
         if(!tmpPos)
         {
            tmpPos = new Rectangle();
         }
         var source:DisplayObjectContainer = pTexture.child as DisplayObjectContainer;
         var bg:MovieClip = this.addPart("bg",source,pTarget,tmpPos.x,tmpPos.y) as MovieClip;
         if(bg)
         {
            bgBounds = bg.getBounds(bg);
            scaleX = (pTarget.width - bgBounds.left + (bgBounds.right - 160)) / bgBounds.width;
            scaleY = (pTarget.height - bgBounds.top + (bgBounds.bottom - 40)) / bgBounds.height;
            bg.x += -bgBounds.left * scaleX + bgBounds.left;
            bg.y += -bgBounds.top * scaleY + bgBounds.top;
            bg.scale9Grid = new Rectangle(80,20,1,1);
            bg.width = tmpPos.width * scaleX;
            bg.height = tmpPos.height * scaleY;
         }
         this.addPart("top",source,pTarget,pTarget.width / 2,0);
         this.addPart("picto",source,pTarget,pTarget.width / 2,0);
         this.addPart("right",source,pTarget,pTarget.width,pTarget.height / 2);
         this.addPart("bottom",source,pTarget,pTarget.width / 2,pTarget.height - 1);
         if(OptionManager.getOptionManager("dofus").getOption("showOmegaUnderOrnament"))
         {
            omegaBottom = this.addPart("omega_bottom",source,pTarget,pTarget.width / 2,pTarget.height - 1) as MovieClip;
         }
         if(omegaBottom)
         {
            omegaBottom.x -= omegaBottom.width / 2;
            omegaBottom.y -= omegaBottom.height / 2;
         }
         this.addPart("left",source,pTarget,0,pTarget.height / 2);
         this.addPart("kolizeum_rank_picto",source,pTarget,pTarget.width / 2,0);
         this.addPart("tx_kolizeum_rank",source,pTarget,pTarget.width / 2,0);
      }
      
      private function addPart(name:String, source:DisplayObjectContainer, target:Rectangle, x:int, y:int) : DisplayObject
      {
         if(!source)
         {
            return null;
         }
         var part:DisplayObject = source.getChildByName(name);
         if(part != null)
         {
            part.x = target.x + x;
            part.y = target.y + y;
         }
         return part;
      }
      
      public function getTextSize(pText:String, pCss:Uri, pCssClass:String) : Rectangle
      {
         if(!_label)
         {
            _label = this.createComponent("Label") as Label;
         }
         _label.css = pCss;
         _label.cssClass = pCssClass;
         _label.fixedWidth = false;
         _label.text = pText;
         return new Rectangle(0,0,_label.textWidth,_label.textHeight);
      }
      
      public function setComponentMinMaxSize(component:GraphicContainer, minSize:Point, maxSize:Point) : void
      {
         if(!component.minSize)
         {
            component.minSize = new GraphicSize();
         }
         component.minSize.x = minSize.x;
         component.minSize.y = minSize.y;
         if(!component.maxSize)
         {
            component.maxSize = new GraphicSize();
         }
         component.maxSize.x = maxSize.x;
         component.maxSize.y = maxSize.y;
      }
      
      public function isUiLoading(pUiName:String) : Boolean
      {
         return Berilia.getInstance().loadingUi[pUiName];
      }
      
      public function getColor(pColor:String) : Color
      {
         return pColor.length == 10 ? new ARGBColor(parseInt(pColor,16)) : new Color(parseInt(pColor,16));
      }
      
      public function replaceParams(text:String, params:Array, replace:String = "%") : String
      {
         return I18n.replaceParams(text,params,replace);
      }
      
      public function replaceKey(text:String) : String
      {
         return LangManager.getInstance().replaceKey(text,true);
      }
      
      public function getText(key:String, ... params) : String
      {
         return I18n.getUiText(key,params);
      }
      
      public function getTextFromKey(key:uint, replace:String = "%", ... params) : String
      {
         return I18n.getText(key,params,replace);
      }
      
      public function processText(str:String, gender:String, singular:Boolean = true, zero:Boolean = false) : String
      {
         return PatternDecoder.combine(str,gender,singular,zero);
      }
      
      public function decodeText(str:String, params:Array) : String
      {
         return PatternDecoder.decode(str,params);
      }
   }
}
