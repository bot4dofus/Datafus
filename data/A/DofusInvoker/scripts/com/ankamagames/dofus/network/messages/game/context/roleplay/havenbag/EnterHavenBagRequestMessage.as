package com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class EnterHavenBagRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4036;
       
      
      private var _isInitialized:Boolean = false;
      
      public var havenBagOwner:Number = 0;
      
      public function EnterHavenBagRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4036;
      }
      
      public function initEnterHavenBagRequestMessage(havenBagOwner:Number = 0) : EnterHavenBagRequestMessage
      {
         this.havenBagOwner = havenBagOwner;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.havenBagOwner = 0;
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
         this.serializeAs_EnterHavenBagRequestMessage(output);
      }
      
      public function serializeAs_EnterHavenBagRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.havenBagOwner < 0 || this.havenBagOwner > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.havenBagOwner + ") on element havenBagOwner.");
         }
         output.writeVarLong(this.havenBagOwner);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_EnterHavenBagRequestMessage(input);
      }
      
      public function deserializeAs_EnterHavenBagRequestMessage(input:ICustomDataInput) : void
      {
         this._havenBagOwnerFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_EnterHavenBagRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_EnterHavenBagRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._havenBagOwnerFunc);
      }
      
      private function _havenBagOwnerFunc(input:ICustomDataInput) : void
      {
         this.havenBagOwner = input.readVarUhLong();
         if(this.havenBagOwner < 0 || this.havenBagOwner > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.havenBagOwner + ") on element of EnterHavenBagRequestMessage.havenBagOwner.");
         }
      }
   }
}
