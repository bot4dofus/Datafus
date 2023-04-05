package com.ankamagames.dofus.console.moduleLogger
{
   import com.ankamagames.berilia.managers.KernelEventsManager;
   import com.ankamagames.dofus.console.moduleLUA.ConsoleLUA;
   import com.ankamagames.dofus.misc.lists.HookList;
   import com.ankamagames.jerakine.benchmark.FileLoggerEnum;
   import com.ankamagames.jerakine.benchmark.LogInFile;
   import com.ankamagames.jerakine.utils.benchmark.monitoring.FpsManagerUtils;
   import com.ankamagames.jerakine.utils.display.EnterFrameDispatcher;
   import com.ankamagames.jerakine.utils.display.StageShareManager;
   import com.ankamagames.jerakine.utils.display.enums.EnterFrameConst;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.system.System;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.getTimer;
   
   public final class ModuleDebugManager
   {
      
      private static const WIDTH:int = 220;
      
      private static const HEIGHT:int = 42;
      
      private static var _ui:Sprite;
      
      private static var _fpsShape:Shape;
      
      private static var _textField:TextField;
      
      private static var _lastSecond:int;
      
      private static var _numImages:int;
      
      private static var _offSetX:int;
      
      private static var _offSetY:int;
      
      private static var _valuesList:Vector.<int> = new Vector.<int>();
      
      private static var _lastValue:int = 0;
      
      private static var _console1:ConsoleIcon;
      
      private static var _console2:ConsoleIcon;
      
      private static var _console3:ConsoleIcon;
       
      
      public function ModuleDebugManager()
      {
         super();
      }
      
      public static function display(yes:Boolean, withConsoleButtons:Boolean = true) : void
      {
         if(yes)
         {
            if(!_ui)
            {
               createUI(withConsoleButtons);
            }
            StageShareManager.stage.addChild(_ui);
            _fpsShape.graphics.clear();
            _valuesList.length = 0;
            _lastValue = _lastSecond = getTimer();
            EnterFrameDispatcher.addEventListener(loop,EnterFrameConst.LOOP_MODULE_DEBUG_MANAGER);
         }
         else if(_ui && _ui.parent)
         {
            _ui.parent.removeChild(_ui);
         }
      }
      
      public static function get isDisplayed() : Boolean
      {
         return _ui && _ui.parent;
      }
      
      private static function loop(e:Event) : void
      {
         if(!_ui.stage)
         {
            EnterFrameDispatcher.removeEventListener(loop);
            return;
         }
         var time:int = getTimer();
         if(time - _lastSecond > 1000)
         {
            _textField.htmlText = "<font color=\'#7C87D1\'>FPS: " + _numImages + " / " + _ui.stage.frameRate + "</font>\n<font color=\'#00BBBB\'>MEM: " + FpsManagerUtils.calculateMB(System.totalMemory).toPrecision(4) + " / " + FpsManagerUtils.calculateMB(System.privateMemory).toPrecision(4) + " MB</font>";
            _numImages = 0;
            _lastSecond = time;
         }
         else
         {
            ++_numImages;
         }
         var newValue:int = time - _lastValue;
         _valuesList.push(-newValue);
         if(_valuesList.length > WIDTH)
         {
            _valuesList.shift();
         }
         _lastValue = time;
         _fpsShape.graphics.clear();
         _fpsShape.graphics.lineStyle(1,16777215,1,true);
         _fpsShape.graphics.moveTo(0,_valuesList[0]);
         var num:int = _valuesList.length;
         var i:int = 0;
         while(++i < num)
         {
            _fpsShape.graphics.lineTo(i,_valuesList[i]);
         }
      }
      
      private static function createUI(withConsoleButtons:Boolean) : void
      {
         if(_ui)
         {
            throw new Error();
         }
         _ui = new Sprite();
         _ui.x = _ui.y = 100;
         _fpsShape = new Shape();
         _ui.addChild(_fpsShape);
         _fpsShape.y = 20;
         var bg:Sprite = new Sprite();
         bg.doubleClickEnabled = true;
         _ui.addChild(bg);
         bg.graphics.beginFill(0,0.7);
         bg.graphics.lineTo(0,HEIGHT);
         bg.graphics.lineTo(WIDTH,HEIGHT);
         bg.graphics.lineTo(WIDTH,0);
         bg.graphics.endFill();
         bg.graphics.lineStyle(2);
         bg.graphics.moveTo(0,0);
         bg.graphics.lineTo(0,HEIGHT);
         bg.graphics.lineTo(WIDTH,HEIGHT);
         bg.graphics.lineTo(WIDTH,0);
         _textField = new TextField();
         _textField.y = 2;
         _ui.addChild(_textField);
         _textField.multiline = true;
         _textField.wordWrap = false;
         _textField.mouseEnabled = false;
         _textField.width = WIDTH;
         _textField.height = HEIGHT;
         var format:TextFormat = new TextFormat("Verdana",14,12763866);
         format.leading = 2;
         _textField.defaultTextFormat = format;
         if(withConsoleButtons)
         {
            _console1 = new ConsoleIcon("screen",16,"Open/close Module Console");
            _console1.x = WIDTH - (_console1.width + 2);
            _console1.y = HEIGHT - (_console1.height * 2 + 4);
            LogInFile.getInstance().logLine("ModuleDebugManager _console1.addEventListener onOpenConsole",FileLoggerEnum.EVENTLISTENERS);
            _console1.addEventListener(MouseEvent.MOUSE_DOWN,onOpenConsole,false,0,true);
            _ui.addChild(_console1);
            _console2 = new ConsoleIcon("terminal",16,"Open/close Console");
            _console2.x = WIDTH - (_console2.width + 2);
            _console2.y = HEIGHT - (_console2.height + 2);
            LogInFile.getInstance().logLine("ModuleDebugManager _console2.addEventListener onOpenLogConsole",FileLoggerEnum.EVENTLISTENERS);
            _console2.addEventListener(MouseEvent.MOUSE_DOWN,onOpenLogConsole,false,0,true);
            _ui.addChild(_console2);
            _console3 = new ConsoleIcon("script",16,"Open/close LUA Console");
            _console3.x = WIDTH - (_console3.width + 2) * 2;
            _console3.y = HEIGHT - (_console3.height + 2);
            LogInFile.getInstance().logLine("ModuleDebugManager _console3.addEventListener onOpenLuaConsole",FileLoggerEnum.EVENTLISTENERS);
            _console3.addEventListener(MouseEvent.MOUSE_DOWN,onOpenLuaConsole,false,0,true);
            _ui.addChild(_console3);
         }
         bg.addEventListener(MouseEvent.MOUSE_DOWN,onMouseDown,false,0,true);
         bg.addEventListener(MouseEvent.DOUBLE_CLICK,onMouseDoubleClick,false,0,true);
      }
      
      private static function onOpenLogConsole(e:Event) : void
      {
         LogInFile.getInstance().logLine("ModuleDebugManager onOpenLogConsole",FileLoggerEnum.EVENTLISTENERS);
         KernelEventsManager.getInstance().processCallback(HookList.ToggleConsole);
      }
      
      private static function onOpenConsole(e:Event) : void
      {
         LogInFile.getInstance().logLine("ModuleDebugManager onOpenConsole",FileLoggerEnum.EVENTLISTENERS);
         Console.getInstance().toggleDisplay();
      }
      
      private static function onOpenLuaConsole(e:Event) : void
      {
         LogInFile.getInstance().logLine("ModuleDebugManager onOpenLuaConsole",FileLoggerEnum.EVENTLISTENERS);
         ConsoleLUA.getInstance().toggleDisplay();
      }
      
      private static function onMouseDown(e:Event) : void
      {
         _offSetX = _ui.mouseX;
         _offSetY = _ui.mouseY;
         _ui.stage.addEventListener(MouseEvent.MOUSE_UP,onMouseUp,false,0,true);
         _ui.stage.addEventListener(MouseEvent.MOUSE_MOVE,onMouseMove,false,0,true);
      }
      
      private static function onMouseUp(e:Event) : void
      {
         _ui.stage.removeEventListener(MouseEvent.MOUSE_UP,onMouseUp);
         _ui.stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove);
      }
      
      private static function onMouseMove(e:MouseEvent) : void
      {
         _ui.x = _ui.stage.mouseX - _offSetX;
         _ui.y = _ui.stage.mouseY - _offSetY;
         e.updateAfterEvent();
      }
      
      private static function onMouseDoubleClick(event:MouseEvent) : void
      {
         System.gc();
      }
   }
}
