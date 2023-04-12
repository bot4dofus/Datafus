package com.ankamagames.berilia.types.tooltip
{
   import com.ankamagames.berilia.types.data.ChunkData;
   import com.ankamagames.jerakine.logger.Log;
   import com.ankamagames.jerakine.logger.Logger;
   import com.ankamagames.jerakine.resources.events.ResourceErrorEvent;
   import com.ankamagames.jerakine.resources.events.ResourceLoadedEvent;
   import com.ankamagames.jerakine.resources.loaders.IResourceLoader;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderFactory;
   import com.ankamagames.jerakine.resources.loaders.ResourceLoaderType;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class TooltipBlock extends EventDispatcher
   {
      
      private static var _chunckCache:Dictionary = new Dictionary();
       
      
      protected var _log:Logger;
      
      private var _loader:IResourceLoader;
      
      private var _loadedChunk:uint = 0;
      
      private var _totalChunk:uint = 0;
      
      private var _chunksUri:Array;
      
      private var _chunks:Array;
      
      public var onAllChunkLoadedCallback:Function;
      
      public var contentGetter:Function;
      
      public var chunkType:String;
      
      public function TooltipBlock()
      {
         this._log = Log.getLogger(getQualifiedClassName(TooltipBlock));
         this._chunks = new Array();
         super();
         this._loader = ResourceLoaderFactory.getLoader(ResourceLoaderType.PARALLEL_LOADER);
         this._loader.addEventListener(ResourceLoadedEvent.LOADED,this.onLoaded);
         this._loader.addEventListener(ResourceErrorEvent.ERROR,this.onLoadError);
      }
      
      public static function clearCache() : void
      {
         _chunckCache = new Dictionary();
      }
      
      public function get loadedChunk() : uint
      {
         return this._loadedChunk;
      }
      
      public function get totalChunk() : uint
      {
         return this._totalChunk;
      }
      
      public function initChunk(chunksList:Array) : void
      {
         var chunk:ChunkData = null;
         var chunkCache:String = null;
         this._chunksUri = chunksList;
         this._totalChunk = chunksList.length;
         this._loadedChunk = 0;
         for(var i:uint = 0; i < this._totalChunk; i++)
         {
            chunk = chunksList[i];
            chunkCache = _chunckCache[chunk.uri.path];
            if(chunkCache)
            {
               this._chunks[chunk.name] = chunkCache;
               this._chunksUri.splice(i,1);
               i--;
               --this._totalChunk;
            }
            else
            {
               chunk.uri.tag = chunk.name;
            }
         }
      }
      
      public function init() : void
      {
         var i:uint = 0;
         this._totalChunk = this._chunksUri.length;
         if(this._totalChunk)
         {
            this._loadedChunk = 0;
            for(i = 0; i < this._totalChunk; i++)
            {
               this._loader.load(ChunkData(this._chunksUri[i]).uri);
            }
         }
         else
         {
            this.onAllChunkLoaded();
         }
      }
      
      public function getChunk(name:String) : TooltipChunk
      {
         var data:String = this._chunks[name];
         return new TooltipChunk(data);
      }
      
      public function get content() : String
      {
         if(this.contentGetter != null)
         {
            return this.contentGetter();
         }
         return "[Abstract tooltip]";
      }
      
      protected function onAllChunkLoaded() : void
      {
         if(this.onAllChunkLoadedCallback != null)
         {
            this.onAllChunkLoadedCallback();
         }
         this._loader.removeEventListener(ResourceLoadedEvent.LOADED,this.onLoaded);
         this._loader.removeEventListener(ResourceErrorEvent.ERROR,this.onLoadError);
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      private function onLoaded(e:ResourceLoadedEvent) : void
      {
         ++this._loadedChunk;
         _chunckCache[e.uri.path] = e.resource;
         this._chunks[e.uri.tag] = e.resource;
         if(this._loadedChunk == this._totalChunk)
         {
            this.onAllChunkLoaded();
         }
      }
      
      private function onLoadError(e:ResourceErrorEvent) : void
      {
         ++this._loadedChunk;
         if(this._loadedChunk == this._totalChunk)
         {
            this.onAllChunkLoaded();
         }
         this._chunks[e.uri.tag] = new TooltipChunk("[loading error on " + e.uri.tag + "]");
      }
   }
}
