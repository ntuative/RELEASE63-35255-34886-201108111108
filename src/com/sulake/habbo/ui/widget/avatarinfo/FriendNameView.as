package com.sulake.habbo.ui.widget.avatarinfo
{
    public class FriendNameView extends AvatarInfoView 
    {

        private var var_1678:int;

        public function FriendNameView(param1:AvatarInfoWidget)
        {
            super(param1);
        }

        public static function setup(param1:FriendNameView, param2:int, param3:String, param4:int, param5:int, param6:int):void
        {
            param1.var_1678 = param6;
            param1.var_5190 = 8000;
            AvatarInfoView.setup(param1, param2, param3, param4, param5, false);
            param1._window.color = 4288528218;
        }


        public function get objectId():int
        {
            return (this.var_1678);
        }

        override public function dispose():void
        {
            super.dispose();
        }


    }
}