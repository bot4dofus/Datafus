package _PNGEncoder2
{
   import avm2.intrinsics.memory.li16;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   import flash.Lib;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.display.Stage;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import flash.events.ProgressEvent;
   import flash.geom.Rectangle;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   import flash.utils.getTimer;
   
   public class PNGEncoder2Impl
   {
      
      public static var CRC_TABLE_END:int = 1024;
      
      public static var DEFLATE_SCRATCH:int = 1024;
      
      public static var CHUNK_START:int = 6600;
      
      public static var FRAME_AVG_SMOOTH_COUNT:int = 4;
      
      public static var FIRST_UPDATE_PIXELS:int = 20480;
      
      public static var MIN_PIXELS_PER_UPDATE:int = 20480;
      
      public static var data:ByteArray;
      
      public static var sprite:Sprite;
      
      public static var encoding:Boolean = false;
      
      public static var region:Rectangle;
      
      public static var pendingAsyncEncodings:Vector.<PNGEncoder2Impl> = new Vector.<PNGEncoder2Impl>();
      
      public static var level:CompressionLevel;
      
      public static var crcComputed:Boolean = false;
       
      
      public var updatesPerFrameIndex:int;
      
      public var updatesPerFrame:Vector.<int>;
      
      public var updates:int;
      
      public var targetFPS:int;
      
      public var step:int;
      
      public var png#3:ByteArray;
      
      public var msPerLineIndex:int;
      
      public var msPerLine:Vector.<Number>;
      
      public var msPerFrameIndex:int;
      
      public var msPerFrame:Vector.<int>;
      
      public var metadata;
      
      public var lastFrameStart:int;
      
      public var img:BitmapData;
      
      public var frameCount:int;
      
      public var done:Boolean;
      
      public var dispatcher:IEventDispatcher;
      
      public var deflateStream:DeflateStream;
      
      public var currentY:int;
      
      public function PNGEncoder2Impl(param1:BitmapData, param2:IEventDispatcher, param3:*)
      {
         targetFPS = 20;
         _new(param1,param2,param3);
      }
      
      public static function encode(param1:BitmapData, param2:*) : ByteArray
      {
         var _loc5_:Number = NaN;
         var _loc6_:uint = 0;
         var _loc7_:int = 0;
         var _loc8_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc3_:ByteArray = ApplicationDomain.currentDomain.domainMemory;
         if(PNGEncoder2Impl.encoding)
         {
            throw new Error("Only one PNG can be encoded at once (are you encoding asynchronously while attempting to encode another PNG synchronously?)");
         }
         PNGEncoder2Impl.encoding = true;
         if(PNGEncoder2Impl.level == null)
         {
            PNGEncoder2Impl.level = CompressionLevel.FAST;
         }
         if(!PNGEncoder2Impl.crcComputed)
         {
            PNGEncoder2Impl.region = new Rectangle(0,0,1,1);
            PNGEncoder2Impl.sprite = new Sprite();
            PNGEncoder2Impl.data = new ByteArray();
            _loc5_ = Number(Math.max(6600,ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH));
            PNGEncoder2Impl.data.length = int(_loc5_);
         }
         ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
         if(!PNGEncoder2Impl.crcComputed)
         {
            _loc7_ = 0;
            while(_loc7_ < 256)
            {
               _loc8_ = int(_loc7_++);
               _loc6_ = _loc8_;
               if((_loc6_ & 1) == 1)
               {
                  _loc6_ = -306674912 ^ _loc6_ >>> 1;
               }
               else
               {
                  _loc6_ >>>= 1;
               }
               if((_loc6_ & 1) == 1)
               {
                  _loc6_ = -306674912 ^ _loc6_ >>> 1;
               }
               else
               {
                  _loc6_ >>>= 1;
               }
               if((_loc6_ & 1) == 1)
               {
                  _loc6_ = -306674912 ^ _loc6_ >>> 1;
               }
               else
               {
                  _loc6_ >>>= 1;
               }
               if((_loc6_ & 1) == 1)
               {
                  _loc6_ = -306674912 ^ _loc6_ >>> 1;
               }
               else
               {
                  _loc6_ >>>= 1;
               }
               if((_loc6_ & 1) == 1)
               {
                  _loc6_ = -306674912 ^ _loc6_ >>> 1;
               }
               else
               {
                  _loc6_ >>>= 1;
               }
               if((_loc6_ & 1) == 1)
               {
                  _loc6_ = -306674912 ^ _loc6_ >>> 1;
               }
               else
               {
                  _loc6_ >>>= 1;
               }
               if((_loc6_ & 1) == 1)
               {
                  _loc6_ = -306674912 ^ _loc6_ >>> 1;
               }
               else
               {
                  _loc6_ >>>= 1;
               }
               if((_loc6_ & 1) == 1)
               {
                  _loc6_ = -306674912 ^ _loc6_ >>> 1;
               }
               else
               {
                  _loc6_ >>>= 1;
               }
               si32(_loc6_,_loc8_ << 2);
            }
            PNGEncoder2Impl.crcComputed = true;
         }
         var _loc9_:ByteArray = new ByteArray();
         _loc9_.writeUnsignedInt(-1991225785);
         _loc9_.writeUnsignedInt(218765834);
         _loc7_ = 13;
         _loc5_ = Number(Math.max(6600 + _loc7_,ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH));
         PNGEncoder2Impl.data.length = int(_loc5_);
         ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
         _loc6_ = param1.width;
         si8(_loc6_ >>> 24,6600);
         si8(_loc6_ >>> 16,6601);
         si8(_loc6_ >>> 8,6602);
         si8(_loc6_,6603);
         _loc6_ = param1.height;
         si8(_loc6_ >>> 24,6604);
         si8(_loc6_ >>> 16,6605);
         si8(_loc6_ >>> 8,6606);
         si8(_loc6_,6607);
         si8(8,6608);
         if(param1.transparent)
         {
            si8(6,6609);
         }
         else
         {
            si8(2,6609);
         }
         si8(0,6610);
         si8(0,6611);
         si8(0,6612);
         _loc8_ = int(_loc7_);
         _loc9_.writeUnsignedInt(_loc8_);
         _loc9_.writeUnsignedInt(1229472850);
         if(_loc8_ != 0)
         {
            PNGEncoder2Impl.data.position = 6600;
            PNGEncoder2Impl.data.readBytes(_loc9_,_loc9_.position,_loc7_);
            _loc9_.position += _loc8_;
         }
         _loc10_ = -1;
         _loc10_ = li32(((_loc10_ ^ 73) & 255) << 2) ^ _loc10_ >>> 8;
         _loc10_ = li32(((_loc10_ ^ 72) & 255) << 2) ^ _loc10_ >>> 8;
         _loc10_ = li32(((_loc10_ ^ 68) & 255) << 2) ^ _loc10_ >>> 8;
         _loc10_ = li32(((_loc10_ ^ 82) & 255) << 2) ^ _loc10_ >>> 8;
         if(_loc8_ != 0)
         {
            _loc11_ = 6600;
            _loc12_ = 6600 + _loc8_;
            _loc13_ = 6600 + (_loc8_ & -16);
            while(_loc11_ < _loc13_)
            {
               _loc14_ = _loc10_ ^ li8(_loc11_);
               _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
               _loc14_ = _loc10_ ^ li8(_loc11_ + 1);
               _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
               _loc14_ = _loc10_ ^ li8(_loc11_ + 2);
               _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
               _loc14_ = _loc10_ ^ li8(_loc11_ + 3);
               _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
               _loc14_ = _loc10_ ^ li8(_loc11_ + 4);
               _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
               _loc14_ = _loc10_ ^ li8(_loc11_ + 5);
               _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
               _loc14_ = _loc10_ ^ li8(_loc11_ + 6);
               _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
               _loc14_ = _loc10_ ^ li8(_loc11_ + 7);
               _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
               _loc14_ = _loc10_ ^ li8(_loc11_ + 8);
               _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
               _loc14_ = _loc10_ ^ li8(_loc11_ + 9);
               _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
               _loc14_ = _loc10_ ^ li8(_loc11_ + 10);
               _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
               _loc14_ = _loc10_ ^ li8(_loc11_ + 11);
               _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
               _loc14_ = _loc10_ ^ li8(_loc11_ + 12);
               _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
               _loc14_ = _loc10_ ^ li8(_loc11_ + 13);
               _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
               _loc14_ = _loc10_ ^ li8(_loc11_ + 14);
               _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
               _loc14_ = _loc10_ ^ li8(_loc11_ + 15);
               _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
               _loc11_ += 16;
            }
            while(_loc11_ < _loc12_)
            {
               _loc14_ = _loc10_ ^ li8(_loc11_);
               _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
               _loc11_++;
            }
         }
         _loc10_ ^= -1;
         _loc9_.writeUnsignedInt(_loc10_);
         PNGEncoder2Impl.writeMetadataChunks(param2,_loc9_);
         var _loc4_:ByteArray = _loc9_;
         var _loc15_:DeflateStream = DeflateStream.createEx(PNGEncoder2Impl.level,1024,6600,true);
         PNGEncoder2Impl.writeIDATChunk(param1,0,param1.height,_loc15_,_loc4_);
         _loc7_ = 0;
         _loc4_.writeUnsignedInt(_loc7_);
         _loc4_.writeUnsignedInt(1229278788);
         if(_loc7_ != 0)
         {
            PNGEncoder2Impl.data.position = 6600;
            PNGEncoder2Impl.data.readBytes(_loc4_,_loc4_.position,0);
            _loc4_.position += _loc7_;
         }
         _loc8_ = -1;
         _loc8_ = li32(((_loc8_ ^ 73) & 255) << 2) ^ _loc8_ >>> 8;
         _loc8_ = li32(((_loc8_ ^ 69) & 255) << 2) ^ _loc8_ >>> 8;
         _loc8_ = li32(((_loc8_ ^ 78) & 255) << 2) ^ _loc8_ >>> 8;
         _loc8_ = li32(((_loc8_ ^ 68) & 255) << 2) ^ _loc8_ >>> 8;
         if(_loc7_ != 0)
         {
            _loc10_ = 6600;
            _loc11_ = 6600 + _loc7_;
            _loc12_ = 6600 + (_loc7_ & -16);
            while(_loc10_ < _loc12_)
            {
               _loc13_ = _loc8_ ^ li8(_loc10_);
               _loc8_ = li32((_loc13_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc13_ = _loc8_ ^ li8(_loc10_ + 1);
               _loc8_ = li32((_loc13_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc13_ = _loc8_ ^ li8(_loc10_ + 2);
               _loc8_ = li32((_loc13_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc13_ = _loc8_ ^ li8(_loc10_ + 3);
               _loc8_ = li32((_loc13_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc13_ = _loc8_ ^ li8(_loc10_ + 4);
               _loc8_ = li32((_loc13_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc13_ = _loc8_ ^ li8(_loc10_ + 5);
               _loc8_ = li32((_loc13_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc13_ = _loc8_ ^ li8(_loc10_ + 6);
               _loc8_ = li32((_loc13_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc13_ = _loc8_ ^ li8(_loc10_ + 7);
               _loc8_ = li32((_loc13_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc13_ = _loc8_ ^ li8(_loc10_ + 8);
               _loc8_ = li32((_loc13_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc13_ = _loc8_ ^ li8(_loc10_ + 9);
               _loc8_ = li32((_loc13_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc13_ = _loc8_ ^ li8(_loc10_ + 10);
               _loc8_ = li32((_loc13_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc13_ = _loc8_ ^ li8(_loc10_ + 11);
               _loc8_ = li32((_loc13_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc13_ = _loc8_ ^ li8(_loc10_ + 12);
               _loc8_ = li32((_loc13_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc13_ = _loc8_ ^ li8(_loc10_ + 13);
               _loc8_ = li32((_loc13_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc13_ = _loc8_ ^ li8(_loc10_ + 14);
               _loc8_ = li32((_loc13_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc13_ = _loc8_ ^ li8(_loc10_ + 15);
               _loc8_ = li32((_loc13_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc10_ += 16;
            }
            while(_loc10_ < _loc11_)
            {
               _loc13_ = _loc8_ ^ li8(_loc10_);
               _loc8_ = li32((_loc13_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc10_++;
            }
         }
         _loc8_ ^= -1;
         _loc4_.writeUnsignedInt(_loc8_);
         PNGEncoder2Impl.encoding = false;
         _loc4_.position = 0;
         _loc15_ = null;
         ApplicationDomain.currentDomain.domainMemory = _loc3_;
         return _loc4_;
      }
      
      public static function decode(param1:ByteArray) : BitmapData
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:* = false;
         var _loc7_:* = null as ByteArray;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:* = null as ByteArray;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc15_:* = 0;
         var _loc16_:* = 0;
         var _loc17_:uint = 0;
         var _loc18_:int = 0;
         var _loc19_:uint = 0;
         var _loc20_:* = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         var _loc24_:* = 0;
         var _loc25_:* = 0;
         var _loc26_:* = 0;
         var _loc27_:* = 0;
         var _loc28_:* = 0;
         var _loc29_:* = 0;
         var _loc30_:* = 0;
         var _loc31_:uint = 0;
         var _loc2_:Boolean = false;
         if(param1.length < 16)
         {
            _loc2_ = true;
         }
         if(!_loc2_ && (int(param1.readInt()) != -1991225785 || int(param1.readInt()) != 218765834))
         {
            _loc2_ = true;
         }
         var _loc3_:BitmapData = null;
         if(!_loc2_)
         {
            _loc4_ = -1;
            _loc5_ = -1;
            _loc6_ = false;
            _loc7_ = new ByteArray();
            _loc8_ = uint(param1.readUnsignedInt());
            _loc9_ = uint(param1.readUnsignedInt());
            if(_loc9_ != 1229472850)
            {
               _loc2_ = true;
            }
            while(_loc9_ != 1229278788)
            {
               if(_loc9_ == 1229472850)
               {
                  if(_loc8_ != 13)
                  {
                     _loc2_ = true;
                  }
                  _loc4_ = param1.readInt();
                  _loc5_ = param1.readInt();
                  param1.position = param1.position + 1;
                  _loc6_ = uint(param1.readUnsignedByte()) == 6;
                  param1.position += 3;
                  if(_loc6_)
                  {
                     _loc7_.length = _loc5_ * _loc4_ * 4 + _loc5_;
                  }
                  else
                  {
                     _loc7_.length = _loc5_ * _loc4_ * 3 + _loc5_;
                  }
               }
               else if(_loc9_ == 1229209940)
               {
                  param1.readBytes(_loc7_,_loc7_.position,_loc8_);
                  _loc7_.position += _loc8_;
               }
               else
               {
                  param1.position += _loc8_;
               }
               param1.position += 4;
               _loc8_ = uint(param1.readUnsignedInt());
               _loc9_ = uint(param1.readUnsignedInt());
            }
            if(_loc4_ == 0 || _loc5_ == 0)
            {
               _loc3_ = new BitmapData(_loc4_,_loc5_,_loc6_,16777215);
            }
            else if(!_loc2_)
            {
               _loc7_.uncompress();
               _loc10_ = ApplicationDomain.currentDomain.domainMemory;
               _loc11_ = 0;
               if(_loc6_)
               {
                  _loc12_ = 0;
                  ApplicationDomain.currentDomain.domainMemory = _loc7_;
                  _loc11_++;
                  _loc14_ = int(li32(_loc11_));
                  _loc13_ = _loc14_ << 8 | _loc14_ >>> 24;
                  si32(_loc13_,_loc12_);
                  _loc13_ = _loc4_ * 4;
                  _loc14_ = _loc12_ + _loc13_;
                  _loc11_ += 4;
                  _loc12_ += 4;
                  _loc15_ = _loc12_ + (_loc13_ - 1 & -64);
                  while(_loc12_ != _loc15_)
                  {
                     _loc18_ = li32(_loc11_);
                     _loc17_ = _loc18_ << 8 | _loc18_ >>> 24;
                     _loc19_ = li32(_loc12_ - 4);
                     _loc16_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_);
                     _loc18_ = li32(_loc11_ + 4);
                     _loc17_ = _loc18_ << 8 | _loc18_ >>> 24;
                     _loc19_ = li32(_loc12_);
                     _loc16_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 4);
                     _loc18_ = li32(_loc11_ + 8);
                     _loc17_ = _loc18_ << 8 | _loc18_ >>> 24;
                     _loc19_ = li32(_loc12_ + 4);
                     _loc16_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 8);
                     _loc18_ = li32(_loc11_ + 12);
                     _loc17_ = _loc18_ << 8 | _loc18_ >>> 24;
                     _loc19_ = li32(_loc12_ + 8);
                     _loc16_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 12);
                     _loc18_ = li32(_loc11_ + 16);
                     _loc17_ = _loc18_ << 8 | _loc18_ >>> 24;
                     _loc19_ = li32(_loc12_ + 12);
                     _loc16_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 16);
                     _loc18_ = li32(_loc11_ + 20);
                     _loc17_ = _loc18_ << 8 | _loc18_ >>> 24;
                     _loc19_ = li32(_loc12_ + 16);
                     _loc16_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 20);
                     _loc18_ = li32(_loc11_ + 24);
                     _loc17_ = _loc18_ << 8 | _loc18_ >>> 24;
                     _loc19_ = li32(_loc12_ + 20);
                     _loc16_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 24);
                     _loc18_ = li32(_loc11_ + 28);
                     _loc17_ = _loc18_ << 8 | _loc18_ >>> 24;
                     _loc19_ = li32(_loc12_ + 24);
                     _loc16_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 28);
                     _loc18_ = li32(_loc11_ + 32);
                     _loc17_ = _loc18_ << 8 | _loc18_ >>> 24;
                     _loc19_ = li32(_loc12_ + 28);
                     _loc16_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 32);
                     _loc18_ = li32(_loc11_ + 36);
                     _loc17_ = _loc18_ << 8 | _loc18_ >>> 24;
                     _loc19_ = li32(_loc12_ + 32);
                     _loc16_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 36);
                     _loc18_ = li32(_loc11_ + 40);
                     _loc17_ = _loc18_ << 8 | _loc18_ >>> 24;
                     _loc19_ = li32(_loc12_ + 36);
                     _loc16_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 40);
                     _loc18_ = li32(_loc11_ + 44);
                     _loc17_ = _loc18_ << 8 | _loc18_ >>> 24;
                     _loc19_ = li32(_loc12_ + 40);
                     _loc16_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 44);
                     _loc18_ = li32(_loc11_ + 48);
                     _loc17_ = _loc18_ << 8 | _loc18_ >>> 24;
                     _loc19_ = li32(_loc12_ + 44);
                     _loc16_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 48);
                     _loc18_ = li32(_loc11_ + 52);
                     _loc17_ = _loc18_ << 8 | _loc18_ >>> 24;
                     _loc19_ = li32(_loc12_ + 48);
                     _loc16_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 52);
                     _loc18_ = li32(_loc11_ + 56);
                     _loc17_ = _loc18_ << 8 | _loc18_ >>> 24;
                     _loc19_ = li32(_loc12_ + 52);
                     _loc16_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 56);
                     _loc18_ = li32(_loc11_ + 60);
                     _loc17_ = _loc18_ << 8 | _loc18_ >>> 24;
                     _loc19_ = li32(_loc12_ + 56);
                     _loc16_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 60);
                     _loc11_ += 64;
                     _loc12_ += 64;
                  }
                  while(_loc12_ != _loc14_)
                  {
                     _loc18_ = li32(_loc11_);
                     _loc17_ = _loc18_ << 8 | _loc18_ >>> 24;
                     _loc19_ = li32(_loc12_ - 4);
                     _loc16_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_);
                     _loc11_ += 4;
                     _loc12_ += 4;
                  }
                  _loc16_ = 1;
                  while(_loc16_ < _loc5_)
                  {
                     _loc18_ = _loc16_++;
                     _loc11_++;
                     _loc21_ = li32(_loc11_);
                     _loc17_ = _loc21_ << 8 | _loc21_ >>> 24;
                     _loc19_ = li32(_loc12_ - _loc13_);
                     _loc20_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                     si32(_loc20_,_loc12_);
                     _loc14_ = _loc12_ + _loc13_;
                     _loc11_ += 4;
                     _loc12_ += 4;
                     _loc15_ = _loc12_ + (_loc13_ - 1 & -64);
                     while(_loc12_ != _loc15_)
                     {
                        _loc21_ = li32(_loc11_);
                        _loc17_ = _loc21_ << 8 | _loc21_ >>> 24;
                        _loc21_ = li32(_loc12_ - 4);
                        _loc22_ = li32(_loc12_ - _loc13_);
                        _loc23_ = li32(_loc12_ - 4 - _loc13_);
                        _loc25_ = (_loc22_ & 255) - (_loc23_ & 255);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 255) - (_loc23_ & 255);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 255) + (_loc22_ & 255) - (_loc23_ << 1 & 510);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 255;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 255;
                        _loc29_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc19_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_);
                        _loc21_ = li32(_loc11_ + 4);
                        _loc17_ = _loc21_ << 8 | _loc21_ >>> 24;
                        _loc21_ = li32(_loc12_);
                        _loc22_ = li32(_loc12_ + 4 - _loc13_);
                        _loc23_ = li32(_loc12_ - _loc13_);
                        _loc25_ = (_loc22_ & 255) - (_loc23_ & 255);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 255) - (_loc23_ & 255);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 255) + (_loc22_ & 255) - (_loc23_ << 1 & 510);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 255;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 255;
                        _loc29_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc19_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 4);
                        _loc21_ = li32(_loc11_ + 8);
                        _loc17_ = _loc21_ << 8 | _loc21_ >>> 24;
                        _loc21_ = li32(_loc12_ + 4);
                        _loc22_ = li32(_loc12_ + 8 - _loc13_);
                        _loc23_ = li32(_loc12_ + 4 - _loc13_);
                        _loc25_ = (_loc22_ & 255) - (_loc23_ & 255);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 255) - (_loc23_ & 255);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 255) + (_loc22_ & 255) - (_loc23_ << 1 & 510);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 255;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 255;
                        _loc29_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc19_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 8);
                        _loc21_ = li32(_loc11_ + 12);
                        _loc17_ = _loc21_ << 8 | _loc21_ >>> 24;
                        _loc21_ = li32(_loc12_ + 8);
                        _loc22_ = li32(_loc12_ + 12 - _loc13_);
                        _loc23_ = li32(_loc12_ + 8 - _loc13_);
                        _loc25_ = (_loc22_ & 255) - (_loc23_ & 255);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 255) - (_loc23_ & 255);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 255) + (_loc22_ & 255) - (_loc23_ << 1 & 510);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 255;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 255;
                        _loc29_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc19_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 12);
                        _loc21_ = li32(_loc11_ + 16);
                        _loc17_ = _loc21_ << 8 | _loc21_ >>> 24;
                        _loc21_ = li32(_loc12_ + 12);
                        _loc22_ = li32(_loc12_ + 16 - _loc13_);
                        _loc23_ = li32(_loc12_ + 12 - _loc13_);
                        _loc25_ = (_loc22_ & 255) - (_loc23_ & 255);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 255) - (_loc23_ & 255);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 255) + (_loc22_ & 255) - (_loc23_ << 1 & 510);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 255;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 255;
                        _loc29_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc19_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 16);
                        _loc21_ = li32(_loc11_ + 20);
                        _loc17_ = _loc21_ << 8 | _loc21_ >>> 24;
                        _loc21_ = li32(_loc12_ + 16);
                        _loc22_ = li32(_loc12_ + 20 - _loc13_);
                        _loc23_ = li32(_loc12_ + 16 - _loc13_);
                        _loc25_ = (_loc22_ & 255) - (_loc23_ & 255);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 255) - (_loc23_ & 255);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 255) + (_loc22_ & 255) - (_loc23_ << 1 & 510);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 255;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 255;
                        _loc29_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc19_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 20);
                        _loc21_ = li32(_loc11_ + 24);
                        _loc17_ = _loc21_ << 8 | _loc21_ >>> 24;
                        _loc21_ = li32(_loc12_ + 20);
                        _loc22_ = li32(_loc12_ + 24 - _loc13_);
                        _loc23_ = li32(_loc12_ + 20 - _loc13_);
                        _loc25_ = (_loc22_ & 255) - (_loc23_ & 255);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 255) - (_loc23_ & 255);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 255) + (_loc22_ & 255) - (_loc23_ << 1 & 510);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 255;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 255;
                        _loc29_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc19_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 24);
                        _loc21_ = li32(_loc11_ + 28);
                        _loc17_ = _loc21_ << 8 | _loc21_ >>> 24;
                        _loc21_ = li32(_loc12_ + 24);
                        _loc22_ = li32(_loc12_ + 28 - _loc13_);
                        _loc23_ = li32(_loc12_ + 24 - _loc13_);
                        _loc25_ = (_loc22_ & 255) - (_loc23_ & 255);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 255) - (_loc23_ & 255);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 255) + (_loc22_ & 255) - (_loc23_ << 1 & 510);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 255;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 255;
                        _loc29_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc19_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 28);
                        _loc21_ = li32(_loc11_ + 32);
                        _loc17_ = _loc21_ << 8 | _loc21_ >>> 24;
                        _loc21_ = li32(_loc12_ + 28);
                        _loc22_ = li32(_loc12_ + 32 - _loc13_);
                        _loc23_ = li32(_loc12_ + 28 - _loc13_);
                        _loc25_ = (_loc22_ & 255) - (_loc23_ & 255);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 255) - (_loc23_ & 255);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 255) + (_loc22_ & 255) - (_loc23_ << 1 & 510);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 255;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 255;
                        _loc29_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc19_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 32);
                        _loc21_ = li32(_loc11_ + 36);
                        _loc17_ = _loc21_ << 8 | _loc21_ >>> 24;
                        _loc21_ = li32(_loc12_ + 32);
                        _loc22_ = li32(_loc12_ + 36 - _loc13_);
                        _loc23_ = li32(_loc12_ + 32 - _loc13_);
                        _loc25_ = (_loc22_ & 255) - (_loc23_ & 255);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 255) - (_loc23_ & 255);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 255) + (_loc22_ & 255) - (_loc23_ << 1 & 510);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 255;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 255;
                        _loc29_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc19_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 36);
                        _loc21_ = li32(_loc11_ + 40);
                        _loc17_ = _loc21_ << 8 | _loc21_ >>> 24;
                        _loc21_ = li32(_loc12_ + 36);
                        _loc22_ = li32(_loc12_ + 40 - _loc13_);
                        _loc23_ = li32(_loc12_ + 36 - _loc13_);
                        _loc25_ = (_loc22_ & 255) - (_loc23_ & 255);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 255) - (_loc23_ & 255);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 255) + (_loc22_ & 255) - (_loc23_ << 1 & 510);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 255;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 255;
                        _loc29_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc19_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 40);
                        _loc21_ = li32(_loc11_ + 44);
                        _loc17_ = _loc21_ << 8 | _loc21_ >>> 24;
                        _loc21_ = li32(_loc12_ + 40);
                        _loc22_ = li32(_loc12_ + 44 - _loc13_);
                        _loc23_ = li32(_loc12_ + 40 - _loc13_);
                        _loc25_ = (_loc22_ & 255) - (_loc23_ & 255);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 255) - (_loc23_ & 255);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 255) + (_loc22_ & 255) - (_loc23_ << 1 & 510);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 255;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 255;
                        _loc29_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc19_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 44);
                        _loc21_ = li32(_loc11_ + 48);
                        _loc17_ = _loc21_ << 8 | _loc21_ >>> 24;
                        _loc21_ = li32(_loc12_ + 44);
                        _loc22_ = li32(_loc12_ + 48 - _loc13_);
                        _loc23_ = li32(_loc12_ + 44 - _loc13_);
                        _loc25_ = (_loc22_ & 255) - (_loc23_ & 255);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 255) - (_loc23_ & 255);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 255) + (_loc22_ & 255) - (_loc23_ << 1 & 510);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 255;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 255;
                        _loc29_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc19_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 48);
                        _loc21_ = li32(_loc11_ + 52);
                        _loc17_ = _loc21_ << 8 | _loc21_ >>> 24;
                        _loc21_ = li32(_loc12_ + 48);
                        _loc22_ = li32(_loc12_ + 52 - _loc13_);
                        _loc23_ = li32(_loc12_ + 48 - _loc13_);
                        _loc25_ = (_loc22_ & 255) - (_loc23_ & 255);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 255) - (_loc23_ & 255);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 255) + (_loc22_ & 255) - (_loc23_ << 1 & 510);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 255;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 255;
                        _loc29_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc19_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 52);
                        _loc21_ = li32(_loc11_ + 56);
                        _loc17_ = _loc21_ << 8 | _loc21_ >>> 24;
                        _loc21_ = li32(_loc12_ + 52);
                        _loc22_ = li32(_loc12_ + 56 - _loc13_);
                        _loc23_ = li32(_loc12_ + 52 - _loc13_);
                        _loc25_ = (_loc22_ & 255) - (_loc23_ & 255);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 255) - (_loc23_ & 255);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 255) + (_loc22_ & 255) - (_loc23_ << 1 & 510);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 255;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 255;
                        _loc29_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc19_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 56);
                        _loc21_ = li32(_loc11_ + 60);
                        _loc17_ = _loc21_ << 8 | _loc21_ >>> 24;
                        _loc21_ = li32(_loc12_ + 56);
                        _loc22_ = li32(_loc12_ + 60 - _loc13_);
                        _loc23_ = li32(_loc12_ + 56 - _loc13_);
                        _loc25_ = (_loc22_ & 255) - (_loc23_ & 255);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 255) - (_loc23_ & 255);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 255) + (_loc22_ & 255) - (_loc23_ << 1 & 510);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 255;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 255;
                        _loc29_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc19_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 60);
                        _loc11_ += 64;
                        _loc12_ += 64;
                     }
                     while(_loc12_ != _loc14_)
                     {
                        _loc21_ = li32(_loc11_);
                        _loc17_ = _loc21_ << 8 | _loc21_ >>> 24;
                        _loc21_ = li32(_loc12_ - 4);
                        _loc22_ = li32(_loc12_ - _loc13_);
                        _loc23_ = li32(_loc12_ - 4 - _loc13_);
                        _loc25_ = (_loc22_ & 255) - (_loc23_ & 255);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 255) - (_loc23_ & 255);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 255) + (_loc22_ & 255) - (_loc23_ << 1 & 510);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 255;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 255;
                        _loc29_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc19_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc17_ & -16711936) + (_loc19_ & -16711936) & -16711936 | (_loc17_ & 16711935) + (_loc19_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_);
                        _loc11_ += 4;
                        _loc12_ += 4;
                     }
                  }
                  ApplicationDomain.currentDomain.domainMemory = _loc10_;
                  _loc7_.position = 0;
                  _loc3_ = new BitmapData(_loc4_,_loc5_,_loc6_,16777215);
                  _loc3_.setPixels(new Rectangle(0,0,_loc4_,_loc5_),_loc7_);
               }
               else
               {
                  _loc17_ = _loc7_.length;
                  _loc12_ = int(_loc17_);
                  _loc7_.length += _loc4_ * _loc5_ * 4;
                  ApplicationDomain.currentDomain.domainMemory = _loc7_;
                  _loc11_++;
                  _loc13_ = li8(_loc11_) << 8;
                  si16(_loc13_,_loc12_);
                  _loc13_ = int(li8(_loc11_ + 1));
                  si8(_loc13_,_loc12_ + 2);
                  _loc13_ = int(li8(_loc11_ + 2));
                  si8(_loc13_,_loc12_ + 3);
                  _loc13_ = _loc4_ * 4;
                  _loc14_ = _loc12_ + _loc13_;
                  _loc11_ += 3;
                  _loc12_ += 4;
                  _loc15_ = _loc12_ + (_loc13_ - 1 & -64);
                  _loc11_--;
                  while(_loc12_ != _loc15_)
                  {
                     _loc19_ = li32(_loc11_);
                     _loc31_ = li32(_loc12_ - 4);
                     _loc16_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_);
                     _loc19_ = li32(_loc11_ + 3);
                     _loc31_ = li32(_loc12_);
                     _loc16_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 4);
                     _loc19_ = li32(_loc11_ + 6);
                     _loc31_ = li32(_loc12_ + 4);
                     _loc16_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 8);
                     _loc19_ = li32(_loc11_ + 9);
                     _loc31_ = li32(_loc12_ + 8);
                     _loc16_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 12);
                     _loc19_ = li32(_loc11_ + 12);
                     _loc31_ = li32(_loc12_ + 12);
                     _loc16_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 16);
                     _loc19_ = li32(_loc11_ + 15);
                     _loc31_ = li32(_loc12_ + 16);
                     _loc16_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 20);
                     _loc19_ = li32(_loc11_ + 18);
                     _loc31_ = li32(_loc12_ + 20);
                     _loc16_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 24);
                     _loc19_ = li32(_loc11_ + 21);
                     _loc31_ = li32(_loc12_ + 24);
                     _loc16_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 28);
                     _loc19_ = li32(_loc11_ + 24);
                     _loc31_ = li32(_loc12_ + 28);
                     _loc16_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 32);
                     _loc19_ = li32(_loc11_ + 27);
                     _loc31_ = li32(_loc12_ + 32);
                     _loc16_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 36);
                     _loc19_ = li32(_loc11_ + 30);
                     _loc31_ = li32(_loc12_ + 36);
                     _loc16_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 40);
                     _loc19_ = li32(_loc11_ + 33);
                     _loc31_ = li32(_loc12_ + 40);
                     _loc16_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 44);
                     _loc19_ = li32(_loc11_ + 36);
                     _loc31_ = li32(_loc12_ + 44);
                     _loc16_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 48);
                     _loc19_ = li32(_loc11_ + 39);
                     _loc31_ = li32(_loc12_ + 48);
                     _loc16_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 52);
                     _loc19_ = li32(_loc11_ + 42);
                     _loc31_ = li32(_loc12_ + 52);
                     _loc16_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 56);
                     _loc19_ = li32(_loc11_ + 45);
                     _loc31_ = li32(_loc12_ + 56);
                     _loc16_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_ + 60);
                     _loc11_ += 48;
                     _loc12_ += 64;
                  }
                  while(_loc12_ != _loc14_)
                  {
                     _loc19_ = li32(_loc11_);
                     _loc31_ = li32(_loc12_ - 4);
                     _loc16_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                     si32(_loc16_,_loc12_);
                     _loc11_ += 3;
                     _loc12_ += 4;
                  }
                  _loc11_++;
                  _loc16_ = 1;
                  while(_loc16_ < _loc5_)
                  {
                     _loc18_ = _loc16_++;
                     _loc11_++;
                     _loc20_ = li8(_loc11_) + li8(_loc12_ + 1 - _loc13_) << 8;
                     si16(_loc20_,_loc12_);
                     _loc20_ = li8(_loc11_ + 1) + li8(_loc12_ + 2 - _loc13_);
                     si8(_loc20_,_loc12_ + 2);
                     _loc20_ = li8(_loc11_ + 2) + li8(_loc12_ + 3 - _loc13_);
                     si8(_loc20_,_loc12_ + 3);
                     _loc14_ = _loc12_ + _loc13_;
                     _loc11_ += 3;
                     _loc12_ += 4;
                     _loc15_ = _loc12_ + (_loc13_ - 1 & -64);
                     _loc11_--;
                     while(_loc12_ != _loc15_)
                     {
                        _loc19_ = li32(_loc11_);
                        _loc21_ = li32(_loc12_ - 4);
                        _loc22_ = li32(_loc12_ - _loc13_);
                        _loc23_ = li32(_loc12_ - 4 - _loc13_);
                        _loc25_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc31_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_);
                        _loc19_ = li32(_loc11_ + 3);
                        _loc21_ = li32(_loc12_);
                        _loc22_ = li32(_loc12_ + 4 - _loc13_);
                        _loc23_ = li32(_loc12_ - _loc13_);
                        _loc25_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc31_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 4);
                        _loc19_ = li32(_loc11_ + 6);
                        _loc21_ = li32(_loc12_ + 4);
                        _loc22_ = li32(_loc12_ + 8 - _loc13_);
                        _loc23_ = li32(_loc12_ + 4 - _loc13_);
                        _loc25_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc31_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 8);
                        _loc19_ = li32(_loc11_ + 9);
                        _loc21_ = li32(_loc12_ + 8);
                        _loc22_ = li32(_loc12_ + 12 - _loc13_);
                        _loc23_ = li32(_loc12_ + 8 - _loc13_);
                        _loc25_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc31_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 12);
                        _loc19_ = li32(_loc11_ + 12);
                        _loc21_ = li32(_loc12_ + 12);
                        _loc22_ = li32(_loc12_ + 16 - _loc13_);
                        _loc23_ = li32(_loc12_ + 12 - _loc13_);
                        _loc25_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc31_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 16);
                        _loc19_ = li32(_loc11_ + 15);
                        _loc21_ = li32(_loc12_ + 16);
                        _loc22_ = li32(_loc12_ + 20 - _loc13_);
                        _loc23_ = li32(_loc12_ + 16 - _loc13_);
                        _loc25_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc31_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 20);
                        _loc19_ = li32(_loc11_ + 18);
                        _loc21_ = li32(_loc12_ + 20);
                        _loc22_ = li32(_loc12_ + 24 - _loc13_);
                        _loc23_ = li32(_loc12_ + 20 - _loc13_);
                        _loc25_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc31_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 24);
                        _loc19_ = li32(_loc11_ + 21);
                        _loc21_ = li32(_loc12_ + 24);
                        _loc22_ = li32(_loc12_ + 28 - _loc13_);
                        _loc23_ = li32(_loc12_ + 24 - _loc13_);
                        _loc25_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc31_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 28);
                        _loc19_ = li32(_loc11_ + 24);
                        _loc21_ = li32(_loc12_ + 28);
                        _loc22_ = li32(_loc12_ + 32 - _loc13_);
                        _loc23_ = li32(_loc12_ + 28 - _loc13_);
                        _loc25_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc31_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 32);
                        _loc19_ = li32(_loc11_ + 27);
                        _loc21_ = li32(_loc12_ + 32);
                        _loc22_ = li32(_loc12_ + 36 - _loc13_);
                        _loc23_ = li32(_loc12_ + 32 - _loc13_);
                        _loc25_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc31_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 36);
                        _loc19_ = li32(_loc11_ + 30);
                        _loc21_ = li32(_loc12_ + 36);
                        _loc22_ = li32(_loc12_ + 40 - _loc13_);
                        _loc23_ = li32(_loc12_ + 36 - _loc13_);
                        _loc25_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc31_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 40);
                        _loc19_ = li32(_loc11_ + 33);
                        _loc21_ = li32(_loc12_ + 40);
                        _loc22_ = li32(_loc12_ + 44 - _loc13_);
                        _loc23_ = li32(_loc12_ + 40 - _loc13_);
                        _loc25_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc31_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 44);
                        _loc19_ = li32(_loc11_ + 36);
                        _loc21_ = li32(_loc12_ + 44);
                        _loc22_ = li32(_loc12_ + 48 - _loc13_);
                        _loc23_ = li32(_loc12_ + 44 - _loc13_);
                        _loc25_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc31_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 48);
                        _loc19_ = li32(_loc11_ + 39);
                        _loc21_ = li32(_loc12_ + 48);
                        _loc22_ = li32(_loc12_ + 52 - _loc13_);
                        _loc23_ = li32(_loc12_ + 48 - _loc13_);
                        _loc25_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc31_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 52);
                        _loc19_ = li32(_loc11_ + 42);
                        _loc21_ = li32(_loc12_ + 52);
                        _loc22_ = li32(_loc12_ + 56 - _loc13_);
                        _loc23_ = li32(_loc12_ + 52 - _loc13_);
                        _loc25_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc31_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 56);
                        _loc19_ = li32(_loc11_ + 45);
                        _loc21_ = li32(_loc12_ + 56);
                        _loc22_ = li32(_loc12_ + 60 - _loc13_);
                        _loc23_ = li32(_loc12_ + 56 - _loc13_);
                        _loc25_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc31_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_ + 60);
                        _loc11_ += 48;
                        _loc12_ += 64;
                     }
                     while(_loc12_ != _loc14_)
                     {
                        _loc19_ = li32(_loc11_);
                        _loc21_ = li32(_loc12_ - 4);
                        _loc22_ = li32(_loc12_ - _loc13_);
                        _loc23_ = li32(_loc12_ - 4 - _loc13_);
                        _loc25_ = (_loc22_ & 65280) - (_loc23_ & 65280);
                        _loc26_ = _loc25_ >> 31;
                        _loc24_ = _loc25_ + _loc26_ ^ _loc26_;
                        _loc26_ = (_loc21_ & 65280) - (_loc23_ & 65280);
                        _loc27_ = _loc26_ >> 31;
                        _loc25_ = _loc26_ + _loc27_ ^ _loc27_;
                        _loc27_ = (_loc21_ & 65280) + (_loc22_ & 65280) - (_loc23_ << 1 & 130560);
                        _loc28_ = _loc27_ >> 31;
                        _loc26_ = _loc27_ + _loc28_ ^ _loc28_;
                        _loc27_ = (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 65280;
                        _loc28_ = _loc26_ - _loc25_ >> 31 & 65280;
                        _loc29_ = (_loc22_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) - (_loc23_ & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ & 16711680) + (_loc22_ & 16711680) - (_loc23_ << 1 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & 16711680;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & 16711680;
                        _loc29_ = (_loc22_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc24_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) - (_loc23_ >> 8 & 16711680);
                        _loc30_ = _loc29_ >> 31;
                        _loc25_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc29_ = (_loc21_ >> 8 & 16711680) + (_loc22_ >> 8 & 16711680) - (_loc23_ >> 7 & 33423360);
                        _loc30_ = _loc29_ >> 31;
                        _loc26_ = _loc29_ + _loc30_ ^ _loc30_;
                        _loc27_ |= (_loc25_ - _loc24_ | _loc26_ - _loc24_) >> 31 & -16777216;
                        _loc28_ |= _loc26_ - _loc25_ >> 31 & -16777216;
                        _loc31_ = _loc21_ & ~_loc27_ | _loc22_ & _loc27_ & ~_loc28_ | _loc23_ & _loc27_ & _loc28_;
                        _loc20_ = (_loc19_ & -16711936) + (_loc31_ & -16711936) & -16711936 | (_loc19_ & 16711935) + (_loc31_ & 16711935) & 16711935;
                        si32(_loc20_,_loc12_);
                        _loc11_ += 3;
                        _loc12_ += 4;
                     }
                     _loc11_++;
                  }
                  ApplicationDomain.currentDomain.domainMemory = _loc10_;
                  _loc7_.position = _loc17_;
                  _loc3_ = new BitmapData(_loc4_,_loc5_,_loc6_,16777215);
                  _loc3_.setPixels(new Rectangle(0,0,_loc4_,_loc5_),_loc7_);
               }
            }
         }
         return _loc3_;
      }
      
      public static function rotl8(param1:int) : int
      {
         return param1 << 8 | param1 >>> 24;
      }
      
      public static function byteAdd4(param1:uint, param2:uint) : int
      {
         return (param1 & -16711936) + (param2 & -16711936) & -16711936 | (param1 & 16711935) + (param2 & 16711935) & 16711935;
      }
      
      public static function paethPredictor3Hi(param1:int, param2:int, param3:int) : int
      {
         var _loc5_:* = (param2 & 65280) - (param3 & 65280);
         var _loc6_:* = _loc5_ >> 31;
         var _loc4_:* = _loc5_ + _loc6_ ^ _loc6_;
         _loc6_ = (param1 & 65280) - (param3 & 65280);
         var _loc7_:* = _loc6_ >> 31;
         _loc5_ = _loc6_ + _loc7_ ^ _loc7_;
         _loc7_ = (param1 & 65280) + (param2 & 65280) - (param3 << 1 & 130560);
         var _loc8_:* = _loc7_ >> 31;
         _loc6_ = _loc7_ + _loc8_ ^ _loc8_;
         _loc7_ = (_loc5_ - _loc4_ | _loc6_ - _loc4_) >> 31 & 65280;
         _loc8_ = _loc6_ - _loc5_ >> 31 & 65280;
         var _loc9_:* = (param2 & 16711680) - (param3 & 16711680);
         var _loc10_:* = _loc9_ >> 31;
         _loc4_ = _loc9_ + _loc10_ ^ _loc10_;
         _loc9_ = (param1 & 16711680) - (param3 & 16711680);
         _loc10_ = _loc9_ >> 31;
         _loc5_ = _loc9_ + _loc10_ ^ _loc10_;
         _loc9_ = (param1 & 16711680) + (param2 & 16711680) - (param3 << 1 & 33423360);
         _loc10_ = _loc9_ >> 31;
         _loc6_ = _loc9_ + _loc10_ ^ _loc10_;
         _loc7_ |= (_loc5_ - _loc4_ | _loc6_ - _loc4_) >> 31 & 16711680;
         _loc8_ |= _loc6_ - _loc5_ >> 31 & 16711680;
         _loc9_ = (param2 >> 8 & 16711680) - (param3 >> 8 & 16711680);
         _loc10_ = _loc9_ >> 31;
         _loc4_ = _loc9_ + _loc10_ ^ _loc10_;
         _loc9_ = (param1 >> 8 & 16711680) - (param3 >> 8 & 16711680);
         _loc10_ = _loc9_ >> 31;
         _loc5_ = _loc9_ + _loc10_ ^ _loc10_;
         _loc9_ = (param1 >> 8 & 16711680) + (param2 >> 8 & 16711680) - (param3 >> 7 & 33423360);
         _loc10_ = _loc9_ >> 31;
         _loc6_ = _loc9_ + _loc10_ ^ _loc10_;
         _loc7_ |= (_loc5_ - _loc4_ | _loc6_ - _loc4_) >> 31 & -16777216;
         _loc8_ |= _loc6_ - _loc5_ >> 31 & -16777216;
         return param1 & ~_loc7_ | param2 & _loc7_ & ~_loc8_ | param3 & _loc7_ & _loc8_;
      }
      
      public static function beginEncoding(param1:BitmapData, param2:*) : ByteArray
      {
         var _loc3_:Number = NaN;
         var _loc4_:uint = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         if(PNGEncoder2Impl.encoding)
         {
            throw new Error("Only one PNG can be encoded at once (are you encoding asynchronously while attempting to encode another PNG synchronously?)");
         }
         PNGEncoder2Impl.encoding = true;
         if(PNGEncoder2Impl.level == null)
         {
            PNGEncoder2Impl.level = CompressionLevel.FAST;
         }
         if(!PNGEncoder2Impl.crcComputed)
         {
            PNGEncoder2Impl.region = new Rectangle(0,0,1,1);
            PNGEncoder2Impl.sprite = new Sprite();
            PNGEncoder2Impl.data = new ByteArray();
            _loc3_ = Number(Math.max(6600,ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH));
            PNGEncoder2Impl.data.length = int(_loc3_);
         }
         ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
         if(!PNGEncoder2Impl.crcComputed)
         {
            _loc5_ = 0;
            while(_loc5_ < 256)
            {
               _loc6_ = _loc5_++;
               _loc4_ = _loc6_;
               if((_loc4_ & 1) == 1)
               {
                  _loc4_ = -306674912 ^ _loc4_ >>> 1;
               }
               else
               {
                  _loc4_ >>>= 1;
               }
               if((_loc4_ & 1) == 1)
               {
                  _loc4_ = -306674912 ^ _loc4_ >>> 1;
               }
               else
               {
                  _loc4_ >>>= 1;
               }
               if((_loc4_ & 1) == 1)
               {
                  _loc4_ = -306674912 ^ _loc4_ >>> 1;
               }
               else
               {
                  _loc4_ >>>= 1;
               }
               if((_loc4_ & 1) == 1)
               {
                  _loc4_ = -306674912 ^ _loc4_ >>> 1;
               }
               else
               {
                  _loc4_ >>>= 1;
               }
               if((_loc4_ & 1) == 1)
               {
                  _loc4_ = -306674912 ^ _loc4_ >>> 1;
               }
               else
               {
                  _loc4_ >>>= 1;
               }
               if((_loc4_ & 1) == 1)
               {
                  _loc4_ = -306674912 ^ _loc4_ >>> 1;
               }
               else
               {
                  _loc4_ >>>= 1;
               }
               if((_loc4_ & 1) == 1)
               {
                  _loc4_ = -306674912 ^ _loc4_ >>> 1;
               }
               else
               {
                  _loc4_ >>>= 1;
               }
               if((_loc4_ & 1) == 1)
               {
                  _loc4_ = -306674912 ^ _loc4_ >>> 1;
               }
               else
               {
                  _loc4_ >>>= 1;
               }
               si32(_loc4_,_loc6_ << 2);
            }
            PNGEncoder2Impl.crcComputed = true;
         }
         var _loc7_:ByteArray = new ByteArray();
         _loc7_.writeUnsignedInt(-1991225785);
         _loc7_.writeUnsignedInt(218765834);
         _loc5_ = 13;
         _loc3_ = Number(Math.max(6600 + _loc5_,ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH));
         PNGEncoder2Impl.data.length = int(_loc3_);
         ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
         _loc4_ = param1.width;
         si8(_loc4_ >>> 24,6600);
         si8(_loc4_ >>> 16,6601);
         si8(_loc4_ >>> 8,6602);
         si8(_loc4_,6603);
         _loc4_ = param1.height;
         si8(_loc4_ >>> 24,6604);
         si8(_loc4_ >>> 16,6605);
         si8(_loc4_ >>> 8,6606);
         si8(_loc4_,6607);
         si8(8,6608);
         if(param1.transparent)
         {
            si8(6,6609);
         }
         else
         {
            si8(2,6609);
         }
         si8(0,6610);
         si8(0,6611);
         si8(0,6612);
         _loc6_ = _loc5_;
         _loc7_.writeUnsignedInt(_loc6_);
         _loc7_.writeUnsignedInt(1229472850);
         if(_loc6_ != 0)
         {
            PNGEncoder2Impl.data.position = 6600;
            PNGEncoder2Impl.data.readBytes(_loc7_,_loc7_.position,_loc5_);
            _loc7_.position += _loc6_;
         }
         var _loc8_:* = -1;
         _loc8_ = li32(((_loc8_ ^ 73) & 255) << 2) ^ _loc8_ >>> 8;
         _loc8_ = li32(((_loc8_ ^ 72) & 255) << 2) ^ _loc8_ >>> 8;
         _loc8_ = li32(((_loc8_ ^ 68) & 255) << 2) ^ _loc8_ >>> 8;
         _loc8_ = li32(((_loc8_ ^ 82) & 255) << 2) ^ _loc8_ >>> 8;
         if(_loc6_ != 0)
         {
            _loc9_ = 6600;
            _loc10_ = 6600 + _loc6_;
            _loc11_ = 6600 + (_loc6_ & -16);
            while(_loc9_ < _loc11_)
            {
               _loc12_ = _loc8_ ^ li8(_loc9_);
               _loc8_ = li32((_loc12_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc12_ = _loc8_ ^ li8(_loc9_ + 1);
               _loc8_ = li32((_loc12_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc12_ = _loc8_ ^ li8(_loc9_ + 2);
               _loc8_ = li32((_loc12_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc12_ = _loc8_ ^ li8(_loc9_ + 3);
               _loc8_ = li32((_loc12_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc12_ = _loc8_ ^ li8(_loc9_ + 4);
               _loc8_ = li32((_loc12_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc12_ = _loc8_ ^ li8(_loc9_ + 5);
               _loc8_ = li32((_loc12_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc12_ = _loc8_ ^ li8(_loc9_ + 6);
               _loc8_ = li32((_loc12_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc12_ = _loc8_ ^ li8(_loc9_ + 7);
               _loc8_ = li32((_loc12_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc12_ = _loc8_ ^ li8(_loc9_ + 8);
               _loc8_ = li32((_loc12_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc12_ = _loc8_ ^ li8(_loc9_ + 9);
               _loc8_ = li32((_loc12_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc12_ = _loc8_ ^ li8(_loc9_ + 10);
               _loc8_ = li32((_loc12_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc12_ = _loc8_ ^ li8(_loc9_ + 11);
               _loc8_ = li32((_loc12_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc12_ = _loc8_ ^ li8(_loc9_ + 12);
               _loc8_ = li32((_loc12_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc12_ = _loc8_ ^ li8(_loc9_ + 13);
               _loc8_ = li32((_loc12_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc12_ = _loc8_ ^ li8(_loc9_ + 14);
               _loc8_ = li32((_loc12_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc12_ = _loc8_ ^ li8(_loc9_ + 15);
               _loc8_ = li32((_loc12_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc9_ += 16;
            }
            while(_loc9_ < _loc10_)
            {
               _loc12_ = _loc8_ ^ li8(_loc9_);
               _loc8_ = li32((_loc12_ & 255) << 2) ^ _loc8_ >>> 8;
               _loc9_++;
            }
         }
         _loc8_ ^= -1;
         _loc7_.writeUnsignedInt(_loc8_);
         PNGEncoder2Impl.writeMetadataChunks(param2,_loc7_);
         return _loc7_;
      }
      
      public static function endEncoding(param1:ByteArray) : void
      {
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc2_:int = 0;
         param1.writeUnsignedInt(_loc2_);
         param1.writeUnsignedInt(1229278788);
         if(_loc2_ != 0)
         {
            PNGEncoder2Impl.data.position = 6600;
            PNGEncoder2Impl.data.readBytes(param1,param1.position,0);
            param1.position += _loc2_;
         }
         var _loc3_:* = -1;
         _loc3_ = li32(((_loc3_ ^ 73) & 255) << 2) ^ _loc3_ >>> 8;
         _loc3_ = li32(((_loc3_ ^ 69) & 255) << 2) ^ _loc3_ >>> 8;
         _loc3_ = li32(((_loc3_ ^ 78) & 255) << 2) ^ _loc3_ >>> 8;
         _loc3_ = li32(((_loc3_ ^ 68) & 255) << 2) ^ _loc3_ >>> 8;
         if(_loc2_ != 0)
         {
            _loc4_ = 6600;
            _loc5_ = 6600 + _loc2_;
            _loc6_ = 6600 + (_loc2_ & -16);
            while(_loc4_ < _loc6_)
            {
               _loc7_ = _loc3_ ^ li8(_loc4_);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 1);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 2);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 3);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 4);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 5);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 6);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 7);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 8);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 9);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 10);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 11);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 12);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 13);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 14);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 15);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc4_ += 16;
            }
            while(_loc4_ < _loc5_)
            {
               _loc7_ = _loc3_ ^ li8(_loc4_);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc4_++;
            }
         }
         _loc3_ ^= -1;
         param1.writeUnsignedInt(_loc3_);
         PNGEncoder2Impl.encoding = false;
         param1.position = 0;
      }
      
      public static function writePNGSignature(param1:ByteArray) : void
      {
         param1.writeUnsignedInt(-1991225785);
         param1.writeUnsignedInt(218765834);
      }
      
      public static function writeIHDRChunk(param1:BitmapData, param2:ByteArray) : void
      {
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc3_:int = 13;
         var _loc4_:Number = Number(Math.max(6600 + _loc3_,ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH));
         PNGEncoder2Impl.data.length = int(_loc4_);
         ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
         var _loc5_:uint = param1.width;
         si8(_loc5_ >>> 24,6600);
         si8(_loc5_ >>> 16,6601);
         si8(_loc5_ >>> 8,6602);
         si8(_loc5_,6603);
         _loc5_ = param1.height;
         si8(_loc5_ >>> 24,6604);
         si8(_loc5_ >>> 16,6605);
         si8(_loc5_ >>> 8,6606);
         si8(_loc5_,6607);
         si8(8,6608);
         if(param1.transparent)
         {
            si8(6,6609);
         }
         else
         {
            si8(2,6609);
         }
         si8(0,6610);
         si8(0,6611);
         si8(0,6612);
         var _loc6_:int = _loc3_;
         param2.writeUnsignedInt(_loc6_);
         param2.writeUnsignedInt(1229472850);
         if(_loc6_ != 0)
         {
            PNGEncoder2Impl.data.position = 6600;
            PNGEncoder2Impl.data.readBytes(param2,param2.position,_loc3_);
            param2.position += _loc6_;
         }
         var _loc7_:* = -1;
         _loc7_ = li32(((_loc7_ ^ 73) & 255) << 2) ^ _loc7_ >>> 8;
         _loc7_ = li32(((_loc7_ ^ 72) & 255) << 2) ^ _loc7_ >>> 8;
         _loc7_ = li32(((_loc7_ ^ 68) & 255) << 2) ^ _loc7_ >>> 8;
         _loc7_ = li32(((_loc7_ ^ 82) & 255) << 2) ^ _loc7_ >>> 8;
         if(_loc6_ != 0)
         {
            _loc8_ = 6600;
            _loc9_ = 6600 + _loc6_;
            _loc10_ = 6600 + (_loc6_ & -16);
            while(_loc8_ < _loc10_)
            {
               _loc11_ = _loc7_ ^ li8(_loc8_);
               _loc7_ = li32((_loc11_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc11_ = _loc7_ ^ li8(_loc8_ + 1);
               _loc7_ = li32((_loc11_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc11_ = _loc7_ ^ li8(_loc8_ + 2);
               _loc7_ = li32((_loc11_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc11_ = _loc7_ ^ li8(_loc8_ + 3);
               _loc7_ = li32((_loc11_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc11_ = _loc7_ ^ li8(_loc8_ + 4);
               _loc7_ = li32((_loc11_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc11_ = _loc7_ ^ li8(_loc8_ + 5);
               _loc7_ = li32((_loc11_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc11_ = _loc7_ ^ li8(_loc8_ + 6);
               _loc7_ = li32((_loc11_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc11_ = _loc7_ ^ li8(_loc8_ + 7);
               _loc7_ = li32((_loc11_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc11_ = _loc7_ ^ li8(_loc8_ + 8);
               _loc7_ = li32((_loc11_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc11_ = _loc7_ ^ li8(_loc8_ + 9);
               _loc7_ = li32((_loc11_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc11_ = _loc7_ ^ li8(_loc8_ + 10);
               _loc7_ = li32((_loc11_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc11_ = _loc7_ ^ li8(_loc8_ + 11);
               _loc7_ = li32((_loc11_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc11_ = _loc7_ ^ li8(_loc8_ + 12);
               _loc7_ = li32((_loc11_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc11_ = _loc7_ ^ li8(_loc8_ + 13);
               _loc7_ = li32((_loc11_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc11_ = _loc7_ ^ li8(_loc8_ + 14);
               _loc7_ = li32((_loc11_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc11_ = _loc7_ ^ li8(_loc8_ + 15);
               _loc7_ = li32((_loc11_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc8_ += 16;
            }
            while(_loc8_ < _loc9_)
            {
               _loc11_ = _loc7_ ^ li8(_loc8_);
               _loc7_ = li32((_loc11_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc8_++;
            }
         }
         _loc7_ ^= -1;
         param2.writeUnsignedInt(_loc7_);
      }
      
      public static function writeMetadataChunks(param1:*, param2:ByteArray) : void
      {
         var _loc3_:* = null as ByteArray;
         var _loc4_:* = null as Array;
         var _loc5_:* = null as Class;
         var _loc6_:int = 0;
         var _loc7_:* = null as String;
         var _loc8_:Boolean = false;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:* = null;
         var _loc13_:* = null as String;
         var _loc14_:Boolean = false;
         var _loc15_:* = null;
         var _loc16_:uint = 0;
         var _loc17_:Number = NaN;
         var _loc18_:uint = 0;
         var _loc19_:* = 0;
         var _loc20_:* = 0;
         var _loc21_:* = 0;
         var _loc22_:* = 0;
         var _loc23_:* = 0;
         if(param1 != null)
         {
            _loc3_ = new ByteArray();
            ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
            _loc4_ = Reflect.fields(param1);
            if(_loc4_ == null || int(_loc4_.length) == 0)
            {
               _loc5_ = Type.getClass(param1);
               if(_loc5_ != null)
               {
                  _loc4_ = Type.getInstanceFields(_loc5_);
               }
            }
            _loc6_ = 0;
            while(_loc6_ < int(_loc4_.length))
            {
               _loc7_ = _loc4_[_loc6_];
               _loc6_++;
               if(!(_loc7_.length < 1 || _loc7_.length > 79))
               {
                  _loc3_.clear();
                  _loc3_.position = 0;
                  _loc8_ = true;
                  _loc9_ = 0;
                  _loc10_ = _loc7_.length;
                  while(_loc9_ < _loc10_)
                  {
                     _loc11_ = _loc9_++;
                     _loc12_ = _loc7_.charCodeAt(_loc11_);
                     if(!(_loc12_ >= 32 && _loc12_ <= 126 || _loc12_ >= 161 && _loc12_ <= 255))
                     {
                        _loc8_ = false;
                        break;
                     }
                     _loc3_.writeByte(_loc12_);
                  }
                  if(_loc8_)
                  {
                     _loc12_ = Reflect.field(param1,_loc7_);
                     if(!(_loc12_ == null || Reflect.isFunction(_loc12_)))
                     {
                        _loc13_ = Std.string(_loc12_);
                        _loc13_ = StringTools.replace(_loc13_,"\r\n","\n");
                        _loc13_ = StringTools.replace(_loc13_,"\r","\n");
                        _loc14_ = true;
                        _loc9_ = 0;
                        _loc10_ = _loc13_.length;
                        while(_loc9_ < _loc10_)
                        {
                           _loc11_ = _loc9_++;
                           _loc15_ = _loc13_.charCodeAt(_loc11_);
                           if(_loc15_ < 0 || _loc15_ > 255)
                           {
                              _loc14_ = false;
                              break;
                           }
                        }
                        if(_loc14_)
                        {
                           _loc3_.writeByte(0);
                           _loc9_ = 0;
                           _loc10_ = _loc13_.length;
                           while(_loc9_ < _loc10_)
                           {
                              _loc11_ = _loc9_++;
                              _loc3_.writeByte(_loc13_.charCodeAt(_loc11_));
                           }
                        }
                        else
                        {
                           _loc3_.writeInt(0);
                           _loc3_.writeByte(0);
                           _loc3_.writeUTFBytes(_loc13_);
                        }
                        _loc16_ = uint(6600 + _loc3_.length);
                        if(PNGEncoder2Impl.data.length < _loc16_)
                        {
                           _loc17_ = Number(Math.max(uint(6600 + _loc3_.length),ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH));
                           PNGEncoder2Impl.data.length = int(_loc17_);
                           ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
                        }
                        _loc3_.position = 0;
                        _loc18_ = uint(0);
                        _loc3_.readBytes(ApplicationDomain.currentDomain.domainMemory,6600,_loc18_);
                        if(_loc14_)
                        {
                           _loc9_ = 1950701684;
                        }
                        else
                        {
                           _loc9_ = 1767135348;
                        }
                        _loc10_ = _loc3_.length;
                        _loc11_ = _loc10_;
                        param2.writeUnsignedInt(_loc11_);
                        param2.writeUnsignedInt(_loc9_);
                        if(_loc11_ != 0)
                        {
                           PNGEncoder2Impl.data.position = 6600;
                           PNGEncoder2Impl.data.readBytes(param2,param2.position,_loc10_);
                           param2.position += _loc11_;
                        }
                        _loc19_ = -1;
                        _loc19_ = li32(((_loc19_ ^ _loc9_ >>> 24) & 255) << 2) ^ _loc19_ >>> 8;
                        _loc19_ = li32(((_loc19_ ^ _loc9_ >>> 16 & 255) & 255) << 2) ^ _loc19_ >>> 8;
                        _loc19_ = li32(((_loc19_ ^ _loc9_ >>> 8 & 255) & 255) << 2) ^ _loc19_ >>> 8;
                        _loc19_ = li32(((_loc19_ ^ _loc9_ & 255) & 255) << 2) ^ _loc19_ >>> 8;
                        if(_loc11_ != 0)
                        {
                           _loc20_ = 6600;
                           _loc21_ = 6600 + _loc11_;
                           _loc22_ = 6600 + (_loc11_ & -16);
                           while(_loc20_ < _loc22_)
                           {
                              _loc23_ = _loc19_ ^ li8(_loc20_);
                              _loc19_ = li32((_loc23_ & 255) << 2) ^ _loc19_ >>> 8;
                              _loc23_ = _loc19_ ^ li8(_loc20_ + 1);
                              _loc19_ = li32((_loc23_ & 255) << 2) ^ _loc19_ >>> 8;
                              _loc23_ = _loc19_ ^ li8(_loc20_ + 2);
                              _loc19_ = li32((_loc23_ & 255) << 2) ^ _loc19_ >>> 8;
                              _loc23_ = _loc19_ ^ li8(_loc20_ + 3);
                              _loc19_ = li32((_loc23_ & 255) << 2) ^ _loc19_ >>> 8;
                              _loc23_ = _loc19_ ^ li8(_loc20_ + 4);
                              _loc19_ = li32((_loc23_ & 255) << 2) ^ _loc19_ >>> 8;
                              _loc23_ = _loc19_ ^ li8(_loc20_ + 5);
                              _loc19_ = li32((_loc23_ & 255) << 2) ^ _loc19_ >>> 8;
                              _loc23_ = _loc19_ ^ li8(_loc20_ + 6);
                              _loc19_ = li32((_loc23_ & 255) << 2) ^ _loc19_ >>> 8;
                              _loc23_ = _loc19_ ^ li8(_loc20_ + 7);
                              _loc19_ = li32((_loc23_ & 255) << 2) ^ _loc19_ >>> 8;
                              _loc23_ = _loc19_ ^ li8(_loc20_ + 8);
                              _loc19_ = li32((_loc23_ & 255) << 2) ^ _loc19_ >>> 8;
                              _loc23_ = _loc19_ ^ li8(_loc20_ + 9);
                              _loc19_ = li32((_loc23_ & 255) << 2) ^ _loc19_ >>> 8;
                              _loc23_ = _loc19_ ^ li8(_loc20_ + 10);
                              _loc19_ = li32((_loc23_ & 255) << 2) ^ _loc19_ >>> 8;
                              _loc23_ = _loc19_ ^ li8(_loc20_ + 11);
                              _loc19_ = li32((_loc23_ & 255) << 2) ^ _loc19_ >>> 8;
                              _loc23_ = _loc19_ ^ li8(_loc20_ + 12);
                              _loc19_ = li32((_loc23_ & 255) << 2) ^ _loc19_ >>> 8;
                              _loc23_ = _loc19_ ^ li8(_loc20_ + 13);
                              _loc19_ = li32((_loc23_ & 255) << 2) ^ _loc19_ >>> 8;
                              _loc23_ = _loc19_ ^ li8(_loc20_ + 14);
                              _loc19_ = li32((_loc23_ & 255) << 2) ^ _loc19_ >>> 8;
                              _loc23_ = _loc19_ ^ li8(_loc20_ + 15);
                              _loc19_ = li32((_loc23_ & 255) << 2) ^ _loc19_ >>> 8;
                              _loc20_ += 16;
                           }
                           while(_loc20_ < _loc21_)
                           {
                              _loc23_ = _loc19_ ^ li8(_loc20_);
                              _loc19_ = li32((_loc23_ & 255) << 2) ^ _loc19_ >>> 8;
                              _loc20_++;
                           }
                        }
                        _loc19_ ^= -1;
                        param2.writeUnsignedInt(_loc19_);
                     }
                  }
               }
            }
         }
      }
      
      public static function memcpy(param1:ByteArray, param2:uint, param3:uint = 0) : void
      {
         param1.readBytes(ApplicationDomain.currentDomain.domainMemory,param2,param3);
      }
      
      public static function writeI32BE(param1:uint, param2:uint) : void
      {
         si8(param2 >>> 24,param1);
         si8(param2 >>> 16,uint(param1 + 1));
         si8(param2 >>> 8,uint(param1 + 2));
         si8(param2,uint(param1 + 3));
      }
      
      public static function writeIDATChunk(param1:BitmapData, param2:int, param3:int, param4:DeflateStream, param5:ByteArray) : void
      {
         var _loc7_:* = 0;
         var _loc11_:int = 0;
         var _loc13_:uint = 0;
         var _loc20_:uint = 0;
         var _loc21_:* = 0;
         var _loc22_:* = 0;
         var _loc23_:* = 0;
         var _loc24_:* = 0;
         var _loc25_:uint = 0;
         var _loc26_:* = 0;
         var _loc27_:* = 0;
         var _loc28_:* = 0;
         var _loc29_:* = 0;
         var _loc30_:* = 0;
         var _loc31_:* = 0;
         var _loc32_:* = 0;
         var _loc33_:* = 0;
         var _loc34_:* = 0;
         var _loc35_:* = 0;
         var _loc36_:* = 0;
         var _loc37_:* = 0;
         var _loc39_:* = null as MemoryRange;
         var _loc6_:int = param1.width;
         if(param2 == 0)
         {
            _loc7_ = 0;
         }
         else
         {
            _loc7_ = param2 - 1;
         }
         var _loc8_:* = param3 - param2;
         var _loc9_:* = param3 - _loc7_;
         PNGEncoder2Impl.region.y = _loc7_;
         PNGEncoder2Impl.region.width = _loc6_;
         PNGEncoder2Impl.region.height = _loc9_;
         var _loc10_:* = _loc6_ << 2;
         if(param1.transparent)
         {
            _loc11_ = 4;
         }
         else
         {
            _loc11_ = 3;
         }
         var _loc12_:uint = _loc6_ * _loc8_ * _loc11_ + _loc8_;
         if(param1.transparent)
         {
            _loc13_ = 0;
         }
         else
         {
            _loc13_ = 1;
         }
         var _loc14_:uint = _loc6_ * _loc9_ * 4;
         var _loc15_:Number = Number(Math.max(uint(uint(uint(6600 + int(param4.maxOutputBufferSize(_loc12_)) + _loc14_) + _loc12_) + _loc13_),ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH));
         PNGEncoder2Impl.data.length = int(_loc15_);
         ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
         var _loc16_:* = 6600 + int(param4.maxOutputBufferSize(_loc12_));
         var _loc17_:int = uint(_loc16_ + _loc14_);
         var _loc18_:* = int(_loc17_);
         var _loc19_:ByteArray = param1.getPixels(PNGEncoder2Impl.region);
         _loc19_.position = 0;
         _loc20_ = uint(0);
         _loc19_.readBytes(ApplicationDomain.currentDomain.domainMemory,_loc16_,_loc20_);
         if(_loc7_ != param2)
         {
            _loc16_ += _loc6_ * 4;
         }
         if(param1.transparent)
         {
            if(_loc7_ == param2)
            {
               si8(1,_loc18_);
               _loc18_ += 1;
               if(_loc6_ > 0 && _loc8_ > 0)
               {
                  _loc24_ = int(li32(_loc16_));
                  _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                  si32(_loc23_,_loc18_);
                  _loc21_ = _loc18_ + _loc10_;
                  _loc18_ += 4;
                  _loc16_ += 4;
                  _loc22_ = _loc18_ + (_loc10_ - 1 & -64);
                  while(_loc18_ != _loc22_)
                  {
                     _loc20_ = li32(_loc16_);
                     _loc25_ = li32(_loc16_ - 4);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_);
                     _loc20_ = li32(_loc16_ + 4);
                     _loc25_ = li32(_loc16_);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 4);
                     _loc20_ = li32(_loc16_ + 8);
                     _loc25_ = li32(_loc16_ + 4);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 8);
                     _loc20_ = li32(_loc16_ + 12);
                     _loc25_ = li32(_loc16_ + 8);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 12);
                     _loc20_ = li32(_loc16_ + 16);
                     _loc25_ = li32(_loc16_ + 12);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 16);
                     _loc20_ = li32(_loc16_ + 20);
                     _loc25_ = li32(_loc16_ + 16);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 20);
                     _loc20_ = li32(_loc16_ + 24);
                     _loc25_ = li32(_loc16_ + 20);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 24);
                     _loc20_ = li32(_loc16_ + 28);
                     _loc25_ = li32(_loc16_ + 24);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 28);
                     _loc20_ = li32(_loc16_ + 32);
                     _loc25_ = li32(_loc16_ + 28);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 32);
                     _loc20_ = li32(_loc16_ + 36);
                     _loc25_ = li32(_loc16_ + 32);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 36);
                     _loc20_ = li32(_loc16_ + 40);
                     _loc25_ = li32(_loc16_ + 36);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 40);
                     _loc20_ = li32(_loc16_ + 44);
                     _loc25_ = li32(_loc16_ + 40);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 44);
                     _loc20_ = li32(_loc16_ + 48);
                     _loc25_ = li32(_loc16_ + 44);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 48);
                     _loc20_ = li32(_loc16_ + 52);
                     _loc25_ = li32(_loc16_ + 48);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 52);
                     _loc20_ = li32(_loc16_ + 56);
                     _loc25_ = li32(_loc16_ + 52);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 56);
                     _loc20_ = li32(_loc16_ + 60);
                     _loc25_ = li32(_loc16_ + 56);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 60);
                     _loc18_ += 64;
                     _loc16_ += 64;
                  }
                  while(_loc18_ != _loc21_)
                  {
                     _loc20_ = li32(_loc16_);
                     _loc25_ = li32(_loc16_ - 4);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_);
                     _loc18_ += 4;
                     _loc16_ += 4;
                  }
               }
            }
            _loc23_ = 1;
            while(_loc23_ < _loc9_)
            {
               _loc24_ = int(_loc23_++);
               si8(4,_loc18_);
               _loc18_ += 1;
               if(_loc6_ > 0)
               {
                  _loc20_ = li32(_loc16_);
                  _loc25_ = li32(_loc16_ - _loc10_);
                  _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                  _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                  si32(_loc26_,_loc18_);
                  _loc21_ = _loc18_ + _loc10_;
                  _loc18_ += 4;
                  _loc16_ += 4;
                  _loc22_ = _loc18_ + (_loc10_ - 1 & -64);
                  while(_loc18_ != _loc22_)
                  {
                     _loc20_ = li32(_loc16_);
                     _loc28_ = int(li32(_loc16_ - 4));
                     _loc29_ = int(li32(_loc16_ - _loc10_));
                     _loc30_ = int(li32(_loc16_ - 4 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_);
                     _loc20_ = li32(_loc16_ + 4);
                     _loc28_ = int(li32(_loc16_));
                     _loc29_ = int(li32(_loc16_ + 4 - _loc10_));
                     _loc30_ = int(li32(_loc16_ - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 4);
                     _loc20_ = li32(_loc16_ + 8);
                     _loc28_ = int(li32(_loc16_ + 4));
                     _loc29_ = int(li32(_loc16_ + 8 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 4 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 8);
                     _loc20_ = li32(_loc16_ + 12);
                     _loc28_ = int(li32(_loc16_ + 8));
                     _loc29_ = int(li32(_loc16_ + 12 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 8 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 12);
                     _loc20_ = li32(_loc16_ + 16);
                     _loc28_ = int(li32(_loc16_ + 12));
                     _loc29_ = int(li32(_loc16_ + 16 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 12 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 16);
                     _loc20_ = li32(_loc16_ + 20);
                     _loc28_ = int(li32(_loc16_ + 16));
                     _loc29_ = int(li32(_loc16_ + 20 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 16 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 20);
                     _loc20_ = li32(_loc16_ + 24);
                     _loc28_ = int(li32(_loc16_ + 20));
                     _loc29_ = int(li32(_loc16_ + 24 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 20 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 24);
                     _loc20_ = li32(_loc16_ + 28);
                     _loc28_ = int(li32(_loc16_ + 24));
                     _loc29_ = int(li32(_loc16_ + 28 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 24 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 28);
                     _loc20_ = li32(_loc16_ + 32);
                     _loc28_ = int(li32(_loc16_ + 28));
                     _loc29_ = int(li32(_loc16_ + 32 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 28 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 32);
                     _loc20_ = li32(_loc16_ + 36);
                     _loc28_ = int(li32(_loc16_ + 32));
                     _loc29_ = int(li32(_loc16_ + 36 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 32 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 36);
                     _loc20_ = li32(_loc16_ + 40);
                     _loc28_ = int(li32(_loc16_ + 36));
                     _loc29_ = int(li32(_loc16_ + 40 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 36 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 40);
                     _loc20_ = li32(_loc16_ + 44);
                     _loc28_ = int(li32(_loc16_ + 40));
                     _loc29_ = int(li32(_loc16_ + 44 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 40 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 44);
                     _loc20_ = li32(_loc16_ + 48);
                     _loc28_ = int(li32(_loc16_ + 44));
                     _loc29_ = int(li32(_loc16_ + 48 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 44 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 48);
                     _loc20_ = li32(_loc16_ + 52);
                     _loc28_ = int(li32(_loc16_ + 48));
                     _loc29_ = int(li32(_loc16_ + 52 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 48 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 52);
                     _loc20_ = li32(_loc16_ + 56);
                     _loc28_ = int(li32(_loc16_ + 52));
                     _loc29_ = int(li32(_loc16_ + 56 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 52 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 56);
                     _loc20_ = li32(_loc16_ + 60);
                     _loc28_ = int(li32(_loc16_ + 56));
                     _loc29_ = int(li32(_loc16_ + 60 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 56 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 60);
                     _loc18_ += 64;
                     _loc16_ += 64;
                  }
                  while(_loc18_ != _loc21_)
                  {
                     _loc20_ = li32(_loc16_);
                     _loc28_ = int(li32(_loc16_ - 4));
                     _loc29_ = int(li32(_loc16_ - _loc10_));
                     _loc30_ = int(li32(_loc16_ - 4 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_);
                     _loc18_ += 4;
                     _loc16_ += 4;
                  }
               }
            }
         }
         else
         {
            if(_loc7_ == param2)
            {
               si8(1,_loc18_);
               _loc18_ += 1;
               if(_loc6_ > 0 && _loc8_ > 0)
               {
                  _loc23_ = int(li16(_loc16_ + 1));
                  si16(_loc23_,_loc18_);
                  _loc23_ = int(li8(_loc16_ + 3));
                  si8(_loc23_,_loc18_ + 2);
                  _loc21_ = _loc18_ + _loc6_ * 3;
                  _loc18_ += 3;
                  _loc16_ += 4;
                  _loc16_++;
                  _loc22_ = _loc16_ + (_loc6_ * 3 - 1 & -64);
                  while(_loc16_ != _loc22_)
                  {
                     _loc20_ = li32(_loc16_);
                     _loc25_ = li32(_loc16_ - 4);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_);
                     _loc20_ = li32(_loc16_ + 4);
                     _loc25_ = li32(_loc16_);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 3);
                     _loc20_ = li32(_loc16_ + 8);
                     _loc25_ = li32(_loc16_ + 4);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 6);
                     _loc20_ = li32(_loc16_ + 12);
                     _loc25_ = li32(_loc16_ + 8);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 9);
                     _loc20_ = li32(_loc16_ + 16);
                     _loc25_ = li32(_loc16_ + 12);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 12);
                     _loc20_ = li32(_loc16_ + 20);
                     _loc25_ = li32(_loc16_ + 16);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 15);
                     _loc20_ = li32(_loc16_ + 24);
                     _loc25_ = li32(_loc16_ + 20);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 18);
                     _loc20_ = li32(_loc16_ + 28);
                     _loc25_ = li32(_loc16_ + 24);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 21);
                     _loc20_ = li32(_loc16_ + 32);
                     _loc25_ = li32(_loc16_ + 28);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 24);
                     _loc20_ = li32(_loc16_ + 36);
                     _loc25_ = li32(_loc16_ + 32);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 27);
                     _loc20_ = li32(_loc16_ + 40);
                     _loc25_ = li32(_loc16_ + 36);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 30);
                     _loc20_ = li32(_loc16_ + 44);
                     _loc25_ = li32(_loc16_ + 40);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 33);
                     _loc20_ = li32(_loc16_ + 48);
                     _loc25_ = li32(_loc16_ + 44);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 36);
                     _loc20_ = li32(_loc16_ + 52);
                     _loc25_ = li32(_loc16_ + 48);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 39);
                     _loc20_ = li32(_loc16_ + 56);
                     _loc25_ = li32(_loc16_ + 52);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 42);
                     _loc20_ = li32(_loc16_ + 60);
                     _loc25_ = li32(_loc16_ + 56);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 45);
                     _loc18_ += 48;
                     _loc16_ += 64;
                  }
                  while(_loc18_ != _loc21_)
                  {
                     _loc20_ = li32(_loc16_);
                     _loc25_ = li32(_loc16_ - 4);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_);
                     _loc18_ += 3;
                     _loc16_ += 4;
                  }
                  _loc16_--;
               }
            }
            _loc23_ = 1;
            while(_loc23_ < _loc9_)
            {
               _loc24_ = int(_loc23_++);
               si8(4,_loc18_);
               _loc18_ += 1;
               if(_loc6_ > 0)
               {
                  _loc20_ = li32(_loc16_ + 1);
                  _loc25_ = li32(_loc16_ + 1 - _loc10_);
                  _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                  si32(_loc26_,_loc18_);
                  _loc21_ = _loc18_ + _loc6_ * 3;
                  _loc18_ += 3;
                  _loc16_ += 4;
                  _loc16_++;
                  _loc22_ = _loc16_ + (_loc6_ * 3 - 1 & -64);
                  while(_loc16_ != _loc22_)
                  {
                     _loc20_ = li32(_loc16_);
                     _loc27_ = int(li32(_loc16_ - 4));
                     _loc28_ = int(li32(_loc16_ - _loc10_));
                     _loc29_ = int(li32(_loc16_ - 4 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_);
                     _loc20_ = li32(_loc16_ + 4);
                     _loc27_ = int(li32(_loc16_));
                     _loc28_ = int(li32(_loc16_ + 4 - _loc10_));
                     _loc29_ = int(li32(_loc16_ - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 3);
                     _loc20_ = li32(_loc16_ + 8);
                     _loc27_ = int(li32(_loc16_ + 4));
                     _loc28_ = int(li32(_loc16_ + 8 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 4 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 6);
                     _loc20_ = li32(_loc16_ + 12);
                     _loc27_ = int(li32(_loc16_ + 8));
                     _loc28_ = int(li32(_loc16_ + 12 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 8 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 9);
                     _loc20_ = li32(_loc16_ + 16);
                     _loc27_ = int(li32(_loc16_ + 12));
                     _loc28_ = int(li32(_loc16_ + 16 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 12 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 12);
                     _loc20_ = li32(_loc16_ + 20);
                     _loc27_ = int(li32(_loc16_ + 16));
                     _loc28_ = int(li32(_loc16_ + 20 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 16 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 15);
                     _loc20_ = li32(_loc16_ + 24);
                     _loc27_ = int(li32(_loc16_ + 20));
                     _loc28_ = int(li32(_loc16_ + 24 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 20 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 18);
                     _loc20_ = li32(_loc16_ + 28);
                     _loc27_ = int(li32(_loc16_ + 24));
                     _loc28_ = int(li32(_loc16_ + 28 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 24 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 21);
                     _loc20_ = li32(_loc16_ + 32);
                     _loc27_ = int(li32(_loc16_ + 28));
                     _loc28_ = int(li32(_loc16_ + 32 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 28 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 24);
                     _loc20_ = li32(_loc16_ + 36);
                     _loc27_ = int(li32(_loc16_ + 32));
                     _loc28_ = int(li32(_loc16_ + 36 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 32 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 27);
                     _loc20_ = li32(_loc16_ + 40);
                     _loc27_ = int(li32(_loc16_ + 36));
                     _loc28_ = int(li32(_loc16_ + 40 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 36 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 30);
                     _loc20_ = li32(_loc16_ + 44);
                     _loc27_ = int(li32(_loc16_ + 40));
                     _loc28_ = int(li32(_loc16_ + 44 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 40 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 33);
                     _loc20_ = li32(_loc16_ + 48);
                     _loc27_ = int(li32(_loc16_ + 44));
                     _loc28_ = int(li32(_loc16_ + 48 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 44 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 36);
                     _loc20_ = li32(_loc16_ + 52);
                     _loc27_ = int(li32(_loc16_ + 48));
                     _loc28_ = int(li32(_loc16_ + 52 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 48 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 39);
                     _loc20_ = li32(_loc16_ + 56);
                     _loc27_ = int(li32(_loc16_ + 52));
                     _loc28_ = int(li32(_loc16_ + 56 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 52 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 42);
                     _loc20_ = li32(_loc16_ + 60);
                     _loc27_ = int(li32(_loc16_ + 56));
                     _loc28_ = int(li32(_loc16_ + 60 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 56 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 45);
                     _loc18_ += 48;
                     _loc16_ += 64;
                  }
                  while(_loc18_ != _loc21_)
                  {
                     _loc20_ = li32(_loc16_);
                     _loc27_ = int(li32(_loc16_ - 4));
                     _loc28_ = int(li32(_loc16_ - _loc10_));
                     _loc29_ = int(li32(_loc16_ - 4 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_);
                     _loc18_ += 3;
                     _loc16_ += 4;
                  }
                  _loc16_--;
               }
            }
         }
         param4.fastWrite(_loc17_,uint(_loc17_ + _loc12_));
         var _loc38_:* = param3 == param1.height;
         if(_loc38_)
         {
            _loc39_ = param4.fastFinalize();
         }
         else
         {
            _loc39_ = param4.peek();
         }
         _loc23_ = _loc39_.end - _loc39_.offset;
         _loc24_ = int(_loc23_);
         param5.writeUnsignedInt(_loc24_);
         param5.writeUnsignedInt(1229209940);
         if(_loc24_ != 0)
         {
            PNGEncoder2Impl.data.position = 6600;
            PNGEncoder2Impl.data.readBytes(param5,param5.position,_loc23_);
            param5.position += _loc24_;
         }
         _loc26_ = -1;
         _loc26_ = li32(((_loc26_ ^ 73) & 255) << 2) ^ _loc26_ >>> 8;
         _loc26_ = li32(((_loc26_ ^ 68) & 255) << 2) ^ _loc26_ >>> 8;
         _loc26_ = li32(((_loc26_ ^ 65) & 255) << 2) ^ _loc26_ >>> 8;
         _loc26_ = li32(((_loc26_ ^ 84) & 255) << 2) ^ _loc26_ >>> 8;
         if(_loc24_ != 0)
         {
            _loc27_ = 6600;
            _loc28_ = 6600 + _loc24_;
            _loc29_ = 6600 + (_loc24_ & -16);
            while(_loc27_ < _loc29_)
            {
               _loc30_ = _loc26_ ^ li8(_loc27_);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 1);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 2);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 3);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 4);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 5);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 6);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 7);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 8);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 9);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 10);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 11);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 12);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 13);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 14);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 15);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc27_ += 16;
            }
            while(_loc27_ < _loc28_)
            {
               _loc30_ = _loc26_ ^ li8(_loc27_);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc27_++;
            }
         }
         _loc26_ ^= -1;
         param5.writeUnsignedInt(_loc26_);
         if(!_loc38_)
         {
            param4.release();
         }
      }
      
      public static function _writeIDATChunk(param1:BitmapData, param2:int, param3:int, param4:DeflateStream, param5:ByteArray) : void
      {
         var _loc7_:* = 0;
         var _loc11_:int = 0;
         var _loc13_:uint = 0;
         var _loc20_:uint = 0;
         var _loc21_:* = 0;
         var _loc22_:* = 0;
         var _loc23_:* = 0;
         var _loc24_:* = 0;
         var _loc25_:uint = 0;
         var _loc26_:* = 0;
         var _loc27_:* = 0;
         var _loc28_:* = 0;
         var _loc29_:* = 0;
         var _loc30_:* = 0;
         var _loc31_:* = 0;
         var _loc32_:* = 0;
         var _loc33_:* = 0;
         var _loc34_:* = 0;
         var _loc35_:* = 0;
         var _loc36_:* = 0;
         var _loc37_:* = 0;
         var _loc39_:* = null as MemoryRange;
         var _loc6_:int = param1.width;
         if(param2 == 0)
         {
            _loc7_ = 0;
         }
         else
         {
            _loc7_ = param2 - 1;
         }
         var _loc8_:* = param3 - param2;
         var _loc9_:* = param3 - _loc7_;
         PNGEncoder2Impl.region.y = _loc7_;
         PNGEncoder2Impl.region.width = _loc6_;
         PNGEncoder2Impl.region.height = _loc9_;
         var _loc10_:* = _loc6_ << 2;
         if(param1.transparent)
         {
            _loc11_ = 4;
         }
         else
         {
            _loc11_ = 3;
         }
         var _loc12_:uint = _loc6_ * _loc8_ * _loc11_ + _loc8_;
         if(param1.transparent)
         {
            _loc13_ = 0;
         }
         else
         {
            _loc13_ = 1;
         }
         var _loc14_:uint = _loc6_ * _loc9_ * 4;
         var _loc15_:Number = Number(Math.max(uint(uint(uint(6600 + int(param4.maxOutputBufferSize(_loc12_)) + _loc14_) + _loc12_) + _loc13_),ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH));
         PNGEncoder2Impl.data.length = int(_loc15_);
         ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
         var _loc16_:* = 6600 + int(param4.maxOutputBufferSize(_loc12_));
         var _loc17_:int = uint(_loc16_ + _loc14_);
         var _loc18_:* = int(_loc17_);
         var _loc19_:ByteArray = param1.getPixels(PNGEncoder2Impl.region);
         _loc19_.position = 0;
         _loc20_ = uint(0);
         _loc19_.readBytes(ApplicationDomain.currentDomain.domainMemory,_loc16_,_loc20_);
         if(_loc7_ != param2)
         {
            _loc16_ += _loc6_ * 4;
         }
         if(param1.transparent)
         {
            if(_loc7_ == param2)
            {
               si8(1,_loc18_);
               _loc18_ += 1;
               if(_loc6_ > 0 && _loc8_ > 0)
               {
                  _loc24_ = int(li32(_loc16_));
                  _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                  si32(_loc23_,_loc18_);
                  _loc21_ = _loc18_ + _loc10_;
                  _loc18_ += 4;
                  _loc16_ += 4;
                  _loc22_ = _loc18_ + (_loc10_ - 1 & -64);
                  while(_loc18_ != _loc22_)
                  {
                     _loc20_ = li32(_loc16_);
                     _loc25_ = li32(_loc16_ - 4);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_);
                     _loc20_ = li32(_loc16_ + 4);
                     _loc25_ = li32(_loc16_);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 4);
                     _loc20_ = li32(_loc16_ + 8);
                     _loc25_ = li32(_loc16_ + 4);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 8);
                     _loc20_ = li32(_loc16_ + 12);
                     _loc25_ = li32(_loc16_ + 8);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 12);
                     _loc20_ = li32(_loc16_ + 16);
                     _loc25_ = li32(_loc16_ + 12);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 16);
                     _loc20_ = li32(_loc16_ + 20);
                     _loc25_ = li32(_loc16_ + 16);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 20);
                     _loc20_ = li32(_loc16_ + 24);
                     _loc25_ = li32(_loc16_ + 20);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 24);
                     _loc20_ = li32(_loc16_ + 28);
                     _loc25_ = li32(_loc16_ + 24);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 28);
                     _loc20_ = li32(_loc16_ + 32);
                     _loc25_ = li32(_loc16_ + 28);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 32);
                     _loc20_ = li32(_loc16_ + 36);
                     _loc25_ = li32(_loc16_ + 32);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 36);
                     _loc20_ = li32(_loc16_ + 40);
                     _loc25_ = li32(_loc16_ + 36);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 40);
                     _loc20_ = li32(_loc16_ + 44);
                     _loc25_ = li32(_loc16_ + 40);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 44);
                     _loc20_ = li32(_loc16_ + 48);
                     _loc25_ = li32(_loc16_ + 44);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 48);
                     _loc20_ = li32(_loc16_ + 52);
                     _loc25_ = li32(_loc16_ + 48);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 52);
                     _loc20_ = li32(_loc16_ + 56);
                     _loc25_ = li32(_loc16_ + 52);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 56);
                     _loc20_ = li32(_loc16_ + 60);
                     _loc25_ = li32(_loc16_ + 56);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_ + 60);
                     _loc18_ += 64;
                     _loc16_ += 64;
                  }
                  while(_loc18_ != _loc21_)
                  {
                     _loc20_ = li32(_loc16_);
                     _loc25_ = li32(_loc16_ - 4);
                     _loc24_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc23_ = _loc24_ >>> 8 | _loc24_ << 24;
                     si32(_loc23_,_loc18_);
                     _loc18_ += 4;
                     _loc16_ += 4;
                  }
               }
            }
            _loc23_ = 1;
            while(_loc23_ < _loc9_)
            {
               _loc24_ = int(_loc23_++);
               si8(4,_loc18_);
               _loc18_ += 1;
               if(_loc6_ > 0)
               {
                  _loc20_ = li32(_loc16_);
                  _loc25_ = li32(_loc16_ - _loc10_);
                  _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                  _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                  si32(_loc26_,_loc18_);
                  _loc21_ = _loc18_ + _loc10_;
                  _loc18_ += 4;
                  _loc16_ += 4;
                  _loc22_ = _loc18_ + (_loc10_ - 1 & -64);
                  while(_loc18_ != _loc22_)
                  {
                     _loc20_ = li32(_loc16_);
                     _loc28_ = int(li32(_loc16_ - 4));
                     _loc29_ = int(li32(_loc16_ - _loc10_));
                     _loc30_ = int(li32(_loc16_ - 4 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_);
                     _loc20_ = li32(_loc16_ + 4);
                     _loc28_ = int(li32(_loc16_));
                     _loc29_ = int(li32(_loc16_ + 4 - _loc10_));
                     _loc30_ = int(li32(_loc16_ - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 4);
                     _loc20_ = li32(_loc16_ + 8);
                     _loc28_ = int(li32(_loc16_ + 4));
                     _loc29_ = int(li32(_loc16_ + 8 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 4 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 8);
                     _loc20_ = li32(_loc16_ + 12);
                     _loc28_ = int(li32(_loc16_ + 8));
                     _loc29_ = int(li32(_loc16_ + 12 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 8 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 12);
                     _loc20_ = li32(_loc16_ + 16);
                     _loc28_ = int(li32(_loc16_ + 12));
                     _loc29_ = int(li32(_loc16_ + 16 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 12 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 16);
                     _loc20_ = li32(_loc16_ + 20);
                     _loc28_ = int(li32(_loc16_ + 16));
                     _loc29_ = int(li32(_loc16_ + 20 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 16 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 20);
                     _loc20_ = li32(_loc16_ + 24);
                     _loc28_ = int(li32(_loc16_ + 20));
                     _loc29_ = int(li32(_loc16_ + 24 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 20 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 24);
                     _loc20_ = li32(_loc16_ + 28);
                     _loc28_ = int(li32(_loc16_ + 24));
                     _loc29_ = int(li32(_loc16_ + 28 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 24 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 28);
                     _loc20_ = li32(_loc16_ + 32);
                     _loc28_ = int(li32(_loc16_ + 28));
                     _loc29_ = int(li32(_loc16_ + 32 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 28 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 32);
                     _loc20_ = li32(_loc16_ + 36);
                     _loc28_ = int(li32(_loc16_ + 32));
                     _loc29_ = int(li32(_loc16_ + 36 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 32 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 36);
                     _loc20_ = li32(_loc16_ + 40);
                     _loc28_ = int(li32(_loc16_ + 36));
                     _loc29_ = int(li32(_loc16_ + 40 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 36 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 40);
                     _loc20_ = li32(_loc16_ + 44);
                     _loc28_ = int(li32(_loc16_ + 40));
                     _loc29_ = int(li32(_loc16_ + 44 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 40 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 44);
                     _loc20_ = li32(_loc16_ + 48);
                     _loc28_ = int(li32(_loc16_ + 44));
                     _loc29_ = int(li32(_loc16_ + 48 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 44 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 48);
                     _loc20_ = li32(_loc16_ + 52);
                     _loc28_ = int(li32(_loc16_ + 48));
                     _loc29_ = int(li32(_loc16_ + 52 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 48 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 52);
                     _loc20_ = li32(_loc16_ + 56);
                     _loc28_ = int(li32(_loc16_ + 52));
                     _loc29_ = int(li32(_loc16_ + 56 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 52 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 56);
                     _loc20_ = li32(_loc16_ + 60);
                     _loc28_ = int(li32(_loc16_ + 56));
                     _loc29_ = int(li32(_loc16_ + 60 - _loc10_));
                     _loc30_ = int(li32(_loc16_ + 56 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_ + 60);
                     _loc18_ += 64;
                     _loc16_ += 64;
                  }
                  while(_loc18_ != _loc21_)
                  {
                     _loc20_ = li32(_loc16_);
                     _loc28_ = int(li32(_loc16_ - 4));
                     _loc29_ = int(li32(_loc16_ - _loc10_));
                     _loc30_ = int(li32(_loc16_ - 4 - _loc10_));
                     _loc32_ = (_loc29_ & 255) - (_loc30_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc28_ & 255) - (_loc30_ & 255);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc34_ = (_loc28_ & 255) + (_loc29_ & 255) - (_loc30_ << 1 & 510);
                     _loc35_ = _loc34_ >> 31;
                     _loc33_ = _loc34_ + _loc35_ ^ _loc35_;
                     _loc34_ = (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 255;
                     _loc35_ = _loc33_ - _loc32_ >> 31 & 255;
                     _loc36_ = (_loc29_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) - (_loc30_ & 65280);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 65280) + (_loc29_ & 65280) - (_loc30_ << 1 & 130560);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 65280;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 65280;
                     _loc36_ = (_loc29_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) - (_loc30_ & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ & 16711680) + (_loc29_ & 16711680) - (_loc30_ << 1 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & 16711680;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & 16711680;
                     _loc36_ = (_loc29_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc31_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) - (_loc30_ >> 8 & 16711680);
                     _loc37_ = _loc36_ >> 31;
                     _loc32_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc36_ = (_loc28_ >> 8 & 16711680) + (_loc29_ >> 8 & 16711680) - (_loc30_ >> 7 & 33423360);
                     _loc37_ = _loc36_ >> 31;
                     _loc33_ = _loc36_ + _loc37_ ^ _loc37_;
                     _loc34_ |= (_loc32_ - _loc31_ | _loc33_ - _loc31_) >> 31 & -16777216;
                     _loc35_ |= _loc33_ - _loc32_ >> 31 & -16777216;
                     _loc25_ = _loc28_ & ~_loc34_ | _loc29_ & _loc34_ & ~_loc35_ | _loc30_ & _loc34_ & _loc35_;
                     _loc27_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     _loc26_ = _loc27_ >>> 8 | _loc27_ << 24;
                     si32(_loc26_,_loc18_);
                     _loc18_ += 4;
                     _loc16_ += 4;
                  }
               }
            }
         }
         else
         {
            if(_loc7_ == param2)
            {
               si8(1,_loc18_);
               _loc18_ += 1;
               if(_loc6_ > 0 && _loc8_ > 0)
               {
                  _loc23_ = int(li16(_loc16_ + 1));
                  si16(_loc23_,_loc18_);
                  _loc23_ = int(li8(_loc16_ + 3));
                  si8(_loc23_,_loc18_ + 2);
                  _loc21_ = _loc18_ + _loc6_ * 3;
                  _loc18_ += 3;
                  _loc16_ += 4;
                  _loc16_++;
                  _loc22_ = _loc16_ + (_loc6_ * 3 - 1 & -64);
                  while(_loc16_ != _loc22_)
                  {
                     _loc20_ = li32(_loc16_);
                     _loc25_ = li32(_loc16_ - 4);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_);
                     _loc20_ = li32(_loc16_ + 4);
                     _loc25_ = li32(_loc16_);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 3);
                     _loc20_ = li32(_loc16_ + 8);
                     _loc25_ = li32(_loc16_ + 4);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 6);
                     _loc20_ = li32(_loc16_ + 12);
                     _loc25_ = li32(_loc16_ + 8);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 9);
                     _loc20_ = li32(_loc16_ + 16);
                     _loc25_ = li32(_loc16_ + 12);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 12);
                     _loc20_ = li32(_loc16_ + 20);
                     _loc25_ = li32(_loc16_ + 16);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 15);
                     _loc20_ = li32(_loc16_ + 24);
                     _loc25_ = li32(_loc16_ + 20);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 18);
                     _loc20_ = li32(_loc16_ + 28);
                     _loc25_ = li32(_loc16_ + 24);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 21);
                     _loc20_ = li32(_loc16_ + 32);
                     _loc25_ = li32(_loc16_ + 28);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 24);
                     _loc20_ = li32(_loc16_ + 36);
                     _loc25_ = li32(_loc16_ + 32);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 27);
                     _loc20_ = li32(_loc16_ + 40);
                     _loc25_ = li32(_loc16_ + 36);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 30);
                     _loc20_ = li32(_loc16_ + 44);
                     _loc25_ = li32(_loc16_ + 40);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 33);
                     _loc20_ = li32(_loc16_ + 48);
                     _loc25_ = li32(_loc16_ + 44);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 36);
                     _loc20_ = li32(_loc16_ + 52);
                     _loc25_ = li32(_loc16_ + 48);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 39);
                     _loc20_ = li32(_loc16_ + 56);
                     _loc25_ = li32(_loc16_ + 52);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 42);
                     _loc20_ = li32(_loc16_ + 60);
                     _loc25_ = li32(_loc16_ + 56);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_ + 45);
                     _loc18_ += 48;
                     _loc16_ += 64;
                  }
                  while(_loc18_ != _loc21_)
                  {
                     _loc20_ = li32(_loc16_);
                     _loc25_ = li32(_loc16_ - 4);
                     _loc23_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc23_,_loc18_);
                     _loc18_ += 3;
                     _loc16_ += 4;
                  }
                  _loc16_--;
               }
            }
            _loc23_ = 1;
            while(_loc23_ < _loc9_)
            {
               _loc24_ = int(_loc23_++);
               si8(4,_loc18_);
               _loc18_ += 1;
               if(_loc6_ > 0)
               {
                  _loc20_ = li32(_loc16_ + 1);
                  _loc25_ = li32(_loc16_ + 1 - _loc10_);
                  _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                  si32(_loc26_,_loc18_);
                  _loc21_ = _loc18_ + _loc6_ * 3;
                  _loc18_ += 3;
                  _loc16_ += 4;
                  _loc16_++;
                  _loc22_ = _loc16_ + (_loc6_ * 3 - 1 & -64);
                  while(_loc16_ != _loc22_)
                  {
                     _loc20_ = li32(_loc16_);
                     _loc27_ = int(li32(_loc16_ - 4));
                     _loc28_ = int(li32(_loc16_ - _loc10_));
                     _loc29_ = int(li32(_loc16_ - 4 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_);
                     _loc20_ = li32(_loc16_ + 4);
                     _loc27_ = int(li32(_loc16_));
                     _loc28_ = int(li32(_loc16_ + 4 - _loc10_));
                     _loc29_ = int(li32(_loc16_ - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 3);
                     _loc20_ = li32(_loc16_ + 8);
                     _loc27_ = int(li32(_loc16_ + 4));
                     _loc28_ = int(li32(_loc16_ + 8 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 4 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 6);
                     _loc20_ = li32(_loc16_ + 12);
                     _loc27_ = int(li32(_loc16_ + 8));
                     _loc28_ = int(li32(_loc16_ + 12 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 8 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 9);
                     _loc20_ = li32(_loc16_ + 16);
                     _loc27_ = int(li32(_loc16_ + 12));
                     _loc28_ = int(li32(_loc16_ + 16 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 12 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 12);
                     _loc20_ = li32(_loc16_ + 20);
                     _loc27_ = int(li32(_loc16_ + 16));
                     _loc28_ = int(li32(_loc16_ + 20 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 16 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 15);
                     _loc20_ = li32(_loc16_ + 24);
                     _loc27_ = int(li32(_loc16_ + 20));
                     _loc28_ = int(li32(_loc16_ + 24 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 20 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 18);
                     _loc20_ = li32(_loc16_ + 28);
                     _loc27_ = int(li32(_loc16_ + 24));
                     _loc28_ = int(li32(_loc16_ + 28 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 24 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 21);
                     _loc20_ = li32(_loc16_ + 32);
                     _loc27_ = int(li32(_loc16_ + 28));
                     _loc28_ = int(li32(_loc16_ + 32 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 28 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 24);
                     _loc20_ = li32(_loc16_ + 36);
                     _loc27_ = int(li32(_loc16_ + 32));
                     _loc28_ = int(li32(_loc16_ + 36 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 32 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 27);
                     _loc20_ = li32(_loc16_ + 40);
                     _loc27_ = int(li32(_loc16_ + 36));
                     _loc28_ = int(li32(_loc16_ + 40 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 36 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 30);
                     _loc20_ = li32(_loc16_ + 44);
                     _loc27_ = int(li32(_loc16_ + 40));
                     _loc28_ = int(li32(_loc16_ + 44 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 40 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 33);
                     _loc20_ = li32(_loc16_ + 48);
                     _loc27_ = int(li32(_loc16_ + 44));
                     _loc28_ = int(li32(_loc16_ + 48 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 44 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 36);
                     _loc20_ = li32(_loc16_ + 52);
                     _loc27_ = int(li32(_loc16_ + 48));
                     _loc28_ = int(li32(_loc16_ + 52 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 48 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 39);
                     _loc20_ = li32(_loc16_ + 56);
                     _loc27_ = int(li32(_loc16_ + 52));
                     _loc28_ = int(li32(_loc16_ + 56 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 52 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 42);
                     _loc20_ = li32(_loc16_ + 60);
                     _loc27_ = int(li32(_loc16_ + 56));
                     _loc28_ = int(li32(_loc16_ + 60 - _loc10_));
                     _loc29_ = int(li32(_loc16_ + 56 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_ + 45);
                     _loc18_ += 48;
                     _loc16_ += 64;
                  }
                  while(_loc18_ != _loc21_)
                  {
                     _loc20_ = li32(_loc16_);
                     _loc27_ = int(li32(_loc16_ - 4));
                     _loc28_ = int(li32(_loc16_ - _loc10_));
                     _loc29_ = int(li32(_loc16_ - 4 - _loc10_));
                     _loc31_ = (_loc28_ & 255) - (_loc29_ & 255);
                     _loc32_ = _loc31_ >> 31;
                     _loc30_ = _loc31_ + _loc32_ ^ _loc32_;
                     _loc32_ = (_loc27_ & 255) - (_loc29_ & 255);
                     _loc33_ = _loc32_ >> 31;
                     _loc31_ = _loc32_ + _loc33_ ^ _loc33_;
                     _loc33_ = (_loc27_ & 255) + (_loc28_ & 255) - (_loc29_ << 1 & 510);
                     _loc34_ = _loc33_ >> 31;
                     _loc32_ = _loc33_ + _loc34_ ^ _loc34_;
                     _loc33_ = (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 255;
                     _loc34_ = _loc32_ - _loc31_ >> 31 & 255;
                     _loc35_ = (_loc28_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) - (_loc29_ & 65280);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 65280) + (_loc28_ & 65280) - (_loc29_ << 1 & 130560);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 65280;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 65280;
                     _loc35_ = (_loc28_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc30_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) - (_loc29_ & 16711680);
                     _loc36_ = _loc35_ >> 31;
                     _loc31_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc35_ = (_loc27_ & 16711680) + (_loc28_ & 16711680) - (_loc29_ << 1 & 33423360);
                     _loc36_ = _loc35_ >> 31;
                     _loc32_ = _loc35_ + _loc36_ ^ _loc36_;
                     _loc33_ |= (_loc31_ - _loc30_ | _loc32_ - _loc30_) >> 31 & 16711680;
                     _loc34_ |= _loc32_ - _loc31_ >> 31 & 16711680;
                     _loc25_ = _loc27_ & ~_loc33_ | _loc28_ & _loc33_ & ~_loc34_ | _loc29_ & _loc33_ & _loc34_;
                     _loc26_ = (_loc20_ & -16711936 | 65536) - (_loc25_ & -16711936) & -16711936 | (_loc20_ & 16711935 | 16777472) - (_loc25_ & 16711935) & 16711935;
                     si32(_loc26_,_loc18_);
                     _loc18_ += 3;
                     _loc16_ += 4;
                  }
                  _loc16_--;
               }
            }
         }
         param4.fastWrite(_loc17_,uint(_loc17_ + _loc12_));
         var _loc38_:* = param3 == param1.height;
         if(_loc38_)
         {
            _loc39_ = param4.fastFinalize();
         }
         else
         {
            _loc39_ = param4.peek();
         }
         _loc23_ = _loc39_.end - _loc39_.offset;
         _loc24_ = int(_loc23_);
         param5.writeUnsignedInt(_loc24_);
         param5.writeUnsignedInt(1229209940);
         if(_loc24_ != 0)
         {
            PNGEncoder2Impl.data.position = 6600;
            PNGEncoder2Impl.data.readBytes(param5,param5.position,_loc23_);
            param5.position += _loc24_;
         }
         _loc26_ = -1;
         _loc26_ = li32(((_loc26_ ^ 73) & 255) << 2) ^ _loc26_ >>> 8;
         _loc26_ = li32(((_loc26_ ^ 68) & 255) << 2) ^ _loc26_ >>> 8;
         _loc26_ = li32(((_loc26_ ^ 65) & 255) << 2) ^ _loc26_ >>> 8;
         _loc26_ = li32(((_loc26_ ^ 84) & 255) << 2) ^ _loc26_ >>> 8;
         if(_loc24_ != 0)
         {
            _loc27_ = 6600;
            _loc28_ = 6600 + _loc24_;
            _loc29_ = 6600 + (_loc24_ & -16);
            while(_loc27_ < _loc29_)
            {
               _loc30_ = _loc26_ ^ li8(_loc27_);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 1);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 2);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 3);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 4);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 5);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 6);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 7);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 8);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 9);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 10);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 11);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 12);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 13);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 14);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc30_ = _loc26_ ^ li8(_loc27_ + 15);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc27_ += 16;
            }
            while(_loc27_ < _loc28_)
            {
               _loc30_ = _loc26_ ^ li8(_loc27_);
               _loc26_ = li32((_loc30_ & 255) << 2) ^ _loc26_ >>> 8;
               _loc27_++;
            }
         }
         _loc26_ ^= -1;
         param5.writeUnsignedInt(_loc26_);
         if(!_loc38_)
         {
            param4.release();
         }
      }
      
      public static function rotr8(param1:int) : int
      {
         return param1 >>> 8 | param1 << 24;
      }
      
      public static function byteSub4(param1:uint, param2:uint) : int
      {
         return (param1 & -16711936 | 65536) - (param2 & -16711936) & -16711936 | (param1 & 16711935 | 16777472) - (param2 & 16711935) & 16711935;
      }
      
      public static function paethPredictor4(param1:int, param2:int, param3:int) : int
      {
         var _loc5_:* = (param2 & 255) - (param3 & 255);
         var _loc6_:* = _loc5_ >> 31;
         var _loc4_:* = _loc5_ + _loc6_ ^ _loc6_;
         _loc6_ = (param1 & 255) - (param3 & 255);
         var _loc7_:* = _loc6_ >> 31;
         _loc5_ = _loc6_ + _loc7_ ^ _loc7_;
         _loc7_ = (param1 & 255) + (param2 & 255) - (param3 << 1 & 510);
         var _loc8_:* = _loc7_ >> 31;
         _loc6_ = _loc7_ + _loc8_ ^ _loc8_;
         _loc7_ = (_loc5_ - _loc4_ | _loc6_ - _loc4_) >> 31 & 255;
         _loc8_ = _loc6_ - _loc5_ >> 31 & 255;
         var _loc9_:* = (param2 & 65280) - (param3 & 65280);
         var _loc10_:* = _loc9_ >> 31;
         _loc4_ = _loc9_ + _loc10_ ^ _loc10_;
         _loc9_ = (param1 & 65280) - (param3 & 65280);
         _loc10_ = _loc9_ >> 31;
         _loc5_ = _loc9_ + _loc10_ ^ _loc10_;
         _loc9_ = (param1 & 65280) + (param2 & 65280) - (param3 << 1 & 130560);
         _loc10_ = _loc9_ >> 31;
         _loc6_ = _loc9_ + _loc10_ ^ _loc10_;
         _loc7_ |= (_loc5_ - _loc4_ | _loc6_ - _loc4_) >> 31 & 65280;
         _loc8_ |= _loc6_ - _loc5_ >> 31 & 65280;
         _loc9_ = (param2 & 16711680) - (param3 & 16711680);
         _loc10_ = _loc9_ >> 31;
         _loc4_ = _loc9_ + _loc10_ ^ _loc10_;
         _loc9_ = (param1 & 16711680) - (param3 & 16711680);
         _loc10_ = _loc9_ >> 31;
         _loc5_ = _loc9_ + _loc10_ ^ _loc10_;
         _loc9_ = (param1 & 16711680) + (param2 & 16711680) - (param3 << 1 & 33423360);
         _loc10_ = _loc9_ >> 31;
         _loc6_ = _loc9_ + _loc10_ ^ _loc10_;
         _loc7_ |= (_loc5_ - _loc4_ | _loc6_ - _loc4_) >> 31 & 16711680;
         _loc8_ |= _loc6_ - _loc5_ >> 31 & 16711680;
         _loc9_ = (param2 >> 8 & 16711680) - (param3 >> 8 & 16711680);
         _loc10_ = _loc9_ >> 31;
         _loc4_ = _loc9_ + _loc10_ ^ _loc10_;
         _loc9_ = (param1 >> 8 & 16711680) - (param3 >> 8 & 16711680);
         _loc10_ = _loc9_ >> 31;
         _loc5_ = _loc9_ + _loc10_ ^ _loc10_;
         _loc9_ = (param1 >> 8 & 16711680) + (param2 >> 8 & 16711680) - (param3 >> 7 & 33423360);
         _loc10_ = _loc9_ >> 31;
         _loc6_ = _loc9_ + _loc10_ ^ _loc10_;
         _loc7_ |= (_loc5_ - _loc4_ | _loc6_ - _loc4_) >> 31 & -16777216;
         _loc8_ |= _loc6_ - _loc5_ >> 31 & -16777216;
         return param1 & ~_loc7_ | param2 & _loc7_ & ~_loc8_ | param3 & _loc7_ & _loc8_;
      }
      
      public static function paethPredictor3Lo(param1:int, param2:int, param3:int) : int
      {
         var _loc5_:* = (param2 & 255) - (param3 & 255);
         var _loc6_:* = _loc5_ >> 31;
         var _loc4_:* = _loc5_ + _loc6_ ^ _loc6_;
         _loc6_ = (param1 & 255) - (param3 & 255);
         var _loc7_:* = _loc6_ >> 31;
         _loc5_ = _loc6_ + _loc7_ ^ _loc7_;
         _loc7_ = (param1 & 255) + (param2 & 255) - (param3 << 1 & 510);
         var _loc8_:* = _loc7_ >> 31;
         _loc6_ = _loc7_ + _loc8_ ^ _loc8_;
         _loc7_ = (_loc5_ - _loc4_ | _loc6_ - _loc4_) >> 31 & 255;
         _loc8_ = _loc6_ - _loc5_ >> 31 & 255;
         var _loc9_:* = (param2 & 65280) - (param3 & 65280);
         var _loc10_:* = _loc9_ >> 31;
         _loc4_ = _loc9_ + _loc10_ ^ _loc10_;
         _loc9_ = (param1 & 65280) - (param3 & 65280);
         _loc10_ = _loc9_ >> 31;
         _loc5_ = _loc9_ + _loc10_ ^ _loc10_;
         _loc9_ = (param1 & 65280) + (param2 & 65280) - (param3 << 1 & 130560);
         _loc10_ = _loc9_ >> 31;
         _loc6_ = _loc9_ + _loc10_ ^ _loc10_;
         _loc7_ |= (_loc5_ - _loc4_ | _loc6_ - _loc4_) >> 31 & 65280;
         _loc8_ |= _loc6_ - _loc5_ >> 31 & 65280;
         _loc9_ = (param2 & 16711680) - (param3 & 16711680);
         _loc10_ = _loc9_ >> 31;
         _loc4_ = _loc9_ + _loc10_ ^ _loc10_;
         _loc9_ = (param1 & 16711680) - (param3 & 16711680);
         _loc10_ = _loc9_ >> 31;
         _loc5_ = _loc9_ + _loc10_ ^ _loc10_;
         _loc9_ = (param1 & 16711680) + (param2 & 16711680) - (param3 << 1 & 33423360);
         _loc10_ = _loc9_ >> 31;
         _loc6_ = _loc9_ + _loc10_ ^ _loc10_;
         _loc7_ |= (_loc5_ - _loc4_ | _loc6_ - _loc4_) >> 31 & 16711680;
         _loc8_ |= _loc6_ - _loc5_ >> 31 & 16711680;
         return param1 & ~_loc7_ | param2 & _loc7_ & ~_loc8_ | param3 & _loc7_ & _loc8_;
      }
      
      public static function abs(param1:int) : int
      {
         var _loc2_:* = param1 >> 31;
         return param1 + _loc2_ ^ _loc2_;
      }
      
      public static function writeIENDChunk(param1:ByteArray) : void
      {
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc2_:int = 0;
         param1.writeUnsignedInt(_loc2_);
         param1.writeUnsignedInt(1229278788);
         if(_loc2_ != 0)
         {
            PNGEncoder2Impl.data.position = 6600;
            PNGEncoder2Impl.data.readBytes(param1,param1.position,0);
            param1.position += _loc2_;
         }
         var _loc3_:* = -1;
         _loc3_ = li32(((_loc3_ ^ 73) & 255) << 2) ^ _loc3_ >>> 8;
         _loc3_ = li32(((_loc3_ ^ 69) & 255) << 2) ^ _loc3_ >>> 8;
         _loc3_ = li32(((_loc3_ ^ 78) & 255) << 2) ^ _loc3_ >>> 8;
         _loc3_ = li32(((_loc3_ ^ 68) & 255) << 2) ^ _loc3_ >>> 8;
         if(_loc2_ != 0)
         {
            _loc4_ = 6600;
            _loc5_ = 6600 + _loc2_;
            _loc6_ = 6600 + (_loc2_ & -16);
            while(_loc4_ < _loc6_)
            {
               _loc7_ = _loc3_ ^ li8(_loc4_);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 1);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 2);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 3);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 4);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 5);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 6);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 7);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 8);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 9);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 10);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 11);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 12);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 13);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 14);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc7_ = _loc3_ ^ li8(_loc4_ + 15);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc4_ += 16;
            }
            while(_loc4_ < _loc5_)
            {
               _loc7_ = _loc3_ ^ li8(_loc4_);
               _loc3_ = li32((_loc7_ & 255) << 2) ^ _loc3_ >>> 8;
               _loc4_++;
            }
         }
         _loc3_ ^= -1;
         param1.writeUnsignedInt(_loc3_);
      }
      
      public static function writeChunk(param1:ByteArray, param2:int, param3:int) : void
      {
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc9_:* = 0;
         var _loc4_:int = param3;
         param1.writeUnsignedInt(_loc4_);
         param1.writeUnsignedInt(param2);
         if(_loc4_ != 0)
         {
            PNGEncoder2Impl.data.position = 6600;
            PNGEncoder2Impl.data.readBytes(param1,param1.position,param3);
            param1.position += _loc4_;
         }
         var _loc5_:* = -1;
         _loc5_ = li32(((_loc5_ ^ param2 >>> 24) & 255) << 2) ^ _loc5_ >>> 8;
         _loc5_ = li32(((_loc5_ ^ param2 >>> 16 & 255) & 255) << 2) ^ _loc5_ >>> 8;
         _loc5_ = li32(((_loc5_ ^ param2 >>> 8 & 255) & 255) << 2) ^ _loc5_ >>> 8;
         _loc5_ = li32(((_loc5_ ^ param2 & 255) & 255) << 2) ^ _loc5_ >>> 8;
         if(_loc4_ != 0)
         {
            _loc6_ = 6600;
            _loc7_ = 6600 + _loc4_;
            _loc8_ = 6600 + (_loc4_ & -16);
            while(_loc6_ < _loc8_)
            {
               _loc9_ = _loc5_ ^ li8(_loc6_);
               _loc5_ = li32((_loc9_ & 255) << 2) ^ _loc5_ >>> 8;
               _loc9_ = _loc5_ ^ li8(_loc6_ + 1);
               _loc5_ = li32((_loc9_ & 255) << 2) ^ _loc5_ >>> 8;
               _loc9_ = _loc5_ ^ li8(_loc6_ + 2);
               _loc5_ = li32((_loc9_ & 255) << 2) ^ _loc5_ >>> 8;
               _loc9_ = _loc5_ ^ li8(_loc6_ + 3);
               _loc5_ = li32((_loc9_ & 255) << 2) ^ _loc5_ >>> 8;
               _loc9_ = _loc5_ ^ li8(_loc6_ + 4);
               _loc5_ = li32((_loc9_ & 255) << 2) ^ _loc5_ >>> 8;
               _loc9_ = _loc5_ ^ li8(_loc6_ + 5);
               _loc5_ = li32((_loc9_ & 255) << 2) ^ _loc5_ >>> 8;
               _loc9_ = _loc5_ ^ li8(_loc6_ + 6);
               _loc5_ = li32((_loc9_ & 255) << 2) ^ _loc5_ >>> 8;
               _loc9_ = _loc5_ ^ li8(_loc6_ + 7);
               _loc5_ = li32((_loc9_ & 255) << 2) ^ _loc5_ >>> 8;
               _loc9_ = _loc5_ ^ li8(_loc6_ + 8);
               _loc5_ = li32((_loc9_ & 255) << 2) ^ _loc5_ >>> 8;
               _loc9_ = _loc5_ ^ li8(_loc6_ + 9);
               _loc5_ = li32((_loc9_ & 255) << 2) ^ _loc5_ >>> 8;
               _loc9_ = _loc5_ ^ li8(_loc6_ + 10);
               _loc5_ = li32((_loc9_ & 255) << 2) ^ _loc5_ >>> 8;
               _loc9_ = _loc5_ ^ li8(_loc6_ + 11);
               _loc5_ = li32((_loc9_ & 255) << 2) ^ _loc5_ >>> 8;
               _loc9_ = _loc5_ ^ li8(_loc6_ + 12);
               _loc5_ = li32((_loc9_ & 255) << 2) ^ _loc5_ >>> 8;
               _loc9_ = _loc5_ ^ li8(_loc6_ + 13);
               _loc5_ = li32((_loc9_ & 255) << 2) ^ _loc5_ >>> 8;
               _loc9_ = _loc5_ ^ li8(_loc6_ + 14);
               _loc5_ = li32((_loc9_ & 255) << 2) ^ _loc5_ >>> 8;
               _loc9_ = _loc5_ ^ li8(_loc6_ + 15);
               _loc5_ = li32((_loc9_ & 255) << 2) ^ _loc5_ >>> 8;
               _loc6_ += 16;
            }
            while(_loc6_ < _loc7_)
            {
               _loc9_ = _loc5_ ^ li8(_loc6_);
               _loc5_ = li32((_loc9_ & 255) << 2) ^ _loc5_ >>> 8;
               _loc6_++;
            }
         }
         _loc5_ ^= -1;
         param1.writeUnsignedInt(_loc5_);
      }
      
      public static function initialize() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:uint = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(!PNGEncoder2Impl.crcComputed)
         {
            PNGEncoder2Impl.region = new Rectangle(0,0,1,1);
            PNGEncoder2Impl.sprite = new Sprite();
            PNGEncoder2Impl.data = new ByteArray();
            _loc1_ = Number(Math.max(6600,ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH));
            PNGEncoder2Impl.data.length = int(_loc1_);
         }
         ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
         if(!PNGEncoder2Impl.crcComputed)
         {
            _loc3_ = 0;
            while(_loc3_ < 256)
            {
               _loc4_ = _loc3_++;
               _loc2_ = _loc4_;
               if((_loc2_ & 1) == 1)
               {
                  _loc2_ = -306674912 ^ _loc2_ >>> 1;
               }
               else
               {
                  _loc2_ >>>= 1;
               }
               if((_loc2_ & 1) == 1)
               {
                  _loc2_ = -306674912 ^ _loc2_ >>> 1;
               }
               else
               {
                  _loc2_ >>>= 1;
               }
               if((_loc2_ & 1) == 1)
               {
                  _loc2_ = -306674912 ^ _loc2_ >>> 1;
               }
               else
               {
                  _loc2_ >>>= 1;
               }
               if((_loc2_ & 1) == 1)
               {
                  _loc2_ = -306674912 ^ _loc2_ >>> 1;
               }
               else
               {
                  _loc2_ >>>= 1;
               }
               if((_loc2_ & 1) == 1)
               {
                  _loc2_ = -306674912 ^ _loc2_ >>> 1;
               }
               else
               {
                  _loc2_ >>>= 1;
               }
               if((_loc2_ & 1) == 1)
               {
                  _loc2_ = -306674912 ^ _loc2_ >>> 1;
               }
               else
               {
                  _loc2_ >>>= 1;
               }
               if((_loc2_ & 1) == 1)
               {
                  _loc2_ = -306674912 ^ _loc2_ >>> 1;
               }
               else
               {
                  _loc2_ >>>= 1;
               }
               if((_loc2_ & 1) == 1)
               {
                  _loc2_ = -306674912 ^ _loc2_ >>> 1;
               }
               else
               {
                  _loc2_ >>>= 1;
               }
               si32(_loc2_,_loc4_ << 2);
            }
            PNGEncoder2Impl.crcComputed = true;
         }
      }
      
      public static function crcTable(param1:int) : int
      {
         return li32((param1 & 255) << 2);
      }
      
      public static function freeCachedMemory() : void
      {
         if(PNGEncoder2Impl.encoding)
         {
            throw new Error("Cached resources cannot be freed while an image is being encoded");
         }
         if(PNGEncoder2Impl.crcComputed)
         {
            if(ApplicationDomain.currentDomain.domainMemory == PNGEncoder2Impl.data)
            {
               ApplicationDomain.currentDomain.domainMemory = null;
            }
            PNGEncoder2Impl.region = null;
            PNGEncoder2Impl.sprite = null;
            PNGEncoder2Impl.data = null;
            PNGEncoder2Impl.crcComputed = false;
         }
      }
      
      public function updateUpdatesPerFrame(param1:int) : void
      {
         updatesPerFrame[updatesPerFrameIndex] = param1;
         updatesPerFrameIndex = updatesPerFrameIndex + 1 & 3;
      }
      
      public function updateStep() : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null as Vector.<int>;
         var _loc5_:int = 0;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:* = null as Vector.<Number>;
         var _loc10_:Number = NaN;
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         _loc3_ = 0;
         _loc4_ = msPerFrame;
         while(_loc3_ < int(_loc4_.length))
         {
            _loc5_ = _loc4_[_loc3_];
            _loc3_++;
            if(_loc5_ > 0)
            {
               _loc1_ += _loc5_;
               _loc2_++;
            }
         }
         if(_loc2_ != 0)
         {
            _loc1_ /= _loc2_;
            _loc6_ = 1000 / targetFPS;
            if(_loc1_ > _loc6_ * 1.15)
            {
               _loc6_ -= _loc1_ - _loc6_;
            }
            _loc7_ = 0;
            _loc2_ = 0;
            _loc3_ = 0;
            _loc4_ = updatesPerFrame;
            while(_loc3_ < int(_loc4_.length))
            {
               _loc5_ = _loc4_[_loc3_];
               _loc3_++;
               if(_loc5_ > 0)
               {
                  _loc7_ += _loc5_;
                  _loc2_++;
               }
            }
            if(_loc2_ != 0)
            {
               _loc7_ /= _loc2_;
               _loc8_ = 0;
               _loc2_ = 0;
               _loc3_ = 0;
               _loc9_ = msPerLine;
               while(_loc3_ < int(_loc9_.length))
               {
                  _loc10_ = Number(_loc9_[_loc3_]);
                  _loc3_++;
                  if(_loc10_ > 0)
                  {
                     _loc8_ += _loc10_;
                     _loc2_++;
                  }
               }
               if(_loc2_ != 0)
               {
                  _loc8_ /= _loc2_;
                  step = int(Math.ceil(Number(Math.max(_loc6_ / _loc8_ / _loc7_,20480 / img.width))));
               }
               else
               {
                  step = int(Math.ceil(20480 / img.width));
               }
            }
            else
            {
               step = int(Math.ceil(20480 / img.width));
            }
         }
         else
         {
            step = int(Math.ceil(20480 / img.width));
         }
      }
      
      public function updateMsPerLine(param1:int, param2:int) : void
      {
         if(param2 != 0)
         {
            if(param1 <= 0)
            {
               param1 = 5;
            }
            msPerLine[msPerLineIndex] = param1 * 1 / param2;
            msPerLineIndex = msPerLineIndex + 1 & 3;
         }
      }
      
      public function updateMsPerFrame(param1:int) : void
      {
         msPerFrame[msPerFrameIndex] = param1;
         msPerFrameIndex = msPerFrameIndex + 1 & 3;
      }
      
      public function updateFrameInfo() : void
      {
         var _loc1_:int = 0;
         if(!done)
         {
            frameCount = frameCount + 1;
            _loc1_ = getTimer();
            msPerFrame[msPerFrameIndex] = _loc1_ - lastFrameStart;
            msPerFrameIndex = msPerFrameIndex + 1 & 3;
            lastFrameStart = _loc1_;
            updatesPerFrame[updatesPerFrameIndex] = updates;
            updatesPerFrameIndex = updatesPerFrameIndex + 1 & 3;
            updates = 0;
         }
      }
      
      public function update() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null as ByteArray;
         var _loc3_:* = null as ProgressEvent;
         var _loc4_:* = null as Event;
         var _loc5_:int = 0;
         var _loc6_:* = 0;
         var _loc7_:* = null as Event;
         var _loc8_:* = null as ByteArray;
         var _loc9_:int = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc15_:Number = NaN;
         var _loc16_:* = 0;
         var _loc17_:* = 0;
         var _loc18_:* = null as Vector.<int>;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:* = null as Vector.<Number>;
         var _loc23_:Number = NaN;
         var _loc24_:* = null as PNGEncoder2Impl;
         if(!done)
         {
            _loc1_ = getTimer();
            updates = updates + 1;
            _loc2_ = ApplicationDomain.currentDomain.domainMemory;
            ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
            _loc3_ = null;
            _loc4_ = null;
            if(img.transparent)
            {
               _loc5_ = 4;
            }
            else
            {
               _loc5_ = 3;
            }
            _loc6_ = _loc5_ * img.width * img.height;
            if(currentY >= img.height)
            {
               _loc3_ = new ProgressEvent(ProgressEvent.PROGRESS,false,false,_loc6_,_loc6_);
               _loc7_ = null;
               if(currentY >= img.height)
               {
                  done = true;
                  PNGEncoder2Impl.sprite.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
                  _loc8_ = png#3;
                  _loc9_ = 0;
                  _loc8_.writeUnsignedInt(_loc9_);
                  _loc8_.writeUnsignedInt(1229278788);
                  if(_loc9_ != 0)
                  {
                     PNGEncoder2Impl.data.position = 6600;
                     PNGEncoder2Impl.data.readBytes(_loc8_,_loc8_.position,0);
                     _loc8_.position += _loc9_;
                  }
                  _loc10_ = -1;
                  _loc10_ = li32(((_loc10_ ^ 73) & 255) << 2) ^ _loc10_ >>> 8;
                  _loc10_ = li32(((_loc10_ ^ 69) & 255) << 2) ^ _loc10_ >>> 8;
                  _loc10_ = li32(((_loc10_ ^ 78) & 255) << 2) ^ _loc10_ >>> 8;
                  _loc10_ = li32(((_loc10_ ^ 68) & 255) << 2) ^ _loc10_ >>> 8;
                  if(_loc9_ != 0)
                  {
                     _loc11_ = 6600;
                     _loc12_ = 6600 + _loc9_;
                     _loc13_ = 6600 + (_loc9_ & -16);
                     while(_loc11_ < _loc13_)
                     {
                        _loc14_ = _loc10_ ^ li8(_loc11_);
                        _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
                        _loc14_ = _loc10_ ^ li8(_loc11_ + 1);
                        _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
                        _loc14_ = _loc10_ ^ li8(_loc11_ + 2);
                        _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
                        _loc14_ = _loc10_ ^ li8(_loc11_ + 3);
                        _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
                        _loc14_ = _loc10_ ^ li8(_loc11_ + 4);
                        _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
                        _loc14_ = _loc10_ ^ li8(_loc11_ + 5);
                        _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
                        _loc14_ = _loc10_ ^ li8(_loc11_ + 6);
                        _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
                        _loc14_ = _loc10_ ^ li8(_loc11_ + 7);
                        _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
                        _loc14_ = _loc10_ ^ li8(_loc11_ + 8);
                        _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
                        _loc14_ = _loc10_ ^ li8(_loc11_ + 9);
                        _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
                        _loc14_ = _loc10_ ^ li8(_loc11_ + 10);
                        _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
                        _loc14_ = _loc10_ ^ li8(_loc11_ + 11);
                        _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
                        _loc14_ = _loc10_ ^ li8(_loc11_ + 12);
                        _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
                        _loc14_ = _loc10_ ^ li8(_loc11_ + 13);
                        _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
                        _loc14_ = _loc10_ ^ li8(_loc11_ + 14);
                        _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
                        _loc14_ = _loc10_ ^ li8(_loc11_ + 15);
                        _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
                        _loc11_ += 16;
                     }
                     while(_loc11_ < _loc12_)
                     {
                        _loc14_ = _loc10_ ^ li8(_loc11_);
                        _loc10_ = li32((_loc14_ & 255) << 2) ^ _loc10_ >>> 8;
                        _loc11_++;
                     }
                  }
                  _loc10_ ^= -1;
                  _loc8_.writeUnsignedInt(_loc10_);
                  PNGEncoder2Impl.encoding = false;
                  _loc8_.position = 0;
                  _loc7_ = new Event(Event.COMPLETE);
               }
               _loc4_ = _loc7_;
            }
            else
            {
               _loc15_ = Number(Math.min(currentY + step,img.height));
               _loc9_ = _loc15_;
               PNGEncoder2Impl.writeIDATChunk(img,currentY,_loc9_,deflateStream,png#3);
               currentY = _loc9_;
               _loc10_ = _loc5_ * img.width * currentY;
               _loc3_ = new ProgressEvent(ProgressEvent.PROGRESS,false,false,_loc10_,_loc6_);
               _loc7_ = null;
               if(currentY >= img.height)
               {
                  done = true;
                  PNGEncoder2Impl.sprite.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
                  _loc8_ = png#3;
                  _loc11_ = 0;
                  _loc8_.writeUnsignedInt(_loc11_);
                  _loc8_.writeUnsignedInt(1229278788);
                  if(_loc11_ != 0)
                  {
                     PNGEncoder2Impl.data.position = 6600;
                     PNGEncoder2Impl.data.readBytes(_loc8_,_loc8_.position,0);
                     _loc8_.position += _loc11_;
                  }
                  _loc12_ = -1;
                  _loc12_ = li32(((_loc12_ ^ 73) & 255) << 2) ^ _loc12_ >>> 8;
                  _loc12_ = li32(((_loc12_ ^ 69) & 255) << 2) ^ _loc12_ >>> 8;
                  _loc12_ = li32(((_loc12_ ^ 78) & 255) << 2) ^ _loc12_ >>> 8;
                  _loc12_ = li32(((_loc12_ ^ 68) & 255) << 2) ^ _loc12_ >>> 8;
                  if(_loc11_ != 0)
                  {
                     _loc13_ = 6600;
                     _loc14_ = 6600 + _loc11_;
                     _loc16_ = 6600 + (_loc11_ & -16);
                     while(_loc13_ < _loc16_)
                     {
                        _loc17_ = _loc12_ ^ li8(_loc13_);
                        _loc12_ = li32((_loc17_ & 255) << 2) ^ _loc12_ >>> 8;
                        _loc17_ = _loc12_ ^ li8(_loc13_ + 1);
                        _loc12_ = li32((_loc17_ & 255) << 2) ^ _loc12_ >>> 8;
                        _loc17_ = _loc12_ ^ li8(_loc13_ + 2);
                        _loc12_ = li32((_loc17_ & 255) << 2) ^ _loc12_ >>> 8;
                        _loc17_ = _loc12_ ^ li8(_loc13_ + 3);
                        _loc12_ = li32((_loc17_ & 255) << 2) ^ _loc12_ >>> 8;
                        _loc17_ = _loc12_ ^ li8(_loc13_ + 4);
                        _loc12_ = li32((_loc17_ & 255) << 2) ^ _loc12_ >>> 8;
                        _loc17_ = _loc12_ ^ li8(_loc13_ + 5);
                        _loc12_ = li32((_loc17_ & 255) << 2) ^ _loc12_ >>> 8;
                        _loc17_ = _loc12_ ^ li8(_loc13_ + 6);
                        _loc12_ = li32((_loc17_ & 255) << 2) ^ _loc12_ >>> 8;
                        _loc17_ = _loc12_ ^ li8(_loc13_ + 7);
                        _loc12_ = li32((_loc17_ & 255) << 2) ^ _loc12_ >>> 8;
                        _loc17_ = _loc12_ ^ li8(_loc13_ + 8);
                        _loc12_ = li32((_loc17_ & 255) << 2) ^ _loc12_ >>> 8;
                        _loc17_ = _loc12_ ^ li8(_loc13_ + 9);
                        _loc12_ = li32((_loc17_ & 255) << 2) ^ _loc12_ >>> 8;
                        _loc17_ = _loc12_ ^ li8(_loc13_ + 10);
                        _loc12_ = li32((_loc17_ & 255) << 2) ^ _loc12_ >>> 8;
                        _loc17_ = _loc12_ ^ li8(_loc13_ + 11);
                        _loc12_ = li32((_loc17_ & 255) << 2) ^ _loc12_ >>> 8;
                        _loc17_ = _loc12_ ^ li8(_loc13_ + 12);
                        _loc12_ = li32((_loc17_ & 255) << 2) ^ _loc12_ >>> 8;
                        _loc17_ = _loc12_ ^ li8(_loc13_ + 13);
                        _loc12_ = li32((_loc17_ & 255) << 2) ^ _loc12_ >>> 8;
                        _loc17_ = _loc12_ ^ li8(_loc13_ + 14);
                        _loc12_ = li32((_loc17_ & 255) << 2) ^ _loc12_ >>> 8;
                        _loc17_ = _loc12_ ^ li8(_loc13_ + 15);
                        _loc12_ = li32((_loc17_ & 255) << 2) ^ _loc12_ >>> 8;
                        _loc13_ += 16;
                     }
                     while(_loc13_ < _loc14_)
                     {
                        _loc17_ = _loc12_ ^ li8(_loc13_);
                        _loc12_ = li32((_loc17_ & 255) << 2) ^ _loc12_ >>> 8;
                        _loc13_++;
                     }
                  }
                  _loc12_ ^= -1;
                  _loc8_.writeUnsignedInt(_loc12_);
                  PNGEncoder2Impl.encoding = false;
                  _loc8_.position = 0;
                  _loc7_ = new Event(Event.COMPLETE);
               }
               _loc4_ = _loc7_;
               _loc11_ = getTimer() - _loc1_;
               _loc12_ = int(step);
               if(_loc12_ != 0)
               {
                  if(_loc11_ <= 0)
                  {
                     _loc11_ = 5;
                  }
                  msPerLine[msPerLineIndex] = _loc11_ * 1 / _loc12_;
                  msPerLineIndex = msPerLineIndex + 1 & 3;
               }
               _loc15_ = 0;
               _loc11_ = 0;
               _loc12_ = 0;
               _loc18_ = msPerFrame;
               while(_loc12_ < int(_loc18_.length))
               {
                  _loc13_ = int(_loc18_[_loc12_]);
                  _loc12_++;
                  if(_loc13_ > 0)
                  {
                     _loc15_ += _loc13_;
                     _loc11_++;
                  }
               }
               if(_loc11_ != 0)
               {
                  _loc15_ /= _loc11_;
                  _loc19_ = 1000 / targetFPS;
                  if(_loc15_ > _loc19_ * 1.15)
                  {
                     _loc19_ -= _loc15_ - _loc19_;
                  }
                  _loc20_ = 0;
                  _loc11_ = 0;
                  _loc12_ = 0;
                  _loc18_ = updatesPerFrame;
                  while(_loc12_ < int(_loc18_.length))
                  {
                     _loc13_ = int(_loc18_[_loc12_]);
                     _loc12_++;
                     if(_loc13_ > 0)
                     {
                        _loc20_ += _loc13_;
                        _loc11_++;
                     }
                  }
                  if(_loc11_ != 0)
                  {
                     _loc20_ /= _loc11_;
                     _loc21_ = 0;
                     _loc11_ = 0;
                     _loc12_ = 0;
                     _loc22_ = msPerLine;
                     while(_loc12_ < int(_loc22_.length))
                     {
                        _loc23_ = Number(_loc22_[_loc12_]);
                        _loc12_++;
                        if(_loc23_ > 0)
                        {
                           _loc21_ += _loc23_;
                           _loc11_++;
                        }
                     }
                     if(_loc11_ != 0)
                     {
                        _loc21_ /= _loc11_;
                        step = int(Math.ceil(Number(Math.max(_loc19_ / _loc21_ / _loc20_,20480 / img.width))));
                     }
                     else
                     {
                        step = int(Math.ceil(20480 / img.width));
                     }
                  }
                  else
                  {
                     step = int(Math.ceil(20480 / img.width));
                  }
               }
               else
               {
                  step = int(Math.ceil(20480 / img.width));
               }
            }
            ApplicationDomain.currentDomain.domainMemory = _loc2_;
            if(_loc3_ != null)
            {
               dispatcher.dispatchEvent(_loc3_);
               _loc3_ = null;
            }
            if(_loc4_ != null)
            {
               dispatcher.dispatchEvent(_loc4_);
               _loc4_ = null;
            }
            if(done)
            {
               dispatcher = null;
               img = null;
               deflateStream = null;
               msPerFrame = null;
               msPerLine = null;
               updatesPerFrame = null;
               if(!PNGEncoder2Impl.encoding && int(PNGEncoder2Impl.pendingAsyncEncodings.length) > 0)
               {
                  _loc24_ = PNGEncoder2Impl.pendingAsyncEncodings.shift();
                  _loc24_._new(_loc24_.img,_loc24_.dispatcher,_loc24_.metadata);
               }
            }
         }
      }
      
      public function onEnterFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null as ByteArray;
         var _loc4_:* = null as ProgressEvent;
         var _loc5_:* = null as Event;
         var _loc6_:int = 0;
         var _loc7_:* = 0;
         var _loc8_:* = null as Event;
         var _loc9_:* = null as ByteArray;
         var _loc10_:int = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc15_:* = 0;
         var _loc16_:Number = NaN;
         var _loc17_:* = 0;
         var _loc18_:* = 0;
         var _loc19_:* = null as Vector.<int>;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:* = null as Vector.<Number>;
         var _loc24_:Number = NaN;
         var _loc25_:* = null as PNGEncoder2Impl;
         if(!done)
         {
            frameCount = frameCount + 1;
            _loc2_ = getTimer();
            msPerFrame[msPerFrameIndex] = _loc2_ - lastFrameStart;
            msPerFrameIndex = msPerFrameIndex + 1 & 3;
            lastFrameStart = _loc2_;
            updatesPerFrame[updatesPerFrameIndex] = updates;
            updatesPerFrameIndex = updatesPerFrameIndex + 1 & 3;
            updates = 0;
         }
         if(!done)
         {
            _loc2_ = getTimer();
            updates = updates + 1;
            _loc3_ = ApplicationDomain.currentDomain.domainMemory;
            ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
            _loc4_ = null;
            _loc5_ = null;
            if(img.transparent)
            {
               _loc6_ = 4;
            }
            else
            {
               _loc6_ = 3;
            }
            _loc7_ = _loc6_ * img.width * img.height;
            if(currentY >= img.height)
            {
               _loc4_ = new ProgressEvent(ProgressEvent.PROGRESS,false,false,_loc7_,_loc7_);
               _loc8_ = null;
               if(currentY >= img.height)
               {
                  done = true;
                  PNGEncoder2Impl.sprite.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
                  _loc9_ = png#3;
                  _loc10_ = 0;
                  _loc9_.writeUnsignedInt(_loc10_);
                  _loc9_.writeUnsignedInt(1229278788);
                  if(_loc10_ != 0)
                  {
                     PNGEncoder2Impl.data.position = 6600;
                     PNGEncoder2Impl.data.readBytes(_loc9_,_loc9_.position,0);
                     _loc9_.position += _loc10_;
                  }
                  _loc11_ = -1;
                  _loc11_ = li32(((_loc11_ ^ 73) & 255) << 2) ^ _loc11_ >>> 8;
                  _loc11_ = li32(((_loc11_ ^ 69) & 255) << 2) ^ _loc11_ >>> 8;
                  _loc11_ = li32(((_loc11_ ^ 78) & 255) << 2) ^ _loc11_ >>> 8;
                  _loc11_ = li32(((_loc11_ ^ 68) & 255) << 2) ^ _loc11_ >>> 8;
                  if(_loc10_ != 0)
                  {
                     _loc12_ = 6600;
                     _loc13_ = 6600 + _loc10_;
                     _loc14_ = 6600 + (_loc10_ & -16);
                     while(_loc12_ < _loc14_)
                     {
                        _loc15_ = _loc11_ ^ li8(_loc12_);
                        _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                        _loc15_ = _loc11_ ^ li8(_loc12_ + 1);
                        _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                        _loc15_ = _loc11_ ^ li8(_loc12_ + 2);
                        _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                        _loc15_ = _loc11_ ^ li8(_loc12_ + 3);
                        _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                        _loc15_ = _loc11_ ^ li8(_loc12_ + 4);
                        _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                        _loc15_ = _loc11_ ^ li8(_loc12_ + 5);
                        _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                        _loc15_ = _loc11_ ^ li8(_loc12_ + 6);
                        _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                        _loc15_ = _loc11_ ^ li8(_loc12_ + 7);
                        _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                        _loc15_ = _loc11_ ^ li8(_loc12_ + 8);
                        _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                        _loc15_ = _loc11_ ^ li8(_loc12_ + 9);
                        _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                        _loc15_ = _loc11_ ^ li8(_loc12_ + 10);
                        _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                        _loc15_ = _loc11_ ^ li8(_loc12_ + 11);
                        _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                        _loc15_ = _loc11_ ^ li8(_loc12_ + 12);
                        _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                        _loc15_ = _loc11_ ^ li8(_loc12_ + 13);
                        _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                        _loc15_ = _loc11_ ^ li8(_loc12_ + 14);
                        _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                        _loc15_ = _loc11_ ^ li8(_loc12_ + 15);
                        _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                        _loc12_ += 16;
                     }
                     while(_loc12_ < _loc13_)
                     {
                        _loc15_ = _loc11_ ^ li8(_loc12_);
                        _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                        _loc12_++;
                     }
                  }
                  _loc11_ ^= -1;
                  _loc9_.writeUnsignedInt(_loc11_);
                  PNGEncoder2Impl.encoding = false;
                  _loc9_.position = 0;
                  _loc8_ = new Event(Event.COMPLETE);
               }
               _loc5_ = _loc8_;
            }
            else
            {
               _loc16_ = Number(Math.min(currentY + step,img.height));
               _loc10_ = _loc16_;
               PNGEncoder2Impl.writeIDATChunk(img,currentY,_loc10_,deflateStream,png#3);
               currentY = _loc10_;
               _loc11_ = _loc6_ * img.width * currentY;
               _loc4_ = new ProgressEvent(ProgressEvent.PROGRESS,false,false,_loc11_,_loc7_);
               _loc8_ = null;
               if(currentY >= img.height)
               {
                  done = true;
                  PNGEncoder2Impl.sprite.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
                  _loc9_ = png#3;
                  _loc12_ = 0;
                  _loc9_.writeUnsignedInt(_loc12_);
                  _loc9_.writeUnsignedInt(1229278788);
                  if(_loc12_ != 0)
                  {
                     PNGEncoder2Impl.data.position = 6600;
                     PNGEncoder2Impl.data.readBytes(_loc9_,_loc9_.position,0);
                     _loc9_.position += _loc12_;
                  }
                  _loc13_ = -1;
                  _loc13_ = li32(((_loc13_ ^ 73) & 255) << 2) ^ _loc13_ >>> 8;
                  _loc13_ = li32(((_loc13_ ^ 69) & 255) << 2) ^ _loc13_ >>> 8;
                  _loc13_ = li32(((_loc13_ ^ 78) & 255) << 2) ^ _loc13_ >>> 8;
                  _loc13_ = li32(((_loc13_ ^ 68) & 255) << 2) ^ _loc13_ >>> 8;
                  if(_loc12_ != 0)
                  {
                     _loc14_ = 6600;
                     _loc15_ = 6600 + _loc12_;
                     _loc17_ = 6600 + (_loc12_ & -16);
                     while(_loc14_ < _loc17_)
                     {
                        _loc18_ = _loc13_ ^ li8(_loc14_);
                        _loc13_ = li32((_loc18_ & 255) << 2) ^ _loc13_ >>> 8;
                        _loc18_ = _loc13_ ^ li8(_loc14_ + 1);
                        _loc13_ = li32((_loc18_ & 255) << 2) ^ _loc13_ >>> 8;
                        _loc18_ = _loc13_ ^ li8(_loc14_ + 2);
                        _loc13_ = li32((_loc18_ & 255) << 2) ^ _loc13_ >>> 8;
                        _loc18_ = _loc13_ ^ li8(_loc14_ + 3);
                        _loc13_ = li32((_loc18_ & 255) << 2) ^ _loc13_ >>> 8;
                        _loc18_ = _loc13_ ^ li8(_loc14_ + 4);
                        _loc13_ = li32((_loc18_ & 255) << 2) ^ _loc13_ >>> 8;
                        _loc18_ = _loc13_ ^ li8(_loc14_ + 5);
                        _loc13_ = li32((_loc18_ & 255) << 2) ^ _loc13_ >>> 8;
                        _loc18_ = _loc13_ ^ li8(_loc14_ + 6);
                        _loc13_ = li32((_loc18_ & 255) << 2) ^ _loc13_ >>> 8;
                        _loc18_ = _loc13_ ^ li8(_loc14_ + 7);
                        _loc13_ = li32((_loc18_ & 255) << 2) ^ _loc13_ >>> 8;
                        _loc18_ = _loc13_ ^ li8(_loc14_ + 8);
                        _loc13_ = li32((_loc18_ & 255) << 2) ^ _loc13_ >>> 8;
                        _loc18_ = _loc13_ ^ li8(_loc14_ + 9);
                        _loc13_ = li32((_loc18_ & 255) << 2) ^ _loc13_ >>> 8;
                        _loc18_ = _loc13_ ^ li8(_loc14_ + 10);
                        _loc13_ = li32((_loc18_ & 255) << 2) ^ _loc13_ >>> 8;
                        _loc18_ = _loc13_ ^ li8(_loc14_ + 11);
                        _loc13_ = li32((_loc18_ & 255) << 2) ^ _loc13_ >>> 8;
                        _loc18_ = _loc13_ ^ li8(_loc14_ + 12);
                        _loc13_ = li32((_loc18_ & 255) << 2) ^ _loc13_ >>> 8;
                        _loc18_ = _loc13_ ^ li8(_loc14_ + 13);
                        _loc13_ = li32((_loc18_ & 255) << 2) ^ _loc13_ >>> 8;
                        _loc18_ = _loc13_ ^ li8(_loc14_ + 14);
                        _loc13_ = li32((_loc18_ & 255) << 2) ^ _loc13_ >>> 8;
                        _loc18_ = _loc13_ ^ li8(_loc14_ + 15);
                        _loc13_ = li32((_loc18_ & 255) << 2) ^ _loc13_ >>> 8;
                        _loc14_ += 16;
                     }
                     while(_loc14_ < _loc15_)
                     {
                        _loc18_ = _loc13_ ^ li8(_loc14_);
                        _loc13_ = li32((_loc18_ & 255) << 2) ^ _loc13_ >>> 8;
                        _loc14_++;
                     }
                  }
                  _loc13_ ^= -1;
                  _loc9_.writeUnsignedInt(_loc13_);
                  PNGEncoder2Impl.encoding = false;
                  _loc9_.position = 0;
                  _loc8_ = new Event(Event.COMPLETE);
               }
               _loc5_ = _loc8_;
               _loc12_ = getTimer() - _loc2_;
               _loc13_ = int(step);
               if(_loc13_ != 0)
               {
                  if(_loc12_ <= 0)
                  {
                     _loc12_ = 5;
                  }
                  msPerLine[msPerLineIndex] = _loc12_ * 1 / _loc13_;
                  msPerLineIndex = msPerLineIndex + 1 & 3;
               }
               _loc16_ = 0;
               _loc12_ = 0;
               _loc13_ = 0;
               _loc19_ = msPerFrame;
               while(_loc13_ < int(_loc19_.length))
               {
                  _loc14_ = int(_loc19_[_loc13_]);
                  _loc13_++;
                  if(_loc14_ > 0)
                  {
                     _loc16_ += _loc14_;
                     _loc12_++;
                  }
               }
               if(_loc12_ != 0)
               {
                  _loc16_ /= _loc12_;
                  _loc20_ = 1000 / targetFPS;
                  if(_loc16_ > _loc20_ * 1.15)
                  {
                     _loc20_ -= _loc16_ - _loc20_;
                  }
                  _loc21_ = 0;
                  _loc12_ = 0;
                  _loc13_ = 0;
                  _loc19_ = updatesPerFrame;
                  while(_loc13_ < int(_loc19_.length))
                  {
                     _loc14_ = int(_loc19_[_loc13_]);
                     _loc13_++;
                     if(_loc14_ > 0)
                     {
                        _loc21_ += _loc14_;
                        _loc12_++;
                     }
                  }
                  if(_loc12_ != 0)
                  {
                     _loc21_ /= _loc12_;
                     _loc22_ = 0;
                     _loc12_ = 0;
                     _loc13_ = 0;
                     _loc23_ = msPerLine;
                     while(_loc13_ < int(_loc23_.length))
                     {
                        _loc24_ = Number(_loc23_[_loc13_]);
                        _loc13_++;
                        if(_loc24_ > 0)
                        {
                           _loc22_ += _loc24_;
                           _loc12_++;
                        }
                     }
                     if(_loc12_ != 0)
                     {
                        _loc22_ /= _loc12_;
                        step = int(Math.ceil(Number(Math.max(_loc20_ / _loc22_ / _loc21_,20480 / img.width))));
                     }
                     else
                     {
                        step = int(Math.ceil(20480 / img.width));
                     }
                  }
                  else
                  {
                     step = int(Math.ceil(20480 / img.width));
                  }
               }
               else
               {
                  step = int(Math.ceil(20480 / img.width));
               }
            }
            ApplicationDomain.currentDomain.domainMemory = _loc3_;
            if(_loc4_ != null)
            {
               dispatcher.dispatchEvent(_loc4_);
               _loc4_ = null;
            }
            if(_loc5_ != null)
            {
               dispatcher.dispatchEvent(_loc5_);
               _loc5_ = null;
            }
            if(done)
            {
               dispatcher = null;
               img = null;
               deflateStream = null;
               msPerFrame = null;
               msPerLine = null;
               updatesPerFrame = null;
               if(!PNGEncoder2Impl.encoding && int(PNGEncoder2Impl.pendingAsyncEncodings.length) > 0)
               {
                  _loc25_ = PNGEncoder2Impl.pendingAsyncEncodings.shift();
                  _loc25_._new(_loc25_.img,_loc25_.dispatcher,_loc25_.metadata);
               }
            }
         }
      }
      
      public function finalize() : Event
      {
         var _loc2_:* = null as ByteArray;
         var _loc3_:int = 0;
         var _loc4_:* = 0;
         var _loc5_:* = 0;
         var _loc6_:* = 0;
         var _loc7_:* = 0;
         var _loc8_:* = 0;
         var _loc1_:Event = null;
         if(currentY >= img.height)
         {
            done = true;
            PNGEncoder2Impl.sprite.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
            _loc2_ = png#3;
            _loc3_ = 0;
            _loc2_.writeUnsignedInt(_loc3_);
            _loc2_.writeUnsignedInt(1229278788);
            if(_loc3_ != 0)
            {
               PNGEncoder2Impl.data.position = 6600;
               PNGEncoder2Impl.data.readBytes(_loc2_,_loc2_.position,0);
               _loc2_.position += _loc3_;
            }
            _loc4_ = -1;
            _loc4_ = li32(((_loc4_ ^ 73) & 255) << 2) ^ _loc4_ >>> 8;
            _loc4_ = li32(((_loc4_ ^ 69) & 255) << 2) ^ _loc4_ >>> 8;
            _loc4_ = li32(((_loc4_ ^ 78) & 255) << 2) ^ _loc4_ >>> 8;
            _loc4_ = li32(((_loc4_ ^ 68) & 255) << 2) ^ _loc4_ >>> 8;
            if(_loc3_ != 0)
            {
               _loc5_ = 6600;
               _loc6_ = 6600 + _loc3_;
               _loc7_ = 6600 + (_loc3_ & -16);
               while(_loc5_ < _loc7_)
               {
                  _loc8_ = _loc4_ ^ li8(_loc5_);
                  _loc4_ = li32((_loc8_ & 255) << 2) ^ _loc4_ >>> 8;
                  _loc8_ = _loc4_ ^ li8(_loc5_ + 1);
                  _loc4_ = li32((_loc8_ & 255) << 2) ^ _loc4_ >>> 8;
                  _loc8_ = _loc4_ ^ li8(_loc5_ + 2);
                  _loc4_ = li32((_loc8_ & 255) << 2) ^ _loc4_ >>> 8;
                  _loc8_ = _loc4_ ^ li8(_loc5_ + 3);
                  _loc4_ = li32((_loc8_ & 255) << 2) ^ _loc4_ >>> 8;
                  _loc8_ = _loc4_ ^ li8(_loc5_ + 4);
                  _loc4_ = li32((_loc8_ & 255) << 2) ^ _loc4_ >>> 8;
                  _loc8_ = _loc4_ ^ li8(_loc5_ + 5);
                  _loc4_ = li32((_loc8_ & 255) << 2) ^ _loc4_ >>> 8;
                  _loc8_ = _loc4_ ^ li8(_loc5_ + 6);
                  _loc4_ = li32((_loc8_ & 255) << 2) ^ _loc4_ >>> 8;
                  _loc8_ = _loc4_ ^ li8(_loc5_ + 7);
                  _loc4_ = li32((_loc8_ & 255) << 2) ^ _loc4_ >>> 8;
                  _loc8_ = _loc4_ ^ li8(_loc5_ + 8);
                  _loc4_ = li32((_loc8_ & 255) << 2) ^ _loc4_ >>> 8;
                  _loc8_ = _loc4_ ^ li8(_loc5_ + 9);
                  _loc4_ = li32((_loc8_ & 255) << 2) ^ _loc4_ >>> 8;
                  _loc8_ = _loc4_ ^ li8(_loc5_ + 10);
                  _loc4_ = li32((_loc8_ & 255) << 2) ^ _loc4_ >>> 8;
                  _loc8_ = _loc4_ ^ li8(_loc5_ + 11);
                  _loc4_ = li32((_loc8_ & 255) << 2) ^ _loc4_ >>> 8;
                  _loc8_ = _loc4_ ^ li8(_loc5_ + 12);
                  _loc4_ = li32((_loc8_ & 255) << 2) ^ _loc4_ >>> 8;
                  _loc8_ = _loc4_ ^ li8(_loc5_ + 13);
                  _loc4_ = li32((_loc8_ & 255) << 2) ^ _loc4_ >>> 8;
                  _loc8_ = _loc4_ ^ li8(_loc5_ + 14);
                  _loc4_ = li32((_loc8_ & 255) << 2) ^ _loc4_ >>> 8;
                  _loc8_ = _loc4_ ^ li8(_loc5_ + 15);
                  _loc4_ = li32((_loc8_ & 255) << 2) ^ _loc4_ >>> 8;
                  _loc5_ += 16;
               }
               while(_loc5_ < _loc6_)
               {
                  _loc8_ = _loc4_ ^ li8(_loc5_);
                  _loc4_ = li32((_loc8_ & 255) << 2) ^ _loc4_ >>> 8;
                  _loc5_++;
               }
            }
            _loc4_ ^= -1;
            _loc2_.writeUnsignedInt(_loc4_);
            PNGEncoder2Impl.encoding = false;
            _loc2_.position = 0;
            _loc1_ = new Event(Event.COMPLETE);
         }
         return _loc1_;
      }
      
      public function fastNew(param1:BitmapData, param2:IEventDispatcher, param3:*) : void
      {
         var _loc4_:* = null as ByteArray;
         var _loc5_:* = null as BitmapData;
         var _loc6_:Number = NaN;
         var _loc7_:uint = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:* = null as ByteArray;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc15_:* = 0;
         var _loc16_:Number = NaN;
         var _loc17_:* = null as Vector.<int>;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:* = null as Vector.<Number>;
         var _loc22_:Number = NaN;
         img = param1;
         dispatcher = param2;
         metadata = param3;
         if(PNGEncoder2Impl.encoding)
         {
            PNGEncoder2Impl.pendingAsyncEncodings.push(this);
         }
         else
         {
            lastFrameStart = getTimer();
            _loc4_ = ApplicationDomain.currentDomain.domainMemory;
            _loc5_ = img;
            if(PNGEncoder2Impl.encoding)
            {
               throw new Error("Only one PNG can be encoded at once (are you encoding asynchronously while attempting to encode another PNG synchronously?)");
            }
            PNGEncoder2Impl.encoding = true;
            if(PNGEncoder2Impl.level == null)
            {
               PNGEncoder2Impl.level = CompressionLevel.FAST;
            }
            if(!PNGEncoder2Impl.crcComputed)
            {
               PNGEncoder2Impl.region = new Rectangle(0,0,1,1);
               PNGEncoder2Impl.sprite = new Sprite();
               PNGEncoder2Impl.data = new ByteArray();
               _loc6_ = Number(Math.max(6600,ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH));
               PNGEncoder2Impl.data.length = int(_loc6_);
            }
            ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
            if(!PNGEncoder2Impl.crcComputed)
            {
               _loc8_ = 0;
               while(_loc8_ < 256)
               {
                  _loc9_ = _loc8_++;
                  _loc7_ = _loc9_;
                  if((_loc7_ & 1) == 1)
                  {
                     _loc7_ = -306674912 ^ _loc7_ >>> 1;
                  }
                  else
                  {
                     _loc7_ >>>= 1;
                  }
                  if((_loc7_ & 1) == 1)
                  {
                     _loc7_ = -306674912 ^ _loc7_ >>> 1;
                  }
                  else
                  {
                     _loc7_ >>>= 1;
                  }
                  if((_loc7_ & 1) == 1)
                  {
                     _loc7_ = -306674912 ^ _loc7_ >>> 1;
                  }
                  else
                  {
                     _loc7_ >>>= 1;
                  }
                  if((_loc7_ & 1) == 1)
                  {
                     _loc7_ = -306674912 ^ _loc7_ >>> 1;
                  }
                  else
                  {
                     _loc7_ >>>= 1;
                  }
                  if((_loc7_ & 1) == 1)
                  {
                     _loc7_ = -306674912 ^ _loc7_ >>> 1;
                  }
                  else
                  {
                     _loc7_ >>>= 1;
                  }
                  if((_loc7_ & 1) == 1)
                  {
                     _loc7_ = -306674912 ^ _loc7_ >>> 1;
                  }
                  else
                  {
                     _loc7_ >>>= 1;
                  }
                  if((_loc7_ & 1) == 1)
                  {
                     _loc7_ = -306674912 ^ _loc7_ >>> 1;
                  }
                  else
                  {
                     _loc7_ >>>= 1;
                  }
                  if((_loc7_ & 1) == 1)
                  {
                     _loc7_ = -306674912 ^ _loc7_ >>> 1;
                  }
                  else
                  {
                     _loc7_ >>>= 1;
                  }
                  si32(_loc7_,_loc9_ << 2);
               }
               PNGEncoder2Impl.crcComputed = true;
            }
            _loc10_ = new ByteArray();
            _loc10_.writeUnsignedInt(-1991225785);
            _loc10_.writeUnsignedInt(218765834);
            _loc8_ = 13;
            _loc6_ = Number(Math.max(6600 + _loc8_,ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH));
            PNGEncoder2Impl.data.length = int(_loc6_);
            ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
            _loc7_ = _loc5_.width;
            si8(_loc7_ >>> 24,6600);
            si8(_loc7_ >>> 16,6601);
            si8(_loc7_ >>> 8,6602);
            si8(_loc7_,6603);
            _loc7_ = _loc5_.height;
            si8(_loc7_ >>> 24,6604);
            si8(_loc7_ >>> 16,6605);
            si8(_loc7_ >>> 8,6606);
            si8(_loc7_,6607);
            si8(8,6608);
            if(_loc5_.transparent)
            {
               si8(6,6609);
            }
            else
            {
               si8(2,6609);
            }
            si8(0,6610);
            si8(0,6611);
            si8(0,6612);
            _loc9_ = _loc8_;
            _loc10_.writeUnsignedInt(_loc9_);
            _loc10_.writeUnsignedInt(1229472850);
            if(_loc9_ != 0)
            {
               PNGEncoder2Impl.data.position = 6600;
               PNGEncoder2Impl.data.readBytes(_loc10_,_loc10_.position,_loc8_);
               _loc10_.position += _loc9_;
            }
            _loc11_ = -1;
            _loc11_ = li32(((_loc11_ ^ 73) & 255) << 2) ^ _loc11_ >>> 8;
            _loc11_ = li32(((_loc11_ ^ 72) & 255) << 2) ^ _loc11_ >>> 8;
            _loc11_ = li32(((_loc11_ ^ 68) & 255) << 2) ^ _loc11_ >>> 8;
            _loc11_ = li32(((_loc11_ ^ 82) & 255) << 2) ^ _loc11_ >>> 8;
            if(_loc9_ != 0)
            {
               _loc12_ = 6600;
               _loc13_ = 6600 + _loc9_;
               _loc14_ = 6600 + (_loc9_ & -16);
               while(_loc12_ < _loc14_)
               {
                  _loc15_ = _loc11_ ^ li8(_loc12_);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 1);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 2);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 3);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 4);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 5);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 6);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 7);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 8);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 9);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 10);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 11);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 12);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 13);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 14);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 15);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc12_ += 16;
               }
               while(_loc12_ < _loc13_)
               {
                  _loc15_ = _loc11_ ^ li8(_loc12_);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc12_++;
               }
            }
            _loc11_ ^= -1;
            _loc10_.writeUnsignedInt(_loc11_);
            PNGEncoder2Impl.writeMetadataChunks(param3,_loc10_);
            png#3 = _loc10_;
            currentY = 0;
            frameCount = 0;
            done = false;
            msPerFrame = new Vector.<int>(4,true);
            msPerFrameIndex = 0;
            msPerLine = new Vector.<Number>(4,true);
            msPerLineIndex = 0;
            updatesPerFrame = new Vector.<int>(4,true);
            updatesPerFrameIndex = 0;
            deflateStream = DeflateStream.createEx(PNGEncoder2Impl.level,1024,6600,true);
            PNGEncoder2Impl.sprite.addEventListener(Event.ENTER_FRAME,onEnterFrame);
            if(img.width > 0 && img.height > 0)
            {
               _loc8_ = getTimer();
               _loc9_ = Math.ceil(Number(Math.min(20480 / img.width,img.height)));
               PNGEncoder2Impl.writeIDATChunk(img,0,_loc9_,deflateStream,png#3);
               _loc11_ = int(getTimer());
               _loc12_ = _loc11_ - _loc8_;
               if(_loc9_ != 0)
               {
                  if(_loc12_ <= 0)
                  {
                     _loc12_ = 5;
                  }
                  msPerLine[msPerLineIndex] = _loc12_ * 1 / _loc9_;
                  msPerLineIndex = msPerLineIndex + 1 & 3;
               }
               if(Lib.current == null || Lib.current.stage == null)
               {
                  _loc6_ = 24;
               }
               else
               {
                  _loc6_ = Lib.current.stage.frameRate;
               }
               _loc12_ = int(1 / _loc6_ * 1000);
               msPerFrame[msPerFrameIndex] = _loc12_;
               msPerFrameIndex = msPerFrameIndex + 1 & 3;
               updatesPerFrame[updatesPerFrameIndex] = 1;
               updatesPerFrameIndex = updatesPerFrameIndex + 1 & 3;
               _loc16_ = 0;
               _loc12_ = 0;
               _loc13_ = 0;
               _loc17_ = msPerFrame;
               while(_loc13_ < int(_loc17_.length))
               {
                  _loc14_ = int(_loc17_[_loc13_]);
                  _loc13_++;
                  if(_loc14_ > 0)
                  {
                     _loc16_ += _loc14_;
                     _loc12_++;
                  }
               }
               if(_loc12_ != 0)
               {
                  _loc16_ /= _loc12_;
                  _loc18_ = 1000 / targetFPS;
                  if(_loc16_ > _loc18_ * 1.15)
                  {
                     _loc18_ -= _loc16_ - _loc18_;
                  }
                  _loc19_ = 0;
                  _loc12_ = 0;
                  _loc13_ = 0;
                  _loc17_ = updatesPerFrame;
                  while(_loc13_ < int(_loc17_.length))
                  {
                     _loc14_ = int(_loc17_[_loc13_]);
                     _loc13_++;
                     if(_loc14_ > 0)
                     {
                        _loc19_ += _loc14_;
                        _loc12_++;
                     }
                  }
                  if(_loc12_ != 0)
                  {
                     _loc19_ /= _loc12_;
                     _loc20_ = 0;
                     _loc12_ = 0;
                     _loc13_ = 0;
                     _loc21_ = msPerLine;
                     while(_loc13_ < int(_loc21_.length))
                     {
                        _loc22_ = Number(_loc21_[_loc13_]);
                        _loc13_++;
                        if(_loc22_ > 0)
                        {
                           _loc20_ += _loc22_;
                           _loc12_++;
                        }
                     }
                     if(_loc12_ != 0)
                     {
                        _loc20_ /= _loc12_;
                        step = int(Math.ceil(Number(Math.max(_loc18_ / _loc20_ / _loc19_,20480 / img.width))));
                     }
                     else
                     {
                        step = int(Math.ceil(20480 / img.width));
                     }
                  }
                  else
                  {
                     step = int(Math.ceil(20480 / img.width));
                  }
               }
               else
               {
                  step = int(Math.ceil(20480 / img.width));
               }
               currentY = _loc9_;
            }
            else
            {
               step = img.height;
            }
            updates = 0;
            ApplicationDomain.currentDomain.domainMemory = _loc4_;
         }
      }
      
      public function _new(param1:BitmapData, param2:IEventDispatcher, param3:*) : void
      {
         var _loc4_:* = null as ByteArray;
         var _loc5_:* = null as BitmapData;
         var _loc6_:Number = NaN;
         var _loc7_:uint = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:* = null as ByteArray;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         var _loc14_:* = 0;
         var _loc15_:* = 0;
         var _loc16_:Number = NaN;
         var _loc17_:* = null as Vector.<int>;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:* = null as Vector.<Number>;
         var _loc22_:Number = NaN;
         img = param1;
         dispatcher = param2;
         metadata = param3;
         if(PNGEncoder2Impl.encoding)
         {
            PNGEncoder2Impl.pendingAsyncEncodings.push(this);
         }
         else
         {
            lastFrameStart = getTimer();
            _loc4_ = ApplicationDomain.currentDomain.domainMemory;
            _loc5_ = img;
            if(PNGEncoder2Impl.encoding)
            {
               throw new Error("Only one PNG can be encoded at once (are you encoding asynchronously while attempting to encode another PNG synchronously?)");
            }
            PNGEncoder2Impl.encoding = true;
            if(PNGEncoder2Impl.level == null)
            {
               PNGEncoder2Impl.level = CompressionLevel.FAST;
            }
            if(!PNGEncoder2Impl.crcComputed)
            {
               PNGEncoder2Impl.region = new Rectangle(0,0,1,1);
               PNGEncoder2Impl.sprite = new Sprite();
               PNGEncoder2Impl.data = new ByteArray();
               _loc6_ = Number(Math.max(6600,ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH));
               PNGEncoder2Impl.data.length = int(_loc6_);
            }
            ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
            if(!PNGEncoder2Impl.crcComputed)
            {
               _loc8_ = 0;
               while(_loc8_ < 256)
               {
                  _loc9_ = _loc8_++;
                  _loc7_ = _loc9_;
                  if((_loc7_ & 1) == 1)
                  {
                     _loc7_ = -306674912 ^ _loc7_ >>> 1;
                  }
                  else
                  {
                     _loc7_ >>>= 1;
                  }
                  if((_loc7_ & 1) == 1)
                  {
                     _loc7_ = -306674912 ^ _loc7_ >>> 1;
                  }
                  else
                  {
                     _loc7_ >>>= 1;
                  }
                  if((_loc7_ & 1) == 1)
                  {
                     _loc7_ = -306674912 ^ _loc7_ >>> 1;
                  }
                  else
                  {
                     _loc7_ >>>= 1;
                  }
                  if((_loc7_ & 1) == 1)
                  {
                     _loc7_ = -306674912 ^ _loc7_ >>> 1;
                  }
                  else
                  {
                     _loc7_ >>>= 1;
                  }
                  if((_loc7_ & 1) == 1)
                  {
                     _loc7_ = -306674912 ^ _loc7_ >>> 1;
                  }
                  else
                  {
                     _loc7_ >>>= 1;
                  }
                  if((_loc7_ & 1) == 1)
                  {
                     _loc7_ = -306674912 ^ _loc7_ >>> 1;
                  }
                  else
                  {
                     _loc7_ >>>= 1;
                  }
                  if((_loc7_ & 1) == 1)
                  {
                     _loc7_ = -306674912 ^ _loc7_ >>> 1;
                  }
                  else
                  {
                     _loc7_ >>>= 1;
                  }
                  if((_loc7_ & 1) == 1)
                  {
                     _loc7_ = -306674912 ^ _loc7_ >>> 1;
                  }
                  else
                  {
                     _loc7_ >>>= 1;
                  }
                  si32(_loc7_,_loc9_ << 2);
               }
               PNGEncoder2Impl.crcComputed = true;
            }
            _loc10_ = new ByteArray();
            _loc10_.writeUnsignedInt(-1991225785);
            _loc10_.writeUnsignedInt(218765834);
            _loc8_ = 13;
            _loc6_ = Number(Math.max(6600 + _loc8_,ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH));
            PNGEncoder2Impl.data.length = int(_loc6_);
            ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
            _loc7_ = _loc5_.width;
            si8(_loc7_ >>> 24,6600);
            si8(_loc7_ >>> 16,6601);
            si8(_loc7_ >>> 8,6602);
            si8(_loc7_,6603);
            _loc7_ = _loc5_.height;
            si8(_loc7_ >>> 24,6604);
            si8(_loc7_ >>> 16,6605);
            si8(_loc7_ >>> 8,6606);
            si8(_loc7_,6607);
            si8(8,6608);
            if(_loc5_.transparent)
            {
               si8(6,6609);
            }
            else
            {
               si8(2,6609);
            }
            si8(0,6610);
            si8(0,6611);
            si8(0,6612);
            _loc9_ = _loc8_;
            _loc10_.writeUnsignedInt(_loc9_);
            _loc10_.writeUnsignedInt(1229472850);
            if(_loc9_ != 0)
            {
               PNGEncoder2Impl.data.position = 6600;
               PNGEncoder2Impl.data.readBytes(_loc10_,_loc10_.position,_loc8_);
               _loc10_.position += _loc9_;
            }
            _loc11_ = -1;
            _loc11_ = li32(((_loc11_ ^ 73) & 255) << 2) ^ _loc11_ >>> 8;
            _loc11_ = li32(((_loc11_ ^ 72) & 255) << 2) ^ _loc11_ >>> 8;
            _loc11_ = li32(((_loc11_ ^ 68) & 255) << 2) ^ _loc11_ >>> 8;
            _loc11_ = li32(((_loc11_ ^ 82) & 255) << 2) ^ _loc11_ >>> 8;
            if(_loc9_ != 0)
            {
               _loc12_ = 6600;
               _loc13_ = 6600 + _loc9_;
               _loc14_ = 6600 + (_loc9_ & -16);
               while(_loc12_ < _loc14_)
               {
                  _loc15_ = _loc11_ ^ li8(_loc12_);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 1);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 2);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 3);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 4);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 5);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 6);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 7);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 8);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 9);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 10);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 11);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 12);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 13);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 14);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc15_ = _loc11_ ^ li8(_loc12_ + 15);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc12_ += 16;
               }
               while(_loc12_ < _loc13_)
               {
                  _loc15_ = _loc11_ ^ li8(_loc12_);
                  _loc11_ = li32((_loc15_ & 255) << 2) ^ _loc11_ >>> 8;
                  _loc12_++;
               }
            }
            _loc11_ ^= -1;
            _loc10_.writeUnsignedInt(_loc11_);
            PNGEncoder2Impl.writeMetadataChunks(param3,_loc10_);
            png#3 = _loc10_;
            currentY = 0;
            frameCount = 0;
            done = false;
            msPerFrame = new Vector.<int>(4,true);
            msPerFrameIndex = 0;
            msPerLine = new Vector.<Number>(4,true);
            msPerLineIndex = 0;
            updatesPerFrame = new Vector.<int>(4,true);
            updatesPerFrameIndex = 0;
            deflateStream = DeflateStream.createEx(PNGEncoder2Impl.level,1024,6600,true);
            PNGEncoder2Impl.sprite.addEventListener(Event.ENTER_FRAME,onEnterFrame);
            if(img.width > 0 && img.height > 0)
            {
               _loc8_ = getTimer();
               _loc9_ = Math.ceil(Number(Math.min(20480 / img.width,img.height)));
               PNGEncoder2Impl.writeIDATChunk(img,0,_loc9_,deflateStream,png#3);
               _loc11_ = int(getTimer());
               _loc12_ = _loc11_ - _loc8_;
               if(_loc9_ != 0)
               {
                  if(_loc12_ <= 0)
                  {
                     _loc12_ = 5;
                  }
                  msPerLine[msPerLineIndex] = _loc12_ * 1 / _loc9_;
                  msPerLineIndex = msPerLineIndex + 1 & 3;
               }
               if(Lib.current == null || Lib.current.stage == null)
               {
                  _loc6_ = 24;
               }
               else
               {
                  _loc6_ = Lib.current.stage.frameRate;
               }
               _loc12_ = int(1 / _loc6_ * 1000);
               msPerFrame[msPerFrameIndex] = _loc12_;
               msPerFrameIndex = msPerFrameIndex + 1 & 3;
               updatesPerFrame[updatesPerFrameIndex] = 1;
               updatesPerFrameIndex = updatesPerFrameIndex + 1 & 3;
               _loc16_ = 0;
               _loc12_ = 0;
               _loc13_ = 0;
               _loc17_ = msPerFrame;
               while(_loc13_ < int(_loc17_.length))
               {
                  _loc14_ = int(_loc17_[_loc13_]);
                  _loc13_++;
                  if(_loc14_ > 0)
                  {
                     _loc16_ += _loc14_;
                     _loc12_++;
                  }
               }
               if(_loc12_ != 0)
               {
                  _loc16_ /= _loc12_;
                  _loc18_ = 1000 / targetFPS;
                  if(_loc16_ > _loc18_ * 1.15)
                  {
                     _loc18_ -= _loc16_ - _loc18_;
                  }
                  _loc19_ = 0;
                  _loc12_ = 0;
                  _loc13_ = 0;
                  _loc17_ = updatesPerFrame;
                  while(_loc13_ < int(_loc17_.length))
                  {
                     _loc14_ = int(_loc17_[_loc13_]);
                     _loc13_++;
                     if(_loc14_ > 0)
                     {
                        _loc19_ += _loc14_;
                        _loc12_++;
                     }
                  }
                  if(_loc12_ != 0)
                  {
                     _loc19_ /= _loc12_;
                     _loc20_ = 0;
                     _loc12_ = 0;
                     _loc13_ = 0;
                     _loc21_ = msPerLine;
                     while(_loc13_ < int(_loc21_.length))
                     {
                        _loc22_ = Number(_loc21_[_loc13_]);
                        _loc13_++;
                        if(_loc22_ > 0)
                        {
                           _loc20_ += _loc22_;
                           _loc12_++;
                        }
                     }
                     if(_loc12_ != 0)
                     {
                        _loc20_ /= _loc12_;
                        step = int(Math.ceil(Number(Math.max(_loc18_ / _loc20_ / _loc19_,20480 / img.width))));
                     }
                     else
                     {
                        step = int(Math.ceil(20480 / img.width));
                     }
                  }
                  else
                  {
                     step = int(Math.ceil(20480 / img.width));
                  }
               }
               else
               {
                  step = int(Math.ceil(20480 / img.width));
               }
               currentY = _loc9_;
            }
            else
            {
               step = img.height;
            }
            updates = 0;
            ApplicationDomain.currentDomain.domainMemory = _loc4_;
         }
      }
   }
}
