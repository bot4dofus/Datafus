package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.character.restriction.ActorRestrictionsInformations;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class HumanInformations implements INetworkType
   {
      
      public static const protocolId:uint = 9794;
       
      
      public var restrictions:ActorRestrictionsInformations;
      
      public var sex:Boolean = false;
      
      public var options:Vector.<HumanOption>;
      
      private var _restrictionstree:FuncTree;
      
      private var _optionstree:FuncTree;
      
      public function HumanInformations()
      {
         this.restrictions = new ActorRestrictionsInformations();
         this.options = new Vector.<HumanOption>();
         super();
      }
      
      public function getTypeId() : uint
      {
         return 9794;
      }
      
      public function initHumanInformations(restrictions:ActorRestrictionsInformations = null, sex:Boolean = false, options:Vector.<HumanOption> = null) : HumanInformations
      {
         this.restrictions = restrictions;
         this.sex = sex;
         this.options = options;
         return this;
      }
      
      public function reset() : void
      {
         this.restrictions = new ActorRestrictionsInformations();
         this.options = new Vector.<HumanOption>();
      }
      
      public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_HumanInformations(output);
      }
      
      public function serializeAs_HumanInformations(output:ICustomDataOutput) : void
      {
         this.restrictions.serializeAs_ActorRestrictionsInformations(output);
         output.writeBoolean(this.sex);
         output.writeShort(this.options.length);
         for(var _i3:uint = 0; _i3 < this.options.length; _i3++)
         {
            output.writeShort((this.options[_i3] as HumanOption).getTypeId());
            (this.options[_i3] as HumanOption).serialize(output);
         }
      }
      
      public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_HumanInformations(input);
      }
      
      public function deserializeAs_HumanInformations(input:ICustomDataInput) : void
      {
         var _id3:uint = 0;
         var _item3:HumanOption = null;
         this.restrictions = new ActorRestrictionsInformations();
         this.restrictions.deserialize(input);
         this._sexFunc(input);
         var _optionsLen:uint = input.readUnsignedShort();
         for(var _i3:uint = 0; _i3 < _optionsLen; _i3++)
         {
            _id3 = input.readUnsignedShort();
            _item3 = ProtocolTypeManager.getInstance(HumanOption,_id3);
            _item3.deserialize(input);
            this.options.push(_item3);
         }
      }
      
      public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_HumanInformations(tree);
      }
      
      public function deserializeAsyncAs_HumanInformations(tree:FuncTree) : void
      {
         this._restrictionstree = tree.addChild(this._restrictionstreeFunc);
         tree.addChild(this._sexFunc);
         this._optionstree = tree.addChild(this._optionstreeFunc);
      }
      
      private function _restrictionstreeFunc(input:ICustomDataInput) : void
      {
         this.restrictions = new ActorRestrictionsInformations();
         this.restrictions.deserializeAsync(this._restrictionstree);
      }
      
      private function _sexFunc(input:ICustomDataInput) : void
      {
         this.sex = input.readBoolean();
      }
      
      private function _optionstreeFunc(input:ICustomDataInput) : void
      {
         var length:uint = input.readUnsignedShort();
         for(var i:uint = 0; i < length; i++)
         {
            this._optionstree.addChild(this._optionsFunc);
         }
      }
      
      private function _optionsFunc(input:ICustomDataInput) : void
      {
         var _id:uint = input.readUnsignedShort();
         var _item:HumanOption = ProtocolTypeManager.getInstance(HumanOption,_id);
         _item.deserialize(input);
         this.options.push(_item);
      }
   }
}
