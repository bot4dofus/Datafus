package com.ankamagames.dofus.network.messages.game.context.roleplay.havenbag
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ChangeThemeRequestMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 4899;
       
      
      private var _isInitialized:Boolean = false;
      
      public var theme:int = 0;
      
      public function ChangeThemeRequestMessage()
      {
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 4899;
      }
      
      public function initChangeThemeRequestMessage(theme:int = 0) : ChangeThemeRequestMessage
      {
         this.theme = theme;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.theme = 0;
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
         this.serializeAs_ChangeThemeRequestMessage(output);
      }
      
      public function serializeAs_ChangeThemeRequestMessage(output:ICustomDataOutput) : void
      {
         output.writeByte(this.theme);
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ChangeThemeRequestMessage(input);
      }
      
      public function deserializeAs_ChangeThemeRequestMessage(input:ICustomDataInput) : void
      {
         this._themeFunc(input);
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ChangeThemeRequestMessage(tree);
      }
      
      public function deserializeAsyncAs_ChangeThemeRequestMessage(tree:FuncTree) : void
      {
         tree.addChild(this._themeFunc);
      }
      
      private function _themeFunc(input:ICustomDataInput) : void
      {
         this.theme = input.readByte();
      }
   }
}
