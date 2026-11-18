// Butchered Tongue: A Visual Novel
// By: Abdullah Abdeldayem
// ------------------------------------------------------------------- //
@import "chodash"
@import "objects/PolyFont.ck"
@import "objects/Scene.ck"
@import "objects/TitleScene.ck"
@import "objects/Character.ck"
// ------------------------------------------------------------------- //
// Scene 1
class Scene1 extends Scene
{
    // So I can zoom
    GGen world --> this;

    // Man
    Character man(); 
    man --> world;
    man.mat.color(@(0, 0, 0));
    man.plane.sca(@(0.5, 1, 1));
    man.setSound("audio/ma1.wav", "audio/mo1.wav");

    // Tree
    Character trunk(); 
    trunk --> world;
    trunk.mat.color(@(0.55, 0.5, 0.45));
    trunk.plane.sca(@(0.4, 2, 1));
    trunk.pos(@(2, 0.5, 0));

    Character leaves(); leaves --> world;
    leaves.mat.color(@(0.65, 0.7, 0.6));
    leaves.plane.sca(@(1.6, 1.6, 1));
    leaves.pos(@(2, 2, 0));

    // Zooming
    1.0 => float zoom;
    0 => int presses;

    SndBuf zoomSound => dac;
    0.3 => zoomSound.gain;
    "audio/zoom.wav" => zoomSound.read;
    zoomSound.samples() => zoomSound.pos;

    // Task: Press key to zoom in repeatedly on the Man to enter the memory
    fun void update()
    {

        if (GWindow.keyDown(GWindow.KEY_SPACE))
        {
            0 => zoomSound.pos;
            1.0 - presses * 0.1 => zoomSound.rate;

            zoom * 1.2 => zoom;
            Tween.scale(world, zoom, 1::second);
            presses++;
            
            if (presses % 2) man.say("Blah agweaiofn asfno", 3);
            else man.say("Yadda yoobaasdf blahblah", 2);

            if (presses == 5) 1 => finished;
        }
    }
}
// ------------------------------------------------------------------- //
// Scene 2
class Scene2 extends Scene
{
    // Tree
    Character trunk(); 
    trunk --> this;
    trunk.mat.color(@(0.55, 0.5, 0.45));
    trunk.plane.sca(@(0.4, 2, 1));
    trunk.pos(@(2, 0.5, 0));

    Character leaves(); 
    leaves --> this;
    leaves.mat.color(@(0.65, 0.7, 0.6));
    leaves.plane.sca(@(1.6, 1.6, 1));
    leaves.pos(@(2, 2, 0));

    // Running Boy
    Character boy(); 
    boy --> this;
    boy.mat.color(@(0.1, 0.3, 0.8));
    boy.plane.sca(@(0.3, 0.6, 1));
    boy.pos(@(-2, -1, 1));

    // Mom who is just a voice
    Character mom(); 
    mom --> this;
    mom.plane.sca(0);
    mom.pos(@(-4, 0.5, 0));
    mom.setSound("audio/fa1.wav", "audio/fo1.wav");

    // Progress Bar Stuff
    4.0 => float barW;
    FlatMaterial fullMat; 
    backMat.color(@(0.8, 0.8, 0.8));
    FlatMaterial fillMat; 
    fillMat.color(@(0.9, 0.1, 0.1));

    GPlane barFull --> this;
    barFull.material(fullMat);
    barFull.sca(@(barW, 0.2, 1));
    barFull.pos(@(0, -2.5, 0.2));

    GPlane barFill --> this;
    barFill.material(fillMat);
    barFill.sca(@(0, 0.2, 1));
    barFill.pos(@(-barW / 2, -2.5, 0.3));

    2.0 => float speed;
    0.0 => float ran;
    15.0 => float limit;
    0 => int tired;

    fun void update()
    {
        if (!tired)
        {
            0 => float dx;
            if (GWindow.key(GWindow.KEY_LEFT))  -1 => dx;
            if (GWindow.key(GWindow.KEY_RIGHT))  1 => dx;

            boy.posX(boy.posX() + dx * speed * GG.dt());

            Math.fabs(dx) * speed * GG.dt() +=> ran;

            Math.min(ran / limit, 1.0) => float ratio;
            barFill.scaX(barW * ratio);
            barFill.posX(-barW / 2 + barW * ratio / 2);

            if (ran > limit)
            {
                1 => tired;
                mom.say("Come home for dinner!", 1);
            }
        }
        else
        {
            if (GWindow.keyDown(GWindow.KEY_SPACE)) 1 => finished;
        }
    }
    
}
// ------------------------------------------------------------------- //
// Window Setup
GG.camera().orthographic();
GWindow.fullscreen();
GG.scene().backgroundColor(@(0.95, 0.95, 0.95));
GText.defaultFont(me.dir() + "./fonts/e.ttf");
// ------------------------------------------------------------------- //
// Scene Setup
Scene @ scenes[0];

TitleScene act1("ACT I: First Exposure");
scenes << act1;

Scene1 scene1;
scenes << scene1;

Scene2 scene2;
scenes << scene2;

TitleScene act2("To Be Continued...");
scenes << act2;

TitleScene act3("ACT III: Butchered Tongue");
//scenes << act3;

TitleScene credits("Credits");
//scenes << credits;


// ------------------------------------------------------------------- //
// Main Loop
0 => int counter;

scenes[counter].enter();

while(true)
{
    GG.nextFrame() => now;
    Tween.update();

    scenes[counter].update();

    if(scenes[counter].finished)
    {
        scenes[counter].exit();
        counter++;
        if(counter == scenes.size()) me.exit();
        else scenes[counter].enter();
    }
}