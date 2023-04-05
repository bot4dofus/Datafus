package com.hurlant.crypto.hash
{
   import flash.utils.ByteArray;
   
   public class HMAC implements IHMAC
   {
       
      
      private var hash:IHash;
      
      private var bits:uint;
      
      public function HMAC(hash:IHash, bits:uint = 0)
      {
         super();
         this.hash = hash;
         this.bits = bits;
      }
      
      public function getHashSize() : uint
      {
         if(this.bits != 0)
         {
            return this.bits / 8;
         }
         return this.hash.getHashSize();
      }
      
      public function compute(key:ByteArray, data:ByteArray) : ByteArray
      {
         var hashKey:ByteArray = null;
         if(key.length > this.hash.getInputSize())
         {
            hashKey = this.hash.hash(key);
         }
         else
         {
            hashKey = new ByteArray();
            hashKey.writeBytes(key);
         }
         while(hashKey.length < this.hash.getInputSize())
         {
            hashKey[hashKey.length] = 0;
         }
         var innerKey:ByteArray = new ByteArray();
         var outerKey:ByteArray = new ByteArray();
         for(var i:uint = 0; i < hashKey.length; i++)
         {
            innerKey[i] = hashKey[i] ^ 54;
            outerKey[i] = hashKey[i] ^ 92;
         }
         innerKey.position = hashKey.length;
         innerKey.writeBytes(data);
         var innerHash:ByteArray = this.hash.hash(innerKey);
         outerKey.position = hashKey.length;
         outerKey.writeBytes(innerHash);
         var outerHash:ByteArray = this.hash.hash(outerKey);
         if(this.bits > 0 && this.bits < 8 * outerHash.length)
         {
            outerHash.length = this.bits / 8;
         }
         return outerHash;
      }
      
      public function dispose() : void
      {
         this.hash = null;
         this.bits = 0;
      }
      
      public function toString() : String
      {
         return "hmac-" + (this.bits > 0 ? this.bits + "-" : "") + this.hash.toString();
      }
   }
}
