package com.ankamagames.dofus.network.messages.game.context.roleplay.breach.branch
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.context.roleplay.breach.ExtendedBreachBranch;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class BreachBranchesMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4087;
       
      
      private var _isInitialized:Boolean = false;
      
      public var branches:Vector.<ExtendedBreachBranch>;
      
      private var _branchestree:FuncTree;
      
      public function BreachBranchesMessage()
      {
         this.branches = new Vector.<ExtendedBreachBranch>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4087;
      }
      
      public function initBreachBranchesMessage(branches:Vector.<ExtendedBreachBranch> = null) : BreachBranchesMessage
      {
         this.branches = branches;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.branches = new Vector.<ExtendedBreachBranch>();
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
         this.serializeAs_BreachBranchesMessage(output);
      }
      
      public function serializeAs_BreachBranchesMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.branches.length);
         for(var _i1:uint = 0; _i1 < this.branches.length; _i1++)
         {
            output.writeShort((this.branches[_i1] as ExtendedBreachBranch).getTypeId());
            (this.branches[_i1] as ExtendedBreachBranch).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_BreachBranchesMessage(input);
      }
      
      public function deserializeAs_BreachBranchesMessage(input:ICustomDataInput) : void
      {
         var _id1:uint = 0;
         var _item1:ExtendedBreachBranch = null;
         var _branchesLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _branchesLen; _i1++)
         {
            _id1 = input.readUnsignedShort();
            _item1 = ProtocolTypeManager.getInstance(ExtendedBreachBranch,_id1);
            _item1.deserialize(input);
            this.branches.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_BreachBranchesMessage(tree);
      }
      
      public function deserializeAsyncAs_BreachBranchesMessage(tree:FuncTree) : void
      {
         this._branchestree = tree.addChild(this._branchestreeFunc);
      }
      
      private function _branchestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._branchestree.addChild(this._branchesFunc);
         }
      }
      
      private function _branchesFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:ExtendedBreachBranch = ProtocolTypeManager.getInstance(ExtendedBreachBranch,_id);
         _item.deserialize(input);
         this.branches.push(_item);
      }
   }
}
