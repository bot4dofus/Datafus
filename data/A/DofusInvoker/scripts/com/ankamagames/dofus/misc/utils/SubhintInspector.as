package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.berilia.components.Input;
   import com.ankamagames.berilia.components.Label;
   import com.ankamagames.berilia.components.Texture;
   import com.ankamagames.berilia.components.TextureBitmap;
   import com.ankamagames.berilia.events.LinkInteractionEvent;
   import com.ankamagames.berilia.factories.HyperlinkFactory;
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.berilia.types.graphic.ButtonContainer;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.datacenter.misc.Subhint;
   import com.ankamagames.dofus.internalDatacenter.tutorial.SubhintWrapper;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.ui.Keyboard;
   
   public class SubhintInspector
   {
      
      private static var _self:SubhintInspector;
       
      
      private var _tooltip:Sprite;
      
      private var _enable:Boolean;
      
      private var _lastTarget:Vector.<InteractiveItem>;
      
      private var _underPoint:Point;
      
      private var _currentShortCut:ShortcutItem;
      
      private var _freeze:Boolean = false;
      
      private var _mouseOverHyperLink:Boolean = false;
      
      private var _validTargetType:Array;
      
      public function SubhintInspector()
      {
         this._tooltip = new Sprite();
         this._underPoint = new Point();
         this._validTargetType = [GraphicContainer,UiRootContainer,ButtonContainer,Sprite,TextureBitmap,Texture,Label,Input,TextField];
         super();
         this._tooltip.mouseEnabled = false;
      }
      
      public static function getInstance() : SubhintInspector
      {
         if(!_self)
         {
            _self = new SubhintInspector();
         }
         return _self;
      }
      
      public static function selectElementInInspector(Id:uint) : void
      {
         _self.getSelectedElementById(Id);
      }
      
      public static function processRollOver(posX:int, posY:int, Id:uint) : void
      {
         _self.highlightElementById(Id);
      }
      
      public function set enable(b:Boolean) : void
      {
         if(b)
         {
            StageShareManager.stage.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
            StageShareManager.stage.addEventListener(MouseEvent.MOUSE_OUT,this.onRollout);
            StageShareManager.stage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
            StageShareManager.stage.addEventListener(MouseEvent.CLICK,this.onRelease);
         }
         else
         {
            this._freeze = false;
            this.onRollout(this._lastTarget);
            StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
            StageShareManager.stage.removeEventListener(MouseEvent.MOUSE_OUT,this.onRollout);
            StageShareManager.stage.removeEventListener(KeyboardEvent.KEY_UP,this.onKeyUp);
            StageShareManager.stage.removeEventListener(MouseEvent.CLICK,this.onRelease);
         }
         this._enable = b;
      }
      
      public function get enable() : Boolean
      {
         return this._enable;
      }
      
      private function onKeyUp(e:KeyboardEvent) : void
      {
         if(this._lastTarget && this._lastTarget.length && this._currentShortCut)
         {
            if(this._currentShortCut.shift == e.shiftKey && this._currentShortCut.key == e.keyCode)
            {
               this._currentShortCut.callback();
            }
         }
      }
      
      private function onRollout(e:*) : void
      {
         var item:InteractiveItem = null;
         var tooltipItemTf:DisplayObject = null;
         for each(item in this._lastTarget)
         {
            item.cleanHighlight();
         }
         if(this._freeze)
         {
            return;
         }
         this._currentShortCut = null;
         while(this._tooltip.numChildren > 0)
         {
            tooltipItemTf = this._tooltip.removeChildAt(0);
            HyperlinkFactory.removeRollOverHandler(tooltipItemTf);
            HyperlinkFactory.removeTextClickHandler(tooltipItemTf);
         }
         if(this._tooltip.parent)
         {
            StageShareManager.stage.removeChild(this._tooltip);
         }
      }
      
      private function freeze() : void
      {
         this._freeze = !this._freeze;
         this._tooltip.mouseEnabled = this._freeze;
      }
      
      public function getSelectedElementById(Id:int) : void
      {
         if((this._lastTarget[Id].target as GraphicContainer).isInstance || this._lastTarget[Id].target.name.indexOf("instance") != -1 || this._lastTarget[Id].target.name == "default")
         {
            return;
         }
         var data:Subhint = new Subhint();
         data.hint_anchored_element = this._lastTarget[Id].elementName;
         data.hint_parent_uid = (this._lastTarget[Id].target as GraphicContainer).getUi().uiData.name;
         this.enable = false;
         var dataWrapper:SubhintWrapper = SubhintWrapper.create(data);
         KernelEventsManager.getInstance().processCallback(HookList.SubhintEditorUpdated,dataWrapper);
      }
      
      public function highlightElementById(Id:int) : void
      {
         if(this.enable)
         {
            this._lastTarget[Id].highlight();
         }
      }
      
      private function checkTargetType(target:*) : Boolean
      {
         var type:* = undefined;
         for each(type in this._validTargetType)
         {
            if(target is type)
            {
               return true;
            }
         }
         return false;
      }
      
      private function onMouseMove(e:MouseEvent) : void
      {
         var tooltipStr:* = null;
         var item:InteractiveItem = null;
         var currentTooltipStr:String = null;
         var tooltipItemTf:TextField = null;
         var tfItem:TextFormat = null;
         var stageBounds:Rectangle = null;
         if(this._freeze)
         {
            return;
         }
         this.onRollout(this._lastTarget);
         if(e.target is GraphicContainer && (e.target as GraphicContainer).getUi().uiData.uiClassName == "ui::SubhintEditorUi" || e.target.parent is GraphicContainer && (e.target.parent as GraphicContainer).getUi().uiData.uiClassName == "ui::SubhintEditorUi")
         {
            return;
         }
         if(e.target is GraphicContainer && (e.target as GraphicContainer).getUi().uiData.uiClassName == "ui::SubhintList" || e.target.parent is GraphicContainer && (e.target.parent as GraphicContainer).getUi().uiData.uiClassName == "ui::SubhintList")
         {
            return;
         }
         if(!this.checkTargetType(e.target))
         {
            return;
         }
         this._lastTarget = this.findElements(this.getDeepestObject(e.target as DisplayObject));
         var textFieldSize:Point = new Point();
         var tooltipTf:TextField = new TextField();
         tooltipTf.mouseEnabled = false;
         var tf:TextFormat = new TextFormat("Verdana");
         tooltipTf.defaultTextFormat = tf;
         tooltipTf.setTextFormat(tf);
         tooltipTf.multiline = true;
         tooltipTf.autoSize = TextFieldAutoSize.LEFT;
         tooltipStr = "Mouse pos : " + StageShareManager.stage.mouseX + " / " + StageShareManager.stage.mouseY + "<br/>";
         tooltipTf.htmlText = tooltipStr;
         tooltipTf.x = 0;
         tooltipTf.y = textFieldSize.y;
         textFieldSize.x += tooltipTf.textWidth;
         textFieldSize.y += tooltipTf.textHeight;
         this._tooltip.addChild(tooltipTf);
         var ind:* = "";
         for(var i:uint = 0; i < this._lastTarget.length; i++)
         {
            item = this._lastTarget[i];
            item.Id = i;
            currentTooltipStr = (!!tooltipStr.length ? ind : "") + item.tooltip();
            currentTooltipStr = currentTooltipStr.split("<br/>").join("<br/>" + ind);
            tooltipItemTf = new TextField();
            tfItem = new TextFormat("Verdana");
            tooltipTf.defaultTextFormat = tfItem;
            tooltipTf.setTextFormat(tf);
            tooltipItemTf.autoSize = TextFieldAutoSize.LEFT;
            tooltipItemTf.multiline = true;
            if(item.target is UiRootContainer)
            {
               tooltipItemTf.htmlText = currentTooltipStr;
            }
            else
            {
               tooltipItemTf.mouseEnabled = true;
               tooltipItemTf.addEventListener(MouseEvent.MOUSE_MOVE,this.onHyperlinkMove);
               tooltipItemTf.addEventListener(MouseEvent.ROLL_OUT,this.onHyperlinkRollOut);
               tooltipItemTf.htmlText = "{highlightElement," + item.Id + "::" + currentTooltipStr + "}";
               HyperlinkFactory.createRollOverHandler(tooltipItemTf);
               HyperlinkFactory.createTextClickHandler(tooltipItemTf,true);
            }
            tooltipItemTf.x = 0;
            tooltipItemTf.y = textFieldSize.y;
            textFieldSize.x = textFieldSize.x < tooltipItemTf.width ? Number(tooltipItemTf.width) : Number(textFieldSize.x);
            textFieldSize.y += tooltipItemTf.textHeight;
            this._tooltip.addChild(tooltipItemTf);
            ind += "&nbsp;&nbsp;&nbsp;";
         }
         this._currentShortCut = null;
         if(this._lastTarget.length)
         {
            this._currentShortCut = new ShortcutItem("Freeze",Keyboard.S,this.freeze,true);
         }
         this._tooltip.graphics.clear();
         this._tooltip.graphics.beginFill(16777215,0.9);
         this._tooltip.graphics.lineStyle(1,0,0.7);
         this._tooltip.graphics.drawRect(-5,-5,textFieldSize.x * 1.1 + 10,textFieldSize.y * 1.1 + 10);
         this._tooltip.graphics.endFill();
         if(this._lastTarget.length)
         {
            this._tooltip.x = StageShareManager.mouseX + 20;
            this._tooltip.y = StageShareManager.mouseY - this._tooltip.height - 5;
            stageBounds = StageShareManager.stageVisibleBounds;
            if(this._tooltip.y < 0)
            {
               this._tooltip.y = 5;
            }
            if(this._tooltip.x + this._tooltip.width > stageBounds.right)
            {
               this._tooltip.x += stageBounds.right - (this._tooltip.x + this._tooltip.width);
            }
         }
         else
         {
            this._tooltip.x = this._tooltip.y = 0;
         }
         StageShareManager.stage.addChild(this._tooltip);
      }
      
      private function onRelease(e:MouseEvent) : void
      {
         var tempTarget:DisplayObject = e.target as DisplayObject;
      }
      
      private function onHyperlinkMove(e:MouseEvent) : void
      {
         var startIndex:int = 0;
         var endIndex:int = 0;
         var params:Array = null;
         var data:String = null;
         if(!this._freeze)
         {
            return;
         }
         if(!this._mouseOverHyperLink)
         {
            startIndex = (e.target as TextField).htmlText.indexOf("event:") + 6;
            endIndex = (e.target as TextField).htmlText.indexOf(">",startIndex) - 1;
            params = (e.target as TextField).htmlText.substring(startIndex,endIndex).split(",");
            data = params.shift() + "," + StageShareManager.stage.mouseX + "," + StageShareManager.stage.mouseY + "," + params.join(",");
            e.target.dispatchEvent(new LinkInteractionEvent(LinkInteractionEvent.ROLL_OVER,data));
            this._mouseOverHyperLink = true;
         }
      }
      
      private function onHyperlinkRollOut(e:MouseEvent) : void
      {
         if(e || this._mouseOverHyperLink)
         {
            e.target.dispatchEvent(new LinkInteractionEvent(LinkInteractionEvent.ROLL_OUT));
         }
         this._mouseOverHyperLink = false;
      }
      
      private function getDeepestObject(target:DisplayObject) : DisplayObject
      {
         var item:DisplayObject = null;
         var currentItem:DisplayObject = null;
         this._underPoint.x = StageShareManager.mouseX;
         this._underPoint.y = StageShareManager.mouseY;
         var objets:Array = StageShareManager.stage.getObjectsUnderPoint(this._underPoint);
         for each(item in objets)
         {
            currentItem = item;
            while(currentItem && !(currentItem is Stage) && currentItem.parent)
            {
               if(currentItem == target)
               {
                  return item;
               }
               currentItem = currentItem.parent;
            }
         }
         return target;
      }
      
      private function findElements(target:DisplayObject) : Vector.<InteractiveItem>
      {
         var currentItem:InteractiveItem = null;
         var result:Vector.<InteractiveItem> = new Vector.<InteractiveItem>();
         var ind:String = "";
         while(target && !(target is Stage) && target.parent)
         {
            currentItem = this.cast(target);
            if(currentItem)
            {
               result.push(currentItem);
            }
            target = target.parent;
         }
         return result;
      }
      
      private function cast(target:DisplayObject) : InteractiveItem
      {
         var currentItem:InteractiveItem = null;
         switch(true)
         {
            case target is UiRootContainer:
            case target is GraphicContainer:
               currentItem = new InteractiveItemUi();
               currentItem.target = target;
         }
         return currentItem;
      }
   }
}

