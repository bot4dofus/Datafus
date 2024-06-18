package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.dofus.network.types.game.context.IdentifiedEntityDispositionInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GameEntityDispositionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4;
       
      
      private var _isInitialized:Boolean = false;
      
      public var disposition:IdentifiedEntityDispositionInformations;
      
      private var _dispositiontree:FuncTree;
      
      public function GameEntityDispositionMessage()
      {
         this.disposition = new IdentifiedEntityDispositionInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4;
      }
      
      public function initGameEntityDispositionMessage(disposition:IdentifiedEntityDispositionInformations = null) : GameEntityDispositionMessage
      {
         this.disposition = disposition;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.disposition = new IdentifiedEntityDispositionInformations();
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
         this.serializeAs_GameEntityDispositionMessage(output);
      }
      
      public function serializeAs_GameEntityDispositionMessage(output:ICustomDataOutput) : void
      {
         this.disposition.serializeAs_IdentifiedEntityDispositionInformations(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameEntityDispositionMessage(input);
      }
      
      public function deserializeAs_GameEntityDispositionMessage(input:ICustomDataInput) : void
      {
         this.disposition = new IdentifiedEntityDispositionInformations();
         this.disposition.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameEntityDispositionMessage(tree);
      }
      
      public function deserializeAsyncAs_GameEntityDispositionMessage(tree:FuncTree) : void
      {
         this._dispositiontree = tree.addChild(this._dispositiontreeFunc);
      }
      
      private function _dispositiontreeFunc(input:ICustomDataInput) : void
      {
         this.disposition = new IdentifiedEntityDispositionInformations();
         this.disposition.deserializeAsync(this._dispositiontree);
      }
   }
}
