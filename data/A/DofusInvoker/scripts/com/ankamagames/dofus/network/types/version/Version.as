package com.ankamagames.dofus.network.types.version
{
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class Version implements INetworkType
   {
      
      public static const protocolId:uint = 580;
       
      
      public var major:uint = 0;
      
      public var minor:uint = 0;
      
      public var code:uint = 0;
      
      public var build:uint = 0;
      
      public var buildType:uint = 0;
      
      public function Version()
      {
         super();
      }
      
      public function getTypeId() : uint
      {
         return 580;
      }
      
      public function initVersion(major:uint = 0, minor:uint = 0, code:uint = 0, build:uint = 0, buildType:uint = 0) : Version
      {
         this.major = major;
         this.minor = minor;
         this.code = code;
         this.build = build;
         this.buildType = buildType;
         return this;
      }
      
      public function reset() : void
      {
         this.major = 0;
         this.minor = 0;
         this.code = 0;
         this.build = 0;
         this.buildType = 0;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_Version(output);
      }
      
      public function serializeAs_Version(output:ICustomDataOutput) : void
      {
         if(this.major < 0)
         {
            throw new Error("Forbidden value (" + this.major + ") on element major.");
         }
         output.writeByte(this.major);
         if(this.minor < 0)
         {
            throw new Error("Forbidden value (" + this.minor + ") on element minor.");
         }
         output.writeByte(this.minor);
         if(this.code < 0)
         {
            throw new Error("Forbidden value (" + this.code + ") on element code.");
         }
         output.writeByte(this.code);
         if(this.build < 0)
         {
            throw new Error("Forbidden value (" + this.build + ") on element build.");
         }
         output.writeInt(this.build);
         output.writeByte(this.buildType);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_Version(input);
      }
      
      public function deserializeAs_Version(input:ICustomDataInput) : void
      {
         this._majorFunc(input);
         this._minorFunc(input);
         this._codeFunc(input);
         this._buildFunc(input);
         this._buildTypeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_Version(tree);
      }
      
      public function deserializeAsyncAs_Version(tree:FuncTree) : void
      {
         tree.addChild(this._majorFunc);
         tree.addChild(this._minorFunc);
         tree.addChild(this._codeFunc);
         tree.addChild(this._buildFunc);
         tree.addChild(this._buildTypeFunc);
      }
      
      private function _majorFunc(input:ICustomDataInput) : void
      {
         this.major = input.readByte();
         if(this.major < 0)
         {
            throw new Error("Forbidden value (" + this.major + ") on element of Version.major.");
         }
      }
      
      private function _minorFunc(input:ICustomDataInput) : void
      {
         this.minor = input.readByte();
         if(this.minor < 0)
         {
            throw new Error("Forbidden value (" + this.minor + ") on element of Version.minor.");
         }
      }
      
      private function _codeFunc(input:ICustomDataInput) : void
      {
         this.code = input.readByte();
         if(this.code < 0)
         {
            throw new Error("Forbidden value (" + this.code + ") on element of Version.code.");
         }
      }
      
      private function _buildFunc(input:ICustomDataInput) : void
      {
         this.build = input.readInt();
         if(this.build < 0)
         {
            throw new Error("Forbidden value (" + this.build + ") on element of Version.build.");
         }
      }
      
      private function _buildTypeFunc(input:ICustomDataInput) : void
      {
         this.buildType = input.readByte();
         if(this.buildType < 0)
         {
            throw new Error("Forbidden value (" + this.buildType + ") on element of Version.buildType.");
         }
      }
   }
}
