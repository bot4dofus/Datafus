package com.ankamagames.dofus.network.messages.game.alliance.application
{
   import com.ankamagames.dofus.network.types.game.social.application.SocialApplicationInformation;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceListApplicationModifiedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 3470;
       
      
      private var _isInitialized:Boolean = false;
      
      public var apply:SocialApplicationInformation;
      
      public var state:uint = 0;
      
      public var playerId:Number = 0;
      
      private var _applytree:FuncTree;
      
      public function AllianceListApplicationModifiedMessage()
      {
         this.apply = new SocialApplicationInformation();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 3470;
      }
      
      public function initAllianceListApplicationModifiedMessage(apply:SocialApplicationInformation = null, state:uint = 0, playerId:Number = 0) : AllianceListApplicationModifiedMessage
      {
         this.apply = apply;
         this.state = state;
         this.playerId = playerId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.apply = new SocialApplicationInformation();
         this.playerId = 0;
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
         this.serializeAs_AllianceListApplicationModifiedMessage(output);
      }
      
      public function serializeAs_AllianceListApplicationModifiedMessage(output:ICustomDataOutput) : void
      {
         this.apply.serializeAs_SocialApplicationInformation(output);
         output.writeByte(this.state);
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element playerId.");
         }
         output.writeVarLong(this.playerId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceListApplicationModifiedMessage(input);
      }
      
      public function deserializeAs_AllianceListApplicationModifiedMessage(input:ICustomDataInput) : void
      {
         this.apply = new SocialApplicationInformation();
         this.apply.deserialize(input);
         this._stateFunc(input);
         this._playerIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceListApplicationModifiedMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceListApplicationModifiedMessage(tree:FuncTree) : void
      {
         this._applytree = tree.addChild(this._applytreeFunc);
         tree.addChild(this._stateFunc);
         tree.addChild(this._playerIdFunc);
      }
      
      private function _applytreeFunc(input:ICustomDataInput) : void
      {
         this.apply = new SocialApplicationInformation();
         this.apply.deserializeAsync(this._applytree);
      }
      
      private function _stateFunc(input:ICustomDataInput) : void
      {
         this.state = input.readByte();
         if(this.state < 0)
         {
            throw new Error("Forbidden value (" + this.state + ") on element of AllianceListApplicationModifiedMessage.state.");
         }
      }
      
      private function _playerIdFunc(input:ICustomDataInput) : void
      {
         this.playerId = input.readVarUhLong();
         if(this.playerId < 0 || this.playerId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.playerId + ") on element of AllianceListApplicationModifiedMessage.playerId.");
         }
      }
   }
}
