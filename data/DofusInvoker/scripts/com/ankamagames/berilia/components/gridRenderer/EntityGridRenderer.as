package com.ankamagames.berilia.components.gridRenderer
{
   import com.ankamagames.berilia.UIComponent;
   import com.ankamagames.berilia.components.EntityDisplayer;
   import com.ankamagames.berilia.components.Grid;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.interfaces.IGridRenderer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.getQualifiedClassName;
   
   public class EntityGridRenderer implements IGridRenderer
   {
       
      
      protected var _log:Logger;
      
      private var _grid:Grid;
      
      private var _emptyTexture:Uri;
      
      private var _placeholderTexture:Uri;
      
      private var _mask:Sprite;
      
      public function EntityGridRenderer(strParams:String)
      {
         this._log = Log.getLogger(getQualifiedClassName(EntityGridRenderer));
         super();
         var params:Array = !!strParams ? strParams.split(",") : [];
         this._emptyTexture = params[0] && params[0].length ? new Uri(params[0]) : null;
         this._placeholderTexture = params[1] && params[1].length ? new Uri(params[1]) : null;
         this._mask = new Sprite();
      }
      
      public function set grid(g:Grid) : void
      {
         this._grid = g;
      }
      
      public function render(data:*, index:uint, selected:Boolean, subIndex:uint = 0) : DisplayObject
      {
         var background:Texture = null;
         var entDisp:EntityDisplayer = null;
         var placeholder:Texture = null;
         var ctr:GraphicContainer = new GraphicContainer();
         ctr.mouseEnabled = true;
         background = new Texture();
         background.width = this._grid.slotWidth;
         background.height = this._grid.slotHeight;
         background.uri = this._emptyTexture;
         background.finalize();
         ctr.addChild(background);
         ctr.width = this._grid.slotWidth;
         ctr.height = this._grid.slotHeight;
         if(data)
         {
            entDisp = new EntityDisplayer();
            entDisp.name = "entity";
            entDisp.width = this._grid.slotWidth;
            entDisp.height = this._grid.slotHeight;
            entDisp.direction = 3;
            entDisp.entityScale = 2;
            entDisp.yOffset = 20;
            entDisp.look = data.entityLook;
            ctr.addChild(entDisp);
            this._mask = new Sprite();
            this._mask.graphics.beginFill(16711680);
            this._mask.graphics.drawRoundRect(3,3,ctr.width - 6,ctr.height - 6,6,6);
            this._mask.graphics.endFill();
            ctr.addChild(this._mask);
            entDisp.mask = this._mask;
         }
         else
         {
            placeholder = new Texture();
            this.initPlaceholder(placeholder);
            ctr.addChild(placeholder);
         }
         return ctr;
      }
      
      public function update(data:*, index:uint, dispObj:DisplayObject, selected:Boolean, subIndex:uint = 0) : void
      {
         var ctr:GraphicContainer = null;
         var ed:EntityDisplayer = null;
         var placeholder:Texture = null;
         var entDisp:EntityDisplayer = null;
         if(dispObj is GraphicContainer)
         {
            ctr = GraphicContainer(dispObj);
            ctr.mouseEnabled = true;
            ed = ctr.getChildByName("entity") as EntityDisplayer;
            placeholder = ctr.getChildByName("placeholder") as Texture;
            if(data)
            {
               if(ed)
               {
                  if(ed.look.toString() == data.entityLook.toString())
                  {
                     return;
                  }
                  ed.look = data.entityLook;
               }
               else
               {
                  entDisp = new EntityDisplayer();
                  entDisp.name = "entity";
                  entDisp.width = this._grid.slotWidth;
                  entDisp.height = this._grid.slotHeight;
                  entDisp.look = data.entityLook;
                  entDisp.direction = 3;
                  entDisp.entityScale = 2;
                  entDisp.yOffset = 20;
                  ctr.addChild(entDisp);
                  this._mask = new Sprite();
                  this._mask.graphics.beginFill(255);
                  this._mask.graphics.drawRoundRect(3,3,ctr.width - 6,ctr.height - 6,6,6);
                  this._mask.graphics.endFill();
                  ctr.addChild(this._mask);
                  entDisp.mask = this._mask;
               }
               if(placeholder)
               {
                  ctr.removeChild(placeholder);
                  placeholder.remove();
               }
            }
            else
            {
               if(ed)
               {
                  ctr.removeChild(ed);
                  if(this._mask && ctr.getChildByName(this._mask.name))
                  {
                     ctr.removeChild(this._mask);
                  }
                  ed.remove();
               }
               if(!placeholder)
               {
                  placeholder = new Texture();
                  this.initPlaceholder(placeholder);
                  ctr.addChild(placeholder);
               }
            }
         }
      }
      
      private function initPlaceholder(placeholder:Texture) : void
      {
         placeholder.name = "placeholder";
         placeholder.width = this._grid.slotWidth - 5;
         placeholder.height = this._grid.slotHeight - 5;
         placeholder.x = 2;
         placeholder.y = 2;
         placeholder.alpha = 0.5;
         placeholder.uri = this._placeholderTexture;
         placeholder.finalize();
      }
      
      public function getDataLength(data:*, selected:Boolean) : uint
      {
         return data % 2;
      }
      
      public function remove(dispObj:DisplayObject) : void
      {
         var ed:EntityDisplayer = null;
         var mask:DisplayObject = null;
         if(dispObj is GraphicContainer)
         {
            ed = GraphicContainer(dispObj).getChildByName("entity") as EntityDisplayer;
            if(ed)
            {
               ed.remove();
            }
            mask = GraphicContainer(dispObj).getChildByName(this._mask.name);
            if(mask)
            {
               GraphicContainer(dispObj).removeChild(mask);
            }
            GraphicContainer(dispObj).remove();
         }
      }
      
      public function destroy() : void
      {
         this._grid = null;
         this._emptyTexture = null;
         this._placeholderTexture = null;
         this._mask = null;
      }
      
      public function renderModificator(childs:Array) : Array
      {
         return childs;
      }
      
      public function eventModificator(msg:Message, functionName:String, args:Array, target:UIComponent) : String
      {
         return functionName;
      }
   }
}
