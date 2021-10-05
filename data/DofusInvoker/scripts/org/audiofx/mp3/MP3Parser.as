package org.audiofx.mp3
{
   import com.ankamagames.jerakine.pools.Poolable;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.net.FileReference;
   import flash.net.URLLoader;
   import flash.net.URLLoaderDataFormat;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   [Event(name="complete",type="flash.events.Event")]
   class MP3Parser extends EventDispatcher implements Poolable
   {
      
      private static var bitRates:Array = [-1,32,40,48,56,64,80,96,112,128,160,192,224,256,320,-1,-1,8,16,24,32,40,48,56,64,80,96,112,128,144,160,-1];
      
      private static var versions:Array = [2.5,-1,2,1];
      
      private static var samplingRates:Array = [44100,48000,32000];
       
      
      private var mp3Data:ByteArray;
      
      private var loader:URLLoader;
      
      private var currentPosition:uint;
      
      private var sampleRate:uint;
      
      public var channels:uint;
      
      private var version:uint;
      
      private var m_parent:MP3FileReferenceLoader;
      
      function MP3Parser(parent:MP3FileReferenceLoader)
      {
         super();
         this.m_parent = parent;
      }
      
      public function loadMP3ByteArray(bytes:ByteArray) : void
      {
         this.mp3Data = bytes;
         this.currentPosition = this.getFirstHeaderPosition();
         this.m_parent.parsingDone(this);
      }
      
      public function free() : void
      {
         this.mp3Data.clear();
         this.mp3Data = null;
         this.loader = null;
         this.currentPosition = 0;
      }
      
      function load(url:String) : void
      {
         this.loader = new URLLoader();
         this.loader.dataFormat = URLLoaderDataFormat.BINARY;
         this.loader.addEventListener(Event.COMPLETE,this.loaderCompleteHandler);
         var req:URLRequest = new URLRequest(url);
         this.loader.load(req);
      }
      
      function loadFileRef(fileRef:FileReference) : void
      {
         fileRef.addEventListener(Event.COMPLETE,this.loaderCompleteHandler);
         fileRef.addEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
         fileRef.load();
      }
      
      private function errorHandler(ev:IOErrorEvent) : void
      {
         ev.target.removeEventListener(Event.COMPLETE,this.loaderCompleteHandler);
         ev.target.removeEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
      }
      
      private function loaderCompleteHandler(ev:Event) : void
      {
         ev.target.removeEventListener(Event.COMPLETE,this.loaderCompleteHandler);
         ev.target.removeEventListener(IOErrorEvent.IO_ERROR,this.errorHandler);
         this.mp3Data = ev.currentTarget.data as ByteArray;
         this.currentPosition = this.getFirstHeaderPosition();
         dispatchEvent(ev);
      }
      
      private function getFirstHeaderPosition() : uint
      {
         var readPosition:uint = 0;
         var str:String = null;
         var val:uint = 0;
         var b3:* = 0;
         var b2:* = 0;
         var b1:* = 0;
         var b0:* = 0;
         var headerLength:int = 0;
         var newPosition:int = 0;
         this.mp3Data.position = 0;
         while(this.mp3Data.position < this.mp3Data.length)
         {
            readPosition = this.mp3Data.position;
            str = this.mp3Data.readUTFBytes(3);
            if(str == "ID3")
            {
               this.mp3Data.position += 3;
               b3 = (this.mp3Data.readByte() & 127) << 21;
               b2 = (this.mp3Data.readByte() & 127) << 14;
               b1 = (this.mp3Data.readByte() & 127) << 7;
               b0 = this.mp3Data.readByte() & 127;
               headerLength = b0 + b1 + b2 + b3;
               newPosition = this.mp3Data.position + headerLength;
               this.mp3Data.position = newPosition;
               readPosition = newPosition;
            }
            else
            {
               this.mp3Data.position = readPosition;
            }
            val = this.mp3Data.readInt();
            if(this.isValidHeader(val))
            {
               this.parseHeader(val);
               this.mp3Data.position = readPosition + this.getFrameSize(val);
               if(this.isValidHeader(this.mp3Data.readInt()))
               {
                  return readPosition;
               }
            }
         }
         throw new Error("Could not locate first header. This isn\'t an MP3 file");
      }
      
      function getNextFrame() : ByteArraySegment
      {
         var headerByte:uint = 0;
         var frameSize:uint = 0;
         this.mp3Data.position = this.currentPosition;
         while(this.currentPosition <= this.mp3Data.length - 4)
         {
            headerByte = this.mp3Data.readInt();
            if(this.isValidHeader(headerByte))
            {
               frameSize = this.getFrameSize(headerByte);
               if(frameSize != 4294967295)
               {
                  this.mp3Data.position = this.currentPosition;
                  if(this.currentPosition + frameSize > this.mp3Data.length)
                  {
                     return null;
                  }
                  this.currentPosition += frameSize;
                  return new ByteArraySegment(this.mp3Data,this.mp3Data.position,frameSize);
               }
            }
            this.currentPosition = this.mp3Data.position;
         }
         return null;
      }
      
      function writeSwfFormatByte(byteArray:ByteArray) : void
      {
         var sampleRateIndex:uint = 4 - 44100 / this.sampleRate;
         byteArray.writeByte((2 << 4) + (sampleRateIndex << 2) + (1 << 1) + (this.channels - 1));
      }
      
      private function parseHeader(headerBytes:uint) : void
      {
         var channelMode:uint = this.getModeIndex(headerBytes);
         this.version = this.getVersionIndex(headerBytes);
         var samplingRate:uint = this.getFrequencyIndex(headerBytes);
         this.channels = channelMode > 2 ? uint(1) : uint(2);
         var actualVersion:Number = versions[this.version];
         var samplingRates:Array = [44100,48000,32000];
         this.sampleRate = samplingRates[samplingRate];
         switch(actualVersion)
         {
            case 2:
               this.sampleRate /= 2;
               break;
            case 2.5:
               this.sampleRate /= 4;
         }
      }
      
      private function getFrameSize(headerBytes:uint) : uint
      {
         var version:uint = this.getVersionIndex(headerBytes);
         var bitRate:uint = this.getBitrateIndex(headerBytes);
         var samplingRate:uint = this.getFrequencyIndex(headerBytes);
         var padding:uint = this.getPaddingBit(headerBytes);
         var channelMode:uint = this.getModeIndex(headerBytes);
         var actualVersion:Number = versions[version];
         var sampleRate:uint = samplingRates[samplingRate];
         if(this.version != version)
         {
            return 4294967295;
         }
         switch(actualVersion)
         {
            case 2:
               sampleRate /= 2;
               break;
            case 2.5:
               sampleRate /= 4;
         }
         var bitRatesYIndex:uint = (actualVersion == 1 ? 0 : 1) * bitRates.length / 2;
         var actualBitRate:uint = bitRates[bitRatesYIndex + bitRate] * 1000;
         return uint((actualVersion == 1 ? 144 : 72) * actualBitRate / sampleRate + padding);
      }
      
      private function isValidHeader(headerBits:uint) : Boolean
      {
         return (this.getFrameSync(headerBits) & 2047) == 2047 && (this.getVersionIndex(headerBits) & 3) != 1 && (this.getLayerIndex(headerBits) & 3) != 0 && (this.getBitrateIndex(headerBits) & 15) != 0 && (this.getBitrateIndex(headerBits) & 15) != 15 && (this.getFrequencyIndex(headerBits) & 3) != 3 && (this.getEmphasisIndex(headerBits) & 3) != 2;
      }
      
      private function getFrameSync(headerBits:uint) : uint
      {
         return uint(headerBits >> 21 & 2047);
      }
      
      private function getVersionIndex(headerBits:uint) : uint
      {
         return uint(headerBits >> 19 & 3);
      }
      
      private function getLayerIndex(headerBits:uint) : uint
      {
         return uint(headerBits >> 17 & 3);
      }
      
      private function getBitrateIndex(headerBits:uint) : uint
      {
         return uint(headerBits >> 12 & 15);
      }
      
      private function getFrequencyIndex(headerBits:uint) : uint
      {
         return uint(headerBits >> 10 & 3);
      }
      
      private function getPaddingBit(headerBits:uint) : uint
      {
         return uint(headerBits >> 9 & 1);
      }
      
      private function getModeIndex(headerBits:uint) : uint
      {
         return uint(headerBits >> 6 & 3);
      }
      
      private function getEmphasisIndex(headerBits:uint) : uint
      {
         return uint(headerBits & 3);
      }
   }
}
