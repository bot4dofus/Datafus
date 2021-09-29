package org.audiofx.mp3
{
   import com.ankamagames.jerakine.pools.Poolable;
   import com.ankamagames.jerakine.utils.system.AirScanner;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.media.Sound;
   import flash.net.FileReference;
   import flash.system.LoaderContext;
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   [Event(name="complete",type="org.audiofx.mp3.MP3SoundEvent")]
   public class MP3FileReferenceLoader extends EventDispatcher implements Poolable
   {
       
      
      private var mp3Parser:MP3Parser;
      
      public function MP3FileReferenceLoader()
      {
         super();
         this.mp3Parser = new MP3Parser(this);
      }
      
      public static function create(instance:MP3FileReferenceLoader = null) : MP3FileReferenceLoader
      {
         if(!instance)
         {
            instance = new MP3FileReferenceLoader();
         }
         return instance;
      }
      
      public function loadMP3ByteArray(ba:ByteArray) : void
      {
         this.mp3Parser.addEventListener(Event.COMPLETE,this.parserCompleteHandler);
         this.mp3Parser.loadMP3ByteArray(ba);
      }
      
      public function parsingDone(parser:MP3Parser) : void
      {
         this.generateSound(parser);
      }
      
      public function getSound(fr:FileReference) : void
      {
         this.mp3Parser.addEventListener(Event.COMPLETE,this.parserCompleteHandler);
         this.mp3Parser.loadFileRef(fr);
      }
      
      public function free() : void
      {
         this.mp3Parser.free();
         this.mp3Parser.removeEventListener(Event.COMPLETE,this.parserCompleteHandler);
      }
      
      private function parserCompleteHandler(ev:Event) : void
      {
         var parser:MP3Parser = ev.currentTarget as MP3Parser;
         this.generateSound(parser);
      }
      
      private function generateSound(mp3Source:MP3Parser) : Boolean
      {
         var seg:ByteArraySegment = null;
         var swfBytes:ByteArray = new ByteArray();
         swfBytes.endian = Endian.LITTLE_ENDIAN;
         for(var i:uint = 0; i < SoundClassSwfByteCode.soundClassSwfBytes1.length; i++)
         {
            swfBytes.writeByte(SoundClassSwfByteCode.soundClassSwfBytes1[i]);
         }
         var swfSizePosition:uint = swfBytes.position;
         swfBytes.writeInt(0);
         for(i = 0; i < SoundClassSwfByteCode.soundClassSwfBytes2.length; i++)
         {
            swfBytes.writeByte(SoundClassSwfByteCode.soundClassSwfBytes2[i]);
         }
         var audioSizePosition:uint = swfBytes.position;
         swfBytes.writeInt(0);
         swfBytes.writeByte(1);
         swfBytes.writeByte(0);
         mp3Source.writeSwfFormatByte(swfBytes);
         var sampleSizePosition:uint = swfBytes.position;
         swfBytes.writeInt(0);
         swfBytes.writeByte(0);
         swfBytes.writeByte(0);
         var frameCount:uint = 0;
         var byteCount:uint = 0;
         while(true)
         {
            seg = mp3Source.getNextFrame();
            if(seg == null)
            {
               break;
            }
            swfBytes.writeBytes(seg.byteArray,seg.start,seg.length);
            byteCount += seg.length;
            frameCount++;
         }
         if(byteCount == 0)
         {
            return false;
         }
         byteCount += 2;
         var currentPos:uint = swfBytes.position;
         swfBytes.position = audioSizePosition;
         swfBytes.writeInt(byteCount + 7);
         swfBytes.position = sampleSizePosition;
         swfBytes.writeInt(frameCount * 1152);
         swfBytes.position = currentPos;
         for(i = 0; i < SoundClassSwfByteCode.soundClassSwfBytes3.length; i++)
         {
            swfBytes.writeByte(SoundClassSwfByteCode.soundClassSwfBytes3[i]);
         }
         swfBytes.position = swfSizePosition;
         swfBytes.writeInt(swfBytes.length);
         swfBytes.position = 0;
         var swfBytesLoader:Loader = new Loader();
         swfBytesLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.swfCreated);
         var lc:LoaderContext = new LoaderContext();
         AirScanner.allowByteCodeExecution(lc,true);
         swfBytesLoader.loadBytes(swfBytes,lc);
         return true;
      }
      
      private function swfCreated(ev:Event) : void
      {
         ev.target.removeEventListener(ev.type,this.swfCreated);
         var loaderInfo:LoaderInfo = ev.currentTarget as LoaderInfo;
         var soundClass:Class = loaderInfo.applicationDomain.getDefinition("SoundClass") as Class;
         var sound:Sound = new soundClass();
         dispatchEvent(new MP3SoundEvent(MP3SoundEvent.COMPLETE,sound,this.mp3Parser.channels));
      }
   }
}
