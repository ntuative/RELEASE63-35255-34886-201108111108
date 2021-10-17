package com.sulake.core.window.utils
{
    import com.sulake.core.window.enum.MouseCursorType;
    import flash.display.Stage;
    import flash.display.DisplayObject;
    import flash.utils.Dictionary;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.ui.Mouse;
    import flash.ui.MouseCursor;

    public class MouseCursorControl 
    {

        private static var _type:uint = MouseCursorType.var_613;//0
        private static var var_1168:Stage;
        private static var var_1169:Boolean = true;
        private static var _disposed:Boolean = false;
        private static var var_1170:Boolean = true;
        private static var var_1167:DisplayObject;
        private static var var_1171:Dictionary = new Dictionary();

        public function MouseCursorControl(param1:DisplayObject)
        {
            var_1168 = param1.stage;
        }

        public static function dispose():void
        {
            if (!_disposed)
            {
                if (var_1167)
                {
                    var_1168.removeChild(var_1167);
                    var_1168.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
                    var_1168.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
                    var_1168.removeEventListener(MouseEvent.MOUSE_OVER, onStageMouseMove);
                    var_1168.removeEventListener(MouseEvent.MOUSE_OUT, onStageMouseMove);
                };
                _disposed = true;
            };
        }

        public static function get disposed():Boolean
        {
            return (_disposed);
        }

        public static function get type():uint
        {
            return (_type);
        }

        public static function set type(param1:uint):void
        {
            if (_type != param1)
            {
                _type = param1;
                var_1170 = true;
            };
        }

        public static function get visible():Boolean
        {
            return (var_1169);
        }

        public static function set visible(param1:Boolean):void
        {
            var_1169 = param1;
            if (var_1169)
            {
                if (var_1167)
                {
                    var_1167.visible = true;
                }
                else
                {
                    Mouse.show();
                };
            }
            else
            {
                if (var_1167)
                {
                    var_1167.visible = false;
                }
                else
                {
                    Mouse.hide();
                };
            };
        }

        public static function change():void
        {
            var _loc1_:DisplayObject;
            if (var_1170)
            {
                _loc1_ = var_1171[_type];
                if (_loc1_)
                {
                    if (var_1167)
                    {
                        var_1168.removeChild(var_1167);
                    }
                    else
                    {
                        var_1168.addEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
                        var_1168.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
                        var_1168.addEventListener(MouseEvent.MOUSE_OVER, onStageMouseMove);
                        var_1168.addEventListener(MouseEvent.MOUSE_OUT, onStageMouseMove);
                        Mouse.hide();
                    };
                    var_1167 = _loc1_;
                    var_1168.addChild(var_1167);
                }
                else
                {
                    if (var_1167)
                    {
                        var_1168.removeChild(var_1167);
                        var_1168.removeEventListener(Event.MOUSE_LEAVE, onStageMouseLeave);
                        var_1168.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
                        var_1168.removeEventListener(MouseEvent.MOUSE_OVER, onStageMouseMove);
                        var_1168.removeEventListener(MouseEvent.MOUSE_OUT, onStageMouseMove);
                        var_1167 = null;
                        Mouse.show();
                    };
                    switch (_type)
                    {
                        case MouseCursorType.var_613:
                        case MouseCursorType.ARROW:
                            Mouse.cursor = MouseCursor.ARROW;
                            break;
                        case MouseCursorType.var_1172:
                            Mouse.cursor = MouseCursor.BUTTON;
                            break;
                        case MouseCursorType.var_1173:
                        case MouseCursorType.var_1174:
                        case MouseCursorType.var_1175:
                        case MouseCursorType.var_1176:
                            Mouse.cursor = MouseCursor.HAND;
                            break;
                        case MouseCursorType.NONE:
                            Mouse.cursor = MouseCursor.ARROW;
                            Mouse.hide();
                            break;
                    };
                };
                var_1170 = false;
            };
        }

        public static function defineCustomCursorType(param1:uint, param2:DisplayObject):void
        {
            var_1171[param1] = param2;
        }

        private static function onStageMouseMove(param1:MouseEvent):void
        {
            if (var_1167)
            {
                var_1167.x = (param1.stageX - 2);
                var_1167.y = param1.stageY;
                if (_type == MouseCursorType.var_613)
                {
                    var_1169 = false;
                    Mouse.show();
                }
                else
                {
                    var_1169 = true;
                    Mouse.hide();
                };
            };
        }

        private static function onStageMouseLeave(param1:Event):void
        {
            if (((var_1167) && (!(_type == MouseCursorType.var_613))))
            {
                Mouse.hide();
                var_1169 = false;
            };
        }


    }
}