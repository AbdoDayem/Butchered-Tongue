@import "objects/PolyFont.ck"
// ------------------------------------------------------------------- //

PolyFont test --> GG.scene();
test.text("Hello my name is ABDULLAH, im very HAPPY to be here", 2);
test.sca(0.2);
test.pos(@(-2,0));

// ------------------------------------------------------------------- //
// Main Loop
while(true)
{
    GG.nextFrame() => now;
}