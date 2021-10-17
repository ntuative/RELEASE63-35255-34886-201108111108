package com.sulake.habbo.catalog.viewer.widgets.events
{
    import flash.events.Event;

    public class TextInputEvent extends Event 
    {

        private var _text:String;

        public function TextInputEvent(param1:String, param2:Boolean=false, param3:Boolean=false)
        {
            super(WidgetEvent.CWE_TEXT_INPUT, param2, param3);
            this._text = param1;
        }

        public function get text():String
        {
            return (this._text);
        }


    }
}