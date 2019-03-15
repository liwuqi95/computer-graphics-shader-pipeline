// Given a 3d position as a seed, compute a smooth procedural noise
// value: "Perlin Noise", also known as "Gradient noise".
//
// Inputs:
//   st  3D seed
// Returns a smooth value between (-1,1)
//
// expects: random_direction, smooth_step

//https://www.youtube.com/watch?v=MJ3bvCkHJtE
float perlin_noise(vec3 st)
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

    vec3 gv[8];

    //get the 8 gradiant vector

    for (int i = 0; i < 8; i++){
        gv[i] = random_direction(gird + direction[i]);
    }

    vec3 oppo = st - gird;

    vec3 distance[8];

    for (int i = 0; i < 8; i ++){
        distance[i] = oppo - direction[i];
    }


    float dots[8];

    for (int i = 0; i < 8; i++){
        dots[i] = dot(distance[i], gv[i]);
    }

    vec3 smoother = smooth_step(oppo);

    float reduce1_1 = mix(dots[0], dots[1], smoother.x);
    float reduce1_2 = mix(dots[2], dots[3], smoother.x);
    float reduce1_3 = mix(dots[4], dots[5], smoother.x);
    float reduce1_4 = mix(dots[6], dots[7], smoother.x);


    float reduce2_1 = mix(reduce1_1, reduce1_2, smoother.y);
    float reduce2_2 = mix(reduce1_3, reduce1_4, smoother.y);


    float reduce = mix(reduce2_1, reduce2_2, smoother.z);

    return -1 + 2 * reduce;

    /////////////////////////////////////////////////////////////////////////////
}

