package Ankama_ContextMenu.ui
{
   import Ankama_ContextMenu.contextMenu.ContextMenuItem;
   import Ankama_ContextMenu.contextMenu.ContextMenuManager;
   import Ankama_ContextMenu.contextMenu.ContextMenuPictureItem;
   import Ankama_ContextMenu.contextMenu.ContextMenuPictureLabelItem;
   import Ankama_ContextMenu.contextMenu.ContextMenuSeparator;
   import Ankama_ContextMenu.contextMenu.ContextMenuTitle;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.enums.StatesEnum;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.kernel.sound.enum.SoundTypeEnum;
   import com.ankamagames.dofus.uiApi.SoundApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import com.ankamagames.jerakine.benchmark.BenchmarkTimer;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   
   public class ContextMenuUi
   {
      
      private static var _openedMenuTriangle:Vector.<Point> = new Vector.<Point>();
      
      private static var _testLabel:Label;
      
      private static const LEFT_DIR:uint = 1;
      
      private static const RIGHT_DIR:uint = 2;
      
      private static const UP_DIR:uint = 3;
      
      private static const DOWN_DIR:uint = 4;
      
      private static const ACTIVATION_DELAY:uint = 300;
       
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="SoundApi")]
      public var soundApi:SoundApi;
      
      public var mainCtr:GraphicContainer;
      
      public var bgCtr:GraphicContainer;
      
      private var _items:Array;
      
      private var _itemsByName:Array;
      
      private var _orderedButtonItems:Array;
      
      private var _openTimer:BenchmarkTimer;
      
      private var _closeTimer:BenchmarkTimer;
      
      private var _lastItemOver:Object;
      
      private var _openedItem:Object;
      
      private var _lastOverIsVirtual:Boolean;
      
      private var _hasPuce:Boolean;
      
      private var _tooltipTimer:BenchmarkTimer;
      
      private var _currentHelpText:String;
      
      private var _maxLinesCount:int = 30;
      
      private var _firstDisplayedIndex:int = 0;
      
      private var _scrollUpButtonItem:ButtonContainer;
      
      private var _scrollDownButtonItem:ButtonContainer;
      
      public function ContextMenuUi()
      {
         this._items = [];
         this._itemsByName = [];
         this._orderedButtonItems = [];
         super();
      }
      
      public function get items() : Array
      {
         return this._itemsByName;
      }
      
      public function main(args:Object) : void
      {
         var menu:Array = null;
         var btn:GraphicContainer = null;
         var btnLbl:Label = null;
         var btnTx:Texture = null;
         var btnChildIcon:Texture = null;
         var item:* = undefined;
         var i:uint = 0;
         var startPoint:Point = null;
         var textureSize:int = 0;
         var tempWidth:int = 0;
         var uriPrevious:String = null;
         var uriNext:String = null;
         var asLabel:Boolean = false;
         var asTexture:Boolean = false;
         var uri:String = null;
         var cmi:ContextMenuItem = null;
         var puce:Texture = null;
         var stateChangingProperties:Array = null;
         var uriArr:Array = null;
         this.soundApi.playSound(SoundTypeEnum.OPEN_CONTEXT_MENU);
         if(!_testLabel)
         {
            _testLabel = this.uiApi.createComponent("Label") as Label;
            _testLabel.css = this.uiApi.createUri(this.uiApi.me().getConstant("css.uri"));
            _testLabel.cssClass = this.uiApi.me().getConstant("item.cssClass");
            _testLabel.fixedWidth = false;
            _testLabel.useExtendWidth = true;
         }
         this.initTimer();
         if(args is Array)
         {
            menu = args[0] as Array;
            if(args[2])
            {
               this._maxLinesCount = args[2];
            }
         }
         else
         {
            menu = args.menu;
            if(args.hasOwnProperty("maxLinesCount"))
            {
               this._maxLinesCount = args.maxLinesCount;
            }
         }
         var sepHeight:int = parseInt(this.uiApi.me().getConstant("separatorHeight"));
         var titleHeight:int = parseInt(this.uiApi.me().getConstant("titleHeight"));
         var itemHeight:int = parseInt(this.uiApi.me().getConstant("itemHeight"));
         var minWidth:int = parseInt(this.uiApi.me().getConstant("minWidth"));
         this.uiApi.addShortcutHook("ALL",this.onShortcut);
         var maxWidth:uint = 0;
         var hasChild:Boolean = false;
         for(i = 0; i < menu.length; i++)
         {
            item = menu[i];
            switch(true)
            {
               case item is ContextMenuTitle:
               case item is ContextMenuItem:
                  if(item is ContextMenuItem || item is ContextMenuPictureLabelItem)
                  {
                     if(item.child)
                     {
                        hasChild = true;
                     }
                     if(item is ContextMenuItem && ContextMenuItem(item).selected)
                     {
                        this._hasPuce = true;
                     }
                  }
                  _testLabel.text = item.label;
                  if(_testLabel.width > maxWidth)
                  {
                     maxWidth = _testLabel.width;
                  }
                  if(item is ContextMenuPictureLabelItem)
                  {
                     textureSize = ContextMenuPictureLabelItem(item).txSize;
                     tempWidth = _testLabel.width + textureSize;
                  }
                  if(tempWidth > maxWidth)
                  {
                     maxWidth = tempWidth;
                  }
                  break;
            }
         }
         var xOffset:uint = 16;
         maxWidth += 10 + (!!hasChild ? 20 : 0) + xOffset;
         if(maxWidth < minWidth)
         {
            maxWidth = minWidth;
         }
         if(this._maxLinesCount > 0 && menu.length > this._maxLinesCount)
         {
            uriPrevious = this.uiApi.me().getConstant("upArrow.uri");
            uriNext = this.uiApi.me().getConstant("downArrow.uri");
            this._scrollUpButtonItem = this.createNavigationButtonLine("btnUp",uriPrevious,maxWidth,itemHeight);
            this._scrollDownButtonItem = this.createNavigationButtonLine("btnDown",uriNext,maxWidth,itemHeight);
         }
         for(i = 0; i < menu.length; i++)
         {
            item = menu[i];
            switch(true)
            {
               case item is ContextMenuTitle:
                  btnLbl = this.uiApi.createComponent("Label") as Label;
                  btnLbl.width = maxWidth + 2;
                  btnLbl.height = titleHeight;
                  btnLbl.cssClass = this.uiApi.me().getConstant("title.cssClass");
                  btnLbl.css = this.uiApi.createUri(this.uiApi.me().getConstant("css.uri"));
                  btnLbl.text = " " + (!!item.parseText ? this.uiApi.replaceKey(item.label) : item.label);
                  btnLbl.bgColor = this.sysApi.getConfigEntry("colors.contextmenu.title");
                  btnLbl.bgAlpha = this.sysApi.getConfigEntry("colors.contextmenu.title.alpha");
                  btnLbl.x = -1;
                  this.uiApi.addComponentHook(btnLbl,"onRollOver");
                  this._items.push(btnLbl);
                  break;
               case item is ContextMenuSeparator:
                  btn = this.uiApi.createContainer("GraphicContainer");
                  btn.width = maxWidth;
                  btn.height = 1;
                  btn.bgColor = this.sysApi.getConfigEntry("colors.contextmenu.separator");
                  this.uiApi.addComponentHook(btn,"onRollOver");
                  this._items.push(btn);
                  break;
               case item is ContextMenuItem:
                  asLabel = true;
                  asTexture = false;
                  uri = "";
                  if(item is ContextMenuPictureItem)
                  {
                     uri = ContextMenuPictureItem(item).uri;
                     asLabel = false;
                     asTexture = true;
                  }
                  else if(item is ContextMenuPictureLabelItem)
                  {
                     asTexture = true;
                     uri = ContextMenuPictureLabelItem(item).uri;
                  }
                  cmi = item as ContextMenuItem;
                  btn = this.uiApi.createContainer("ButtonContainer");
                  ButtonContainer(btn).isMute = true;
                  btn.width = maxWidth;
                  btn.height = itemHeight;
                  btn.name = "btn" + (i + 1);
                  this.uiApi.me().registerId(btn.name,this.uiApi.createContainer("GraphicElement",btn,new Array(),btn.name));
                  this._orderedButtonItems.push(btn);
                  puce = this.uiApi.createComponent("Texture") as Texture;
                  puce.width = 16;
                  puce.height = 16;
                  puce.y = 3;
                  puce.name = "puce" + i;
                  puce.uri = this.uiApi.createUri(this.uiApi.me().getConstant(!!cmi.radioStyle ? "radio.uri" : "selected.uri"));
                  puce.finalize();
                  btn.addChild(puce);
                  puce.alpha = 0;
                  this.uiApi.me().registerId(puce.name,this.uiApi.createContainer("GraphicElement",puce,new Array(),puce.name));
                  stateChangingProperties = [];
                  stateChangingProperties[StatesEnum.STATE_SELECTED] = [];
                  stateChangingProperties[StatesEnum.STATE_SELECTED][btn.name] = [];
                  if(!cmi.child || !cmi.child.length)
                  {
                     stateChangingProperties[StatesEnum.STATE_SELECTED]["puce" + i] = [];
                     stateChangingProperties[StatesEnum.STATE_SELECTED]["puce" + i]["alpha"] = 1;
                     stateChangingProperties[StatesEnum.STATE_SELECTED][btn.name]["bgColor"] = -1;
                  }
                  else
                  {
                     stateChangingProperties[StatesEnum.STATE_SELECTED][btn.name]["bgColor"] = this.sysApi.getConfigEntry("colors.contextmenu.over");
                     stateChangingProperties[StatesEnum.STATE_SELECTED][btn.name]["bgAlpha"] = this.sysApi.getConfigEntry("colors.contextmenu.over.alpha");
                  }
                  if(!cmi.disabled)
                  {
                     stateChangingProperties[StatesEnum.STATE_OVER] = [];
                     stateChangingProperties[StatesEnum.STATE_OVER][btn.name] = [];
                     stateChangingProperties[StatesEnum.STATE_OVER][btn.name]["bgColor"] = this.sysApi.getConfigEntry("colors.contextmenu.over");
                     stateChangingProperties[StatesEnum.STATE_OVER][btn.name]["bgAlpha"] = this.sysApi.getConfigEntry("colors.contextmenu.over.alpha");
                     stateChangingProperties[StatesEnum.STATE_SELECTED_OVER] = [];
                     stateChangingProperties[StatesEnum.STATE_SELECTED_OVER][btn.name] = [];
                     stateChangingProperties[StatesEnum.STATE_SELECTED_OVER][btn.name]["bgColor"] = this.sysApi.getConfigEntry("colors.contextmenu.over");
                     stateChangingProperties[StatesEnum.STATE_SELECTED_OVER][btn.name]["bgAlpha"] = this.sysApi.getConfigEntry("colors.contextmenu.over.alpha");
                     stateChangingProperties[StatesEnum.STATE_CLICKED] = stateChangingProperties[StatesEnum.STATE_OVER];
                     if(!cmi.child || !cmi.child.length)
                     {
                        stateChangingProperties[StatesEnum.STATE_SELECTED_OVER]["puce" + i] = [];
                        stateChangingProperties[StatesEnum.STATE_SELECTED_OVER]["puce" + i]["alpha"] = 1;
                        stateChangingProperties[StatesEnum.STATE_OVER]["puce" + i] = [];
                        stateChangingProperties[StatesEnum.STATE_OVER]["puce" + i]["alpha"] = 0;
                     }
                     stateChangingProperties[StatesEnum.STATE_SELECTED_CLICKED] = stateChangingProperties[StatesEnum.STATE_SELECTED_OVER];
                  }
                  ButtonContainer(btn).changingStateData = stateChangingProperties;
                  if(asTexture)
                  {
                     btnTx = this.uiApi.createComponent("Texture") as Texture;
                     if(item is ContextMenuPictureLabelItem && item.txSize <= itemHeight)
                     {
                        btnTx.height = item.txSize;
                        btnTx.width = item.txSize;
                        btnTx.y = itemHeight / 2 - item.txSize / 2;
                     }
                     else
                     {
                        btnTx.height = itemHeight;
                        btnTx.width = itemHeight;
                        btnTx.y = 0;
                     }
                     uriArr = uri.split("?");
                     btnTx.uri = this.uiApi.createUri(uriArr[0]);
                     btnTx.x = xOffset;
                     if(uriArr.length == 2)
                     {
                        btnTx.gotoAndStop = parseInt(uriArr[1]);
                     }
                     btnTx.finalize();
                  }
                  if(asLabel)
                  {
                     btnLbl = this.uiApi.createComponent("Label") as Label;
                     btnLbl.width = maxWidth - xOffset;
                     btnLbl.height = itemHeight;
                     if(cmi.disabled)
                     {
                        btnLbl.cssClass = this.uiApi.me().getConstant("disabled.cssClass");
                     }
                     else
                     {
                        btnLbl.cssClass = this.uiApi.me().getConstant("item.cssClass");
                     }
                     btnLbl.css = this.uiApi.createUri(this.uiApi.me().getConstant("css.uri"));
                     btnLbl.html = true;
                     btnLbl.useCustomFormat = true;
                     btnLbl.text = this.uiApi.replaceKey(cmi.label);
                     if(asTexture)
                     {
                        if(item is ContextMenuPictureLabelItem && item.pictureAfterLaber)
                        {
                           btnTx.x = btnLbl.x + (maxWidth - btnTx.width);
                           btnLbl.x = xOffset;
                        }
                        else
                        {
                           btnLbl.x = xOffset + btnTx.width;
                        }
                     }
                     else
                     {
                        btnLbl.x = xOffset;
                     }
                  }
                  if(!cmi.disabled)
                  {
                     if(cmi.child)
                     {
                        btnChildIcon = this.uiApi.createComponent("Texture") as Texture;
                        btnChildIcon.width = 10;
                        btnChildIcon.height = 10;
                        btnChildIcon.uri = this.uiApi.createUri(this.uiApi.me().getConstant("rightArrow.uri"));
                        btnChildIcon.x = btnLbl.width - btnChildIcon.width;
                        btnChildIcon.y = (btn.height - btnChildIcon.height) / 2;
                        btnChildIcon.finalize();
                        btn.addChild(btnChildIcon);
                     }
                     this.uiApi.addComponentHook(btn,"onRollOver");
                     this.uiApi.addComponentHook(btn,"onRollOut");
                  }
                  if(cmi.callback != null || cmi.child)
                  {
                     this.uiApi.addComponentHook(btn,"onRelease");
                  }
                  if(asTexture)
                  {
                     btn.addChild(btnTx);
                  }
                  if(asLabel)
                  {
                     btn.addChild(btnLbl);
                  }
                  ButtonContainer(btn).finalize();
                  this._itemsByName[btn.name] = cmi;
                  this._items.push(btn);
                  break;
            }
         }
         this.displayMenu();
         this.bgCtr.x = -1;
         this.bgCtr.y = -1;
         this.bgCtr.width = maxWidth + 2;
         var targetHeight:Number = 0;
         if(args is Array)
         {
            if(!args[1])
            {
               startPoint = new Point(this.uiApi.getMouseX() + 5,this.uiApi.getMouseY() + 5);
            }
            else
            {
               startPoint = new Point(args[1].x,args[1].y);
            }
            ContextMenuManager.getInstance().mainUiLoaded = true;
         }
         else
         {
            startPoint = new Point(args.x,args.y);
            if(args.hasOwnProperty("targetHeight"))
            {
               targetHeight = args.targetHeight;
            }
         }
         ContextMenuManager.getInstance().placeMe(this.uiApi.me(),this.mainCtr,startPoint,targetHeight);
      }
      
      public function displayMenu() : void
      {
         var btn:GraphicContainer = null;
         var i:int = 0;
         var currentY:uint = 0;
         var childrenCount:int = this.mainCtr.numChildren;
         for(i = childrenCount - 1; i >= 0; i--)
         {
            if(this.mainCtr.getChildAt(i).name != "strata_1")
            {
               this.mainCtr.removeChildAt(i);
            }
         }
         var sepHeight:int = parseInt(this.uiApi.me().getConstant("separatorHeight"));
         var titleHeight:int = parseInt(this.uiApi.me().getConstant("titleHeight"));
         var itemHeight:int = parseInt(this.uiApi.me().getConstant("itemHeight"));
         var listLength:int = this._items.length;
         if(this._maxLinesCount > 0 && this._maxLinesCount < listLength)
         {
            listLength = this._maxLinesCount;
         }
         if(this._firstDisplayedIndex > 0)
         {
            this._scrollUpButtonItem.selected = false;
            this.mainCtr.addChild(this._scrollUpButtonItem);
            currentY += itemHeight;
         }
         for(i = this._firstDisplayedIndex; i < listLength + this._firstDisplayedIndex; i++)
         {
            if(i >= this._items.length)
            {
               break;
            }
            btn = this._items[i];
            switch(true)
            {
               case btn is Label:
                  btn.y = currentY - 2;
                  this.mainCtr.addChild(btn);
                  currentY += titleHeight;
                  continue;
               case btn is ButtonContainer:
                  btn.y = currentY;
                  this.mainCtr.addChild(btn);
                  ButtonContainer(btn).selected = this._itemsByName[btn.name].selected;
                  currentY += itemHeight;
                  continue;
               case btn is GraphicContainer:
                  btn.y = currentY + (sepHeight - 1) / 2;
                  this.mainCtr.addChild(btn);
                  currentY += sepHeight;
                  continue;
               default:
                  continue;
            }
         }
         if(this._firstDisplayedIndex + listLength < this._items.length)
         {
            this._scrollDownButtonItem.y = currentY;
            this._scrollDownButtonItem.selected = false;
            this.mainCtr.addChild(this._scrollDownButtonItem);
            currentY += itemHeight;
         }
         this.bgCtr.height = currentY + 4;
      }
      
      public function createNavigationButtonLine(name:String, uriText:String, width:int, height:int) : ButtonContainer
      {
         var txArrow:Texture = null;
         var btn:ButtonContainer = this.uiApi.createContainer("ButtonContainer") as ButtonContainer;
         btn.isMute = true;
         btn.width = width;
         btn.height = height;
         btn.name = name;
         btn.bgColor = 0;
         btn.bgAlpha = 0;
         this.uiApi.me().registerId(btn.name,this.uiApi.createContainer("GraphicElement",btn,[],btn.name));
         this._orderedButtonItems.push(btn);
         var stateChangingProperties:Array = [];
         stateChangingProperties[StatesEnum.STATE_SELECTED] = [];
         stateChangingProperties[StatesEnum.STATE_SELECTED][btn.name] = [];
         stateChangingProperties[StatesEnum.STATE_SELECTED][btn.name]["bgColor"] = this.sysApi.getConfigEntry("colors.contextmenu.over");
         stateChangingProperties[StatesEnum.STATE_SELECTED][btn.name]["bgAlpha"] = this.sysApi.getConfigEntry("colors.contextmenu.over.alpha");
         stateChangingProperties[StatesEnum.STATE_OVER] = [];
         stateChangingProperties[StatesEnum.STATE_OVER][btn.name] = [];
         stateChangingProperties[StatesEnum.STATE_OVER][btn.name]["bgColor"] = this.sysApi.getConfigEntry("colors.contextmenu.over");
         stateChangingProperties[StatesEnum.STATE_OVER][btn.name]["bgAlpha"] = this.sysApi.getConfigEntry("colors.contextmenu.over.alpha");
         stateChangingProperties[StatesEnum.STATE_SELECTED_OVER] = [];
         stateChangingProperties[StatesEnum.STATE_SELECTED_OVER][btn.name] = [];
         stateChangingProperties[StatesEnum.STATE_SELECTED_OVER][btn.name]["bgColor"] = this.sysApi.getConfigEntry("colors.contextmenu.over");
         stateChangingProperties[StatesEnum.STATE_SELECTED_OVER][btn.name]["bgAlpha"] = this.sysApi.getConfigEntry("colors.contextmenu.over.alpha");
         stateChangingProperties[StatesEnum.STATE_CLICKED] = stateChangingProperties[StatesEnum.STATE_OVER];
         stateChangingProperties[StatesEnum.STATE_SELECTED_CLICKED] = stateChangingProperties[StatesEnum.STATE_SELECTED_OVER];
         btn.changingStateData = stateChangingProperties;
         txArrow = this.uiApi.createComponent("Texture") as Texture;
         txArrow.width = 14;
         txArrow.height = 10;
         txArrow.uri = this.uiApi.createUri(uriText);
         txArrow.x = (width - txArrow.width) / 2;
         txArrow.y = (height - txArrow.height) / 2;
         txArrow.finalize();
         btn.addChild(txArrow);
         this.uiApi.addComponentHook(btn,"onRelease");
         this.uiApi.addComponentHook(btn,"onRollOver");
         this.uiApi.addComponentHook(btn,"onRollOut");
         ButtonContainer(btn).finalize();
         return btn;
      }
      
      public function selectParentOpenItem() : void
      {
         var s:Object = null;
         var parent:UiRootContainer = ContextMenuManager.getInstance().getParent(this.uiApi.me());
         if(parent && parent.uiClass)
         {
            s = parent.uiClass.getOpenItem();
            if(s)
            {
               parent.uiClass.onRollOver(s,true);
            }
         }
      }
      
      public function getOpenItem() : Object
      {
         return this._openedItem;
      }
      
      public function unload() : void
      {
         this._tooltipTimer.removeEventListener(TimerEvent.TIMER_COMPLETE,this.showHelp);
         this._openTimer.removeEventListener(TimerEvent.TIMER,this.openChild);
         this._closeTimer.removeEventListener(TimerEvent.TIMER,this.closeChild);
         this.uiApi.hideTooltip("contextMenuHelp");
      }
      
      public function onRelease(target:Object) : void
      {
         var item:ContextMenuItem = null;
         var tmpItem:Object = null;
         var dir:uint = 0;
         var menuX:Number = NaN;
         var menuY:Number = NaN;
         var menuWidth:Number = NaN;
         var menuHeight:Number = NaN;
         var menuTopCorner:Point = null;
         var menuBottomCorner:Point = null;
         if(this._openedItem == target)
         {
            return;
         }
         if(target == this._scrollUpButtonItem && this._maxLinesCount > 0 && this._firstDisplayedIndex > 0)
         {
            this._firstDisplayedIndex -= this._maxLinesCount;
            if(this._firstDisplayedIndex < 0)
            {
               this._firstDisplayedIndex = 0;
            }
            this.displayMenu();
         }
         else if(target == this._scrollDownButtonItem && this._maxLinesCount > 0 && this._firstDisplayedIndex + this._maxLinesCount < this._items.length)
         {
            this._firstDisplayedIndex += this._maxLinesCount;
            if(this._firstDisplayedIndex > this._items.length - this._maxLinesCount)
            {
               this._firstDisplayedIndex = this._items.length - this._maxLinesCount;
            }
            this.displayMenu();
         }
         else
         {
            item = this._itemsByName[target.name];
            if(this._openedItem)
            {
               this.closeChild();
            }
            if(!item)
            {
               return;
            }
            if(!item.disabled && item.callback != null)
            {
               if(item.radioStyle || item.forceCloseOnSelect)
               {
                  item.callback.apply(null,item.callbackArgs);
                  if(!item.child)
                  {
                     ContextMenuManager.getInstance().closeAll();
                  }
               }
               else
               {
                  for each(tmpItem in this._orderedButtonItems)
                  {
                     if(tmpItem != target)
                     {
                        if(item.radioStyle)
                        {
                           tmpItem.selected = false;
                        }
                     }
                     else if(!item.radioStyle)
                     {
                        item.callback.apply(null,item.callbackArgs);
                        target.selected = !target.selected;
                     }
                     else
                     {
                        if(!target.selected)
                        {
                           item.callback.apply(null,item.callbackArgs);
                        }
                        target.selected = true;
                     }
                  }
               }
            }
            else if(item.disabled && item.disabledCallback != null)
            {
               item.disabledCallback.apply(null,item.disabledCallbackArgs);
            }
            if(item.child && !item.disabled && this.mainCtr != null)
            {
               this._openTimer.reset();
               this._openedItem = target;
               dir = RIGHT_DIR;
               menuX = this.mainCtr.x + this.mainCtr.width;
               menuY = this.mainCtr.y + target.y;
               menuWidth = this.getMenuWidth(this._itemsByName[target.name].child) + 2;
               menuHeight = this.getMenuHeight(this._itemsByName[target.name].child) + 4;
               if(menuX + menuWidth > this.uiApi.getStageWidth())
               {
                  menuX = this.mainCtr.x - menuWidth;
                  dir = LEFT_DIR;
               }
               if(menuY + menuHeight > this.uiApi.getStageHeight())
               {
                  menuY -= menuHeight;
               }
               if(menuX < 0)
               {
                  menuX = 0;
               }
               if(menuY < 0)
               {
                  menuY = 0;
               }
               menuTopCorner = new Point();
               menuBottomCorner = new Point();
               if(dir == RIGHT_DIR)
               {
                  menuTopCorner.x = menuX;
                  menuTopCorner.y = menuY;
                  menuBottomCorner.x = menuTopCorner.x;
                  menuBottomCorner.y = menuTopCorner.y + menuHeight;
               }
               else if(dir == LEFT_DIR)
               {
                  menuTopCorner.x = menuX + menuWidth;
                  menuTopCorner.y = menuY;
                  menuBottomCorner.x = menuTopCorner.x;
                  menuBottomCorner.y = menuTopCorner.y + menuHeight;
               }
               _openedMenuTriangle.length = 0;
               _openedMenuTriangle.push(new Point(this.uiApi.getMouseX(),this.uiApi.getMouseY()),menuTopCorner,menuBottomCorner);
               target.selected = true;
               ContextMenuManager.getInstance().openChild({
                  "menu":this._itemsByName[target.name].child,
                  "x":this.mainCtr.x + this.mainCtr.width,
                  "y":this.mainCtr.y + target.y,
                  "targetHeight":target.height,
                  "maxLinesCount":this._maxLinesCount
               });
            }
            if(!item.child)
            {
               item.selected = target.selected;
            }
         }
      }
      
      public function onRollOver(target:Object, virtual:Boolean = false) : void
      {
         this._tooltipTimer.reset();
         this.selectParentOpenItem();
         if(this._itemsByName[target.name] && this._itemsByName[target.name].child)
         {
            this._openTimer.delay = !!this.isPointInsideTriangle(_openedMenuTriangle,new Point(this.uiApi.getMouseX(),this.uiApi.getMouseY())) ? Number(ACTIVATION_DELAY) : Number(0);
            this._openTimer.start();
         }
         if(ContextMenuManager.getInstance().childHasFocus(this.uiApi.me()))
         {
            this._closeTimer.start();
         }
         if(this._lastItemOver == target)
         {
            this._closeTimer.reset();
         }
         if(virtual)
         {
            this._lastOverIsVirtual = true;
            target.state += 1;
         }
         if(this._lastItemOver && this._lastOverIsVirtual)
         {
            this.onRollOut(this._lastItemOver,true);
         }
         var item:ContextMenuItem = this._itemsByName[target.name];
         if(item && item.help)
         {
            this._tooltipTimer.delay = item.helpDelay;
            this._tooltipTimer.start();
            this._currentHelpText = item.help;
         }
         ContextMenuManager.getInstance().setCurrentFocus(this.uiApi.me());
         this._lastItemOver = target;
         this._lastOverIsVirtual = virtual;
      }
      
      public function onRollOut(target:Object, virtual:Boolean = false) : void
      {
         this._tooltipTimer.reset();
         this.uiApi.hideTooltip("contextMenuHelp");
         if(this._openedItem)
         {
            this._closeTimer.start();
         }
         this._openTimer.reset();
         if(virtual && target.hasOwnProperty("state"))
         {
            --target.state;
         }
      }
      
      public function showHelp(e:Event) : void
      {
         this.uiApi.showTooltip(this.uiApi.textTooltipInfo(this._currentHelpText),ContextMenuManager.getInstance().getTopParent().getElement("mainCtr"),false,"contextMenuHelp",2,0,3,null,null,null,"TextInfo",false,4,1,"",false,this.uiApi.me().parentUiRoot && this.uiApi.me().parentUiRoot.windowOwner ? this.uiApi.me().parentUiRoot.windowOwner.uiRootContainer : null);
      }
      
      private function openChild(e:Event = null) : void
      {
         this._openTimer.reset();
         this.onRelease(this._lastItemOver);
      }
      
      private function closeChild(e:Event = null) : void
      {
         if(!this.uiApi || ContextMenuManager.getInstance().childHasFocus(this.uiApi.me()))
         {
            return;
         }
         this._openedItem.selected = false;
         this._closeTimer.reset();
         this._openedItem = null;
         ContextMenuManager.getInstance().closeChild(this.uiApi.me());
      }
      
      private function initTimer() : void
      {
         this._tooltipTimer = new BenchmarkTimer(1000,1,"ContextMenuUi._tooltipTimer");
         this._tooltipTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.showHelp);
         this._openTimer = new BenchmarkTimer(parseInt(this.uiApi.me().getConstant("timer.open")),1,"ContextMenuUi._openTimer");
         this._openTimer.addEventListener(TimerEvent.TIMER,this.openChild);
         this._closeTimer = new BenchmarkTimer(parseInt(this.uiApi.me().getConstant("timer.close")),1,"ContextMenuUi._closeTimer");
         this._closeTimer.addEventListener(TimerEvent.TIMER,this.closeChild);
      }
      
      private function addToIndex(index:int) : void
      {
         var currentIndex:int = -1;
         if(this._lastItemOver)
         {
            currentIndex = this._orderedButtonItems.indexOf(this._lastItemOver);
         }
         if(currentIndex == -1)
         {
            currentIndex = 0;
         }
         else
         {
            currentIndex = (currentIndex + index) % this._orderedButtonItems.length;
            if(currentIndex == -1)
            {
               currentIndex = this._orderedButtonItems.length - 1;
            }
         }
         var btn:Object = this._orderedButtonItems[currentIndex];
         if(btn)
         {
            if(this._lastItemOver)
            {
               this.onRollOut(this._lastItemOver);
            }
            this.onRollOver(btn,true);
            this._lastItemOver = btn;
         }
      }
      
      private function onShortcut(s:String) : Boolean
      {
         switch(s)
         {
            case "validUi":
               if(this._lastItemOver)
               {
                  this.onRelease(this._lastItemOver);
               }
               ContextMenuManager.getInstance().closeAll();
               return true;
            case "upArrow":
               this.addToIndex(-1);
               return true;
            case "downArrow":
               this.addToIndex(1);
               return true;
            case "closeUi":
               ContextMenuManager.getInstance().closeAll();
               return true;
            default:
               return true;
         }
      }
      
      private function getMenuWidth(pItems:Array) : Number
      {
         var i:int = 0;
         var item:* = undefined;
         var itemWidth:Number = NaN;
         var nbItems:int = pItems.length;
         var maxWidth:Number = 0;
         var hasChild:Boolean = false;
         for(i = 0; i < nbItems; i++)
         {
            item = pItems[i];
            if(item is ContextMenuItem && item.child)
            {
               hasChild = true;
            }
            switch(true)
            {
               case item is ContextMenuTitle:
               case item is ContextMenuItem:
                  _testLabel.text = item.label;
                  itemWidth = item is ContextMenuPictureLabelItem ? Number(_testLabel.width + (item as ContextMenuPictureLabelItem).txSize) : Number(_testLabel.width);
                  if(itemWidth > maxWidth)
                  {
                     maxWidth = itemWidth;
                  }
                  break;
            }
         }
         var minWidth:int = parseInt(this.uiApi.me().getConstant("minWidth"));
         maxWidth += 10 + (!!hasChild ? 20 : 0) + 16;
         if(maxWidth < minWidth)
         {
            maxWidth = minWidth;
         }
         return maxWidth;
      }
      
      private function getMenuHeight(pItems:Array) : Number
      {
         var i:int = 0;
         var item:* = undefined;
         var nbItems:int = pItems.length;
         var height:Number = 0;
         for(i = 0; i < nbItems; i++)
         {
            item = pItems[i];
            switch(true)
            {
               case item is ContextMenuTitle:
                  height += parseInt(this.uiApi.me().getConstant("titleHeight"));
                  break;
               case item is ContextMenuSeparator:
                  height += parseInt(this.uiApi.me().getConstant("separatorHeight"));
                  break;
               case item is ContextMenuItem:
                  height += parseInt(this.uiApi.me().getConstant("itemHeight"));
                  break;
            }
         }
         if(nbItems > this._maxLinesCount)
         {
            height += parseInt(this.uiApi.me().getConstant("itemHeight"));
         }
         return height;
      }
      
      private function isPointInsideTriangle(pTriangle:Vector.<Point>, p:Point) : Boolean
      {
         if(pTriangle.length != 3)
         {
            return false;
         }
         var p1:Point = pTriangle[0];
         var p2:Point = pTriangle[1];
         var p3:Point = pTriangle[2];
         var alpha:Number = ((p2.y - p3.y) * (p.x - p3.x) + (p3.x - p2.x) * (p.y - p3.y)) / ((p2.y - p3.y) * (p1.x - p3.x) + (p3.x - p2.x) * (p1.y - p3.y));
         var beta:Number = ((p3.y - p1.y) * (p.x - p3.x) + (p1.x - p3.x) * (p.y - p3.y)) / ((p2.y - p3.y) * (p1.x - p3.x) + (p3.x - p2.x) * (p1.y - p3.y));
         var gamma:Number = 1 - alpha - beta;
         return alpha > 0 && beta > 0 && gamma > 0;
      }
   }
}
