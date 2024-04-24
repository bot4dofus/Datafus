package com.ankamagames.dofus.network.messages.game.alliance.application
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.AllianceInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceApplicationIsAnsweredMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7034;
       
      
      private var _isInitialized:Boolean = false;
      
      public var accepted:Boolean = false;
      
      public var allianceInformation:AllianceInformation;
      
      private var _allianceInformationtree:FuncTree;
      
      public function AllianceApplicationIsAnsweredMessage()
      {
         this.allianceInformation = new AllianceInformation();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7034;
      }
      
      public function initAllianceApplicationIsAnsweredMessage(accepted:Boolean = false, allianceInformation:AllianceInformation = null) : AllianceApplicationIsAnsweredMessage
      {
         this.accepted = accepted;
         this.allianceInformation = allianceInformation;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.accepted = false;
         this.allianceInformation = new AllianceInformation();
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
         this.serializeAs_AllianceApplicationIsAnsweredMessage(output);
      }
      
      public function serializeAs_AllianceApplicationIsAnsweredMessage(output:ICustomDataOutput) : void
      {
         output.writeBoolean(this.accepted);
         this.allianceInformation.serializeAs_AllianceInformation(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceApplicationIsAnsweredMessage(input);
      }
      
      public function deserializeAs_AllianceApplicationIsAnsweredMessage(input:ICustomDataInput) : void
      {
         this._acceptedFunc(input);
         this.allianceInformation = new AllianceInformation();
         this.allianceInformation.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceApplicationIsAnsweredMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceApplicationIsAnsweredMessage(tree:FuncTree) : void
      {
         tree.addChild(this._acceptedFunc);
         this._allianceInformationtree = tree.addChild(this._allianceInformationtreeFunc);
      }
      
      private function _acceptedFunc(input:ICustomDataInput) : void
      {
         this.accepted = input.readBoolean();
      }
      
      private function _allianceInformationtreeFunc(input:ICustomDataInput) : void
      {
         this.allianceInformation = new AllianceInformation();
         this.allianceInformation.deserializeAsync(this._allianceInformationtree);
      }
   }
}
