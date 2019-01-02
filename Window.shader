Shader "Custom/Window" {
	Properties 
	{
		_MainTex ("Albedo (RGB)", 2D) = "white" {}//Setting a texture property 	
		_Trans("Transparency", Range(0,1)) = 0.5 // setting a range property for the amount of transparency
		_Tint("Tint Colour", Color) = (1,1,1,1)// setting a colour property for the tint colour
		_CubeMap("Cube Map", CUBE) = ""{} // setting a cubemap property to assign the cubemap
		_Reflection("Reflection Amount", Range(0.1,1)) = 0.5 // setting a range property for the ammount of reflection
	
	}
	SubShader 
	{
		Tags { "Queue" = "Transparent" }
		LOD 200
		CGPROGRAM
		#pragma surface surf Lambert alpha // setting the lighting model 
		#pragma target 3.0

		sampler2D _MainTex;//creting a texture variable 
		float _Trans;//creating a float variable for the transpacency 
		float4 _Tint;//creating a float variable with 4 data members for the tint color 
		samplerCUBE _CubeMap; //creating a cube map variable
		float _Reflection;//creating a float variable for the reflection


		struct Input 
		{
			float2 uv_MainTex;//pasing the uv values of the main texture into the input structure 	
			float3 refl; //pasing the a float variable into the input structure
		};


		void surf (Input IN, inout SurfaceOutput o) 
		{
			half4 tex = tex2D(_MainTex, IN.uv_MainTex) * _Tint; //creating a variable and setting it to the values of the texture, its uv values and times by the tint amount
			o.Emission = texCUBE(_CubeMap, IN.refl).rgb * _Reflection; // setting the output emissions to the value of the cubemaps rgb valuse and multiplied by the reflection amount
			o.Albedo = tex.rgb; // setting the outputs albedo to the textures rgb values
			o.Alpha = _Trans;// setting the alpha value of the output structure to the transparency value
		}
		ENDCG
	}
	FallBack "Diffuse"
}
