package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.dofus.network.messages.game.social.BulletinMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildBulletinMessage extends BulletinMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4247;
       
      
      private var _isInitialized:Boolean = false;
      
      public function GuildBulletinMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4247;
      }
      
      public function initGuildBulletinMessage(content:String = "", timestamp:uint = 0, memberId:Number = 0, memberName:String = "") : GuildBulletinMessage
      {
         super.initBulletinMessage(content,timestamp,memberId,memberName);
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
         this.serializeAs_GuildBulletinMessage(output);
      }
      
      public function serializeAs_GuildBulletinMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_BulletinMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildBulletinMessage(input);
      }
      
      public function deserializeAs_GuildBulletinMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildBulletinMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildBulletinMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}
