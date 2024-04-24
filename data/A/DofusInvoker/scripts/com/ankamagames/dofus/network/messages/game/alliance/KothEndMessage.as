package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.dofus.network.types.game.alliance.KothWinner;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class KothEndMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6893;
       
      
      private var _isInitialized:Boolean = false;
      
      public var winner:KothWinner;
      
      private var _winnertree:FuncTree;
      
      public function KothEndMessage()
      {
         this.winner = new KothWinner();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6893;
      }
      
      public function initKothEndMessage(winner:KothWinner = null) : KothEndMessage
      {
         this.winner = winner;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.winner = new KothWinner();
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
         this.serializeAs_KothEndMessage(output);
      }
      
      public function serializeAs_KothEndMessage(output:ICustomDataOutput) : void
      {
         this.winner.serializeAs_KothWinner(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_KothEndMessage(input);
      }
      
      public function deserializeAs_KothEndMessage(input:ICustomDataInput) : void
      {
         this.winner = new KothWinner();
         this.winner.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_KothEndMessage(tree);
      }
      
      public function deserializeAsyncAs_KothEndMessage(tree:FuncTree) : void
      {
         this._winnertree = tree.addChild(this._winnertreeFunc);
      }
      
      private function _winnertreeFunc(input:ICustomDataInput) : void
      {
         this.winner = new KothWinner();
         this.winner.deserializeAsync(this._winnertree);
      }
   }
}
