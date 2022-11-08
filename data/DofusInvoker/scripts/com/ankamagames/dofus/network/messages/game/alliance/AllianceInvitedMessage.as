package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.dofus.network.types.game.context.roleplay.BasicNamedAllianceInformations;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceInvitedMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8799;
       
      
      private var _isInitialized:Boolean = false;
      
      public var recruterId:Number = 0;
      
      public var recruterName:String = "";
      
      public var allianceInfo:BasicNamedAllianceInformations;
      
      private var _allianceInfotree:FuncTree;
      
      public function AllianceInvitedMessage()
      {
         this.allianceInfo = new BasicNamedAllianceInformations();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8799;
      }
      
      public function initAllianceInvitedMessage(recruterId:Number = 0, recruterName:String = "", allianceInfo:BasicNamedAllianceInformations = null) : AllianceInvitedMessage
      {
         this.recruterId = recruterId;
         this.recruterName = recruterName;
         this.allianceInfo = allianceInfo;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.recruterId = 0;
         this.recruterName = "";
         this.allianceInfo = new BasicNamedAllianceInformations();
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
         this.serializeAs_AllianceInvitedMessage(output);
      }
      
      public function serializeAs_AllianceInvitedMessage(output:ICustomDataOutput) : void
      {
         if(this.recruterId < 0 || this.recruterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.recruterId + ") on element recruterId.");
         }
         output.writeVarLong(this.recruterId);
         output.writeUTF(this.recruterName);
         this.allianceInfo.serializeAs_BasicNamedAllianceInformations(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceInvitedMessage(input);
      }
      
      public function deserializeAs_AllianceInvitedMessage(input:ICustomDataInput) : void
      {
         this._recruterIdFunc(input);
         this._recruterNameFunc(input);
         this.allianceInfo = new BasicNamedAllianceInformations();
         this.allianceInfo.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceInvitedMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceInvitedMessage(tree:FuncTree) : void
      {
         tree.addChild(this._recruterIdFunc);
         tree.addChild(this._recruterNameFunc);
         this._allianceInfotree = tree.addChild(this._allianceInfotreeFunc);
      }
      
      private function _recruterIdFunc(input:ICustomDataInput) : void
      {
         this.recruterId = input.readVarUhLong();
         if(this.recruterId < 0 || this.recruterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.recruterId + ") on element of AllianceInvitedMessage.recruterId.");
         }
      }
      
      private function _recruterNameFunc(input:ICustomDataInput) : void
      {
         this.recruterName = input.readUTF();
      }
      
      private function _allianceInfotreeFunc(input:ICustomDataInput) : void
      {
         this.allianceInfo = new BasicNamedAllianceInformations();
         this.allianceInfo.deserializeAsync(this._allianceInfotree);
      }
   }
}
