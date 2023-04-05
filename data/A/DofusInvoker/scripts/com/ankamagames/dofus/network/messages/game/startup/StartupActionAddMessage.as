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
   
   public class StartupActionAddMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4490;
       
      
      private var _isInitialized:Boolean = false;
      
      public var newAction:StartupActionAddObject;
      
      private var _newActiontree:FuncTree;
      
      public function StartupActionAddMessage()
      {
         this.newAction = new StartupActionAddObject();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4490;
      }
      
      public function initStartupActionAddMessage(newAction:StartupActionAddObject = null) : StartupActionAddMessage
      {
         this.newAction = newAction;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.newAction = new StartupActionAddObject();
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
         this.serializeAs_StartupActionAddMessage(output);
      }
      
      public function serializeAs_StartupActionAddMessage(output:ICustomDataOutput) : void
      {
         this.newAction.serializeAs_StartupActionAddObject(output);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_StartupActionAddMessage(input);
      }
      
      public function deserializeAs_StartupActionAddMessage(input:ICustomDataInput) : void
      {
         this.newAction = new StartupActionAddObject();
         this.newAction.deserialize(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_StartupActionAddMessage(tree);
      }
      
      public function deserializeAsyncAs_StartupActionAddMessage(tree:FuncTree) : void
      {
         this._newActiontree = tree.addChild(this._newActiontreeFunc);
      }
      
      private function _newActiontreeFunc(input:ICustomDataInput) : void
      {
         this.newAction = new StartupActionAddObject();
         this.newAction.deserializeAsync(this._newActiontree);
      }
   }
}
