package Ankama_Tooltips.ui
{
   import Ankama_ContextMenu.ContextMenu;
   import Ankama_Tooltips.Api;
   import com.ankamagames.berilia.api.UiApi;
   import com.ankamagames.berilia.types.data.ContextMenuData;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.berilia.utils.ComponentHookList;
   import com.ankamagames.dofus.internalDatacenter.items.MountWrapper;
   import com.ankamagames.dofus.uiApi.ContextMenuApi;
   import com.ankamagames.dofus.uiApi.InventoryApi;
   import com.ankamagames.dofus.uiApi.SystemApi;
   import flash.display.DisplayObject;
   import flash.display.Stage;
   import flash.geom.Rectangle;
   import flash.ui.Keyboard;
   import flash.utils.Dictionary;
   
   public class TooltipPinableBaseUi
   {
      
      private static var _pinCounterId:uint = 0;
      
      private static var _displayedPin:Dictionary = new Dictionary(true);
      
      private static var _pinnedTooltipScripts:Array = [];
      
      private static var _cancelKeyUp:Boolean;
      
      private static var _startPinSequence:Boolean;
      
      private static const KEY_PIN:uint = Keyboard.ALTERNATE;
       
      
      protected var _params:Object;
      
      private var _pinId:int = -1;
      
      [Module(name="Ankama_ContextMenu")]
      public var modContextMenu:ContextMenu;
      
      [Api(name="SystemApi")]
      public var sysApi:SystemApi;
      
      [Api(name="UiApi")]
      public var uiApi:UiApi;
      
      [Api(name="ContextMenuApi")]
      public var menuApi:ContextMenuApi;
      
      [Api(name="InventoryApi")]
      public var inventoryApi:InventoryApi;
      
      public var isPin:Boolean = false;
      
      public var btnClose:ButtonContainer;
      
      public var btnMenu:ButtonContainer;
      
      public var mainCtr:GraphicContainer;
      
      public var backgroundCtr:GraphicContainer;
      
      private var dragControler:GraphicContainer;
      
      public function TooltipPinableBaseUi()
      {
         super();
      }
      
      public function main(params:Object = null) : void
      {
         var newTooltipName:String = null;
         var rect:Rectangle = null;
         if(!this.backgroundCtr)
         {
            return;
         }
         var tooltipName:String = this.uiApi.me().name;
         var isPinned:* = tooltipName.indexOf("_pin@") != -1;
         if(!isPinned && params && params.makerParam && params.makerParam.hasOwnProperty("pinnable") && params.makerParam.pinnable)
         {
            if(_displayedPin[params.data])
            {
               this.uiApi.unloadUi("tooltip_" + _displayedPin[params.data]);
               this.uiApi.hideTooltip();
               return;
            }
            if(params.makerParam is Object)
            {
               params.makerParam.noLeftFooter = true;
            }
            this._pinId = _pinCounterId;
            newTooltipName = tooltipName + "_pin@" + _pinCounterId++;
            _displayedPin[params.data] = newTooltipName;
            rect = new Rectangle(20,20,0,0);
            if(params.hasOwnProperty("position") && params.position)
            {
               rect.x = params.position.x;
               rect.y = params.position.y;
            }
            this.uiApi.showTooltip(params.data,rect,false,newTooltipName,0,0,0,params.makerName,null,params.makerParam,null,true);
            this.uiApi.hideTooltip();
            return;
         }
         this._params = params;
         if(isPinned)
         {
            this.makePin();
         }
         else if(tooltipName.indexOf("compare") == -1)
         {
            this.sysApi.addHook(BeriliaHookList.KeyDown,this._onKeyDown);
            this.sysApi.addHook(BeriliaHookList.KeyUp,this._onKeyUp);
            this.sysApi.addHook(BeriliaHookList.MouseShiftClick,this._onMouseShiftClick);
         }
      }
      
      protected function makePin() : void
      {
         var bounds:Rectangle = null;
         var p:* = undefined;
         var me:* = undefined;
         this.isPin = true;
         if(!this.mainCtr)
         {
            bounds = this.uiApi.me().getBounds(this.uiApi.me());
            this.dragControler = this.uiApi.createContainer("GraphicContainer") as GraphicContainer;
            this.dragControler.width = bounds.width;
            this.dragControler.height = bounds.height;
            this.dragControler.bgColor = 16711680;
            this.uiApi.me().addChildAt(this.dragControler,0);
         }
         else
         {
            this.dragControler = this.mainCtr;
            p = this.dragControler;
            me = this.uiApi.me();
            while(p.name != me.name && !(p is Stage))
            {
               p.mouseChildren = true;
               p = p.parent;
            }
         }
         this.dragControler.dragController = true;
         this.dragControler.dragTarget = this.uiApi.me().name;
         this.dragControler.dragBoundsContainer = this.dragControler.name;
         this.dragControler.dragSavePosition = false;
         if(this.btnClose)
         {
            this.btnClose.visible = true;
            this.uiApi.addComponentHook(this.btnClose,ComponentHookList.ON_RELEASE);
            if(this.btnMenu)
            {
               this.btnMenu.visible = true;
               this.uiApi.addComponentHook(this.btnMenu,ComponentHookList.ON_RELEASE);
            }
         }
         this.highlightPinnedTooltip();
         this.sysApi.addHook(BeriliaHookList.UiUnloading,this._onUiUnload);
         this.uiApi.addShortcutHook("closeUi",this.onShortcut);
         this.uiApi.addShortcutHook("shiftCloseUi",this.onShortcut);
         this.uiApi.addComponentHook(this.mainCtr,"onPress");
         this.uiApi.addComponentHook(this.mainCtr,"onRelease");
      }
      
      public function onShortcut(s:String) : Boolean
      {
         var uiRootContainer:* = undefined;
         var topIndex:int = 0;
         if(!this.mainCtr.visible)
         {
            return false;
         }
         switch(s)
         {
            case "closeUi":
               uiRootContainer = this.uiApi.me();
               topIndex = uiRootContainer.parent.numChildren - 1;
               if(uiRootContainer.childIndex == topIndex)
               {
                  this.uiApi.unloadUi(this.uiApi.me().name);
                  return true;
               }
               return false;
               break;
            case "shiftCloseUi":
               this.uiApi.unloadUi(this.uiApi.me().name);
               return false;
            default:
               return false;
         }
      }
      
      public function onPress(target:GraphicContainer) : void
      {
         if(target == this.mainCtr)
         {
            this.highlightPinnedTooltip();
         }
      }
      
      public function onRelease(target:GraphicContainer) : void
      {
         var uiRootContainer:* = undefined;
         var topIndex:int = 0;
         var contextMenu:ContextMenuData = null;
         if(target == this.mainCtr)
         {
            uiRootContainer = this.uiApi.me();
            topIndex = uiRootContainer.parent.numChildren - 1;
            uiRootContainer.childIndex = topIndex;
         }
         else if(target == this.btnClose)
         {
            this.uiApi.unloadUi(this.uiApi.me().name);
         }
         else if(target == this.btnMenu)
         {
            if(this._params && this._params.data != MountWrapper)
            {
               if(this._params.data.hasOwnProperty("itemWrapper") && this._params.data.itemWrapper)
               {
                  contextMenu = this.menuApi.create(this._params.data.itemWrapper,null,[{"ownedItem":this.inventoryApi.getItemFromInventoryByUID(this._params.data.itemWrapper.objectUID) != null},this.uiApi.me()["name"]]);
               }
               else if(this._params && this._params.data)
               {
                  contextMenu = this.menuApi.create(this._params.data,null,[{"ownedItem":this.inventoryApi.getItemFromInventoryByUID(this._params.data.objectUID) != null},this.uiApi.me()["name"]]);
               }
               if(contextMenu.content.length > 0)
               {
                  this.modContextMenu.createContextMenu(contextMenu);
               }
            }
         }
      }
      
      private function _onKeyDown(target:DisplayObject, keyCode:uint) : void
      {
         if(!_startPinSequence && keyCode == KEY_PIN)
         {
            _cancelKeyUp = false;
            _startPinSequence = true;
         }
      }
      
      private function _onMouseShiftClick(target:*) : void
      {
         _cancelKeyUp = true;
      }
      
      private function _onKeyUp(target:DisplayObject, keyCode:uint) : void
      {
         var tooltipName:String = null;
         var settings:Object = null;
         var setting:String = null;
         var objVariables:* = undefined;
         _startPinSequence = false;
         if(!_cancelKeyUp && keyCode == KEY_PIN && !(this._params.makerParam && this._params.makerParam.hasOwnProperty("unPinnable") && this._params.makerParam.unPinnable) && !_displayedPin[this._params.data])
         {
            tooltipName = this.uiApi.me().name + "_pin@" + _pinCounterId++;
            this._pinId = _pinCounterId;
            _displayedPin[this._params.data] = tooltipName;
            if(this._params.makerParam is Object)
            {
               try
               {
                  this._params.makerParam.noFooter = true;
               }
               catch(error:Error)
               {
               }
            }
            settings = {};
            if(this._params.makerParam)
            {
               objVariables = Api.system.getObjectVariables(this._params.makerParam);
               for each(setting in objVariables)
               {
                  settings[setting] = this._params.makerParam[setting];
               }
            }
            settings.pinnable = true;
            settings.footerText = "";
            this.uiApi.showTooltip(this._params.data,new Rectangle(this.uiApi.me().x,this.uiApi.me().y,0,0),false,tooltipName,0,0,0,this._params.makerName,null,settings,null,true);
         }
      }
      
      private function _onUiUnload(name:String, options:Object) : void
      {
         var paramData:* = null;
         var idx:int = 0;
         if(name == this.uiApi.me().name && this._params)
         {
            for(paramData in _displayedPin)
            {
               if(paramData.hasOwnProperty("id") && this._params.data.hasOwnProperty("id") && paramData.id == this._params.data.id)
               {
                  delete _displayedPin[paramData];
               }
            }
            idx = _pinnedTooltipScripts.indexOf(this);
            if(idx > -1)
            {
               _pinnedTooltipScripts.splice(idx,1);
               if(_pinnedTooltipScripts.length)
               {
                  _pinnedTooltipScripts[_pinnedTooltipScripts.length - 1].backgroundCtr.borderColor = this.sysApi.getConfigEntry("colors.tooltip.border.activePin");
               }
            }
         }
      }
      
      public function highlightPinnedTooltip() : void
      {
         if(_pinnedTooltipScripts.length)
         {
            _pinnedTooltipScripts[_pinnedTooltipScripts.length - 1].backgroundCtr.borderColor = this.sysApi.getConfigEntry("colors.tooltip.border");
         }
         this.backgroundCtr.borderColor = this.sysApi.getConfigEntry("colors.tooltip.border.activePin");
         var idx:int = _pinnedTooltipScripts.indexOf(this);
         if(idx > -1)
         {
            _pinnedTooltipScripts.splice(idx,1);
         }
         _pinnedTooltipScripts.push(this);
      }
   }
}
