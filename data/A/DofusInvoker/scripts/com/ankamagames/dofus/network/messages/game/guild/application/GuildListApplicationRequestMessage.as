package com.ankamagames.dofus.network.messages.game.guild.application
{
   import com.ankamagames.dofus.network.messages.game.PaginationRequestAbstractMessage;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildListApplicationRequestMessage extends PaginationRequestAbstractMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 695;
       
      
      private var _isInitialized:Boolean = false;
      
      public function GuildListApplicationRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 695;
      }
      
      public function initGuildListApplicationRequestMessage(offset:Number = 0, count:uint = 0) : GuildListApplicationRequestMessage
      {
         super.initPaginationRequestAbstractMessage(offset,count);
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
         this.serializeAs_GuildListApplicationRequestMessage(output);
      }
      
      public function serializeAs_GuildListApplicationRequestMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_PaginationRequestAbstractMessage(output);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildListApplicationRequestMessage(input);
      }
      
      public function deserializeAs_GuildListApplicationRequestMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildListApplicationRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildListApplicationRequestMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
      }
   }
}
