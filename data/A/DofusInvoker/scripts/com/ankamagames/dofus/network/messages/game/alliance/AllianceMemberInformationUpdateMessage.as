package com.ankamagames.dofus.network.messages.game.alliance
{
   import com.ankamagames.dofus.network.types.game.alliance.AllianceMemberInfo;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceMemberInformationUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8221;
       
      
      private var _isInitialized:Boolean = false;
      
      public var member:AllianceMemberInfo;
      
      private var _membertree:FuncTree;
      
      public function AllianceMemberInformationUpdateMessage()
      {
         this.member = new AllianceMemberInfo();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8221;
      }
      
      public function initAllianceMemberInformationUpdateMessage(member:AllianceMemberInfo = null) : AllianceMemberInformationUpdateMessage
      {
         this.member = member;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.member = new AllianceMemberInfo();
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
         this.serializeAs_AllianceMemberInformationUpdateMessage(output);
      }
      
      public function serializeAs_AllianceMemberInformationUpdateMessage(output:ICustomDataOutput) : void
      {
         this.member.serializeAs_AllianceMemberInfo(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceMemberInformationUpdateMessage(input);
      }
      
      public function deserializeAs_AllianceMemberInformationUpdateMessage(input:ICustomDataInput) : void
      {
         this.member = new AllianceMemberInfo();
         this.member.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceMemberInformationUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceMemberInformationUpdateMessage(tree:FuncTree) : void
      {
         this._membertree = tree.addChild(this._membertreeFunc);
      }
      
      private function _membertreeFunc(input:ICustomDataInput) : void
      {
         this.member = new AllianceMemberInfo();
         this.member.deserializeAsync(this._membertree);
      }
   }
}
