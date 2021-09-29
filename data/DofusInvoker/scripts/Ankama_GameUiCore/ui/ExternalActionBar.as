package Ankama_GameUiCore.ui
{
   import Ankama_GameUiCore.ui.enums.ContextEnum;
   import Ankama_GameUiCore.ui.params.ActionBarParameters;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.dofus.network.enums.GameContextEnum;
   import com.ankamagames.jerakine.types.enums.DataStoreEnum;
   import flash.geom.Rectangle;
   
   public class ExternalActionBar extends ActionBar
   {
      
      public static const ORIENTATION_HORIZONTAL:uint = 1;
      
      public static const ORIENTATION_VERTICAL:uint = 2;
       
      
      public var mainCtr:GraphicContainer;
      
      public var btn_options:ButtonContainer;
      
      public var btn_minimize:ButtonContainer;
      
      public var actionBarCtr:GraphicContainer;
      
      public var backgroundCtr:GraphicContainer;
      
      public var actionBarId:uint;
      
      private var _orientation:uint;
      
      private var _screenBounds:Rectangle;
      
      private var _currentContext:uint;
      
      public function ExternalActionBar()
      {
         super();
      }
      
      override public function main(args:Array) : void
      {
         sysApi.addHook(HookList.ContextChanged,this.onContextJustChanged);
         isMainBar = false;
         super.main(args);
         var params:ActionBarParameters = args[0];
         this.actionBarId = params.id;
         this._orientation = params.orientation;
         externalActionBars[this.actionBarId] = this;
         _nPageItems = 0;
         _nPageSpells = 0;
         _sTabGrid = ITEMS_TAB;
         var externalActionBarsState:* = sysApi.getData(dataKey,DataStoreEnum.BIND_CHARACTER);
         if(externalActionBarsState && externalActionBarsState[this.actionBarId])
         {
            _nPageItems = externalActionBarsState[this.actionBarId].nPageItems;
            if(getPlayerId() >= 0)
            {
               _nPageSpells = externalActionBarsState[this.actionBarId].nPageSpells;
            }
            _sTabGrid = externalActionBarsState[this.actionBarId].sTabGrid;
            this.mainCtr.visible = true;
         }
         else if(params.orientationChanged)
         {
            this.mainCtr.visible = true;
         }
         onShortcutBarViewContent(0);
         onShortcutBarViewContent(1);
         gridDisplay(_sTabGrid,true);
         if(!this.mainCtr.getSavedPosition() && !params.orientationChanged)
         {
            this.place();
         }
      }
      
      public function restoreData(data:Object) : void
      {
         _nPageItems = data.nPageItems;
         if(getPlayerId() >= 0)
         {
            _nPageSpells = data.nPageSpells;
         }
         _sTabGrid = data.sTabGrid;
         gridDisplay(_sTabGrid,true);
      }
      
      public function get orientation() : uint
      {
         return this._orientation;
      }
      
      public function get bounds() : Rectangle
      {
         return new Rectangle(this.mainCtr.x,this.mainCtr.y,uiApi.me().width,uiApi.me().height);
      }
      
      private function onContextJustChanged(pContextId:uint) : void
      {
         if(this._currentContext && this._currentContext != pContextId)
         {
            this.mainCtr.visible = false;
         }
         this._currentContext = pContextId;
      }
      
      override protected function onContextChanged(context:String, previousContext:String = "", contextChanged:Boolean = false) : void
      {
         if(context == ContextEnum.ROLEPLAY)
         {
            this._currentContext = GameContextEnum.ROLE_PLAY;
         }
         else
         {
            this._currentContext = GameContextEnum.FIGHT;
         }
         var externalActionBarsState:* = sysApi.getData(dataKey,DataStoreEnum.BIND_CHARACTER);
         if(!externalActionBarsState)
         {
            externalActionBarsState = [];
         }
         switch(context)
         {
            case ContextEnum.SPECTATOR:
               gd_spellitemotes.disabled = true;
               this.mainCtr.visible = false;
               break;
            default:
               if(!externalActionBarsState[this.actionBarId])
               {
                  this.mainCtr.visible = false;
                  mainBar.btn_addActionBar.disabled = false;
               }
               else if(externalActionBarsState[this.actionBarId])
               {
                  if(this._orientation != externalActionBarsState[this.actionBarId].orientation)
                  {
                     this.changeOrientation(externalActionBarsState[this.actionBarId].orientation,false);
                  }
                  else
                  {
                     this.restoreData(externalActionBarsState[this.actionBarId]);
                     this.mainCtr.visible = true;
                     gd_spellitemotes.disabled = false;
                     mainBar.btn_addActionBar.disabled = !canAddExternalActionBar();
                  }
               }
         }
      }
      
      override public function onRelease(target:GraphicContainer) : void
      {
         var contextMenu:Array = null;
         super.onRelease(target);
         switch(target)
         {
            case btn_tabItems:
            case btn_tabSpells:
               this.saveCurrentActiveActionBars();
               break;
            case this.btn_options:
               contextMenu = [];
               contextMenu.push(modContextMenu.createContextMenuTitleObject(uiApi.getText("ui.common.options")));
               contextMenu.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.banner.actionBar.changeOrientation"),this.changeOrientation,[this._orientation == ORIENTATION_HORIZONTAL ? ORIENTATION_VERTICAL : ORIENTATION_HORIZONTAL]));
               contextMenu.push(modContextMenu.createContextMenuItemObject(uiApi.getText("ui.common.close"),this.hide));
               modContextMenu.createContextMenu(contextMenu);
               break;
            case this.btn_minimize:
               this.actionBarCtr.visible = !this.actionBarCtr.visible;
               this.backgroundCtr.bgAlpha = !!this.actionBarCtr.visible ? Number(0.7) : Number(0);
         }
      }
      
      override public function onRollOver(target:GraphicContainer) : void
      {
         super.onRollOver(target);
      }
      
      override public function unload() : void
      {
         externalActionBars[this.actionBarId] = null;
         super.unload();
      }
      
      override protected function onSwitchBannerTab(tabName:String) : void
      {
      }
      
      override public function onOpenSpellBook() : void
      {
      }
      
      override protected function updateSpellShortcuts() : void
      {
         _aSpells = storageApi.getShortcutBarContent(1);
         if(_sTabGrid == SPELLS_TAB)
         {
            updateGrid(_aSpells,_nPageSpells);
         }
      }
      
      override protected function displayPage() : void
      {
         var index:int = 0;
         if(_sTabGrid == ITEMS_TAB)
         {
            index = _nPageItems;
         }
         else if(_sTabGrid == SPELLS_TAB)
         {
            index = _nPageSpells;
         }
         lbl_itemsNumber.text = (index + 1).toString();
         btn_upArrow.disabled = index == 0;
         btn_downArrow.disabled = index == NUM_PAGES - 1;
         this.saveCurrentActiveActionBars();
      }
      
      override public function onOpenInventory(... args) : void
      {
      }
      
      override public function onShortcut(s:String) : Boolean
      {
         return false;
      }
      
      private function changeOrientation(pOrientation:uint, pSaveData:Boolean = true) : void
      {
         this._orientation = pOrientation;
         if(pSaveData)
         {
            this.saveCurrentActiveActionBars();
         }
         mainBar.reloadExternalActionBar(this.actionBarId,currentContext);
      }
      
      public function show() : void
      {
         this.place();
         _nPageItems = 0;
         _nPageSpells = 0;
         _sTabGrid = ITEMS_TAB;
         gridDisplay(_sTabGrid,true);
         this.mainCtr.visible = true;
         this.saveCurrentActiveActionBars();
      }
      
      public function hide() : void
      {
         this.mainCtr.visible = false;
         uiApi.getUi("bannerActionBar").uiClass.btn_addActionBar.disabled = false;
         this.saveCurrentActiveActionBars();
      }
      
      private function place() : void
      {
         var bar:ExternalActionBar = null;
         var barBounds:Rectangle = null;
         var barsBoundsLength:uint = 0;
         var i:int = 0;
         var b:Rectangle = this.bounds;
         var barsBounds:Vector.<Rectangle> = new Vector.<Rectangle>(0);
         for each(bar in externalActionBars)
         {
            if(bar && bar != this && bar.mainCtr.visible)
            {
               barsBounds.push(bar.bounds);
            }
         }
         barsBounds.sort(this.compareBounds);
         barsBoundsLength = barsBounds.length;
         for(i = 0; i < barsBoundsLength; i++)
         {
            barBounds = barsBounds[i];
            b.x = barBounds.x;
            b.y = barBounds.y + barBounds.height + 5;
            if(this.isValidBounds(b,barsBounds))
            {
               break;
            }
            b.x = barBounds.x + barBounds.width + 5;
            b.y = barBounds.y;
            if(this.isValidBounds(b,barsBounds))
            {
               break;
            }
            b.x = barBounds.x - barBounds.width - 5;
            b.y = barBounds.y;
            if(this.isValidBounds(b,barsBounds))
            {
               break;
            }
            b.x = barBounds.x;
            b.y = barBounds.y - b.height - 5;
            if(this.isValidBounds(b,barsBounds))
            {
               break;
            }
         }
         if(barsBoundsLength)
         {
            this.mainCtr.x = b.x;
            this.mainCtr.y = b.y;
         }
         else
         {
            this.mainCtr.x = this.mainCtr.y = 0;
         }
         this.mainCtr.setSavedPosition(this.mainCtr.x,this.mainCtr.y);
      }
      
      private function compareBounds(pRectA:Rectangle, pRectB:Rectangle) : int
      {
         if(pRectA.y > pRectB.y)
         {
            return -1;
         }
         if(pRectA.y < pRectB.y)
         {
            return 1;
         }
         return 0;
      }
      
      private function isValidBounds(pBarBounds:Rectangle, pOtherBarsBounds:Vector.<Rectangle>) : Boolean
      {
         var sb:Rectangle = null;
         var otherBarBounds:Rectangle = null;
         if(!this._screenBounds)
         {
            sb = uiApi.getVisibleStageBounds();
            this._screenBounds = new Rectangle(sb.x,sb.y,sb.width,sb.height);
         }
         if(this._screenBounds.containsRect(pBarBounds))
         {
            for each(otherBarBounds in pOtherBarsBounds)
            {
               if(pBarBounds.intersects(otherBarBounds))
               {
                  return false;
               }
            }
            return true;
         }
         return false;
      }
      
      private function saveCurrentActiveActionBars() : void
      {
         var externalActionBarsState:Array = sysApi.getData(dataKey,DataStoreEnum.BIND_CHARACTER);
         if(!externalActionBarsState)
         {
            externalActionBarsState = [];
         }
         var dataObj:Object = null;
         if(this.mainCtr.visible)
         {
            dataObj = {};
            dataObj.sTabGrid = _sTabGrid;
            dataObj.nPageItems = _nPageItems;
            dataObj.nPageSpells = _nPageSpells;
            dataObj.orientation = this._orientation;
         }
         externalActionBarsState[this.actionBarId] = dataObj;
         sysApi.setData(dataKey,externalActionBarsState,DataStoreEnum.BIND_CHARACTER);
      }
   }
}
