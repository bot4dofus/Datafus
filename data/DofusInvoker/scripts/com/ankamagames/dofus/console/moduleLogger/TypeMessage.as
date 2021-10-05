package com.ankamagames.dofus.console.moduleLogger
{
   import com.ankamagames.berilia.types.shortcut.Bind;
   import com.ankamagames.jerakine.handlers.messages.Action;
   import com.ankamagames.jerakine.logger.LogLevel;
   import com.ankamagames.jerakine.messages.Message;
   import com.ankamagames.jerakine.utils.misc.DescribeTypeCache;
   import flash.display.DisplayObject;
   import flash.utils.getQualifiedClassName;
   
   public final class TypeMessage
   {
      
      public static const TYPE_HOOK:int = 0;
      
      public static const TYPE_UI:int = 1;
      
      public static const TYPE_ACTION:int = 2;
      
      public static const TYPE_SHORTCUT:int = 3;
      
      public static const TYPE_MODULE_LOG:int = 4;
      
      public static const LOG:int = 5;
      
      public static const LOG_CHAT:int = 17;
      
      public static const TAB:String = "                  • ";
       
      
      public var name:String = "";
      
      public var textInfo:String;
      
      public var type:int = -1;
      
      public var logType:int = -1;
      
      private var search1:RegExp;
      
      private var search2:RegExp;
      
      private var vectorExp:RegExp;
      
      public function TypeMessage(... args)
      {
         var object:Object = null;
         this.search1 = /</g;
         this.search2 = />/g;
         this.vectorExp = /Vector.<(.*)::(.*)>/g;
         super();
         try
         {
            object = args[0];
            if(object is String && args.length > 1 && args[1] == "hook")
            {
               this.displayHookInformations(object as String,args[1]);
            }
            else if(object is String && args.length == 2)
            {
               this.displayLog(object as String,args[1]);
            }
            else if(object is String && args[1] == LOG_CHAT)
            {
               this.type = LOG_CHAT;
               this.textInfo = "<span class=\'" + args[2] + "\'>[" + this.getDate() + "] " + String(object) + "</span>";
            }
            else if(object is Action)
            {
               this.displayActionInformations(object as Action);
            }
            else if(object is Message)
            {
               this.displayInteractionMessage(object as Message,args[1]);
            }
            else if(object is Bind)
            {
               this.displayBind(object as Bind,args[1]);
            }
            else
            {
               this.name = "trace";
               this.textInfo = object as String;
               this.type = LOG;
            }
         }
         catch(e:Error)
         {
            if(!(object is String))
            {
               name = "trace";
               textInfo = "<span class=\'red\'>" + e.getStackTrace() + "</span>";
            }
         }
      }
      
      private function displayBind(bind:Bind, ui:Object) : void
      {
         this.type = TYPE_SHORTCUT;
         var textBind:String = "Shortcut : " + bind.key.toUpperCase() + " --&gt; \"" + bind.targetedShortcut + "\" " + (!!bind.alt ? "Alt+" : "") + (!!bind.ctrl ? "Ctrl+" : "") + (!!bind.shift ? "Shift+" : "");
         this.name = "Shortcut";
         this.textInfo = "<span class=\'gray\'>[" + this.getDate() + "]</span>" + "<span class=\'yellow\'> BIND   : <a href=\'event:@shortcut\'>" + textBind + "</a></span>" + "\n<span class=\'gray+\'>" + TAB + "target : " + ui + "</span>\n";
      }
      
      private function displayInteractionMessage(msg:Message, ui:DisplayObject) : void
      {
         var infos:Array = null;
         var num:int = 0;
         var i:int = 0;
         this.type = TYPE_UI;
         var className:String = getQualifiedClassName(msg);
         if(className.indexOf("::") != -1)
         {
            className = className.split("::")[1];
         }
         this.name = className;
         var text:* = "<span class=\'gray\'>[" + this.getDate() + "]</span>" + "<span class=\'green\'> UI     : <a href=\'event:@" + this.name + "\'>" + this.name + "</a></span>" + "\n<span class=\'gray+\'>" + TAB + "target : " + ui.name + "</span><span class=\'gray\'>";
         var baseName:String = String(msg);
         if(baseName.indexOf("@") != -1)
         {
            infos = baseName.split("@");
            num = infos.length;
            for(i = 1; i < num; i++)
            {
               text += "\n" + TAB + infos[i];
            }
         }
         this.textInfo = text + "</span>\n";
      }
      
      private function displayHookInformations(hook:String, args:Array) : void
      {
         var arg:Object = null;
         var className:String = null;
         var textArg:String = null;
         this.type = TYPE_HOOK;
         this.name = hook;
         var text:* = "<span class=\'gray\'>[" + this.getDate() + "]</span>" + "<span class=\'blue\'> HOOK   : <a href=\'event:@" + this.name + "\'>" + this.name + "</a></span>" + "<span class=\'gray\'>";
         var num:int = args.length;
         for(var i:int = 0; i < num; i++)
         {
            arg = args[i];
            className = getQualifiedClassName(arg);
            className = className.replace(this.vectorExp,"Vector.<$2>");
            className = className.replace(this.search1,"&lt;");
            className = className.replace(this.search2,"&gt;");
            if(className.indexOf("::") != -1)
            {
               className = className.split("::")[1];
            }
            if(arg != null)
            {
               textArg = arg.toString();
               textArg = textArg.replace(this.search1,"&lt;");
               textArg = textArg.replace(this.search2,"&gt;");
            }
            text += "\n" + TAB + "arg" + i + ":" + className + " = " + textArg;
         }
         text += "</span>\n";
         this.textInfo = text;
      }
      
      private function displayLog(text:String, level:int) : void
      {
         var finalText:String = null;
         this.name = text;
         if(level == LogLevel.DEBUG)
         {
            finalText = "<span class=\'blue\'>";
         }
         else if(level == LogLevel.TRACE)
         {
            finalText = "<span class=\'green\'>";
         }
         else if(level == LogLevel.INFO)
         {
            finalText = "<span class=\'yellow\'>";
         }
         else if(level == LogLevel.WARN)
         {
            finalText = "<span class=\'orange\'>";
         }
         else if(level == LogLevel.ERROR)
         {
            finalText = "<span class=\'red\'>";
         }
         else if(level == LogLevel.FATAL)
         {
            finalText = "<span class=\'red+\'>";
         }
         else if(level == LOG_CHAT)
         {
            this.logType = LOG_CHAT;
            finalText = "<span class=\'white\'>";
         }
         else
         {
            finalText = "<span class=\'gray\'>";
         }
         finalText += "[" + this.getDate() + "] " + text + "</span>";
         this.textInfo = finalText;
      }
      
      private function displayActionInformations(action:Action) : void
      {
         var varName:String = null;
         var value:String = null;
         this.type = TYPE_ACTION;
         var actionName:String = getQualifiedClassName(action).split("::")[1];
         this.name = actionName;
         var text:* = "<span class=\'gray\'>[" + this.getDate() + "]</span>" + "<span class=\'pink\'> ACTION : <a href=\'event:@" + this.name + "\'>" + this.name + "</a></span>" + "<span class=\'gray\'>";
         var variables:Vector.<String> = DescribeTypeCache.getVariables(action,false,true,false,true);
         for each(varName in variables)
         {
            value = String(action[varName]);
            value = value.replace(this.search1,"&lt;");
            value = value.replace(this.search2,"&gt;");
            if(action[varName] is String)
            {
               text += "\n" + TAB + varName + " = " + "\"" + value + "\"";
            }
            else
            {
               text += "\n" + TAB + varName + " = " + value;
            }
         }
         text += "</span>\n";
         this.textInfo = text;
      }
      
      private function getDate() : String
      {
         var date:Date = new Date();
         var hours:int = date.hours;
         var minutes:int = date.minutes;
         var seconds:int = date.seconds;
         return (hours < 10 ? "0" + hours : hours) + ":" + (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds < 10 ? "0" + seconds : seconds);
      }
   }
}
