package com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag.meeting
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class HavenBagPermissionsUpdateRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 958;
       
      
      private var _isInitialized:Boolean = false;
      
      public var permissions:uint = 0;
      
      public function HavenBagPermissionsUpdateRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 958;
      }
      
      public function initHavenBagPermissionsUpdateRequestMessage(permissions:uint = 0) : HavenBagPermissionsUpdateRequestMessage
      {
         this.permissions = permissions;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.permissions = 0;
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
         this.serializeAs_HavenBagPermissionsUpdateRequestMessage(output);
      }
      
      public function serializeAs_HavenBagPermissionsUpdateRequestMessage(output:ICustomDataOutput) : void
      {
         if(this.permissions < 0)
         {
            throw new Error("Forbidden value (" + this.permissions + ") on element permissions.");
         }
         output.writeInt(this.permissions);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HavenBagPermissionsUpdateRequestMessage(input);
      }
      
      public function deserializeAs_HavenBagPermissionsUpdateRequestMessage(input:ICustomDataInput) : void
      {
         this._permissionsFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HavenBagPermissionsUpdateRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_HavenBagPermissionsUpdateRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._permissionsFunc);
      }
      
      private function _permissionsFunc(input:ICustomDataInput) : void
      {
         this.permissions = input.readInt();
         if(this.permissions < 0)
         {
            throw new Error("Forbidden value (" + this.permissions + ") on element of HavenBagPermissionsUpdateRequestMessage.permissions.");
         }
      }
   }
}
