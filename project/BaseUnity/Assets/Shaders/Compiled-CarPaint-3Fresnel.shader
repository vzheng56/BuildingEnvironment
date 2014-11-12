Shader "MyShader/CarPaintChange" {
Properties {
 _Color ("Base Color 1", Color) = (1,1,1,1)
 _Color_1 ("Tone 1", Color) = (1,1,1,1)
 _Color_2 ("Tone 2", Color) = (1,1,1,1)
 _Color_A ("New Base Color", Color) = (1,1,1,1)
 _Color_A1 ("New Tone 1", Color) = (1,1,1,1)
 _Color_A2 ("New Tone 2", Color) = (1,1,1,1)
 _Lerp ("Lerp", Range(0,1)) = 0
 _Penumbra ("Penumbra", Float) = 0.5
 _zMax ("ZMax", Float) = 4
 _zMin ("ZMin", Float) = -4
 _CubeMapLerp ("CubeMap Lerp", Range(0,1)) = 0
 _Cube ("Cubemap 1", CUBE) = "" {}
 _Cube_01 ("Cubemap 2", CUBE) = "" {}
 _Reflection ("Reflection", Float) = 1
 _Gloss ("Gloss", Float) = -1
 _Kr ("Reflection Max", Float) = 1
 _KrMin ("Reflection Min", Float) = 0.05
 _FresnelExpon ("Fresnel Exponent", Float) = 3
 _FresnelPower ("Fresnel Power", Float) = 3
}
SubShader { 
 LOD 200
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
Program "vp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Float 22 [_Lerp]
Float 23 [_Kr]
Float 24 [_KrMin]
Float 25 [_FresnelExpon]
Float 26 [_FresnelPower]
Float 27 [_Penumbra]
Float 28 [_zMax]
Float 29 [_zMin]
"!!ARBvp1.0
# 76 ALU
PARAM c[30] = { { 1, 2, -1 },
		state.matrix.mvp,
		program.local[5..29] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R0.xyz, vertex.normal, c[13].w;
DP3 R4.x, R0, c[6];
DP3 R3.w, R0, c[7];
DP3 R2.w, R0, c[5];
MOV R2.x, R4;
MOV R2.y, R3.w;
MOV R2.z, c[0].x;
MUL R0, R2.wxyy, R2.xyyw;
DP4 R1.z, R2.wxyz, c[17];
DP4 R1.y, R2.wxyz, c[16];
DP4 R1.x, R2.wxyz, c[15];
DP4 R2.z, R0, c[20];
DP4 R2.y, R0, c[19];
DP4 R2.x, R0, c[18];
MUL R3.x, R4, R4;
ADD R1.xyz, R1, R2;
MAD R0.x, R2.w, R2.w, -R3;
MUL R2.xyz, R0.x, c[21];
MOV R0.w, c[0].x;
MOV R0.xyz, c[14];
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
DP3 R0.w, vertex.normal, vertex.normal;
MAD R0.xyz, R3, c[13].w, -vertex.position;
ADD result.texcoord[5].xyz, R1, R2;
DP3 R1.x, R0, R0;
RSQ R1.x, R1.x;
MUL R1.xyz, R1.x, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, vertex.normal;
DP3 R0.w, R0, R1;
MUL R2.xyz, R0, c[0].y;
MAD R2.xyz, -R2, R0.w, R1;
MOV result.texcoord[1].xyz, R1;
ABS R0.w, R0;
ADD R0.w, -R0, c[0].x;
POW R1.y, R0.w, c[25].x;
MOV R0.w, c[29].x;
ADD R1.z, -R0.w, c[28].x;
MOV R0.w, c[0].x;
MOV R1.x, c[24];
ADD R0.w, R0, -c[22].x;
ABS R1.z, R1;
MAD R1.z, R0.w, R1, c[29].x;
ADD R0.w, -R1.x, c[23].x;
MAD R1.x, R0.w, R1.y, c[24];
ADD R0.w, R1.z, -c[27].x;
MUL result.texcoord[2].w, R1.x, c[26].x;
SLT R1.x, vertex.position.z, R0.w;
ADD R1.y, R1.z, c[27].x;
MAD R1.z, -R1.w, R1.x, R1.w;
MAD R1.w, R1.x, c[0].z, c[0].x;
MOV result.texcoord[2].xyz, -R2;
SLT R2.x, R1.y, vertex.position.z;
ADD R1.y, -R0.w, R1;
ABS R1.y, R1;
ADD R0.w, vertex.position.z, -R0;
MUL R2.x, R1.w, R2;
ADD R1.x, -R1.z, c[0];
MAD R1.x, R1, R2, R1.z;
MAD R1.z, R2.x, -R1.w, R1.w;
MUL R1.z, R1.w, R1;
RCP R1.y, R1.y;
ABS R0.w, R0;
MUL R0.w, R0, R1.y;
ADD R0.w, R0, -R1.x;
MAD result.texcoord[3].x, R0.w, R1.z, R1;
MOV result.texcoord[0].xyz, R0;
MOV result.texcoord[4].z, R3.w;
MOV result.texcoord[4].y, R4.x;
MOV result.texcoord[4].x, R2.w;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 76 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [unity_SHAr]
Vector 15 [unity_SHAg]
Vector 16 [unity_SHAb]
Vector 17 [unity_SHBr]
Vector 18 [unity_SHBg]
Vector 19 [unity_SHBb]
Vector 20 [unity_SHC]
Float 21 [_Lerp]
Float 22 [_Kr]
Float 23 [_KrMin]
Float 24 [_FresnelExpon]
Float 25 [_FresnelPower]
Float 26 [_Penumbra]
Float 27 [_zMax]
Float 28 [_zMin]
"vs_2_0
; 92 ALU
def c29, 1.00000000, 2.00000000, 0.00000000, 0
dcl_position0 v0
dcl_normal0 v1
mov r2.w, c29.x
mov r2.xyz, c13
dp4 r0.z, r2, c10
dp4 r0.x, r2, c8
dp4 r0.y, r2, c9
mul r2.xyz, v1, c12.w
mad r1.xyz, r0, c12.w, -v0
dp3 r3.w, r2, c6
dp3 r0.w, r2, c4
dp3 r4.w, r2, c5
dp3 r0.x, r1, r1
rsq r4.x, r0.x
mov r0.x, r4.w
mov r0.y, r3.w
mov r0.z, c29.x
mul r2, r0.wxyy, r0.xyyw
dp4 r3.z, r0.wxyz, c16
dp4 r3.y, r0.wxyz, c15
dp4 r3.x, r0.wxyz, c14
dp4 r0.z, r2, c19
dp4 r0.x, r2, c17
dp4 r0.y, r2, c18
add r3.xyz, r3, r0
mul r2.xyz, r4.x, r1
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r1.xyz, r0.x, v1
mul r0.y, r4.w, r4.w
mad r0.y, r0.w, r0.w, -r0
mul r4.xyz, r0.y, c20
dp3 r2.w, r1, r2
mul r0.xyz, r1, c29.y
mad r0.xyz, -r0, r2.w, r2
mov oT2.xyz, -r0
mov r0.x, c27
add r0.y, -c28.x, r0.x
mov r0.x, c21
abs r0.y, r0
add r0.x, c29, -r0
add oT5.xyz, r3, r4
mad r3.x, r0, r0.y, c28
abs r0.y, r2.w
add r0.x, r3, -c26
add r0.z, -r0.y, c29.x
mov oT1.xyz, r2
pow r2, r0.z, c24.x
slt r0.y, v0.z, r0.x
add r0.z, r3.x, c26.x
max r2.y, -r0, r0
slt r2.z, r0, v0
add r0.z, -r0.x, r0
slt r2.y, c29.z, r2
add r2.y, -r2, c29.x
mul r2.z, r2.y, r2
mov r2.w, r2.x
max r3.x, -r2.z, r2.z
slt r3.x, c29.z, r3
mov r2.x, c22
add r2.x, -c23, r2
mad r2.x, r2, r2.w, c23
add r3.x, -r3, c29
abs r0.z, r0
add r0.x, v0.z, -r0
mul r2.w, r2.y, r3.x
mul oT2.w, r2.x, c25.x
mul r2.x, r2.y, r2.w
max r2.y, -r0, r0
max r0.y, -r2.x, r2.x
slt r2.y, c29.z, r2
max r2.x, -r2.z, r2.z
add r2.y, -r2, c29.x
slt r2.x, c29.z, r2
mul r2.y, r2, r1.w
add r1.w, -r2.x, c29.x
mad r2.x, r1.w, r2.y, r2
slt r0.y, c29.z, r0
add r1.w, -r0.y, c29.x
mul r1.w, r1, r2.x
rcp r0.z, r0.z
abs r0.x, r0
mul r0.x, r0, r0.z
mad oT3.x, r0.y, r0, r1.w
mov oT0.xyz, r1
mov oT4.z, r3.w
mov oT4.y, r4.w
mov oT4.x, r0.w
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 9 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Float 15 [_Lerp]
Float 16 [_Kr]
Float 17 [_KrMin]
Float 18 [_FresnelExpon]
Float 19 [_FresnelPower]
Float 20 [_Penumbra]
Float 21 [_zMax]
Float 22 [_zMin]
Vector 23 [unity_LightmapST]
"!!ARBvp1.0
# 55 ALU
PARAM c[24] = { { 1, 2, -1 },
		state.matrix.mvp,
		program.local[5..23] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R1.xyz, c[14];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MAD R0.xyz, R0, c[13].w, -vertex.position;
DP3 R1.y, R0, R0;
DP3 R1.x, vertex.normal, vertex.normal;
RSQ R1.w, R1.x;
RSQ R1.y, R1.y;
MUL R1.xyz, R1.y, R0;
MUL R0.xyz, R1.w, vertex.normal;
DP3 R1.w, R0, R1;
MUL R2.xyz, R0, c[0].y;
MAD R2.xyz, -R2, R1.w, R1;
MOV result.texcoord[1].xyz, R1;
ABS R1.w, R1;
ADD R1.w, -R1, c[0].x;
POW R1.x, R1.w, c[18].x;
MOV R1.y, c[22].x;
ADD R1.w, -R1.y, c[21].x;
MOV R1.y, c[0].x;
MOV R1.z, c[17].x;
ADD R1.y, R1, -c[15].x;
ABS R1.w, R1;
MAD R1.w, R1.y, R1, c[22].x;
ADD R1.y, -R1.z, c[16].x;
MAD R1.y, R1, R1.x, c[17].x;
ADD R1.x, R1.w, -c[20];
SLT R1.z, vertex.position, R1.x;
MAD R0.w, -R0, R1.z, R0;
MUL result.texcoord[2].w, R1.y, c[19].x;
ADD R1.y, R1.w, c[20].x;
MAD R1.z, R1, c[0], c[0].x;
SLT R1.w, R1.y, vertex.position.z;
MOV result.texcoord[2].xyz, -R2;
MUL R2.x, R1.z, R1.w;
ADD R1.w, -R0, c[0].x;
MAD R0.w, R1, R2.x, R0;
ADD R1.w, -R1.x, R1.y;
MAD R2.x, R2, -R1.z, R1.z;
MUL R1.y, R1.z, R2.x;
ABS R1.z, R1.w;
ADD R1.x, vertex.position.z, -R1;
RCP R1.z, R1.z;
ABS R1.x, R1;
MUL R1.x, R1, R1.z;
ADD R1.x, R1, -R0.w;
MAD result.texcoord[3].x, R1, R1.y, R0.w;
MOV result.texcoord[0].xyz, R0;
MAD result.texcoord[5].xy, vertex.texcoord[1], c[23], c[23].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 55 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 8 [_World2Object]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Float 14 [_Lerp]
Float 15 [_Kr]
Float 16 [_KrMin]
Float 17 [_FresnelExpon]
Float 18 [_FresnelPower]
Float 19 [_Penumbra]
Float 20 [_zMax]
Float 21 [_zMin]
Vector 22 [unity_LightmapST]
"vs_2_0
; 71 ALU
def c23, 1.00000000, 2.00000000, 0.00000000, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord1 v2
mov r1.w, c23.x
mov r1.xyz, c13
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r1.xyz, r0, c12.w, -v0
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul r1.xyz, r0.y, r1
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r1.w, r0, r1
mul r2.xyz, r0, c23.y
mad r2.xyz, -r2, r1.w, r1
mov oT2.xyz, -r2
mov oT1.xyz, r1
mov r2.x, c20
add r1.y, -c21.x, r2.x
mov r1.x, c14
abs r1.y, r1
add r1.x, c23, -r1
mad r2.w, r1.x, r1.y, c21.x
add r2.x, r2.w, -c19
abs r1.x, r1.w
add r2.z, -r1.x, c23.x
pow r1, r2.z, c17.x
add r1.y, r2.w, c19.x
slt r2.y, v0.z, r2.x
max r1.z, -r2.y, r2.y
slt r1.z, c23, r1
add r1.z, -r1, c23.x
slt r1.w, r1.y, v0.z
mul r1.w, r1.z, r1
mov r2.z, r1.x
max r2.w, -r1, r1
slt r2.w, c23.z, r2
mov r1.x, c15
add r1.x, -c16, r1
mad r1.x, r1, r2.z, c16
add r2.w, -r2, c23.x
mul r2.z, r1, r2.w
mul oT2.w, r1.x, c18.x
mul r1.x, r1.z, r2.z
max r1.z, -r2.y, r2.y
slt r2.y, c23.z, r1.z
max r1.z, -r1.w, r1.w
add r1.w, -r2.y, c23.x
max r1.x, -r1, r1
slt r1.z, c23, r1
mul r1.w, r1, r0
add r0.w, -r1.z, c23.x
mad r1.z, r0.w, r1.w, r1
slt r0.w, c23.z, r1.x
add r1.x, -r2, r1.y
add r1.y, -r0.w, c23.x
mul r1.z, r1.y, r1
abs r1.y, r1.x
add r1.x, v0.z, -r2
rcp r1.y, r1.y
abs r1.x, r1
mul r1.x, r1, r1.y
mad oT3.x, r0.w, r1, r1.z
mov oT0.xyz, r0
mad oT5.xy, v2, c22, c22.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Float 23 [_Lerp]
Float 24 [_Kr]
Float 25 [_KrMin]
Float 26 [_FresnelExpon]
Float 27 [_FresnelPower]
Float 28 [_Penumbra]
Float 29 [_zMax]
Float 30 [_zMin]
"!!ARBvp1.0
# 82 ALU
PARAM c[31] = { { 1, 2, -1, 0.5 },
		state.matrix.mvp,
		program.local[5..30] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R0.xyz, vertex.normal, c[14].w;
DP3 R3.x, R0, c[6];
DP3 R0.w, R0, c[7];
DP3 R2.x, R0, c[5];
MOV R2.y, R3.x;
MOV R2.z, R0.w;
MUL R1, R2.xyzz, R2.yzzx;
MOV R2.w, c[0].x;
DP4 R4.z, R1, c[21];
DP4 R4.y, R1, c[20];
DP4 R4.x, R1, c[19];
DP4 R0.z, R2, c[18];
DP4 R0.y, R2, c[17];
DP4 R0.x, R2, c[16];
ADD R0.xyz, R0, R4;
MUL R2.y, R3.x, R3.x;
MAD R1.x, R2, R2, -R2.y;
MUL R1.xyz, R1.x, c[22];
ADD result.texcoord[5].xyz, R0, R1;
DP3 R0.y, vertex.normal, vertex.normal;
MOV R4.xyz, c[15];
MOV R4.w, c[0].x;
DP4 R2.w, R4, c[11];
DP4 R2.y, R4, c[9];
DP4 R2.z, R4, c[10];
MAD R4.xyz, R2.yzww, c[14].w, -vertex.position;
DP3 R0.x, R4, R4;
RSQ R0.x, R0.x;
MUL R1.xyz, R0.x, R4;
RSQ R0.y, R0.y;
MUL R0.xyz, R0.y, vertex.normal;
MOV R2.y, c[25].x;
DP3 R1.w, R0, R1;
MUL R4.xyz, R0, c[0].y;
MAD R4.xyz, -R4, R1.w, R1;
MOV result.texcoord[1].xyz, R1;
ABS R1.w, R1;
ADD R1.w, -R1, c[0].x;
MOV R1.z, c[30].x;
ADD R1.z, -R1, c[29].x;
ADD R2.y, -R2, c[24].x;
POW R1.w, R1.w, c[26].x;
MAD R1.w, R2.y, R1, c[25].x;
MUL result.texcoord[2].w, R1, c[27].x;
MOV R2.y, c[0].x;
DP4 R1.w, vertex.position, c[4];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MOV result.texcoord[2].xyz, -R4;
MUL R4.xyz, R1.xyww, c[0].w;
MOV R2.z, R4.x;
MUL R2.w, R4.y, c[13].x;
ABS R1.z, R1;
ADD R2.y, R2, -c[23].x;
MAD R2.y, R2, R1.z, c[30].x;
ADD result.texcoord[6].xy, R2.zwzw, R4.z;
ADD R1.z, R2.y, -c[28].x;
ADD R2.w, R2.y, c[28].x;
SLT R2.z, vertex.position, R1;
MAD R2.y, -R3, R2.z, R3;
MAD R2.z, R2, c[0], c[0].x;
SLT R3.y, R2.w, vertex.position.z;
MUL R3.y, R2.z, R3;
ADD R3.z, -R2.y, c[0].x;
MAD R2.y, R3.z, R3, R2;
ADD R3.z, -R1, R2.w;
MAD R2.w, R3.y, -R2.z, R2.z;
ABS R3.y, R3.z;
ADD R3.z, vertex.position, -R1;
RCP R1.z, R3.y;
ABS R3.y, R3.z;
MUL R1.z, R3.y, R1;
ADD R3.y, R1.z, -R2;
DP4 R1.z, vertex.position, c[3];
MUL R2.z, R2, R2.w;
MAD result.texcoord[3].x, R3.y, R2.z, R2.y;
MOV result.position, R1;
MOV result.texcoord[6].zw, R1;
MOV result.texcoord[0].xyz, R0;
MOV result.texcoord[4].z, R0.w;
MOV result.texcoord[4].y, R3.x;
MOV result.texcoord[4].x, R2;
END
# 82 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Float 23 [_Lerp]
Float 24 [_Kr]
Float 25 [_KrMin]
Float 26 [_FresnelExpon]
Float 27 [_FresnelPower]
Float 28 [_Penumbra]
Float 29 [_zMax]
Float 30 [_zMin]
"vs_2_0
; 97 ALU
def c31, 1.00000000, 2.00000000, 0.00000000, 0.50000000
dcl_position0 v0
dcl_normal0 v1
mul r0.xyz, v1, c14.w
dp3 r3.w, r0, c5
dp3 r2.w, r0, c6
dp3 r4.x, r0, c4
mov r4.y, r3.w
mov r4.z, r2.w
mul r0, r4.xyzz, r4.yzzx
mov r4.w, c31.x
dp4 r2.z, r0, c21
dp4 r2.y, r0, c20
dp4 r2.x, r0, c19
mul r3.x, r3.w, r3.w
mov r0.w, c31.x
dp4 r1.z, r4, c18
dp4 r1.y, r4, c17
dp4 r1.x, r4, c16
add r1.xyz, r1, r2
mad r0.x, r4, r4, -r3
mul r2.xyz, r0.x, c22
mov r0.xyz, c15
dp4 r3.z, r0, c10
dp4 r3.x, r0, c8
dp4 r3.y, r0, c9
dp3 r0.w, v1, v1
mad r0.xyz, r3, c14.w, -v0
add oT5.xyz, r1, r2
dp3 r1.x, r0, r0
rsq r1.x, r1.x
mul r0.xyz, r1.x, r0
rsq r0.w, r0.w
mul r1.xyz, r0.w, v1
dp3 r0.w, r1, r0
mul r2.xyz, r1, c31.y
mad r2.xyz, -r2, r0.w, r0
abs r0.w, r0
mov oT2.xyz, -r2
add r2.x, -r0.w, c31
mov oT1.xyz, r0
pow r0, r2.x, c26.x
mov r0.y, c29.x
add r0.z, -c30.x, r0.y
mov r0.y, c23.x
add r0.y, c31.x, -r0
abs r0.z, r0
mad r0.z, r0.y, r0, c30.x
add r3.x, r0.z, -c28
mov r0.y, r0.x
add r0.z, r0, c28.x
slt r0.w, r0.z, v0.z
mov r0.x, c24
add r0.x, -c25, r0
mad r0.x, r0, r0.y, c25
slt r3.z, v0, r3.x
max r0.y, -r3.z, r3.z
slt r0.y, c31.z, r0
add r4.y, -r0, c31.x
mul r3.y, r4, r0.w
mul oT2.w, r0.x, c27.x
max r4.z, -r3.y, r3.y
slt r4.z, c31, r4
add r4.z, -r4, c31.x
dp4 r0.w, v0, c3
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r2.xyz, r0.xyww, c31.w
mul r2.y, r2, c12.x
mad oT6.xy, r2.z, c13.zwzw, r2
max r2.y, -r3.z, r3.z
slt r2.z, c31, r2.y
mul r4.z, r4.y, r4
mul r2.x, r4.y, r4.z
max r2.y, -r3, r3
add r2.z, -r2, c31.x
max r2.x, -r2, r2
slt r2.y, c31.z, r2
mul r2.z, r2, r1.w
add r1.w, -r2.y, c31.x
mad r2.y, r1.w, r2.z, r2
slt r1.w, c31.z, r2.x
add r2.x, -r1.w, c31
add r0.z, -r3.x, r0
mul r2.y, r2.x, r2
abs r2.x, r0.z
add r0.z, v0, -r3.x
abs r0.z, r0
rcp r2.x, r2.x
mul r2.x, r0.z, r2
dp4 r0.z, v0, c2
mad oT3.x, r1.w, r2, r2.y
mov oPos, r0
mov oT6.zw, r0
mov oT0.xyz, r1
mov oT4.z, r2.w
mov oT4.y, r3.w
mov oT4.x, r4
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Float 16 [_Lerp]
Float 17 [_Kr]
Float 18 [_KrMin]
Float 19 [_FresnelExpon]
Float 20 [_FresnelPower]
Float 21 [_Penumbra]
Float 22 [_zMax]
Float 23 [_zMin]
Vector 24 [unity_LightmapST]
"!!ARBvp1.0
# 60 ALU
PARAM c[25] = { { 1, 2, -1, 0.5 },
		state.matrix.mvp,
		program.local[5..24] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R2.w, c[0].x;
MOV R1.xyz, c[15];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MAD R0.xyz, R0, c[14].w, -vertex.position;
DP3 R1.y, R0, R0;
DP3 R1.x, vertex.normal, vertex.normal;
RSQ R1.w, R1.x;
RSQ R1.y, R1.y;
MUL R1.xyz, R1.y, R0;
MUL R0.xyz, R1.w, vertex.normal;
DP3 R1.w, R0, R1;
MUL R2.xyz, R0, c[0].y;
MAD R2.xyz, -R2, R1.w, R1;
MOV result.texcoord[1].xyz, R1;
MOV R1.z, c[23].x;
ADD R1.z, -R1, c[22].x;
ABS R1.w, R1;
MOV result.texcoord[2].xyz, -R2;
ADD R2.x, -R1.w, c[0];
MOV R1.w, c[18].x;
POW R2.x, R2.x, c[19].x;
ADD R1.w, -R1, c[17].x;
MAD R1.w, R1, R2.x, c[18].x;
MUL result.texcoord[2].w, R1, c[20].x;
DP4 R1.w, vertex.position, c[4];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MUL R2.xyz, R1.xyww, c[0].w;
MUL R2.y, R2, c[13].x;
ADD result.texcoord[6].xy, R2, R2.z;
ADD R2.w, R2, -c[16].x;
ABS R1.z, R1;
MAD R1.z, R2.w, R1, c[23].x;
ADD R2.w, R1.z, -c[21].x;
ADD R1.z, R1, c[21].x;
SLT R2.x, vertex.position.z, R2.w;
MAD R0.w, -R0, R2.x, R0;
MAD R2.x, R2, c[0].z, c[0];
SLT R2.y, R1.z, vertex.position.z;
MUL R2.y, R2.x, R2;
ADD R2.z, -R0.w, c[0].x;
MAD R0.w, R2.z, R2.y, R0;
ADD R2.z, -R2.w, R1;
MAD R1.z, R2.y, -R2.x, R2.x;
MUL R2.x, R2, R1.z;
DP4 R1.z, vertex.position, c[3];
ABS R2.z, R2;
ADD R2.y, vertex.position.z, -R2.w;
RCP R2.z, R2.z;
ABS R2.y, R2;
MUL R2.y, R2, R2.z;
ADD R2.y, R2, -R0.w;
MAD result.texcoord[3].x, R2.y, R2, R0.w;
MOV result.position, R1;
MOV result.texcoord[6].zw, R1;
MOV result.texcoord[0].xyz, R0;
MAD result.texcoord[5].xy, vertex.texcoord[1], c[24], c[24].zwzw;
END
# 60 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Matrix 8 [_World2Object]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Float 16 [_Lerp]
Float 17 [_Kr]
Float 18 [_KrMin]
Float 19 [_FresnelExpon]
Float 20 [_FresnelPower]
Float 21 [_Penumbra]
Float 22 [_zMax]
Float 23 [_zMin]
Vector 24 [unity_LightmapST]
"vs_2_0
; 76 ALU
def c25, 1.00000000, 2.00000000, 0.00000000, 0.50000000
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord1 v2
mov r1.w, c25.x
mov r1.xyz, c15
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r1.xyz, r0, c14.w, -v0
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul r1.xyz, r0.y, r1
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r1.w, r0, r1
mul r2.xyz, r0, c25.y
mad r2.xyz, -r2, r1.w, r1
abs r1.w, r1
mov oT2.xyz, -r2
add r2.x, -r1.w, c25
mov oT1.xyz, r1
pow r1, r2.x, c19.x
mov r1.y, c22.x
add r1.z, -c23.x, r1.y
mov r1.y, c16.x
add r1.y, c25.x, -r1
abs r1.z, r1
mad r1.z, r1.y, r1, c23.x
add r3.y, r1.z, -c21.x
mov r1.y, r1.x
add r2.w, r1.z, c21.x
mov r1.x, c17
add r1.x, -c18, r1
mad r1.x, r1, r1.y, c18
slt r3.x, v0.z, r3.y
max r1.y, -r3.x, r3.x
slt r1.y, c25.z, r1
add r1.z, -r1.y, c25.x
slt r1.w, r2, v0.z
mul r3.z, r1, r1.w
mul oT2.w, r1.x, c20.x
max r3.w, -r3.z, r3.z
slt r3.w, c25.z, r3
add r3.w, -r3, c25.x
mul r3.w, r1.z, r3
mul r1.z, r1, r3.w
dp4 r1.w, v0, c3
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r2.xyz, r1.xyww, c25.w
mul r2.y, r2, c12.x
mad oT6.xy, r2.z, c13.zwzw, r2
max r2.x, -r3, r3
slt r2.y, c25.z, r2.x
max r2.x, -r3.z, r3.z
add r2.y, -r2, c25.x
slt r2.x, c25.z, r2
mul r2.y, r2, r0.w
add r0.w, -r2.x, c25.x
mad r2.y, r0.w, r2, r2.x
max r1.z, -r1, r1
slt r0.w, c25.z, r1.z
add r2.x, -r0.w, c25
add r1.z, -r3.y, r2.w
mul r2.y, r2.x, r2
abs r2.x, r1.z
add r1.z, v0, -r3.y
abs r1.z, r1
rcp r2.x, r2.x
mul r2.x, r1.z, r2
dp4 r1.z, v0, c2
mad oT3.x, r0.w, r2, r2.y
mov oPos, r1
mov oT6.zw, r1
mov oT0.xyz, r0
mad oT5.xy, v2, c24, c24.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [unity_4LightPosX0]
Vector 16 [unity_4LightPosY0]
Vector 17 [unity_4LightPosZ0]
Vector 18 [unity_4LightAtten0]
Vector 19 [unity_LightColor0]
Vector 20 [unity_LightColor1]
Vector 21 [unity_LightColor2]
Vector 22 [unity_LightColor3]
Vector 23 [unity_SHAr]
Vector 24 [unity_SHAg]
Vector 25 [unity_SHAb]
Vector 26 [unity_SHBr]
Vector 27 [unity_SHBg]
Vector 28 [unity_SHBb]
Vector 29 [unity_SHC]
Float 30 [_Lerp]
Float 31 [_Kr]
Float 32 [_KrMin]
Float 33 [_FresnelExpon]
Float 34 [_FresnelPower]
Float 35 [_Penumbra]
Float 36 [_zMax]
Float 37 [_zMin]
"!!ARBvp1.0
# 106 ALU
PARAM c[38] = { { 1, 2, -1, 0 },
		state.matrix.mvp,
		program.local[5..37] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R3.xyz, vertex.normal, c[13].w;
DP3 R4.x, R3, c[5];
DP3 R5.x, R3, c[6];
DP3 R3.x, R3, c[7];
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[16];
MUL R2, R5.x, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[15];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MOV R4.w, c[0].x;
MAD R2, R4.x, R0, R2;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[17];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[18];
MOV R4.y, R5.x;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
DP4 R2.z, R4, c[25];
DP4 R2.y, R4, c[24];
DP4 R2.x, R4, c[23];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].w;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[20];
MAD R1.xyz, R0.x, c[19], R1;
MAD R0.xyz, R0.z, c[21], R1;
MAD R1.xyz, R0.w, c[22], R0;
MUL R0, R4.xyzz, R4.yzzx;
MUL R1.w, R5.x, R5.x;
DP4 R4.w, R0, c[28];
DP4 R4.z, R0, c[27];
DP4 R4.y, R0, c[26];
MAD R1.w, R4.x, R4.x, -R1;
ADD R2.xyz, R2, R4.yzww;
MUL R0.xyz, R1.w, c[29];
ADD R2.xyz, R2, R0;
MOV R0.w, c[0].x;
MOV R0.xyz, c[14];
DP4 R4.w, R0, c[11];
DP4 R4.y, R0, c[9];
DP4 R4.z, R0, c[10];
DP3 R0.w, vertex.normal, vertex.normal;
MAD R0.xyz, R4.yzww, c[13].w, -vertex.position;
ADD result.texcoord[5].xyz, R2, R1;
DP3 R1.x, R0, R0;
RSQ R1.x, R1.x;
MUL R1.xyz, R1.x, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, vertex.normal;
DP3 R0.w, R0, R1;
MUL R2.xyz, R0, c[0].y;
MAD R2.xyz, -R2, R0.w, R1;
MOV result.texcoord[1].xyz, R1;
ABS R0.w, R0;
ADD R0.w, -R0, c[0].x;
POW R1.y, R0.w, c[33].x;
MOV R0.w, c[37].x;
ADD R1.z, -R0.w, c[36].x;
MOV R0.w, c[0].x;
MOV R1.x, c[32];
ADD R0.w, R0, -c[30].x;
ABS R1.z, R1;
MAD R1.z, R0.w, R1, c[37].x;
ADD R0.w, -R1.x, c[31].x;
MAD R1.x, R0.w, R1.y, c[32];
ADD R0.w, R1.z, -c[35].x;
SLT R1.y, vertex.position.z, R0.w;
MUL result.texcoord[2].w, R1.x, c[34].x;
ADD R1.x, R1.z, c[35];
MOV result.texcoord[2].xyz, -R2;
SLT R2.x, R1, vertex.position.z;
ADD R1.x, -R0.w, R1;
MAD R1.w, R1.y, c[0].z, c[0].x;
MAD R1.z, -R3.w, R1.y, R3.w;
ABS R1.x, R1;
ADD R0.w, vertex.position.z, -R0;
MUL R2.x, R1.w, R2;
ADD R1.y, -R1.z, c[0].x;
MAD R1.y, R1, R2.x, R1.z;
MAD R1.z, R2.x, -R1.w, R1.w;
MUL R1.z, R1.w, R1;
RCP R1.x, R1.x;
ABS R0.w, R0;
MUL R0.w, R0, R1.x;
ADD R0.w, R0, -R1.y;
MAD result.texcoord[3].x, R0.w, R1.z, R1.y;
MOV result.texcoord[0].xyz, R0;
MOV result.texcoord[4].z, R3.x;
MOV result.texcoord[4].y, R5.x;
MOV result.texcoord[4].x, R4;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 106 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [unity_4LightPosX0]
Vector 15 [unity_4LightPosY0]
Vector 16 [unity_4LightPosZ0]
Vector 17 [unity_4LightAtten0]
Vector 18 [unity_LightColor0]
Vector 19 [unity_LightColor1]
Vector 20 [unity_LightColor2]
Vector 21 [unity_LightColor3]
Vector 22 [unity_SHAr]
Vector 23 [unity_SHAg]
Vector 24 [unity_SHAb]
Vector 25 [unity_SHBr]
Vector 26 [unity_SHBg]
Vector 27 [unity_SHBb]
Vector 28 [unity_SHC]
Float 29 [_Lerp]
Float 30 [_Kr]
Float 31 [_KrMin]
Float 32 [_FresnelExpon]
Float 33 [_FresnelPower]
Float 34 [_Penumbra]
Float 35 [_zMax]
Float 36 [_zMin]
"vs_2_0
; 122 ALU
def c37, 1.00000000, 2.00000000, 0.00000000, 0
dcl_position0 v0
dcl_normal0 v1
mul r3.xyz, v1, c12.w
dp3 r4.x, r3, c4
dp3 r5.x, r3, c5
dp3 r3.x, r3, c6
dp4 r0.x, v0, c5
add r1, -r0.x, c15
mul r2, r5.x, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c14
mul r1, r1, r1
mov r4.z, r3.x
mov r4.w, c37.x
mad r2, r4.x, r0, r2
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c16
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c17
mov r4.y, r5.x
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c37.x
dp4 r2.z, r4, c24
dp4 r2.y, r4, c23
dp4 r2.x, r4, c22
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c37.z
mul r0, r0, r1
mul r1.xyz, r0.y, c19
mad r1.xyz, r0.x, c18, r1
mad r0.xyz, r0.z, c20, r1
mul r1, r4.xyzz, r4.yzzx
mad r0.xyz, r0.w, c21, r0
mul r0.w, r5.x, r5.x
dp4 r4.w, r1, c27
dp4 r4.z, r1, c26
dp4 r4.y, r1, c25
mov r1.w, c37.x
mov r1.xyz, c13
dp4 r5.w, r1, c10
dp4 r5.y, r1, c8
dp4 r5.z, r1, c9
mad r1.xyz, r5.yzww, c12.w, -v0
dp3 r1.w, r1, r1
add r2.xyz, r2, r4.yzww
mad r0.w, r4.x, r4.x, -r0
mul r4.yzw, r0.w, c28.xxyz
add r2.xyz, r2, r4.yzww
add oT5.xyz, r2, r0
rsq r1.w, r1.w
mul r4.yzw, r1.w, r1.xxyz
mov r0.x, c35
add r0.y, -c36.x, r0.x
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul r1.xyz, r0.w, v1
mov r0.x, c29
dp3 r0.w, r1, r4.yzww
mul r5.yzw, r1.xxyz, c37.y
mad r5.yzw, -r5, r0.w, r4
abs r0.y, r0
add r0.x, c37, -r0
mad r2.z, r0.x, r0.y, c36.x
add r1.w, r2.z, -c34.x
abs r0.x, r0.w
add r2.y, -r0.x, c37.x
pow r0, r2.y, c32.x
add r0.y, r2.z, c34.x
slt r2.x, v0.z, r1.w
max r0.z, -r2.x, r2.x
slt r0.z, c37, r0
add r0.z, -r0, c37.x
slt r0.w, r0.y, v0.z
mul r0.w, r0.z, r0
mov r2.y, r0.x
max r2.z, -r0.w, r0.w
slt r2.z, c37, r2
mov r0.x, c30
add r0.x, -c31, r0
mad r0.x, r0, r2.y, c31
add r2.z, -r2, c37.x
mul r2.y, r0.z, r2.z
mul oT2.w, r0.x, c33.x
mul r0.x, r0.z, r2.y
max r0.z, -r2.x, r2.x
slt r2.x, c37.z, r0.z
max r0.z, -r0.w, r0.w
add r0.w, -r2.x, c37.x
max r0.x, -r0, r0
slt r0.z, c37, r0
mul r2.x, r0.w, r3.w
add r0.w, -r0.z, c37.x
mad r0.w, r0, r2.x, r0.z
slt r0.x, c37.z, r0
add r0.z, -r0.x, c37.x
add r0.y, -r1.w, r0
mul r0.w, r0.z, r0
abs r0.z, r0.y
add r0.y, v0.z, -r1.w
rcp r0.z, r0.z
abs r0.y, r0
mul r0.y, r0, r0.z
mov oT2.xyz, -r5.yzww
mov oT1.xyz, r4.yzww
mad oT3.x, r0, r0.y, r0.w
mov oT0.xyz, r1
mov oT4.z, r3.x
mov oT4.y, r5.x
mov oT4.x, r4
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Float 31 [_Lerp]
Float 32 [_Kr]
Float 33 [_KrMin]
Float 34 [_FresnelExpon]
Float 35 [_FresnelPower]
Float 36 [_Penumbra]
Float 37 [_zMax]
Float 38 [_zMin]
"!!ARBvp1.0
# 111 ALU
PARAM c[40] = { { 1, 2, -1, 0 },
		state.matrix.mvp,
		program.local[5..38],
		{ 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
MUL R3.xyz, vertex.normal, c[14].w;
DP3 R4.x, R3, c[5];
DP3 R5.x, R3, c[6];
DP3 R3.x, R3, c[7];
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[17];
MUL R2, R5.x, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[16];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MOV R4.w, c[0].x;
MAD R2, R4.x, R0, R2;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[18];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[19];
MOV R4.y, R5.x;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
DP4 R2.z, R4, c[26];
DP4 R2.y, R4, c[25];
DP4 R2.x, R4, c[24];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].w;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[21];
MAD R1.xyz, R0.x, c[20], R1;
MAD R0.xyz, R0.z, c[22], R1;
MAD R1.xyz, R0.w, c[23], R0;
MUL R0, R4.xyzz, R4.yzzx;
MUL R1.w, R5.x, R5.x;
DP4 R4.w, R0, c[29];
DP4 R4.z, R0, c[28];
DP4 R4.y, R0, c[27];
MAD R1.w, R4.x, R4.x, -R1;
ADD R2.xyz, R2, R4.yzww;
MUL R0.xyz, R1.w, c[30];
ADD R2.xyz, R2, R0;
MOV R0.w, c[0].x;
MOV R0.xyz, c[15];
DP4 R4.w, R0, c[11];
DP4 R4.y, R0, c[9];
DP4 R4.z, R0, c[10];
DP3 R0.w, vertex.normal, vertex.normal;
MAD R0.xyz, R4.yzww, c[14].w, -vertex.position;
ADD result.texcoord[5].xyz, R2, R1;
DP3 R1.x, R0, R0;
RSQ R1.x, R1.x;
MUL R1.xyz, R1.x, R0;
RSQ R0.w, R0.w;
MUL R0.xyz, R0.w, vertex.normal;
DP3 R0.w, R0, R1;
MUL R2.xyz, R0, c[0].y;
MAD R2.xyz, -R2, R0.w, R1;
MOV result.texcoord[1].xyz, R1;
ABS R0.w, R0;
ADD R1.w, -R0, c[0].x;
MOV R0.w, c[33].x;
POW R1.w, R1.w, c[34].x;
ADD R0.w, -R0, c[32].x;
MAD R0.w, R0, R1, c[33].x;
MUL result.texcoord[2].w, R0, c[35].x;
MOV R0.w, c[38].x;
ADD R1.z, -R0.w, c[37].x;
MOV R0.w, c[0].x;
DP4 R1.w, vertex.position, c[4];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MOV result.texcoord[2].xyz, -R2;
MUL R2.xyz, R1.xyww, c[39].x;
MUL R2.y, R2, c[13].x;
ADD result.texcoord[6].xy, R2, R2.z;
ADD R0.w, R0, -c[31].x;
ABS R1.z, R1;
MAD R1.z, R0.w, R1, c[38].x;
ADD R0.w, R1.z, -c[36].x;
SLT R2.x, vertex.position.z, R0.w;
ADD R2.y, R1.z, c[36].x;
SLT R2.w, R2.y, vertex.position.z;
ADD R2.y, -R0.w, R2;
MAD R1.z, R2.x, c[0], c[0].x;
MAD R2.z, -R3.w, R2.x, R3.w;
ABS R2.y, R2;
ADD R0.w, vertex.position.z, -R0;
MUL R2.w, R1.z, R2;
ADD R2.x, -R2.z, c[0];
MAD R2.x, R2, R2.w, R2.z;
MAD R2.z, R2.w, -R1, R1;
RCP R2.y, R2.y;
ABS R0.w, R0;
MUL R0.w, R0, R2.y;
MUL R2.y, R1.z, R2.z;
DP4 R1.z, vertex.position, c[3];
ADD R0.w, R0, -R2.x;
MAD result.texcoord[3].x, R0.w, R2.y, R2;
MOV result.position, R1;
MOV result.texcoord[6].zw, R1;
MOV result.texcoord[0].xyz, R0;
MOV result.texcoord[4].z, R3.x;
MOV result.texcoord[4].y, R5.x;
MOV result.texcoord[4].x, R4;
END
# 111 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Float 31 [_Lerp]
Float 32 [_Kr]
Float 33 [_KrMin]
Float 34 [_FresnelExpon]
Float 35 [_FresnelPower]
Float 36 [_Penumbra]
Float 37 [_zMax]
Float 38 [_zMin]
"vs_2_0
; 127 ALU
def c39, 1.00000000, 2.00000000, 0.00000000, 0.50000000
dcl_position0 v0
dcl_normal0 v1
mul r3.xyz, v1, c14.w
dp3 r4.x, r3, c4
dp3 r5.x, r3, c5
dp3 r3.x, r3, c6
dp4 r0.x, v0, c5
add r1, -r0.x, c17
mul r2, r5.x, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c16
mul r1, r1, r1
mov r4.z, r3.x
mov r4.w, c39.x
mad r2, r4.x, r0, r2
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c18
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c19
mov r4.y, r5.x
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c39.x
dp4 r2.z, r4, c26
dp4 r2.y, r4, c25
dp4 r2.x, r4, c24
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c39.z
mul r0, r0, r1
mul r1.xyz, r0.y, c21
mad r1.xyz, r0.x, c20, r1
mad r0.xyz, r0.z, c22, r1
mad r1.xyz, r0.w, c23, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r5.x, r5.x
dp4 r4.w, r0, c29
dp4 r4.z, r0, c28
dp4 r4.y, r0, c27
mad r1.w, r4.x, r4.x, -r1
add r2.xyz, r2, r4.yzww
mul r0.xyz, r1.w, c30
add r2.xyz, r2, r0
mov r0.w, c39.x
mov r0.xyz, c15
dp4 r4.y, r0, c8
add oT5.xyz, r2, r1
dp4 r4.w, r0, c10
dp4 r4.z, r0, c9
mad r0.xyz, r4.yzww, c14.w, -v0
dp3 r1.x, r0, r0
rsq r1.x, r1.x
mul r0.xyz, r1.x, r0
dp3 r0.w, v1, v1
rsq r0.w, r0.w
mul r1.xyz, r0.w, v1
dp3 r0.w, r1, r0
mul r2.xyz, r1, c39.y
mad r2.xyz, -r2, r0.w, r0
abs r0.w, r0
add r1.w, -r0, c39.x
mov oT1.xyz, r0
pow r0, r1.w, c34.x
mov r0.y, c37.x
add r0.z, -c38.x, r0.y
mov r0.y, c31.x
add r0.y, c39.x, -r0
abs r0.z, r0
mad r0.z, r0.y, r0, c38.x
add r1.w, r0.z, -c36.x
mov r0.y, r0.x
add r0.z, r0, c36.x
slt r0.w, r0.z, v0.z
mov r0.x, c32
add r0.x, -c33, r0
mad r0.x, r0, r0.y, c33
slt r3.y, v0.z, r1.w
max r0.y, -r3, r3
slt r0.y, c39.z, r0
add r3.z, -r0.y, c39.x
mul r2.w, r3.z, r0
max r4.y, -r2.w, r2.w
mul oT2.w, r0.x, c35.x
slt r4.y, c39.z, r4
add r4.y, -r4, c39.x
dp4 r0.w, v0, c3
add r0.z, -r1.w, r0
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oT2.xyz, -r2
mul r2.xyz, r0.xyww, c39.w
mul r2.y, r2, c12.x
mad oT6.xy, r2.z, c13.zwzw, r2
max r2.y, -r3, r3
slt r2.z, c39, r2.y
max r2.y, -r2.w, r2.w
add r2.z, -r2, c39.x
mul r4.y, r3.z, r4
mul r2.x, r3.z, r4.y
max r2.x, -r2, r2
slt r2.y, c39.z, r2
mul r2.w, r2.z, r3
add r2.z, -r2.y, c39.x
mad r2.z, r2, r2.w, r2.y
slt r2.x, c39.z, r2
add r2.y, -r2.x, c39.x
mul r2.z, r2.y, r2
abs r2.y, r0.z
add r0.z, v0, -r1.w
abs r0.z, r0
rcp r1.w, r2.y
mul r1.w, r0.z, r1
dp4 r0.z, v0, c2
mad oT3.x, r2, r1.w, r2.z
mov oPos, r0
mov oT6.zw, r0
mov oT0.xyz, r1
mov oT4.z, r3.x
mov oT4.y, r5.x
mov oT4.x, r4
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_Color_1]
Vector 4 [_Color_2]
Vector 5 [_Color_A]
Vector 6 [_Color_A1]
Vector 7 [_Color_A2]
Float 8 [_CubeMapLerp]
Float 9 [_Reflection]
SetTexture 0 [_Cube] CUBE
SetTexture 1 [_Cube_01] CUBE
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 31 ALU, 2 TEX
PARAM c[11] = { program.local[0..9],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R1.xyz, fragment.texcoord[2], texture[0], CUBE;
TEX R0.xyz, fragment.texcoord[2], texture[1], CUBE;
ADD R0.xyz, R0, -R1;
MAD R0.xyz, R0, c[8].x, R1;
MOV R3.xyz, c[2];
ADD R3.xyz, -R3, c[5];
MAD R4.xyz, fragment.texcoord[3].x, R3, c[2];
MOV R2.xyz, c[3];
ADD R2.xyz, -R2, c[6];
MAD R2.xyz, fragment.texcoord[3].x, R2, c[3];
ADD R5.xyz, R2, -R4;
MOV R2.xyz, fragment.texcoord[1];
DP3_SAT R0.w, fragment.texcoord[0], R2;
MAD R2.xyz, R0.w, R5, R4;
MOV R3.xyz, c[4];
ADD R3.xyz, -R3, c[7];
MAD R3.xyz, fragment.texcoord[3].x, R3, c[4];
MUL R0.w, R0, R0;
MUL R0.w, R0, R0;
ADD R3.xyz, R3, -R2;
MAD R1.xyz, R0.w, R3, R2;
MUL R0.xyz, R0, c[9].x;
MAD R1.xyz, R0, fragment.texcoord[2].w, R1;
MUL R0.xyz, R1, fragment.texcoord[5];
DP3 R0.w, fragment.texcoord[4], c[0];
MAX R0.w, R0, c[10].x;
MUL R0.w, R0, c[10].y;
MUL R1.xyz, R1, c[1];
MUL R1.xyz, R1, R0.w;
ADD result.color.xyz, R1, R0;
MOV result.color.w, c[10].x;
END
# 31 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_Color_1]
Vector 4 [_Color_2]
Vector 5 [_Color_A]
Vector 6 [_Color_A1]
Vector 7 [_Color_A2]
Float 8 [_CubeMapLerp]
Float 9 [_Reflection]
SetTexture 0 [_Cube] CUBE
SetTexture 1 [_Cube_01] CUBE
"ps_2_0
; 30 ALU, 2 TEX
dcl_cube s0
dcl_cube s1
def c10, 0.00000000, 2.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2
dcl t3.x
dcl t4.xyz
dcl t5.xyz
texld r0, t2, s1
texld r1, t2, s0
add r2.xyz, r0, -r1
mad r1.xyz, r2, c8.x, r1
mov r3.xyz, c5
add r3.xyz, -c2, r3
mad r4.xyz, t3.x, r3, c2
mov r0.xyz, c6
add r0.xyz, -c3, r0
mad r0.xyz, t3.x, r0, c3
add r5.xyz, r0, -r4
mov r0.xyz, t1
dp3_sat r0.x, t0, r0
mad r4.xyz, r0.x, r5, r4
mov r3.xyz, c7
add r3.xyz, -c4, r3
mul r0.x, r0, r0
mad r3.xyz, t3.x, r3, c4
mul r0.x, r0, r0
add r3.xyz, r3, -r4
mad r3.xyz, r0.x, r3, r4
dp3_pp r0.x, t4, c0
mul r1.xyz, r1, c9.x
mad r1.xyz, r1, t2.w, r3
mul r2.xyz, r1, c1
max_pp r0.x, r0, c10
mul_pp r0.x, r0, c10.y
mul r0.xyz, r2, r0.x
mul r1.xyz, r1, t5
mov_pp r0.w, c10.x
add_pp r0.xyz, r0, r1
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" }
Vector 0 [_Color]
Vector 1 [_Color_1]
Vector 2 [_Color_2]
Vector 3 [_Color_A]
Vector 4 [_Color_A1]
Vector 5 [_Color_A2]
Float 6 [_CubeMapLerp]
Float 7 [_Reflection]
SetTexture 0 [_Cube] CUBE
SetTexture 1 [_Cube_01] CUBE
SetTexture 2 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 28 ALU, 3 TEX
PARAM c[9] = { program.local[0..7],
		{ 0, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEX R0, fragment.texcoord[5], texture[2], 2D;
TEX R2.xyz, fragment.texcoord[2], texture[0], CUBE;
TEX R1.xyz, fragment.texcoord[2], texture[1], CUBE;
ADD R1.xyz, R1, -R2;
MAD R1.xyz, R1, c[6].x, R2;
MOV R4.xyz, c[0];
ADD R4.xyz, -R4, c[3];
MAD R5.xyz, fragment.texcoord[3].x, R4, c[0];
MOV R3.xyz, c[1];
ADD R3.xyz, -R3, c[4];
MAD R3.xyz, fragment.texcoord[3].x, R3, c[1];
ADD R6.xyz, R3, -R5;
MOV R3.xyz, fragment.texcoord[1];
DP3_SAT R1.w, fragment.texcoord[0], R3;
MAD R3.xyz, R1.w, R6, R5;
MOV R4.xyz, c[2];
ADD R4.xyz, -R4, c[5];
MAD R4.xyz, fragment.texcoord[3].x, R4, c[2];
MUL R1.w, R1, R1;
ADD R4.xyz, R4, -R3;
MUL R1.w, R1, R1;
MAD R2.xyz, R1.w, R4, R3;
MUL R1.xyz, R1, c[7].x;
MAD R1.xyz, R1, fragment.texcoord[2].w, R2;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[8].y;
MOV result.color.w, c[8].x;
END
# 28 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" }
Vector 0 [_Color]
Vector 1 [_Color_1]
Vector 2 [_Color_2]
Vector 3 [_Color_A]
Vector 4 [_Color_A1]
Vector 5 [_Color_A2]
Float 6 [_CubeMapLerp]
Float 7 [_Reflection]
SetTexture 0 [_Cube] CUBE
SetTexture 1 [_Cube_01] CUBE
SetTexture 2 [unity_Lightmap] 2D
"ps_2_0
; 26 ALU, 3 TEX
dcl_cube s0
dcl_cube s1
dcl_2d s2
def c8, 8.00000000, 0.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2
dcl t3.x
dcl t5.xy
texld r0, t2, s0
texld r1, t5, s2
texld r2, t2, s1
add r2.xyz, r2, -r0
mad r2.xyz, r2, c6.x, r0
mov r3.xyz, c3
add r3.xyz, -c0, r3
mad r4.xyz, t3.x, r3, c0
mov r0.xyz, c4
add r0.xyz, -c1, r0
mad r0.xyz, t3.x, r0, c1
add r5.xyz, r0, -r4
mov r0.xyz, t1
dp3_sat r0.x, t0, r0
mad r4.xyz, r0.x, r5, r4
mov r3.xyz, c5
add r3.xyz, -c2, r3
mul r0.x, r0, r0
mad r3.xyz, t3.x, r3, c2
add r3.xyz, r3, -r4
mul r0.x, r0, r0
mad r0.xyz, r0.x, r3, r4
mul r2.xyz, r2, c7.x
mad r0.xyz, r2, t2.w, r0
mul_pp r1.xyz, r1.w, r1
mul_pp r0.xyz, r1, r0
mul_pp r0.xyz, r0, c8.x
mov_pp r0.w, c8.y
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_Color_1]
Vector 4 [_Color_2]
Vector 5 [_Color_A]
Vector 6 [_Color_A1]
Vector 7 [_Color_A2]
Float 8 [_CubeMapLerp]
Float 9 [_Reflection]
SetTexture 0 [_Cube] CUBE
SetTexture 1 [_Cube_01] CUBE
SetTexture 2 [_ShadowMapTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 33 ALU, 3 TEX
PARAM c[11] = { program.local[0..9],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0.xyz, fragment.texcoord[2], texture[0], CUBE;
TEX R1.xyz, fragment.texcoord[2], texture[1], CUBE;
TXP R3.x, fragment.texcoord[6], texture[2], 2D;
ADD R1.xyz, R1, -R0;
MOV R2.xyz, c[3];
MOV R4.xyz, c[2];
MAD R0.xyz, R1, c[8].x, R0;
ADD R5.xyz, -R2, c[6];
ADD R4.xyz, -R4, c[5];
MAD R2.xyz, fragment.texcoord[3].x, R4, c[2];
MAD R4.xyz, fragment.texcoord[3].x, R5, c[3];
ADD R3.yzw, R4.xxyz, -R2.xxyz;
MOV R4.xyz, c[4];
MOV R5.xyz, fragment.texcoord[1];
DP3_SAT R0.w, fragment.texcoord[0], R5;
MAD R2.xyz, R0.w, R3.yzww, R2;
ADD R4.xyz, -R4, c[7];
MAD R4.xyz, fragment.texcoord[3].x, R4, c[4];
MUL R0.w, R0, R0;
ADD R4.xyz, R4, -R2;
MUL R0.w, R0, R0;
MAD R1.xyz, R0.w, R4, R2;
MUL R2.xyz, R0, c[9].x;
DP3 R0.x, fragment.texcoord[4], c[0];
MAX R0.x, R0, c[10];
MUL R0.w, R0.x, R3.x;
MAD R1.xyz, R2, fragment.texcoord[2].w, R1;
MUL R0.xyz, R1, fragment.texcoord[5];
MUL R0.w, R0, c[10].y;
MUL R1.xyz, R1, c[1];
MUL R1.xyz, R1, R0.w;
ADD result.color.xyz, R1, R0;
MOV result.color.w, c[10].x;
END
# 33 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
Vector 2 [_Color]
Vector 3 [_Color_1]
Vector 4 [_Color_2]
Vector 5 [_Color_A]
Vector 6 [_Color_A1]
Vector 7 [_Color_A2]
Float 8 [_CubeMapLerp]
Float 9 [_Reflection]
SetTexture 0 [_Cube] CUBE
SetTexture 1 [_Cube_01] CUBE
SetTexture 2 [_ShadowMapTexture] 2D
"ps_2_0
; 31 ALU, 3 TEX
dcl_cube s0
dcl_cube s1
dcl_2d s2
def c10, 0.00000000, 2.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2
dcl t3.x
dcl t4.xyz
dcl t5.xyz
dcl t6
texld r0, t2, s0
texldp r5, t6, s2
texld r1, t2, s1
add r1.xyz, r1, -r0
mad r1.xyz, r1, c8.x, r0
mov r2.xyz, c5
add r2.xyz, -c2, r2
mad r3.xyz, t3.x, r2, c2
mov r0.xyz, c6
add r0.xyz, -c3, r0
mad r0.xyz, t3.x, r0, c3
add r4.xyz, r0, -r3
mov r0.xyz, t1
dp3_sat r0.x, t0, r0
mad r3.xyz, r0.x, r4, r3
mov r2.xyz, c7
add r2.xyz, -c4, r2
mul r0.x, r0, r0
mad r2.xyz, t3.x, r2, c4
mul r0.x, r0, r0
add r2.xyz, r2, -r3
mad r2.xyz, r0.x, r2, r3
mul r1.xyz, r1, c9.x
mad r1.xyz, r1, t2.w, r2
mul r2.xyz, r1, c1
dp3_pp r0.x, t4, c0
max_pp r0.x, r0, c10
mul_pp r0.x, r0, r5
mul_pp r0.x, r0, c10.y
mul r0.xyz, r2, r0.x
mul r1.xyz, r1, t5
mov_pp r0.w, c10.x
add_pp r0.xyz, r0, r1
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
Vector 0 [_Color]
Vector 1 [_Color_1]
Vector 2 [_Color_2]
Vector 3 [_Color_A]
Vector 4 [_Color_A1]
Vector 5 [_Color_A2]
Float 6 [_CubeMapLerp]
Float 7 [_Reflection]
SetTexture 0 [_Cube] CUBE
SetTexture 1 [_Cube_01] CUBE
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 31 ALU, 4 TEX
PARAM c[9] = { program.local[0..7],
		{ 0, 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEX R0, fragment.texcoord[5], texture[3], 2D;
TEX R2.xyz, fragment.texcoord[2], texture[0], CUBE;
TEX R1.xyz, fragment.texcoord[2], texture[1], CUBE;
TXP R3.x, fragment.texcoord[6], texture[2], 2D;
MUL R0.xyz, R0.w, R0;
ADD R1.xyz, R1, -R2;
MAD R1.xyz, R1, c[6].x, R2;
MOV R5.xyz, c[0];
ADD R5.xyz, -R5, c[3];
MAD R6.xyz, fragment.texcoord[3].x, R5, c[0];
MOV R5.xyz, fragment.texcoord[1];
MOV R4.xyz, c[1];
ADD R4.xyz, -R4, c[4];
MAD R4.xyz, fragment.texcoord[3].x, R4, c[1];
ADD R3.yzw, R4.xxyz, -R6.xxyz;
DP3_SAT R1.w, fragment.texcoord[0], R5;
MAD R5.xyz, R1.w, R3.yzww, R6;
MOV R4.xyz, c[2];
ADD R4.xyz, -R4, c[5];
MAD R4.xyz, fragment.texcoord[3].x, R4, c[2];
MUL R1.w, R1, R1;
ADD R4.xyz, R4, -R5;
MUL R1.w, R1, R1;
MAD R2.xyz, R1.w, R4, R5;
MUL R1.xyz, R1, c[7].x;
MUL R0.w, R3.x, c[8].z;
MUL R0.xyz, R0, c[8].y;
MIN R0.xyz, R0, R0.w;
MAD R1.xyz, R1, fragment.texcoord[2].w, R2;
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[8].x;
END
# 31 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
Vector 0 [_Color]
Vector 1 [_Color_1]
Vector 2 [_Color_2]
Vector 3 [_Color_A]
Vector 4 [_Color_A1]
Vector 5 [_Color_A2]
Float 6 [_CubeMapLerp]
Float 7 [_Reflection]
SetTexture 0 [_Cube] CUBE
SetTexture 1 [_Cube_01] CUBE
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [unity_Lightmap] 2D
"ps_2_0
; 28 ALU, 4 TEX
dcl_cube s0
dcl_cube s1
dcl_2d s2
dcl_2d s3
def c8, 8.00000000, 2.00000000, 0.00000000, 0
dcl t0.xyz
dcl t1.xyz
dcl t2
dcl t3.x
dcl t5.xy
dcl t6
texld r0, t2, s0
texldp r6, t6, s2
texld r1, t5, s3
texld r2, t2, s1
add r2.xyz, r2, -r0
mad r2.xyz, r2, c6.x, r0
mov r3.xyz, c3
add r3.xyz, -c0, r3
mad r4.xyz, t3.x, r3, c0
mov r0.xyz, c4
add r0.xyz, -c1, r0
mad r0.xyz, t3.x, r0, c1
add r5.xyz, r0, -r4
mov r0.xyz, t1
dp3_sat r0.x, t0, r0
mad r4.xyz, r0.x, r5, r4
mov r3.xyz, c5
add r3.xyz, -c2, r3
mul r0.x, r0, r0
mad r3.xyz, t3.x, r3, c2
mul_pp r1.xyz, r1.w, r1
mul r0.x, r0, r0
add r3.xyz, r3, -r4
mad r3.xyz, r0.x, r3, r4
mul_pp r1.xyz, r1, c8.x
mul_pp r0.x, r6, c8.y
min_pp r0.xyz, r1, r0.x
mul r2.xyz, r2, c7.x
mad r1.xyz, r2, t2.w, r3
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c8.z
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "RenderType"="Opaque" }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
Program "vp" {
SubProgram "opengl " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Float 20 [_Lerp]
Float 21 [_Kr]
Float 22 [_KrMin]
Float 23 [_FresnelExpon]
Float 24 [_FresnelPower]
Float 25 [_Penumbra]
Float 26 [_zMax]
Float 27 [_zMin]
"!!ARBvp1.0
# 66 ALU
PARAM c[28] = { { 1, 2, -1 },
		state.matrix.mvp,
		program.local[5..27] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MAD R0.xyz, R0, c[17].w, -vertex.position;
DP3 R1.y, R0, R0;
DP3 R1.x, vertex.normal, vertex.normal;
RSQ R1.w, R1.x;
RSQ R1.y, R1.y;
MUL R1.xyz, R1.y, R0;
MUL R0.xyz, R1.w, vertex.normal;
DP3 R1.w, R0, R1;
MUL R2.xyz, R0, c[0].y;
MAD R2.xyz, -R2, R1.w, R1;
MOV result.texcoord[1].xyz, R1;
ABS R1.w, R1;
ADD R1.w, -R1, c[0].x;
POW R1.x, R1.w, c[23].x;
MOV R1.y, c[27].x;
ADD R1.w, -R1.y, c[26].x;
MOV R1.y, c[0].x;
MOV result.texcoord[2].xyz, -R2;
MOV R1.z, c[22].x;
ADD R1.y, R1, -c[20].x;
ABS R1.w, R1;
MAD R1.w, R1.y, R1, c[27].x;
ADD R1.y, -R1.z, c[21].x;
MAD R1.y, R1, R1.x, c[22].x;
ADD R1.x, R1.w, -c[25];
SLT R1.z, vertex.position, R1.x;
MAD R0.w, -R0, R1.z, R0;
MUL result.texcoord[2].w, R1.y, c[24].x;
ADD R1.y, R1.w, c[25].x;
MAD R1.z, R1, c[0], c[0].x;
SLT R1.w, R1.y, vertex.position.z;
MUL R2.x, R1.z, R1.w;
ADD R1.w, -R0, c[0].x;
MAD R0.w, R1, R2.x, R0;
ADD R1.w, -R1.x, R1.y;
MAD R2.x, R2, -R1.z, R1.z;
MUL R1.y, R1.z, R2.x;
MUL R2.xyz, vertex.normal, c[17].w;
ABS R1.z, R1.w;
ADD R1.x, vertex.position.z, -R1;
DP4 R1.w, vertex.position, c[8];
RCP R1.z, R1.z;
ABS R1.x, R1;
MUL R1.x, R1, R1.z;
ADD R1.x, R1, -R0.w;
MAD result.texcoord[3].x, R1, R1.y, R0.w;
DP4 R1.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
DP4 result.texcoord[6].z, R1, c[15];
DP4 result.texcoord[6].y, R1, c[14];
DP4 result.texcoord[6].x, R1, c[13];
MOV result.texcoord[0].xyz, R0;
DP3 result.texcoord[4].z, R2, c[7];
DP3 result.texcoord[4].y, R2, c[6];
DP3 result.texcoord[4].x, R2, c[5];
ADD result.texcoord[5].xyz, -R1, c[19];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 66 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Float 19 [_Lerp]
Float 20 [_Kr]
Float 21 [_KrMin]
Float 22 [_FresnelExpon]
Float 23 [_FresnelPower]
Float 24 [_Penumbra]
Float 25 [_zMax]
Float 26 [_zMin]
"vs_2_0
; 82 ALU
def c27, 1.00000000, 2.00000000, 0.00000000, 0
dcl_position0 v0
dcl_normal0 v1
mov r1.w, c27.x
mov r1.xyz, c17
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r1.xyz, r0, c16.w, -v0
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul r1.xyz, r0.y, r1
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r1.w, r0, r1
mul r2.xyz, r0, c27.y
mad r2.xyz, -r2, r1.w, r1
mov oT2.xyz, -r2
mov oT1.xyz, r1
mov r2.x, c25
add r1.y, -c26.x, r2.x
mov r1.x, c19
abs r1.y, r1
add r1.x, c27, -r1
mad r2.w, r1.x, r1.y, c26.x
add r2.x, r2.w, -c24
abs r1.x, r1.w
add r2.z, -r1.x, c27.x
pow r1, r2.z, c22.x
add r1.y, r2.w, c24.x
slt r2.y, v0.z, r2.x
max r1.z, -r2.y, r2.y
slt r1.z, c27, r1
add r1.z, -r1, c27.x
slt r1.w, r1.y, v0.z
mul r1.w, r1.z, r1
mov r2.z, r1.x
max r2.w, -r1, r1
slt r2.w, c27.z, r2
mov r1.x, c20
add r1.x, -c21, r1
mad r1.x, r1, r2.z, c21
add r2.w, -r2, c27.x
mul r2.z, r1, r2.w
mul oT2.w, r1.x, c23.x
mul r1.x, r1.z, r2.z
max r1.z, -r2.y, r2.y
slt r2.y, c27.z, r1.z
max r1.z, -r1.w, r1.w
add r1.w, -r2.y, c27.x
mul r1.w, r1, r0
slt r1.z, c27, r1
add r0.w, -r1.z, c27.x
mad r1.z, r0.w, r1.w, r1
max r1.x, -r1, r1
slt r0.w, c27.z, r1.x
add r1.x, -r2, r1.y
add r1.y, -r0.w, c27.x
mul r1.z, r1.y, r1
abs r1.y, r1.x
add r1.x, v0.z, -r2
mul r2.xyz, v1, c16.w
dp4 r1.w, v0, c7
rcp r1.y, r1.y
abs r1.x, r1
mul r1.x, r1, r1.y
mad oT3.x, r0.w, r1, r1.z
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
dp4 oT6.z, r1, c14
dp4 oT6.y, r1, c13
dp4 oT6.x, r1, c12
mov oT0.xyz, r0
dp3 oT4.z, r2, c6
dp3 oT4.y, r2, c5
dp3 oT4.x, r2, c4
add oT5.xyz, -r1, c18
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
Float 16 [_Lerp]
Float 17 [_Kr]
Float 18 [_KrMin]
Float 19 [_FresnelExpon]
Float 20 [_FresnelPower]
Float 21 [_Penumbra]
Float 22 [_zMax]
Float 23 [_zMin]
"!!ARBvp1.0
# 59 ALU
PARAM c[24] = { { 1, 2, -1 },
		state.matrix.mvp,
		program.local[5..23] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R1.xyz, c[14];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MAD R0.xyz, R0, c[13].w, -vertex.position;
DP3 R1.y, R0, R0;
DP3 R1.x, vertex.normal, vertex.normal;
RSQ R1.w, R1.x;
RSQ R1.y, R1.y;
MUL R1.xyz, R1.y, R0;
MUL R0.xyz, R1.w, vertex.normal;
DP3 R1.w, R0, R1;
MUL R2.xyz, R0, c[0].y;
MAD R2.xyz, -R2, R1.w, R1;
MOV result.texcoord[1].xyz, R1;
ABS R1.w, R1;
ADD R1.w, -R1, c[0].x;
POW R1.x, R1.w, c[19].x;
MOV R1.y, c[23].x;
ADD R1.w, -R1.y, c[22].x;
MOV R1.y, c[0].x;
MOV R1.z, c[18].x;
ADD R1.y, R1, -c[16].x;
ABS R1.w, R1;
MAD R1.w, R1.y, R1, c[23].x;
ADD R1.y, -R1.z, c[17].x;
MAD R1.y, R1, R1.x, c[18].x;
ADD R1.x, R1.w, -c[21];
SLT R1.z, vertex.position, R1.x;
MAD R0.w, -R0, R1.z, R0;
MUL result.texcoord[2].w, R1.y, c[20].x;
ADD R1.y, R1.w, c[21].x;
MAD R1.z, R1, c[0], c[0].x;
SLT R1.w, R1.y, vertex.position.z;
MOV result.texcoord[2].xyz, -R2;
MUL R2.x, R1.z, R1.w;
ADD R1.w, -R0, c[0].x;
MAD R0.w, R1, R2.x, R0;
ADD R1.w, -R1.x, R1.y;
MAD R2.x, R2, -R1.z, R1.z;
MUL R1.y, R1.z, R2.x;
ABS R1.z, R1.w;
ADD R1.x, vertex.position.z, -R1;
RCP R1.z, R1.z;
ABS R1.x, R1;
MUL R1.x, R1, R1.z;
ADD R1.x, R1, -R0.w;
MAD result.texcoord[3].x, R1, R1.y, R0.w;
MUL R1.xyz, vertex.normal, c[13].w;
MOV result.texcoord[0].xyz, R0;
DP3 result.texcoord[4].z, R1, c[7];
DP3 result.texcoord[4].y, R1, c[6];
DP3 result.texcoord[4].x, R1, c[5];
MOV result.texcoord[5].xyz, c[15];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 59 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Float 15 [_Lerp]
Float 16 [_Kr]
Float 17 [_KrMin]
Float 18 [_FresnelExpon]
Float 19 [_FresnelPower]
Float 20 [_Penumbra]
Float 21 [_zMax]
Float 22 [_zMin]
"vs_2_0
; 75 ALU
def c23, 1.00000000, 2.00000000, 0.00000000, 0
dcl_position0 v0
dcl_normal0 v1
mov r1.w, c23.x
mov r1.xyz, c13
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r1.xyz, r0, c12.w, -v0
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul r1.xyz, r0.y, r1
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r1.w, r0, r1
mul r2.xyz, r0, c23.y
mad r2.xyz, -r2, r1.w, r1
mov oT2.xyz, -r2
mov oT1.xyz, r1
mov r2.x, c21
add r1.y, -c22.x, r2.x
mov r1.x, c15
abs r1.y, r1
add r1.x, c23, -r1
mad r2.w, r1.x, r1.y, c22.x
add r2.x, r2.w, -c20
abs r1.x, r1.w
add r2.z, -r1.x, c23.x
pow r1, r2.z, c18.x
add r1.y, r2.w, c20.x
slt r2.y, v0.z, r2.x
max r1.z, -r2.y, r2.y
slt r1.z, c23, r1
add r1.z, -r1, c23.x
slt r1.w, r1.y, v0.z
mul r1.w, r1.z, r1
mov r2.z, r1.x
max r2.w, -r1, r1
slt r2.w, c23.z, r2
mov r1.x, c16
add r1.x, -c17, r1
mad r1.x, r1, r2.z, c17
add r2.w, -r2, c23.x
mul r2.z, r1, r2.w
mul oT2.w, r1.x, c19.x
mul r1.x, r1.z, r2.z
max r1.z, -r2.y, r2.y
slt r2.y, c23.z, r1.z
max r1.z, -r1.w, r1.w
add r1.w, -r2.y, c23.x
max r1.x, -r1, r1
slt r1.z, c23, r1
mul r1.w, r1, r0
add r0.w, -r1.z, c23.x
mad r1.z, r0.w, r1.w, r1
slt r0.w, c23.z, r1.x
add r1.x, -r2, r1.y
add r1.y, -r0.w, c23.x
mul r1.z, r1.y, r1
abs r1.y, r1.x
add r1.x, v0.z, -r2
rcp r1.y, r1.y
abs r1.x, r1
mul r1.x, r1, r1.y
mad oT3.x, r0.w, r1, r1.z
mul r1.xyz, v1, c12.w
mov oT0.xyz, r0
dp3 oT4.z, r1, c6
dp3 oT4.y, r1, c5
dp3 oT4.x, r1, c4
mov oT5.xyz, c14
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Float 20 [_Lerp]
Float 21 [_Kr]
Float 22 [_KrMin]
Float 23 [_FresnelExpon]
Float 24 [_FresnelPower]
Float 25 [_Penumbra]
Float 26 [_zMax]
Float 27 [_zMin]
"!!ARBvp1.0
# 67 ALU
PARAM c[28] = { { 1, 2, -1 },
		state.matrix.mvp,
		program.local[5..27] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MAD R0.xyz, R0, c[17].w, -vertex.position;
DP3 R1.y, R0, R0;
DP3 R1.x, vertex.normal, vertex.normal;
RSQ R1.w, R1.x;
RSQ R1.y, R1.y;
MUL R1.xyz, R1.y, R0;
MUL R0.xyz, R1.w, vertex.normal;
DP3 R1.w, R0, R1;
MUL R2.xyz, R0, c[0].y;
MAD R2.xyz, -R2, R1.w, R1;
MOV result.texcoord[1].xyz, R1;
ABS R1.w, R1;
ADD R1.w, -R1, c[0].x;
POW R1.x, R1.w, c[23].x;
MOV R1.y, c[27].x;
ADD R1.w, -R1.y, c[26].x;
MOV R1.y, c[0].x;
MOV result.texcoord[2].xyz, -R2;
MOV R1.z, c[22].x;
ADD R1.y, R1, -c[20].x;
ABS R1.w, R1;
MAD R1.w, R1.y, R1, c[27].x;
ADD R1.y, -R1.z, c[21].x;
MAD R1.y, R1, R1.x, c[22].x;
ADD R1.x, R1.w, -c[25];
SLT R1.z, vertex.position, R1.x;
MAD R0.w, -R0, R1.z, R0;
MUL result.texcoord[2].w, R1.y, c[24].x;
ADD R1.y, R1.w, c[25].x;
MAD R1.z, R1, c[0], c[0].x;
SLT R1.w, R1.y, vertex.position.z;
MUL R2.x, R1.z, R1.w;
ADD R1.w, -R0, c[0].x;
MAD R0.w, R1, R2.x, R0;
ADD R1.w, -R1.x, R1.y;
MAD R2.x, R2, -R1.z, R1.z;
MUL R1.y, R1.z, R2.x;
MUL R2.xyz, vertex.normal, c[17].w;
ABS R1.z, R1.w;
ADD R1.x, vertex.position.z, -R1;
DP4 R1.w, vertex.position, c[8];
RCP R1.z, R1.z;
ABS R1.x, R1;
MUL R1.x, R1, R1.z;
ADD R1.x, R1, -R0.w;
MAD result.texcoord[3].x, R1, R1.y, R0.w;
DP4 R1.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
DP4 result.texcoord[6].w, R1, c[16];
DP4 result.texcoord[6].z, R1, c[15];
DP4 result.texcoord[6].y, R1, c[14];
DP4 result.texcoord[6].x, R1, c[13];
MOV result.texcoord[0].xyz, R0;
DP3 result.texcoord[4].z, R2, c[7];
DP3 result.texcoord[4].y, R2, c[6];
DP3 result.texcoord[4].x, R2, c[5];
ADD result.texcoord[5].xyz, -R1, c[19];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 67 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Float 19 [_Lerp]
Float 20 [_Kr]
Float 21 [_KrMin]
Float 22 [_FresnelExpon]
Float 23 [_FresnelPower]
Float 24 [_Penumbra]
Float 25 [_zMax]
Float 26 [_zMin]
"vs_2_0
; 83 ALU
def c27, 1.00000000, 2.00000000, 0.00000000, 0
dcl_position0 v0
dcl_normal0 v1
mov r1.w, c27.x
mov r1.xyz, c17
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r1.xyz, r0, c16.w, -v0
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul r1.xyz, r0.y, r1
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r1.w, r0, r1
mul r2.xyz, r0, c27.y
mad r2.xyz, -r2, r1.w, r1
mov oT2.xyz, -r2
mov oT1.xyz, r1
mov r2.x, c25
add r1.y, -c26.x, r2.x
mov r1.x, c19
abs r1.y, r1
add r1.x, c27, -r1
mad r2.w, r1.x, r1.y, c26.x
add r2.x, r2.w, -c24
abs r1.x, r1.w
add r2.z, -r1.x, c27.x
pow r1, r2.z, c22.x
add r1.y, r2.w, c24.x
slt r2.y, v0.z, r2.x
max r1.z, -r2.y, r2.y
slt r1.z, c27, r1
add r1.z, -r1, c27.x
slt r1.w, r1.y, v0.z
mul r1.w, r1.z, r1
mov r2.z, r1.x
max r2.w, -r1, r1
slt r2.w, c27.z, r2
mov r1.x, c20
add r1.x, -c21, r1
mad r1.x, r1, r2.z, c21
add r2.w, -r2, c27.x
mul r2.z, r1, r2.w
mul oT2.w, r1.x, c23.x
mul r1.x, r1.z, r2.z
max r1.z, -r2.y, r2.y
slt r2.y, c27.z, r1.z
max r1.z, -r1.w, r1.w
add r1.w, -r2.y, c27.x
mul r1.w, r1, r0
slt r1.z, c27, r1
add r0.w, -r1.z, c27.x
mad r1.z, r0.w, r1.w, r1
max r1.x, -r1, r1
slt r0.w, c27.z, r1.x
add r1.x, -r2, r1.y
add r1.y, -r0.w, c27.x
mul r1.z, r1.y, r1
abs r1.y, r1.x
add r1.x, v0.z, -r2
mul r2.xyz, v1, c16.w
dp4 r1.w, v0, c7
rcp r1.y, r1.y
abs r1.x, r1
mul r1.x, r1, r1.y
mad oT3.x, r0.w, r1, r1.z
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
dp4 oT6.w, r1, c15
dp4 oT6.z, r1, c14
dp4 oT6.y, r1, c13
dp4 oT6.x, r1, c12
mov oT0.xyz, r0
dp3 oT4.z, r2, c6
dp3 oT4.y, r2, c5
dp3 oT4.x, r2, c4
add oT5.xyz, -r1, c18
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Float 20 [_Lerp]
Float 21 [_Kr]
Float 22 [_KrMin]
Float 23 [_FresnelExpon]
Float 24 [_FresnelPower]
Float 25 [_Penumbra]
Float 26 [_zMax]
Float 27 [_zMin]
"!!ARBvp1.0
# 66 ALU
PARAM c[28] = { { 1, 2, -1 },
		state.matrix.mvp,
		program.local[5..27] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MAD R0.xyz, R0, c[17].w, -vertex.position;
DP3 R1.y, R0, R0;
DP3 R1.x, vertex.normal, vertex.normal;
RSQ R1.w, R1.x;
RSQ R1.y, R1.y;
MUL R1.xyz, R1.y, R0;
MUL R0.xyz, R1.w, vertex.normal;
DP3 R1.w, R0, R1;
MUL R2.xyz, R0, c[0].y;
MAD R2.xyz, -R2, R1.w, R1;
MOV result.texcoord[1].xyz, R1;
ABS R1.w, R1;
ADD R1.w, -R1, c[0].x;
POW R1.x, R1.w, c[23].x;
MOV R1.y, c[27].x;
ADD R1.w, -R1.y, c[26].x;
MOV R1.y, c[0].x;
MOV result.texcoord[2].xyz, -R2;
MOV R1.z, c[22].x;
ADD R1.y, R1, -c[20].x;
ABS R1.w, R1;
MAD R1.w, R1.y, R1, c[27].x;
ADD R1.y, -R1.z, c[21].x;
MAD R1.y, R1, R1.x, c[22].x;
ADD R1.x, R1.w, -c[25];
SLT R1.z, vertex.position, R1.x;
MAD R0.w, -R0, R1.z, R0;
MUL result.texcoord[2].w, R1.y, c[24].x;
ADD R1.y, R1.w, c[25].x;
MAD R1.z, R1, c[0], c[0].x;
SLT R1.w, R1.y, vertex.position.z;
MUL R2.x, R1.z, R1.w;
ADD R1.w, -R0, c[0].x;
MAD R0.w, R1, R2.x, R0;
ADD R1.w, -R1.x, R1.y;
MAD R2.x, R2, -R1.z, R1.z;
MUL R1.y, R1.z, R2.x;
MUL R2.xyz, vertex.normal, c[17].w;
ABS R1.z, R1.w;
ADD R1.x, vertex.position.z, -R1;
DP4 R1.w, vertex.position, c[8];
RCP R1.z, R1.z;
ABS R1.x, R1;
MUL R1.x, R1, R1.z;
ADD R1.x, R1, -R0.w;
MAD result.texcoord[3].x, R1, R1.y, R0.w;
DP4 R1.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
DP4 result.texcoord[6].z, R1, c[15];
DP4 result.texcoord[6].y, R1, c[14];
DP4 result.texcoord[6].x, R1, c[13];
MOV result.texcoord[0].xyz, R0;
DP3 result.texcoord[4].z, R2, c[7];
DP3 result.texcoord[4].y, R2, c[6];
DP3 result.texcoord[4].x, R2, c[5];
ADD result.texcoord[5].xyz, -R1, c[19];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 66 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Float 19 [_Lerp]
Float 20 [_Kr]
Float 21 [_KrMin]
Float 22 [_FresnelExpon]
Float 23 [_FresnelPower]
Float 24 [_Penumbra]
Float 25 [_zMax]
Float 26 [_zMin]
"vs_2_0
; 82 ALU
def c27, 1.00000000, 2.00000000, 0.00000000, 0
dcl_position0 v0
dcl_normal0 v1
mov r1.w, c27.x
mov r1.xyz, c17
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r1.xyz, r0, c16.w, -v0
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul r1.xyz, r0.y, r1
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r1.w, r0, r1
mul r2.xyz, r0, c27.y
mad r2.xyz, -r2, r1.w, r1
mov oT2.xyz, -r2
mov oT1.xyz, r1
mov r2.x, c25
add r1.y, -c26.x, r2.x
mov r1.x, c19
abs r1.y, r1
add r1.x, c27, -r1
mad r2.w, r1.x, r1.y, c26.x
add r2.x, r2.w, -c24
abs r1.x, r1.w
add r2.z, -r1.x, c27.x
pow r1, r2.z, c22.x
add r1.y, r2.w, c24.x
slt r2.y, v0.z, r2.x
max r1.z, -r2.y, r2.y
slt r1.z, c27, r1
add r1.z, -r1, c27.x
slt r1.w, r1.y, v0.z
mul r1.w, r1.z, r1
mov r2.z, r1.x
max r2.w, -r1, r1
slt r2.w, c27.z, r2
mov r1.x, c20
add r1.x, -c21, r1
mad r1.x, r1, r2.z, c21
add r2.w, -r2, c27.x
mul r2.z, r1, r2.w
mul oT2.w, r1.x, c23.x
mul r1.x, r1.z, r2.z
max r1.z, -r2.y, r2.y
slt r2.y, c27.z, r1.z
max r1.z, -r1.w, r1.w
add r1.w, -r2.y, c27.x
mul r1.w, r1, r0
slt r1.z, c27, r1
add r0.w, -r1.z, c27.x
mad r1.z, r0.w, r1.w, r1
max r1.x, -r1, r1
slt r0.w, c27.z, r1.x
add r1.x, -r2, r1.y
add r1.y, -r0.w, c27.x
mul r1.z, r1.y, r1
abs r1.y, r1.x
add r1.x, v0.z, -r2
mul r2.xyz, v1, c16.w
dp4 r1.w, v0, c7
rcp r1.y, r1.y
abs r1.x, r1
mul r1.x, r1, r1.y
mad oT3.x, r0.w, r1, r1.z
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
dp4 oT6.z, r1, c14
dp4 oT6.y, r1, c13
dp4 oT6.x, r1, c12
mov oT0.xyz, r0
dp3 oT4.z, r2, c6
dp3 oT4.y, r2, c5
dp3 oT4.x, r2, c4
add oT5.xyz, -r1, c18
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Float 20 [_Lerp]
Float 21 [_Kr]
Float 22 [_KrMin]
Float 23 [_FresnelExpon]
Float 24 [_FresnelPower]
Float 25 [_Penumbra]
Float 26 [_zMax]
Float 27 [_zMin]
"!!ARBvp1.0
# 65 ALU
PARAM c[28] = { { 1, 2, -1 },
		state.matrix.mvp,
		program.local[5..27] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MAD R0.xyz, R0, c[17].w, -vertex.position;
DP3 R1.y, R0, R0;
DP3 R1.x, vertex.normal, vertex.normal;
RSQ R1.w, R1.x;
RSQ R1.y, R1.y;
MUL R1.xyz, R1.y, R0;
MUL R0.xyz, R1.w, vertex.normal;
DP3 R1.w, R0, R1;
MUL R2.xyz, R0, c[0].y;
MAD R2.xyz, -R2, R1.w, R1;
MOV result.texcoord[1].xyz, R1;
ABS R1.w, R1;
ADD R1.w, -R1, c[0].x;
POW R1.x, R1.w, c[23].x;
MOV R1.y, c[27].x;
ADD R1.w, -R1.y, c[26].x;
MOV R1.y, c[0].x;
MOV R1.z, c[22].x;
ADD R1.y, R1, -c[20].x;
ABS R1.w, R1;
MAD R1.w, R1.y, R1, c[27].x;
ADD R1.y, -R1.z, c[21].x;
MAD R1.y, R1, R1.x, c[22].x;
ADD R1.x, R1.w, -c[25];
SLT R1.z, vertex.position, R1.x;
MAD R0.w, -R0, R1.z, R0;
MUL result.texcoord[2].w, R1.y, c[24].x;
ADD R1.y, R1.w, c[25].x;
MAD R1.z, R1, c[0], c[0].x;
SLT R1.w, R1.y, vertex.position.z;
MOV result.texcoord[2].xyz, -R2;
MUL R2.x, R1.z, R1.w;
ADD R1.w, -R0, c[0].x;
MAD R0.w, R1, R2.x, R0;
ADD R1.w, -R1.x, R1.y;
MAD R2.x, R2, -R1.z, R1.z;
MUL R1.y, R1.z, R2.x;
ABS R1.z, R1.w;
ADD R1.x, vertex.position.z, -R1;
RCP R1.z, R1.z;
ABS R1.x, R1;
MUL R1.x, R1, R1.z;
ADD R1.x, R1, -R0.w;
MAD result.texcoord[3].x, R1, R1.y, R0.w;
DP4 R1.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
DP4 R1.w, vertex.position, c[8];
DP4 result.texcoord[6].y, R1, c[14];
DP4 result.texcoord[6].x, R1, c[13];
MUL R1.xyz, vertex.normal, c[17].w;
MOV result.texcoord[0].xyz, R0;
DP3 result.texcoord[4].z, R1, c[7];
DP3 result.texcoord[4].y, R1, c[6];
DP3 result.texcoord[4].x, R1, c[5];
MOV result.texcoord[5].xyz, c[19];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 65 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Float 19 [_Lerp]
Float 20 [_Kr]
Float 21 [_KrMin]
Float 22 [_FresnelExpon]
Float 23 [_FresnelPower]
Float 24 [_Penumbra]
Float 25 [_zMax]
Float 26 [_zMin]
"vs_2_0
; 81 ALU
def c27, 1.00000000, 2.00000000, 0.00000000, 0
dcl_position0 v0
dcl_normal0 v1
mov r1.w, c27.x
mov r1.xyz, c17
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r1.xyz, r0, c16.w, -v0
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul r1.xyz, r0.y, r1
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r1.w, r0, r1
mul r2.xyz, r0, c27.y
mad r2.xyz, -r2, r1.w, r1
mov oT2.xyz, -r2
mov oT1.xyz, r1
mov r2.x, c25
add r1.y, -c26.x, r2.x
mov r1.x, c19
abs r1.y, r1
add r1.x, c27, -r1
mad r2.w, r1.x, r1.y, c26.x
add r2.x, r2.w, -c24
abs r1.x, r1.w
add r2.z, -r1.x, c27.x
pow r1, r2.z, c22.x
add r1.y, r2.w, c24.x
slt r2.y, v0.z, r2.x
max r1.z, -r2.y, r2.y
slt r1.z, c27, r1
add r1.z, -r1, c27.x
slt r1.w, r1.y, v0.z
mul r1.w, r1.z, r1
mov r2.z, r1.x
max r2.w, -r1, r1
slt r2.w, c27.z, r2
mov r1.x, c20
add r1.x, -c21, r1
mad r1.x, r1, r2.z, c21
add r2.w, -r2, c27.x
mul r2.z, r1, r2.w
mul oT2.w, r1.x, c23.x
mul r1.x, r1.z, r2.z
max r1.z, -r2.y, r2.y
slt r2.y, c27.z, r1.z
max r1.z, -r1.w, r1.w
add r1.w, -r2.y, c27.x
mul r1.w, r1, r0
slt r1.z, c27, r1
add r0.w, -r1.z, c27.x
mad r1.z, r0.w, r1.w, r1
max r1.x, -r1, r1
slt r0.w, c27.z, r1.x
add r1.x, -r2, r1.y
add r1.y, -r0.w, c27.x
mul r1.z, r1.y, r1
abs r1.y, r1.x
add r1.x, v0.z, -r2
rcp r1.y, r1.y
abs r1.x, r1
mul r1.x, r1, r1.y
mad oT3.x, r0.w, r1, r1.z
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
dp4 r1.w, v0, c7
dp4 oT6.y, r1, c13
dp4 oT6.x, r1, c12
mul r1.xyz, v1, c16.w
mov oT0.xyz, r0
dp3 oT4.z, r1, c6
dp3 oT4.y, r1, c5
dp3 oT4.x, r1, c4
mov oT5.xyz, c18
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Color_1]
Vector 3 [_Color_2]
Vector 4 [_Color_A]
Vector 5 [_Color_A1]
Vector 6 [_Color_A2]
Float 7 [_CubeMapLerp]
Float 8 [_Reflection]
SetTexture 0 [_Cube] CUBE
SetTexture 1 [_Cube_01] CUBE
SetTexture 2 [_LightTexture0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 35 ALU, 3 TEX
PARAM c[10] = { program.local[0..8],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R1.xyz, fragment.texcoord[2], texture[0], CUBE;
TEX R0.xyz, fragment.texcoord[2], texture[1], CUBE;
ADD R0.xyz, R0, -R1;
MAD R0.xyz, R0, c[7].x, R1;
DP3 R0.w, fragment.texcoord[6], fragment.texcoord[6];
MOV R3.xyz, c[1];
ADD R3.xyz, -R3, c[4];
MAD R4.xyz, fragment.texcoord[3].x, R3, c[1];
MOV R2.xyz, c[2];
ADD R2.xyz, -R2, c[5];
MAD R2.xyz, fragment.texcoord[3].x, R2, c[2];
ADD R5.xyz, R2, -R4;
MOV R2.xyz, fragment.texcoord[1];
DP3_SAT R1.w, fragment.texcoord[0], R2;
MAD R2.xyz, R1.w, R5, R4;
MOV R3.xyz, c[3];
ADD R3.xyz, -R3, c[6];
MUL R1.w, R1, R1;
MAD R3.xyz, fragment.texcoord[3].x, R3, c[3];
ADD R3.xyz, R3, -R2;
MUL R1.w, R1, R1;
MAD R2.xyz, R1.w, R3, R2;
DP3 R2.w, fragment.texcoord[5], fragment.texcoord[5];
RSQ R1.w, R2.w;
MUL R3.xyz, R1.w, fragment.texcoord[5];
DP3 R1.x, fragment.texcoord[4], R3;
MUL R0.xyz, R0, c[8].x;
MAD R0.xyz, R0, fragment.texcoord[2].w, R2;
MAX R1.x, R1, c[9];
MUL R0.xyz, R0, c[0];
MOV result.color.w, c[9].x;
TEX R0.w, R0.w, texture[2], 2D;
MUL R0.w, R1.x, R0;
MUL R0.w, R0, c[9].y;
MUL result.color.xyz, R0, R0.w;
END
# 35 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Color_1]
Vector 3 [_Color_2]
Vector 4 [_Color_A]
Vector 5 [_Color_A1]
Vector 6 [_Color_A2]
Float 7 [_CubeMapLerp]
Float 8 [_Reflection]
SetTexture 0 [_Cube] CUBE
SetTexture 1 [_Cube_01] CUBE
SetTexture 2 [_LightTexture0] 2D
"ps_2_0
; 34 ALU, 3 TEX
dcl_cube s0
dcl_cube s1
dcl_2d s2
def c9, 0.00000000, 2.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2
dcl t3.x
dcl t4.xyz
dcl t5.xyz
dcl t6.xyz
texld r1, t2, s0
texld r2, t2, s1
dp3 r0.x, t6, t6
mov r0.xy, r0.x
mov r3.xyz, c4
add r3.xyz, -c1, r3
mad r4.xyz, t3.x, r3, c1
mov r3.xyz, c6
add r3.xyz, -c3, r3
add r2.xyz, r2, -r1
mad r1.xyz, r2, c7.x, r1
mad r3.xyz, t3.x, r3, c3
mul r1.xyz, r1, c8.x
mov_pp r0.w, c9.x
texld r6, r0, s2
mov r0.xyz, c5
add r0.xyz, -c2, r0
mad r0.xyz, t3.x, r0, c2
add r5.xyz, r0, -r4
mov r0.xyz, t1
dp3_sat r0.x, t0, r0
mad r4.xyz, r0.x, r5, r4
mul r0.x, r0, r0
mul r0.x, r0, r0
add r3.xyz, r3, -r4
mad r3.xyz, r0.x, r3, r4
dp3_pp r0.x, t5, t5
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, t5
dp3_pp r0.x, t4, r0
mad r1.xyz, r1, t2.w, r3
max_pp r0.x, r0, c9
mul_pp r0.x, r0, r6
mul_pp r0.x, r0, c9.y
mul r1.xyz, r1, c0
mul r0.xyz, r1, r0.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Color_1]
Vector 3 [_Color_2]
Vector 4 [_Color_A]
Vector 5 [_Color_A1]
Vector 6 [_Color_A2]
Float 7 [_CubeMapLerp]
Float 8 [_Reflection]
SetTexture 0 [_Cube] CUBE
SetTexture 1 [_Cube_01] CUBE
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 30 ALU, 2 TEX
PARAM c[10] = { program.local[0..8],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R1.xyz, fragment.texcoord[2], texture[0], CUBE;
TEX R0.xyz, fragment.texcoord[2], texture[1], CUBE;
MOV R3.xyz, c[1];
ADD R3.xyz, -R3, c[4];
MAD R4.xyz, fragment.texcoord[3].x, R3, c[1];
MOV R2.xyz, c[2];
ADD R2.xyz, -R2, c[5];
MAD R2.xyz, fragment.texcoord[3].x, R2, c[2];
ADD R5.xyz, R2, -R4;
MOV R2.xyz, fragment.texcoord[1];
DP3_SAT R0.w, fragment.texcoord[0], R2;
MAD R2.xyz, R0.w, R5, R4;
MOV R3.xyz, c[3];
ADD R3.xyz, -R3, c[6];
MUL R0.w, R0, R0;
MAD R3.xyz, fragment.texcoord[3].x, R3, c[3];
ADD R0.xyz, R0, -R1;
MAD R0.xyz, R0, c[7].x, R1;
ADD R3.xyz, R3, -R2;
MUL R0.w, R0, R0;
MAD R2.xyz, R0.w, R3, R2;
MOV R3.xyz, fragment.texcoord[5];
DP3 R0.w, fragment.texcoord[4], R3;
MUL R0.xyz, R0, c[8].x;
MAX R0.w, R0, c[9].x;
MAD R0.xyz, R0, fragment.texcoord[2].w, R2;
MUL R0.w, R0, c[9].y;
MUL R0.xyz, R0, c[0];
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[9].x;
END
# 30 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Color_1]
Vector 3 [_Color_2]
Vector 4 [_Color_A]
Vector 5 [_Color_A1]
Vector 6 [_Color_A2]
Float 7 [_CubeMapLerp]
Float 8 [_Reflection]
SetTexture 0 [_Cube] CUBE
SetTexture 1 [_Cube_01] CUBE
"ps_2_0
; 29 ALU, 2 TEX
dcl_cube s0
dcl_cube s1
def c9, 0.00000000, 2.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2
dcl t3.x
dcl t4.xyz
dcl t5.xyz
texld r2, t2, s1
texld r1, t2, s0
mov r3.xyz, c4
add r3.xyz, -c1, r3
mad r4.xyz, t3.x, r3, c1
mov r0.xyz, c5
add r0.xyz, -c2, r0
mad r0.xyz, t3.x, r0, c2
add r5.xyz, r0, -r4
mov r0.xyz, t1
dp3_sat r0.x, t0, r0
mad r4.xyz, r0.x, r5, r4
mov r3.xyz, c6
add r3.xyz, -c3, r3
mul r0.x, r0, r0
mad r3.xyz, t3.x, r3, c3
add r2.xyz, r2, -r1
mad r2.xyz, r2, c7.x, r1
add r3.xyz, r3, -r4
mul r0.x, r0, r0
mad r0.xyz, r0.x, r3, r4
mov_pp r3.xyz, t5
dp3_pp r1.x, t4, r3
mul r2.xyz, r2, c8.x
mad r2.xyz, r2, t2.w, r0
max_pp r1.x, r1, c9
mul_pp r0.x, r1, c9.y
mul r1.xyz, r2, c0
mul r0.xyz, r1, r0.x
mov_pp r0.w, c9.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Color_1]
Vector 3 [_Color_2]
Vector 4 [_Color_A]
Vector 5 [_Color_A1]
Vector 6 [_Color_A2]
Float 7 [_CubeMapLerp]
Float 8 [_Reflection]
SetTexture 0 [_Cube] CUBE
SetTexture 1 [_Cube_01] CUBE
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 41 ALU, 4 TEX
PARAM c[10] = { program.local[0..8],
		{ 0, 0.5, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R1.xyz, fragment.texcoord[2], texture[0], CUBE;
RCP R0.x, fragment.texcoord[6].w;
MAD R2.xy, fragment.texcoord[6], R0.x, c[9].y;
DP3 R1.w, fragment.texcoord[6], fragment.texcoord[6];
MOV R3.xyz, c[1];
ADD R3.xyz, -R3, c[4];
MAD R4.xyz, fragment.texcoord[3].x, R3, c[1];
MOV R3.xyz, c[3];
ADD R3.xyz, -R3, c[6];
MAD R3.xyz, fragment.texcoord[3].x, R3, c[3];
MOV result.color.w, c[9].x;
TEX R0.w, R2, texture[2], 2D;
TEX R0.xyz, fragment.texcoord[2], texture[1], CUBE;
TEX R1.w, R1.w, texture[3], 2D;
ADD R0.xyz, R0, -R1;
MAD R0.xyz, R0, c[7].x, R1;
MOV R2.xyz, c[2];
ADD R2.xyz, -R2, c[5];
MAD R2.xyz, fragment.texcoord[3].x, R2, c[2];
ADD R5.xyz, R2, -R4;
MOV R2.xyz, fragment.texcoord[1];
DP3_SAT R2.w, fragment.texcoord[0], R2;
MAD R2.xyz, R2.w, R5, R4;
MUL R2.w, R2, R2;
MUL R2.w, R2, R2;
ADD R3.xyz, R3, -R2;
MAD R2.xyz, R2.w, R3, R2;
DP3 R2.w, fragment.texcoord[5], fragment.texcoord[5];
RSQ R2.w, R2.w;
MUL R1.xyz, R2.w, fragment.texcoord[5];
DP3 R1.x, fragment.texcoord[4], R1;
SLT R1.y, c[9].x, fragment.texcoord[6].z;
MUL R0.w, R1.y, R0;
MUL R1.y, R0.w, R1.w;
MUL R0.xyz, R0, c[8].x;
MAX R0.w, R1.x, c[9].x;
MUL R0.w, R0, R1.y;
MAD R0.xyz, R0, fragment.texcoord[2].w, R2;
MUL R0.w, R0, c[9].z;
MUL R0.xyz, R0, c[0];
MUL result.color.xyz, R0, R0.w;
END
# 41 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Color_1]
Vector 3 [_Color_2]
Vector 4 [_Color_A]
Vector 5 [_Color_A1]
Vector 6 [_Color_A2]
Float 7 [_CubeMapLerp]
Float 8 [_Reflection]
SetTexture 0 [_Cube] CUBE
SetTexture 1 [_Cube_01] CUBE
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
"ps_2_0
; 39 ALU, 4 TEX
dcl_cube s0
dcl_cube s1
dcl_2d s2
dcl_2d s3
def c9, 0.00000000, 1.00000000, 0.50000000, 2.00000000
dcl t0.xyz
dcl t1.xyz
dcl t2
dcl t3.x
dcl t4.xyz
dcl t5.xyz
dcl t6
texld r2, t2, s1
dp3 r1.x, t6, t6
mov r1.xy, r1.x
rcp r0.x, t6.w
mad r0.xy, t6, r0.x, c9.z
texld r5, r1, s3
texld r1, t2, s0
texld r0, r0, s2
add r0.xyz, r2, -r1
mad r1.xyz, r0, c7.x, r1
mov r2.xyz, c4
add r2.xyz, -c1, r2
mad r3.xyz, t3.x, r2, c1
mov r0.xyz, c5
add r0.xyz, -c2, r0
mad r0.xyz, t3.x, r0, c2
add r4.xyz, r0, -r3
mov r0.xyz, t1
dp3_sat r0.x, t0, r0
mad r3.xyz, r0.x, r4, r3
mov r2.xyz, c6
add r2.xyz, -c3, r2
mul r0.x, r0, r0
mad r2.xyz, t3.x, r2, c3
add r2.xyz, r2, -r3
mul r0.x, r0, r0
mad r2.xyz, r0.x, r2, r3
dp3_pp r0.x, t5, t5
mul r3.xyz, r1, c8.x
rsq_pp r1.x, r0.x
mul_pp r1.xyz, r1.x, t5
dp3_pp r1.x, t4, r1
cmp r0.x, -t6.z, c9, c9.y
mul r0.x, r0, r0.w
max_pp r1.x, r1, c9
mul r0.x, r0, r5
mul_pp r0.x, r1, r0
mad r1.xyz, r3, t2.w, r2
mul_pp r0.x, r0, c9.w
mul r1.xyz, r1, c0
mul r0.xyz, r1, r0.x
mov_pp r0.w, c9.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Color_1]
Vector 3 [_Color_2]
Vector 4 [_Color_A]
Vector 5 [_Color_A1]
Vector 6 [_Color_A2]
Float 7 [_CubeMapLerp]
Float 8 [_Reflection]
SetTexture 0 [_Cube] CUBE
SetTexture 1 [_Cube_01] CUBE
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_LightTexture0] CUBE
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 37 ALU, 4 TEX
PARAM c[10] = { program.local[0..8],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R1.xyz, fragment.texcoord[2], texture[0], CUBE;
TEX R0.xyz, fragment.texcoord[2], texture[1], CUBE;
TEX R1.w, fragment.texcoord[6], texture[3], CUBE;
ADD R0.xyz, R0, -R1;
MAD R0.xyz, R0, c[7].x, R1;
DP3 R0.w, fragment.texcoord[6], fragment.texcoord[6];
MOV R3.xyz, c[1];
ADD R3.xyz, -R3, c[4];
MAD R4.xyz, fragment.texcoord[3].x, R3, c[1];
MOV R2.xyz, c[2];
ADD R2.xyz, -R2, c[5];
MAD R2.xyz, fragment.texcoord[3].x, R2, c[2];
ADD R5.xyz, R2, -R4;
MOV R2.xyz, fragment.texcoord[1];
DP3_SAT R2.w, fragment.texcoord[0], R2;
MAD R2.xyz, R2.w, R5, R4;
MOV R3.xyz, c[3];
ADD R3.xyz, -R3, c[6];
MUL R2.w, R2, R2;
MAD R3.xyz, fragment.texcoord[3].x, R3, c[3];
MUL R2.w, R2, R2;
ADD R3.xyz, R3, -R2;
MAD R2.xyz, R2.w, R3, R2;
DP3 R2.w, fragment.texcoord[5], fragment.texcoord[5];
RSQ R2.w, R2.w;
MUL R1.xyz, R2.w, fragment.texcoord[5];
MUL R0.xyz, R0, c[8].x;
MAD R0.xyz, R0, fragment.texcoord[2].w, R2;
DP3 R1.x, fragment.texcoord[4], R1;
MUL R0.xyz, R0, c[0];
MOV result.color.w, c[9].x;
TEX R0.w, R0.w, texture[2], 2D;
MUL R1.y, R0.w, R1.w;
MAX R0.w, R1.x, c[9].x;
MUL R0.w, R0, R1.y;
MUL R0.w, R0, c[9].y;
MUL result.color.xyz, R0, R0.w;
END
# 37 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Color_1]
Vector 3 [_Color_2]
Vector 4 [_Color_A]
Vector 5 [_Color_A1]
Vector 6 [_Color_A2]
Float 7 [_CubeMapLerp]
Float 8 [_Reflection]
SetTexture 0 [_Cube] CUBE
SetTexture 1 [_Cube_01] CUBE
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_LightTexture0] CUBE
"ps_2_0
; 35 ALU, 4 TEX
dcl_cube s0
dcl_cube s1
dcl_2d s2
dcl_cube s3
def c9, 0.00000000, 2.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2
dcl t3.x
dcl t4.xyz
dcl t5.xyz
dcl t6.xyz
texld r2, t2, s1
dp3 r0.x, t6, t6
mov r1.xy, r0.x
mov r3.xyz, c4
add r3.xyz, -c1, r3
mad r4.xyz, t3.x, r3, c1
mov r3.xyz, c6
add r3.xyz, -c3, r3
mad r3.xyz, t3.x, r3, c3
texld r6, r1, s2
texld r0, t6, s3
texld r1, t2, s0
add r2.xyz, r2, -r1
mad r1.xyz, r2, c7.x, r1
mov r0.xyz, c5
add r0.xyz, -c2, r0
mad r0.xyz, t3.x, r0, c2
add r5.xyz, r0, -r4
mov r0.xyz, t1
dp3_sat r0.x, t0, r0
mad r4.xyz, r0.x, r5, r4
mul r0.x, r0, r0
mul r0.x, r0, r0
add r3.xyz, r3, -r4
mad r3.xyz, r0.x, r3, r4
dp3_pp r0.x, t5, t5
mul r1.xyz, r1, c8.x
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, t5
dp3_pp r0.x, t4, r0
mul r2.x, r6, r0.w
max_pp r0.x, r0, c9
mul_pp r0.x, r0, r2
mad r1.xyz, r1, t2.w, r3
mul_pp r0.x, r0, c9.y
mul r1.xyz, r1, c0
mul r0.xyz, r1, r0.x
mov_pp r0.w, c9.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Color_1]
Vector 3 [_Color_2]
Vector 4 [_Color_A]
Vector 5 [_Color_A1]
Vector 6 [_Color_A2]
Float 7 [_CubeMapLerp]
Float 8 [_Reflection]
SetTexture 0 [_Cube] CUBE
SetTexture 1 [_Cube_01] CUBE
SetTexture 2 [_LightTexture0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 32 ALU, 3 TEX
PARAM c[10] = { program.local[0..8],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R1.xyz, fragment.texcoord[2], texture[0], CUBE;
TEX R0.xyz, fragment.texcoord[2], texture[1], CUBE;
TEX R0.w, fragment.texcoord[6], texture[2], 2D;
ADD R0.xyz, R0, -R1;
MAD R0.xyz, R0, c[7].x, R1;
MOV R3.xyz, c[1];
ADD R3.xyz, -R3, c[4];
MAD R4.xyz, fragment.texcoord[3].x, R3, c[1];
MOV R2.xyz, c[2];
ADD R2.xyz, -R2, c[5];
MAD R2.xyz, fragment.texcoord[3].x, R2, c[2];
ADD R5.xyz, R2, -R4;
MOV R2.xyz, fragment.texcoord[1];
DP3_SAT R1.w, fragment.texcoord[0], R2;
MAD R2.xyz, R1.w, R5, R4;
MOV R3.xyz, c[3];
ADD R3.xyz, -R3, c[6];
MUL R1.w, R1, R1;
MAD R3.xyz, fragment.texcoord[3].x, R3, c[3];
ADD R3.xyz, R3, -R2;
MUL R1.w, R1, R1;
MAD R2.xyz, R1.w, R3, R2;
MOV R3.xyz, fragment.texcoord[5];
DP3 R1.x, fragment.texcoord[4], R3;
MUL R0.xyz, R0, c[8].x;
MAX R1.x, R1, c[9];
MUL R0.w, R1.x, R0;
MAD R0.xyz, R0, fragment.texcoord[2].w, R2;
MUL R0.w, R0, c[9].y;
MUL R0.xyz, R0, c[0];
MUL result.color.xyz, R0, R0.w;
MOV result.color.w, c[9].x;
END
# 32 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
Vector 1 [_Color]
Vector 2 [_Color_1]
Vector 3 [_Color_2]
Vector 4 [_Color_A]
Vector 5 [_Color_A1]
Vector 6 [_Color_A2]
Float 7 [_CubeMapLerp]
Float 8 [_Reflection]
SetTexture 0 [_Cube] CUBE
SetTexture 1 [_Cube_01] CUBE
SetTexture 2 [_LightTexture0] 2D
"ps_2_0
; 30 ALU, 3 TEX
dcl_cube s0
dcl_cube s1
dcl_2d s2
def c9, 0.00000000, 2.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2
dcl t3.x
dcl t4.xyz
dcl t5.xyz
dcl t6.xy
texld r0, t6, s2
texld r1, t2, s0
texld r2, t2, s1
mov r3.xyz, c4
add r3.xyz, -c1, r3
mad r4.xyz, t3.x, r3, c1
mov r0.xyz, c5
add r0.xyz, -c2, r0
mad r0.xyz, t3.x, r0, c2
add r5.xyz, r0, -r4
mov r0.xyz, t1
dp3_sat r0.x, t0, r0
mad r4.xyz, r0.x, r5, r4
mov r3.xyz, c6
add r3.xyz, -c3, r3
mul r0.x, r0, r0
mad r3.xyz, t3.x, r3, c3
add r2.xyz, r2, -r1
mad r1.xyz, r2, c7.x, r1
mul r0.x, r0, r0
add r3.xyz, r3, -r4
mad r3.xyz, r0.x, r3, r4
mov_pp r0.xyz, t5
dp3_pp r0.x, t4, r0
mul r1.xyz, r1, c8.x
max_pp r0.x, r0, c9
mul_pp r0.x, r0, r0.w
mad r1.xyz, r1, t2.w, r3
mul_pp r0.x, r0, c9.y
mul r1.xyz, r1, c0
mul r0.xyz, r1, r0.x
mov_pp r0.w, c9.x
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "RenderType"="Opaque" }
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Float 15 [_Lerp]
Float 16 [_Kr]
Float 17 [_KrMin]
Float 18 [_FresnelExpon]
Float 19 [_FresnelPower]
Float 20 [_Penumbra]
Float 21 [_zMax]
Float 22 [_zMin]
"!!ARBvp1.0
# 58 ALU
PARAM c[23] = { { 1, 2, -1 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R1.xyz, c[14];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MAD R0.xyz, R0, c[13].w, -vertex.position;
DP3 R1.y, R0, R0;
DP3 R1.x, vertex.normal, vertex.normal;
RSQ R1.w, R1.x;
RSQ R1.y, R1.y;
MUL R1.xyz, R1.y, R0;
MUL R0.xyz, R1.w, vertex.normal;
DP3 R1.w, R0, R1;
MUL R2.xyz, R0, c[0].y;
MAD R2.xyz, -R2, R1.w, R1;
MOV result.texcoord[1].xyz, R1;
ABS R1.w, R1;
ADD R1.w, -R1, c[0].x;
POW R1.x, R1.w, c[18].x;
MOV R1.y, c[22].x;
ADD R1.w, -R1.y, c[21].x;
MOV R1.y, c[0].x;
MOV R1.z, c[17].x;
ADD R1.y, R1, -c[15].x;
ABS R1.w, R1;
MAD R1.w, R1.y, R1, c[22].x;
ADD R1.y, -R1.z, c[16].x;
MAD R1.y, R1, R1.x, c[17].x;
ADD R1.x, R1.w, -c[20];
SLT R1.z, vertex.position, R1.x;
MAD R0.w, -R0, R1.z, R0;
MUL result.texcoord[2].w, R1.y, c[19].x;
ADD R1.y, R1.w, c[20].x;
MAD R1.z, R1, c[0], c[0].x;
SLT R1.w, R1.y, vertex.position.z;
MOV result.texcoord[2].xyz, -R2;
MUL R2.x, R1.z, R1.w;
ADD R1.w, -R0, c[0].x;
MAD R0.w, R1, R2.x, R0;
ADD R1.w, -R1.x, R1.y;
MAD R2.x, R2, -R1.z, R1.z;
MUL R1.y, R1.z, R2.x;
ABS R1.z, R1.w;
ADD R1.x, vertex.position.z, -R1;
RCP R1.z, R1.z;
ABS R1.x, R1;
MUL R1.x, R1, R1.z;
ADD R1.x, R1, -R0.w;
MAD result.texcoord[3].x, R1, R1.y, R0.w;
MUL R1.xyz, vertex.normal, c[13].w;
MOV result.texcoord[0].xyz, R0;
DP3 result.texcoord[4].z, R1, c[7];
DP3 result.texcoord[4].y, R1, c[6];
DP3 result.texcoord[4].x, R1, c[5];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 58 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Float 14 [_Lerp]
Float 15 [_Kr]
Float 16 [_KrMin]
Float 17 [_FresnelExpon]
Float 18 [_FresnelPower]
Float 19 [_Penumbra]
Float 20 [_zMax]
Float 21 [_zMin]
"vs_2_0
; 74 ALU
def c22, 1.00000000, 2.00000000, 0.00000000, 0
dcl_position0 v0
dcl_normal0 v1
mov r1.w, c22.x
mov r1.xyz, c13
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r1.xyz, r0, c12.w, -v0
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul r1.xyz, r0.y, r1
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r1.w, r0, r1
mul r2.xyz, r0, c22.y
mad r2.xyz, -r2, r1.w, r1
mov oT2.xyz, -r2
mov oT1.xyz, r1
mov r2.x, c20
add r1.y, -c21.x, r2.x
mov r1.x, c14
abs r1.y, r1
add r1.x, c22, -r1
mad r2.w, r1.x, r1.y, c21.x
add r2.x, r2.w, -c19
abs r1.x, r1.w
add r2.z, -r1.x, c22.x
pow r1, r2.z, c17.x
add r1.y, r2.w, c19.x
slt r2.y, v0.z, r2.x
max r1.z, -r2.y, r2.y
slt r1.z, c22, r1
add r1.z, -r1, c22.x
slt r1.w, r1.y, v0.z
mul r1.w, r1.z, r1
mov r2.z, r1.x
max r2.w, -r1, r1
slt r2.w, c22.z, r2
mov r1.x, c15
add r1.x, -c16, r1
mad r1.x, r1, r2.z, c16
add r2.w, -r2, c22.x
mul r2.z, r1, r2.w
mul oT2.w, r1.x, c18.x
mul r1.x, r1.z, r2.z
max r1.z, -r2.y, r2.y
slt r2.y, c22.z, r1.z
max r1.z, -r1.w, r1.w
add r1.w, -r2.y, c22.x
max r1.x, -r1, r1
slt r1.z, c22, r1
mul r1.w, r1, r0
add r0.w, -r1.z, c22.x
mad r1.z, r0.w, r1.w, r1
slt r0.w, c22.z, r1.x
add r1.x, -r2, r1.y
add r1.y, -r0.w, c22.x
mul r1.z, r1.y, r1
abs r1.y, r1.x
add r1.x, v0.z, -r2
rcp r1.y, r1.y
abs r1.x, r1
mul r1.x, r1, r1.y
mad oT3.x, r0.w, r1, r1.z
mul r1.xyz, v1, c12.w
mov oT0.xyz, r0
dp3 oT4.z, r1, c6
dp3 oT4.y, r1, c5
dp3 oT4.x, r1, c4
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 2 ALU, 0 TEX
PARAM c[1] = { { 0, 0.5 } };
MAD result.color.xyz, fragment.texcoord[4], c[0].y, c[0].y;
MOV result.color.w, c[0].x;
END
# 2 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
"ps_2_0
; 3 ALU
def c0, 0.50000000, 0.00000000, 0, 0
dcl t4.xyz
mad_pp r0.xyz, t4, c0.x, c0.x
mov_pp r0.w, c0.y
mov_pp oC0, r0
"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "RenderType"="Opaque" }
  ZWrite Off
Program "vp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 5 [_World2Object]
Vector 9 [_ProjectionParams]
Vector 10 [unity_Scale]
Vector 11 [_WorldSpaceCameraPos]
Float 12 [_Lerp]
Float 13 [_Kr]
Float 14 [_KrMin]
Float 15 [_FresnelExpon]
Float 16 [_FresnelPower]
Float 17 [_Penumbra]
Float 18 [_zMax]
Float 19 [_zMin]
"!!ARBvp1.0
# 59 ALU
PARAM c[20] = { { 1, 2, -1, 0.5 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R2.w, c[0].x;
MOV R1.xyz, c[11];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[7];
DP4 R0.x, R1, c[5];
DP4 R0.y, R1, c[6];
MAD R0.xyz, R0, c[10].w, -vertex.position;
DP3 R1.y, R0, R0;
DP3 R1.x, vertex.normal, vertex.normal;
RSQ R1.w, R1.x;
RSQ R1.y, R1.y;
MUL R1.xyz, R1.y, R0;
MUL R0.xyz, R1.w, vertex.normal;
DP3 R1.w, R0, R1;
MUL R2.xyz, R0, c[0].y;
MAD R2.xyz, -R2, R1.w, R1;
MOV result.texcoord[1].xyz, R1;
MOV R1.z, c[19].x;
ADD R1.z, -R1, c[18].x;
ABS R1.w, R1;
MOV result.texcoord[2].xyz, -R2;
ADD R2.x, -R1.w, c[0];
MOV R1.w, c[14].x;
POW R2.x, R2.x, c[15].x;
ADD R1.w, -R1, c[13].x;
MAD R1.w, R1, R2.x, c[14].x;
MUL result.texcoord[2].w, R1, c[16].x;
DP4 R1.w, vertex.position, c[4];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MUL R2.xyz, R1.xyww, c[0].w;
MUL R2.y, R2, c[9].x;
ADD result.texcoord[4].xy, R2, R2.z;
ADD R2.w, R2, -c[12].x;
ABS R1.z, R1;
MAD R1.z, R2.w, R1, c[19].x;
ADD R2.w, R1.z, -c[17].x;
ADD R1.z, R1, c[17].x;
SLT R2.x, vertex.position.z, R2.w;
MAD R0.w, -R0, R2.x, R0;
MAD R2.x, R2, c[0].z, c[0];
SLT R2.y, R1.z, vertex.position.z;
MUL R2.y, R2.x, R2;
ADD R2.z, -R0.w, c[0].x;
MAD R0.w, R2.z, R2.y, R0;
ADD R2.z, -R2.w, R1;
MAD R1.z, R2.y, -R2.x, R2.x;
MUL R2.x, R2, R1.z;
DP4 R1.z, vertex.position, c[3];
ABS R2.z, R2;
ADD R2.y, vertex.position.z, -R2.w;
RCP R2.z, R2.z;
ABS R2.y, R2;
MUL R2.y, R2, R2.z;
ADD R2.y, R2, -R0.w;
MAD result.texcoord[3].x, R2.y, R2, R0.w;
MOV result.position, R1;
MOV result.texcoord[4].zw, R1;
MOV result.texcoord[0].xyz, R0;
END
# 59 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_Scale]
Vector 11 [_WorldSpaceCameraPos]
Float 12 [_Lerp]
Float 13 [_Kr]
Float 14 [_KrMin]
Float 15 [_FresnelExpon]
Float 16 [_FresnelPower]
Float 17 [_Penumbra]
Float 18 [_zMax]
Float 19 [_zMin]
"vs_2_0
; 75 ALU
def c20, 1.00000000, 2.00000000, 0.00000000, 0.50000000
dcl_position0 v0
dcl_normal0 v1
mov r1.w, c20.x
mov r1.xyz, c11
dp4 r0.z, r1, c6
dp4 r0.x, r1, c4
dp4 r0.y, r1, c5
mad r1.xyz, r0, c10.w, -v0
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul r1.xyz, r0.y, r1
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r1.w, r0, r1
mul r2.xyz, r0, c20.y
mad r2.xyz, -r2, r1.w, r1
abs r1.w, r1
mov oT2.xyz, -r2
add r2.x, -r1.w, c20
mov oT1.xyz, r1
pow r1, r2.x, c15.x
mov r1.y, c18.x
add r1.z, -c19.x, r1.y
mov r1.y, c12.x
add r1.y, c20.x, -r1
abs r1.z, r1
mad r1.z, r1.y, r1, c19.x
add r3.y, r1.z, -c17.x
mov r1.y, r1.x
add r2.w, r1.z, c17.x
mov r1.x, c13
add r1.x, -c14, r1
mad r1.x, r1, r1.y, c14
slt r3.x, v0.z, r3.y
max r1.y, -r3.x, r3.x
slt r1.y, c20.z, r1
add r1.z, -r1.y, c20.x
slt r1.w, r2, v0.z
mul r3.z, r1, r1.w
mul oT2.w, r1.x, c16.x
max r3.w, -r3.z, r3.z
slt r3.w, c20.z, r3
add r3.w, -r3, c20.x
mul r3.w, r1.z, r3
mul r1.z, r1, r3.w
dp4 r1.w, v0, c3
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r2.xyz, r1.xyww, c20.w
mul r2.y, r2, c8.x
mad oT4.xy, r2.z, c9.zwzw, r2
max r2.x, -r3, r3
slt r2.y, c20.z, r2.x
max r2.x, -r3.z, r3.z
add r2.y, -r2, c20.x
slt r2.x, c20.z, r2
mul r2.y, r2, r0.w
add r0.w, -r2.x, c20.x
mad r2.y, r0.w, r2, r2.x
max r1.z, -r1, r1
slt r0.w, c20.z, r1.z
add r2.x, -r0.w, c20
add r1.z, -r3.y, r2.w
mul r2.y, r2.x, r2
abs r2.x, r1.z
add r1.z, v0, -r3.y
abs r1.z, r1
rcp r2.x, r2.x
mul r2.x, r1.z, r2
dp4 r1.z, v0, c2
mad oT3.x, r0.w, r2, r2.y
mov oPos, r1
mov oT4.zw, r1
mov oT0.xyz, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Float 16 [_Lerp]
Float 17 [_Kr]
Float 18 [_KrMin]
Float 19 [_FresnelExpon]
Float 20 [_FresnelPower]
Float 21 [_Penumbra]
Float 22 [_zMax]
Float 23 [_zMin]
Vector 24 [unity_LightmapST]
Vector 25 [unity_LightmapFade]
"!!ARBvp1.0
# 62 ALU
PARAM c[26] = { { 1, 2, -1, 0.5 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..25] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R2.w, c[0].x;
MOV R1.xyz, c[15];
MOV R1.w, c[0].x;
DP4 R0.z, R1, c[11];
DP4 R0.x, R1, c[9];
DP4 R0.y, R1, c[10];
MAD R0.xyz, R0, c[14].w, -vertex.position;
DP3 R1.y, R0, R0;
DP3 R1.x, vertex.normal, vertex.normal;
RSQ R1.w, R1.x;
RSQ R1.y, R1.y;
MUL R1.xyz, R1.y, R0;
MUL R0.xyz, R1.w, vertex.normal;
DP3 R1.w, R0, R1;
MUL R2.xyz, R0, c[0].y;
MAD R2.xyz, -R2, R1.w, R1;
MOV result.texcoord[1].xyz, R1;
MOV R1.z, c[23].x;
ADD R1.z, -R1, c[22].x;
MOV result.texcoord[0].xyz, R0;
DP4 R0.x, vertex.position, c[3];
ABS R1.w, R1;
MOV result.texcoord[2].xyz, -R2;
ADD R2.x, -R1.w, c[0];
MOV R1.w, c[18].x;
POW R2.x, R2.x, c[19].x;
ADD R1.w, -R1, c[17].x;
MAD R1.w, R1, R2.x, c[18].x;
MUL result.texcoord[2].w, R1, c[20].x;
DP4 R1.w, vertex.position, c[8];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
MUL R2.xyz, R1.xyww, c[0].w;
MUL R2.y, R2, c[13].x;
ADD result.texcoord[4].xy, R2, R2.z;
ADD R2.w, R2, -c[16].x;
ABS R1.z, R1;
MAD R1.z, R2.w, R1, c[23].x;
ADD R2.w, R1.z, -c[21].x;
ADD R1.z, R1, c[21].x;
SLT R2.x, vertex.position.z, R2.w;
MAD R0.w, -R0, R2.x, R0;
MAD R2.x, R2, c[0].z, c[0];
SLT R2.y, R1.z, vertex.position.z;
MUL R2.y, R2.x, R2;
ADD R2.z, -R0.w, c[0].x;
MAD R0.w, R2.z, R2.y, R0;
ADD R2.z, -R2.w, R1;
MAD R1.z, R2.y, -R2.x, R2.x;
MUL R2.x, R2, R1.z;
DP4 R1.z, vertex.position, c[7];
ABS R2.z, R2;
ADD R2.y, vertex.position.z, -R2.w;
RCP R2.z, R2.z;
ABS R2.y, R2;
MUL R2.y, R2, R2.z;
ADD R2.y, R2, -R0.w;
MAD result.texcoord[3].x, R2.y, R2, R0.w;
MOV result.position, R1;
MOV result.texcoord[4].zw, R1;
MAD result.texcoord[5].xy, vertex.texcoord[1], c[24], c[24].zwzw;
MAD result.texcoord[5].z, -R0.x, c[25], c[25].w;
END
# 62 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Matrix 8 [_World2Object]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Float 16 [_Lerp]
Float 17 [_Kr]
Float 18 [_KrMin]
Float 19 [_FresnelExpon]
Float 20 [_FresnelPower]
Float 21 [_Penumbra]
Float 22 [_zMax]
Float 23 [_zMin]
Vector 24 [unity_LightmapST]
Vector 25 [unity_LightmapFade]
"vs_2_0
; 78 ALU
def c26, 1.00000000, 2.00000000, 0.00000000, 0.50000000
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord1 v2
mov r1.w, c26.x
mov r1.xyz, c15
dp4 r0.z, r1, c10
dp4 r0.x, r1, c8
dp4 r0.y, r1, c9
mad r1.xyz, r0, c14.w, -v0
dp3 r0.y, r1, r1
rsq r0.y, r0.y
mul r1.xyz, r0.y, r1
dp3 r0.x, v1, v1
rsq r0.x, r0.x
mul r0.xyz, r0.x, v1
dp3 r1.w, r0, r1
mul r2.xyz, r0, c26.y
mad r2.xyz, -r2, r1.w, r1
mov oT0.xyz, r0
dp4 r0.x, v0, c2
abs r1.w, r1
mov oT2.xyz, -r2
add r2.x, -r1.w, c26
mov oT1.xyz, r1
pow r1, r2.x, c19.x
mov r1.y, c22.x
add r1.z, -c23.x, r1.y
mov r1.y, c16.x
add r1.y, c26.x, -r1
abs r1.z, r1
mad r1.z, r1.y, r1, c23.x
add r3.y, r1.z, -c21.x
mov r1.y, r1.x
add r2.w, r1.z, c21.x
mov r1.x, c17
add r1.x, -c18, r1
mad r1.x, r1, r1.y, c18
slt r3.x, v0.z, r3.y
max r1.y, -r3.x, r3.x
slt r1.y, c26.z, r1
add r1.z, -r1.y, c26.x
slt r1.w, r2, v0.z
mul r3.z, r1, r1.w
mul oT2.w, r1.x, c20.x
max r3.w, -r3.z, r3.z
slt r3.w, c26.z, r3
add r3.w, -r3, c26.x
mul r3.w, r1.z, r3
mul r1.z, r1, r3.w
dp4 r1.w, v0, c7
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
mul r2.xyz, r1.xyww, c26.w
mul r2.y, r2, c12.x
mad oT4.xy, r2.z, c13.zwzw, r2
max r2.x, -r3, r3
slt r2.y, c26.z, r2.x
max r2.x, -r3.z, r3.z
add r2.y, -r2, c26.x
slt r2.x, c26.z, r2
mul r2.y, r2, r0.w
add r0.w, -r2.x, c26.x
mad r2.y, r0.w, r2, r2.x
max r1.z, -r1, r1
slt r0.w, c26.z, r1.z
add r2.x, -r0.w, c26
add r1.z, -r3.y, r2.w
mul r2.y, r2.x, r2
abs r2.x, r1.z
add r1.z, v0, -r3.y
abs r1.z, r1
rcp r2.x, r2.x
mul r2.x, r1.z, r2
dp4 r1.z, v0, c6
mad oT3.x, r0.w, r2, r2.y
mov oPos, r1
mov oT4.zw, r1
mad oT5.xy, v2, c24, c24.zwzw
mad oT5.z, -r0.x, c25, c25.w
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" }
Vector 0 [_Color]
Vector 1 [_Color_1]
Vector 2 [_Color_2]
Vector 3 [_Color_A]
Vector 4 [_Color_A1]
Vector 5 [_Color_A2]
Float 6 [_CubeMapLerp]
Float 7 [_Reflection]
Vector 8 [unity_Ambient]
SetTexture 0 [_Cube] CUBE
SetTexture 1 [_Cube_01] CUBE
SetTexture 2 [_LightBuffer] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 30 ALU, 3 TEX
PARAM c[10] = { program.local[0..8],
		{ 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TXP R2.xyz, fragment.texcoord[4], texture[2], 2D;
TEX R1.xyz, fragment.texcoord[2], texture[0], CUBE;
TEX R0.xyz, fragment.texcoord[2], texture[1], CUBE;
ADD R0.xyz, R0, -R1;
MAD R0.xyz, R0, c[6].x, R1;
MOV R4.xyz, c[0];
ADD R4.xyz, -R4, c[3];
MAD R5.xyz, fragment.texcoord[3].x, R4, c[0];
MOV R3.xyz, c[1];
ADD R3.xyz, -R3, c[4];
MAD R3.xyz, fragment.texcoord[3].x, R3, c[1];
ADD R6.xyz, R3, -R5;
MOV R3.xyz, fragment.texcoord[1];
DP3_SAT R0.w, fragment.texcoord[0], R3;
MAD R3.xyz, R0.w, R6, R5;
MOV R4.xyz, c[2];
ADD R4.xyz, -R4, c[5];
MAD R4.xyz, fragment.texcoord[3].x, R4, c[2];
MUL R0.w, R0, R0;
ADD R4.xyz, R4, -R3;
MUL R0.w, R0, R0;
MAD R1.xyz, R0.w, R4, R3;
MUL R0.xyz, R0, c[7].x;
LG2 R2.x, R2.x;
LG2 R2.z, R2.z;
LG2 R2.y, R2.y;
ADD R2.xyz, -R2, c[8];
MAD R0.xyz, R0, fragment.texcoord[2].w, R1;
MUL result.color.xyz, R0, R2;
MOV result.color.w, c[9].x;
END
# 30 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" }
Vector 0 [_Color]
Vector 1 [_Color_1]
Vector 2 [_Color_2]
Vector 3 [_Color_A]
Vector 4 [_Color_A1]
Vector 5 [_Color_A2]
Float 6 [_CubeMapLerp]
Float 7 [_Reflection]
Vector 8 [unity_Ambient]
SetTexture 0 [_Cube] CUBE
SetTexture 1 [_Cube_01] CUBE
SetTexture 2 [_LightBuffer] 2D
"ps_2_0
; 28 ALU, 3 TEX
dcl_cube s0
dcl_cube s1
dcl_2d s2
def c9, 0.00000000, 0, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2
dcl t3.x
dcl t4
texld r0, t2, s1
texldp r1, t4, s2
texld r2, t2, s0
add r3.xyz, r0, -r2
mov r4.xyz, c3
add r4.xyz, -c0, r4
mad r5.xyz, t3.x, r4, c0
mov r0.xyz, c4
add r0.xyz, -c1, r0
mad r0.xyz, t3.x, r0, c1
add r6.xyz, r0, -r5
mov r0.xyz, t1
dp3_sat r0.x, t0, r0
mad r5.xyz, r0.x, r6, r5
mov r4.xyz, c5
add r4.xyz, -c2, r4
mul r0.x, r0, r0
mad r4.xyz, t3.x, r4, c2
mad r2.xyz, r3, c6.x, r2
add r4.xyz, r4, -r5
mul r0.x, r0, r0
mad r0.xyz, r0.x, r4, r5
mul r2.xyz, r2, c7.x
log_pp r1.x, r1.x
log_pp r1.z, r1.z
log_pp r1.y, r1.y
add_pp r1.xyz, -r1, c8
mad r0.xyz, r2, t2.w, r0
mul_pp r0.xyz, r0, r1
mov_pp r0.w, c9.x
mov_pp oC0, r0
"
}
SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" }
Vector 0 [_Color]
Vector 1 [_Color_1]
Vector 2 [_Color_2]
Vector 3 [_Color_A]
Vector 4 [_Color_A1]
Vector 5 [_Color_A2]
Float 6 [_CubeMapLerp]
Float 7 [_Reflection]
SetTexture 0 [_Cube] CUBE
SetTexture 1 [_Cube_01] CUBE
SetTexture 2 [_LightBuffer] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 38 ALU, 5 TEX
PARAM c[9] = { program.local[0..7],
		{ 0, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEX R0, fragment.texcoord[5], texture[3], 2D;
TEX R1, fragment.texcoord[5], texture[4], 2D;
TXP R4.xyz, fragment.texcoord[4], texture[2], 2D;
TEX R3.xyz, fragment.texcoord[2], texture[0], CUBE;
TEX R2.xyz, fragment.texcoord[2], texture[1], CUBE;
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R0.w, R0;
MUL R1.xyz, R1, c[8].y;
MOV R6.xyz, c[0];
ADD R6.xyz, -R6, c[3];
MAD R7.xyz, fragment.texcoord[3].x, R6, c[0];
MOV R5.xyz, c[1];
ADD R5.xyz, -R5, c[4];
MAD R5.xyz, fragment.texcoord[3].x, R5, c[1];
ADD R8.xyz, R5, -R7;
MOV R5.xyz, fragment.texcoord[1];
DP3_SAT R2.w, fragment.texcoord[0], R5;
MAD R5.xyz, R2.w, R8, R7;
MOV R6.xyz, c[2];
ADD R6.xyz, -R6, c[5];
MAD R6.xyz, fragment.texcoord[3].x, R6, c[2];
MUL R2.w, R2, R2;
ADD R2.xyz, R2, -R3;
MAD R0.xyz, R0, c[8].y, -R1;
MOV_SAT R0.w, fragment.texcoord[5].z;
MAD R0.xyz, R0.w, R0, R1;
MAD R1.xyz, R2, c[6].x, R3;
ADD R6.xyz, R6, -R5;
MUL R1.w, R2, R2;
MAD R5.xyz, R1.w, R6, R5;
MUL R1.xyz, R1, c[7].x;
LG2 R2.x, R4.x;
LG2 R2.y, R4.y;
LG2 R2.z, R4.z;
ADD R0.xyz, -R2, R0;
MAD R1.xyz, R1, fragment.texcoord[2].w, R5;
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[8].x;
END
# 38 instructions, 9 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" }
Vector 0 [_Color]
Vector 1 [_Color_1]
Vector 2 [_Color_2]
Vector 3 [_Color_A]
Vector 4 [_Color_A1]
Vector 5 [_Color_A2]
Float 6 [_CubeMapLerp]
Float 7 [_Reflection]
SetTexture 0 [_Cube] CUBE
SetTexture 1 [_Cube_01] CUBE
SetTexture 2 [_LightBuffer] 2D
SetTexture 3 [unity_Lightmap] 2D
SetTexture 4 [unity_LightmapInd] 2D
"ps_2_0
; 34 ALU, 5 TEX
dcl_cube s0
dcl_cube s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c8, 8.00000000, 0.00000000, 0, 0
dcl t0.xyz
dcl t1.xyz
dcl t2
dcl t3.x
dcl t4
dcl t5.xyz
texldp r5, t4, s2
texld r2, t5, s3
texld r1, t5, s4
texld r4, t2, s1
texld r3, t2, s0
mov r6.xyz, c3
add r6.xyz, -c0, r6
mad r7.xyz, t3.x, r6, c0
mov r0.xyz, c4
add r0.xyz, -c1, r0
mad r0.xyz, t3.x, r0, c1
add r8.xyz, r0, -r7
mov r0.xyz, t1
dp3_sat r0.x, t0, r0
mad r7.xyz, r0.x, r8, r7
mov r6.xyz, c5
add r6.xyz, -c2, r6
mul r0.x, r0, r0
mad r6.xyz, t3.x, r6, c2
add r4.xyz, r4, -r3
mad r3.xyz, r4, c6.x, r3
mul_pp r1.xyz, r1.w, r1
mul_pp r4.xyz, r1, c8.x
mul_pp r1.xyz, r2.w, r2
mad_pp r2.xyz, r1, c8.x, -r4
mov_sat r1.x, t5.z
mad_pp r1.xyz, r1.x, r2, r4
log_pp r2.x, r5.x
log_pp r2.y, r5.y
log_pp r2.z, r5.z
add_pp r1.xyz, -r2, r1
add r6.xyz, r6, -r7
mul r0.x, r0, r0
mad r0.xyz, r0.x, r6, r7
mul r2.xyz, r3, c7.x
mad r0.xyz, r2, t2.w, r0
mul_pp r0.xyz, r0, r1
mov_pp r0.w, c8.y
mov_pp oC0, r0
"
}
}
 }
}
Fallback "Diffuse"
}