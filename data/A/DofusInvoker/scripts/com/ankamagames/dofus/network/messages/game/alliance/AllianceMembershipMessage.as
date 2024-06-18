package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceMembershipMessage extends AllianceJoinedMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3547;
       
      
      private var _isInitialized:Boolean = false;
      
      public function AllianceMembershipMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3547;
      }
      
      public function initAllianceMembershipMessage(allianceInfo:AllianceInformation = null, rankId:uint = 0) : AllianceMembershipMessage
      {
         super.initAllianceJoinedMessage(allianceInfo,rankId);
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
         this.serializeAs_AllianceMembershipMessage(output);
      }
      
      public function serializeAs_AllianceMembershipMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_AllianceJoinedMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceMembershipMessage(input);
      }
      
      public function deserializeAs_AllianceMembershipMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceMembershipMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceMembershipMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}
