package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.dofus.network.messages.game.social.SocialNoticeSetRequestMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildBulletinSetRequestMessage extends SocialNoticeSetRequestMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6761;
       
      
      private var _isInitialized:Boolean = false;
      
      [Transient]
      public var content:String = "";
      
      public var notifyMembers:Boolean = false;
      
      public function GuildBulletinSetRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6761;
      }
      
      public function initGuildBulletinSetRequestMessage(content:String = "", notifyMembers:Boolean = false) : GuildBulletinSetRequestMessage
      {
         this.content = content;
         this.notifyMembers = notifyMembers;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.content = "";
         this.notifyMembers = false;
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
         this.serializeAs_GuildBulletinSetRequestMessage(output);
      }
      
      public function serializeAs_GuildBulletinSetRequestMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_SocialNoticeSetRequestMessage(output);
         output.writeUTF(this.content);
         output.writeBoolean(this.notifyMembers);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildBulletinSetRequestMessage(input);
      }
      
      public function deserializeAs_GuildBulletinSetRequestMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._contentFunc(input);
         this._notifyMembersFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildBulletinSetRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildBulletinSetRequestMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._contentFunc);
         tree.addChild(this._notifyMembersFunc);
      }
      
      private function _contentFunc(input:ICustomDataInput) : void
      {
         this.content = input.readUTF();
      }
      
      private function _notifyMembersFunc(input:ICustomDataInput) : void
      {
         this.notifyMembers = input.readBoolean();
      }
   }
}
