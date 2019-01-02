Shader "Custom/normalMap" {
	Properties {
		_Tex("Base", 2D) = "white"{}//Setting up a texture property to assign 
		_Normal("Normal Map", 2D) ="bump"{}//set up a texture property to assign a normal map	
		_Intensity("Normal Intensity", Range(0,10)) = 5 //set a range property to control the intensity of the normal map
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert
		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0
		float _Intensity;//creating a float variable for the intensity
		sampler2D _Tex;//create a 2d texture variable for the texture
		sampler2D _Normal;//create a 2d texture variable for the normal map texture 


		struct Input 
		{
		float _Intensity; // send the float variable into the input for the surface 
		float2 uv_Normal;// send the float variable of the normal map into the input 
		float2 uv_Tex;// send the float variable for the texture into the input

		};

		void surf (Input IN, inout SurfaceOutput o) 
		{
		half4 tex = tex2D(_Tex, IN.uv_Tex);// creating a half 4 and assigning it the values of the texture and its UV values
		o.Albedo = tex.rgb; // setting the outputs albedo to the textures rgb values
		o.Alpha = tex.a;// setting the alpha values of the output to the textures alpha values

		float3 normalTex = UnpackNormal(tex2D(_Normal,IN.uv_Normal)); //create a float value and assign it the values of the vormal maps texture and its UV value
		normalTex = float3(normalTex.x * _Intensity, normalTex.y* _Intensity,normalTex.z); // set the float normal map to the values of the noraml maps x,y and z values times by the intensity

		o.Normal = normalTex.rgb; //set the normal maps output value to that of the textures rgb value
			
		}
		ENDCG
	}
	FallBack "Diffuse"
}
