package com.hurlant.util.der
{
   import flash.utils.ByteArray;
   
   public interface IAsn1Type
   {
       
      
      function getType() : uint;
      
      function getLength() : uint;
      
      function toDER() : ByteArray;
   }
}
