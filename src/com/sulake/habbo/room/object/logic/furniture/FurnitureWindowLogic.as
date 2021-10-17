package com.sulake.habbo.room.object.logic.furniture
{
    import com.sulake.room.utils.XMLValidator;
    import com.sulake.habbo.room.object.RoomObjectVariableEnum;

    public class FurnitureWindowLogic extends FurnitureMultiStateLogic 
    {


        override public function initialize(param1:XML):void
        {
            var _loc3_:XML;
            var _loc4_:String;
            super.initialize(param1);
            if (param1 == null)
            {
                return;
            };
            var _loc2_:XMLList = param1.mask;
            if (_loc2_.length() > 0)
            {
                _loc3_ = _loc2_[0];
                if (XMLValidator.checkRequiredAttributes(_loc3_, ["type"]))
                {
                    _loc4_ = _loc3_.@type;
                    object.getModelController().setNumber(RoomObjectVariableEnum.var_507, 1, true);
                    object.getModelController().setString(RoomObjectVariableEnum.var_508, _loc4_, true);
                };
            };
        }


    }
}