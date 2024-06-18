package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class NpcGenericActionRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 6670;
       
      
      private var _isInitialized:Boolean = false;
      
      public var npcId:int = 0;
      
      public var npcActionId:uint = 0;
      
      public var npcMapId:Number = 0;
      
      public function NpcGenericActionRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 6670;
      }
      
      public function initNpcGenericActionRequestMessage(npcId:int = 0, npcActionId:uint = 0, npcMapId:Number = 0) : NpcGenericActionRequestMessage
      {
         this.npcId = npcId;
         this.npcActionId = npcActionId;
         this.npcMapId = npcMapId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.npcId = 0;
         this.npcActionId = 0;
         this.npcMapId = 0;
         this._isInitialized = false;
      }
      
      override public function pack(output:ICustomDataOutput) : void
      {
         var data:ByteArray = new ByteArray();
         this.serialize(new CustomDataWrapper(data));
         if(HASH_FUNCTION != null)
         {
            HASH_FUNCTION(data);
         }
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
         this.serializeAs_NpcGenericActionRequestMessage(output);
      }
      
      public function serializeAs_NpcGenericActionRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeInt(this.npcId);
         if(this.npcActionId < 0)
         {
            throw new Error("Forbidden value (" + this.npcActionId + ") on element npcActionId.");
         }
         output.writeByte(this.npcActionId);
         if(this.npcMapId < 0 || this.npcMapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.npcMapId + ") on element npcMapId.");
         }
         output.writeDouble(this.npcMapId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_NpcGenericActionRequestMessage(input);
      }
      
      public function deserializeAs_NpcGenericActionRequestMessage(input:ICustomDataInput) : void
      {
         this._npcIdFunc(input);
         this._npcActionIdFunc(input);
         this._npcMapIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_NpcGenericActionRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_NpcGenericActionRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._npcIdFunc);
         tree.addChild(this._npcActionIdFunc);
         tree.addChild(this._npcMapIdFunc);
      }
      
      private function _npcIdFunc(input:ICustomDataInput) : void
      {
         this.npcId = input.readInt();
      }
      
      private function _npcActionIdFunc(input:ICustomDataInput) : void
      {
         this.npcActionId = input.readByte();
         if(this.npcActionId < 0)
         {
            throw new Error("Forbidden value (" + this.npcActionId + ") on element of NpcGenericActionRequestMessage.npcActionId.");
         }
      }
      
      private function _npcMapIdFunc(input:ICustomDataInput) : void
      {
         this.npcMapId = input.readDouble();
         if(this.npcMapId < 0 || this.npcMapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.npcMapId + ") on element of NpcGenericActionRequestMessage.npcMapId.");
         }
      }
   }
}
