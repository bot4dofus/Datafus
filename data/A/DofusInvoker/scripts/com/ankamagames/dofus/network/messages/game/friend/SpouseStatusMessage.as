package com.ankamagames.dofus.network.messages.game.friend
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class SpouseStatusMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8361;
       
      
      private var _isInitialized:Boolean = false;
      
      public var hasSpouse:Boolean = false;
      
      public function SpouseStatusMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8361;
      }
      
      public function initSpouseStatusMessage(hasSpouse:Boolean = false) : SpouseStatusMessage
      {
         this.hasSpouse = hasSpouse;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.hasSpouse = false;
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
         this.serializeAs_SpouseStatusMessage(output);
      }
      
      public function serializeAs_SpouseStatusMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.hasSpouse);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_SpouseStatusMessage(input);
      }
      
      public function deserializeAs_SpouseStatusMessage(input:ICustomDataInput) : void
      {
         this._hasSpouseFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_SpouseStatusMessage(tree);
      }
      
      public function deserializeAsyncAs_SpouseStatusMessage(tree:FuncTree) : void
      {
         tree.addChild(this._hasSpouseFunc);
      }
      
      private function _hasSpouseFunc(input:ICustomDataInput) : void
      {
         this.hasSpouse = input.readBoolean();
      }
   }
}
