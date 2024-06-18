package com.ankamagames.dofus.network.messages.game.alliance.application
{
   import com.ankamagames.dofus.network.messages.game.PaginationRequestAbstractMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceListApplicationRequestMessage extends PaginationRequestAbstractMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7241;
       
      
      private var _isInitialized:Boolean = false;
      
      public function AllianceListApplicationRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7241;
      }
      
      public function initAllianceListApplicationRequestMessage(offset:Number = 0, count:uint = 0) : AllianceListApplicationRequestMessage
      {
         super.initPaginationRequestAbstractMessage(offset,count);
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
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
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_AllianceListApplicationRequestMessage(output);
      }
      
      public function serializeAs_AllianceListApplicationRequestMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_PaginationRequestAbstractMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceListApplicationRequestMessage(input);
      }
      
      public function deserializeAs_AllianceListApplicationRequestMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceListApplicationRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceListApplicationRequestMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}
