package com.ankamagames.dofus.network.messages.game.context
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ShowCellSpectatorMessage extends ShowCellMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4927;
       
      
      private var _isInitialized:Boolean = false;
      
      public var playerName:String = "";
      
      public function ShowCellSpectatorMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return super.isInitialized && this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4927;
      }
      
      public function initShowCellSpectatorMessage(sourceId:Number = 0, cellId:uint = 0, playerName:String = "") : ShowCellSpectatorMessage
      {
         super.initShowCellMessage(sourceId,cellId);
         this.playerName = playerName;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.playerName = "";
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
         this.serializeAs_ShowCellSpectatorMessage(output);
      }
      
      public function serializeAs_ShowCellSpectatorMessage(output:ICustomDataOutput) : void
      {
         super.serializeAs_ShowCellMessage(output);
         output.writeUTF(this.playerName);
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ShowCellSpectatorMessage(input);
      }
      
      public function deserializeAs_ShowCellSpectatorMessage(input:ICustomDataInput) : void
      {
         super.deserialize(input);
         this._playerNameFunc(input);
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ShowCellSpectatorMessage(tree);
      }
      
      public function deserializeAsyncAs_ShowCellSpectatorMessage(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._playerNameFunc);
      }
      
      private function _playerNameFunc(input:ICustomDataInput) : void
      {
         this.playerName = input.readUTF();
      }
   }
}
