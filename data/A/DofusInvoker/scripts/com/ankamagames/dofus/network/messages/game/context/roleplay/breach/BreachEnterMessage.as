package com.ankamagames.dofus.network.messages.game.context.roleplay.breach
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BreachEnterMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9138;
       
      
      private var _isInitialized:Boolean = false;
      
      public var owner:Number = 0;
      
      public function BreachEnterMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9138;
      }
      
      public function initBreachEnterMessage(owner:Number = 0) : BreachEnterMessage
      {
         this.owner = owner;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.owner = 0;
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
         this.serializeAs_BreachEnterMessage(output);
      }
      
      public function serializeAs_BreachEnterMessage(output:ICustomDataOutput) : void
      {
         if(this.owner < 0 || this.owner > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.owner + ") on element owner.");
         }
         output.writeVarLong(this.owner);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BreachEnterMessage(input);
      }
      
      public function deserializeAs_BreachEnterMessage(input:ICustomDataInput) : void
      {
         this._ownerFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BreachEnterMessage(tree);
      }
      
      public function deserializeAsyncAs_BreachEnterMessage(tree:FuncTree) : void
      {
         tree.addChild(this._ownerFunc);
      }
      
      private function _ownerFunc(input:ICustomDataInput) : void
      {
         this.owner = input.readVarUhLong();
         if(this.owner < 0 || this.owner > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.owner + ") on element of BreachEnterMessage.owner.");
         }
      }
   }
}
