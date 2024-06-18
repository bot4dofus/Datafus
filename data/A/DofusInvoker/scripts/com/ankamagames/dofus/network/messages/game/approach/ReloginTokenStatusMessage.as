package com.ankamagames.dofus.network.messages.game.approach
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ReloginTokenStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2673;
       
      
      private var _isInitialized:Boolean = false;
      
      public var validToken:Boolean = false;
      
      [Transient]
      public var token:String = "";
      
      public function ReloginTokenStatusMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2673;
      }
      
      public function initReloginTokenStatusMessage(validToken:Boolean = false, token:String = "") : ReloginTokenStatusMessage
      {
         this.validToken = validToken;
         this.token = token;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.validToken = false;
         this.token = "";
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
         this.serializeAs_ReloginTokenStatusMessage(output);
      }
      
      public function serializeAs_ReloginTokenStatusMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.validToken);
         output.writeUTF(this.token);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ReloginTokenStatusMessage(input);
      }
      
      public function deserializeAs_ReloginTokenStatusMessage(input:ICustomDataInput) : void
      {
         this._validTokenFunc(input);
         this._tokenFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ReloginTokenStatusMessage(tree);
      }
      
      public function deserializeAsyncAs_ReloginTokenStatusMessage(tree:FuncTree) : void
      {
         tree.addChild(this._validTokenFunc);
         tree.addChild(this._tokenFunc);
      }
      
      private function _validTokenFunc(input:ICustomDataInput) : void
      {
         this.validToken = input.readBoolean();
      }
      
      private function _tokenFunc(input:ICustomDataInput) : void
      {
         this.token = input.readUTF();
      }
   }
}
