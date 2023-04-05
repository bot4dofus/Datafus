package com.ankamagames.dofus.misc.options
{
   import com.ankamagames.berilia.managers.CssManager;
   import com.ankamagames.berilia.types.data.ExtendedStyleSheet;
   import com.ankamagames.dofus.datacenter.communication.ChatChannel;
   import com.ankamagames.dofus.internalDatacenter.DataEnum;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.OptionManager;
   import com.ankamagames.jerakine.types.Callback;
   import flash.events.Event;
   import flash.utils.getQualifiedClassName;
   
   public class ChatOptions extends OptionManager
   {
      
      protected static const _log:Logger = Log.getLogger(getQualifiedClassName(ChatOptions));
      
      public static const CSS_LOADED:String = "CSS_LOADED";
       
      
      public var colors:Array;
      
      public function ChatOptions()
      {
         this.colors = new Array();
         super("chat");
         add("channelLocked",false);
         add("filterInsult",true);
         add("letLivingObjectTalk",true);
         add("smileysAutoclosed",false);
         add("showTime",false);
         add("showShortcut",false);
         add("showInfoPrefix",false);
         add("chatFontSize",1);
         add("channelTabs",[[DataEnum.CHAT_CHANNEL_GENERAL,DataEnum.CHAT_CHANNEL_TEAM,DataEnum.CHAT_CHANNEL_GUILD,DataEnum.CHAT_CHANNEL_ALLIANCE,DataEnum.CHAT_CHANNEL_GROUP,DataEnum.CHAT_CHANNEL_NOOB,DataEnum.CHAT_CHANNEL_ADMIN,DataEnum.CHAT_CHANNEL_PRIVATE,DataEnum.CHAT_CHANNEL_INFORMATION,DataEnum.CHAT_CHANNEL_PROMOTIONAL,DataEnum.CHAT_CHANNEL_ARENA,DataEnum.CHAT_CHANNEL_COMMUNITY],[DataEnum.CHAT_CHANNEL_INFORMATION,DataEnum.CHAT_CHANNEL_FIGHT],[DataEnum.CHAT_CHANNEL_PRIVATE],[DataEnum.CHAT_CHANNEL_GUILD,DataEnum.CHAT_CHANNEL_TRADE,DataEnum.CHAT_CHANNEL_RECRUITMENT]]);
         add("tabsNames",["0","1","2","3"]);
         add("currentChatTheme","");
         add("externalChatEnabledChannels",[]);
         var cssUrl:String = "theme://css/chat.css";
         CssManager.getInstance().askCss(cssUrl,new Callback(this.onCssLoaded,cssUrl));
      }
      
      private function onCssLoaded(cssUrl:String) : void
      {
         var styleObj:Object = null;
         var _ssSheet:ExtendedStyleSheet = CssManager.getInstance().getCss(cssUrl);
         var chatOptions:ChatOptions = OptionManager.getOptionManager("chat") as ChatOptions;
         var theme:String = OptionManager.getOptionManager("dofus").getOption("currentUiSkin");
         var chatTheme:String = chatOptions.getOption("currentChatTheme");
         var channelsCount:int = ChatChannel.getChannels().length;
         for(var i:int = 0; i < channelsCount; i++)
         {
            styleObj = _ssSheet.getStyle("p" + i);
            if(!styleObj || styleObj == null || !styleObj.hasOwnProperty("color"))
            {
               styleObj = _ssSheet.getStyle("p0");
            }
            this.colors[i] = uint(this.color0x(styleObj["color"]));
            add("channelColor" + i,this.colors[i]);
            if(theme != chatTheme)
            {
               chatOptions.setOption("channelColor" + i,this.colors[i]);
            }
         }
         if(theme != chatTheme)
         {
            chatOptions.setOption("currentChatTheme",theme);
         }
         styleObj = _ssSheet.getStyle("p");
         add("alertColor",uint(this.color0x(styleObj["color"])));
         dispatchEvent(new Event(CSS_LOADED));
      }
      
      private function color0x(color:String) : String
      {
         return color.replace("#","0x");
      }
   }
}
