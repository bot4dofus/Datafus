package com.ankamagames.dofus.uiApi
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.factories.TooltipsFactory;
   import com.ankamagames.berilia.interfaces.IApi;
   import com.ankamagames.berilia.interfaces.ITooltipMaker;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.ChunkData;
   import com.ankamagames.berilia.types.data.UiData;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.event.UiRenderEvent;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   import com.ankamagames.berilia.types.tooltip.TooltipBlock;
   import com.ankamagames.berilia.types.tooltip.TooltipPlacer;
   import com.ankamagames.berilia.types.tooltip.TooltipRectangle;
   import com.ankamagames.berilia.utils.errors.ApiError;
   import com.ankamagames.dofus.internalDatacenter.items.ItemWrapper;
   import com.ankamagames.dofus.internalDatacenter.items.WeaponWrapper;
   import com.ankamagames.dofus.internalDatacenter.spells.SpellWrapper;
   import com.ankamagames.dofus.logic.game.common.frames.PlayedCharacterUpdatesFrame;
   import com.ankamagames.dofus.modules.utils.ItemTooltipSettings;
   import com.ankamagames.dofus.modules.utils.SpellTooltipSettings;
   import com.ankamagames.dofus.types.data.ItemTooltipInfo;
   import com.ankamagames.dofus.types.data.SpellTooltipInfo;
   import com.ankamagames.dofus.types.data.WeaponTooltipInfo;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.Uri;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   [InstanciedApi]
   public class TooltipApi implements IApi
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(TooltipApi));
       
      
      private var _module:UiModule;
      
      private var _currentUi:UiRootContainer;
      
      private var _ttCallbacks:Dictionary;
      
      public function TooltipApi()
      {
         this._ttCallbacks = new Dictionary();
         super();
      }
      
      private static function placeTooltip(pTooltipUi:UiRootContainer, pTarget:*, showDirectionalArrow:Object, pPoint:uint, pRelativePoint:uint, pOffset:*, pCheckSuperposition:Boolean, pCellId:int, pOffsetRect:IRectangle, pAlwaysDisplayed:Boolean) : void
      {
         TooltipPlacer.place(pTooltipUi,pTarget,showDirectionalArrow,pPoint,pRelativePoint,pOffset,pAlwaysDisplayed);
         if(pCheckSuperposition && pCellId != -1)
         {
            TooltipPlacer.addTooltipPosition(pTooltipUi,pTarget,pCellId,pOffsetRect);
         }
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
         this._module = null;
         this._currentUi = null;
      }
      
      public function setDefaultTooltipUiScript(module:String, ui:String) : void
      {
         var m:UiModule = UiModuleManager.getInstance().getModule(module);
         if(!m)
         {
            throw new ApiError("Module " + module + " doesn\'t exist");
         }
         var uiData:UiData = m.getUi(ui);
         if(!uiData)
         {
            throw new ApiError("UI " + ui + " doesn\'t exist in module " + module);
         }
         TooltipManager.defaultTooltipUiScript = uiData.uiClass;
      }
      
      [NoBoxing]
      public function createTooltip(baseUri:String, containerUri:String, separatorUri:String = null) : Tooltip
      {
         var t:Tooltip = null;
         if(baseUri.substr(-4,4) != ".txt")
         {
            throw new ApiError("ChunkData support only [.txt] file, found " + baseUri);
         }
         if(containerUri.substr(-4,4) != ".txt")
         {
            throw new ApiError("ChunkData support only [.txt] file, found " + containerUri);
         }
         if(separatorUri)
         {
            if(separatorUri.substr(-4,4) != ".txt")
            {
               throw new ApiError("ChunkData support only [.txt] file, found " + separatorUri);
            }
            t = new Tooltip(new Uri(this._module.rootPath + "/" + baseUri),new Uri(this._module.rootPath + "/" + containerUri),new Uri(this._module.rootPath + "/" + separatorUri));
         }
         else
         {
            t = new Tooltip(new Uri(this._module.rootPath + "/" + baseUri),new Uri(this._module.rootPath + "/" + containerUri));
         }
         return t;
      }
      
      [NoBoxing]
      public function createTooltipBlock(onAllChunkLoadedCallback:Function, contentGetter:Function, chunkType:String = "chunks") : TooltipBlock
      {
         var tb:TooltipBlock = new TooltipBlock();
         tb.onAllChunkLoadedCallback = onAllChunkLoadedCallback;
         tb.contentGetter = contentGetter;
         tb.chunkType = chunkType;
         return tb;
      }
      
      public function registerTooltipAssoc(targetClass:*, makerName:String) : void
      {
         TooltipsFactory.registerAssoc(targetClass,makerName);
      }
      
      public function registerTooltipMaker(makerName:String, makerClass:Class, scriptClass:Class = null) : void
      {
         if(DescribeTypeCache.classImplementInterface(makerClass,ITooltipMaker))
         {
            TooltipsFactory.registerMaker(makerName,makerClass,scriptClass);
            return;
         }
         throw new ApiError(makerName + " maker class is not compatible with ITooltipMaker");
      }
      
      [NoBoxing]
      public function createChunkData(name:String, uri:String) : ChunkData
      {
         var newUri:Uri = new Uri(this._module.rootPath + "/" + uri);
         if(newUri.fileType.toLowerCase() != "txt")
         {
            throw new ApiError("ChunkData support only [.txt] file, found " + uri);
         }
         return new ChunkData(name,newUri);
      }
      
      public function place(target:IRectangle, showDirectionalArrow:Object, point:uint = 6, relativePoint:uint = 0, offset:* = 3, checkSuperposition:Boolean = false, cellId:int = -1, offsetRect:IRectangle = null, alwaysDisplayed:Boolean = true) : void
      {
         if(target != null)
         {
            if(this._currentUi.ready)
            {
               placeTooltip(this._currentUi,target,showDirectionalArrow,point,relativePoint,offset,checkSuperposition,cellId,offsetRect,alwaysDisplayed);
            }
            else
            {
               this._ttCallbacks[this._currentUi] = new Callback(placeTooltip,this._currentUi,target,showDirectionalArrow,point,relativePoint,offset,checkSuperposition,cellId,offsetRect,alwaysDisplayed);
               this._currentUi.addEventListener(UiRenderEvent.UIRenderComplete,this.onTooltipReady);
            }
         }
      }
      
      public function placeArrow(target:IRectangle) : Object
      {
         return TooltipPlacer.placeWithArrow(this._currentUi,target);
      }
      
      public function getSpellTooltipInfo(spellWrapper:SpellWrapper, shortcutKey:String = null) : SpellTooltipInfo
      {
         return new SpellTooltipInfo(spellWrapper,shortcutKey);
      }
      
      public function getItemTooltipInfo(itemWrapper:ItemWrapper, shortcutKey:String = null) : ItemTooltipInfo
      {
         return new ItemTooltipInfo(itemWrapper,shortcutKey);
      }
      
      public function getWeaponTooltipInfo(spellWrapper:SpellWrapper, shortcutKey:String = null, makerParams:Object = null, weapon:WeaponWrapper = null) : WeaponTooltipInfo
      {
         return new WeaponTooltipInfo(spellWrapper,shortcutKey,makerParams,weapon);
      }
      
      public function getSpellTooltipCache() : int
      {
         return PlayedCharacterUpdatesFrame.SPELL_TOOLTIP_CACHE_NUM;
      }
      
      public function resetSpellTooltipCache() : void
      {
         ++PlayedCharacterUpdatesFrame.SPELL_TOOLTIP_CACHE_NUM;
      }
      
      [NoBoxing]
      public function createTooltipRectangle(x:Number = 0, y:Number = 0, width:Number = 0, height:Number = 0) : TooltipRectangle
      {
         return new TooltipRectangle(x,y,width,height);
      }
      
      public function createSpellSettings() : SpellTooltipSettings
      {
         return new SpellTooltipSettings();
      }
      
      public function createItemSettings() : ItemTooltipSettings
      {
         return new ItemTooltipSettings();
      }
      
      public function update(ttCacheName:String, ... params) : void
      {
         TooltipManager.update(ttCacheName,params);
      }
      
      public function adjustTooltipPositions(tooltipNames:Array, sourceName:String, offset:int = 0) : void
      {
         var ui:UiRootContainer = null;
         var name:String = null;
         var i:int = 0;
         var goOnTop:Boolean = false;
         var lastUi:UiRootContainer = null;
         var mainColumnTooltips:Array = null;
         var mainColumnHeight:Number = NaN;
         var mainColumnY:Number = NaN;
         var tooltipUis:Array = new Array();
         var sourceUi:UiRootContainer = Berilia.getInstance().getUi(sourceName);
         for each(name in tooltipNames)
         {
            ui = Berilia.getInstance().getUi(name);
            if(ui)
            {
               tooltipUis.push(ui);
            }
         }
         i = 0;
         goOnTop = true;
         mainColumnTooltips = [];
         mainColumnHeight = 0;
         mainColumnY = 0;
         for each(ui in tooltipUis)
         {
            if(i == 0)
            {
               if(tooltipNames.length == 1)
               {
                  if(sourceUi.x - ui.width - offset >= 0)
                  {
                     placeTooltip(ui,sourceUi,false,LocationEnum.POINT_TOPRIGHT,LocationEnum.POINT_TOPLEFT,offset,false,0,null,true);
                     ui.x -= offset * 2;
                  }
                  else
                  {
                     placeTooltip(ui,sourceUi,false,LocationEnum.POINT_TOPLEFT,LocationEnum.POINT_TOPRIGHT,offset,false,0,null,true);
                  }
                  if(ui.y - 41 >= 0)
                  {
                     ui.y -= 41;
                  }
                  return;
               }
               if(sourceUi.x - ui.width - offset >= 0)
               {
                  placeTooltip(ui,sourceUi,false,LocationEnum.POINT_RIGHT,LocationEnum.POINT_LEFT,offset,false,0,null,true);
                  ui.x -= offset * 2;
               }
               else
               {
                  placeTooltip(ui,sourceUi,false,LocationEnum.POINT_LEFT,LocationEnum.POINT_RIGHT,offset,false,0,null,true);
               }
               mainColumnHeight += ui.height + offset;
               mainColumnTooltips.push(ui);
               mainColumnY = ui.y;
            }
            else if(i < 4)
            {
               if(goOnTop && lastUi.y - ui.height - offset < 0)
               {
                  goOnTop = false;
                  lastUi = tooltipUis[0];
               }
               if(goOnTop)
               {
                  placeTooltip(ui,lastUi,false,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,offset,false,0,null,false);
                  mainColumnY = ui.y;
               }
               else
               {
                  placeTooltip(ui,lastUi,false,LocationEnum.POINT_TOP,LocationEnum.POINT_BOTTOM,offset,false,0,null,false);
               }
               ui.x = lastUi.x;
               mainColumnHeight += ui.height + offset;
               mainColumnTooltips.push(ui);
            }
            else
            {
               if(goOnTop && lastUi.y - ui.height - offset < 0)
               {
                  goOnTop = false;
                  lastUi = sourceUi;
               }
               if(goOnTop)
               {
                  placeTooltip(ui,lastUi,false,LocationEnum.POINT_BOTTOM,LocationEnum.POINT_TOP,offset,false,0,null,true);
               }
               else
               {
                  placeTooltip(ui,lastUi,false,LocationEnum.POINT_TOP,LocationEnum.POINT_BOTTOM,offset,false,0,null,true);
               }
               ui.x = lastUi.x;
            }
            lastUi = ui;
            i++;
            if(i == 4)
            {
               goOnTop = true;
               lastUi = sourceUi;
            }
         }
         if(mainColumnY + mainColumnHeight > StageShareManager.startHeight)
         {
            offset = mainColumnY + mainColumnHeight - StageShareManager.startHeight;
            for each(ui in mainColumnTooltips)
            {
               ui.y -= offset;
            }
         }
      }
      
      private function onTooltipReady(pEvent:UiRenderEvent) : void
      {
         var currentUi:UiRootContainer = pEvent.currentTarget as UiRootContainer;
         currentUi.removeEventListener(UiRenderEvent.UIRenderComplete,this.onTooltipReady);
         (this._ttCallbacks[currentUi] as Callback).exec();
         delete this._ttCallbacks[currentUi];
      }
   }
}
