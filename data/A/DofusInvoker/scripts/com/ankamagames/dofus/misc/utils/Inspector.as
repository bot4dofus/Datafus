package com.ankamagames.dofus.misc.utils
{
   import com.ankamagames.atouin.managers.InteractiveCellManager;
   import com.ankamagames.atouin.types.CellContainer;
   import com.ankamagames.atouin.types.FrustumShape;
   import com.ankamagames.atouin.types.GraphicCell;
   import com.ankamagames.atouin.types.SpriteWrapper;
   import com.ankamagames.berilia.Berilia;
   import com.ankamagames.berilia.types.graphic.GraphicContainer;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.dofus.types.entities.AnimatedCharacter;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import flash.desktop.Clipboard;
   import flash.desktop.ClipboardFormats;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.InteractiveObject;
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
   import flash.utils.Dictionary;
   
   public class Inspector
   {
       
      
      private var _tooltipTf:TextField;
      
      private var _tooltip:Sprite;
      
      private var _enable:Boolean;
      
      private var _lastTarget:Vector.<InteractiveItem>;
      
      private var _currentShortCut:Vector.<ShortcutItem>;
      
      private var _berilaAllInteraction:Boolean;
      
      private var _berilaChangedInteraction:Dictionary;
      
      private var _hierachicalMode:Boolean = true;
      
      private var _underPoint:Point;
      
      public function Inspector()
      {
         this._tooltipTf = new TextField();
         this._tooltip = new Sprite();
         this._berilaChangedInteraction = new Dictionary(true);
         this._underPoint = new Point();
         super();
         this._tooltip.mouseEnabled = false;
         this._tooltipTf.mouseEnabled = false;
         var tf:TextFormat = new TextFormat("Verdana");
         this._tooltipTf.defaultTextFormat = tf;
         this._tooltipTf.setTextFormat(tf);
         this._tooltipTf.multiline = true;
         this._tooltip.addChild(this._tooltipTf);
         this._tooltipTf.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public function get hierachicalMode() : Boolean
      {
         return this._hierachicalMode;
      }
      
      public function set hierachicalMode(value:Boolean) : void
      {
         this._hierachicalMode = value;
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
      
      private function onRollout(arg:*) : void
      {
         var item:InteractiveItem = null;
         for each(item in this._lastTarget)
         {
            item.cleanHighlight();
         }
         this._currentShortCut = null;
         if(this._tooltip.parent)
         {
            StageShareManager.stage.removeChild(this._tooltip);
         }
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
      
      private function onRelease(e:MouseEvent) : void
      {
         var tempTarget:DisplayObject = e.target as DisplayObject;
      }
      
      private function onMouseMove(e:MouseEvent) : void
      {
         var tooltipStr:String = null;
         var item:InteractiveItem = null;
         var currentTooltipStr:String = null;
         var rawTooltipStr:String = null;
         var s:ShortcutItem = null;
         var stageBounds:Rectangle = null;
         this.onRollout(this._lastTarget);
         this._lastTarget = !!this._hierachicalMode ? this.findElements(this.getDeepestObject(e.target as DisplayObject)) : this.findSameLevelElements();
         tooltipStr = "Mouse pos : " + StageShareManager.stage.mouseX + " / " + StageShareManager.stage.mouseY;
         var ind:String = "";
         for(var i:uint = 0; i < this._lastTarget.length; i++)
         {
            item = this._lastTarget[i];
            item.highlight(i,this._lastTarget);
            currentTooltipStr = (!!tooltipStr.length ? "<br/><br/>" : "") + item.tooltip();
            currentTooltipStr = currentTooltipStr.split("<br/>").join("<br/>" + ind);
            tooltipStr += currentTooltipStr;
            if(this._hierachicalMode)
            {
               ind += "&nbsp;&nbsp;&nbsp;";
            }
         }
         this._currentShortCut = null;
         if(this._lastTarget.length)
         {
            rawTooltipStr = tooltipStr;
            this._currentShortCut = !!this._lastTarget[0].shortcuts ? this._lastTarget[0].shortcuts.concat() : new Vector.<ShortcutItem>();
            this._currentShortCut.unshift(new ShortcutItem("Copier toutes les informations",Keyboard.C,function():void
            {
               var tf:* = new TextField();
               tf.htmlText = rawTooltipStr.split("<br/>").join("\n");
               Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,tf.text);
            },true,false,false));
            this._currentShortCut.unshift(new ShortcutItem("Activer l\'inspection avancée",Keyboard.Z,function():void
            {
               changeBeriliaInteraction();
            },true,true,false));
            tooltipStr += "<br/>-----------------------";
            for each(s in this._currentShortCut)
            {
               tooltipStr += "<br/>" + s.toString();
            }
         }
         if(tooltipStr.length)
         {
            this._tooltipTf.htmlText = tooltipStr;
            this._tooltip.graphics.clear();
            this._tooltip.graphics.beginFill(16777215,0.9);
            this._tooltip.graphics.lineStyle(1,0,0.7);
            this._tooltip.graphics.drawRect(-5,-5,this._tooltipTf.width * 1.1 + 10,this._tooltipTf.textHeight * 1.1 + 10);
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
      
      private function findSameLevelElements() : Vector.<InteractiveItem>
      {
         var currentItem:InteractiveItem = null;
         var item:DisplayObject = null;
         var result:Vector.<InteractiveItem> = new Vector.<InteractiveItem>();
         this._underPoint.x = StageShareManager.mouseX;
         this._underPoint.y = StageShareManager.mouseY;
         var objets:Array = StageShareManager.stage.getObjectsUnderPoint(this._underPoint);
         for each(item in objets)
         {
            while(item && !(item is Stage) && item.parent)
            {
               currentItem = this.cast(item);
               if(currentItem)
               {
                  result.push(currentItem);
                  break;
               }
               item = item.parent;
            }
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
               break;
            case target is GraphicCell:
            case target is CellContainer:
               currentItem = new InteractiveItemCell();
               currentItem.target = target;
               break;
            case target is AnimatedCharacter:
               currentItem = new InteractiveItemEntity();
               currentItem.target = target;
               currentItem = new InteractiveItemCell();
               currentItem.target = InteractiveCellManager.getInstance().getCell(AnimatedCharacter(target).position.cellId);
               break;
            case target is SpriteWrapper:
               currentItem = new InteractiveItemElement();
               currentItem.target = target;
               break;
            case target is FrustumShape:
               currentItem = new InteractiveItemMapBorder();
               currentItem.target = target;
         }
         return currentItem;
      }
      
      private function changeBeriliaInteraction() : void
      {
         var current:* = undefined;
         this._berilaAllInteraction = !this._berilaAllInteraction;
         if(this._berilaAllInteraction)
         {
            this.changeInteraction(Berilia.getInstance().docMain);
         }
         else
         {
            for(current in this._berilaChangedInteraction)
            {
               if(current is InteractiveObject && this._berilaChangedInteraction[current] == 1 || this._berilaChangedInteraction[current] == 3)
               {
                  InteractiveObject(current).mouseEnabled = false;
               }
               if(current is DisplayObjectContainer && this._berilaChangedInteraction[current] > 1)
               {
                  DisplayObjectContainer(current).mouseChildren = false;
               }
            }
            this._berilaChangedInteraction = new Dictionary(true);
         }
      }
      
      private function changeInteraction(target:DisplayObjectContainer) : void
      {
         var current:DisplayObject = null;
         for(var i:uint = 0; i < target.numChildren; i++)
         {
            current = target.getChildAt(i);
            if(current is InteractiveObject && !InteractiveObject(current).mouseEnabled)
            {
               InteractiveObject(current).mouseEnabled = true;
               this._berilaChangedInteraction[current] = 1;
            }
            if(current is DisplayObjectContainer)
            {
               if(!DisplayObjectContainer(current).mouseChildren)
               {
                  DisplayObjectContainer(current).mouseChildren = true;
                  this._berilaChangedInteraction[current] += 2;
               }
               this.changeInteraction(current as DisplayObjectContainer);
            }
         }
      }
      
      private function onKeyUp(e:KeyboardEvent) : void
      {
         var s:ShortcutItem = null;
         if(this._lastTarget && this._lastTarget.length && this._currentShortCut)
         {
            for each(s in this._currentShortCut)
            {
               if(s.ctrl == e.ctrlKey && s.shift == e.shiftKey && s.alt == e.altKey && s.key == e.keyCode)
               {
                  s.callback();
               }
            }
         }
      }
   }
}

class ShortcutItem
{
    
   
   public var legend:String;
   
   public var callback:Function;
   
   public var key:uint;
   
   public var ctrl:Boolean;
   
   public var shift:Boolean;
   
   public var alt:Boolean;
   
   function ShortcutItem(legend:String, key:uint, callback:Function, ctrl:Boolean, shift:Boolean, alt:Boolean)
   {
      super();
      this.legend = legend;
      this.key = key;
      this.callback = callback;
      this.ctrl = ctrl;
      this.alt = alt;
      this.shift = shift;
   }
   
   public function toString() : String
   {
      var keys:Array = [];
      if(this.ctrl)
      {
         keys.push("ctrl");
      }
      if(this.alt)
      {
         keys.push("alt");
      }
      if(this.shift)
      {
         keys.push("shift");
      }
      keys.push(String.fromCharCode(this.key));
      return keys.join(" + ") + " : " + this.legend;
   }
}

import flash.desktop.Clipboard;
import flash.desktop.ClipboardFormats;
import flash.display.DisplayObject;
import flash.display.Shape;
import flash.geom.ColorTransform;

class InteractiveItem
{
   
   protected static var _highlightShape:Shape = new Shape();
   
   protected static var _highlightShape2:Shape = new Shape();
   
   protected static var _highlightEffect:ColorTransform = new ColorTransform(1.2,1.2,1.2);
   
   protected static var _normalEffect:ColorTransform = new ColorTransform(1,1,1);
    
   
   public var shortcuts:Vector.<ShortcutItem>;
   
   public var target:DisplayObject;
   
   function InteractiveItem()
   {
      super();
   }
   
   public function highlight(index:uint, elements:Vector.<InteractiveItem>) : void
   {
   }
   
   public function cleanHighlight() : void
   {
   }
   
   public function tooltip() : String
   {
      return "";
   }
   
   protected function toClipboard(txt:String) : void
   {
      Clipboard.generalClipboard.setData(ClipboardFormats.TEXT_FORMAT,txt);
   }
}

import com.ankamagames.berilia.components.ComboBox;
import com.ankamagames.berilia.components.Grid;
import com.ankamagames.berilia.components.Label;
import com.ankamagames.berilia.components.Slot;
import com.ankamagames.berilia.components.TextureBase;
import com.ankamagames.berilia.managers.UiSoundManager;
import com.ankamagames.berilia.types.data.BeriliaUiElementSound;
import com.ankamagames.berilia.types.graphic.GraphicContainer;
import com.ankamagames.berilia.types.graphic.UiRootContainer;
import com.ankamagames.jerakine.utils.display.StageShareManager;
import flash.geom.Rectangle;
import flash.ui.Keyboard;
import flash.utils.getQualifiedClassName;

class InteractiveItemUi extends InteractiveItem
{
    
   
   function InteractiveItemUi()
   {
      super();
      shortcuts = Vector.<ShortcutItem>([new ShortcutItem("Cmd click test fonctionnel",Keyboard.Q,function():void
      {
         toClipboard("click( UiHelper.get(\"" + GraphicContainer(target).getUi().uiData.name + "\"), \"" + GraphicContainer(target).customUnicName + "\");");
      },true,true,false),new ShortcutItem("Cmd son survol",Keyboard.S,function():void
      {
         if(target is Grid || target is ComboBox)
         {
            toClipboard("/adduisoundelement " + GraphicContainer(target).getUi().uiData.name + " " + target.name + " onItemRollOver [ID_SON]");
         }
         else
         {
            toClipboard("/adduisoundelement " + GraphicContainer(target).getUi().uiData.name + " " + target.name + " onRollOver [ID_SON]");
         }
      },true,true,false),new ShortcutItem("Cmd son click",Keyboard.X,function():void
      {
         toClipboard("/adduisoundelement " + GraphicContainer(target).getUi().uiData.name + " " + target.name + " onRelease [ID_SON]");
      },true,true,false),new ShortcutItem("Cmd inspecter element",Keyboard.A,function():void
      {
         toClipboard("/inspectuielement " + GraphicContainer(target).getUi().uiData.name + " " + target.name);
      },true,true,false)]);
   }
   
   override public function highlight(index:uint, elements:Vector.<InteractiveItem>) : void
   {
      var pos:Rectangle = null;
      var elem:InteractiveItem = null;
      var firstElem:* = index == 0;
      var firstUi:Boolean = true;
      for each(elem in elements)
      {
         if(elem.target == target)
         {
            break;
         }
         if(elem is InteractiveItemUi && elem.target != target)
         {
            firstUi = false;
            break;
         }
      }
      if(target is UiRootContainer)
      {
         if(!firstUi)
         {
            firstUi = true;
            StageShareManager.stage.addChild(_highlightShape2);
            pos = target.getBounds(StageShareManager.stage);
            _highlightShape2.graphics.clear();
            _highlightShape2.graphics.lineStyle(2,255,0.7);
            _highlightShape2.graphics.beginFill(255,0);
            _highlightShape2.graphics.drawRect(pos.left,pos.top,pos.width,pos.height);
            _highlightShape2.graphics.endFill();
         }
      }
      else if(!firstElem)
      {
         StageShareManager.stage.addChild(_highlightShape);
         pos = target.getBounds(StageShareManager.stage);
         _highlightShape.graphics.clear();
         _highlightShape.graphics.lineStyle(3,0,0.7);
         _highlightShape.graphics.beginFill(16711680,0);
         _highlightShape.graphics.drawRect(pos.left,pos.top,pos.width,pos.height);
         _highlightShape.graphics.endFill();
      }
      else if(target is Grid || target is ComboBox)
      {
      }
   }
   
   override public function cleanHighlight() : void
   {
      if(_highlightShape2.parent)
      {
         StageShareManager.stage.removeChild(_highlightShape2);
      }
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
      var soundParams:Vector.<BeriliaUiElementSound> = null;
      var soundParam:BeriliaUiElementSound = null;
      var str:* = "";
      var color:String = "#0";
      if(target.name.indexOf("instance") == 0)
      {
         color = "#FF0000";
      }
      if(target is UiRootContainer)
      {
         uirc = target as UiRootContainer;
         str += "<b><font color=\'#62AAA6\'>Interface</font></b><br/>";
         if(uirc.uiData)
         {
            str += "<b>Nom : </b>" + uirc.uiData.name + "<br/>";
            str += "<b>Module : </b>" + uirc.uiData.module.id + "<br/>";
            str += "<b>Script : </b>" + uirc.uiData.uiClassName + "<br/>";
         }
         else
         {
            str += "<b>Aucune information</b><br/>";
         }
      }
      else
      {
         cptClass = getQualifiedClassName(target).split("::").pop();
         str += "<b><font color=\'#964D8C\'>Composant </font><font color=\'" + this.hashStringToColor(cptClass) + "\' >" + cptClass + "</font></b><br/>";
         str += "<b>Nom : </b><font color=\'" + color + "\'>" + target.name + "</font><br/>";
         switch(true)
         {
            case target is TextureBase:
               str += "<b>Chemin : </b>" + TextureBase(target).uri + "<br/>";
               break;
            case target is Label:
               str += "<b>Css : </b>" + Label(target).css + "<br/>";
               str += "<b>Classe css : </b>" + Label(target).cssClass + "<br/>";
               break;
            case target is Slot:
               str += "<b>emptyTexture : </b>" + Slot(target).emptyTexture + "<br/>";
               str += "<b>acceptDragTexture : </b>" + Slot(target).acceptDragTexture + "<br/>";
               str += "<b>refuseDragTexture : </b>" + Slot(target).refuseDragTexture + "<br/>";
         }
         soundParams = UiSoundManager.getInstance().getAllSoundUiElement(target as GraphicContainer);
         str += "<b>Sons : </b>" + (!!soundParams.length ? "" : "Aucun") + "";
         if(soundParams.length)
         {
            for each(soundParam in soundParams)
            {
               str += "<br/>&nbsp;&nbsp;&nbsp; - " + soundParam.hook + " : " + soundParam.file;
            }
         }
      }
      return str;
   }
}

import com.ankamagames.atouin.data.map.CellData;
import com.ankamagames.atouin.managers.MapDisplayManager;
import com.ankamagames.atouin.managers.SelectionManager;
import com.ankamagames.atouin.renderers.ZoneDARenderer;
import com.ankamagames.atouin.types.Selection;
import com.ankamagames.atouin.utils.DataMapProvider;
import com.ankamagames.jerakine.types.Color;
import com.ankamagames.jerakine.types.positions.MapPoint;
import com.ankamagames.jerakine.types.zones.Custom;
import flash.ui.Keyboard;

class InteractiveItemCell extends InteractiveItem
{
   
   private static var SELECTION_NAME:String = "InteractiveItemCellHighlight";
   
   private static var _selection:Selection = new Selection();
   
   {
      _selection.renderer = new ZoneDARenderer(0,0.5,true);
      _selection.color = new Color(16711680);
   }
   
   function InteractiveItemCell()
   {
      super();
      shortcuts = Vector.<ShortcutItem>([new ShortcutItem("Cmd click test fonctionnel",Keyboard.Q,function():void
      {
         toClipboard("click( CellHelper.get( " + Object(target).cellId + " );");
      },true,true,false)]);
   }
   
   override public function tooltip() : String
   {
      var cellId:uint = Object(target).cellId;
      var mp:MapPoint = MapPoint.fromCellId(cellId);
      var textInfo:* = "<b><font color=\'#66572D\'>Cell " + cellId + "</font></b> (" + mp.x + "/" + mp.y + ")";
      textInfo += "<br/>Ligne de vue : " + !DataMapProvider.getInstance().pointLos(mp.x,mp.y);
      textInfo += "<br/>Blocage éditeur : " + !DataMapProvider.getInstance().pointMov(mp.x,mp.y);
      textInfo += "<br/>Blocage entitée : " + !DataMapProvider.getInstance().pointMov(mp.x,mp.y,false);
      var cellData:CellData = CellData(MapDisplayManager.getInstance().getDataMapContainer().dataMap.cells[cellId]);
      if(cellData.useBottomArrow || cellData.useTopArrow || cellData.useRightArrow || cellData.useLeftArrow)
      {
         textInfo += "<br/>Forcage fleche bas : " + cellData.useBottomArrow;
         textInfo += "<br/>Forcage fleche haut : " + cellData.useTopArrow;
         textInfo += "<br/>Forcage fleche droite : " + cellData.useRightArrow;
         textInfo += "<br/>Forcage fleche gauche : " + cellData.useLeftArrow;
      }
      textInfo += "<br/>ID de zone : " + cellData.moveZone;
      textInfo += "<br/>Hauteur : " + cellData.floor + " px";
      return textInfo + ("<br/>Speed : " + cellData.speed);
   }
   
   override public function cleanHighlight() : void
   {
      _selection.remove();
   }
   
   override public function highlight(index:uint, elements:Vector.<InteractiveItem>) : void
   {
      _selection.zone = new Custom(Vector.<uint>([Object(target).cellId]));
      SelectionManager.getInstance().addSelection(_selection,SELECTION_NAME,Object(target).cellId);
   }
}

import com.ankamagames.dofus.datacenter.monsters.Monster;
import com.ankamagames.dofus.datacenter.npcs.Npc;
import com.ankamagames.dofus.datacenter.npcs.NpcAction;
import com.ankamagames.dofus.kernel.Kernel;
import com.ankamagames.dofus.logic.game.common.frames.AbstractEntitiesFrame;
import com.ankamagames.dofus.logic.game.fight.frames.FightEntitiesFrame;
import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
import com.ankamagames.dofus.network.types.game.context.GameContextActorInformations;
import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayGroupMonsterInformations;
import com.ankamagames.dofus.network.types.game.context.roleplay.GameRolePlayNpcInformations;
import com.ankamagames.dofus.network.types.game.context.roleplay.MonsterInGroupLightInformations;
import com.ankamagames.jerakine.entities.interfaces.IEntity;
import flash.net.URLRequest;
import flash.net.navigateToURL;
import flash.ui.Keyboard;
import flash.utils.Dictionary;

class InteractiveItemEntity extends InteractiveItem
{
    
   
   private var _cmd:String;
   
   function InteractiveItemEntity()
   {
      super();
      shortcuts = Vector.<ShortcutItem>([new ShortcutItem("Cmd click test fonctionnel",Keyboard.Q,function():void
      {
         toClipboard(_cmd);
      },true,true,false)]);
   }
   
   override public function tooltip() : String
   {
      var entities:Dictionary = null;
      var info:GameContextActorInformations = null;
      var npc:Npc = null;
      var monsterGroup:GameRolePlayGroupMonsterInformations = null;
      var monsters:Vector.<MonsterInGroupLightInformations> = null;
      var npcAction:NpcAction = null;
      var action:uint = 0;
      var m:MonsterInGroupLightInformations = null;
      var monster:Monster = null;
      var e:IEntity = target as IEntity;
      var str:String = "<b>Entity " + e.id + "</b>";
      var entityFrame:AbstractEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
      if(!entityFrame)
      {
         entityFrame = Kernel.getWorker().getFrame(FightEntitiesFrame) as FightEntitiesFrame;
      }
      if(entityFrame)
      {
         entities = entityFrame.entities;
      }
      else
      {
         entities = new Dictionary();
      }
      info = entities[e.id];
      this._cmd = "click( EntityHelper.get( " + e.id + " ) );";
      if(info)
      {
         switch(true)
         {
            case info is GameRolePlayNpcInformations:
               npc = Npc.getNpcById(GameRolePlayNpcInformations(info).npcId);
               str = "<b><font color=\'#4F8230\'>PNJ " + npc.name + "</font></b><br/>";
               str += "Npc Id: " + npc.id + "<br/>";
               str += "Entity Id: " + e.id + "<br/>";
               str += "look: " + npc.look;
               if(npc.actions && npc.actions.length > 0)
               {
                  for each(action in npc.actions)
                  {
                     npcAction = NpcAction.getNpcActionById(action);
                     str += "<br/> Skill : " + npcAction.name + " (id: " + npcAction.realId + ")";
                  }
               }
               this._cmd = "$(\"On parle avec le Pnj " + npc.name + " (id: " + npc.id + ")\" );\n";
               this._cmd += "npcDialog( EntityHelper.getNpc( " + npc.id + " ), rep1, rep2, ... );";
               shortcuts.push(new ShortcutItem("Ouvrir l\'admin lite de ce PNJ",Keyboard.A,function():void
               {
                  navigateToURL(new URLRequest("http://dofus.adminslite.lan:8080/admin?type=1402&value=" + npc.id + "&lang=fr"));
               },true,true,false));
               break;
            case info is GameRolePlayGroupMonsterInformations:
               str = "<b><font color=\'#ED4A61\'>Groupe de monstre</font></b><br/>";
               str += "id: " + e.id + "<br/>";
               monsterGroup = info as GameRolePlayGroupMonsterInformations;
               monsters = Vector.<MonsterInGroupLightInformations>([monsterGroup.staticInfos.mainCreatureLightInfos]);
               monsters = monsters.concat(monsterGroup.staticInfos.underlings);
               for each(m in monsters)
               {
                  monster = Monster.getMonsterById(m.genericId);
                  str += "<br/> " + monster.name + " (id: " + monster.id + ", lvl: " + monster.getMonsterGrade(m.grade).level + ", look: " + monster.look + ")";
               }
         }
      }
      return str;
   }
}

import com.ankamagames.atouin.Atouin;
import com.ankamagames.dofus.datacenter.jobs.Skill;
import com.ankamagames.dofus.kernel.Kernel;
import com.ankamagames.dofus.logic.game.roleplay.frames.RoleplayEntitiesFrame;
import com.ankamagames.dofus.network.types.game.interactive.InteractiveElement;
import com.ankamagames.dofus.network.types.game.interactive.InteractiveElementSkill;
import flash.ui.Keyboard;

class InteractiveItemElement extends InteractiveItem
{
    
   
   private var _cmd:String;
   
   function InteractiveItemElement()
   {
      super();
      shortcuts = Vector.<ShortcutItem>([new ShortcutItem("Cmd click test fonctionnel",Keyboard.Q,function():void
      {
         toClipboard(_cmd);
      },true,true,false)]);
   }
   
   override public function tooltip() : String
   {
      var ie:InteractiveElement = null;
      var skill:InteractiveElementSkill = null;
      var str:* = null;
      var entitiesFrame:RoleplayEntitiesFrame = Kernel.getWorker().getFrame(RoleplayEntitiesFrame) as RoleplayEntitiesFrame;
      if(!entitiesFrame)
      {
         return "";
      }
      var interactiveElementList:Vector.<InteractiveElement> = entitiesFrame.interactiveElements;
      var matches:Vector.<InteractiveElement> = new Vector.<InteractiveElement>();
      for each(ie in interactiveElementList)
      {
         if(Atouin.getInstance().getIdentifiedElement(ie.elementId) == target)
         {
            this._cmd = "click( InteractiveElementHelper.get( " + ie.elementId + " ) );";
            str = "<b><font color=\'#2A49AA\'>Element " + ie.elementId + "</font></b>";
            for each(skill in ie.enabledSkills)
            {
               str += "<br/> Skill : " + Skill.getSkillById(skill.skillId).name + " (id: " + Skill.getSkillById(skill.skillId).id + ")";
            }
            for each(skill in ie.disabledSkills)
            {
               str += "<br/> Skill disable : " + Skill.getSkillById(skill.skillId).name + " (id: " + Skill.getSkillById(skill.skillId).id + ")";
            }
            return str;
         }
      }
      return null;
   }
}

import com.ankamagames.atouin.managers.FrustumManager;
import com.ankamagames.atouin.types.FrustumShape;
import com.ankamagames.jerakine.types.enums.DirectionsEnum;
import flash.ui.Keyboard;

class InteractiveItemMapBorder extends InteractiveItem
{
    
   
   private var _cmd:String;
   
   function InteractiveItemMapBorder()
   {
      super();
      shortcuts = Vector.<ShortcutItem>([new ShortcutItem("Cmd click test fonctionnel",Keyboard.Q,function():void
      {
         toClipboard(_cmd);
      },true,true,false)]);
   }
   
   override public function tooltip() : String
   {
      var prc:uint = 0;
      var mb:FrustumShape = target as FrustumShape;
      switch(target)
      {
         case FrustumManager.getInstance().getShape(DirectionsEnum.LEFT):
         case FrustumManager.getInstance().getShape(DirectionsEnum.RIGHT):
            prc = Math.round(mb.mouseY / mb.height * 100);
            break;
         case FrustumManager.getInstance().getShape(DirectionsEnum.UP):
         case FrustumManager.getInstance().getShape(DirectionsEnum.DOWN):
            prc = Math.round(mb.mouseX / mb.width * 100);
      }
      return "<b><font color=\'#40BD00\'>Bord de map " + DirectionsEnum.getNameFromDirection(mb.direction) + " (" + prc + "%)</font></b>";
   }
}
