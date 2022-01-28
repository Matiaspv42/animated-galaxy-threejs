uniform float uSize;
uniform float uTime;

attribute float aScales;
attribute vec3 aRandomness;
varying vec3 vColor;

void main()
{   
    // Position
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);

    // SPIN

    float angle = atan(modelPosition.x,modelPosition.z);
    float distanceToCenter = length(modelPosition.xz);
    float angleOffSet = (1.0/distanceToCenter) * uTime * 0.2;
    angle += angleOffSet;

    modelPosition.x = distanceToCenter* cos(angle);
    modelPosition.z = distanceToCenter*sin(angle);   

    // randomness

    modelPosition.xyz += vec3(aRandomness); 



    vec4 viewPosition = viewMatrix * modelPosition;
    vec4 projectedPosition = projectionMatrix * viewPosition; 

    gl_Position = projectedPosition;

    // Size
    
    gl_PointSize = uSize *  aScales;
    gl_PointSize *= (1.0 / - viewPosition.z);

    // color

    vColor = color;
}