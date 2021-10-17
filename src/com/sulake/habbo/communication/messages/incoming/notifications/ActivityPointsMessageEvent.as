package com.sulake.habbo.communication.messages.incoming.notifications
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.core.communication.messages.IMessageEvent;
    import com.sulake.habbo.communication.messages.parser.notifications.ActivityPointsMessageParser;
    import flash.utils.Dictionary;

    public class ActivityPointsMessageEvent extends MessageEvent implements IMessageEvent 
    {

        public function ActivityPointsMessageEvent(param1:Function)
        {
            super(param1, ActivityPointsMessageParser);
        }

        public function get points():Dictionary
        {
            return ((var_334 as ActivityPointsMessageParser).points);
        }


    }
}