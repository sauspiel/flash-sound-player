package {
  import flash.display.Sprite;
  import flash.events.Event;
  import flash.events.IOErrorEvent;
  import flash.external.ExternalInterface;
  import flash.media.Sound;
  import flash.media.SoundChannel;
  import flash.net.URLRequest;
  
  public class FlashSoundPlayer extends Sprite {
    protected var soundsCache:Object = new Object();

    public function FlashSoundPlayer() {
      if(ExternalInterface.available) {
        ExternalInterface.addCallback('playSound', playSound);
      }
    }

    public function playSound(soundUrl:String):void {
      var sound:Sound = getSound(soundUrl);
      try { 
        sound.play();
      } catch(e:*) { }
    }
    
    private function getSound(soundUrl:String):Sound {
      var cachedSound:Sound = soundsCache[soundUrl] as Sound;
      if(cachedSound != null) {
        return cachedSound;
      }
      var sound:Sound = new Sound();
      var request:URLRequest = new URLRequest(soundUrl);
      var ioErrorHandler:Function = function(event:IOErrorEvent):void { 
        sound.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler); 
        sound.removeEventListener(Event.COMPLETE, completeHandler); 
      };
      var completeHandler:Function = function(event:Event):void {
        soundsCache[soundUrl] = sound;
        sound.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler); 
        sound.removeEventListener(Event.COMPLETE, completeHandler); 
      };
      sound.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
      sound.addEventListener(Event.COMPLETE, completeHandler);
      sound.load(request);  
      return sound;
    }
  }
}
