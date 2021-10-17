package com.sulake.habbo.notifications
{
    public class HabboNotificationItem 
    {

        private var var_1206:HabboNotificationItemStyle;
        private var var_2578:String;
        private var var_4007:HabboNotifications;

        public function HabboNotificationItem(param1:String, param2:HabboNotificationItemStyle, param3:HabboNotifications)
        {
            this.var_2578 = param1;
            this.var_1206 = param2;
            this.var_4007 = param3;
        }

        public function get style():HabboNotificationItemStyle
        {
            return (this.var_1206);
        }

        public function get content():String
        {
            return (this.var_2578);
        }

        public function dispose():void
        {
            this.var_2578 = null;
            if (this.var_1206 != null)
            {
                this.var_1206.dispose();
                this.var_1206 = null;
            };
            this.var_4007 = null;
        }

        public function ExecuteUiLinks():void
        {
            var _loc2_:String;
            var _loc1_:Array = this.var_1206.componentLinks;
            for each (_loc2_ in _loc1_)
            {
                if (this.var_4007 != null)
                {
                    this.var_4007.onExecuteLink(_loc2_);
                };
            };
        }


    }
}