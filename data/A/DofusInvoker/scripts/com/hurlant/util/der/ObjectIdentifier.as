package com.hurlant.util.der
{
   import flash.net.registerClassAlias;
   import flash.utils.ByteArray;
   
   public class ObjectIdentifier implements IAsn1Type
   {
      
      {
         registerClassAlias("com.hurlant.util.der.ObjectIdentifier",ObjectIdentifier);
      }
      
      private var type:uint;
      
      private var len:uint;
      
      private var oid:Array;
      
      public function ObjectIdentifier(type:uint = 0, length:uint = 0, b:* = null)
      {
         super();
         this.type = type;
         this.len = length;
         if(b is ByteArray)
         {
            this.parse(b as ByteArray);
         }
         else
         {
            if(!(b is String))
            {
               throw new Error("Invalid call to new ObjectIdentifier");
            }
            this.generate(b as String);
         }
      }
      
      private function generate(s:String) : void
      {
         this.oid = s.split(".");
      }
      
      private function parse(b:ByteArray) : void
      {
         var last:* = false;
         var o:uint = b.readUnsignedByte();
         var a:Array = [];
         a.push(uint(o / 40));
         a.push(uint(o % 40));
         var v:uint = 0;
         while(b.bytesAvailable > 0)
         {
            o = b.readUnsignedByte();
            last = (o & 128) == 0;
            o &= 127;
            v = v * 128 + o;
            if(last)
            {
               a.push(v);
               v = 0;
            }
         }
         this.oid = a;
      }
      
      public function getLength() : uint
      {
         return this.len;
      }
      
      public function getType() : uint
      {
         return this.type;
      }
      
      public function toDER() : ByteArray
      {
         var v:int = 0;
         var tmp:Array = [];
         tmp[0] = this.oid[0] * 40 + this.oid[1];
         for(var i:int = 2; i < this.oid.length; i++)
         {
            v = parseInt(this.oid[i]);
            if(v < 128)
            {
               tmp.push(v);
            }
            else if(v < 128 * 128)
            {
               tmp.push(v >> 7 | 128);
               tmp.push(v & 127);
            }
            else if(v < 128 * 128 * 128)
            {
               tmp.push(v >> 14 | 128);
               tmp.push(v >> 7 & 127 | 128);
               tmp.push(v & 127);
            }
            else
            {
               if(v >= 128 * 128 * 128 * 128)
               {
                  throw new Error("OID element bigger than we thought. :(");
               }
               tmp.push(v >> 21 | 128);
               tmp.push(v >> 14 & 127 | 128);
               tmp.push(v >> 7 & 127 | 128);
               tmp.push(v & 127);
            }
         }
         this.len = tmp.length;
         if(this.type == 0)
         {
            this.type = 6;
         }
         tmp.unshift(this.len);
         tmp.unshift(this.type);
         var b:ByteArray = new ByteArray();
         for(i = 0; i < tmp.length; i++)
         {
            b[i] = tmp[i];
         }
         return b;
      }
      
      public function toString() : String
      {
         return DER.indent + this.oid.join(".");
      }
      
      public function dump() : String
      {
         return "OID[" + this.type + "][" + this.len + "][" + this.toString() + "]";
      }
   }
}
