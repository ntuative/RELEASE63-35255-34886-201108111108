package com.sulake.habbo.session.events
{
    import com.sulake.habbo.session.IRoomSession;

    public class RoomSessionPollEvent extends RoomSessionEvent 
    {

        public static const var_372:String = "RSPE_POLL_OFFER";
        public static const var_60:String = "RSPE_POLL_ERROR";
        public static const var_371:String = "RSPE_POLL_CONTENT";

        private var _id:int = -1;
        private var var_3782:String;
        private var var_3780:int = 0;
        private var var_3778:String = "";
        private var var_3779:String = "";
        private var var_3781:Array = null;

        public function RoomSessionPollEvent(param1:String, param2:IRoomSession, param3:int)
        {
            this._id = param3;
            super(param1, param2);
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