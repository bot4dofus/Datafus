package com.ankamagames.dofus.network.messages.game.startup
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class StartupActionsAllAttributionMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 5005;
       
      
      private var _isInitialized:Boolean = false;
      
      public var characterId:Number = 0;
      
      public function StartupActionsAllAttributionMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 5005;
      }
      
      public function initStartupActionsAllAttributionMessage(characterId:Number = 0) : StartupActionsAllAttributionMessage
      {
         this.characterId = characterId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.characterId = 0;
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
         this.serializeAs_StartupActionsAllAttributionMessage(output);
      }
      
      public function serializeAs_StartupActionsAllAttributionMessage(output:ICustomDataOutput) : void
      {
         if(this.characterId < 0 || this.characterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.characterId + ") on element characterId.");
         }
         output.writeVarLong(this.characterId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_StartupActionsAllAttributionMessage(input);
      }
      
      public function deserializeAs_StartupActionsAllAttributionMessage(input:ICustomDataInput) : void
      {
         this._characterIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_StartupActionsAllAttributionMessage(tree);
      }
      
      public function deserializeAsyncAs_StartupActionsAllAttributionMessage(tree:FuncTree) : void
      {
         tree.addChild(this._characterIdFunc);
      }
      
      private function _characterIdFunc(input:ICustomDataInput) : void
      {
         this.characterId = input.readVarUhLong();
         if(this.characterId < 0 || this.characterId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.characterId + ") on element of StartupActionsAllAttributionMessage.characterId.");
         }
      }
   }
}
