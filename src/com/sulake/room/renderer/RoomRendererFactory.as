﻿package com.sulake.room.renderer
{
    import com.sulake.core.runtime.Component;
    import com.sulake.core.runtime.IContext;

    public class RoomRendererFactory extends Component implements IRoomRendererFactory 
    {

        public function RoomRendererFactory(param1:IContext, param2:uint=0)
        {
            super(param1, param2);
        }

        public function createRenderer():IRoomRenderer
        {
            return (new RoomRenderer(this));
        }


    }
}