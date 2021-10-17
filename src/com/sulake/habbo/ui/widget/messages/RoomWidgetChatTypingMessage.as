package com.sulake.habbo.ui.widget.messages
{
    public class RoomWidgetChatTypingMessage extends RoomWidgetMessage 
    {

        public static const var_2318:String = "RWCTM_TYPING_STATUS";

        private var var_3803:Boolean;

        public function RoomWidgetChatTypingMessage(param1:Boolean)
        {
            super(var_2318);
            this.var_3803 = param1;
        }

        public function get isTyping():Boolean
        {
            return (this.var_3803);
        }


    }
}