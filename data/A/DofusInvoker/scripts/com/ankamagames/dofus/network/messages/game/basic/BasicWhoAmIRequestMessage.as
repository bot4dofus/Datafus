package com.ankamagames.dofus.network.messages.game.basic
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BasicWhoAmIRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 390;
       
      
      private var _isInitialized:Boolean = false;
      
      public var verbose:Boolean = false;
      
      public function BasicWhoAmIRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 390;
      }
      
      public function initBasicWhoAmIRequestMessage(verbose:Boolean = false) : BasicWhoAmIRequestMessage
      {
         this.verbose = verbose;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.verbose = false;
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
         this.serializeAs_BasicWhoAmIRequestMessage(output);
      }
      
      public function serializeAs_BasicWhoAmIRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.verbose);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BasicWhoAmIRequestMessage(input);
      }
      
      public function deserializeAs_BasicWhoAmIRequestMessage(input:ICustomDataInput) : void
      {
         this._verboseFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BasicWhoAmIRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_BasicWhoAmIRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._verboseFunc);
      }
      
      private function _verboseFunc(input:ICustomDataInput) : void
      {
         this.verbose = input.readBoolean();
      }
   }
}
