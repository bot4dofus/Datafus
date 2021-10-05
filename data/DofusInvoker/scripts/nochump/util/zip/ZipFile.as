package nochump.util.zip
{
   import com.ankamagames.jerakine.benchmark.FileLoggerEnum;
   import com.ankamagames.jerakine.benchmark.LogInFile;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.ProgressEvent;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import flash.utils.Endian;
   import flash.utils.IDataInput;
   
   public class ZipFile extends EventDispatcher
   {
       
      
      private var buf:ByteArray;
      
      private var entryList:Array;
      
      private var entryTable:Dictionary;
      
      private var locOffsetTable:Dictionary;
      
      public function ZipFile(data:IDataInput)
      {
         super();
         this.buf = new ByteArray();
         this.buf.endian = Endian.LITTLE_ENDIAN;
         data.readBytes(this.buf);
         this.readEntries();
      }
      
      public function get entries() : Array
      {
         return this.entryList;
      }
      
      public function get size() : uint
      {
         return this.entryList.length;
      }
      
      public function getEntry(name:String) : ZipEntry
      {
         return this.entryTable[name];
      }
      
      public function getInput(entry:ZipEntry, asynCallback:Function = null) : ByteArray
      {
         var b2:ByteArray = null;
         var inflater:Inflater = null;
         this.buf.position = this.locOffsetTable[entry.name] + ZipConstants.LOCHDR - 2;
         var len:uint = this.buf.readShort();
         this.buf.position += entry.name.length + len;
         var b1:ByteArray = new ByteArray();
         if(entry.compressedSize > 0)
         {
            this.buf.readBytes(b1,0,entry.compressedSize);
         }
         switch(entry.method)
         {
            case ZipConstants.STORED:
               return b1;
            case ZipConstants.DEFLATED:
               b2 = new ByteArray();
               inflater = new Inflater();
               LogInFile.getInstance().logLine("GameGuide inflater.addEventListener onProgress",FileLoggerEnum.EVENTLISTENERS);
               inflater.addEventListener(ProgressEvent.PROGRESS,this.onProgress,false,0,true);
               inflater.setInput(b1);
               inflater.inflate(b2,asynCallback);
               if(asynCallback != null)
               {
                  return null;
               }
               return b2;
               break;
            default:
               throw new ZipError("invalid compression method");
         }
      }
      
      private function onProgress(e:Event) : void
      {
         LogInFile.getInstance().logLine("GameGuide onProgress",FileLoggerEnum.EVENTLISTENERS);
         dispatchEvent(e);
      }
      
      private function readEntries() : void
      {
         var tmpbuf:ByteArray = null;
         var len:uint = 0;
         var e:ZipEntry = null;
         this.readEND();
         this.entryTable = new Dictionary();
         this.locOffsetTable = new Dictionary();
         for(var i:uint = 0; i < this.entryList.length; i++)
         {
            tmpbuf = new ByteArray();
            tmpbuf.endian = Endian.LITTLE_ENDIAN;
            this.buf.readBytes(tmpbuf,0,ZipConstants.CENHDR);
            if(tmpbuf.readUnsignedInt() != ZipConstants.CENSIG)
            {
               throw new ZipError("invalid CEN header (bad signature)");
            }
            tmpbuf.position = ZipConstants.CENNAM;
            len = tmpbuf.readUnsignedShort();
            if(len == 0)
            {
               throw new ZipError("missing entry name");
            }
            e = new ZipEntry(this.buf.readUTFBytes(len));
            len = tmpbuf.readUnsignedShort();
            e.extra = new ByteArray();
            if(len > 0)
            {
               this.buf.readBytes(e.extra,0,len);
            }
            this.buf.position += tmpbuf.readUnsignedShort();
            tmpbuf.position = ZipConstants.CENVER;
            e.version = tmpbuf.readUnsignedShort();
            e.flag = tmpbuf.readUnsignedShort();
            if((e.flag & 1) == 1)
            {
               throw new ZipError("encrypted ZIP entry not supported");
            }
            e.method = tmpbuf.readUnsignedShort();
            e.dostime = tmpbuf.readUnsignedInt();
            e.crc = tmpbuf.readUnsignedInt();
            e.compressedSize = tmpbuf.readUnsignedInt();
            e.size = tmpbuf.readUnsignedInt();
            this.entryList[i] = e;
            this.entryTable[e.name] = e;
            tmpbuf.position = ZipConstants.CENOFF;
            this.locOffsetTable[e.name] = tmpbuf.readUnsignedInt();
         }
      }
      
      private function readEND() : void
      {
         var b:ByteArray = new ByteArray();
         b.endian = Endian.LITTLE_ENDIAN;
         this.buf.position = this.findEND();
         this.buf.readBytes(b,0,ZipConstants.ENDHDR);
         b.position = ZipConstants.ENDTOT;
         this.entryList = new Array(b.readUnsignedShort());
         b.position = ZipConstants.ENDOFF;
         this.buf.position = b.readUnsignedInt();
      }
      
      private function findEND() : uint
      {
         var i:uint = this.buf.length - ZipConstants.ENDHDR;
         for(var n:uint = Math.max(0,i - 65535); i >= n; )
         {
            if(this.buf[i] == 80)
            {
               this.buf.position = i;
               if(this.buf.readUnsignedInt() == ZipConstants.ENDSIG)
               {
                  return i;
               }
            }
            i--;
         }
         throw new ZipError("invalid zip");
      }
   }
}
