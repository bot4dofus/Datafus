package com.ankamagames.dofus.network.messages.authorized
{
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class ConsoleCommandsListMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 2634;
       
      
      private var _isInitialized:Boolean = false;
      
      public var aliases:Vector.<String>;
      
      public var args:Vector.<String>;
      
      public var descriptions:Vector.<String>;
      
      private var _aliasestree:FuncTree;
      
      private var _argstree:FuncTree;
      
      private var _descriptionstree:FuncTree;
      
      public function ConsoleCommandsListMessage()
      {
         this.aliases = new Vector.<String>();
         this.args = new Vector.<String>();
         this.descriptions = new Vector.<String>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 2634;
      }
      
      public function initConsoleCommandsListMessage(aliases:Vector.<String> = null, args:Vector.<String> = null, descriptions:Vector.<String> = null) : ConsoleCommandsListMessage
      {
         this.aliases = aliases;
         this.args = args;
         this.descriptions = descriptions;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.aliases = new Vector.<String>();
         this.args = new Vector.<String>();
         this.descriptions = new Vector.<String>();
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
         this.serializeAs_ConsoleCommandsListMessage(output);
      }
      
      public function serializeAs_ConsoleCommandsListMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.aliases.length);
         for(var _i1:uint = 0; _i1 < this.aliases.length; _i1++)
         {
            output.writeUTF(this.aliases[_i1]);
         }
         output.writeShort(this.args.length);
         for(var _i2:uint = 0; _i2 < this.args.length; _i2++)
         {
            output.writeUTF(this.args[_i2]);
         }
         output.writeShort(this.descriptions.length);
         for(var _i3:uint = 0; _i3 < this.descriptions.length; _i3++)
         {
            output.writeUTF(this.descriptions[_i3]);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_ConsoleCommandsListMessage(input);
      }
      
      public function deserializeAs_ConsoleCommandsListMessage(input:ICustomDataInput) : void
      {
         var _val1:String = null;
         var _val2:String = null;
         var _val3:String = null;
         var _aliasesLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _aliasesLen; _i1++)
         {
            _val1 = input.readUTF();
            this.aliases.push(_val1);
         }
         var _argsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _argsLen; _i2++)
         {
            _val2 = input.readUTF();
            this.args.push(_val2);
         }
         var _descriptionsLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _descriptionsLen; _i3++)
         {
            _val3 = input.readUTF();
            this.descriptions.push(_val3);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_ConsoleCommandsListMessage(tree);
      }
      
      public function deserializeAsyncAs_ConsoleCommandsListMessage(tree:FuncTree) : void
      {
         this._aliasestree = tree.addChild(this._aliasestreeFunc);
         this._argstree = tree.addChild(this._argstreeFunc);
         this._descriptionstree = tree.addChild(this._descriptionstreeFunc);
      }
      
      private function _aliasestreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._aliasestree.addChild(this._aliasesFunc);
         }
      }
      
      private function _aliasesFunc(input:ICustomDataInput) : void
      {
         var _val:String = input.readUTF();
         this.aliases.push(_val);
      }
      
      private function _argstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._argstree.addChild(this._argsFunc);
         }
      }
      
      private function _argsFunc(input:ICustomDataInput) : void
      {
         var _val:String = input.readUTF();
         this.args.push(_val);
      }
      
      private function _descriptionstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._descriptionstree.addChild(this._descriptionsFunc);
         }
      }
      
      private function _descriptionsFunc(input:ICustomDataInput) : void
      {
         var _val:String = input.readUTF();
         this.descriptions.push(_val);
      }
   }
}
