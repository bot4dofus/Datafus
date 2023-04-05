package com.ankamagames.berilia.components.params
{
   import com.ankamagames.berilia.types.tooltip.Tooltip;
   import com.ankamagames.berilia.utils.UiProperties;
   import com.ankamagames.jerakine.interfaces.IRectangle;
   
   public class TooltipProperties extends UiProperties
   {
       
      
      public var position:IRectangle;
      
      public var tooltip:Tooltip;
      
      public var autoHide:Boolean;
      
      public var point:uint = 0;
      
      public var relativePoint:uint = 2;
      
      public var offset = 3;
      
      public var data = null;
      
      public var makerName:String;
      
      public var makerParam:Object;
      
      public var zoom:Number;
      
      public var alwaysDisplayed:Boolean;
      
      public var target;
      
      public var showDirectionalArrow:Boolean = false;
      
      public function TooltipProperties(tooltip:Tooltip, autoHide:Boolean, position:IRectangle, point:uint, relativePoint:uint, offset:*, data:*, makerParam:Object, zoom:Number = 1, alwaysDisplayed:Boolean = true, target:* = null, showDirectionalArrow:Boolean = false)
      {
         super();
         this.position = position;
         this.tooltip = tooltip;
         this.autoHide = autoHide;
         this.point = point;
         this.relativePoint = relativePoint;
         this.offset = offset;
         this.data = data;
         this.makerName = tooltip.makerName;
         this.makerParam = makerParam;
         this.zoom = zoom;
         this.alwaysDisplayed = alwaysDisplayed;
         this.target = target;
         this.showDirectionalArrow = showDirectionalArrow;
      }
   }
}
