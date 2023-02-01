package com.hurlant.crypto.hash
{
   import flash.utils.ByteArray;
   import flash.utils.Endian;
   
   public class MD5 implements IHash
   {
      
      public static const HASH_SIZE:int = 16;
       
      
      public var pad_size:int = 48;
      
      public function MD5()
      {
         super();
      }
      
      public function getInputSize() : uint
      {
         return 64;
      }
      
      public function getHashSize() : uint
      {
         return HASH_SIZE;
      }
      
      public function getPadSize() : int
      {
         return this.pad_size;
      }
      
      public function hash(src:ByteArray) : ByteArray
      {
         var len:uint = src.length * 8;
         var savedEndian:String = src.endian;
         while(src.length % 4 != 0)
         {
            src[src.length] = 0;
         }
         src.position = 0;
         var a:Array = [];
         src.endian = Endian.LITTLE_ENDIAN;
         for(var i:uint = 0; i < src.length; i += 4)
         {
            a.push(src.readUnsignedInt());
         }
         var h:Array = this.core_md5(a,len);
         var out:ByteArray = new ByteArray();
         out.endian = Endian.LITTLE_ENDIAN;
         for(i = 0; i < 4; i++)
         {
            out.writeUnsignedInt(h[i]);
         }
         src.length = len / 8;
         src.endian = savedEndian;
         return out;
      }
      
      private function core_md5(x:Array, len:uint) : Array
      {
         var olda:uint = 0;
         var oldb:uint = 0;
         var oldc:uint = 0;
         var oldd:uint = 0;
         x[len >> 5] |= 128 << len % 32;
         x[(len + 64 >>> 9 << 4) + 14] = len;
         var a:uint = 1732584193;
         var b:uint = 4023233417;
         var c:uint = 2562383102;
         var d:uint = 271733878;
         for(var i:uint = 0; i < x.length; i += 16)
         {
            x[i] = x[i] || 0;
            x[i + 1] = x[i + 1] || 0;
            x[i + 2] = x[i + 2] || 0;
            x[i + 3] = x[i + 3] || 0;
            x[i + 4] = x[i + 4] || 0;
            x[i + 5] = x[i + 5] || 0;
            x[i + 6] = x[i + 6] || 0;
            x[i + 7] = x[i + 7] || 0;
            x[i + 8] = x[i + 8] || 0;
            x[i + 9] = x[i + 9] || 0;
            x[i + 10] = x[i + 10] || 0;
            x[i + 11] = x[i + 11] || 0;
            x[i + 12] = x[i + 12] || 0;
            x[i + 13] = x[i + 13] || 0;
            x[i + 14] = x[i + 14] || 0;
            x[i + 15] = x[i + 15] || 0;
            olda = a;
            oldb = b;
            oldc = c;
            oldd = d;
            a = this.ff(a,b,c,d,x[i + 0],7,3614090360);
            d = this.ff(d,a,b,c,x[i + 1],12,3905402710);
            c = this.ff(c,d,a,b,x[i + 2],17,606105819);
            b = this.ff(b,c,d,a,x[i + 3],22,3250441966);
            a = this.ff(a,b,c,d,x[i + 4],7,4118548399);
            d = this.ff(d,a,b,c,x[i + 5],12,1200080426);
            c = this.ff(c,d,a,b,x[i + 6],17,2821735955);
            b = this.ff(b,c,d,a,x[i + 7],22,4249261313);
            a = this.ff(a,b,c,d,x[i + 8],7,1770035416);
            d = this.ff(d,a,b,c,x[i + 9],12,2336552879);
            c = this.ff(c,d,a,b,x[i + 10],17,4294925233);
            b = this.ff(b,c,d,a,x[i + 11],22,2304563134);
            a = this.ff(a,b,c,d,x[i + 12],7,1804603682);
            d = this.ff(d,a,b,c,x[i + 13],12,4254626195);
            c = this.ff(c,d,a,b,x[i + 14],17,2792965006);
            b = this.ff(b,c,d,a,x[i + 15],22,1236535329);
            a = this.gg(a,b,c,d,x[i + 1],5,4129170786);
            d = this.gg(d,a,b,c,x[i + 6],9,3225465664);
            c = this.gg(c,d,a,b,x[i + 11],14,643717713);
            b = this.gg(b,c,d,a,x[i + 0],20,3921069994);
            a = this.gg(a,b,c,d,x[i + 5],5,3593408605);
            d = this.gg(d,a,b,c,x[i + 10],9,38016083);
            c = this.gg(c,d,a,b,x[i + 15],14,3634488961);
            b = this.gg(b,c,d,a,x[i + 4],20,3889429448);
            a = this.gg(a,b,c,d,x[i + 9],5,568446438);
            d = this.gg(d,a,b,c,x[i + 14],9,3275163606);
            c = this.gg(c,d,a,b,x[i + 3],14,4107603335);
            b = this.gg(b,c,d,a,x[i + 8],20,1163531501);
            a = this.gg(a,b,c,d,x[i + 13],5,2850285829);
            d = this.gg(d,a,b,c,x[i + 2],9,4243563512);
            c = this.gg(c,d,a,b,x[i + 7],14,1735328473);
            b = this.gg(b,c,d,a,x[i + 12],20,2368359562);
            a = this.hh(a,b,c,d,x[i + 5],4,4294588738);
            d = this.hh(d,a,b,c,x[i + 8],11,2272392833);
            c = this.hh(c,d,a,b,x[i + 11],16,1839030562);
            b = this.hh(b,c,d,a,x[i + 14],23,4259657740);
            a = this.hh(a,b,c,d,x[i + 1],4,2763975236);
            d = this.hh(d,a,b,c,x[i + 4],11,1272893353);
            c = this.hh(c,d,a,b,x[i + 7],16,4139469664);
            b = this.hh(b,c,d,a,x[i + 10],23,3200236656);
            a = this.hh(a,b,c,d,x[i + 13],4,681279174);
            d = this.hh(d,a,b,c,x[i + 0],11,3936430074);
            c = this.hh(c,d,a,b,x[i + 3],16,3572445317);
            b = this.hh(b,c,d,a,x[i + 6],23,76029189);
            a = this.hh(a,b,c,d,x[i + 9],4,3654602809);
            d = this.hh(d,a,b,c,x[i + 12],11,3873151461);
            c = this.hh(c,d,a,b,x[i + 15],16,530742520);
            b = this.hh(b,c,d,a,x[i + 2],23,3299628645);
            a = this.ii(a,b,c,d,x[i + 0],6,4096336452);
            d = this.ii(d,a,b,c,x[i + 7],10,1126891415);
            c = this.ii(c,d,a,b,x[i + 14],15,2878612391);
            b = this.ii(b,c,d,a,x[i + 5],21,4237533241);
            a = this.ii(a,b,c,d,x[i + 12],6,1700485571);
            d = this.ii(d,a,b,c,x[i + 3],10,2399980690);
            c = this.ii(c,d,a,b,x[i + 10],15,4293915773);
            b = this.ii(b,c,d,a,x[i + 1],21,2240044497);
            a = this.ii(a,b,c,d,x[i + 8],6,1873313359);
            d = this.ii(d,a,b,c,x[i + 15],10,4264355552);
            c = this.ii(c,d,a,b,x[i + 6],15,2734768916);
            b = this.ii(b,c,d,a,x[i + 13],21,1309151649);
            a = this.ii(a,b,c,d,x[i + 4],6,4149444226);
            d = this.ii(d,a,b,c,x[i + 11],10,3174756917);
            c = this.ii(c,d,a,b,x[i + 2],15,718787259);
            b = this.ii(b,c,d,a,x[i + 9],21,3951481745);
            a += olda;
            b += oldb;
            c += oldc;
            d += oldd;
         }
         return [a,b,c,d];
      }
      
      private function rol(num:uint, cnt:uint) : uint
      {
         return num << cnt | num >>> 32 - cnt;
      }
      
      private function cmn(q:uint, a:uint, b:uint, x:uint, s:uint, t:uint) : uint
      {
         return this.rol(a + q + x + t,s) + b;
      }
      
      private function ff(a:uint, b:uint, c:uint, d:uint, x:uint, s:uint, t:uint) : uint
      {
         return this.cmn(b & c | ~b & d,a,b,x,s,t);
      }
      
      private function gg(a:uint, b:uint, c:uint, d:uint, x:uint, s:uint, t:uint) : uint
      {
         return this.cmn(b & d | c & ~d,a,b,x,s,t);
      }
      
      private function hh(a:uint, b:uint, c:uint, d:uint, x:uint, s:uint, t:uint) : uint
      {
         return this.cmn(b ^ c ^ d,a,b,x,s,t);
      }
      
      private function ii(a:uint, b:uint, c:uint, d:uint, x:uint, s:uint, t:uint) : uint
      {
         return this.cmn(c ^ (b | ~d),a,b,x,s,t);
      }
      
      public function toString() : String
      {
         return "md5";
      }
   }
}
