package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceJoinedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5220;
       
      
      private var _isInitialized:Boolean = false;
      
      public var allianceInfo:AllianceInformation;
      
      public var rankId:uint = 0;
      
      private var _allianceInfotree:FuncTree;
      
      public function AllianceJoinedMessage()
      {
         this.allianceInfo = new AllianceInformation();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5220;
      }
      
      public function initAllianceJoinedMessage(allianceInfo:AllianceInformation = null, rankId:uint = 0) : AllianceJoinedMessage
      {
         this.allianceInfo = allianceInfo;
         this.rankId = rankId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.allianceInfo = new AllianceInformation();
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
         this.serializeAs_AllianceJoinedMessage(output);
      }
      
      public function serializeAs_AllianceJoinedMessage(output:ICustomDataOutput) : void
      {
         this.allianceInfo.serializeAs_AllianceInformation(output);
         if(this.rankId < 0)
         {
            throw new Error("Forbidden value (" + this.rankId + ") on element rankId.");
         }
         output.writeVarInt(this.rankId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceJoinedMessage(input);
      }
      
      public function deserializeAs_AllianceJoinedMessage(input:ICustomDataInput) : void
      {
         this.allianceInfo = new AllianceInformation();
         this.allianceInfo.deserialize(input);
         this._rankIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceJoinedMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceJoinedMessage(tree:FuncTree) : void
      {
         this._allianceInfotree = tree.addChild(this._allianceInfotreeFunc);
         tree.addChild(this._rankIdFunc);
      }
      
      private function _allianceInfotreeFunc(input:ICustomDataInput) : void
      {
         this.allianceInfo = new AllianceInformation();
         this.allianceInfo.deserializeAsync(this._allianceInfotree);
      }
      
      private function _rankIdFunc(input:ICustomDataInput) : void
      {
         this.rankId = input.readVarUhInt();
         if(this.rankId < 0)
         {
            throw new Error("Forbidden value (" + this.rankId + ") on element of AllianceJoinedMessage.rankId.");
         }
      }
   }
}
