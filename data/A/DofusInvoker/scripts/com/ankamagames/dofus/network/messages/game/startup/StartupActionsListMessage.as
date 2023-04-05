package com.ankamagames.dofus.network.messages.game.startup
{
   import com.ankamagames.dofus.network.types.game.startup.StartupActionAddObject;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class StartupActionsListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 7819;
       
      
      private var _isInitialized:Boolean = false;
      
      public var actions:Vector.<StartupActionAddObject>;
      
      private var _actionstree:FuncTree;
      
      public function StartupActionsListMessage()
      {
         this.actions = new Vector.<StartupActionAddObject>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 7819;
      }
      
      public function initStartupActionsListMessage(actions:Vector.<StartupActionAddObject> = null) : StartupActionsListMessage
      {
         this.actions = actions;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.actions = new Vector.<StartupActionAddObject>();
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
         this.serializeAs_StartupActionsListMessage(output);
      }
      
      public function serializeAs_StartupActionsListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.actions.length);
         for(var _i1:uint = 0; _i1 < this.actions.length; _i1++)
         {
            (this.actions[_i1] as StartupActionAddObject).serializeAs_StartupActionAddObject(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_StartupActionsListMessage(input);
      }
      
      public function deserializeAs_StartupActionsListMessage(input:ICustomDataInput) : void
      {
         var _item1:StartupActionAddObject = null;
         var _actionsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _actionsLen; _i1++)
         {
            _item1 = new StartupActionAddObject();
            _item1.deserialize(input);
            this.actions.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_StartupActionsListMessage(tree);
      }
      
      public function deserializeAsyncAs_StartupActionsListMessage(tree:FuncTree) : void
      {
         this._actionstree = tree.addChild(this._actionstreeFunc);
      }
      
      private function _actionstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._actionstree.addChild(this._actionsFunc);
         }
      }
      
      private function _actionsFunc(input:ICustomDataInput) : void
      {
         var _item:StartupActionAddObject = new StartupActionAddObject();
         _item.deserialize(input);
         this.actions.push(_item);
      }
   }
}
