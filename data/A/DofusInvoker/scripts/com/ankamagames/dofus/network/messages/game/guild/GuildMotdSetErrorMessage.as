package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.dofus.network.messages.game.social.SocialNoticeSetErrorMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildMotdSetErrorMessage extends SocialNoticeSetErrorMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6422;
       
      
      private var _isInitialized:Boolean = false;
      
      public function GuildMotdSetErrorMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6422;
      }
      
      public function initGuildMotdSetErrorMessage(reason:uint = 0) : GuildMotdSetErrorMessage
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
         this.serializeAs_GuildMotdSetErrorMessage(output);
      }
      
      public function serializeAs_GuildMotdSetErrorMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_SocialNoticeSetErrorMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildMotdSetErrorMessage(input);
      }
      
      public function deserializeAs_GuildMotdSetErrorMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildMotdSetErrorMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildMotdSetErrorMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}