class ShortcutItem
{
    
   
   public var legend:String;
   
   public var callback:Function;
   
   public var key:uint;
   
   public var shift:Boolean;
   
   function ShortcutItem(legend:String, key:uint, callback:Function, shift:Boolean)
   {
      super();
      this.legend = legend;
      this.key = key;
      this.callback = callback;
      this.shift = shift;
   }
   
   public function toString() : String
   {
      var keys:Array = [];
      if(this.shift)
      {
         keys.push("shift");
      }
      keys.push(String.fromCharCode(this.key));
      return keys.join(" + ") + " : " + this.legend;
   }
}

import flash.display.DisplayObject;
import flash.display.Shape;
import flash.geom.ColorTransform;

class InteractiveItem
{
   
   protected static var _highlightShape:Shape = new Shape();
   
   protected static var _normalEffect:ColorTransform = new ColorTransform(1,1,1);
    
   
   public var shortcut:ShortcutItem;
   
   public var target:DisplayObject;
   
   public var Id:int = -1;
   
   public var elementName:String = "";
   
   function InteractiveItem()
   {
      super();
   }
   
   public function highlight() : void
   {
   }
   
   public function cleanHighlight() : void
   {
   }
   
   public function tooltip() : String
   {
      return "";
   }
}

import com.ankamagames.berilia.types.graphic.GraphicContainer;
import com.ankamagames.berilia.types.graphic.UiRootContainer;
import com.ankamagames.jerakine.utils.display.StageShareManager;
import flash.display.DisplayObject;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.getQualifiedClassName;

