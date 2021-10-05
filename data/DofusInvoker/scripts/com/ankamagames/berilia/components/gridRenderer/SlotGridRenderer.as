package com.ankamagames.berilia.components.gridRenderer
{
   import com.ankamagames.berilia.UIComponent;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Slot;
   import com.ankamagames.berilia.interfaces.IClonable;
   import com.ankamagames.berilia.interfaces.IGridRenderer;
   import com.ankamagames.berilia.managers.LinkedCursorSpriteManager;
   import com.ankamagames.berilia.types.data.LinkedCursorData;
   import com.ankamagames.jerakine.interfaces.ISlotData;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.DisplayObject;
   import flash.geom.Point;
   import flash.utils.getQualifiedClassName;
   import gs.TweenMax;
   import gs.easing.Quart;
   import gs.events.TweenEvent;
   
   public class SlotGridRenderer implements IGridRenderer
   {
       
      
      protected var _log:Logger;
      
      private var _grid:Grid;
      
      private var _emptyTexture:Uri;
      
      private var _backgroundTexture:Uri;
      
      private var _overTexture:Uri;
      
      private var _selectedTexture:Uri;
      
      private var _acceptDragTexture:Uri;
      
      private var _refuseDragTexture:Uri;
      
      private var _timerTexture:Uri;
      
      private var _cssUri:Uri;
      
      private var _allowDrop:Boolean;
      
      private var _isButton:Boolean;
      
      private var _hideQuantities:Boolean = false;
      
      private var _useTextureCache:Boolean = true;
      
      private var _activeFunctionName:String = null;
      
      public var dropValidatorFunction:Function;
      
      public var processDropFunction:Function;
      
      public var removeDropSourceFunction:Function;
      
      public function SlotGridRenderer(strParams:String)
      {
         this._log = Log.getLogger(getQualifiedClassName(SlotGridRenderer));
         super();
         var params:Array = !!strParams ? strParams.split(",") : [];
         this._emptyTexture = params[0] && params[0].length ? new Uri(params[0]) : null;
         this._overTexture = params[1] && params[1].length ? new Uri(params[1]) : null;
         this._selectedTexture = params[2] && params[2].length ? new Uri(params[2]) : null;
         this._acceptDragTexture = params[3] && params[3].length ? new Uri(params[3]) : null;
         this._refuseDragTexture = params[4] && params[4].length ? new Uri(params[4]) : null;
         this._timerTexture = params[5] && params[5].length ? new Uri(params[5]) : null;
         this._cssUri = params[6] && params[6].length ? new Uri(params[6]) : null;
         this._allowDrop = params[7] && params[7].length ? params[7] == "true" : true;
         this._isButton = params[8] && params[8].length ? params[8] == "true" : false;
         this._useTextureCache = params[9] && params[9].length ? (params[9] == "true" ? true : false) : true;
         this._activeFunctionName = params[10] && params[10].length ? params[10] : null;
         this._backgroundTexture = params[11] && params[11].length ? new Uri(params[11]) : null;
      }
      
      public function set allowDrop(pAllow:Boolean) : void
      {
         this._allowDrop = pAllow;
      }
      
      public function get allowDrop() : Boolean
      {
         return this._allowDrop;
      }
      
      public function set isButton(pButton:Boolean) : void
      {
         this._isButton = pButton;
      }
      
      public function get isButton() : Boolean
      {
         return this._isButton;
      }
      
      public function set hideQuantities(value:Boolean) : void
      {
         this._hideQuantities = value;
      }
      
      public function get hideQuantities() : Boolean
      {
         return this._hideQuantities;
      }
      
      [Uri]
      public function get acceptDragTexture() : Uri
      {
         return this._acceptDragTexture;
      }
      
      [Uri]
      public function set acceptDragTexture(uri:Uri) : void
      {
         this._acceptDragTexture = uri;
      }
      
      [Uri]
      public function get refuseDragTexture() : Uri
      {
         return this._refuseDragTexture;
      }
      
      [Uri]
      public function set refuseDragTexture(uri:Uri) : void
      {
         this._refuseDragTexture = uri;
      }
      
      public function set grid(g:Grid) : void
      {
         this._grid = g;
      }
      
      public function set useTextureCache(pUseCache:Boolean) : void
      {
         this._useTextureCache = pUseCache;
      }
      
      public function get useTextureCache() : Boolean
      {
         return this._useTextureCache;
      }
      
      public function render(data:*, index:uint, selected:Boolean, subIndex:uint = 0) : DisplayObject
      {
         var slotData:* = data;
         var slot:Slot = new Slot();
         slot.name = this._grid.getUi().name + "::" + this._grid.name + "::item" + index;
         slot.mouseEnabled = true;
         slot.emptyTexture = this._emptyTexture;
         slot.forcedBackGroundIconUri = this._backgroundTexture;
         slot.highlightTexture = this._overTexture;
         slot.timerTexture = this._timerTexture;
         slot.selectedTexture = this._selectedTexture;
         slot.acceptDragTexture = this._acceptDragTexture;
         slot.refuseDragTexture = this._refuseDragTexture;
         slot.css = this._cssUri;
         slot.isButton = this._isButton;
         slot.useTextureCache = this._useTextureCache;
         slot.isActiveFunction = !!this._activeFunctionName ? this._grid.getUi().uiClass[this._activeFunctionName] : null;
         if(this._hideQuantities)
         {
            slot.hideTopLabel = true;
         }
         else
         {
            slot.hideTopLabel = false;
         }
         slot.width = this._grid.slotWidth;
         slot.height = this._grid.slotHeight;
         if(this._isButton)
         {
            slot.selected = selected;
         }
         else
         {
            slot.allowDrag = this._allowDrop;
         }
         slot.data = slotData;
         slot.processDrop = this._processDrop;
         slot.removeDropSource = this._removeDropSourceFunction;
         slot.dropValidator = this._dropValidatorFunction;
         slot.finalize();
         return slot;
      }
      
      public function _removeDropSourceFunction(target:*) : void
      {
         var data:* = undefined;
         if(this.removeDropSourceFunction != null)
         {
            this.removeDropSourceFunction(target);
            return;
         }
         var dp:Array = new Array();
         var addData:Boolean = true;
         for each(data in this._grid.dataProvider)
         {
            if(data != target.data)
            {
               dp.push(data);
            }
         }
         this._grid.dataProvider = dp;
      }
      
      public function _dropValidatorFunction(target:Object, iSlotData:*, source:Object) : Boolean
      {
         if(this.dropValidatorFunction != null)
         {
            return this.dropValidatorFunction(target,iSlotData,source);
         }
         return true;
      }
      
      public function update(data:*, index:uint, dispObj:DisplayObject, selected:Boolean, subIndex:uint = 0) : void
      {
         var slot:Slot = null;
         if(dispObj is Slot)
         {
            slot = Slot(dispObj);
            slot.width = this._grid.slotWidth;
            slot.height = this._grid.slotHeight;
            slot.data = data as ISlotData;
            if(!this._isButton)
            {
               slot.selected = selected;
               slot.allowDrag = this._allowDrop;
            }
            slot.isButton = this._isButton;
            if(this._hideQuantities)
            {
               slot.hideTopLabel = true;
            }
            else
            {
               slot.hideTopLabel = false;
            }
            slot.dropValidator = this._dropValidatorFunction;
            slot.removeDropSource = this._removeDropSourceFunction;
            slot.processDrop = this._processDrop;
            if(data && getQualifiedClassName(data).indexOf("ItemWrapper") != -1 && !data.linked && data.forcedBackGroundIconUri && data.forcedBackGroundIconUri.fileName.indexOf("linkedSlot") != -1)
            {
               data.forcedBackGroundIconUri = null;
               slot.refresh();
            }
         }
         else
         {
            this._log.warn("Can\'t update, " + dispObj.name + " is not a Slot component");
         }
      }
      
      public function getDataLength(data:*, selected:Boolean) : uint
      {
         return 1;
      }
      
      public function remove(dispObj:DisplayObject) : void
      {
         if(dispObj is Slot && dispObj.parent)
         {
            Slot(dispObj).remove();
         }
      }
      
      public function destroy() : void
      {
         this._grid = null;
         this._emptyTexture = null;
         this._backgroundTexture = null;
         this._overTexture = null;
         this._timerTexture = null;
         this._selectedTexture = null;
         this._acceptDragTexture = null;
         this._refuseDragTexture = null;
         this._cssUri = null;
      }
      
      public function _processDrop(target:*, data:*, source:*) : void
      {
         var linkCursor:LinkedCursorData = null;
         var pt:Point = null;
         var tweenTarget:DisplayObject = null;
         if(!this._allowDrop)
         {
            return;
         }
         if(this.processDropFunction != null)
         {
            this.processDropFunction(target,data,source);
            return;
         }
         var sameGrid:Boolean = false;
         if(DisplayObject(data.holder).parent != this._grid)
         {
            if(data is IClonable)
            {
               this._grid.dataProvider.push((data as IClonable).clone());
            }
            else
            {
               this._grid.dataProvider.push(data);
            }
            this._grid.dataProvider = this._grid.dataProvider;
         }
         else
         {
            sameGrid = true;
         }
         linkCursor = LinkedCursorSpriteManager.getInstance().getItem(Slot.DRAG_AND_DROP_CURSOR_NAME);
         if(sameGrid || !this._grid.indexIsInvisibleSlot(this._grid.dataProvider.length - 1))
         {
            tweenTarget = DisplayObject(data.holder);
            pt = tweenTarget.localToGlobal(new Point(tweenTarget.x,tweenTarget.y));
            TweenMax.to(linkCursor.sprite,0.5,{
               "x":pt.x,
               "y":pt.y,
               "alpha":0,
               "ease":Quart.easeOut,
               "onCompleteListener":this.onTweenEnd
            });
         }
         else
         {
            pt = this._grid.localToGlobal(new Point(this._grid.x,this._grid.y));
            linkCursor.sprite.stopDrag();
            TweenMax.to(linkCursor.sprite,0.5,{
               "x":pt.x + this._grid.width / 2,
               "y":pt.y + this._grid.height,
               "alpha":0,
               "scaleX":0.1,
               "scaleY":0.1,
               "ease":Quart.easeOut,
               "onCompleteListener":this.onTweenEnd
            });
         }
      }
      
      public function renderModificator(childs:Array) : Array
      {
         return childs;
      }
      
      public function eventModificator(msg:Message, functionName:String, args:Array, target:UIComponent) : String
      {
         return functionName;
      }
      
      private function onTweenEnd(e:TweenEvent) : void
      {
         LinkedCursorSpriteManager.getInstance().removeItem(Slot.DRAG_AND_DROP_CURSOR_NAME);
      }
   }
}
