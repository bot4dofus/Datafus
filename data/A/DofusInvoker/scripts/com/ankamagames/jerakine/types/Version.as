package com.ankamagames.jerakine.types
{
   public class Version
   {
       
      
      private var _major:uint = 2;
      
      private var _minor:uint = 0;
      
      private var _code:uint = 0;
      
      private var _build:uint = 0;
      
      private var _buildType:uint = 0;
      
      public function Version(versionNumber:String, buildType:uint)
      {
         super();
         var versionSplit:Array = versionNumber.split(".");
         this._major = uint(versionSplit[0]);
         this._minor = uint(versionSplit[1]);
         this._code = uint(versionSplit[2].split("-")[0]);
         this._buildType = buildType;
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
   }
}
