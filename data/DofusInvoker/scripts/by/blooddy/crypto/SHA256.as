package by.blooddy.crypto
{
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.li8;
   import avm2.intrinsics.memory.si32;
   import avm2.intrinsics.memory.si8;
   import flash.system.ApplicationDomain;
   import flash.utils.ByteArray;
   
   public class SHA256
   {
       
      
      public function SHA256()
      {
      }
      
      public static function hash(param1:String) : String
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeUTFBytes(param1);
         return SHA256.hashBytes(_loc2_);
      }
      
      public static function hashBytes(param1:ByteArray) : String
      {
         var _loc14_:uint = 0;
         var _loc17_:* = 0;
         var _loc18_:int = 0;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:* = 0;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         var _loc24_:int = 0;
         var _loc25_:int = 0;
         var _loc26_:int = 0;
         var _loc27_:* = 0;
         var _loc28_:* = 0;
         var _loc29_:* = 0;
         var _loc2_:* = 1779033703;
         var _loc3_:* = -1150833019;
         var _loc4_:* = 1013904242;
         var _loc5_:* = -1521486534;
         var _loc6_:* = 1359893119;
         var _loc7_:* = -1694144372;
         var _loc8_:* = 528734635;
         var _loc9_:* = 1541459225;
         var _loc10_:ByteArray = ApplicationDomain.currentDomain.domainMemory;
         var _loc11_:uint = param1.length << 3;
         var _loc12_:uint = 512 + ((_loc11_ + 64 >>> 9 << 4) + 15 << 2);
         _loc14_ = _loc12_ + 4;
         var _loc15_:ByteArray = new ByteArray();
         if(_loc14_ != 0)
         {
            _loc15_.length = _loc14_;
         }
         var _loc13_:ByteArray = _loc15_;
         _loc13_.position = 512;
         _loc13_.writeBytes(param1);
         if(_loc13_.length < ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH)
         {
            _loc13_.length = ApplicationDomain.MIN_DOMAIN_MEMORY_LENGTH;
         }
         ApplicationDomain.currentDomain.domainMemory = _loc13_;
         si32(li32(512 + (_loc11_ >>> 5 << 2)) | 128 << _loc11_ % 32,512 + (_loc11_ >>> 5 << 2));
         si8(_loc11_ >> 24,_loc12_);
         si8(_loc11_ >> 16,_loc12_ + 1);
         si8(_loc11_ >> 8,_loc12_ + 2);
         si8(_loc11_,_loc12_ + 3);
         var _loc16_:Array = [1116352408,1899447441,-1245643825,-373957723,961987163,1508970993,-1841331548,-1424204075,-670586216,310598401,607225278,1426881987,1925078388,-2132889090,-1680079193,-1046744716,-459576895,-272742522,264347078,604807628,770255983,1249150122,1555081692,1996064986,-1740746414,-1473132947,-1341970488,-1084653625,-958395405,-710438585,113926993,338241895,666307205,773529912,1294757372,1396182291,1695183700,1986661051,-2117940946,-1838011259,-1564481375,-1474664885,-1035236496,-949202525,-778901479,-694614492,-200395387,275423344,430227734,506948616,659060556,883997877,958139571,1322822218,1537002063,1747873779,1955562222,2024104815,-2067236844,-1933114872,-1866530822,-1538233109,-1090935817,-965641998];
         _loc11_ = 0;
         do
         {
            si32(int(_loc16_[_loc11_]),256 + (_loc11_ << 2));
         }
         while(++_loc11_ < 64);
         
         _loc11_ = 512;
         do
         {
            _loc17_ = int(_loc2_);
            _loc18_ = _loc3_;
            _loc19_ = _loc4_;
            _loc20_ = _loc5_;
            _loc21_ = int(_loc6_);
            _loc22_ = _loc7_;
            _loc23_ = _loc8_;
            _loc24_ = _loc9_;
            _loc14_ = 0;
            do
            {
               _loc27_ = li8(_loc11_ + _loc14_) << 24 | li8(_loc11_ + _loc14_ + 1) << 16 | li8(_loc11_ + _loc14_ + 2) << 8 | li8(_loc11_ + _loc14_ + 3);
               si32(_loc27_,_loc14_);
               _loc29_ = _loc24_ + ((_loc21_ << 26 | _loc21_ >>> 6) ^ (_loc21_ << 21 | _loc21_ >>> 11) ^ (_loc21_ << 7 | _loc21_ >>> 25)) + (_loc21_ & _loc22_ ^ ~_loc21_ & _loc23_) + li32(256 + _loc14_) + _loc27_;
               _loc28_ = ((_loc17_ << 30 | _loc17_ >>> 2) ^ (_loc17_ << 19 | _loc17_ >>> 13) ^ (_loc17_ << 10 | _loc17_ >>> 22)) + (_loc17_ & _loc18_ ^ _loc17_ & _loc19_ ^ _loc18_ & _loc19_);
               _loc24_ = _loc23_;
               _loc23_ = _loc22_;
               _loc22_ = _loc21_;
               _loc21_ = _loc20_ + _loc29_;
               _loc20_ = _loc19_;
               _loc19_ = _loc18_;
               _loc18_ = _loc17_;
               _loc17_ = _loc29_ + _loc28_;
               _loc14_ += 4;
            }
            while(_loc14_ < 64);
            
            do
            {
               _loc25_ = li32(_loc14_ - 8);
               _loc26_ = li32(_loc14_ - 60);
               _loc27_ = ((_loc25_ << 15 | _loc25_ >>> 17) ^ (_loc25_ << 13 | _loc25_ >>> 19) ^ _loc25_ >>> 10) + li32(_loc14_ - 28) + ((_loc26_ << 25 | _loc26_ >>> 7) ^ (_loc26_ << 14 | _loc26_ >>> 18) ^ _loc26_ >>> 3) + li32(_loc14_ - 64);
               si32(_loc27_,_loc14_);
               _loc29_ = _loc24_ + ((_loc21_ << 26 | _loc21_ >>> 6) ^ (_loc21_ << 21 | _loc21_ >>> 11) ^ (_loc21_ << 7 | _loc21_ >>> 25)) + (_loc21_ & _loc22_ ^ ~_loc21_ & _loc23_) + li32(256 + _loc14_) + _loc27_;
               _loc28_ = ((_loc17_ << 30 | _loc17_ >>> 2) ^ (_loc17_ << 19 | _loc17_ >>> 13) ^ (_loc17_ << 10 | _loc17_ >>> 22)) + (_loc17_ & _loc18_ ^ _loc17_ & _loc19_ ^ _loc18_ & _loc19_);
               _loc24_ = _loc23_;
               _loc23_ = _loc22_;
               _loc22_ = _loc21_;
               _loc21_ = _loc20_ + _loc29_;
               _loc20_ = _loc19_;
               _loc19_ = _loc18_;
               _loc18_ = _loc17_;
               _loc17_ = _loc29_ + _loc28_;
               _loc14_ += 4;
            }
            while(_loc14_ < 256);
            
            _loc2_ += _loc17_;
            _loc3_ += _loc18_;
            _loc4_ += _loc19_;
            _loc5_ += _loc20_;
            _loc6_ += _loc21_;
            _loc7_ += _loc22_;
            _loc8_ += _loc23_;
            _loc9_ += _loc24_;
            _loc11_ += 64;
         }
         while(_loc11_ < _loc12_);
         
         _loc13_.position = 0;
         _loc13_.writeUTFBytes("0123456789abcdef");
         si8(_loc2_ >> 24,16);
         si8(_loc2_ >> 16,17);
         si8(_loc2_ >> 8,18);
         si8(_loc2_,19);
         si8(_loc3_ >> 24,20);
         si8(_loc3_ >> 16,21);
         si8(_loc3_ >> 8,22);
         si8(_loc3_,23);
         si8(_loc4_ >> 24,24);
         si8(_loc4_ >> 16,25);
         si8(_loc4_ >> 8,26);
         si8(_loc4_,27);
         si8(_loc5_ >> 24,28);
         si8(_loc5_ >> 16,29);
         si8(_loc5_ >> 8,30);
         si8(_loc5_,31);
         si8(_loc6_ >> 24,32);
         si8(_loc6_ >> 16,33);
         si8(_loc6_ >> 8,34);
         si8(_loc6_,35);
         si8(_loc7_ >> 24,36);
         si8(_loc7_ >> 16,37);
         si8(_loc7_ >> 8,38);
         si8(_loc7_,39);
         si8(_loc8_ >> 24,40);
         si8(_loc8_ >> 16,41);
         si8(_loc8_ >> 8,42);
         si8(_loc8_,43);
         si8(_loc9_ >> 24,44);
         si8(_loc9_ >> 16,45);
         si8(_loc9_ >> 8,46);
         si8(_loc9_,47);
         _loc18_ = 47;
         _loc11_ = 16;
         do
         {
            _loc17_ = int(li8(_loc11_));
            _loc18_++;
            si8(li8(_loc17_ >>> 4),_loc18_);
            _loc18_++;
            si8(li8(_loc17_ & 15),_loc18_);
         }
         while(++_loc11_ < 48);
         
         ApplicationDomain.currentDomain.domainMemory = _loc10_;
         _loc13_.position = 48;
         return _loc13_.readUTFBytes(64);
      }
   }
}
