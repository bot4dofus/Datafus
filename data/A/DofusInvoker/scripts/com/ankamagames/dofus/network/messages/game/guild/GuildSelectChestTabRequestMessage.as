package com.ankamagames.dofus.network.messages.game.guild
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class GuildSelectChestTabRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7367;
       
      
      private var _isInitialized:Boolean = false;
      
      public var tabNumber:uint = 0;
      
      public function GuildSelectChestTabRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7367;
      }
      
      public function initGuildSelectChestTabRequestMessage(tabNumber:uint = 0) : GuildSelectChestTabRequestMessage
      {
         this.tabNumber = tabNumber;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.tabNumber = 0;
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
         this.serializeAs_GuildSelectChestTabRequestMessage(output);
      }
      
      public function serializeAs_GuildSelectChestTabRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.tabNumber < 0)
         {
            throw new Error("Forbidden value (" + this.tabNumber + ") on element tabNumber.");
         }
         output.writeVarInt(this.tabNumber);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GuildSelectChestTabRequestMessage(input);
      }
      
      public function deserializeAs_GuildSelectChestTabRequestMessage(input:ICustomDataInput) : void
      {
         this._tabNumberFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GuildSelectChestTabRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_GuildSelectChestTabRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._tabNumberFunc);
      }
      
      private function _tabNumberFunc(input:ICustomDataInput) : void
      {
         this.tabNumber = input.readVarUhInt();
         if(this.tabNumber < 0)
         {
            throw new Error("Forbidden value (" + this.tabNumber + ") on element of GuildSelectChestTabRequestMessage.tabNumber.");
         }
      }
   }
}
