package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.dofus.network.messages.game.social.SocialNoticeSetErrorMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildBulletinSetErrorMessage extends SocialNoticeSetErrorMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 8299;
       
      
      private var _isInitialized:Boolean = false;
      
      public function GuildBulletinSetErrorMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 8299;
      }
      
      public function initGuildBulletinSetErrorMessage(reason:uint = 0) : GuildBulletinSetErrorMessage
      {
         super.initSocialNoticeSetErrorMessage(reason);
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
         this.serializeAs_GuildBulletinSetErrorMessage(output);
      }
      
      public function serializeAs_GuildBulletinSetErrorMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_SocialNoticeSetErrorMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildBulletinSetErrorMessage(input);
      }
      
      public function deserializeAs_GuildBulletinSetErrorMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildBulletinSetErrorMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildBulletinSetErrorMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}
