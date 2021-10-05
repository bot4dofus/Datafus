package by.blooddy.crypto
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   
   public class MD5
   {
       
      
      public function MD5()
      {
      }
      
      public static function hash(param1:String) : String
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(param1);
         return MD5.hashBytes(_loc2_);
      }
      
      public static function hashBytes(param1:ByteArray) : String
      {
         var _loc2_:ByteArray = ApplicationDomain.currentDomain.domainMemory;
         var _loc3_:uint = param1.length << 3;
         var _loc4_:uint = (_loc3_ + 64 >>> 9 << 4) + 15 << 2;
         var _loc6_:uint = _loc4_ + 4;
         var _loc7_:ByteArray = new ByteArray();
         if(_loc6_ != 0)
         {
            _loc7_.length = _loc6_;
         }
         var _loc5_:ByteArray = _loc7_;
         _loc5_.writeBytes(param1);
         if(_loc5_.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
         {
            _loc5_.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
         }
         ApplicationDomain.currentDomain.domainMemory = _loc5_;
         si32(li32(_loc3_ >>> 5 << 2) | 128 << _loc3_ % 32,_loc3_ >>> 5 << 2);
         si32(_loc3_,_loc4_ - 4);
         var _loc8_:* = 1732584193;
         var _loc9_:* = -271733879;
         var _loc10_:* = -1732584194;
         var _loc11_:* = 271733878;
         var _loc12_:int = _loc8_;
         var _loc13_:int = _loc9_;
         var _loc14_:int = _loc10_;
         var _loc15_:int = _loc11_;
         _loc3_ = 0;
         do
         {
            _loc12_ = _loc8_;
            _loc13_ = _loc9_;
            _loc14_ = _loc10_;
            _loc15_ = _loc11_;
            _loc8_ += (_loc9_ & _loc10_ | ~_loc9_ & _loc11_) + li32(_loc3_) + -680876936;
            _loc8_ = (_loc8_ << uint(7) | _loc8_ >>> 25) + _loc9_;
            _loc11_ += (_loc8_ & _loc9_ | ~_loc8_ & _loc10_) + li32(_loc3_ + 4) + -389564586;
            _loc11_ = (_loc11_ << uint(12) | _loc11_ >>> 20) + _loc8_;
            _loc10_ += (_loc11_ & _loc8_ | ~_loc11_ & _loc9_) + li32(_loc3_ + 8) + 606105819;
            _loc10_ = (_loc10_ << uint(17) | _loc10_ >>> 15) + _loc11_;
            _loc9_ += (_loc10_ & _loc11_ | ~_loc10_ & _loc8_) + li32(_loc3_ + 12) + -1044525330;
            _loc9_ = (_loc9_ << uint(22) | _loc9_ >>> 10) + _loc10_;
            _loc8_ += (_loc9_ & _loc10_ | ~_loc9_ & _loc11_) + li32(_loc3_ + 16) + -176418897;
            _loc8_ = (_loc8_ << uint(7) | _loc8_ >>> 25) + _loc9_;
            _loc11_ += (_loc8_ & _loc9_ | ~_loc8_ & _loc10_) + li32(_loc3_ + 20) + 1200080426;
            _loc11_ = (_loc11_ << uint(12) | _loc11_ >>> 20) + _loc8_;
            _loc10_ += (_loc11_ & _loc8_ | ~_loc11_ & _loc9_) + li32(_loc3_ + 24) + -1473231341;
            _loc10_ = (_loc10_ << uint(17) | _loc10_ >>> 15) + _loc11_;
            _loc9_ += (_loc10_ & _loc11_ | ~_loc10_ & _loc8_) + li32(_loc3_ + 28) + -45705983;
            _loc9_ = (_loc9_ << uint(22) | _loc9_ >>> 10) + _loc10_;
            _loc8_ += (_loc9_ & _loc10_ | ~_loc9_ & _loc11_) + li32(_loc3_ + 32) + 1770035416;
            _loc8_ = (_loc8_ << uint(7) | _loc8_ >>> 25) + _loc9_;
            _loc11_ += (_loc8_ & _loc9_ | ~_loc8_ & _loc10_) + li32(_loc3_ + 36) + -1958414417;
            _loc11_ = (_loc11_ << uint(12) | _loc11_ >>> 20) + _loc8_;
            _loc10_ += (_loc11_ & _loc8_ | ~_loc11_ & _loc9_) + li32(_loc3_ + 40) + -42063;
            _loc10_ = (_loc10_ << uint(17) | _loc10_ >>> 15) + _loc11_;
            _loc9_ += (_loc10_ & _loc11_ | ~_loc10_ & _loc8_) + li32(_loc3_ + 44) + -1990404162;
            _loc9_ = (_loc9_ << uint(22) | _loc9_ >>> 10) + _loc10_;
            _loc8_ += (_loc9_ & _loc10_ | ~_loc9_ & _loc11_) + li32(_loc3_ + 48) + 1804603682;
            _loc8_ = (_loc8_ << uint(7) | _loc8_ >>> 25) + _loc9_;
            _loc11_ += (_loc8_ & _loc9_ | ~_loc8_ & _loc10_) + li32(_loc3_ + 52) + -40341101;
            _loc11_ = (_loc11_ << uint(12) | _loc11_ >>> 20) + _loc8_;
            _loc10_ += (_loc11_ & _loc8_ | ~_loc11_ & _loc9_) + li32(_loc3_ + 56) + -1502002290;
            _loc10_ = (_loc10_ << uint(17) | _loc10_ >>> 15) + _loc11_;
            _loc9_ += (_loc10_ & _loc11_ | ~_loc10_ & _loc8_) + li32(_loc3_ + 60) + 1236535329;
            _loc9_ = (_loc9_ << uint(22) | _loc9_ >>> 10) + _loc10_;
            _loc8_ += (_loc9_ & _loc11_ | _loc10_ & ~_loc11_) + li32(_loc3_ + 4) + -165796510;
            _loc8_ = (_loc8_ << uint(5) | _loc8_ >>> 27) + _loc9_;
            _loc11_ += (_loc8_ & _loc10_ | _loc9_ & ~_loc10_) + li32(_loc3_ + 24) + -1069501632;
            _loc11_ = (_loc11_ << uint(9) | _loc11_ >>> 23) + _loc8_;
            _loc10_ += (_loc11_ & _loc9_ | _loc8_ & ~_loc9_) + li32(_loc3_ + 44) + 643717713;
            _loc10_ = (_loc10_ << uint(14) | _loc10_ >>> 18) + _loc11_;
            _loc9_ += (_loc10_ & _loc8_ | _loc11_ & ~_loc8_) + li32(_loc3_) + -373897302;
            _loc9_ = (_loc9_ << uint(20) | _loc9_ >>> 12) + _loc10_;
            _loc8_ += (_loc9_ & _loc11_ | _loc10_ & ~_loc11_) + li32(_loc3_ + 20) + -701558691;
            _loc8_ = (_loc8_ << uint(5) | _loc8_ >>> 27) + _loc9_;
            _loc11_ += (_loc8_ & _loc10_ | _loc9_ & ~_loc10_) + li32(_loc3_ + 40) + 38016083;
            _loc11_ = (_loc11_ << uint(9) | _loc11_ >>> 23) + _loc8_;
            _loc10_ += (_loc11_ & _loc9_ | _loc8_ & ~_loc9_) + li32(_loc3_ + 60) + -660478335;
            _loc10_ = (_loc10_ << uint(14) | _loc10_ >>> 18) + _loc11_;
            _loc9_ += (_loc10_ & _loc8_ | _loc11_ & ~_loc8_) + li32(_loc3_ + 16) + -405537848;
            _loc9_ = (_loc9_ << uint(20) | _loc9_ >>> 12) + _loc10_;
            _loc8_ += (_loc9_ & _loc11_ | _loc10_ & ~_loc11_) + li32(_loc3_ + 36) + 568446438;
            _loc8_ = (_loc8_ << uint(5) | _loc8_ >>> 27) + _loc9_;
            _loc11_ += (_loc8_ & _loc10_ | _loc9_ & ~_loc10_) + li32(_loc3_ + 56) + -1019803690;
            _loc11_ = (_loc11_ << uint(9) | _loc11_ >>> 23) + _loc8_;
            _loc10_ += (_loc11_ & _loc9_ | _loc8_ & ~_loc9_) + li32(_loc3_ + 12) + -187363961;
            _loc10_ = (_loc10_ << uint(14) | _loc10_ >>> 18) + _loc11_;
            _loc9_ += (_loc10_ & _loc8_ | _loc11_ & ~_loc8_) + li32(_loc3_ + 32) + 1163531501;
            _loc9_ = (_loc9_ << uint(20) | _loc9_ >>> 12) + _loc10_;
            _loc8_ += (_loc9_ & _loc11_ | _loc10_ & ~_loc11_) + li32(_loc3_ + 52) + -1444681467;
            _loc8_ = (_loc8_ << uint(5) | _loc8_ >>> 27) + _loc9_;
            _loc11_ += (_loc8_ & _loc10_ | _loc9_ & ~_loc10_) + li32(_loc3_ + 8) + -51403784;
            _loc11_ = (_loc11_ << uint(9) | _loc11_ >>> 23) + _loc8_;
            _loc10_ += (_loc11_ & _loc9_ | _loc8_ & ~_loc9_) + li32(_loc3_ + 28) + 1735328473;
            _loc10_ = (_loc10_ << uint(14) | _loc10_ >>> 18) + _loc11_;
            _loc9_ += (_loc10_ & _loc8_ | _loc11_ & ~_loc8_) + li32(_loc3_ + 48) + -1926607734;
            _loc9_ = (_loc9_ << uint(20) | _loc9_ >>> 12) + _loc10_;
            _loc8_ += (_loc9_ ^ _loc10_ ^ _loc11_) + li32(_loc3_ + 20) + -378558;
            _loc8_ = (_loc8_ << uint(4) | _loc8_ >>> 28) + _loc9_;
            _loc11_ += (_loc8_ ^ _loc9_ ^ _loc10_) + li32(_loc3_ + 32) + -2022574463;
            _loc11_ = (_loc11_ << uint(11) | _loc11_ >>> 21) + _loc8_;
            _loc10_ += (_loc11_ ^ _loc8_ ^ _loc9_) + li32(_loc3_ + 44) + 1839030562;
            _loc10_ = (_loc10_ << uint(16) | _loc10_ >>> 16) + _loc11_;
            _loc9_ += (_loc10_ ^ _loc11_ ^ _loc8_) + li32(_loc3_ + 56) + -35309556;
            _loc9_ = (_loc9_ << uint(23) | _loc9_ >>> 9) + _loc10_;
            _loc8_ += (_loc9_ ^ _loc10_ ^ _loc11_) + li32(_loc3_ + 4) + -1530992060;
            _loc8_ = (_loc8_ << uint(4) | _loc8_ >>> 28) + _loc9_;
            _loc11_ += (_loc8_ ^ _loc9_ ^ _loc10_) + li32(_loc3_ + 16) + 1272893353;
            _loc11_ = (_loc11_ << uint(11) | _loc11_ >>> 21) + _loc8_;
            _loc10_ += (_loc11_ ^ _loc8_ ^ _loc9_) + li32(_loc3_ + 28) + -155497632;
            _loc10_ = (_loc10_ << uint(16) | _loc10_ >>> 16) + _loc11_;
            _loc9_ += (_loc10_ ^ _loc11_ ^ _loc8_) + li32(_loc3_ + 40) + -1094730640;
            _loc9_ = (_loc9_ << uint(23) | _loc9_ >>> 9) + _loc10_;
            _loc8_ += (_loc9_ ^ _loc10_ ^ _loc11_) + li32(_loc3_ + 52) + 681279174;
            _loc8_ = (_loc8_ << uint(4) | _loc8_ >>> 28) + _loc9_;
            _loc11_ += (_loc8_ ^ _loc9_ ^ _loc10_) + li32(_loc3_) + -358537222;
            _loc11_ = (_loc11_ << uint(11) | _loc11_ >>> 21) + _loc8_;
            _loc10_ += (_loc11_ ^ _loc8_ ^ _loc9_) + li32(_loc3_ + 12) + -722521979;
            _loc10_ = (_loc10_ << uint(16) | _loc10_ >>> 16) + _loc11_;
            _loc9_ += (_loc10_ ^ _loc11_ ^ _loc8_) + li32(_loc3_ + 24) + 76029189;
            _loc9_ = (_loc9_ << uint(23) | _loc9_ >>> 9) + _loc10_;
            _loc8_ += (_loc9_ ^ _loc10_ ^ _loc11_) + li32(_loc3_ + 36) + -640364487;
            _loc8_ = (_loc8_ << uint(4) | _loc8_ >>> 28) + _loc9_;
            _loc11_ += (_loc8_ ^ _loc9_ ^ _loc10_) + li32(_loc3_ + 48) + -421815835;
            _loc11_ = (_loc11_ << uint(11) | _loc11_ >>> 21) + _loc8_;
            _loc10_ += (_loc11_ ^ _loc8_ ^ _loc9_) + li32(_loc3_ + 60) + 530742520;
            _loc10_ = (_loc10_ << uint(16) | _loc10_ >>> 16) + _loc11_;
            _loc9_ += (_loc10_ ^ _loc11_ ^ _loc8_) + li32(_loc3_ + 8) + -995338651;
            _loc9_ = (_loc9_ << uint(23) | _loc9_ >>> 9) + _loc10_;
            _loc8_ += (_loc10_ ^ (_loc9_ | ~_loc11_)) + li32(_loc3_) + -198630844;
            _loc8_ = (_loc8_ << uint(6) | _loc8_ >>> 26) + _loc9_;
            _loc11_ += (_loc9_ ^ (_loc8_ | ~_loc10_)) + li32(_loc3_ + 28) + 1126891415;
            _loc11_ = (_loc11_ << uint(10) | _loc11_ >>> 22) + _loc8_;
            _loc10_ += (_loc8_ ^ (_loc11_ | ~_loc9_)) + li32(_loc3_ + 56) + -1416354905;
            _loc10_ = (_loc10_ << uint(15) | _loc10_ >>> 17) + _loc11_;
            _loc9_ += (_loc11_ ^ (_loc10_ | ~_loc8_)) + li32(_loc3_ + 20) + -57434055;
            _loc9_ = (_loc9_ << uint(21) | _loc9_ >>> 11) + _loc10_;
            _loc8_ += (_loc10_ ^ (_loc9_ | ~_loc11_)) + li32(_loc3_ + 48) + 1700485571;
            _loc8_ = (_loc8_ << uint(6) | _loc8_ >>> 26) + _loc9_;
            _loc11_ += (_loc9_ ^ (_loc8_ | ~_loc10_)) + li32(_loc3_ + 12) + -1894986606;
            _loc11_ = (_loc11_ << uint(10) | _loc11_ >>> 22) + _loc8_;
            _loc10_ += (_loc8_ ^ (_loc11_ | ~_loc9_)) + li32(_loc3_ + 40) + -1051523;
            _loc10_ = (_loc10_ << uint(15) | _loc10_ >>> 17) + _loc11_;
            _loc9_ += (_loc11_ ^ (_loc10_ | ~_loc8_)) + li32(_loc3_ + 4) + -2054922799;
            _loc9_ = (_loc9_ << uint(21) | _loc9_ >>> 11) + _loc10_;
            _loc8_ += (_loc10_ ^ (_loc9_ | ~_loc11_)) + li32(_loc3_ + 32) + 1873313359;
            _loc8_ = (_loc8_ << uint(6) | _loc8_ >>> 26) + _loc9_;
            _loc11_ += (_loc9_ ^ (_loc8_ | ~_loc10_)) + li32(_loc3_ + 60) + -30611744;
            _loc11_ = (_loc11_ << uint(10) | _loc11_ >>> 22) + _loc8_;
            _loc10_ += (_loc8_ ^ (_loc11_ | ~_loc9_)) + li32(_loc3_ + 24) + -1560198380;
            _loc10_ = (_loc10_ << uint(15) | _loc10_ >>> 17) + _loc11_;
            _loc9_ += (_loc11_ ^ (_loc10_ | ~_loc8_)) + li32(_loc3_ + 52) + 1309151649;
            _loc9_ = (_loc9_ << uint(21) | _loc9_ >>> 11) + _loc10_;
            _loc8_ += (_loc10_ ^ (_loc9_ | ~_loc11_)) + li32(_loc3_ + 16) + -145523070;
            _loc8_ = (_loc8_ << uint(6) | _loc8_ >>> 26) + _loc9_;
            _loc11_ += (_loc9_ ^ (_loc8_ | ~_loc10_)) + li32(_loc3_ + 44) + -1120210379;
            _loc11_ = (_loc11_ << uint(10) | _loc11_ >>> 22) + _loc8_;
            _loc10_ += (_loc8_ ^ (_loc11_ | ~_loc9_)) + li32(_loc3_ + 8) + 718787259;
            _loc10_ = (_loc10_ << uint(15) | _loc10_ >>> 17) + _loc11_;
            _loc9_ += (_loc11_ ^ (_loc10_ | ~_loc8_)) + li32(_loc3_ + 36) + -343485551;
            _loc9_ = (_loc9_ << uint(21) | _loc9_ >>> 11) + _loc10_;
            _loc8_ += _loc12_;
            _loc9_ += _loc13_;
            _loc10_ += _loc14_;
            _loc11_ += _loc15_;
            _loc3_ += 64;
         }
         while(_loc3_ < _loc4_);
         
         _loc5_.position = 0;
         _loc5_.writeUTFBytes("0123456789abcdef");
         si32(_loc8_,16);
         si32(_loc9_,20);
         si32(_loc10_,24);
         si32(_loc11_,28);
         _loc9_ = 31;
         _loc3_ = 16;
         do
         {
            _loc8_ = int(li8(_loc3_));
            _loc9_++;
            si8(li8(_loc8_ >>> 4),_loc9_);
            _loc9_++;
            si8(li8(_loc8_ & 15),_loc9_);
         }
         while(++_loc3_ < 32);
         
         ApplicationDomain.currentDomain.domainMemory = _loc2_;
         _loc5_.position = 32;
         return _loc5_.readUTFBytes(32);
      }
   }
}
