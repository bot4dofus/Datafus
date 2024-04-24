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
   
   public class GuildInformationsMembersMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4402;
       
      
      private var _isInitialized:Boolean = false;
      
      public var members:Vector.<GuildMemberInfo>;
      
      private var _memberstree:FuncTree;
      
      public function GuildInformationsMembersMessage()
      {
         this.members = new Vector.<GuildMemberInfo>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4402;
      }
      
      public function initGuildInformationsMembersMessage(members:Vector.<GuildMemberInfo> = null) : GuildInformationsMembersMessage
      {
         this.members = members;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.members = new Vector.<GuildMemberInfo>();
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
         this.serializeAs_GuildInformationsMembersMessage(output);
      }
      
      public function serializeAs_GuildInformationsMembersMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.members.length);
         for(var _i1:uint = 0; _i1 < this.members.length; _i1++)
         {
            (this.members[_i1] as GuildMemberInfo).serializeAs_GuildMemberInfo(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildInformationsMembersMessage(input);
      }
      
      public function deserializeAs_GuildInformationsMembersMessage(input:ICustomDataInput) : void
      {
         var _item1:GuildMemberInfo = null;
         var _membersLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _membersLen; _i1++)
         {
            _item1 = new GuildMemberInfo();
            _item1.deserialize(input);
            this.members.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildInformationsMembersMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildInformationsMembersMessage(tree:FuncTree) : void
      {
         this._memberstree = tree.addChild(this._memberstreeFunc);
      }
      
      private function _memberstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._memberstree.addChild(this._membersFunc);
         }
      }
      
      private function _membersFunc(input:ICustomDataInput) : void
      {
         var _item:GuildMemberInfo = new GuildMemberInfo();
         _item.deserialize(input);
         this.members.push(_item);
      }
   }
}
