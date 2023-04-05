package com.hurlant.crypto.symmetric
{
   import com.hurlant.util.Memory;
   import flash.utils.ByteArray;
   
   public class TripleDESKey extends DESKey
   {
       
      
      protected var encKey2:Array;
      
      protected var encKey3:Array;
      
      protected var decKey2:Array;
      
      protected var decKey3:Array;
      
      public function TripleDESKey(key:ByteArray)
      {
         super(key);
         this.encKey2 = generateWorkingKey(false,key,8);
         this.decKey2 = generateWorkingKey(true,key,8);
         if(key.length > 16)
         {
            this.encKey3 = generateWorkingKey(true,key,16);
            this.decKey3 = generateWorkingKey(false,key,16);
         }
         else
         {
            this.encKey3 = encKey;
            this.decKey3 = decKey;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         var i:uint = 0;
         if(this.encKey2 != null)
         {
            for(i = 0; i < this.encKey2.length; this.encKey2[i] = 0,i++)
            {
            }
            this.encKey2 = null;
         }
         if(this.encKey3 != null)
         {
            for(i = 0; i < this.encKey3.length; this.encKey3[i] = 0,i++)
            {
            }
            this.encKey3 = null;
         }
         if(this.decKey2 != null)
         {
            for(i = 0; i < this.decKey2.length; this.decKey2[i] = 0,i++)
            {
            }
            this.decKey2 = null;
         }
         if(this.decKey3 != null)
         {
            for(i = 0; i < this.decKey3.length; this.decKey3[i] = 0,i++)
            {
            }
            this.decKey3 = null;
         }
         Memory.gc();
      }
      
      override public function encrypt(block:ByteArray, index:uint = 0) : void
      {
         desFunc(encKey,block,index,block,index);
         desFunc(this.encKey2,block,index,block,index);
         desFunc(this.encKey3,block,index,block,index);
      }
      
      override public function decrypt(block:ByteArray, index:uint = 0) : void
      {
         desFunc(this.decKey3,block,index,block,index);
         desFunc(this.decKey2,block,index,block,index);
         desFunc(decKey,block,index,block,index);
      }
      
      override public function toString() : String
      {
         return "3des";
      }
   }
}