class InteractiveItemUi extends InteractiveItem
{
    
   
   function InteractiveItemUi()
   {
      super();
   }
   
   public function myLocalToGlobal(point:Point, target:DisplayObject, lastContainerToLookAt:DisplayObject) : Point
   {
      var coord:Point = point;
      while(target && target != lastContainerToLookAt && target.parent)
      {
         coord.x += target.parent.x;
         coord.y += target.parent.y;
         target = target.parent;
      }
      return coord;
   }
   
   override public function highlight() : void
   {
      StageShareManager.stage.addChild(_highlightShape);
      var cont:GraphicContainer = target as GraphicContainer;
      var pos:Rectangle = new Rectangle(this.myLocalToGlobal(new Point(cont.x,cont.y),cont,StageShareManager.stage).x - StageShareManager.stage.x,this.myLocalToGlobal(new Point(cont.x,cont.y),cont,StageShareManager.stage).y - StageShareManager.stage.y,cont.width,cont.height);
      var color:uint = 16110600;
      if((target as GraphicContainer).isInstance || target.name.indexOf("instance") != -1 || target.name == "default")
      {
         color = 15143443;
      }
      _highlightShape.graphics.clear();
      _highlightShape.graphics.lineStyle(2,color,1);
      _highlightShape.graphics.beginFill(color,0.1);
      _highlightShape.graphics.drawRect(pos.left,pos.top,pos.width,pos.height);
      _highlightShape.graphics.endFill();
   }
   
