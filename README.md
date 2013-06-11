# flash-sound-player
The simplest flash fallback for HTML5 audio playback available, **written in under 50 LOC**.

## Why?
Because Firefox still can't play sounds without crashing, see [https://bugzilla.mozilla.org/show_bug.cgi?id=744836](https://bugzilla.mozilla.org/show_bug.cgi?id=744836).

## Usage
Embed the swf in your markup:

    <object id="flash_sound_player" type="application/x-shockwave-flash" data="flash_sound_player.swf" width="0" height="0" allowscriptaccess="always">
      <p>You should not see this if flash is working</p>
    </object>

Use javascript to play a sound:

	document.getElementById("flash_sound_player").playSound("http://assets.sauspiel.de/sounds/male/allgaeuerisch/greeting/begruessung-1.mp3");

Be sure to have a `crossDomain.xml` file on the host that allows the loading of the sound files, for more information see the [Adobe Developer Conneciton site](http://www.adobe.com/devnet/articles/crossdomain_policy_file_spec.html).

Need to detect Flash first? There you go.

    var hasFlash = false;
    try {
      ao = new ActiveXObject("ShockwaveFlash.ShockwaveFlash");
      hasFlash = ao != null;
    } catch (e) {
      hasFlash = navigator.mimeTypes["application/x-shockwave-flash"] !== void 0;
    }

## Building
Get the [Flex SDK](http://www.adobe.com/devnet/flex/flex-sdk-download-all.html), and set `FLEX_HOME`, e.g.:

    export FLEX_HOME=~/Downloads/flex_sdk_4

and run `./build.sh`.


&copy; 2013 Martin Kavalar, Sauspiel GmbH
