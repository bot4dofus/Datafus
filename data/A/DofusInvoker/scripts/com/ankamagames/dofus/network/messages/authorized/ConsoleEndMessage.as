package com.ankamagames.dofus.network.messages.authorized
{
   import com.ankamagames.dofus.network.types.game.Uuid;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ConsoleEndMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 111;
       
      
      private var _isInitialized:Boolean = false;
      
      public var consoleUuid:Uuid;
      
      public var isSuccess:Boolean = false;
      
      private var _consoleUuidtree:FuncTree;
      
      public function ConsoleEndMessage()
      {
         this.consoleUuid = new Uuid();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 111;
      }
      
      public function initConsoleEndMessage(consoleUuid:Uuid = null, isSuccess:Boolean = false) : ConsoleEndMessage
      {
         this.consoleUuid = consoleUuid;
         this.isSuccess = isSuccess;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.consoleUuid = new Uuid();
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
         this.serializeAs_ConsoleEndMessage(output);
      }
      
      public function serializeAs_ConsoleEndMessage(output:ICustomDataOutput) : void
      {
         this.consoleUuid.serializeAs_Uuid(output);
         output.writeBoolean(this.isSuccess);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ConsoleEndMessage(input);
      }
      
      public function deserializeAs_ConsoleEndMessage(input:ICustomDataInput) : void
      {
         this.consoleUuid = new Uuid();
         this.consoleUuid.deserialize(input);
         this._isSuccessFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ConsoleEndMessage(tree);
      }
      
      public function deserializeAsyncAs_ConsoleEndMessage(tree:FuncTree) : void
      {
         this._consoleUuidtree = tree.addChild(this._consoleUuidtreeFunc);
         tree.addChild(this._isSuccessFunc);
      }
      
      private function _consoleUuidtreeFunc(input:ICustomDataInput) : void
      {
         this.consoleUuid = new Uuid();
         this.consoleUuid.deserializeAsync(this._consoleUuidtree);
      }
      
      private function _isSuccessFunc(input:ICustomDataInput) : void
      {
         this.isSuccess = input.readBoolean();
      }
   }
}
