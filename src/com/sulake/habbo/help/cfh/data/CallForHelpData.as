package com.sulake.habbo.help.cfh.data
{
    public class CallForHelpData 
    {

        private var var_3990:int;
        private var var_3446:int;
        private var var_3741:String = "";


        public function get topicIndex():int
        {
            return (this.var_3990);
        }

        public function get reportedUserId():int
        {
            return (this.var_3446);
        }

        public function get reportedUserName():String
        {
            return (this.var_3741);
        }

        public function set topicIndex(param1:int):void
        {
            this.var_3990 = param1;
        }

        public function set reportedUserId(param1:int):void
        {
            this.var_3446 = param1;
        }

        public function set reportedUserName(param1:String):void
        {
            this.var_3741 = param1;
        }

        public function get userSelected():Boolean
        {
            return (this.var_3446 > 0);
        }

        public function getTopicKey(param1:int):String
        {
            return (((this.userSelected) ? "help.cfh.topicwithharasser." : "help.cfh.topic.") + param1);
        }

        public function flush():void
        {
            this.var_3446 = 0;
            this.var_3741 = "";
        }


    }
}