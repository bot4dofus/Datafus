package com.adobe.net
{
   import flash.utils.ByteArray;
   
   public class URIEncodingBitmap extends ByteArray
   {
       
      
      public function URIEncodingBitmap(charsToEscape:String)
      {
         var i:int = 0;
         var c:int = 0;
         var enc:* = 0;
         super();
         var data:ByteArray = new ByteArray();
         for(i = 0; i < 16; i++)
         {
            this.writeByte(0);
         }
         data.writeUTFBytes(charsToEscape);
         data.position = 0;
         while(data.bytesAvailable)
         {
            c = data.readByte();
            if(c <= 127)
            {
               this.position = c >> 3;
               enc = int(this.readByte());
               enc |= 1 << (c & 7);
               this.position = c >> 3;
               this.writeByte(enc);
            }
         }
      }
      
      public function ShouldEscape(char:String) : int
      {
         var c:int = 0;
         var mask:int = 0;
         var data:ByteArray = new ByteArray();
         data.writeUTFBytes(char);
         data.position = 0;
         c = data.readByte();
         if(c & 128)
         {
            return 0;
         }
         if(c < 31 || c == 127)
         {
            return c;
         }
         this.position = c >> 3;
         mask = this.readByte();
         if(mask & 1 << (c & 7))
         {
            return c;
         }
         return 0;
      }
   }
}
