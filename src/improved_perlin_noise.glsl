// Given a 3d position as a seed, compute an even smoother procedural noise
// value. "Improving Noise" [Perlin 2002].
//
// Inputs:
//   st  3D seed
// Values between  -½ and ½ ?
//
// expects: random_direction, improved_smooth_step
float improved_perlin_noise( vec3 st) 
{
  /////////////////////////////////////////////////////////////////////////////
  vec3 gird = floor(st);

  vec3 direction[8];
  int index = 0;

  for (int i = 0; i < 2; i ++){
    for (int j = 0; j < 2; j ++){
      for (int k = 0; k < 2; k ++){
        direction[index] = vec3(i, j, k);
        index++;
      }
    }
  }

  vec3 oppo = st - gird;

  float dots[8];

  for (int i = 0; i < 8; i++){
    dots[i] = dot(st - gird - direction[i], random_direction(gird + direction[i]));
  }

  vec3 smoother = improved_smooth_step(oppo);

  float reduce1_1 = mix(dots[0], dots[4], smoother.x);
  float reduce1_2 = mix(dots[1], dots[5], smoother.x);
  float reduce1_3 = mix(dots[2], dots[6], smoother.x);
  float reduce1_4 = mix(dots[3], dots[7], smoother.x);

  float reduce2_1 = mix(reduce1_1, reduce1_3, smoother.y);
  float reduce2_2 = mix(reduce1_2, reduce1_4, smoother.y);

  float reduce = mix(reduce2_1, reduce2_2, smoother.z);

  return -1 + 2 * reduce;

  /////////////////////////////////////////////////////////////////////////////
}

