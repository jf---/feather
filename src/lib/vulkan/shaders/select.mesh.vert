#version 450

#extension GL_ARB_separate_shader_objects : enable
#extension GL_ARB_shading_language_420pack : enable

layout (location = 0) in vec3 inPosition;
layout (location = 1) in vec3 inNormal;
layout (location = 2) in vec2 inUV;
layout (location = 3) in vec3 inColor;
layout (location = 4) in ivec4 inId;

layout (binding = 0) uniform UBO 
{
	mat4 projection;
	mat4 model;
        int mode;
        // current ids under the mouse
        int p1;
        int p2;
        int p3;
        int object;
} ubo;

layout (location = 2) out vec3 outColor;

void main() 
{
    gl_Position = ubo.projection * ubo.model * vec4(inPosition.xyz, 1.0);
}