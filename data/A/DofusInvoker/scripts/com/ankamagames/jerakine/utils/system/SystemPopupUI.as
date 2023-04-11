package com.ankamagames.jerakine.utils.system
{
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   import flash.utils.Dictionary;
   
   public class SystemPopupUI extends Sprite
   {
      
      private static const _popupRef:Dictionary = new Dictionary();
       
      
      private var _title:String;
      
      private var _content:String;
      
      private var _modal:Boolean;
      
      private var _centerContent:Boolean = true;
      
      private var _buttons:Array;
      
      private var _mainContainer:Sprite;
      
      private var _titleTf:TextField;
      
      private var _contentTf:TextField;
      
      private var _id:String;
      
      private var _style_bg_color:uint = 16777215;
      
      private var _style_font_color:uint = 5592405;
      
      private var _style_title_color:uint = 14540253;
      
      private var _style_border_color:uint = 11184810;
      
      private var _window_width:uint = 900;
      
      private var _callBacks:Dictionary;
      
      public function SystemPopupUI(id:String)
      {
         super();
         if(_popupRef[id])
         {
            throw new ArgumentError("A SystemPopupUI called \'" + id + "\' already exist, call destroy() before.");
         }
         _popupRef[id] = this;
         this._id = id;
      }
      
      public static function get(id:String) : SystemPopupUI
      {
         return _popupRef[id];
      }
      
      public function destroy() : void
      {
         var btn:* = null;
         for(btn in this._callBacks)
         {
            (btn as Sprite).removeEventListener(MouseEvent.MOUSE_OVER,this.onBtnMouseOver);
            (btn as Sprite).removeEventListener(MouseEvent.MOUSE_OUT,this.onBtnMouseOut);
            (btn as Sprite).removeEventListener(MouseEvent.CLICK,this.onBtnClick);
         }
         if(parent)
         {
            parent.removeChild(this);
            this.buildUI(true);
            delete _popupRef[this._id];
         }
      }
      
      public function show() : void
      {
         StageShareManager.rootContainer.addChild(this);
      }
      
      public function get modal() : Boolean
      {
         return this._modal;
      }
      
      public function set modal(value:Boolean) : void
      {
         if(value != this._modal)
         {
            this._modal = value;
            graphics.clear();
            if(value)
            {
               graphics.beginFill(16777215,0.7);
               graphics.drawRect(0,0,StageShareManager.startWidth,StageShareManager.startHeight);
            }
         }
      }
      
      public function get buttons() : Array
      {
         return this._buttons;
      }
      
      public function set buttons(value:Array) : void
      {
         this._buttons = value;
         this.buildUI();
      }
      
      public function get content() : String
      {
         return this._content;
      }
      
      public function set content(value:String) : void
      {
         this._content = value;
         this.buildUI();
      }
      
      public function get title() : String
      {
         return this._title;
      }
      
      public function set title(value:String) : void
      {
         this._title = value;
         this.buildUI();
      }
      
      override public function set width(value:Number) : void
      {
         this._window_width = value;
         this.buildUI();
      }
      
      public function set centerContent(b:Boolean) : void
      {
         this._centerContent = b;
         this.buildUI();
      }
      
      public function get centerContent() : Boolean
      {
         return this._centerContent;
      }
      
      private function buildUI(destroy:Boolean = false) : void
      {
         var oldBtn:* = undefined;
         var btnContainer:Sprite = null;
         var b:Object = null;
         var btn:DisplayObject = null;
         if(!this._title || !this._content)
         {
            return;
         }
         while(numChildren)
         {
            removeChildAt(0);
         }
         if(this._callBacks)
         {
            for(oldBtn in this._callBacks)
            {
               Sprite(oldBtn).removeEventListener(MouseEvent.MOUSE_OVER,this.onBtnMouseOver);
               Sprite(oldBtn).removeEventListener(MouseEvent.MOUSE_OUT,this.onBtnMouseOut);
               Sprite(oldBtn).removeEventListener(MouseEvent.CLICK,this.onBtnClick);
            }
         }
         this._callBacks = new Dictionary();
         if(destroy)
         {
            return;
         }
         this._mainContainer = new Sprite();
         addChild(this._mainContainer);
         this._titleTf = new TextField();
         this._titleTf.selectable = false;
         this._titleTf.autoSize = TextFieldAutoSize.LEFT;
         this._titleTf.height = 20;
         var tf:TextFormat = new TextFormat("Verdana",16,this._style_font_color,true);
         this._titleTf.defaultTextFormat = tf;
         this._titleTf.text = this._title;
         this._mainContainer.addChild(this._titleTf);
         this._contentTf = new TextField();
         this._contentTf.width = this._window_width;
         tf = new TextFormat("Verdana",14,this._style_font_color,null,null,null,null,null,!!this._centerContent ? TextFormatAlign.CENTER : TextFormatAlign.LEFT);
         this._contentTf.defaultTextFormat = tf;
         this._contentTf.wordWrap = true;
         this._contentTf.multiline = true;
         this._contentTf.text = this._content;
         this._contentTf.height = this._contentTf.numLines * 23;
         this._contentTf.y = 30;
         this._mainContainer.addChild(this._contentTf);
         if(this._buttons && this._buttons.length)
         {
            btnContainer = new Sprite();
            for each(b in this._buttons)
            {
               btn = this.createButton(b.label);
               this._callBacks[btn] = b.callback;
               btn.x = !!btnContainer.width ? Number(btnContainer.width + 10) : Number(0);
               btnContainer.addChild(btn);
            }
            btnContainer.y = this._contentTf.y + this._contentTf.height + 10;
            btnContainer.x = (this._mainContainer.width - btnContainer.width) / 2;
            this._mainContainer.addChild(btnContainer);
         }
         this._mainContainer.graphics.lineStyle(1,this._style_border_color);
         this._mainContainer.graphics.beginFill(this._style_bg_color);
         this._mainContainer.graphics.drawRect(-2,-2,this._window_width + 4,this._mainContainer.height + 10);
         this._mainContainer.graphics.beginFill(this._style_title_color);
         this._mainContainer.graphics.drawRect(-2,-2,this._window_width + 4,25);
         this._mainContainer.x = (StageShareManager.startWidth - this._mainContainer.width) / 2;
         this._mainContainer.y = (StageShareManager.startHeight - this._mainContainer.height) / 2;
         this._mainContainer.filters = [new DropShadowFilter(1,45,0,0.5,10,10,1,3)];
      }
      
      private function createButton(text:String) : DisplayObject
      {
         var btn:Sprite = new Sprite();
         var btnText:TextField = new TextField();
         var tf:TextFormat = new TextFormat("Verdana",12,this._style_font_color,true,null,null,null,null,TextFormatAlign.CENTER);
         btnText.defaultTextFormat = tf;
         btnText.text = text;
         btnText.height = 20;
         btnText.width = btnText.textWidth < 50 ? Number(50) : Number(btnText.textWidth + 10);
         btnText.selectable = false;
         btnText.mouseEnabled = false;
         btn.addChild(btnText);
         btn.graphics.lineStyle(1,this._style_border_color + 1118481);
         btn.graphics.beginFill(this._style_title_color + 1118481);
         btn.graphics.drawRoundRect(-2,-2,btnText.width + 5,25,2,2);
         btn.addEventListener(MouseEvent.MOUSE_OVER,this.onBtnMouseOver);
         btn.addEventListener(MouseEvent.MOUSE_OUT,this.onBtnMouseOut);
         btn.addEventListener(MouseEvent.CLICK,this.onBtnClick);
         btn.buttonMode = true;
         return btn;
      }
      
      private function onBtnMouseOver(e:Event) : void
      {
         var btn:Sprite = e.target as Sprite;
         btn.graphics.lineStyle(1,this._style_border_color);
         btn.graphics.beginFill(this._style_title_color);
         btn.graphics.drawRoundRect(-2,-2,btn.width - 1,25,2,2);
      }
      
      private function onBtnMouseOut(e:Event) : void
      {
         var btn:Sprite = e.target as Sprite;
         btn.graphics.lineStyle(1,this._style_border_color + 1118481);
         btn.graphics.beginFill(this._style_title_color + 1118481);
         btn.graphics.drawRoundRect(-2,-2,btn.width - 1,25,2,2);
      }
      
      private function onBtnClick(e:Event) : void
      {
         if(this._callBacks[e.target] is Function)
         {
            this._callBacks[e.target]();
         }
         else if(this._callBacks[e.target] is Callback)
         {
            Callback(this._callBacks[e.target]).exec();
         }
         this.destroy();
      }
   }
}
