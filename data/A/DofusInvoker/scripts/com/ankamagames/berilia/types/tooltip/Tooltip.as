package com.ankamagames.berilia.types.tooltip
{
   import com.ankamagames.berilia.enums.TooltipChunkTypesEnum;
   import com.ankamagames.berilia.types.data.ChunkData;
   import com.ankamagames.berilia.types.graphic.UiRootContainer;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.managers.LangManager;
   import com.ankamagames.jerakine.types.Callback;
   import com.ankamagames.jerakine.types.Uri;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class Tooltip
   {
      
      public static var MEMORY_LOG:Dictionary = new Dictionary(true);
       
      
      protected var _log:Logger;
      
      private var _mainblock:TooltipBlock;
      
      private var _blocks:Array;
      
      private var _loadedblock:uint = 0;
      
      private var _mainblockLoaded:Boolean = false;
      
      private var _callbacks:Array;
      
      private var _content:String = "";
      
      private var _useSeparator:Boolean = true;
      
      private var _canMakeTooltip:Boolean;
      
      public var uiModuleName:String;
      
      public var scriptClass:Class;
      
      public var makerName:String;
      
      public var display:UiRootContainer;
      
      public var mustBeHidden:Boolean = true;
      
      public var htmlText:String;
      
      public var chunkType:String = "chunks";
      
      public var strata:int = 4;
      
      public function Tooltip(base:Uri, container:Uri, separator:Uri = null)
      {
         this._log = Log.getLogger(getQualifiedClassName(Tooltip));
         this._callbacks = new Array();
         super();
         this._canMakeTooltip = false;
         if(base == null && container == null)
         {
            return;
         }
         this._blocks = new Array();
         this._mainblock = new TooltipBlock();
         this._mainblock.addEventListener(Event.COMPLETE,this.onMainChunkLoaded);
         if(!separator)
         {
            this._useSeparator = false;
            this._mainblock.initChunk([new ChunkData("main",base),new ChunkData("container",container)]);
         }
         else
         {
            this._mainblock.initChunk([new ChunkData("main",base),new ChunkData("separator",separator),new ChunkData("container",container)]);
         }
         this._mainblock.init();
         MEMORY_LOG[this] = 1;
      }
      
      public function get mainBlock() : TooltipBlock
      {
         return this._mainblock;
      }
      
      public function addBlock(block:TooltipBlock) : void
      {
         this._blocks.push(block);
         block.addEventListener(Event.COMPLETE,this.onChunkReady);
         block.init();
      }
      
      public function updateAndReturnHtmlText() : String
      {
         if(this._mainblockLoaded && this._loadedblock == this._blocks.length)
         {
            this._canMakeTooltip = true;
            this.makeHtmlTooltip();
            return this.htmlText;
         }
         this._log.error("Could not return HTML text, blocks were not loaded!");
         return "";
      }
      
      public function get content() : String
      {
         return this._content;
      }
      
      public function askTooltip(callback:Callback) : void
      {
         this._canMakeTooltip = true;
         this._callbacks.push(callback);
         this.processCallback();
      }
      
      public function update(txt:String) : void
      {
         this._canMakeTooltip = true;
         this.processCallback();
      }
      
      private function onMainChunkLoaded(e:Event) : void
      {
         this._mainblockLoaded = true;
         this._mainblock.removeEventListener(Event.COMPLETE,this.onMainChunkLoaded);
         this.processCallback();
      }
      
      private function processCallback() : void
      {
         if(this._canMakeTooltip && this._mainblockLoaded && this._loadedblock == this._blocks.length)
         {
            if(this.chunkType == TooltipChunkTypesEnum.CHUNK_HTML)
            {
               this.makeHtmlTooltip();
            }
            else
            {
               this.makeTooltip();
            }
            while(this._callbacks.length)
            {
               Callback(this._callbacks.pop()).exec();
            }
         }
      }
      
      private function makeTooltip() : void
      {
         var blockContent:String = null;
         var block:TooltipBlock = null;
         var sep:String = this._mainblock.getChunk("separator").processContent(null);
         var result:Array = new Array();
         for each(block in this._blocks)
         {
            blockContent = block.content;
            if(blockContent)
            {
               result.push(this._mainblock.getChunk("container").processContent({"content":blockContent}));
            }
         }
         if(this._useSeparator)
         {
            this._content = this._mainblock.getChunk("main").processContent({"content":result.join(this._mainblock.getChunk("separator").processContent(null))});
         }
         else
         {
            this._content = this._mainblock.getChunk("main").processContent({"content":result.join("")});
         }
      }
      
      private function makeHtmlTooltip() : void
      {
         var blockContent:String = null;
         var block:TooltipBlock = null;
         this.htmlText = "";
         var sep:String = this._mainblock.getChunk("separator").processContent(null);
         var result:Array = new Array();
         for each(block in this._blocks)
         {
            blockContent = block.content;
            if(blockContent)
            {
               result.push(this._mainblock.getChunk("container").processContent({"content":blockContent}));
               this.htmlText += LangManager.getInstance().replaceKey(blockContent,false);
            }
            if(this._useSeparator)
            {
               this.htmlText += sep;
            }
         }
         if(this._useSeparator)
         {
            this._content = this._mainblock.getChunk("main").processContent({"content":result.join(this._mainblock.getChunk("separator").processContent(null))});
            this.htmlText = this.htmlText.substr(0,this.htmlText.length - sep.length);
         }
         else
         {
            this._content = this._mainblock.getChunk("main").processContent({"content":result.join("")});
         }
      }
      
      private function onChunkReady(e:Event) : void
      {
         e.currentTarget.removeEventListener(Event.COMPLETE,this.onChunkReady);
         ++this._loadedblock;
         this.processCallback();
      }
   }
}
