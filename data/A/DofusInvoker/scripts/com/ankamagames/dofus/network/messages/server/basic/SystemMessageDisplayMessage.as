package com.ankamagames.dofus.network.messages.server.basic
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SystemMessageDisplayMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5943;
       
      
      private var _isInitialized:Boolean = false;
      
      public var hangUp:Boolean = false;
      
      public var msgId:uint = 0;
      
      public var parameters:Vector.<String>;
      
      private var _parameterstree:FuncTree;
      
      public function SystemMessageDisplayMessage()
      {
         this.parameters = new Vector.<String>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5943;
      }
      
      public function initSystemMessageDisplayMessage(hangUp:Boolean = false, msgId:uint = 0, parameters:Vector.<String> = null) : SystemMessageDisplayMessage
      {
         this.hangUp = hangUp;
         this.msgId = msgId;
         this.parameters = parameters;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.hangUp = false;
         this.msgId = 0;
         this.parameters = new Vector.<String>();
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
         this.serializeAs_SystemMessageDisplayMessage(output);
      }
      
      public function serializeAs_SystemMessageDisplayMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.hangUp);
         if(this.msgId < 0)
         {
            throw new Error("Forbidden value (" + this.msgId + ") on element msgId.");
         }
         output.writeVarShort(this.msgId);
         output.writeShort(this.parameters.length);
         for(var _i3:uint = 0; _i3 < this.parameters.length; _i3++)
         {
            output.writeUTF(this.parameters[_i3]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SystemMessageDisplayMessage(input);
      }
      
      public function deserializeAs_SystemMessageDisplayMessage(input:ICustomDataInput) : void
      {
         var _val3:String = null;
         this._hangUpFunc(input);
         this._msgIdFunc(input);
         var _parametersLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _parametersLen; _i3++)
         {
            _val3 = input.readUTF();
            this.parameters.push(_val3);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SystemMessageDisplayMessage(tree);
      }
      
      public function deserializeAsyncAs_SystemMessageDisplayMessage(tree:FuncTree) : void
      {
         tree.addChild(this._hangUpFunc);
         tree.addChild(this._msgIdFunc);
         this._parameterstree = tree.addChild(this._parameterstreeFunc);
      }
      
      private function _hangUpFunc(input:ICustomDataInput) : void
      {
         this.hangUp = input.readBoolean();
      }
      
      private function _msgIdFunc(input:ICustomDataInput) : void
      {
         this.msgId = input.readVarUhShort();
         if(this.msgId < 0)
         {
            throw new Error("Forbidden value (" + this.msgId + ") on element of SystemMessageDisplayMessage.msgId.");
         }
      }
      
      private function _parameterstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._parameterstree.addChild(this._parametersFunc);
         }
      }
      
      private function _parametersFunc(input:ICustomDataInput) : void
      {
         var _val:String = input.readUTF();
         this.parameters.push(_val);
      }
   }
}
