package com.ankamagames.dofus.network.messages.game.context.roleplay.breach
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BreachBudgetMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 687;
       
      
      private var _isInitialized:Boolean = false;
      
      public var bugdet:uint = 0;
      
      public function BreachBudgetMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 687;
      }
      
      public function initBreachBudgetMessage(bugdet:uint = 0) : BreachBudgetMessage
      {
         this.bugdet = bugdet;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.bugdet = 0;
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
         this.serializeAs_BreachBudgetMessage(output);
      }
      
      public function serializeAs_BreachBudgetMessage(output:ICustomDataOutput) : void
      {
         if(this.bugdet < 0)
         {
            throw new Error("Forbidden value (" + this.bugdet + ") on element bugdet.");
         }
         output.writeVarInt(this.bugdet);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BreachBudgetMessage(input);
      }
      
      public function deserializeAs_BreachBudgetMessage(input:ICustomDataInput) : void
      {
         this._bugdetFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BreachBudgetMessage(tree);
      }
      
      public function deserializeAsyncAs_BreachBudgetMessage(tree:FuncTree) : void
      {
         tree.addChild(this._bugdetFunc);
      }
      
      private function _bugdetFunc(input:ICustomDataInput) : void
      {
         this.bugdet = input.readVarUhInt();
         if(this.bugdet < 0)
         {
            throw new Error("Forbidden value (" + this.bugdet + ") on element of BreachBudgetMessage.bugdet.");
         }
      }
   }
}
