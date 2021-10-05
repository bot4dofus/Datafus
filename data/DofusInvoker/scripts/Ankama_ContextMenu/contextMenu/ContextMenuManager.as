package Ankama_ContextMenu.contextMenu
{
   import Ankama_ContextMenu.Api;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.BeriliaHookList;
   import com.ankamagames.dofus.misc.lists.HookList;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import flash.utils.setTimeout;
   
   public class ContextMenuManager
   {
      
      private static var _self:ContextMenuManager;
       
      
      private var _contextMenuTree:Array;
      
      private var _currentFocus:UiRootContainer;
      
      private var _cancelNextClick:Boolean = false;
      
      private var _openDate:uint;
      
      private var _closeCallback:Function;
      
      public var mainUiLoaded:Boolean;
      
      public function ContextMenuManager()
      {
         this._contextMenuTree = [];
         super();
         if(_self)
         {
            new Error("Singleton Error");
         }
         Api.system.addHook(BeriliaHookList.MouseClick,this.onGenericMouseClick);
         Api.system.addHook(HookList.CloseContextMenu,this.closeAll);
      }
      
      public static function getInstance() : ContextMenuManager
      {
         if(!_self)
         {
            _self = new ContextMenuManager();
         }
         return _self;
      }
      
      public static function unload() : void
      {
         _self = null;
      }
      
      public function openNew(menu:Array, positionReference:Object = null, closeCallback:Function = null, directOpen:Boolean = false, instanceName:String = null, pContainer:UiRootContainer = null) : void
      {
         var container:UiRootContainer = null;
         var ui:Object = null;
         if(menu == null)
         {
            return;
         }
         if(!directOpen)
         {
            setTimeout(this.openNew,1,menu,positionReference,closeCallback,true,instanceName,pContainer);
            return;
         }
         if(menu.length > 0)
         {
            if(this._contextMenuTree.length)
            {
               for each(ui in this._contextMenuTree)
               {
                  Api.ui.unloadUi(ui.name);
               }
               if(this._closeCallback != null)
               {
                  this._closeCallback();
               }
            }
            this._openDate = getTimer();
            this._closeCallback = closeCallback;
            this._contextMenuTree = [];
            this.mainUiLoaded = false;
            if(pContainer)
            {
               container = Api.ui.loadUiInside("contextMenu",pContainer,!instanceName ? "Ankama_ContextMenu" : instanceName,[menu,positionReference]);
            }
            else
            {
               container = Api.ui.loadUi("contextMenu",!instanceName ? "Ankama_ContextMenu" : instanceName,[menu,positionReference],3);
            }
            this._contextMenuTree.push(container);
         }
      }
      
      public function openChild(args:Object) : void
      {
         var container:UiRootContainer = this._contextMenuTree[0];
         if(container.parentUiRoot && container.parentUiRoot.windowOwner)
         {
            this._contextMenuTree.push(Api.ui.loadUiInside("contextMenu",container.parentUiRoot,"Ankama_SubContextMenu" + this._contextMenuTree.length,args));
         }
         else
         {
            this._contextMenuTree.push(Api.ui.loadUi("contextMenu","Ankama_SubContextMenu" + this._contextMenuTree.length,args,3));
         }
      }
      
      public function closeChild(contextMenuChild:UiRootContainer) : void
      {
         if(this._contextMenuTree.indexOf(contextMenuChild) == -1)
         {
            return;
         }
         while(this._contextMenuTree.length && this._contextMenuTree[this._contextMenuTree.length - 1] != contextMenuChild)
         {
            Api.ui.unloadUi(this._contextMenuTree.pop().name);
         }
      }
      
      public function closeAll() : void
      {
         if(!this._contextMenuTree.length)
         {
            return;
         }
         while(this._contextMenuTree.length)
         {
            Api.ui.unloadUi(this._contextMenuTree.pop().name);
         }
         if(this._closeCallback != null)
         {
            this._closeCallback();
         }
      }
      
      public function childHasFocus(contextMenu:UiRootContainer) : Boolean
      {
         for(var i:uint = this._contextMenuTree.length - 1; i >= 0; i--)
         {
            if(this._contextMenuTree[i] == contextMenu)
            {
               return false;
            }
            if(this._contextMenuTree[i] == this._currentFocus)
            {
               return true;
            }
         }
         return false;
      }
      
      public function setCurrentFocus(contextMenu:UiRootContainer) : void
      {
         this._currentFocus = contextMenu;
      }
      
      public function placeMe(pContextMenu:UiRootContainer, mainCtr:GraphicContainer, startPoint:Point, targetHeight:Number = 0) : void
      {
         var p:UiRootContainer = null;
         var p2:UiRootContainer = null;
         var visibleStageBounds:Rectangle = Api.ui.getVisibleStageBounds();
         var newX:int = startPoint.x;
         var newY:int = startPoint.y;
         if(newX + mainCtr.width > visibleStageBounds.right)
         {
            p = this.getParent(pContextMenu);
            if(p)
            {
               newX = p.getElement("mainCtr").x - mainCtr.width;
            }
            else
            {
               newX = startPoint.x - mainCtr.width;
            }
         }
         if(newY + mainCtr.height > visibleStageBounds.bottom)
         {
            p2 = this.getParent(pContextMenu);
            if(p2)
            {
               newY = newY - mainCtr.height + targetHeight;
            }
            else
            {
               newY = startPoint.y - mainCtr.height;
            }
         }
         if(newX < visibleStageBounds.left)
         {
            newX = visibleStageBounds.left;
         }
         if(newY < visibleStageBounds.top)
         {
            newY = visibleStageBounds.top;
         }
         mainCtr.x = newX;
         mainCtr.y = newY;
         if(pContextMenu.parentUiRoot && pContextMenu.parentUiRoot.windowOwner)
         {
            if(mainCtr.y + mainCtr.height > pContextMenu.parentUiRoot.windowOwner.bounds.height)
            {
               pContextMenu.parentUiRoot.windowOwner.height += mainCtr.y + mainCtr.height - pContextMenu.parentUiRoot.windowOwner.bounds.height;
            }
         }
      }
      
      public function getTopParent() : UiRootContainer
      {
         return this._contextMenuTree[0];
      }
      
      public function getParent(contextMenu:UiRootContainer) : UiRootContainer
      {
         for(var i:uint = 0; i < this._contextMenuTree.length; i++)
         {
            if(this._contextMenuTree[i] == contextMenu)
            {
               return this._contextMenuTree[i - 1];
            }
         }
         return this._contextMenuTree[this._contextMenuTree.length - 1];
      }
      
      private function onGenericMouseClick(target:DisplayObject) : void
      {
         var ui:Object = null;
         try
         {
            ui = target is GraphicContainer ? (target as GraphicContainer).getUi() : null;
         }
         catch(e:Error)
         {
         }
         if(!ui || this._contextMenuTree.indexOf(ui) == -1)
         {
            this.closeAll();
         }
      }
   }
}
