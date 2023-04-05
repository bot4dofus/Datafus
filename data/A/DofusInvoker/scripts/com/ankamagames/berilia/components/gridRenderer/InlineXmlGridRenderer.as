package com.ankamagames.berilia.components.gridRenderer
{
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.ColorTransform;
   
   public class InlineXmlGridRenderer extends MultiGridRenderer
   {
       
      
      private var _bgColor3:ColorTransform;
      
      public function InlineXmlGridRenderer(args:String)
      {
         super(null);
         var params:Array = args.split(",");
         _updateFunctionName = params[0];
         if(params[1])
         {
            _bgColor1 = new ColorTransform();
            _bgColor1.color = parseInt(params[1],16) & 16777215;
            if(params[1].length > 8)
            {
               _bgColor1.alphaMultiplier = ((parseInt(params[1],16) & 4278190080) >> 24) / 255;
            }
         }
         if(params[2])
         {
            _bgColor2 = new ColorTransform();
            _bgColor2.color = parseInt(params[2],16) & 16777215;
            if(params[2].length > 8)
            {
               _bgColor2.alphaMultiplier = ((parseInt(params[2],16) & 4278190080) >> 24) / 255;
            }
         }
         if(params[3])
         {
            _bgColor1.alphaMultiplier = parseInt(params[3]);
            _bgColor2.alphaMultiplier = parseInt(params[3]);
         }
         if(params[4])
         {
            this._bgColor3 = new ColorTransform();
            this._bgColor3.color = parseInt(params[4],16) & 16777215;
            if(params[4].length > 8)
            {
               this._bgColor3.alphaMultiplier = ((parseInt(params[4],16) & 4278190080) >> 24) / 255;
            }
         }
         _defaultLineType = "default";
      }
      
      override public function update(data:*, index:uint, target:DisplayObject, selected:Boolean, subIndex:uint = 0) : void
      {
         var s:Sprite = null;
         super.update(data,index,target,selected,subIndex);
         if(target is Sprite && selected && this._bgColor3)
         {
            s = target as Sprite;
            s.graphics.beginFill(this._bgColor3.color,this._bgColor3.alphaMultiplier);
            s.graphics.drawRect(0,0,_grid.slotWidth,_grid.slotHeight);
            s.graphics.endFill();
         }
      }
      
      override protected function uiUpdate(ui:UiRootContainer, target:DisplayObject, data:*, selected:Boolean, subIndex:uint) : void
      {
         if(DisplayObjectContainer(target).numChildren)
         {
            ui.uiClass[_updateFunctionName](data,_cptNameReferences[DisplayObjectContainer(target).getChildAt(0)],selected);
         }
      }
      
      override public function renderModificator(childs:Array) : Array
      {
         _containerDefinition["default"] = childs[0];
         return [];
      }
   }
}
