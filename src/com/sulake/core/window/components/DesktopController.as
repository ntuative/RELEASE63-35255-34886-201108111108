package com.sulake.core.window.components
{
    import com.sulake.core.window.WindowContext;
    import flash.geom.Rectangle;
    import com.sulake.core.window.IWindow;
    import com.sulake.core.window.graphics.GraphicContext;
    import com.sulake.core.window.graphics.IGraphicContext;
    import flash.display.DisplayObject;
    import com.sulake.core.window.events.WindowEvent;

    public class DesktopController extends ActivatorController implements IDesktopWindow, IDisplayObjectWrapper 
    {

        public function DesktopController(param1:String, param2:WindowContext, param3:Rectangle)
        {
            super(param1, 0, 0, 0, param2, param3, null, this.defaultProcedure, null, null, 0);
        }

        public function get mouseX():int
        {
            return (this.getDisplayObject().stage.mouseX);
        }

        public function get mouseY():int
        {
            return (this.getDisplayObject().stage.mouseY);
        }

        override public function set parent(param1:IWindow):void
        {
            throw (new Error("Desktop window doesn't have parent!"));
        }

        override public function set procedure(param1:Function):void
        {
            var_2667 = ((param1 != null) ? param1 : this.defaultProcedure);
        }

        override public function get host():IWindow
        {
            return (this);
        }

        override public function get desktop():IDesktopWindow
        {
            return (this);
        }

        override public function getGraphicContext(param1:Boolean):IGraphicContext
        {
            if (((param1) && (!(var_1252))))
            {
                var_1252 = new GraphicContext((("GC {" + _name) + "}"), GraphicContext.GC_TYPE_DESKTOP, var_1202);
                GraphicContext(var_1252).mouseEnabled = true;
                GraphicContext(var_1252).doubleClickEnabled = true;
            };
            return (var_1252);
        }

        public function getActiveWindow():IWindow
        {
            return (getActiveChild());
        }

        public function setActiveWindow(param1:IWindow):IWindow
        {
            return (setActiveChild(param1));
        }

        public function getDisplayObject():DisplayObject
        {
            return (this.getGraphicContext(true) as DisplayObject);
        }

        public function setDisplayObject(param1:DisplayObject):void
        {
            this.getGraphicContext(true).setDisplayObject(param1);
        }

        override public function invalidate(param1:Rectangle=null):void
        {
        }

        private function defaultProcedure(param1:WindowEvent, param2:IWindow):void
        {
        }


    }
}