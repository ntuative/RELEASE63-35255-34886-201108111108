package com.sulake.habbo.communication.messages.incoming.room.camera
{
    import com.sulake.core.communication.messages.MessageEvent;
    import com.sulake.habbo.communication.messages.parser.room.camera.CameraSnapshotMessageParser;

    public class CameraSnapshotMessageEvent extends MessageEvent 
    {

        public function CameraSnapshotMessageEvent(param1:Function)
        {
            super(param1, CameraSnapshotMessageParser);
        }

        public function getParser():CameraSnapshotMessageParser
        {
            return (var_334 as CameraSnapshotMessageParser);
        }


    }
}