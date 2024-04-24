package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class NpcDialogCreationMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2607;
       
      
      private var _isInitialized:Boolean = false;
      
      public var mapId:Number = 0;
      
      public var npcId:int = 0;
      
      public function NpcDialogCreationMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2607;
      }
      
      public function initNpcDialogCreationMessage(mapId:Number = 0, npcId:int = 0) : NpcDialogCreationMessage
      {
         this.mapId = mapId;
         this.npcId = npcId;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.mapId = 0;
         this.npcId = 0;
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
         this.serializeAs_NpcDialogCreationMessage(output);
      }
      
      public function serializeAs_NpcDialogCreationMessage(output:ICustomDataOutput) : void
      {
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element mapId.");
         }
         output.writeDouble(this.mapId);
         output.writeInt(this.npcId);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_NpcDialogCreationMessage(input);
      }
      
      public function deserializeAs_NpcDialogCreationMessage(input:ICustomDataInput) : void
      {
         this._mapIdFunc(input);
         this._npcIdFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_NpcDialogCreationMessage(tree);
      }
      
      public function deserializeAsyncAs_NpcDialogCreationMessage(tree:FuncTree) : void
      {
         tree.addChild(this._mapIdFunc);
         tree.addChild(this._npcIdFunc);
      }
      
      private function _mapIdFunc(input:ICustomDataInput) : void
      {
         this.mapId = input.readDouble();
         if(this.mapId < 0 || this.mapId > 9007199254740992)
         {
            throw new Error("Forbidden value (" + this.mapId + ") on element of NpcDialogCreationMessage.mapId.");
         }
      }
      
      private function _npcIdFunc(input:ICustomDataInput) : void
      {
         this.npcId = input.readInt();
      }
   }
}
