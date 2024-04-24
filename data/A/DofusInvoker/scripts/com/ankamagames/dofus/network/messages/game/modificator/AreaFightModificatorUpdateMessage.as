package com.ankamagames.dofus.network.messages.game.modificator
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AreaFightModificatorUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2162;
       
      
      private var _isInitialized:Boolean = false;
      
      public var spellPairId:int = 0;
      
      public function AreaFightModificatorUpdateMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2162;
      }
      
      public function initAreaFightModificatorUpdateMessage(spellPairId:int = 0) : AreaFightModificatorUpdateMessage
      {
         this.spellPairId = spellPairId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.spellPairId = 0;
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
         this.serializeAs_AreaFightModificatorUpdateMessage(output);
      }
      
      public function serializeAs_AreaFightModificatorUpdateMessage(output:ICustomDataOutput) : void
      {
         output.writeInt(this.spellPairId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AreaFightModificatorUpdateMessage(input);
      }
      
      public function deserializeAs_AreaFightModificatorUpdateMessage(input:ICustomDataInput) : void
      {
         this._spellPairIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AreaFightModificatorUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_AreaFightModificatorUpdateMessage(tree:FuncTree) : void
      {
         tree.addChild(this._spellPairIdFunc);
      }
      
      private function _spellPairIdFunc(input:ICustomDataInput) : void
      {
         this.spellPairId = input.readInt();
      }
   }
}
