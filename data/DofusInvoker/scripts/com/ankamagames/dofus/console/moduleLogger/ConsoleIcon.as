package com.ankamagames.dofus.console.moduleLogger
{
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.managers.TooltipManager;
   import com.ankamagames.berilia.managers.UiModuleManager;
   import com.ankamagames.berilia.types.data.TextTooltipInfo;
   import com.ankamagames.berilia.types.event.UiRenderEvent;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   import flash.utils.Dictionary;
   
   public final class ConsoleIcon extends Sprite
   {
      
      private static const I_CANCEL:Class = ConsoleIcon_I_CANCEL;
      
      private static const I_CANCEL_HOVER:Class = ConsoleIcon_I_CANCEL_HOVER;
      
      private static const I_DISK:Class = ConsoleIcon_I_DISK;
      
      private static const I_DISK_HOVER:Class = ConsoleIcon_I_DISK_HOVER;
      
      private static const I_LIST:Class = ConsoleIcon_I_LIST;
      
      private static const I_LIST_HOVER:Class = ConsoleIcon_I_LIST_HOVER;
      
      private static const I_BOOK:Class = ConsoleIcon_I_BOOK;
      
      private static const I_TERMINAL:Class = ConsoleIcon_I_TERMINAL;
      
      private static const I_SCREEN:Class = ConsoleIcon_I_SCREEN;
      
      private static const I_SCRIPT:Class = ConsoleIcon_I_SCRIPT;
      
      private static const I_RECORD:Class = ConsoleIcon_I_RECORD;
      
      private static const I_PAUSE:Class = ConsoleIcon_I_PAUSE;
      
      private static const I_WAIT:Class = ConsoleIcon_I_WAIT;
      
      private static const I_WAITAUTO:Class = ConsoleIcon_I_WAITAUTO;
      
      private static const I_STOP:Class = ConsoleIcon_I_STOP;
      
      private static const I_PLAY:Class = ConsoleIcon_I_PLAY;
      
      private static const I_SAVE:Class = ConsoleIcon_I_SAVE;
      
      private static const I_MOVE_DEFAULT:Class = ConsoleIcon_I_MOVE_DEFAULT;
      
      private static const I_MOVE_WALK:Class = ConsoleIcon_I_MOVE_WALK;
      
      private static const I_MOVE_RUN:Class = ConsoleIcon_I_MOVE_RUN;
      
      private static const I_MOVE_TELEPORT:Class = ConsoleIcon_I_MOVE_TELEPORT;
      
      private static const I_MOVE_SLIDE:Class = ConsoleIcon_I_MOVE_SLIDE;
      
      private static const I_OPEN:Class = ConsoleIcon_I_OPEN;
      
      private static const I_CAMERA_AUTOFOLLOW:Class = ConsoleIcon_I_CAMERA_AUTOFOLLOW;
      
      private static const I_CAMERA_ZOOM_IN:Class = ConsoleIcon_I_CAMERA_ZOOM_IN;
      
      private static const I_CAMERA_ZOOM_OUT:Class = ConsoleIcon_I_CAMERA_ZOOM_OUT;
      
      private static const I_RESET_WORLD:Class = ConsoleIcon_I_RESET_WORLD;
      
      private static const I_AUTO_RESET:Class = ConsoleIcon_I_AUTO_RESET;
      
      private static const I_RELOAD:Class = ConsoleIcon_I_RELOAD;
      
      private static const _assets:Dictionary = new Dictionary();
      
      {
         _assets["cancel"] = I_CANCEL;
         _assets["cancel_Hover"] = I_CANCEL_HOVER;
         _assets["disk"] = I_DISK;
         _assets["disk_Hover"] = I_DISK_HOVER;
         _assets["list"] = I_LIST;
         _assets["list_Hover"] = I_LIST_HOVER;
         _assets["book"] = I_BOOK;
         _assets["terminal"] = I_TERMINAL;
         _assets["screen"] = I_SCREEN;
         _assets["script"] = I_SCRIPT;
         _assets["record"] = I_RECORD;
         _assets["wait"] = I_WAIT;
         _assets["waitAuto"] = I_WAITAUTO;
         _assets["play"] = I_PLAY;
         _assets["stop"] = I_STOP;
         _assets["save"] = I_SAVE;
         _assets["moveDefault"] = I_MOVE_DEFAULT;
         _assets["moveWalk"] = I_MOVE_WALK;
         _assets["moveRun"] = I_MOVE_RUN;
         _assets["moveTeleport"] = I_MOVE_TELEPORT;
         _assets["moveSlide"] = I_MOVE_SLIDE;
         _assets["open"] = I_OPEN;
         _assets["cameraAutoFollow"] = I_CAMERA_AUTOFOLLOW;
         _assets["cameraZoomIn"] = I_CAMERA_ZOOM_IN;
         _assets["cameraZoomOut"] = I_CAMERA_ZOOM_OUT;
         _assets["reload"] = I_RELOAD;
         _assets["resetWorld"] = I_RESET_WORLD;
         _assets["autoReset"] = I_AUTO_RESET;
      }
      
      private var _enabled:Boolean = true;
      
      private var _toggled:Boolean = false;
      
      private var _icon:Sprite;
      
      private var _iconHover:Sprite;
      
      private var _iconList:ConsoleIconList;
      
      private var _cross:Shape;
      
      private var _size:int;
      
      private var _tooltipName:String;
      
      private var _tooltipText:String;
      
      public function ConsoleIcon(name:String, size:int = 16, toolTip:String = "", iconList:ConsoleIconList = null)
      {
         super();
         this._size = size;
         if(_assets[name])
         {
            this._icon = new _assets[name]();
            if(_assets[name + "_Hover"])
            {
               this._iconHover = new _assets[name + "_Hover"]();
               this._iconHover.width = this._size;
               this._iconHover.height = this._size;
               this._iconHover.visible = false;
               addChild(this._iconHover);
            }
         }
         else
         {
            this._icon = new MovieClip();
            this._icon.name = name;
            this._icon.graphics.beginFill(16711935);
            this._icon.graphics.drawRect(0,0,this._size,this._size);
            this._icon.graphics.endFill();
         }
         this._icon.width = this._size;
         this._icon.height = this._size;
         addChild(this._icon);
         this._iconList = iconList;
         if(iconList)
         {
            iconList.addIcon(this);
         }
         mouseChildren = false;
         useHandCursor = true;
         buttonMode = true;
         addEventListener(MouseEvent.MOUSE_OVER,this.onRollOver,false,0,true);
         addEventListener(MouseEvent.MOUSE_OUT,this.onRollOut,false,0,true);
         if(toolTip.length > 0)
         {
            this._tooltipName = "console_" + name;
            this._tooltipText = toolTip;
         }
      }
      
      public function get toggled() : Boolean
      {
         return this._toggled;
      }
      
      public function set toggled(value:Boolean) : void
      {
         var IconClass:Class = null;
         this._toggled = value;
         if(this._icon.name.toLowerCase().indexOf("record") != -1 || this._icon.name.toLowerCase().indexOf("pause") != -1)
         {
            IconClass = !!this._toggled ? I_PAUSE : I_RECORD;
            removeChild(this._icon);
            this._icon = new IconClass();
            this._icon.width = this._size;
            this._icon.height = this._size;
            addChild(this._icon);
         }
         else if(this._toggled)
         {
            this._icon.filters = [new GlowFilter(16777215,1,8,8)];
         }
         else
         {
            this._icon.filters = [];
         }
      }
      
      public function get enabled() : Boolean
      {
         return this._enabled;
      }
      
      public function set enabled(value:Boolean) : void
      {
         this._enabled = value;
         if(this._enabled)
         {
            alpha = 1;
         }
         else
         {
            alpha = 0.4;
         }
         mouseEnabled = this._enabled;
      }
      
      public function disable(value:Boolean) : void
      {
         if(value)
         {
            if(!this._cross)
            {
               this._cross = new Shape();
               this._cross.graphics.lineStyle(2,14492194);
               this._cross.graphics.moveTo(0,0);
               this._cross.graphics.lineTo(this._size,this._size);
               this._cross.graphics.moveTo(0,this._size);
               this._cross.graphics.lineTo(this._size,0);
               addChild(this._cross);
            }
         }
         else if(this._cross)
         {
            removeChild(this._cross);
            this._cross = null;
         }
      }
      
      public function changeColor(color:ColorTransform) : void
      {
         this._icon.transform.colorTransform = color;
      }
      
      private function showTooltip() : void
      {
         Berilia.getInstance().addEventListener(UiRenderEvent.UIRenderComplete,this.onUiLoaded);
         TooltipManager.show(new TextTooltipInfo(this._tooltipText),this,UiModuleManager.getInstance().getModule("Ankama_Console"),false,this._tooltipName);
      }
      
      private function onUiLoaded(e:UiRenderEvent) : void
      {
         if(e.uiTarget.name == "tooltip_" + this._tooltipName)
         {
            Berilia.getInstance().removeEventListener(UiRenderEvent.UIRenderComplete,this.onUiLoaded);
            e.uiTarget.x = x + width + 5;
            e.uiTarget.y = y;
            parent.addChild(e.uiTarget);
         }
      }
      
      private function onRollOver(e:MouseEvent) : void
      {
         if(this._iconHover)
         {
            this._iconHover.visible = true;
            this._icon.visible = false;
         }
         else
         {
            transform.colorTransform = new ColorTransform(1.4,1.4,1.4);
         }
         if(this._tooltipName)
         {
            this.showTooltip();
         }
      }
      
      private function onRollOut(e:MouseEvent) : void
      {
         if(this._iconHover)
         {
            this._icon.visible = true;
            this._iconHover.visible = false;
         }
         else
         {
            transform.colorTransform = new ColorTransform(1,1,1);
         }
         this.enabled = this._enabled;
         if(this._tooltipName)
         {
            TooltipManager.hide(this._tooltipName);
         }
      }
   }
}
