package com.sulake.core.window.components
{
    import com.sulake.core.window.utils.tablet.ITouchAwareWindow;
    import com.sulake.core.window.enum.WindowParam;
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.events.WindowEvent;
    import com.sulake.core.window.events.WindowTouchEvent;
    import com.sulake.core.window.events.WindowMouseEvent;
    import com.sulake.core.window.WindowController;

    public class ButtonController extends InteractiveController implements IButtonWindow, ITouchAwareWindow 
    {

        protected static const var_2058:String = "_BTN_TEXT";
        protected static const var_2059:Number = 0.5;

        public function ButtonController(param1:String, param2:uint, param3:uint, param4:uint, param5:WindowContext, param6:Rectangle, param7:IWindow, param8:Function, param9:Array=null, param10:Array=null, param11:uint=0)
        {
            param4 = (param4 | WindowParam.WINDOW_PARAM_EXPAND_TO_ACCOMMODATE_CHILDREN);
            super(param1, param2, param3, param4, param5, param6, param7, param8, param9, param10, param11);
        }

        override public function set caption(param1:String):void
        {
            super.caption = param1;
            var _loc2_:IWindow = getChildByName(var_2058);
            if (_loc2_ != null)
            {
                _loc2_.caption = caption;
            };
        }

        override public function update(subject:WindowController, event:WindowEvent):Boolean
        {
            var type:String;
            var windowEvent:WindowEvent;
            var result:Boolean;
            if ((event is WindowEvent))
            {
                switch (event.type)
                {
                    case WindowEvent.var_599:
                        width = 0;
                        break;
                    case WindowEvent.var_584:
                        try
                        {
                            getChildByName(var_2058).blend = (getChildByName(var_2058).blend + var_2059);
                        }
                        catch(e:Error)
                        {
                        };
                        break;
                    case WindowEvent.var_586:
                        try
                        {
                            getChildByName(var_2058).blend = (getChildByName(var_2058).blend - var_2059);
                        }
                        catch(e:Error)
                        {
                        };
                        break;
                };
            }
            else
            {
                if ((event is WindowTouchEvent))
                {
                    type = WindowEvent.var_608;
                    switch (event.type)
                    {
                        case WindowTouchEvent.var_2060:
                            type = WindowMouseEvent.var_650;
                            break;
                        case WindowTouchEvent.var_2061:
                            type = WindowMouseEvent.var_655;
                            break;
                        case WindowTouchEvent.var_2062:
                            type = WindowMouseEvent.WINDOW_EVENT_MOUSE_CLICK;
                            break;
                    };
                    windowEvent = WindowMouseEvent.allocate(type, WindowTouchEvent(event).window, WindowTouchEvent(event).related, WindowTouchEvent(event).localX, WindowTouchEvent(event).localY, WindowTouchEvent(event).stageX, WindowTouchEvent(event).stageY, WindowTouchEvent(event).altKey, WindowTouchEvent(event).ctrlKey, WindowTouchEvent(event).shiftKey, true, 0);
                    result = super.update(subject, windowEvent);
                    windowEvent.recycle();
                    return (result);
                };
            };
            return (super.update(subject, event));
        }


    }
}