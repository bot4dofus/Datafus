package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.dofus.network.messages.game.social.SocialNoticeMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildMotdMessage extends SocialNoticeMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4318;
       
      
      private var _isInitialized:Boolean = false;
      
      public function GuildMotdMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4318;
      }
      
      public function initGuildMotdMessage(content:String = "", timestamp:uint = 0, memberId:Number = 0, memberName:String = "") : GuildMotdMessage
      {
         super.initSocialNoticeMessage(content,timestamp,memberId,memberName);
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
         this.serializeAs_GuildMotdMessage(output);
      }
      
      public function serializeAs_GuildMotdMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_SocialNoticeMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildMotdMessage(input);
      }
      
      public function deserializeAs_GuildMotdMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildMotdMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildMotdMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}
