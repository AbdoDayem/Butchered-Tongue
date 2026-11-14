public class Character extends GGen
{
    GPlane plane;            // Actual GGen
    FlatMaterial mat;        // Texture stuff

    fun @construct(Texture tex)
    {
        mat.colorMap(tex);
        plane.material(mat);
        plane --> this;
    }

    fun void say()
    {

    }
}