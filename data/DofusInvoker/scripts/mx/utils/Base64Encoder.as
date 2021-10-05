package mx.utils
{
   import flash.utils.ByteArray;
   
   public class Base64Encoder
   {
      
      public static const CHARSET_UTF_8:String = "UTF-8";
      
      public static var newLine:int = 10;
      
      public static const MAX_BUFFER_SIZE:uint = 32767;
      
      private static const ESCAPE_CHAR_CODE:Number = 61;
      
      private static const ALPHABET_CHAR_CODES:Array = [65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,48,49,50,51,52,53,54,55,56,57,43,47];
       
      
      public var insertNewLines:Boolean = true;
      
      private var _buffers:Array;
      
      private var _count:uint;
      
      private var _line:uint;
      
      private var _work:Array;
      
      public function Base64Encoder()
      {
         this._work = [0,0,0];
         super();
         this.reset();
      }
      
      public function drain() : String
      {
         var buffer:Array = null;
         var result:String = "";
         for(var i:uint = 0; i < this._buffers.length; i++)
         {
            buffer = this._buffers[i] as Array;
            result += String.fromCharCode.apply(null,buffer);
         }
         this._buffers = [];
         this._buffers.push([]);
         return result;
      }
      
      public function encode(data:String, offset:uint = 0, length:uint = 0) : void
      {
         if(length == 0)
         {
            length = data.length;
         }
         var currentIndex:uint = offset;
         var endIndex:uint = offset + length;
         if(endIndex > data.length)
         {
            endIndex = data.length;
         }
         while(currentIndex < endIndex)
         {
            this._work[this._count] = data.charCodeAt(currentIndex);
            ++this._count;
            if(this._count == this._work.length || endIndex - currentIndex == 1)
            {
               this.encodeBlock();
               this._count = 0;
               this._work[0] = 0;
               this._work[1] = 0;
               this._work[2] = 0;
            }
            currentIndex++;
         }
      }
      
      public function encodeUTFBytes(data:String) : void
      {
         var bytes:ByteArray = new ByteArray();
         bytes.writeUTFBytes(data);
         bytes.position = 0;
         this.encodeBytes(bytes);
      }
      
      public function encodeBytes(data:ByteArray, offset:uint = 0, length:uint = 0) : void
      {
         if(length == 0)
         {
            length = data.length;
         }
         var oldPosition:uint = data.position;
         data.position = offset;
         var currentIndex:uint = offset;
         var endIndex:uint = offset + length;
         if(endIndex > data.length)
         {
            endIndex = data.length;
         }
         while(currentIndex < endIndex)
         {
            this._work[this._count] = data[currentIndex];
            ++this._count;
            if(this._count == this._work.length || endIndex - currentIndex == 1)
            {
               this.encodeBlock();
               this._count = 0;
               this._work[0] = 0;
               this._work[1] = 0;
               this._work[2] = 0;
            }
            currentIndex++;
         }
         data.position = oldPosition;
      }
      
      public function flush() : String
      {
         if(this._count > 0)
         {
            this.encodeBlock();
         }
         var result:String = this.drain();
         this.reset();
         return result;
      }
      
      public function reset() : void
      {
         this._buffers = [];
         this._buffers.push([]);
         this._count = 0;
         this._line = 0;
         this._work[0] = 0;
         this._work[1] = 0;
         this._work[2] = 0;
      }
      
      public function toString() : String
      {
         return this.flush();
      }
      
      private function encodeBlock() : void
      {
         var currentBuffer:Array = this._buffers[this._buffers.length - 1] as Array;
         if(currentBuffer.length >= MAX_BUFFER_SIZE)
         {
            currentBuffer = [];
            this._buffers.push(currentBuffer);
         }
         currentBuffer.push(ALPHABET_CHAR_CODES[(this._work[0] & 255) >> 2]);
         currentBuffer.push(ALPHABET_CHAR_CODES[(this._work[0] & 3) << 4 | (this._work[1] & 240) >> 4]);
         if(this._count > 1)
         {
            currentBuffer.push(ALPHABET_CHAR_CODES[(this._work[1] & 15) << 2 | (this._work[2] & 192) >> 6]);
         }
         else
         {
            currentBuffer.push(ESCAPE_CHAR_CODE);
         }
         if(this._count > 2)
         {
            currentBuffer.push(ALPHABET_CHAR_CODES[this._work[2] & 63]);
         }
         else
         {
            currentBuffer.push(ESCAPE_CHAR_CODE);
         }
         if(this.insertNewLines)
         {
            if((this._line = this._line + 4) == 76)
            {
               currentBuffer.push(newLine);
               this._line = 0;
            }
         }
      }
   }
}
