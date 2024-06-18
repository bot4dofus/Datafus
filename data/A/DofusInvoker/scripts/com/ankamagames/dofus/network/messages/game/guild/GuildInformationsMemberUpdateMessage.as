package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.dofus.network.types.game.guild.GuildMemberInfo;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildInformationsMemberUpdateMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6708;
       
      
      private var _isInitialized:Boolean = false;
      
      public var member:GuildMemberInfo;
      
      private var _membertree:FuncTree;
      
      public function GuildInformationsMemberUpdateMessage()
      {
         this.member = new GuildMemberInfo();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6708;
      }
      
      public function initGuildInformationsMemberUpdateMessage(member:GuildMemberInfo = null) : GuildInformationsMemberUpdateMessage
      {
         this.member = member;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.member = new GuildMemberInfo();
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
         this.serializeAs_GuildInformationsMemberUpdateMessage(output);
      }
      
      public function serializeAs_GuildInformationsMemberUpdateMessage(output:ICustomDataOutput) : void
      {
         this.member.serializeAs_GuildMemberInfo(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildInformationsMemberUpdateMessage(input);
      }
      
      public function deserializeAs_GuildInformationsMemberUpdateMessage(input:ICustomDataInput) : void
      {
         this.member = new GuildMemberInfo();
         this.member.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildInformationsMemberUpdateMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildInformationsMemberUpdateMessage(tree:FuncTree) : void
      {
         this._membertree = tree.addChild(this._membertreeFunc);
      }
      
      private function _membertreeFunc(input:ICustomDataInput) : void
      {
         this.member = new GuildMemberInfo();
         this.member.deserializeAsync(this._membertree);
      }
   }
}
