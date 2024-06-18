package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceJoinAutomaticallyRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 468;
       
      
      private var _isInitialized:Boolean = false;
      
      public var allianceId:int = 0;
      
      public function AllianceJoinAutomaticallyRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 468;
      }
      
      public function initAllianceJoinAutomaticallyRequestMessage(allianceId:int = 0) : AllianceJoinAutomaticallyRequestMessage
      {
         this.allianceId = allianceId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.allianceId = 0;
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
         this.serializeAs_AllianceJoinAutomaticallyRequestMessage(output);
      }
      
      public function serializeAs_AllianceJoinAutomaticallyRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeInt(this.allianceId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceJoinAutomaticallyRequestMessage(input);
      }
      
      public function deserializeAs_AllianceJoinAutomaticallyRequestMessage(input:ICustomDataInput) : void
      {
         this._allianceIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceJoinAutomaticallyRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceJoinAutomaticallyRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._allianceIdFunc);
      }
      
      private function _allianceIdFunc(input:ICustomDataInput) : void
      {
         this.allianceId = input.readInt();
      }
   }
}
