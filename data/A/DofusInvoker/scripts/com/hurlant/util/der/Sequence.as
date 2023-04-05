package com.hurlant.util.der
{
   import flash.utils.ByteArray;
   
   public dynamic class Sequence extends Array implements IAsn1Type
   {
       
      
      protected var type:uint;
      
      protected var len:uint;
      
      public function Sequence(type:uint = 48, length:uint = 0)
      {
         super();
         this.type = type;
         this.len = length;
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
         var e:IAsn1Type = null;
         var tmp:ByteArray = new ByteArray();
         for(var i:int = 0; i < length; i++)
         {
            e = this[i];
            if(e == null)
            {
               tmp.writeByte(5);
               tmp.writeByte(0);
            }
            else
            {
               tmp.writeBytes(e.toDER());
            }
         }
         return DER.wrapDER(this.type,tmp);
      }
      
      public function toString() : String
      {
         var found:Boolean = false;
         var key:* = null;
         var s:String = DER.indent;
         DER.indent += "    ";
         var t:String = "";
         for(var i:int = 0; i < length; i++)
         {
            if(this[i] != null)
            {
               found = false;
               for(key in this)
               {
                  if(i.toString() != key && this[i] == this[key])
                  {
                     t += key + ": " + this[i] + "\n";
                     found = true;
                     break;
                  }
               }
               if(!found)
               {
                  t += this[i] + "\n";
               }
            }
         }
         DER.indent = s;
         return DER.indent + "Sequence[" + this.type + "][" + this.len + "][\n" + t + "\n" + s + "]";
      }
      
      public function findAttributeValue(oid:String) : IAsn1Type
      {
         var set:* = undefined;
         var child:* = undefined;
         var tmp:* = undefined;
         var id:ObjectIdentifier = null;
         for each(set in this)
         {
            if(set is Set)
            {
               child = set[0];
               if(child is Sequence)
               {
                  tmp = child[0];
                  if(tmp is ObjectIdentifier)
                  {
                     id = tmp as ObjectIdentifier;
                     if(id.toString() == oid)
                     {
                        return child[1] as IAsn1Type;
                     }
                  }
               }
            }
         }
         return null;
      }
   }
}
