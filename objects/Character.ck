public class Character extends GGen
{
    GPlane plane;            // Actual GGen
    FlatMaterial mat;        // Texture stuff

    PolyFont speech;         // Speech bubble
    speech.sca(0.2);
    speech.pos(@(-1, 1, 0));

    TweenAnimation @ typing;

    // Letter sounds
    LPF lpf;
    Gain gain;
    10000 => lpf.freq;
    20 => lpf.Q;
    0.2 => gain.gain;
    SndBuf aSound => lpf => gain => dac;
    SndBuf oSound => lpf => gain => dac;

    class Blip extends Chommand
    {
        SndBuf @ snd;
        fun @construct(SndBuf s) 
        { 
            s @=> snd; 
        }
        fun void run()
        {
            Math.random2f(0.9, 1.1) => snd.rate;
            0 => snd.pos;
        }
    }

    fun setSound(string asnd, string osnd)
    {
        asnd => aSound.read;
        osnd => oSound.read;
        aSound.samples() => aSound.pos;
        oSound.samples() => oSound.pos;
    }

    // For my Drawings
    fun @construct(Texture tex)
    {
        mat.colorMap(tex);
        plane.material(mat);
        plane --> this;
    }

    // For Testing and Milestone
    fun @construct()
    {
        plane.material(mat);
        plane --> this;
        speech --> this;
    }

    // Character Say Something
    fun void say(string tex, int lang)
    {
        speech.text(tex, lang);

        new TweenAnimation @=> typing;
        for (GText ch : speech.chars)
        {
            ch.color(@(0, 0, 0));
            ch.sca(0);

            TweenScale reveal(ch, @(1, 1, 1), 1::ms, TweenEase.LINEAR);

            ch.text().lower() => string letter;
            if (letter == "a") reveal.onDone(new Blip(aSound));
            if (letter == "o") reveal.onDone(new Blip(oSound));

            typing.add(reveal).wait(100::ms);
        }
        Tween.play(typing);
    }
}