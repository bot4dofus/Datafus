package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildChestTabLastContributionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6777;
       
      
      private var _isInitialized:Boolean = false;
      
      public var lastContributionDate:Number = 0;
      
      public function GuildChestTabLastContributionMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6777;
      }
      
      public function initGuildChestTabLastContributionMessage(lastContributionDate:Number = 0) : GuildChestTabLastContributionMessage
      {
         this.lastContributionDate = lastContributionDate;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.lastContributionDate = 0;
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
         this.serializeAs_GuildChestTabLastContributionMessage(output);
      }
      
      public function serializeAs_GuildChestTabLastContributionMessage(output:ICustomDataOutput) : void
      {
         if(this.lastContributionDate < 0 || this.lastContributionDate > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.lastContributionDate + ") on element lastContributionDate.");
         }
         output.writeDouble(this.lastContributionDate);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildChestTabLastContributionMessage(input);
      }
      
      public function deserializeAs_GuildChestTabLastContributionMessage(input:ICustomDataInput) : void
      {
         this._lastContributionDateFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildChestTabLastContributionMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildChestTabLastContributionMessage(tree:FuncTree) : void
      {
         tree.addChild(this._lastContributionDateFunc);
      }
      
      private function _lastContributionDateFunc(input:ICustomDataInput) : void
      {
         this.lastContributionDate = input.readDouble();
         if(this.lastContributionDate < 0 || this.lastContributionDate > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.lastContributionDate + ") on element of GuildChestTabLastContributionMessage.lastContributionDate.");
         }
      }
   }
}
