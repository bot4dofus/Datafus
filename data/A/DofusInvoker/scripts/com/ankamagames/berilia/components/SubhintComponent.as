package com.ankamagames.berilia.components
{
   import com.ankamagames.berilia.FinalizableUIComponent;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.types.LocationEnum;
   import com.ankamagames.berilia.types.data.UiModule;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.jerakine.data.XmlConfig;
   import com.ankamagames.jerakine.types.Uri;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class SubhintComponent extends Texture implements FinalizableUIComponent
   {
       
      
      private var _order:uint;
      
      public var _data:Object;
      
      private var _module:UiModule;
      
      private var _target:GraphicContainer;
      
      private var _rect:Rectangle;
      
      private var _highlightShape;
      
      private var _guided:Boolean;
      
      private var _preview:Boolean = false;
      
      public function SubhintComponent(order:uint, data:Object, uiModule:UiModule, target:GraphicContainer, guided:Boolean = true, rect:Rectangle = null, posX:Number = 0, posY:Number = 0)
      {
         super();
         this._order = order;
         this._data = data;
         this._module = uiModule;
         this._target = target;
         this._guided = guided;
         uri = new Uri(XmlConfig.getInstance().getEntry("config.ui.skin").concat("texture/subhint_selected.png"));
         this._rect = rect;
         if(target.name.indexOf("btn_help") == -1)
         {
            width = this._data.hint_width;
            height = this._data.hint_height;
         }
         else
         {
            width = 22;
            height = 22;
         }
         mouseEnabled = true;
         mouseChildren = true;
         x = posX - width / 2;
         y = posY - height / 2;
         dispatchMessages = true;
         addEventListener(Event.COMPLETE,this.onSubHintRendered);
         finalize();
      }
      
      public function get order() : uint
      {
         return this._order;
      }
      
      public function set order(value:uint) : void
      {
         this._order = value;
      }
      
      public function get target() : GraphicContainer
      {
         return this._target;
      }
      
      public function set target(value:GraphicContainer) : void
      {
         this._target = value;
      }
      
      public function onSubHintRendered(e:Event) : void
      {
         removeEventListener(Event.COMPLETE,this.onSubHintRendered);
         if(this.target.name.indexOf("btn_help") != -1)
         {
            addEventListener(MouseEvent.CLICK,this.onRelease);
         }
         addEventListener(MouseEvent.MOUSE_OVER,this.onRollOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.onRollOut);
      }
      
      public function onRollOver(e:MouseEvent) : void
      {
         if(this.target.name.indexOf("btn_help") != -1)
         {
            handCursor = true;
         }
         if(!this._guided && !this._preview)
         {
            this.showSubHint();
         }
      }
      
      public function onRollOut(e:MouseEvent) : void
      {
         handCursor = false;
         if(!this._guided && !this._preview)
         {
            TooltipManager.hide("tuto_interface");
         }
      }
      
      public function onRelease(e:MouseEvent) : void
      {
         this.target.getUi().uiClass.onRelease(this.target);
      }
      
      public function showSubHint(preview:Boolean = false) : void
      {
         this._preview = preview;
         this._data.hint_order = this._order;
         TooltipManager.hide("tuto_interface");
         TooltipManager.show(this._data,this.target.name.indexOf("btn_help") == -1 ? this : this.target,this._module,true,"tuto_interface",!this._data.hasOwnProperty("hint_tooltip_position_enum") || this._data.hint_tooltip_position_enum == null ? uint(this.findPoint(this.setRelativePoint())) : uint(this.findPoint(this._data.hint_tooltip_position_enum)),!this._data.hasOwnProperty("hint_tooltip_position_enum") || this._data.hint_tooltip_position_enum == null ? uint(this.setRelativePoint()) : uint(this._data.hint_tooltip_position_enum),new Point(this._data.hint_tooltip_offset_x,this._data.hint_tooltip_offset_y),true,"simpleInterfaceTuto",null,null,null,this._guided,4,1,true,true);
      }
      
      public function setRelativePoint() : int
      {
         var tempX:Number = this._target.localToGlobal(new Point(this._target.x,this._target.y)).x - this.parent.x;
         var tempY:Number = this._target.localToGlobal(new Point(this._target.x,this._target.y)).y - this.parent.y;
         if(this.x - tempX <= this._target.width / 2)
         {
            if(this.y - tempY <= this._target.height / 2)
            {
               return LocationEnum.POINT_TOPLEFT;
            }
            return LocationEnum.POINT_BOTTOMLEFT;
         }
         if(this.y - tempY <= this._target.height / 2)
         {
            return LocationEnum.POINT_TOPRIGHT;
         }
         return LocationEnum.POINT_BOTTOMRIGHT;
      }
      
      public function findPoint(relativePoint:uint = 6) : int
      {
         return int(8 - relativePoint);
      }
      
      public function highLight(highLight:Boolean) : void
      {
         if(this._rect)
         {
            if(highLight)
            {
               if(!this._preview)
               {
                  this._highlightShape = new Sprite();
                  this._highlightShape.addEventListener(MouseEvent.MOUSE_OVER,this.onRollOver);
                  this._highlightShape.addEventListener(MouseEvent.MOUSE_OUT,this.onRollOut);
               }
               else
               {
                  this._highlightShape = new Shape();
               }
               this._highlightShape.graphics.clear();
               this._highlightShape.graphics.lineStyle(2,16110600,1);
               if(this._guided)
               {
                  this._highlightShape.graphics.beginFill(0,0.3);
               }
               else
               {
                  this._highlightShape.graphics.beginFill(0,0);
               }
               this._highlightShape.graphics.drawRect(this._rect.x,this._rect.y,this._rect.width,this._rect.height);
               this._highlightShape.graphics.endFill();
               this._highlightShape.visible = true;
               parent.addChildAt(this._highlightShape,parent.getChildIndex(this));
            }
            else
            {
               if(parent && parent.getChildByName("_highlightShape"))
               {
                  parent.removeChild(this._highlightShape);
               }
               if(this._highlightShape)
               {
                  this._highlightShape.visible = false;
               }
            }
         }
      }
      
      override public function remove() : void
      {
         if(!__removed)
         {
            removeEventListener(Event.COMPLETE,this.onSubHintRendered);
            removeEventListener(MouseEvent.CLICK,this.onRelease);
            removeEventListener(MouseEvent.MOUSE_OVER,this.onRollOver);
            removeEventListener(MouseEvent.MOUSE_OUT,this.onRollOut);
            if(this._highlightShape)
            {
               this._highlightShape.removeEventListener(MouseEvent.MOUSE_OVER,this.onRollOver);
               this._highlightShape.removeEventListener(MouseEvent.MOUSE_OUT,this.onRollOut);
            }
         }
         super.remove();
      }
   }
}
