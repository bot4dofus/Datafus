package com.ankamagames.dofus.network.messages.game.context.roleplay.npc
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class PortalDialogCreationMessage extends NpcDialogCreationMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 1297;
       
      
      private var _isInitialized:Boolean = false;
      
      public var type:uint = 0;
      
      public function PortalDialogCreationMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 1297;
      }
      
      public function initPortalDialogCreationMessage(mapId:Number = 0, npcId:int = 0, type:uint = 0) : PortalDialogCreationMessage
      {
         super.initNpcDialogCreationMessage(mapId,npcId);
         this.type = type;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.type = 0;
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
         this.serializeAs_PortalDialogCreationMessage(output);
      }
      
      public function serializeAs_PortalDialogCreationMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_NpcDialogCreationMessage(output);
         output.writeInt(this.type);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_PortalDialogCreationMessage(input);
      }
      
      public function deserializeAs_PortalDialogCreationMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._typeFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_PortalDialogCreationMessage(tree);
      }
      
      public function deserializeAsyncAs_PortalDialogCreationMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._typeFunc);
      }
      
      private function _typeFunc(input:ICustomDataInput) : void
      {
         this.type = input.readInt();
         if(this.type < 0)
         {
            throw new Error("Forbidden value (" + this.type + ") on element of PortalDialogCreationMessage.type.");
         }
      }
   }
}
