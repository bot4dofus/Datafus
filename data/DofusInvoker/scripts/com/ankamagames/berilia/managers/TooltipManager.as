package com.ankamagames.berilia.managers
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.components.params.TooltipProperties;
   import com.ankamagames.berilia.enums.StrataEnum;
   import com.ankamagames.berilia.factories.TooltipsFactory;
   import com.ankamagames.berilia.interfaces.IApplicationContainer;
   import com.ankamagames.berilia.types.data.UiData;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.event.UiRenderEvent;
   import com.ankamagames.berilia.types.event.UiUnloadEvent;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   import com.ankamagames.berilia.types.tooltip.TooltipPlacer;
   import com.ankamagames.berilia.types.tooltip.TooltipRectangle;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   import flash.utils.getTimer;
   
   public class TooltipManager
   {
      
      protected static var _log:Logger = Log.getLogger(getQualifiedClassName(TooltipManager));
      
      private static var _tooltips:Array = new Array();
      
      private static var _tooltipsStrata:Array = new Array();
      
      private static var _tooltipsDico:Dictionary = new Dictionary();
      
      private static const TOOLTIP_UI_NAME_PREFIX:String = "tooltip_";
      
      public static const TOOLTIP_STANDAR_NAME:String = "standard";
      
      public static var _tooltipCache:Dictionary = new Dictionary();
      
      public static var _tooltipCacheParam:Dictionary = new Dictionary();
      
      public static var defaultTooltipUiScript:Class;
      
      private static var _isInit:Boolean = false;
      
      private static var showStartTime:int;
       
      
      public function TooltipManager()
      {
         super();
      }
      
      public static function show(data:*, target:*, uiModule:UiModule, autoHide:Boolean = true, name:String = "standard", point:uint = 0, relativePoint:uint = 2, offset:* = 3, usePrefix:Boolean = true, tooltipMaker:String = null, script:Class = null, makerParam:Object = null, cacheName:String = null, mouseEnabled:Boolean = false, strata:int = 4, zoom:Number = 1, alwaysDisplayed:Boolean = true, showDirectionalArrow:Boolean = false, container:UiRootContainer = null) : Tooltip
      {
         var cacheNameInfo:Array = null;
         var tooltipCache:Tooltip = null;
         showStartTime = getTimer();
         if(!_isInit)
         {
            Berilia.getInstance().addEventListener(UiRenderEvent.UIRenderComplete,onUiRenderComplete);
            Berilia.getInstance().addEventListener(UiUnloadEvent.UNLOAD_UI_STARTED,onUiUnloadStarted);
            _isInit = true;
         }
         if(tooltipMaker == "itemName")
         {
            cacheName = null;
         }
         name = (!!usePrefix ? TOOLTIP_UI_NAME_PREFIX : "") + name;
         if(script == null)
         {
            script = defaultTooltipUiScript;
         }
         if(_tooltips[name])
         {
            hide(name);
         }
         if(cacheName)
         {
            cacheNameInfo = cacheName.split("#");
            if(_tooltipCache[cacheNameInfo[0]] && cacheNameInfo.length == 1 || _tooltipCache[cacheNameInfo[0]] && cacheNameInfo.length > 1 && _tooltipCacheParam[cacheNameInfo[0]] == cacheNameInfo[1])
            {
               tooltipCache = _tooltipCache[cacheNameInfo[0]] as Tooltip;
               _tooltips[name] = data;
               _tooltipsStrata[name] = tooltipCache.display.strata;
               Berilia.getInstance().uiList[name] = tooltipCache.display;
               if(container)
               {
                  container.getStrata(StrataEnum.STRATA_TOOLTIP).addChild(tooltipCache.display);
               }
               else
               {
                  DisplayObjectContainer(Berilia.getInstance().docMain.getChildAt(strata + 1)).addChild(tooltipCache.display);
               }
               if(tooltipCache != null && tooltipCache.display != null && tooltipCache.display.uiClass != null)
               {
                  tooltipCache.display.x = tooltipCache.display.y = 0;
                  tooltipCache.display.scaleX = tooltipCache.display.scaleY = zoom;
                  tooltipCache.display.uiClass.main(new TooltipProperties(tooltipCache,autoHide,getTargetRect(target),point,relativePoint,offset,data,makerParam,zoom,alwaysDisplayed,target,showDirectionalArrow));
               }
               return tooltipCache;
            }
         }
         var tt:Tooltip = TooltipsFactory.create(data,tooltipMaker,script,makerParam);
         if(!tt)
         {
            _log.error("Erreur lors du rendu du tooltip de " + data + " (" + getQualifiedClassName(data) + ")");
            return null;
         }
         if(uiModule)
         {
            tt.uiModuleName = uiModule.id;
         }
         _tooltips[name] = data;
         if(mouseEnabled)
         {
            strata = StrataEnum.STRATA_TOP;
         }
         tt.askTooltip(new Callback(onTooltipReady,tt,uiModule,name,data,target,autoHide,point,relativePoint,offset,cacheName,strata,makerParam,zoom,alwaysDisplayed,showDirectionalArrow,container));
         _tooltipsDico[name] = tt;
         return tt;
      }
      
      public static function hide(name:String = "standard") : void
      {
         var c:DisplayObject = null;
         if(name == null)
         {
            name = TOOLTIP_STANDAR_NAME;
         }
         if(name.indexOf(TOOLTIP_UI_NAME_PREFIX) == -1)
         {
            name = TOOLTIP_UI_NAME_PREFIX + name;
         }
         if(_tooltips[name])
         {
            if(Berilia.getInstance().getUi(name))
            {
               TooltipPlacer.removeTooltipPosition(Berilia.getInstance().getUi(name));
            }
            else
            {
               TooltipPlacer.removeTooltipPositionByName(name);
            }
            Berilia.getInstance().unloadUi(name);
            if(name == TOOLTIP_UI_NAME_PREFIX + TOOLTIP_STANDAR_NAME)
            {
               c = Berilia.getInstance().strataTooltip.getChildByName(name);
               if(c && c.parent && !Berilia.getInstance().getUi(name))
               {
                  c.parent.removeChild(c);
                  _log.warn("Had to remove an orphelan tooltip_standard...");
               }
            }
            delete _tooltips[name];
            delete _tooltipsDico[name];
         }
         else
         {
            TooltipPlacer.removeTooltipPositionByName(name);
         }
      }
      
      public static function getTooltipName(pTooltip:UiRootContainer) : String
      {
         var name:* = null;
         if(pTooltip.cached)
         {
            for(name in Berilia.getInstance().uiList)
            {
               if(Berilia.getInstance().uiList[name] == pTooltip)
               {
                  return name;
               }
            }
         }
         else
         {
            for(name in _tooltips)
            {
               if(_tooltipsDico[name] && _tooltipsDico[name].display == pTooltip)
               {
                  return name;
               }
            }
         }
         return null;
      }
      
      public static function hasCache(pCacheName:String) : Boolean
      {
         var tooltipCache:Tooltip = _tooltipCache[pCacheName.split("#")[0]] as Tooltip;
         return tooltipCache != null && tooltipCache.display != null && tooltipCache.display.uiClass != null;
      }
      
      public static function isVisible(name:String) : Boolean
      {
         if(name.indexOf(TOOLTIP_UI_NAME_PREFIX) == -1)
         {
            name = TOOLTIP_UI_NAME_PREFIX + name;
         }
         return _tooltips[name] != null;
      }
      
      public static function updateContent(ttCacheName:String, ttName:String, data:Object) : void
      {
         var tooltipCache:Tooltip = null;
         if(isVisible(ttName))
         {
            tooltipCache = _tooltipCache[ttCacheName] as Tooltip;
            if(tooltipCache)
            {
               tooltipCache.display.uiClass.updateContent(new TooltipProperties(tooltipCache,false,null,0,0,0,data,null));
            }
         }
      }
      
      public static function update(ttCacheName:String, params:Array) : void
      {
         var tooltipCache:Tooltip = _tooltipCache[ttCacheName] as Tooltip;
         if(tooltipCache)
         {
            tooltipCache.display.uiClass.update(params);
         }
      }
      
      public static function updatePosition(ttCacheName:String, ttName:String, target:*, point:uint, relativePoint:uint, offset:*, alwaysDisplayed:Boolean = true, checkSuperposition:Boolean = false, cellId:int = -1, offsetRect:IRectangle = null, showDirectionalArrow:Boolean = false) : void
      {
         var tooltipCache:Tooltip = null;
         var ttRect:TooltipRectangle = null;
         if(isVisible(ttName))
         {
            tooltipCache = _tooltipCache[ttCacheName] as Tooltip;
            if(tooltipCache)
            {
               tooltipCache.display.x = 0;
               tooltipCache.display.y = 0;
               ttRect = getTargetRect(target);
               TooltipPlacer.place(tooltipCache.display,ttRect,showDirectionalArrow,point,relativePoint,offset,alwaysDisplayed);
               if(checkSuperposition && cellId != -1)
               {
                  TooltipPlacer.addTooltipPosition(tooltipCache.display,ttRect,cellId,offsetRect);
               }
            }
         }
      }
      
      public static function hideAll() : void
      {
         var name:* = null;
         var strata:int = 0;
         var ttt:Tooltip = null;
         for(name in _tooltips)
         {
            strata = _tooltipsStrata[name];
            ttt = _tooltipsDico[name];
            if((strata == StrataEnum.STRATA_TOOLTIP || strata == StrataEnum.STRATA_WORLD) && (ttt == null || ttt.mustBeHidden))
            {
               hide(name);
            }
         }
      }
      
      public static function clearCache() : void
      {
         var tt:Tooltip = null;
         var berilia:Berilia = Berilia.getInstance();
         for each(tt in _tooltipCache)
         {
            tt.display.cached = false;
            berilia.uiList[tt.display.name] = tt.display;
            berilia.unloadUi(tt.display.name);
         }
         _tooltipCache = new Dictionary();
         _tooltipCacheParam = new Dictionary();
      }
      
      public static function updateAllPositions(pOffsetX:Number, pOffsetY:Number) : void
      {
         var tt:UiRootContainer = null;
         var ttName:* = null;
         for(ttName in _tooltips)
         {
            tt = Berilia.getInstance().getUi(ttName);
            if(tt && (tt.strata == StrataEnum.STRATA_WORLD || tt.strata == StrataEnum.STRATA_LOW))
            {
               tt.x += pOffsetX;
               tt.y += pOffsetY;
            }
         }
      }
      
      private static function onTooltipReady(tt:Tooltip, uiModule:UiModule, name:String, data:*, target:*, autoHide:Boolean, point:uint, relativePoint:uint, offset:*, cacheName:String, strata:int, param:Object, zoom:Number, alwaysDisplayed:Boolean, showDirectionalArrow:Boolean = false, container:UiRootContainer = null) : void
      {
         var uiData:UiData = null;
         var newContainer:UiRootContainer = null;
         var cacheNameInfo:Array = null;
         var cacheMode:* = cacheName != null;
         var showNow:Boolean = _tooltips[name] && _tooltips[name] === data;
         _tooltipsStrata[name] = strata;
         if(showNow || cacheName)
         {
            uiData = new UiData(uiModule,name,null,null);
            uiData.xml = tt.content;
            uiData.uiClass = tt.scriptClass;
            if(container)
            {
               newContainer = new UiRootContainer(StageShareManager.stage,uiData);
               newContainer.uiModule = uiModule;
               newContainer.strata = container.getUi().strata;
               newContainer.restoreSnapshotAfterLoading = container.getUi().restoreSnapshotAfterLoading;
               newContainer.depth = container.getUi().depth + 1;
               tt.display = Berilia.getInstance().loadUiInside(uiData,name,newContainer,container.getUi(),new TooltipProperties(tt,autoHide,getTargetRect(target),point,relativePoint,offset,data,param,zoom,alwaysDisplayed,target,showDirectionalArrow),true);
               container.addChild(newContainer);
            }
            else
            {
               tt.display = Berilia.getInstance().loadUi(uiModule,uiData,name,new TooltipProperties(tt,autoHide,getTargetRect(target),point,relativePoint,offset,data,param,zoom,alwaysDisplayed,target,showDirectionalArrow),true,strata,!showNow,null);
            }
            if(cacheName)
            {
               cacheNameInfo = cacheName.split("#");
               _tooltipCache[cacheNameInfo[0]] = tt;
               if(cacheNameInfo.length > 0)
               {
                  _tooltipCacheParam[cacheNameInfo[0]] = cacheNameInfo[1];
               }
               tt.display.cached = true;
               tt.display.cacheAsBitmap = true;
               if(tt.display.scale != zoom)
               {
                  tt.display.scale = zoom;
               }
            }
            else
            {
               tt.display.scale = zoom;
            }
         }
      }
      
      public static function getTargetRect(target:*) : TooltipRectangle
      {
         var coord:Point = null;
         var localCoord:Point = null;
         var sx:Number = NaN;
         var sy:Number = NaN;
         var inBerilia:Boolean = false;
         var ttrect:TooltipRectangle = null;
         var realtarget:* = target;
         if(realtarget)
         {
            if(realtarget is Rectangle)
            {
               coord = new Point(realtarget.x,realtarget.y);
            }
            else if(realtarget.hasOwnProperty("parent") && realtarget.parent)
            {
               coord = localToGlobal(realtarget.parent,new Point(realtarget.x,realtarget.y));
            }
            else
            {
               coord = realtarget.localToGlobal(new Point(realtarget.x,realtarget.y));
            }
            localCoord = Berilia.getInstance().strataTooltip.globalToLocal(coord);
            sx = StageShareManager.stageScaleX;
            sy = StageShareManager.stageScaleY;
            inBerilia = realtarget is DisplayObject ? Boolean(Berilia.getInstance().docMain.contains(realtarget)) : false;
            return new TooltipRectangle(localCoord.x * (!!inBerilia ? sx : 1),localCoord.y * (!!inBerilia ? sy : 1),realtarget.width / sx,realtarget.height / sy);
         }
         return null;
      }
      
      private static function localToGlobal(t:Object, p:Point = null) : Point
      {
         if(!p)
         {
            p = new Point();
         }
         if(!t.hasOwnProperty("parent"))
         {
            return t.localToGlobal(new Point(t.x,t.y));
         }
         p.x += t.x;
         p.y += t.y;
         if(t.parent && !(t.parent is IApplicationContainer))
         {
            p.x *= t.parent.scaleX;
            p.y *= t.parent.scaleY;
            p = localToGlobal(t.parent,p);
         }
         return p;
      }
      
      private static function onUiRenderComplete(pEvt:UiRenderEvent) : void
      {
         TooltipManager.removeTooltipsHiddenByUi(pEvt.uiTarget.name);
      }
      
      private static function onUiUnloadStarted(pEvt:UiUnloadEvent) : void
      {
         TooltipManager.removeTooltipsHiddenByUi(pEvt.name);
      }
      
      private static function removeTooltipsHiddenByUi(uiname:String) : void
      {
         var name:* = null;
         var strata:int = 0;
         var ttt:Tooltip = null;
         var e:Rectangle = null;
         var berilia:Berilia = Berilia.getInstance();
         var ctr:UiRootContainer = berilia.getUi(uiname);
         if(!ctr || _tooltips[uiname])
         {
            return;
         }
         var containerBounds:Rectangle = ctr.getBounds(StageShareManager.stage);
         for(name in _tooltips)
         {
            strata = _tooltipsStrata[name];
            ttt = _tooltipsDico[name];
            if((strata == StrataEnum.STRATA_TOOLTIP || strata == StrataEnum.STRATA_WORLD) && (ttt == null || ttt.mustBeHidden))
            {
               if(berilia.getUi(name))
               {
                  e = berilia.getUi(name).getBounds(StageShareManager.stage);
                  if(e.x > containerBounds.x && e.x + e.width < containerBounds.x + containerBounds.width && e.y > containerBounds.y && e.y + e.height < containerBounds.x + containerBounds.height)
                  {
                     hide(name);
                  }
               }
            }
         }
      }
   }
}
