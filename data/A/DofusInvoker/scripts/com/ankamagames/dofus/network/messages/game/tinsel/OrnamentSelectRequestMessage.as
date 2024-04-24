package com.ankamagames.dofus.network.messages.game.tinsel
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class OrnamentSelectRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9551;
       
      
      private var _isInitialized:Boolean = false;
      
      public var ornamentId:uint = 0;
      
      public function OrnamentSelectRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9551;
      }
      
      public function initOrnamentSelectRequestMessage(ornamentId:uint = 0) : OrnamentSelectRequestMessage
      {
         this.ornamentId = ornamentId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.ornamentId = 0;
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
         this.serializeAs_OrnamentSelectRequestMessage(output);
      }
      
      public function serializeAs_OrnamentSelectRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.ornamentId < 0)
         {
            throw new Error("Forbidden value (" + this.ornamentId + ") on element ornamentId.");
         }
         output.writeVarShort(this.ornamentId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_OrnamentSelectRequestMessage(input);
      }
      
      public function deserializeAs_OrnamentSelectRequestMessage(input:ICustomDataInput) : void
      {
         this._ornamentIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_OrnamentSelectRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_OrnamentSelectRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._ornamentIdFunc);
      }
      
      private function _ornamentIdFunc(input:ICustomDataInput) : void
      {
         this.ornamentId = input.readVarUhShort();
         if(this.ornamentId < 0)
         {
            throw new Error("Forbidden value (" + this.ornamentId + ") on element of OrnamentSelectRequestMessage.ornamentId.");
         }
      }
   }
}