   override public function cleanHighlight() : void
   {
      if(_highlightShape.parent)
      {
         StageShareManager.stage.removeChild(_highlightShape);
      }
      target.transform.colorTransform = _normalEffect;
   }
   
   private function djb2(str:String) : int
   {
      var hash:int = 5381;
      for(var i:int = 0; i < str.length; i++)
      {
         hash = (hash << 5) + hash + str.charCodeAt(i);
      }
      return hash;
   }
   
   private function hashStringToColor(str:String) : String
   {
      var hash:int = this.djb2(str);
      var r:* = (hash & 16711680) >> 16;
      var g:* = (hash & 65280) >> 8;
      var b:* = hash & 255;
      return "#" + ("0" + r.toString(16) as String).substr(-2) + ("0" + g.toString(16) as String).substr(-2) + ("0" + b.toString(16) as String).substr(-2);
   }
   
   override public function tooltip() : String
   {
      var uirc:UiRootContainer = null;
      var cptClass:String = null;
      var str:* = "";
      var color:String = "#0";
      if(target.name.indexOf("instance") == 0)
      {
         color = "#FF0000";
      }
      if(target is UiRootContainer)
      {
         uirc = target as UiRootContainer;
         if(!uirc.uiData.uiClassName)
         {
            return str;
         }
         elementName = uirc.uiData.name;
         str += "<b><font color=\'#62AAA6\'>Interface</font></b><br/>";
         if(uirc.uiData)
         {
            str += "<b>Nom : </b>" + uirc.uiData.name + "<br/>";
            str += "<b>Module : </b>" + uirc.uiData.module.id + "<br/>";
            str += "<b>Script : </b>" + uirc.uiData.uiClassName.substring(uirc.uiData.uiClassName.indexOf("::") + 2,uirc.uiData.uiClassName.length) + "<br/>";
         }
         else
         {
            str += "<b>Aucune information</b><br/>";
         }
      }
      else
      {
         cptClass = getQualifiedClassName(target).split("::").pop();
         elementName = target.name;
         str += "<b><font color=\'#964D8C\'>Composant </font></b><font color=\'" + this.hashStringToColor(cptClass) + "\' >" + cptClass + "</font><br/>";
         str += "<b>Nom : </b><font color=\'" + color + "\'>" + target.name + "</font></b><br/>";
      }
      return str;
   }
}
