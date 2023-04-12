package com.ankamagames.berilia.components.gridRenderer
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.UIComponent;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.Tree;
   import com.ankamagames.berilia.interfaces.IGridRenderer;
   import com.ankamagames.berilia.types.data.TreeData;
   import com.ankamagames.jerakine.interfaces.IInterfaceListener;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.ColorTransform;
   import flash.geom.Transform;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class TreeGridRenderer implements IGridRenderer
   {
       
      
      protected var _log:Logger;
      
      private var _grid:Grid;
      
      private var _bgColor1:ColorTransform;
      
      private var _bgColor2:ColorTransform;
      
      private var _selectedColor:ColorTransform;
      
      private var _overColor:ColorTransform;
      
      private var _cssUri:Uri;
      
      private var _expendBtnUri:Uri;
      
      private var _simpleItemUri:Uri;
      
      private var _endItemUri:Uri;
      
      private var _shapeIndex:Dictionary;
      
      private var _indexRef:Dictionary;
      
      private var _uriRef:Array;
      
      public function TreeGridRenderer(strParams:String)
      {
         var params:Array = null;
         this._log = Log.getLogger(getQualifiedClassName(TreeGridRenderer));
         this._shapeIndex = new Dictionary(true);
         this._indexRef = new Dictionary(true);
         this._uriRef = new Array();
         super();
         if(strParams)
         {
            params = !!strParams.length ? strParams.split(",") : null;
            if(params[0] && params[0].length)
            {
               this._cssUri = new Uri(params[0]);
            }
            if(params[1] && params[1].length)
            {
               this._bgColor1 = new ColorTransform();
               this._bgColor1.color = parseInt(params[1],16);
               if(params[1].length > 8)
               {
                  this._bgColor1.alphaMultiplier = ((parseInt(params[1],16) & 4278190080) >> 24) / 255;
               }
            }
            if(params[2] && params[2].length)
            {
               this._bgColor2 = new ColorTransform();
               this._bgColor2.color = parseInt(params[2],16);
               if(params[2].length > 8)
               {
                  this._bgColor2.alphaMultiplier = ((parseInt(params[2],16) & 4278190080) >> 24) / 255;
               }
            }
            if(params[3] && params[3].length)
            {
               this._overColor = new ColorTransform();
               this._overColor.color = parseInt(params[3],16);
               if(params[3].length > 8)
               {
                  this._overColor.alphaMultiplier = ((parseInt(params[3],16) & 4278190080) >> 24) / 255;
               }
            }
            if(params[4] && params[4].length)
            {
               this._selectedColor = new ColorTransform();
               this._selectedColor.color = parseInt(params[4],16);
               if(params[4].length > 8)
               {
                  this._selectedColor.alphaMultiplier = ((parseInt(params[4],16) & 4278190080) >> 24) / 255;
               }
            }
            if(params[5] && params[5].length)
            {
               this._expendBtnUri = new Uri(params[5]);
            }
            if(params[6] && params[6].length)
            {
               this._simpleItemUri = new Uri(params[6]);
            }
            if(params[7] && params[7].length)
            {
               this._endItemUri = new Uri(params[7]);
            }
         }
      }
      
      public function set grid(g:Grid) : void
      {
         this._grid = g;
      }
      
      public function render(data:*, index:uint, selected:Boolean, subIndex:uint = 0) : DisplayObject
      {
         var raw:Sprite = new Sprite();
         raw.mouseEnabled = false;
         this._indexRef[raw] = data;
         var treeData:TreeData = data;
         var texture:Texture = new Texture();
         texture.mouseEnabled = true;
         texture.width = 10;
         texture.height = this._grid.slotHeight + 1;
         texture.y = (this._grid.slotHeight - 18) / 2;
         if(treeData)
         {
            texture.x = treeData.depth * texture.width;
            if(treeData.children && treeData.children.length)
            {
               texture.uri = this._expendBtnUri;
               texture.buttonMode = true;
            }
            else if(treeData.parent.children.indexOf(treeData) == treeData.parent.children.length - 1)
            {
               texture.uri = this._endItemUri;
            }
            else
            {
               texture.uri = this._simpleItemUri;
            }
            if(treeData.expend)
            {
               texture.gotoAndStop = "selected";
            }
            else
            {
               texture.gotoAndStop = "normal";
            }
         }
         texture.finalize();
         var label:Label = new Label();
         label.mouseEnabled = true;
         label.useHandCursor = true;
         label.x = texture.x + texture.width + 3;
         label.width = this._grid.slotWidth - label.x;
         label.height = this._grid.slotHeight;
         if(data && data.value.hasOwnProperty("css"))
         {
            if(data.css is String)
            {
               if(!this._uriRef[data.value.css])
               {
                  this._uriRef[data.value.css] = new Uri(data.value.css);
               }
               label.css = this._uriRef[data.value.css];
            }
            else
            {
               label.css = data.value.css;
            }
            if(data.value.hasOwnProperty("cssClass"))
            {
               label.cssClass = data.value.cssClass;
            }
         }
         if(data is String || data == null)
         {
            label.text = data;
         }
         else
         {
            label.text = data.label;
         }
         if(this._cssUri)
         {
            label.css = this._cssUri;
         }
         this.updateBackground(raw,index,selected);
         label.addEventListener(MouseEvent.MOUSE_OVER,this.onRollOver);
         label.addEventListener(MouseEvent.MOUSE_OUT,this.onRollOut);
         texture.addEventListener(MouseEvent.CLICK,this.onRelease);
         label.finalize();
         raw.addChild(texture);
         raw.addChild(label);
         return raw;
      }
      
      public function getDataLength(data:*, selected:Boolean) : uint
      {
         return 1;
      }
      
      public function update(data:*, index:uint, dispObj:DisplayObject, selected:Boolean, subIndex:uint = 0) : void
      {
         var treeData:TreeData = null;
         var texture:Texture = null;
         var label:Label = null;
         if(dispObj is Sprite)
         {
            treeData = data;
            this._indexRef[dispObj] = treeData;
            texture = Sprite(dispObj).getChildAt(1) as Texture;
            label = Sprite(dispObj).getChildAt(2) as Label;
            if(treeData != null)
            {
               texture.x = treeData.depth * 10 + 3;
               if(treeData.children && treeData.children.length)
               {
                  texture.uri = this._expendBtnUri;
                  if(treeData.expend)
                  {
                     texture.gotoAndStop = "selected";
                  }
                  else
                  {
                     texture.gotoAndStop = "normal";
                  }
               }
               else if(treeData.parent.children.indexOf(treeData) == treeData.parent.children.length - 1)
               {
                  texture.uri = this._endItemUri;
               }
               else
               {
                  texture.uri = this._simpleItemUri;
               }
               label.x = texture.x + texture.width + 3;
               label.width = this._grid.slotWidth - label.x;
               label.css = this._cssUri;
               label.cssClass = "";
               if(data && data.value.hasOwnProperty("css"))
               {
                  if(data.value.css is String)
                  {
                     if(!this._uriRef[data.value.css])
                     {
                        this._uriRef[data.value.css] = new Uri(data.value.css);
                     }
                     label.css = this._uriRef[data.value.css];
                  }
                  else
                  {
                     label.css = data.value.css;
                  }
                  if(data.value.hasOwnProperty("cssClass"))
                  {
                     label.cssClass = data.value.cssClass;
                  }
               }
               label.text = treeData.label;
               label.finalize();
            }
            else
            {
               label.text = "";
               texture.uri = null;
            }
            this.updateBackground(dispObj as Sprite,index,selected);
         }
         else
         {
            this._log.warn("Can\'t update, " + dispObj.name + " is not a Sprite");
         }
      }
      
      public function remove(dispObj:DisplayObject) : void
      {
         var label:Label = null;
         var tx:Texture = null;
         this._indexRef[dispObj] = null;
         if(dispObj is Label)
         {
            label = dispObj as Label;
            if(label.parent)
            {
               label.parent.removeChild(dispObj);
            }
            label.removeEventListener(MouseEvent.MOUSE_OUT,this.onRollOut);
            label.removeEventListener(MouseEvent.MOUSE_OVER,this.onRollOver);
         }
         else if(dispObj is Texture)
         {
            tx = dispObj as Texture;
            if(tx.parent)
            {
               tx.parent.removeChild(dispObj);
            }
            tx.removeEventListener(MouseEvent.CLICK,this.onRelease);
         }
      }
      
      public function destroy() : void
      {
         this._grid = null;
         this._shapeIndex = null;
      }
      
      public function renderModificator(childs:Array) : Array
      {
         return childs;
      }
      
      public function eventModificator(msg:Message, functionName:String, args:Array, target:UIComponent) : String
      {
         return functionName;
      }
      
      private function updateBackground(raw:Sprite, index:uint, selected:Boolean) : void
      {
         var shape:Shape = null;
         if(!this._shapeIndex[raw])
         {
            shape = new Shape();
            shape.graphics.beginFill(16777215);
            shape.graphics.drawRect(0,0,this._grid.slotWidth,this._grid.slotHeight + 1);
            raw.addChildAt(shape,0);
            this._shapeIndex[raw] = {
               "trans":new Transform(shape),
               "shape":shape
            };
         }
         var t:ColorTransform = !!(index % 2) ? this._bgColor1 : this._bgColor2;
         if(selected && this._selectedColor)
         {
            t = this._selectedColor;
         }
         this._shapeIndex[raw].currentColor = t;
         DisplayObject(this._shapeIndex[raw].shape).visible = t != null;
         if(t)
         {
            Transform(this._shapeIndex[raw].trans).colorTransform = t;
         }
      }
      
      private function onRollOver(e:MouseEvent) : void
      {
         var raw:Sprite = null;
         if(e.target.name.indexOf("extension") == -1 && e.target.text.length)
         {
            raw = e.target.parent as Sprite;
            if(this._overColor)
            {
               Transform(this._shapeIndex[raw].trans).colorTransform = this._overColor;
               DisplayObject(this._shapeIndex[raw].shape).visible = true;
            }
         }
      }
      
      private function onRollOut(e:MouseEvent) : void
      {
         var raw:Sprite = null;
         if(e.target.name.indexOf("extension") == -1)
         {
            raw = e.target.parent as Sprite;
            if(this._shapeIndex[raw])
            {
               if(this._shapeIndex[raw].currentColor)
               {
                  Transform(this._shapeIndex[raw].trans).colorTransform = this._shapeIndex[raw].currentColor;
               }
               DisplayObject(this._shapeIndex[raw].shape).visible = this._shapeIndex[raw].currentColor != null;
            }
         }
      }
      
      private function onRelease(e:MouseEvent) : void
      {
         var listener:IInterfaceListener = null;
         var data:TreeData = this._indexRef[e.target.parent];
         data.expend = !data.expend;
         Tree(this._grid).rerender();
         for each(listener in Berilia.getInstance().UISoundListeners)
         {
            listener.playUISound("16004");
         }
      }
   }
}
