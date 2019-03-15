// Generate a procedural planet and orbiting moon. Use layers of (improved)
// Perlin noise to generate planetary features such as vegetation, gaseous
// clouds, mountains, valleys, ice caps, rivers, oceans. Don't forget about the
// moon. Use `animation_seconds` in your noise input to create (periodic)
// temporal effects.
//
// Uniforms:
uniform mat4 view;
uniform mat4 proj;
uniform float animation_seconds;
uniform bool is_moon;
// Inputs:
in vec3 sphere_fs_in;
in vec3 normal_fs_in;
in vec4 pos_fs_in; 
in vec4 view_pos_fs_in; 
// Outputs:
out vec3 color;
// expects: model, blinn_phong, bump_height, bump_position,
// improved_perlin_noise, tangent
void main()
{
  /////////////////////////////////////////////////////////////////////////////


  float theta = 0.5*M_PI*animation_seconds;
  mat3 rotation = mat3(cos(theta),0,sin(theta),0,1,0,-sin(theta),0,cos(theta));

  vec3 ka = is_moon ? vec3(0.02) : vec3(0.013,0.013,0.031);
  vec3 kd = is_moon ? vec3(0.2) : vec3(0.19,0.24,0.75);
  vec3 ks = is_moon ? vec3(0.8) : vec3(0.8);

  vec3 n = normalize(sphere_fs_in);

  vec3 T, B;
  tangent(n,T,B);

  vec3 position = bump_position(is_moon, n);

  vec3 p1 = bump_position(is_moon, n + T * 0.00005);
  vec3 p2 = bump_position(is_moon, n + B * 0.00005);

  mat4 model = model(is_moon, animation_seconds);

  n = normalize(cross(p1 - position, p2 - position));
  n = normalize((transpose(inverse(view))*transpose(inverse(model))*vec4(n, 1.0)).xyz);

  vec4 vp = view*model*vec4(position, 1.0);
  vec3 v =  -normalize((vp/vp.w).xyz);

  vec3 l = rotation*normalize(vec3(3,2,0));

  float height = length(position) - length(n);

  if (!is_moon && height > 0.06)
    kd = vec3(0.48, 0.5 + (3 * height), 0.21);

  color = blinn_phong(ka, kd, ks, 1000, n, v, l);
  /////////////////////////////////////////////////////////////////////////////
}
