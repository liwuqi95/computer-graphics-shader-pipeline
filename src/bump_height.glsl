// Create a bumpy surface by using procedural noise to generate a height (
// displacement in normal direction).
//
// Inputs:
//   is_moon  whether we're looking at the moon or centre planet
//   s  3D position of seed for noise generation
// Returns elevation adjust along normal (values between -0.1 and 0.1 are
//   reasonable.
float bump_height(bool is_moon, vec3 s)
{
    /////////////////////////////////////////////////////////////////////////////

    vec3 position = 2 * s;
    float size = 0.5;

    float random = 0;
    float scale = 1;
    while(scale > size){
        position = position / scale;
        random = random + improved_perlin_noise(position)*scale;
        scale = scale/2;
    }

    return (sqrt(sin((s.y+3.0*random)*M_PI) + 1) * 0.7071)/10;

    /////////////////////////////////////////////////////////////////////////////
}
