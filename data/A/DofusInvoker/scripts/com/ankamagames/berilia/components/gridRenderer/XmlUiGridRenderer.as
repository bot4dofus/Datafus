package com.ankamagames.berilia.components.gridRenderer
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.UIComponent;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.params.GridScriptProperties;
   import com.ankamagames.berilia.interfaces.IGridRenderer;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.event.UiRenderEvent;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.berilia.utils.errors.BeriliaError;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   import flash.geom.Transform;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class XmlUiGridRenderer implements IGridRenderer
   {
       
      
      protected var _log:Logger;
      
      private var _sUiName:String;
      
      private var _sUiModule:String;
      
      private var _ctr:Sprite;
      
      private var _berilia:Berilia;
      
      private var _uiCtr:UiRootContainer;
      
      private var _grid:Grid;
      
      private var _bgColor1:ColorTransform;
      
      private var _bgColor2:ColorTransform;
      
      private var _bgColor3:ColorTransform;
      
      private var _shapeIndex:Dictionary;
      
      private var _dWaitingUpdate:Dictionary;
      
      public function XmlUiGridRenderer(args:String)
      {
         var tmp:Array = null;
         this._log = Log.getLogger(getQualifiedClassName(XmlUiGridRenderer));
         this._berilia = Berilia.getInstance();
         this._shapeIndex = new Dictionary(true);
         this._dWaitingUpdate = new Dictionary(true);
         super();
         var params:Array = args.split(",");
         var uiName:String = params[0];
         if(params[1])
         {
            this._bgColor1 = new ColorTransform();
            this._bgColor1.color = parseInt(params[1],16);
            if(params[1].length > 8)
            {
               this._bgColor1.alphaMultiplier = ((parseInt(params[1],16) & 4278190080) >> 24) / 255;
            }
         }
         if(params[2])
         {
            this._bgColor2 = new ColorTransform();
            this._bgColor2.color = parseInt(params[2],16);
            if(params[2].length > 8)
            {
               this._bgColor2.alphaMultiplier = ((parseInt(params[2],16) & 4278190080) >> 24) / 255;
            }
         }
         if(params[3])
         {
            this._bgColor3 = new ColorTransform();
            this._bgColor3.color = parseInt(params[3],16);
            if(params[3].length > 8)
            {
               this._bgColor3.alphaMultiplier = ((parseInt(params[3],16) & 4278190080) >> 24) / 255;
            }
         }
         if(uiName.indexOf("::") != -1)
         {
            tmp = uiName.split("::");
            if(!UiModuleManager.getInstance().getModules()[tmp[0]])
            {
               throw new BeriliaError("Module [" + tmp[0] + "] does not exit (grid parameter name [" + uiName + "])");
            }
            this._sUiModule = tmp[0];
            if(!UiModule(UiModuleManager.getInstance().getModules()[tmp[0]]).uis[tmp[1]])
            {
               throw new BeriliaError("Ui [" + tmp[1] + "] does not exit in module [" + tmp[0] + "] (grid parameter name [" + uiName + "])");
            }
            this._sUiName = tmp[1];
         }
         else
         {
            this._sUiName = uiName;
         }
      }
      
      public function set grid(g:Grid) : void
      {
         this._grid = g;
      }
      
      public function render(data:*, index:uint, selected:Boolean, subIndex:uint = 0) : DisplayObject
      {
         var bgColor:ColorTransform = null;
         var mainUi:UiRootContainer = this._grid.getUi();
         this._uiCtr = new UiRootContainer(StageShareManager.stage,mainUi.uiModule.uis[this._sUiName],this._ctr);
         this._uiCtr.uiModule = mainUi.uiModule;
         this._uiCtr.addEventListener(UiRenderEvent.UIRenderComplete,this.onItemUiLoaded);
         this._uiCtr.mouseEnabled = true;
         if(!mainUi.uiModule.uis[this._sUiName])
         {
            throw new BeriliaError("Ui [" + this._sUiName + "] does not exit in module [" + this._uiCtr.uiModule.id + "] (grid parameter name [" + this._sUiName + "])");
         }
         if(!selected)
         {
            bgColor = !!(index % 2) ? this._bgColor1 : this._bgColor2;
         }
         else
         {
            bgColor = this._bgColor3;
         }
         this.updateBackground(this._uiCtr,bgColor);
         this._berilia.loadUiInside(mainUi.uiModule.uis[this._sUiName],this._uiCtr.name,this._uiCtr,null,new GridScriptProperties(data,selected,this._grid));
         return this._uiCtr;
      }
      
      public function update(data:*, index:uint, dispObj:DisplayObject, selected:Boolean, subIndex:uint = 0) : void
      {
         var bgColor:ColorTransform = null;
         if(dispObj is UiRootContainer)
         {
            if(UiRootContainer(dispObj).ready && Object(UiRootContainer(dispObj).uiClass))
            {
               if(Object(UiRootContainer(dispObj).uiClass).data != null || data != null)
               {
                  if(!selected)
                  {
                     bgColor = !!(index % 2) ? this._bgColor1 : this._bgColor2;
                  }
                  else
                  {
                     bgColor = this._bgColor3;
                  }
                  this.updateBackground(UiRootContainer(dispObj),bgColor);
                  Object(UiRootContainer(dispObj).uiClass).update(data,selected);
               }
            }
            else
            {
               this._dWaitingUpdate[dispObj] = new WaitingUpdate(data,index,dispObj,selected,true);
            }
         }
         else
         {
            this._log.warn("Can\'t update, " + dispObj.name + " is not a SecureUi");
         }
      }
      
      public function getDataLength(data:*, selected:Boolean) : uint
      {
         return 1;
      }
      
      public function remove(dispObj:DisplayObject) : void
      {
         if(dispObj is UiRootContainer)
         {
            Berilia.getInstance().unloadUi(UiRootContainer(dispObj).name);
         }
      }
      
      public function destroy() : void
      {
         if(this._uiCtr)
         {
            this._uiCtr.removeEventListener(UiRenderEvent.UIRenderComplete,this.onItemUiLoaded);
         }
         this._berilia = null;
         this._uiCtr = null;
         this._grid = null;
      }
      
      public function renderModificator(childs:Array) : Array
      {
         return childs;
      }
      
      public function eventModificator(msg:Message, functionName:String, args:Array, target:UIComponent) : String
      {
         return functionName;
      }
      
      private function onItemUiLoaded(e:UiRenderEvent) : void
      {
         var data:WaitingUpdate = null;
         if(this._dWaitingUpdate[e.uiTarget])
         {
            data = this._dWaitingUpdate[e.uiTarget];
            this.update(data.data,data.index,data.dispObj,data.selected);
            this._dWaitingUpdate[e.uiTarget] = null;
         }
      }
      
      private function updateBackground(uiContainer:UiRootContainer, color:ColorTransform) : void
      {
         var shape:Shape = null;
         if(this._bgColor1 || this._bgColor2)
         {
            if(!this._shapeIndex[uiContainer])
            {
               shape = new Shape();
               shape.graphics.beginFill(16777215);
               shape.graphics.drawRect(0,0,this._grid.slotWidth,this._grid.slotHeight);
               this._uiCtr.getStrata(0).addChild(shape);
               this._shapeIndex[uiContainer] = {
                  "trans":new Transform(shape),
                  "shape":shape
               };
            }
            DisplayObject(this._shapeIndex[uiContainer].shape).visible = color != null;
            if(color)
            {
               Transform(this._shapeIndex[uiContainer].trans).colorTransform = color;
            }
         }
      }
   }
}

import flash.display.DisplayObject;

class WaitingUpdate
{
    
   
   public var data;
   
   public var index;
   
   public var selected:Boolean;
   
   public var drawBackground:Boolean;
   
   public var dispObj:DisplayObject;
   
   function WaitingUpdate(data:*, index:uint, dispObj:DisplayObject, selected:Boolean, drawBackground:Boolean)
   {
      super();
      this.data = data;
      this.selected = selected;
      this.drawBackground = drawBackground;
      this.dispObj = dispObj;
      this.index = index;
   }
}
