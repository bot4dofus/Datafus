package by.blooddy.crypto.image
{
   import avm2.intrinsics.memory.lf64;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.sf64;
   import avm2.intrinsics.memory.si16;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   
   public class JPEGTableHelper
   {
       
      
      public function JPEGTableHelper()
      {
      }
      
      public static function createQuantTable(param1:uint) : ByteArray
      {
         var _loc6_:uint = 0;
         var _loc8_:uint = 0;
         var _loc9_:Number = NaN;
         if(param1 > 100)
         {
            Error.throwError(RangeError,2006,"quality");
         }
         var _loc2_:uint = param1 <= 1 ? 5000 : (param1 < 50 ? int(5000 / param1) : 200 - (param1 << 1));
         var _loc3_:ByteArray = ApplicationDomain.currentDomain.domainMemory;
         var _loc4_:ByteArray = new ByteArray();
         _loc4_.position = 130;
         _loc4_.writeUTFBytes("\x10\x0b\n\x10\x18(3=\f\f\x0e\x13\x1a:<7\x0e\r\x10\x18(9E8\x0e\x11\x16\x1d3WP>\x12\x16%8DmgM\x18#7@Qhq\\1@NWgyxeH\\_bpdgc");
         _loc4_.writeUTFBytes("\x11\x12\x18/cccc\x12\x15\x1aBcccc\x18\x1a8ccccc/Bcccccccccccccccccccccccccccccccccccccc");
         _loc4_.position = 1154;
         _loc4_.writeUTFBytes("\x00\x01\x05\x06\x0e\x0f\x1b\x1c\x02\x04\x07\r\x10\x1a\x1d*\x03\b\f\x11\x19\x1e)+\t\x0b\x12\x18\x1f(,5\n\x13\x17 \'-46\x14\x16!&.37<\x15\"%/28;=#$019:>?");
         _loc4_.length += 64;
         if(_loc4_.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
         {
            _loc4_.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
         }
         ApplicationDomain.currentDomain.domainMemory = _loc4_;
         var _loc5_:uint = 0;
         do
         {
            _loc6_ = int((li8(130 + _loc5_) * _loc2_ + 50) / 100);
            if(_loc6_ < 1)
            {
               _loc6_ = 1;
            }
            else if(_loc6_ > 255)
            {
               _loc6_ = 255;
            }
            si8(_loc6_,1 + li8(1154 + _loc5_));
         }
         while(++_loc5_ < 64);
         
         _loc5_ = 0;
         do
         {
            _loc6_ = int((li8(194 + _loc5_) * _loc2_ + 50) / 100);
            if(_loc6_ < 1)
            {
               _loc6_ = 1;
            }
            else if(_loc6_ > 255)
            {
               _loc6_ = 255;
            }
            si8(_loc6_,66 + li8(1154 + _loc5_));
         }
         while(++_loc5_ < 64);
         
         sf64(1,1218);
         sf64(1.387039845,1226);
         sf64(1.306562965,1234);
         sf64(1.175875602,1242);
         sf64(1,1250);
         sf64(0.785694958,1258);
         sf64(0.5411961,1266);
         sf64(0.275899379,1274);
         _loc5_ = 0;
         var _loc7_:uint = 0;
         do
         {
            _loc8_ = 0;
            do
            {
               _loc9_ = lf64(1218 + _loc7_) * lf64(1218 + _loc8_) * 8;
               sf64(1 / (li8(1 + li8(1154 + _loc5_)) * _loc9_),130 + (_loc5_ << 3));
               sf64(1 / (li8(66 + li8(1154 + _loc5_)) * _loc9_),642 + (_loc5_ << 3));
               _loc5_++;
               _loc8_ += 8;
            }
            while(_loc8_ < 64);
            
            _loc7_ += 8;
         }
         while(_loc7_ < 64);
         
         ApplicationDomain.currentDomain.domainMemory = _loc3_;
         _loc4_.length = 1154;
         var _loc10_:ByteArray = new ByteArray();
         _loc10_.writeBytes(_loc4_);
         _loc10_.position = 0;
         return _loc10_;
      }
      
      public static function createZigZagTable() : ByteArray
      {
         var _loc1_:ByteArray = new ByteArray();
         _loc1_.writeUTFBytes("\x00\x01\x05\x06\x0e\x0f\x1b\x1c\x02\x04\x07\r\x10\x1a\x1d*\x03\b\f\x11\x19\x1e)+\t\x0b\x12\x18\x1f(,5\n\x13\x17 \'-46\x14\x16!&.37<\x15\"%/28;=#$019:>?");
         _loc1_.position = 0;
         return _loc1_;
      }
      
      public static function createHuffmanTable() : ByteArray
      {
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc1_:ByteArray = ApplicationDomain.currentDomain.domainMemory;
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.length = 1994;
         if(_loc2_.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
         {
            _loc2_.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
         }
         ApplicationDomain.currentDomain.domainMemory = _loc2_;
         _loc2_.position = _loc2_.position + 1;
         _loc2_.writeUTFBytes("\x00\x01\x05\x01\x01\x01\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00");
         _loc2_.writeUTFBytes("\x00\x01\x02\x03\x04\x05\x06\x07\b\t\n\x0b");
         _loc2_.position = _loc2_.position + 1;
         _loc2_.writeUTFBytes("\x00\x02\x01\x03\x03\x02\x04\x03\x05\x05\x04\x04\x00\x00\x01}");
         var _loc4_:Array = [197121,302321924,104935713,123818259,840200482,144806273,-1045347805,-254717419,1919038244,369756546,437852183,673654309,892611113,959985462,1162101562,1229473606,1431589706,1498961750,1701077850,1768449894,1970565994,2037938038,-2054913158,-1987541114,-1802268022,-1734895979,-1549624679,-1482250844,-1297438296,-1229605709,-1162233673,-976960574,-909588538,-724315446,-656943403,-488514855,-421141277,-353769241,-185339151,-117967115,64249];
         var _loc3_:int = 0;
         do
         {
            si32(int(_loc4_[_loc3_]),46 + (_loc3_ << 2));
            _loc3_++;
         }
         while(_loc3_ < 41);
         
         _loc2_.position = 208;
         _loc2_.position = _loc2_.position + 1;
         _loc2_.writeUTFBytes("\x00\x03\x01\x01\x01\x01\x01\x01\x01\x01\x01\x00\x00\x00\x00\x00");
         _loc2_.writeBytes(_loc2_,17,12);
         _loc2_.position = _loc2_.position + 1;
         _loc2_.writeUTFBytes("\x00\x02\x01\x02\x04\x04\x03\x04\x07\x05\x04\x04\x00\x01\x02w");
         _loc4_ = [50462976,553976849,1091700273,1902184273,-2127420909,-1857940472,163688865,-263048413,-781032939,874780170,401679841,639244568,707340327,943142453,1145256505,1212630597,1414744649,1482118741,1684232793,1751606885,1953720937,2021095029,-2088600967,-2021227132,-1836414584,-1768581997,-1701209961,-1515936862,-1448564826,-1263291734,-1195919691,-1010648391,-943274556,-758462008,-690629421,-623257385,-437984286,-370612250,-185339158,-117967115,64249];
         _loc3_ = 0;
         do
         {
            si32(int(_loc4_[_loc3_]),254 + (_loc3_ << 2));
            _loc3_++;
         }
         while(_loc3_ < 41);
         
         var _loc5_:* = 0;
         var _loc6_:int = 0;
         var _loc7_:uint = 1;
         do
         {
            _loc9_ = li8(_loc7_);
            _loc8_ = 1;
            while(_loc8_ <= _loc9_)
            {
               _loc10_ = 416 + li8(17 + _loc6_) * 3;
               si8(_loc7_,_loc10_);
               si16(_loc5_,_loc10_ + 1);
               _loc6_++;
               _loc5_++;
               _loc8_++;
            }
            _loc5_ <<= 1;
         }
         while(++_loc7_ <= 16);
         
         _loc5_ = 0;
         _loc6_ = 0;
         _loc7_ = 1;
         do
         {
            _loc9_ = li8(29 + _loc7_);
            _loc8_ = 1;
            while(_loc8_ <= _loc9_)
            {
               _loc10_ = 452 + li8(46 + _loc6_) * 3;
               si8(_loc7_,_loc10_);
               si16(_loc5_,_loc10_ + 1);
               _loc6_++;
               _loc5_++;
               _loc8_++;
            }
            _loc5_ <<= 1;
         }
         while(++_loc7_ <= 16);
         
         _loc5_ = 0;
         _loc6_ = 0;
         _loc7_ = 1;
         do
         {
            _loc9_ = li8(208 + _loc7_);
            _loc8_ = 1;
            while(_loc8_ <= _loc9_)
            {
               _loc10_ = 1205 + li8(225 + _loc6_) * 3;
               si8(_loc7_,_loc10_);
               si16(_loc5_,_loc10_ + 1);
               _loc6_++;
               _loc5_++;
               _loc8_++;
            }
            _loc5_ <<= 1;
         }
         while(++_loc7_ <= 16);
         
         _loc5_ = 0;
         _loc6_ = 0;
         _loc7_ = 1;
         do
         {
            _loc9_ = li8(237 + _loc7_);
            _loc8_ = 1;
            while(_loc8_ <= _loc9_)
            {
               _loc10_ = 1241 + li8(254 + _loc6_) * 3;
               si8(_loc7_,_loc10_);
               si16(_loc5_,_loc10_ + 1);
               _loc6_++;
               _loc5_++;
               _loc8_++;
            }
            _loc5_ <<= 1;
         }
         while(++_loc7_ <= 16);
         
         _loc2_.position = 0;
         ApplicationDomain.currentDomain.domainMemory = _loc1_;
         return _loc2_;
      }
      
      public static function createCategoryTable() : ByteArray
      {
         var _loc5_:uint = 0;
         var _loc6_:* = 0;
         var _loc7_:int = 0;
         var _loc1_:ByteArray = ApplicationDomain.currentDomain.domainMemory;
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.length = 196605;
         if(_loc2_.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
         {
            _loc2_.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
         }
         ApplicationDomain.currentDomain.domainMemory = _loc2_;
         var _loc3_:* = 1;
         var _loc4_:* = 2;
         var _loc8_:uint = 1;
         do
         {
            _loc6_ = int(_loc3_);
            _loc7_ = _loc4_;
            do
            {
               _loc5_ = (32767 + _loc6_) * 3;
               si8(_loc8_,_loc5_);
               si16(_loc6_,_loc5_ + 1);
               _loc6_++;
            }
            while(_loc6_ < _loc7_);
            
            _loc6_ = -_loc4_ + 1;
            _loc7_ = -_loc3_;
            do
            {
               _loc5_ = (32767 + _loc6_) * 3;
               si8(_loc8_,_loc5_);
               si16(_loc4_ - 1 + _loc6_,_loc5_ + 1);
               _loc6_++;
            }
            while(_loc6_ <= _loc7_);
            
            _loc3_ <<= 1;
            _loc4_ <<= 1;
         }
         while(++_loc8_ <= 15);
         
         _loc2_.position = 0;
         ApplicationDomain.currentDomain.domainMemory = _loc1_;
         return _loc2_;
      }
   }
}
