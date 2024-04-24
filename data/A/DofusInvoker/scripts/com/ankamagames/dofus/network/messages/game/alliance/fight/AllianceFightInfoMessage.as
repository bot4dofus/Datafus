package com.ankamagames.dofus.network.messages.game.alliance.fight
{
   import com.ankamagames.dofus.network.types.game.social.fight.SocialFight;
   import com.ankamagames.jerakine.network.CustomDataWrapper;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkMessage;
   import com.ankamagames.jerakine.network.NetworkMessage;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   import flash.utils.ByteArray;
   
   public class AllianceFightInfoMessage extends NetworkMessage implements INetworkMessage
   {
      
      public static const protocolId:uint = 465;
       
      
      private var _isInitialized:Boolean = false;
      
      public var allianceFights:Vector.<SocialFight>;
      
      private var _allianceFightstree:FuncTree;
      
      public function AllianceFightInfoMessage()
      {
         this.allianceFights = new Vector.<SocialFight>();
         super();
      }
      
      override public function get isInitialized() : Boolean
      {
         return this._isInitialized;
      }
      
      override public function getMessageId() : uint
      {
         return 465;
      }
      
      public function initAllianceFightInfoMessage(allianceFights:Vector.<SocialFight> = null) : AllianceFightInfoMessage
      {
         this.allianceFights = allianceFights;
         this._isInitialized = true;
         return this;
      }
      
      override public function reset() : void
      {
         this.allianceFights = new Vector.<SocialFight>();
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
         this.serializeAs_AllianceFightInfoMessage(output);
      }
      
      public function serializeAs_AllianceFightInfoMessage(output:ICustomDataOutput) : void
      {
         output.writeShort(this.allianceFights.length);
         for(var _i1:uint = 0; _i1 < this.allianceFights.length; _i1++)
         {
            (this.allianceFights[_i1] as SocialFight).serializeAs_SocialFight(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_AllianceFightInfoMessage(input);
      }
      
      public function deserializeAs_AllianceFightInfoMessage(input:ICustomDataInput) : void
      {
         var _item1:SocialFight = null;
         var _allianceFightsLen:uint = input.readUnsignedShort();
         for(var _i1:uint = 0; _i1 < _allianceFightsLen; _i1++)
         {
            _item1 = new SocialFight();
            _item1.deserialize(input);
            this.allianceFights.push(_item1);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_AllianceFightInfoMessage(tree);
      }
      
      public function deserializeAsyncAs_AllianceFightInfoMessage(tree:FuncTree) : void
      {
         this._allianceFightstree = tree.addChild(this._allianceFightstreeFunc);
      }
      
      private function _allianceFightstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._allianceFightstree.addChild(this._allianceFightsFunc);
         }
      }
      
      private function _allianceFightsFunc(input:ICustomDataInput) : void
      {
         var _item:SocialFight = new SocialFight();
         _item.deserialize(input);
         this.allianceFights.push(_item);
      }
   }
}
