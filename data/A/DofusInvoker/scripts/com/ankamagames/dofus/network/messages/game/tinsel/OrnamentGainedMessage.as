package com.ankamagames.dofus.network.messages.game.tinsel
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class OrnamentGainedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7842;
       
      
      private var _isInitialized:Boolean = false;
      
      public var ornamentId:uint = 0;
      
      public function OrnamentGainedMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7842;
      }
      
      public function initOrnamentGainedMessage(ornamentId:uint = 0) : OrnamentGainedMessage
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
         this.serializeAs_OrnamentGainedMessage(output);
      }
      
      public function serializeAs_OrnamentGainedMessage(output:ICustomDataOutput) : void
      {
         if(this.ornamentId < 0)
         {
            throw new Error("Forbidden value (" + this.ornamentId + ") on element ornamentId.");
         }
         output.writeShort(this.ornamentId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_OrnamentGainedMessage(input);
      }
      
      public function deserializeAs_OrnamentGainedMessage(input:ICustomDataInput) : void
      {
         this._ornamentIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_OrnamentGainedMessage(tree);
      }
      
      public function deserializeAsyncAs_OrnamentGainedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._ornamentIdFunc);
      }
      
      private function _ornamentIdFunc(input:ICustomDataInput) : void
      {
         this.ornamentId = input.readShort();
         if(this.ornamentId < 0)
         {
            throw new Error("Forbidden value (" + this.ornamentId + ") on element of OrnamentGainedMessage.ornamentId.");
         }
      }
   }
}
