package com.ankamagames.dofus.network.messages.game.alliance.application
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceApplicationDeletedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9346;
       
      
      private var _isInitialized:Boolean = false;
      
      public var deleted:Boolean = false;
      
      public function AllianceApplicationDeletedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9346;
      }
      
      public function initAllianceApplicationDeletedMessage(deleted:Boolean = false) : AllianceApplicationDeletedMessage
      {
         this.deleted = deleted;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.deleted = false;
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
         this.serializeAs_AllianceApplicationDeletedMessage(output);
      }
      
      public function serializeAs_AllianceApplicationDeletedMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.deleted);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceApplicationDeletedMessage(input);
      }
      
      public function deserializeAs_AllianceApplicationDeletedMessage(input:ICustomDataInput) : void
      {
         this._deletedFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceApplicationDeletedMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceApplicationDeletedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._deletedFunc);
      }
      
      private function _deletedFunc(input:ICustomDataInput) : void
      {
         this.deleted = input.readBoolean();
      }
   }
}
