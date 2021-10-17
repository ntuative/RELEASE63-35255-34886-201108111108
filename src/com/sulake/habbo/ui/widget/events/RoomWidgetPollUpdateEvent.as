package com.sulake.habbo.ui.widget.events
{
    public class RoomWidgetPollUpdateEvent extends RoomWidgetUpdateEvent 
    {

        public static const var_372:String = "RWPUW_OFFER";
        public static const var_60:String = "RWPUW_ERROR";
        public static const var_371:String = "RWPUW_CONTENT";

        private var _id:int = -1;
        private var var_3782:String;
        private var var_3780:int = 0;
        private var var_3778:String = "";
        private var var_3779:String = "";
        private var var_3781:Array = null;

        public function RoomWidgetPollUpdateEvent(param1:int, param2:String, param3:Boolean=false, param4:Boolean=false)
        {
            this._id = param1;
            super(param2, param3, param4);
        }

        public function get id():int
        {
            return (this._id);
        }

        public function get summary():String
        {
            return (this.var_3782);
        }

        public function set summary(param1:String):void
        {
            this.var_3782 = param1;
        }

        public function get numQuestions():int
        {
            return (this.var_3780);
        }

        public function set numQuestions(param1:int):void
        {
            this.var_3780 = param1;
        }

        public function get startMessage():String
        {
            return (this.var_3778);
        }

        public function set startMessage(param1:String):void
        {
            this.var_3778 = param1;
        }

        public function get endMessage():String
        {
            return (this.var_3779);
        }

        public function set endMessage(param1:String):void
        {
            this.var_3779 = param1;
        }

        public function get questionArray():Array
        {
            return (this.var_3781);
        }

        public function set questionArray(param1:Array):void
        {
            this.var_3781 = param1;
        }


    }
}