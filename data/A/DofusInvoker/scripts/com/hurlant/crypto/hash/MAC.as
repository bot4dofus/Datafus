package com.hurlant.crypto.hash
{
   import flash.utils.ByteArray;
   
   public class MAC implements IHMAC
   {
       
      
      private var hash:IHash;
      
      private var bits:uint;
      
      private var pad_1:ByteArray;
      
      private var pad_2:ByteArray;
      
      private var innerHash:ByteArray;
      
      private var outerHash:ByteArray;
      
      private var outerKey:ByteArray;
      
      private var innerKey:ByteArray;
      
      public function MAC(hash:IHash, bits:uint = 0)
      {
         var pad_size:int = 0;
         var x:int = 0;
         super();
         this.hash = hash;
         this.bits = bits;
         this.innerHash = new ByteArray();
         this.outerHash = new ByteArray();
         this.innerKey = new ByteArray();
         this.outerKey = new ByteArray();
         if(hash != null)
         {
            pad_size = hash.getPadSize();
            this.pad_1 = new ByteArray();
            this.pad_2 = new ByteArray();
            for(x = 0; x < pad_size; x++)
            {
               this.pad_1.writeByte(54);
               this.pad_2.writeByte(92);
            }
         }
      }
      
      public function setPadSize(pad_size:int) : void
      {
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
         var pad_size:int = 0;
         var x:int = 0;
         if(this.pad_1 == null)
         {
            pad_size = this.hash.getPadSize();
            this.pad_1 = new ByteArray();
            this.pad_2 = new ByteArray();
            for(x = 0; x < pad_size; x++)
            {
               this.pad_1.writeByte(54);
               this.pad_2.writeByte(92);
            }
         }
         this.innerKey.length = 0;
         this.outerKey.length = 0;
         this.innerKey.writeBytes(key);
         this.innerKey.writeBytes(this.pad_1);
         this.innerKey.writeBytes(data);
         this.innerHash = this.hash.hash(this.innerKey);
         this.outerKey.writeBytes(key);
         this.outerKey.writeBytes(this.pad_2);
         this.outerKey.writeBytes(this.innerHash);
         this.outerHash = this.hash.hash(this.outerKey);
         if(this.bits > 0 && this.bits < 8 * this.outerHash.length)
         {
            this.outerHash.length = this.bits / 8;
         }
         return this.outerHash;
      }
      
      public function dispose() : void
      {
         this.hash = null;
         this.bits = 0;
      }
      
      public function toString() : String
      {
         return "mac-" + (this.bits > 0 ? this.bits + "-" : "") + this.hash.toString();
      }
   }
}
