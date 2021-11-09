package
{
   import _PNGEncoder2.PNGEncoder2Impl;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.geom.Rectangle;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   
   public class PNGEncoder2 extends EventDispatcher
   {
      
      public static var level:CompressionLevel;
       
      
      protected var png#1994:ByteArray;
      
      public var __impl:PNGEncoder2Impl;
      
      public function PNGEncoder2(param1:BitmapData, param2:*)
      {
         super();
         PNGEncoder2Impl.level = PNGEncoder2.level;
         __impl = new PNGEncoder2Impl(param1,this,param2);
      }
      
      public static function encode(param1:BitmapData) : ByteArray
      {
         var _loc4_:Number = NaN;
         var _loc5_:uint = 0;
         var _loc6_:int = 0;
         var _loc7_:* = 0;
         var _loc9_:* = 0;
         var _loc10_:* = 0;
         var _loc11_:* = 0;
         var _loc12_:* = 0;
         var _loc13_:* = 0;
         PNGEncoder2Impl.level = PNGEncoder2.level;
         var _loc2_:ByteArray = ApplicationDomain.currentDomain.domainMemory;
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
            _loc4_ = Number(Math.max(6600,ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH));
            PNGEncoder2Impl.data.length = int(_loc4_);
         }
         ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
         if(!PNGEncoder2Impl.crcComputed)
         {
            _loc6_ = 0;
            while(_loc6_ < 256)
            {
               _loc7_ = int(_loc6_++);
               _loc5_ = _loc7_;
               if((_loc5_ & 1) == 1)
               {
                  _loc5_ = -306674912 ^ _loc5_ >>> 1;
               }
               else
               {
                  _loc5_ >>>= 1;
               }
               if((_loc5_ & 1) == 1)
               {
                  _loc5_ = -306674912 ^ _loc5_ >>> 1;
               }
               else
               {
                  _loc5_ >>>= 1;
               }
               if((_loc5_ & 1) == 1)
               {
                  _loc5_ = -306674912 ^ _loc5_ >>> 1;
               }
               else
               {
                  _loc5_ >>>= 1;
               }
               if((_loc5_ & 1) == 1)
               {
                  _loc5_ = -306674912 ^ _loc5_ >>> 1;
               }
               else
               {
                  _loc5_ >>>= 1;
               }
               if((_loc5_ & 1) == 1)
               {
                  _loc5_ = -306674912 ^ _loc5_ >>> 1;
               }
               else
               {
                  _loc5_ >>>= 1;
               }
               if((_loc5_ & 1) == 1)
               {
                  _loc5_ = -306674912 ^ _loc5_ >>> 1;
               }
               else
               {
                  _loc5_ >>>= 1;
               }
               if((_loc5_ & 1) == 1)
               {
                  _loc5_ = -306674912 ^ _loc5_ >>> 1;
               }
               else
               {
                  _loc5_ >>>= 1;
               }
               if((_loc5_ & 1) == 1)
               {
                  _loc5_ = -306674912 ^ _loc5_ >>> 1;
               }
               else
               {
                  _loc5_ >>>= 1;
               }
               si32(_loc5_,_loc7_ << 2);
            }
            PNGEncoder2Impl.crcComputed = true;
         }
         var _loc8_:ByteArray = new ByteArray();
         _loc8_.writeUnsignedInt(-1991225785);
         _loc8_.writeUnsignedInt(218765834);
         _loc6_ = 13;
         _loc4_ = Number(Math.max(6600 + _loc6_,ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH));
         PNGEncoder2Impl.data.length = int(_loc4_);
         ApplicationDomain.currentDomain.domainMemory = PNGEncoder2Impl.data;
         _loc5_ = param1.width;
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
         _loc7_ = int(_loc6_);
         _loc8_.writeUnsignedInt(_loc7_);
         _loc8_.writeUnsignedInt(1229472850);
         if(_loc7_ != 0)
         {
            PNGEncoder2Impl.data.position = 6600;
            PNGEncoder2Impl.data.readBytes(_loc8_,_loc8_.position,_loc6_);
            _loc8_.position += _loc7_;
         }
         _loc9_ = -1;
         _loc9_ = li32(((_loc9_ ^ 73) & 255) << 2) ^ _loc9_ >>> 8;
         _loc9_ = li32(((_loc9_ ^ 72) & 255) << 2) ^ _loc9_ >>> 8;
         _loc9_ = li32(((_loc9_ ^ 68) & 255) << 2) ^ _loc9_ >>> 8;
         _loc9_ = li32(((_loc9_ ^ 82) & 255) << 2) ^ _loc9_ >>> 8;
         if(_loc7_ != 0)
         {
            _loc10_ = 6600;
            _loc11_ = 6600 + _loc7_;
            _loc12_ = 6600 + (_loc7_ & -16);
            while(_loc10_ < _loc12_)
            {
               _loc13_ = _loc9_ ^ li8(_loc10_);
               _loc9_ = li32((_loc13_ & 255) << 2) ^ _loc9_ >>> 8;
               _loc13_ = _loc9_ ^ li8(_loc10_ + 1);
               _loc9_ = li32((_loc13_ & 255) << 2) ^ _loc9_ >>> 8;
               _loc13_ = _loc9_ ^ li8(_loc10_ + 2);
               _loc9_ = li32((_loc13_ & 255) << 2) ^ _loc9_ >>> 8;
               _loc13_ = _loc9_ ^ li8(_loc10_ + 3);
               _loc9_ = li32((_loc13_ & 255) << 2) ^ _loc9_ >>> 8;
               _loc13_ = _loc9_ ^ li8(_loc10_ + 4);
               _loc9_ = li32((_loc13_ & 255) << 2) ^ _loc9_ >>> 8;
               _loc13_ = _loc9_ ^ li8(_loc10_ + 5);
               _loc9_ = li32((_loc13_ & 255) << 2) ^ _loc9_ >>> 8;
               _loc13_ = _loc9_ ^ li8(_loc10_ + 6);
               _loc9_ = li32((_loc13_ & 255) << 2) ^ _loc9_ >>> 8;
               _loc13_ = _loc9_ ^ li8(_loc10_ + 7);
               _loc9_ = li32((_loc13_ & 255) << 2) ^ _loc9_ >>> 8;
               _loc13_ = _loc9_ ^ li8(_loc10_ + 8);
               _loc9_ = li32((_loc13_ & 255) << 2) ^ _loc9_ >>> 8;
               _loc13_ = _loc9_ ^ li8(_loc10_ + 9);
               _loc9_ = li32((_loc13_ & 255) << 2) ^ _loc9_ >>> 8;
               _loc13_ = _loc9_ ^ li8(_loc10_ + 10);
               _loc9_ = li32((_loc13_ & 255) << 2) ^ _loc9_ >>> 8;
               _loc13_ = _loc9_ ^ li8(_loc10_ + 11);
               _loc9_ = li32((_loc13_ & 255) << 2) ^ _loc9_ >>> 8;
               _loc13_ = _loc9_ ^ li8(_loc10_ + 12);
               _loc9_ = li32((_loc13_ & 255) << 2) ^ _loc9_ >>> 8;
               _loc13_ = _loc9_ ^ li8(_loc10_ + 13);
               _loc9_ = li32((_loc13_ & 255) << 2) ^ _loc9_ >>> 8;
               _loc13_ = _loc9_ ^ li8(_loc10_ + 14);
               _loc9_ = li32((_loc13_ & 255) << 2) ^ _loc9_ >>> 8;
               _loc13_ = _loc9_ ^ li8(_loc10_ + 15);
               _loc9_ = li32((_loc13_ & 255) << 2) ^ _loc9_ >>> 8;
               _loc10_ += 16;
            }
            while(_loc10_ < _loc11_)
            {
               _loc13_ = _loc9_ ^ li8(_loc10_);
               _loc9_ = li32((_loc13_ & 255) << 2) ^ _loc9_ >>> 8;
               _loc10_++;
            }
         }
         _loc9_ ^= -1;
         _loc8_.writeUnsignedInt(_loc9_);
         PNGEncoder2Impl.writeMetadataChunks(null,_loc8_);
         var _loc3_:ByteArray = _loc8_;
         var _loc14_:DeflateStream = DeflateStream.createEx(PNGEncoder2Impl.level,1024,6600,true);
         PNGEncoder2Impl.writeIDATChunk(param1,0,param1.height,_loc14_,_loc3_);
         _loc6_ = 0;
         _loc3_.writeUnsignedInt(_loc6_);
         _loc3_.writeUnsignedInt(1229278788);
         if(_loc6_ != 0)
         {
            PNGEncoder2Impl.data.position = 6600;
            PNGEncoder2Impl.data.readBytes(_loc3_,_loc3_.position,0);
            _loc3_.position += _loc6_;
         }
         _loc7_ = -1;
         _loc7_ = li32(((_loc7_ ^ 73) & 255) << 2) ^ _loc7_ >>> 8;
         _loc7_ = li32(((_loc7_ ^ 69) & 255) << 2) ^ _loc7_ >>> 8;
         _loc7_ = li32(((_loc7_ ^ 78) & 255) << 2) ^ _loc7_ >>> 8;
         _loc7_ = li32(((_loc7_ ^ 68) & 255) << 2) ^ _loc7_ >>> 8;
         if(_loc6_ != 0)
         {
            _loc9_ = 6600;
            _loc10_ = 6600 + _loc6_;
            _loc11_ = 6600 + (_loc6_ & -16);
            while(_loc9_ < _loc11_)
            {
               _loc12_ = _loc7_ ^ li8(_loc9_);
               _loc7_ = li32((_loc12_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc12_ = _loc7_ ^ li8(_loc9_ + 1);
               _loc7_ = li32((_loc12_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc12_ = _loc7_ ^ li8(_loc9_ + 2);
               _loc7_ = li32((_loc12_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc12_ = _loc7_ ^ li8(_loc9_ + 3);
               _loc7_ = li32((_loc12_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc12_ = _loc7_ ^ li8(_loc9_ + 4);
               _loc7_ = li32((_loc12_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc12_ = _loc7_ ^ li8(_loc9_ + 5);
               _loc7_ = li32((_loc12_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc12_ = _loc7_ ^ li8(_loc9_ + 6);
               _loc7_ = li32((_loc12_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc12_ = _loc7_ ^ li8(_loc9_ + 7);
               _loc7_ = li32((_loc12_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc12_ = _loc7_ ^ li8(_loc9_ + 8);
               _loc7_ = li32((_loc12_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc12_ = _loc7_ ^ li8(_loc9_ + 9);
               _loc7_ = li32((_loc12_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc12_ = _loc7_ ^ li8(_loc9_ + 10);
               _loc7_ = li32((_loc12_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc12_ = _loc7_ ^ li8(_loc9_ + 11);
               _loc7_ = li32((_loc12_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc12_ = _loc7_ ^ li8(_loc9_ + 12);
               _loc7_ = li32((_loc12_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc12_ = _loc7_ ^ li8(_loc9_ + 13);
               _loc7_ = li32((_loc12_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc12_ = _loc7_ ^ li8(_loc9_ + 14);
               _loc7_ = li32((_loc12_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc12_ = _loc7_ ^ li8(_loc9_ + 15);
               _loc7_ = li32((_loc12_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc9_ += 16;
            }
            while(_loc9_ < _loc10_)
            {
               _loc12_ = _loc7_ ^ li8(_loc9_);
               _loc7_ = li32((_loc12_ & 255) << 2) ^ _loc7_ >>> 8;
               _loc9_++;
            }
         }
         _loc7_ ^= -1;
         _loc3_.writeUnsignedInt(_loc7_);
         PNGEncoder2Impl.encoding = false;
         _loc3_.position = 0;
         _loc14_ = null;
         ApplicationDomain.currentDomain.domainMemory = _loc2_;
         return _loc3_;
      }
      
      public static function encodeWithMetadata(param1:BitmapData, param2:*) : ByteArray
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
         PNGEncoder2Impl.level = PNGEncoder2.level;
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
      
      public static function encodeAsync(param1:BitmapData) : PNGEncoder2
      {
         return new PNGEncoder2(param1,null);
      }
      
      public static function encodeAsyncWithMetadata(param1:BitmapData, param2:*) : PNGEncoder2
      {
         return new PNGEncoder2(param1,param2);
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
      
      protected function set_targetFPS(param1:int) : int
      {
         return __impl.targetFPS = int(param1);
      }
      
      protected function get_targetFPS() : int
      {
         return __impl.targetFPS;
      }
      
      protected function get_png() : ByteArray
      {
         return __impl.png#3;
      }
      
      public function set targetFPS(param1:int) : void
      {
         __impl.targetFPS = param1;
      }
      
      public function get targetFPS() : int
      {
         return __impl.targetFPS;
      }
      
      public function get png#3() : ByteArray
      {
         return __impl.png#3;
      }
   }
}
