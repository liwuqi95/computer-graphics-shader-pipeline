// Input:
//   N  3D unit normal vector
// Outputs:
//   T  3D unit tangent vector
//   B  3D unit bitangent vector
void tangent(in vec3 N, out vec3 T, out vec3 B)
{
    /////////////////////////////////////////////////////////////////////////////

    vec3 c1 = cross(N, vec3(0, 0, 1));
    vec3 c2 = cross(N, vec3(0, 1, 0));

    T = normalize (length(c1) > length(c2) ? c1:c2);
    B = normalize(cross(T, N));
    /////////////////////////////////////////////////////////////////////////////
}
