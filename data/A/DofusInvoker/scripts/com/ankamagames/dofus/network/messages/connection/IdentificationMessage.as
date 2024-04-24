package com.ankamagames.dofus.network.messages.connection
{
   import com.ankamagames.dofus.network.types.version.Version;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.BooleanByteWrapper;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class IdentificationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 17;
       
      
      private var _isInitialized:Boolean = false;
      
      public var version:Version;
      
      public var lang:String = "";
      
      public var credentials:Vector.<int>;
      
      public var serverId:int = 0;
      
      public var autoconnect:Boolean = false;
      
      public var useCertificate:Boolean = false;
      
      public var useLoginToken:Boolean = false;
      
      public var sessionOptionalSalt:Number = 0;
      
      public var failedAttempts:Vector.<uint>;
      
      private var _versiontree:FuncTree;
      
      private var _credentialstree:FuncTree;
      
      private var _failedAttemptstree:FuncTree;
      
      public function IdentificationMessage()
      {
         this.version = new Version();
         this.credentials = new Vector.<int>();
         this.failedAttempts = new Vector.<uint>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 17;
      }
      
      public function initIdentificationMessage(version:Version = null, lang:String = "", credentials:Vector.<int> = null, serverId:int = 0, autoconnect:Boolean = false, useCertificate:Boolean = false, useLoginToken:Boolean = false, sessionOptionalSalt:Number = 0, failedAttempts:Vector.<uint> = null) : IdentificationMessage
      {
         this.version = version;
         this.lang = lang;
         this.credentials = credentials;
         this.serverId = serverId;
         this.autoconnect = autoconnect;
         this.useCertificate = useCertificate;
         this.useLoginToken = useLoginToken;
         this.sessionOptionalSalt = sessionOptionalSalt;
         this.failedAttempts = failedAttempts;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.version = new Version();
         this.credentials = new Vector.<int>();
         this.serverId = 0;
         this.autoconnect = false;
         this.useCertificate = false;
         this.useLoginToken = false;
         this.sessionOptionalSalt = 0;
         this.failedAttempts = new Vector.<uint>();
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         writePacket(output,this.getMessageId(),data);
      }
      
      override public function unpack(input:ICustomDataInput, length:uint) : void
      {
         this.deserialize(input);
      }
      
      override public function unpackAsync(input:ICustomDataInput, length:uint) : FuncTree
      {
         var tree:FuncTree = new FuncTree();
         tree.setRoot(input);
         this.deserializeAsync(tree);
         return tree;
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_IdentificationMessage(output);
      }
      
      public function serializeAs_IdentificationMessage(output:ICustomDataOutput) : void
      {
         var _box0:uint = 0;
         _box0 = BooleanByteWrapper.setFlag(_box0,0,this.autoconnect);
         _box0 = BooleanByteWrapper.setFlag(_box0,1,this.useCertificate);
         _box0 = BooleanByteWrapper.setFlag(_box0,2,this.useLoginToken);
         output.writeByte(_box0);
         this.version.serializeAs_Version(output);
         output.writeUTF(this.lang);
         output.writeVarInt(this.credentials.length);
         for(var _i3:uint = 0; _i3 < this.credentials.length; _i3++)
         {
            output.writeByte(this.credentials[_i3]);
         }
         output.writeShort(this.serverId);
         if(this.sessionOptionalSalt < -9007199254740992 || this.sessionOptionalSalt > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.sessionOptionalSalt + ") on element sessionOptionalSalt.");
         }
         output.writeVarLong(this.sessionOptionalSalt);
         output.writeShort(this.failedAttempts.length);
         for(var _i9:uint = 0; _i9 < this.failedAttempts.length; _i9++)
         {
            if(this.failedAttempts[_i9] < 0)
            {
               throw new Error("Forbidden value (" + this.failedAttempts[_i9] + ") on element 9 (starting at 1) of failedAttempts.");
            }
            output.writeVarShort(this.failedAttempts[_i9]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_IdentificationMessage(input);
      }
      
      public function deserializeAs_IdentificationMessage(input:ICustomDataInput) : void
      {
         var _val3:int = 0;
         var _val9:uint = 0;
         this.deserializeByteBoxes(input);
         this.version = new Version();
         this.version.deserialize(input);
         this._langFunc(input);
         var _credentialsLen:uint = input.readVarInt();
         for(var _i3:uint = 0; _i3 < _credentialsLen; _i3++)
         {
            _val3 = input.readByte();
            this.credentials.push(_val3);
         }
         this._serverIdFunc(input);
         this._sessionOptionalSaltFunc(input);
         var _failedAttemptsLen:uint = input.readUnsignedShort();
         for(var _i9:uint = 0; _i9 < _failedAttemptsLen; _i9++)
         {
            _val9 = input.readVarUhShort();
            if(_val9 < 0)
            {
               throw new Error("Forbidden value (" + _val9 + ") on elements of failedAttempts.");
            }
            this.failedAttempts.push(_val9);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_IdentificationMessage(tree);
      }
      
      public function deserializeAsyncAs_IdentificationMessage(tree:FuncTree) : void
      {
         tree.addChild(this.deserializeByteBoxes);
         this._versiontree = tree.addChild(this._versiontreeFunc);
         tree.addChild(this._langFunc);
         this._credentialstree = tree.addChild(this._credentialstreeFunc);
         tree.addChild(this._serverIdFunc);
         tree.addChild(this._sessionOptionalSaltFunc);
         this._failedAttemptstree = tree.addChild(this._failedAttemptstreeFunc);
      }
      
      private function deserializeByteBoxes(input:ICustomDataInput) : void
      {
         var _box0:uint = input.readByte();
         this.autoconnect = BooleanByteWrapper.getFlag(_box0,0);
         this.useCertificate = BooleanByteWrapper.getFlag(_box0,1);
         this.useLoginToken = BooleanByteWrapper.getFlag(_box0,2);
      }
      
      private function _versiontreeFunc(input:ICustomDataInput) : void
      {
         this.version = new Version();
         this.version.deserializeAsync(this._versiontree);
      }
      
      private function _langFunc(input:ICustomDataInput) : void
      {
         this.lang = input.readUTF();
      }
      
      private function _credentialstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readVarInt();
         for(var i:uint = 0; i < length; i++)
         {
            this._credentialstree.addChild(this._credentialsFunc);
         }
      }
      
      private function _credentialsFunc(input:ICustomDataInput) : void
      {
         var _val:int = input.readByte();
         this.credentials.push(_val);
      }
      
      private function _serverIdFunc(input:ICustomDataInput) : void
      {
         this.serverId = input.readShort();
      }
      
      private function _sessionOptionalSaltFunc(input:ICustomDataInput) : void
      {
         this.sessionOptionalSalt = input.readVarLong();
         if(this.sessionOptionalSalt < -9007199254740992 || this.sessionOptionalSalt > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.sessionOptionalSalt + ") on element of IdentificationMessage.sessionOptionalSalt.");
         }
      }
      
      private function _failedAttemptstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._failedAttemptstree.addChild(this._failedAttemptsFunc);
         }
      }
      
      private function _failedAttemptsFunc(input:ICustomDataInput) : void
      {
         var _val:uint = input.readVarUhShort();
         if(_val < 0)
         {
            throw new Error("Forbidden value (" + _val + ") on elements of failedAttempts.");
         }
         this.failedAttempts.push(_val);
      }
   }
}
