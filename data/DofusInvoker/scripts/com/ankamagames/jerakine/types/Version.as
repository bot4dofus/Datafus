package com.ankamagames.jerakine.types
{
   import com.ankamagames.jerakine.interfaces.IDataCenter;
   import flash.utils.IDataInput;
   import flash.utils.IDataOutput;
   import flash.utils.IExternalizable;
   
   public class Version implements IExternalizable, IDataCenter
   {
       
      
      private var _major:uint = 2;
      
      private var _minor:uint = 0;
      
      private var _code:uint = 0;
      
      private var _build:uint = 0;
      
      private var _buildType:uint = 4;
      
      public function Version(... args)
      {
         var split:Array = null;
         super();
         if(!args || args.length == 0)
         {
            this._major = this._minor = this._code = this._build = this._buildType = 0;
         }
         else
         {
            if(!(args.length == 2 && args[0] is String))
            {
               throw new ArgumentError("invalid parameters");
            }
            split = (args[0] as String).split(".");
            this._major = uint(split[0]);
            this._minor = uint(split[1]);
            this._code = uint(split[2].split("-")[0]);
            this._buildType = args[1];
         }
      }
      
      public static function fromServerData(major:uint, minor:uint, code:uint, build:uint, buildType:uint) : Version
      {
         var version:Version = new Version();
         version._major = major;
         version._minor = minor;
         version._code = code;
         version._build = build;
         version._buildType = buildType;
         return version;
      }
      
      public function get major() : uint
      {
         return this._major;
      }
      
      public function get minor() : uint
      {
         return this._minor;
      }
      
      public function get code() : uint
      {
         return this._code;
      }
      
      public function get build() : uint
      {
         return this._build;
      }
      
      public function set build(value:uint) : void
      {
         this._build = value;
      }
      
      public function get buildType() : uint
      {
         return this._buildType;
      }
      
      public function set buildType(value:uint) : void
      {
         this._buildType = value;
      }
      
      public function toString() : String
      {
         if(this._buildType == 5)
         {
            return this._major + "." + this._minor + "." + this._code;
         }
         if(this._buildType == 0)
         {
            return this._major + "." + this._minor + "." + this._code + "." + this._build;
         }
         return this._major + "." + this._minor + "." + this._code + "." + this._build + "-" + this._buildType;
      }
      
      public function toStringForAppName() : String
      {
         var version:* = this._major + "." + this._minor + "." + this._code + "." + this._build;
         switch(this._buildType)
         {
            case 1:
               version += "-beta";
               break;
            case 3:
               version += "-testing";
               break;
            case 4:
               version += "-locale";
               break;
            case 5:
               version += "-debug";
               break;
            case 6:
               version += "-draft";
         }
         return version;
      }
      
      public function equals(otherVersion:Version) : Boolean
      {
         return this._major == otherVersion._major && this._minor == otherVersion._minor && this._code == otherVersion._code && this._build == otherVersion._build && this._buildType == otherVersion._buildType;
      }
      
      public function writeExternal(output:IDataOutput) : void
      {
         output.writeByte(this._major);
         output.writeByte(this._minor);
         output.writeByte(this._code);
         output.writeByte(this._build);
         output.writeByte(this._buildType);
      }
      
      public function readExternal(input:IDataInput) : void
      {
         this._major = input.readUnsignedByte();
         this._minor = input.readUnsignedByte();
         this._code = input.readUnsignedByte();
         this._build = input.readUnsignedByte();
         this._buildType = input.readUnsignedByte();
      }
   }
}
