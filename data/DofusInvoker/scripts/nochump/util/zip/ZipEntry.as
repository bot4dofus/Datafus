package nochump.util.zip
{
   import flash.utils.ByteArray;
   
   public class ZipEntry
   {
       
      
      private var _name:String;
      
      private var _size:int = -1;
      
      private var _compressedSize:int = -1;
      
      private var _crc:uint;
      
      var dostime:uint;
      
      private var _method:int = -1;
      
      private var _extra:ByteArray;
      
      private var _comment:String;
      
      var flag:int;
      
      var version:int;
      
      var offset:int;
      
      public function ZipEntry(name:String)
      {
         super();
         this._name = name;
      }
      
      public function get name() : String
      {
         return this._name;
      }
      
      public function get time() : Number
      {
         var d:Date = new Date((this.dostime >> 25 & 127) + 1980,(this.dostime >> 21 & 15) - 1,this.dostime >> 16 & 31,this.dostime >> 11 & 31,this.dostime >> 5 & 63,(this.dostime & 31) << 1);
         return d.time;
      }
      
      public function set time(time:Number) : void
      {
         var d:Date = new Date(time);
         this.dostime = (d.fullYear - 1980 & 127) << 25 | d.month + 1 << 21 | d.day << 16 | d.hours << 11 | d.minutes << 5 | d.seconds >> 1;
      }
      
      public function get size() : int
      {
         return this._size;
      }
      
      public function set size(size:int) : void
      {
         this._size = size;
      }
      
      public function get compressedSize() : int
      {
         return this._compressedSize;
      }
      
      public function set compressedSize(csize:int) : void
      {
         this._compressedSize = csize;
      }
      
      public function get crc() : uint
      {
         return this._crc;
      }
      
      public function set crc(crc:uint) : void
      {
         this._crc = crc;
      }
      
      public function get method() : int
      {
         return this._method;
      }
      
      public function set method(method:int) : void
      {
         this._method = method;
      }
      
      public function get extra() : ByteArray
      {
         return this._extra;
      }
      
      public function set extra(extra:ByteArray) : void
      {
         this._extra = extra;
      }
      
      public function get comment() : String
      {
         return this._comment;
      }
      
      public function set comment(comment:String) : void
      {
         this._comment = comment;
      }
      
      public function isDirectory() : Boolean
      {
         return this._name.charAt(this._name.length - 1) == "/";
      }
      
      public function toString() : String
      {
         return this._name;
      }
   }
}
