package com.sulake.habbo.avatar
{
    import com.sulake.core.utils.Map;
    import com.sulake.habbo.avatar.alias.AssetAliasCollection;
    import com.sulake.habbo.avatar.cache.AvatarImageCache;
    import flash.display.BitmapData;
    import com.sulake.habbo.avatar.enum.AvatarAction;

    public class PlaceholderAvatarImage extends AvatarImage 
    {

        internal static var var_1031:Map = new Map();

        public function PlaceholderAvatarImage(param1:AvatarStructure, param2:AssetAliasCollection, param3:AvatarFigureContainer, param4:String)
        {
            super(param1, param2, param3, param4);
        }

        override public function dispose():void
        {
            var _loc1_:AvatarImageCache;
            if (!var_1023)
            {
                _structure = null;
                _assets = null;
                var_2889 = null;
                var_1022 = null;
                var_2994 = null;
                var_3026 = null;
                var_2856 = null;
                if (((!(var_1032)) && (var_1033)))
                {
                    var_1033.dispose();
                };
                var_1033 = null;
                _loc1_ = getCache();
                if (_loc1_)
                {
                    _loc1_.dispose();
                    _loc1_ = null;
                };
                var_2849 = null;
                var_1023 = true;
            };
        }

        override protected function getFullImage(param1:String):BitmapData
        {
            return (var_1031[param1]);
        }

        override protected function cacheFullImage(param1:String, param2:BitmapData):void
        {
            var_1031[param1] = param2;
        }

        override public function appendAction(param1:String, ... _args):Boolean
        {
            var _loc3_:String;
            if (((!(_args == null)) && (_args.length > 0)))
            {
                _loc3_ = _args[0];
            };
            switch (param1)
            {
                case AvatarAction.var_1015:
                    switch (_loc3_)
                    {
                        case AvatarAction.var_991:
                        case AvatarAction.var_992:
                        case AvatarAction.var_988:
                        case AvatarAction.var_1027:
                        case AvatarAction.var_1021:
                        case AvatarAction.var_993:
                            super.appendAction.apply(null, [param1].concat(_args));
                            break;
                    };
                    break;
                case AvatarAction.var_1019:
                case AvatarAction.var_377:
                case AvatarAction.var_1018:
                case AvatarAction.var_1028:
                case AvatarAction.var_1029:
                case AvatarAction.var_1030:
                    super.addActionData.apply(null, [param1].concat(_args));
                    break;
            };
            return (true);
        }

        override public function isPlaceholder():Boolean
        {
            return (true);
        }


    }
}