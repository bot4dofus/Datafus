package com.ankamagames.dofus.network.messages.game.approach
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.approach.ServerSessionConstant;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ServerSessionConstantsMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 9337;
       
      
      private var _isInitialized:Boolean = false;
      
      public var variables:Vector.<ServerSessionConstant>;
      
      private var _variablestree:FuncTree;
      
      public function ServerSessionConstantsMessage()
      {
         this.variables = new Vector.<ServerSessionConstant>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 9337;
      }
      
      public function initServerSessionConstantsMessage(variables:Vector.<ServerSessionConstant> = null) : ServerSessionConstantsMessage
      {
         this.variables = variables;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.variables = new Vector.<ServerSessionConstant>();
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
         this.serializeAs_ServerSessionConstantsMessage(output);
      }
      
      public function serializeAs_ServerSessionConstantsMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.variables.length);
         for(var _i1:uint = 0; _i1 < this.variables.length; _i1++)
         {
            output.writeShort((this.variables[_i1] as ServerSessionConstant).getTypeId());
            (this.variables[_i1] as ServerSessionConstant).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ServerSessionConstantsMessage(input);
      }
      
      public function deserializeAs_ServerSessionConstantsMessage(input:ICustomDataInput) : void
      {
         var _id1:uint = 0;
         var _item1:ServerSessionConstant = null;
         var _variablesLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _variablesLen; _i1++)
         {
            _id1 = input.readUnsignedShort();
            _item1 = ProtocolTypeManager.getInstance(ServerSessionConstant,_id1);
            _item1.deserialize(input);
            this.variables.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ServerSessionConstantsMessage(tree);
      }
      
      public function deserializeAsyncAs_ServerSessionConstantsMessage(tree:FuncTree) : void
      {
         this._variablestree = tree.addChild(this._variablestreeFunc);
      }
      
      private function _variablestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._variablestree.addChild(this._variablesFunc);
         }
      }
      
      private function _variablesFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:ServerSessionConstant = ProtocolTypeManager.getInstance(ServerSessionConstant,_id);
         _item.deserialize(input);
         this.variables.push(_item);
      }
   }
}
