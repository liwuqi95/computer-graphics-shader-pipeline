// Add (hard code) an orbiting (point or directional) light to the scene. Light
// the scene using the Blinn-Phong Lighting Model.
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
// expects: PI, blinn_phong
void main()
{
  /////////////////////////////////////////////////////////////////////////////

  float theta = 0.5*M_PI*animation_seconds;
  mat3 rotation = mat3(cos(theta),0,sin(theta),0,1,0,-sin(theta),0,cos(theta));

  vec3 ka = is_moon ? vec3(0.02) : vec3(0.013,0.013,0.031);
  vec3 kd = is_moon ? vec3(0.2) : vec3(0.19,0.24,0.75);
  vec3 ks = is_moon ? vec3(0.8) : vec3(0.8);

  vec3 n = normalize(normal_fs_in);
  vec3 v = -normalize((view_pos_fs_in/view_pos_fs_in.w).xyz);
  vec3 l = rotation*normalize(vec3(3,2,0));

  color = blinn_phong(ka, kd, ks, 1000, n, v, l);
  /////////////////////////////////////////////////////////////////////////////
}
