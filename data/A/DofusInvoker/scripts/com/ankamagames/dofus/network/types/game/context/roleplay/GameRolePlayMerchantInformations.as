package com.ankamagames.dofus.network.types.game.context.roleplay
{
   import com.ankamagames.dofus.network.ProtocolTypeManager;
   import com.ankamagames.dofus.network.types.game.context.EntityDispositionInformations;
   import com.ankamagames.dofus.network.types.game.look.EntityLook;
   import com.ankamagames.jerakine.network.ICustomDataInput;
   import com.ankamagames.jerakine.network.ICustomDataOutput;
   import com.ankamagames.jerakine.network.INetworkType;
   import com.ankamagames.jerakine.network.utils.FuncTree;
   
   public class GameRolePlayMerchantInformations extends GameRolePlayNamedActorInformations implements INetworkType
   {
      
      public static const protocolId:uint = 3744;
       
      
      public var sellType:uint = 0;
      
      public var options:Vector.<HumanOption>;
      
      private var _optionstree:FuncTree;
      
      public function GameRolePlayMerchantInformations()
      {
         this.options = new Vector.<HumanOption>();
         super();
      }
      
      override public function getTypeId() : uint
      {
         return 3744;
      }
      
      public function initGameRolePlayMerchantInformations(contextualId:Number = 0, disposition:EntityDispositionInformations = null, look:EntityLook = null, name:String = "", sellType:uint = 0, options:Vector.<HumanOption> = null) : GameRolePlayMerchantInformations
      {
         super.initGameRolePlayNamedActorInformations(contextualId,disposition,look,name);
         this.sellType = sellType;
         this.options = options;
         return this;
      }
      
      override public function reset() : void
      {
         super.reset();
         this.sellType = 0;
         this.options = new Vector.<HumanOption>();
      }
      
      override public function serialize(output:ICustomDataOutput) : void
      {
         this.serializeAs_GameRolePlayMerchantInformations(output);
      }
      
      public function serializeAs_GameRolePlayMerchantInformations(output:ICustomDataOutput) : void
      {
         super.serializeAs_GameRolePlayNamedActorInformations(output);
         if(this.sellType < 0)
         {
            throw new Error("Forbidden value (" + this.sellType + ") on element sellType.");
         }
         output.writeByte(this.sellType);
         output.writeShort(this.options.length);
         for(var _i2:uint = 0; _i2 < this.options.length; _i2++)
         {
            output.writeShort((this.options[_i2] as HumanOption).getTypeId());
            (this.options[_i2] as HumanOption).serialize(output);
         }
      }
      
      override public function deserialize(input:ICustomDataInput) : void
      {
         this.deserializeAs_GameRolePlayMerchantInformations(input);
      }
      
      public function deserializeAs_GameRolePlayMerchantInformations(input:ICustomDataInput) : void
      {
         var _id2:uint = 0;
         var _item2:HumanOption = null;
         super.deserialize(input);
         this._sellTypeFunc(input);
         var _optionsLen:uint = input.readUnsignedShort();
         for(var _i2:uint = 0; _i2 < _optionsLen; _i2++)
         {
            _id2 = input.readUnsignedShort();
            _item2 = ProtocolTypeManager.getInstance(HumanOption,_id2);
            _item2.deserialize(input);
            this.options.push(_item2);
         }
      }
      
      override public function deserializeAsync(tree:FuncTree) : void
      {
         this.deserializeAsyncAs_GameRolePlayMerchantInformations(tree);
      }
      
      public function deserializeAsyncAs_GameRolePlayMerchantInformations(tree:FuncTree) : void
      {
         super.deserializeAsync(tree);
         tree.addChild(this._sellTypeFunc);
         this._optionstree = tree.addChild(this._optionstreeFunc);
      }
      
      private function _sellTypeFunc(input:ICustomDataInput) : void
      {
         this.sellType = input.readByte();
         if(this.sellType < 0)
         {
            throw new Error("Forbidden value (" + this.sellType + ") on element of GameRolePlayMerchantInformations.sellType.");
         }
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
